package com.d1.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.HibernateException;

import com.d1.bean.Award;
import com.d1.bean.AwardUseLog;
import com.d1.bean.BirthGds;
import com.d1.bean.BuyLimit;
import com.d1.bean.BuyLimitDtl;
import com.d1.bean.Cart;
import com.d1.bean.CartItem;
import com.d1.bean.OrderBase;
import com.d1.bean.OrderCache;
import com.d1.bean.OrderItemCache;
import com.d1.bean.OrderMain;
import com.d1.bean.OrderShopCache;
import com.d1.bean.PayMethod;
import com.d1.bean.Prepay;
import com.d1.bean.Product;
import com.d1.bean.ProductGroup;
import com.d1.bean.SecKill;
import com.d1.bean.SgGdsDtl;
import com.d1.bean.Sku;
import com.d1.bean.Ticket;
import com.d1.bean.TicketCrd;
import com.d1.bean.TmallGrp;
import com.d1.bean.Tuandh;
import com.d1.bean.User;
import com.d1.bean.UserAddress;
import com.d1.bean.UsrPoint;
import com.d1.bean.id.OrderIdGenerator;
import com.d1.bean.id.SequenceIdGenerator;
import com.d1.helper.UserHelper;
import com.d1.util.Tools;



/**
 * 创建订单处理的事务，不要自己new出来调用方法，必须通过Tools.getService创建出来才行！
 * @author kk
 *
 */
public class OrderService {

	/**
	 * 下单事务处理方法。扣E券、扣预存款、修改余额、插入订单、插入订单明细。
	 * @param request
	 * @param response
	 * @param loginUser
	 * @param cartList 购物车所有记录
	 * @param raddress 收获人地址
	 * @param rprovince
	 * @param rcity
	 * @param paddress 订货人地址，即下单人，mbrcst表中mbrcst_rthird=0的记录
	 * @param pprovince
	 * @param pcity
	 * @param paymethod 支付方式
	 * @param deliver 送货时间
	 * @param gdsmoney 商品总金额
	 * @param normal_money 商品能用券的金额，即最大能减免的金额
	 * @param ticket_id E券的id
	 * @param ticket_type 使用券的类型，0表示减免(tktmst)，1表示折扣(tktcrd)，2表示品牌减免
	 * @param ticket_cut_money 券省下的钱 ，配合ticket_type使用，大于0时有效，包括品牌减免
	 * @param prepay_money 预存款省下的钱，大于0时有效
	 * @param shipfee 运费
	 * @param sumawardvalue 积分换购使用的总积分
	 * @param memo 订单留言
	 * @return OrderCache 创建的订单
	 */
	public OrderCache createOrder(HttpServletRequest request,
			HttpServletResponse response, User loginUser, 
			ArrayList<Cart> cartList,
			UserAddress raddress,String rprovince,String rcity,
			UserAddress paddress,String pprovince,String pcity,
			PayMethod paymethod, String deliver,
			float gdsmoney,float normal_money,
			String ticket_id,
			String ticket_type,float ticket_cut_money,float prepay_money,
			float shipfee,long sumawardvalue,String memo) throws Exception 
	{
		if(cartList==null||cartList.size()==0)return null ;
		
		long d1actvalue=0;
		long total_point = 0 ;//总积分
		
		Map<Long,Long> map=new HashMap<Long,Long>();  
		for(Cart cx:cartList){
			if(cx.getType().longValue()==2||cx.getType().longValue()==-5){//积分兑换商品
				total_point+=cx.getPoint().longValue();
			}
               if(cx.getActid()!=null&&cx.getActid().longValue()>0){
		        Long arrstri=cx.getActid();
		        if (map.containsKey(arrstri)){
	                map.put(arrstri,cx.getActmoney());
	            }
	            d1actvalue+=cx.getActmoney().longValue();
               }
		}
		
		gdsmoney=gdsmoney+d1actvalue;
		//先创建订单，然后创建明细
		OrderCache order = new OrderCache();
		order.setId(OrderIdGenerator.generate());//order id，通过一个sequence创建的
		order.setOdrmst_id(new Long(SequenceIdGenerator.generate("4")));
		order.setOdrmst_ip(request.getRemoteHost());
	
		HttpSession session = (HttpSession)request.getSession();
		String first_referer_url = (String)session.getAttribute("first_referer_url");
		if(Tools.isNull(first_referer_url)){
			first_referer_url = Tools.getCookie(request, "d1.com.cn.srcurl");
		}
		order.setOdrmst_srcurl(first_referer_url);//来源，cookiename=d1.com.cn.srcurl
		order.setOdrmst_temp("");//联盟参数，不同接口，从cookie中取，先创建，然后update
		
		order.setOdrmst_mbrid(new Long(loginUser.getId()));//会员id 
		order.setOdrmst_rname(raddress.getMbrcst_name());//收货人姓名 
		order.setOdrmst_orderdate(new Date());//订单日期
		
		if(raddress.getMbrcst_rsex()!=null){
			if(raddress.getMbrcst_rsex().longValue()==1){
				order.setOdrmst_rsex("女");
			}else{
				order.setOdrmst_rsex("男");
			}
		}
		String brandpidstr="";
		//System.out.println(memo);
		if(("2".equals(ticket_type)||"0".equals(ticket_type))&&memo.indexOf("@@@@")>=0){
		String[] arrmemo=memo.split("@@@@");
		 
		 brandpidstr=arrmemo[0];
		 if(arrmemo.length>1){
		 memo=arrmemo[1];
		 }else{
			 memo="";
		 }
		}
		
		
		order.setOdrmst_rzipcode(raddress.getMbrcst_rzipcode());//收货人邮编
		order.setOdrmst_raddress(raddress.getMbrcst_raddress());//收货人地址
		order.setOdrmst_rphone(raddress.getMbrcst_rphone());//收货人电话、手机
		order.setOdrmst_remail(raddress.getMbrcst_remail());//收货人email
		order.setOdrmst_rcountry("中国");//国家
		order.setOdrmst_rprovince(rprovince);//收货人省
		order.setOdrmst_rcity(rcity);//收货人城市
		
		order.setOdrmst_pzipcode(paddress.getMbrcst_rzipcode());//订购人相关信息
		order.setOdrmst_paddress(paddress.getMbrcst_raddress());//订购人相关信息
		order.setOdrmst_pcountry("中国");//订购人相关信息
		order.setOdrmst_pprovince(pprovince);//订购人相关信息
		order.setOdrmst_pcity(pcity);//订购人相关信息
		order.setOdrmst_pophone(paddress.getMbrcst_rtelephonecode()+"-"+paddress.getMbrcst_rtelephone()+"-"+paddress.getMbrcst_rtelephoneext());//订购人相关信息
		order.setOdrmst_phphone(paddress.getMbrcst_rtelephonecode()+"-"+paddress.getMbrcst_rtelephone()+"-"+paddress.getMbrcst_rtelephoneext());//订购人相关信息
		order.setOdrmst_pmphone(paddress.getMbrcst_rtelephonecode()+"-"+paddress.getMbrcst_rtelephone()+"-"+paddress.getMbrcst_rtelephoneext());//订购人相关信息 
		order.setOdrmst_pusephone(paddress.getMbrcst_rphone());//订购人相关信息 
		order.setOdrmst_pbp("");//订购人相关信息
		order.setOdrmst_pemail(paddress.getMbrcst_remail());//订购人相关信息
		order.setOdrmst_pname(paddress.getMbrcst_name());//订购人相关信息
		
		if(paddress.getMbrcst_rsex()!=null){
			if(paddress.getMbrcst_rsex().longValue()==1){
				order.setOdrmst_psex("女");
			}else{
				order.setOdrmst_psex("男");
			}
		}
		
		String shiptype = request.getParameter("shiptype");//选择的快递方式

		if("1".equals(shiptype))
		{
			memo=memo+"<br>用户选择顺丰快递邮费已付，发货请注意！！！！";
			order.setOdrmst_d1shipmethod("顺丰快递");
		}
		
		//送货时间+买家留言
		order.setOdrmst_customerword("[送货时间:"+deliver+" 务必送前联系,本人签收 须当面拆箱验货（化妆品拒收不可拆产品包装）]<br><span style=\"color:#FF0000\">"+memo+"</span>");
		order.setOdrmst_internalmemo("[送货时间:"+deliver+" 务必送前联系,本人签收 须当面拆箱验货（化妆品拒收不可拆产品包装）]<br><span style=\"color:#FF0000\">买家留言:"+memo+"</span>");
		
		order.setOdrmst_insurancefee(new Double(0));//保险费用，没用
		order.setOdrmst_netpayfee(new Double(0));//没用
		order.setOdrmst_taxfee(new Double(0));//没有用
		order.setOdrmst_giftfee(new Double(0));//没有用
		order.setOdrmst_giftid(new Long(0));//没有用
		order.setOdrmst_sndshopcode("00000000");//d1发货全填这个
		order.setOdrmst_refundplan("");//缺货退货选择方案，保留字段
		order.setOdrmst_jcflag(new Long(0));//没用
		order.setOdrmst_sumawardvalue(new Long(sumawardvalue));//积分兑换使用总积分
		
		order.setOdrmst_orderstatus(new Long(0));//默认为未处理状态
		order.setOdrmst_oldodrid(order.getId());//用于补发或拆单对帐
		
		//最后查看结果：1VIP 0不是VIP
		if(UserHelper.isVip(loginUser))order.setOdrmst_specialtype(new Long(1));
		else order.setOdrmst_specialtype(new Long(0));
		
		//========================开始算钱，很重要！！！========================
		order.setOdrmst_shipfee(new Double(shipfee));//设置运费
		
		Ticket ticket = null ;//该订单用到了哪张券
		
		
		order.setOdrmst_d1actmoney(d1actvalue);//满减活动优惠金额
		
		boolean hasSetOrderMoney = false ;//是否已经设置订单相关“钱”的字段
		
		//先看预存款和E券是否都用了，先用券，然后扣预存款！！！
		if(prepay_money>0&&ticket_cut_money>0){
	
			if("0".equals(ticket_type)){//tktmst减免券，直减券可以减运费
				ticket = (Ticket)Tools.getManager(Ticket.class).txGet(ticket_id);

				Tools.getManager(Ticket.class).txBeforeUpdate(ticket);
				ticket.setTktmst_validflag(new Long(1));//标记为已使用，直减券一次性用完
				Tools.getManager(Ticket.class).txUpdate(ticket, true);
			}else if("1".equals(ticket_type)){//tktcrd折扣券
				TicketCrd ticket123 = (TicketCrd)Tools.getManager(TicketCrd.class).txGet(ticket_id);
			
				//扣掉折扣券剩余可用额度
				ticket123.setTktcrd_realvalue(new Long(ticket123.getTktcrd_realvalue().longValue()-(long)ticket_cut_money));
				Tools.getManager(TicketCrd.class).txUpdate(ticket123, false);
							
				//创建一条Ticket记录，如果订单创建不成功，这条记录不会创建！！！
				ticket = new Ticket();
				ticket.setTktmst_cardno(ticket123.getTktcrd_cardno());
				ticket.setTktmst_downflag(new Long(1));
				ticket.setTktmst_createdate(new Date());
				ticket.setTktmst_gdsvalue(new Float(gdsmoney));
				ticket.setTktmst_ifcrd(new Long(1));//如果是1的标识不算Ticket记录，表示从减免券创建过来的
				ticket.setTktmst_mbrid(ticket123.getTktcrd_mbrid());
				ticket.setTktmst_memo("从折扣券创建");
				ticket.setTktmst_payid(new Long(paymethod.getId()));
				if (Tools.isNull(ticket123.getTktcrd_rackcode())){
				ticket.setTktmst_rackcode("000");
				}else{
					ticket.setTktmst_rackcode(ticket123.getTktcrd_rackcode());	
				}
				ticket.setTktmst_sodrid(order.getId());//订单id
				ticket.setTktmst_uodrid(order.getId());//使用订单id
				ticket.setTktmst_type(ticket123.getTktcrd_type());//减免券类型，按比例减免券
				ticket.setTktmst_validatee(new Date());
				ticket.setTktmst_validates(new Date());
				ticket.setTktmst_validflag(new Long(1));//标记为已使用！
				ticket.setTktmst_brandname(ticket123.getTktcrd_brandname());
				ticket.setTktmst_value(new Float(ticket_cut_money));
					
				Tools.getManager(Ticket.class).txCreate(ticket);//创建记录
			}else if("2".equals(ticket_type)){//品牌减免，这里是虚拟券，减免后创建一个tktmst记录
				ticket = new Ticket();
				ticket.setTktmst_createdate(new Date());
				ticket.setTktmst_downflag(new Long(1));
				ticket.setTktmst_gdsvalue(new Float(gdsmoney));
				ticket.setTktmst_ifcrd(new Long(0));//不是减免券挂出来的
				ticket.setTktmst_mbrid(new Long(loginUser.getId()));//会员id
				ticket.setTktmst_memo("品牌减免创建");
				ticket.setTktmst_payid(new Long(paymethod.getId()));//pay id
				ticket.setTktmst_rackcode("000");
				ticket.setTktmst_cardno("pbrand"+loginUser.getId());
				ticket.setTktmst_validatee(new Date());
				ticket.setTktmst_validates(new Date());
				ticket.setTktmst_sodrid(order.getId());//订单id
				ticket.setTktmst_type("015004");//品牌减免券
				ticket.setTktmst_value(new Float(ticket_cut_money));
				ticket.setTktmst_validflag(new Long(1));//标记为已使用
				ticket.setTktmst_uodrid(order.getId());
				Tools.getManager(Ticket.class).txCreate(ticket);//创建
			}
			else if("3".equals(ticket_type)){//200-100活动，这里是虚拟券，减免后创建一个tktmst记录				
				ticket = new Ticket();
				ticket.setTktmst_createdate(new Date());
				ticket.setTktmst_downflag(new Long(1));
				ticket.setTktmst_gdsvalue(new Float(gdsmoney));
				ticket.setTktmst_ifcrd(new Long(0));//不是减免券挂出来的
				ticket.setTktmst_mbrid(new Long(loginUser.getId()));//会员id
				ticket.setTktmst_memo("200-100活动");
				ticket.setTktmst_cardno("pcuxiao200j100"+loginUser.getId());
				ticket.setTktmst_payid(new Long(paymethod.getId()));//pay id
				ticket.setTktmst_rackcode("000");
				ticket.setTktmst_validatee(new Date());
				ticket.setTktmst_validates(new Date());
				ticket.setTktmst_sodrid(order.getId());//订单id
				ticket.setTktmst_type("015004");
				ticket.setTktmst_value(new Float(ticket_cut_money));
				ticket.setTktmst_validflag(new Long(1));//标记为已使用
				ticket.setTktmst_uodrid(order.getId());
				Tools.getManager(Ticket.class).txCreate(ticket);//创建
			}

			//扣预存款，创建一条预存款使用记录
			Prepay prepay = new Prepay();
			prepay.setPrepay_createdate(new Date());
			prepay.setPrepay_mbrid(new Long(loginUser.getId()));
			prepay.setPrepay_log("下单扣预存款<br/>");
			prepay.setPrepay_memo("下单");
			prepay.setPrepay_odrid(order.getId());
			prepay.setPrepay_status(new Long(0));//统计的时候把status=0的预存款加起来
			prepay.setPrepay_type(new Long(2));//购物消费
			prepay.setPrepay_value(-prepay_money);//一定是负数，表示扣款
			prepay.setPropay_operator(loginUser.getMbrmst_name());//用户名
			Tools.getManager(Prepay.class).txCreate(prepay);
			
			float real_save_money = ticket_cut_money+prepay_money+d1actvalue ;//最终真正节省的钱
			
			//设置订单关于钱的字段值
			if(paymethod.getId().equals("0") || paymethod.getId().equals("44")){//货到付款，精确到0.5元
				order.setOdrmst_acturepaymoney(Tools.getDouble5(new Float(gdsmoney+shipfee-real_save_money)));
			}else{
				order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(gdsmoney+shipfee-real_save_money),2));	
			}
			order.setOdrmst_gdsmoney(Tools.getDouble(new Float(gdsmoney),2));
			order.setOdrmst_ordermoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
			order.setOdrmst_getmoney(Tools.getDouble(new Float(real_save_money),2));
			order.setOdrmst_prepayvalue(Tools.getDouble(new Float(prepay_money),2));
			
			order.setOdrmst_tktvalue(Tools.getDouble(new Float(ticket_cut_money+d1actvalue),2));//E券金额
			order.setOdrmst_tktid(new Long(ticket.getId()));//E券编号，对应tktmst.id
			
			order.setOdrmst_cardmemo(ticket.getTktmst_cardno());//放入券号
			
			hasSetOrderMoney = true ;
			
		}else if(ticket_cut_money>0){//然后看是否使用了E券
			if("0".equals(ticket_type)){//tktmst减免券，可以减运费
				ticket = (Ticket)Tools.getManager(Ticket.class).txGet(ticket_id);
				Tools.getManager(Ticket.class).txBeforeUpdate(ticket);
				ticket.setTktmst_validflag(new Long(1));//标记为已使用
				Tools.getManager(Ticket.class).txUpdate(ticket, true);
				
				//设置订单钱相关的字段
				if(paymethod.getId().equals("0")|| paymethod.getId().equals("44")){//货到付款，精确到0.5元
					order.setOdrmst_acturepaymoney(Tools.getDouble5(new Float(gdsmoney+shipfee-ticket_cut_money-d1actvalue)));
				}else{
					order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(gdsmoney+shipfee-ticket_cut_money-d1actvalue),2));
				}
				order.setOdrmst_gdsmoney(Tools.getDouble(new Float(gdsmoney),2));
				order.setOdrmst_ordermoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
				order.setOdrmst_getmoney(Tools.getDouble(new Float(ticket_cut_money+d1actvalue),2));
				order.setOdrmst_prepayvalue(Tools.getDouble(new Float(0),2));
				
				order.setOdrmst_tktvalue(Tools.getDouble(new Float(ticket_cut_money+d1actvalue),2));//E券金额
				order.setOdrmst_tktid(new Long(ticket.getId()));//E券编号，对应tktmst.id
				order.setOdrmst_cardmemo(ticket.getTktmst_cardno());//放入券号
				
				hasSetOrderMoney = true ;
				
			}else if("1".equals(ticket_type)){//tktcrd折扣券
				TicketCrd ticket123 = (TicketCrd)Tools.getManager(TicketCrd.class).txGet(ticket_id);
				//扣掉折扣券剩余额度
				ticket123.setTktcrd_realvalue(new Long(ticket123.getTktcrd_realvalue().longValue()-(long)ticket_cut_money));
				Tools.getManager(TicketCrd.class).txUpdate(ticket123, false);
				
				//创建一条Ticket记录，如果订单创建不成功，这条记录不会创建！！！
				ticket = new Ticket();
				ticket.setTktmst_cardno(ticket123.getTktcrd_cardno());
				ticket.setTktmst_createdate(new Date());
				ticket.setTktmst_gdsvalue(new Float(gdsmoney));
				ticket.setTktmst_ifcrd(new Long(1));//如果是1的标识不算Ticket记录，只能用来退，下次不能再用
				ticket.setTktmst_mbrid(ticket123.getTktcrd_mbrid());
				ticket.setTktmst_memo("从折扣券创建");
				ticket.setTktmst_payid(new Long(paymethod.getId()));

				if (Tools.isNull(ticket123.getTktcrd_rackcode())){
					ticket.setTktmst_rackcode("000");
					}else{
					ticket.setTktmst_rackcode(ticket123.getTktcrd_rackcode());	
					}
				ticket.setTktmst_sodrid(order.getId());//订单id
				ticket.setTktmst_uodrid(order.getId());//订单id
				ticket.setTktmst_type(ticket123.getTktcrd_type());
				ticket.setTktmst_validatee(new Date());
				ticket.setTktmst_validates(new Date());
				ticket.setTktmst_validflag(new Long(1));//标记为使用过
				ticket.setTktmst_value(new Float(ticket_cut_money));
					
				Tools.getManager(Ticket.class).txCreate(ticket);//创建记录
					
				//设置订单钱相关的字段
				if(paymethod.getId().equals("0")|| paymethod.getId().equals("44")){//货到付款，精确到0.5元
					order.setOdrmst_acturepaymoney(Tools.getDouble5(new Float(gdsmoney+shipfee-ticket_cut_money-d1actvalue)));
				}else{
					order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(gdsmoney+shipfee-ticket_cut_money-d1actvalue),2));
				}
				order.setOdrmst_gdsmoney(Tools.getDouble(new Float(gdsmoney),2));
				order.setOdrmst_ordermoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
				order.setOdrmst_getmoney(Tools.getDouble(new Float(ticket_cut_money+d1actvalue),2));
				order.setOdrmst_prepayvalue(Tools.getDouble(new Float(0),2));
				
				order.setOdrmst_tktvalue(Tools.getDouble(new Float(ticket_cut_money+d1actvalue),2));//E券金额
				order.setOdrmst_tktid(new Long(ticket.getId()));//E券编号，对应tktmst.id
				order.setOdrmst_cardmemo(ticket.getTktmst_cardno());//放入券号
					
				hasSetOrderMoney = true ;

			}else if("2".equals(ticket_type)){//品牌减免
				ticket = new Ticket();
				ticket.setTktmst_createdate(new Date());
				ticket.setTktmst_downflag(new Long(1));
				ticket.setTktmst_gdsvalue(new Float(gdsmoney));
				ticket.setTktmst_ifcrd(new Long(0));//不是减免券挂出来的
				ticket.setTktmst_mbrid(new Long(loginUser.getId()));//会员id
				ticket.setTktmst_memo("品牌减免创建");
				ticket.setTktmst_payid(new Long(paymethod.getId()));//pay id
				ticket.setTktmst_uodrid(order.getId());//订单id
				ticket.setTktmst_rackcode("000");
				ticket.setTktmst_validatee(new Date());
				ticket.setTktmst_validates(new Date());
				ticket.setTktmst_sodrid(order.getId());//订单id
				ticket.setTktmst_type("015004");//品牌减免券
				ticket.setTktmst_value(new Float(ticket_cut_money));
				ticket.setTktmst_validflag(new Long(1));//标记为已使用
				ticket.setTktmst_uodrid(order.getId());
				
				
				Tools.getManager(Ticket.class).txCreate(ticket);//创建
					
				//设置订单钱相关的字段
				if(paymethod.getId().equals("0")|| paymethod.getId().equals("44")){//货到付款，精确到0.5元
					order.setOdrmst_acturepaymoney(Tools.getDouble5(new Float(gdsmoney+shipfee-ticket_cut_money-d1actvalue)));
				}else{
					order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(gdsmoney+shipfee-ticket_cut_money-d1actvalue),2));
				}
				order.setOdrmst_gdsmoney(Tools.getDouble(new Float(gdsmoney),2));
				order.setOdrmst_ordermoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
				order.setOdrmst_getmoney(Tools.getDouble(new Float(ticket_cut_money+d1actvalue),2));
				order.setOdrmst_prepayvalue(Tools.getDouble(new Float(0),2));
				
				order.setOdrmst_tktvalue(Tools.getDouble(new Float(ticket_cut_money+d1actvalue),2));//E券金额
				order.setOdrmst_tktid(new Long(ticket.getId()));//E券编号，对应tktmst.id
				
				hasSetOrderMoney = true ;
			}
			else if("3".equals(ticket_type)){//200-100活动，这里是虚拟券，减免后创建一个tktmst记录				
				/*ticket = new Ticket();
				ticket.setTktmst_createdate(new Date());
				ticket.setTktmst_downflag(new Long(1));
				ticket.setTktmst_gdsvalue(new Float(gdsmoney));
				ticket.setTktmst_ifcrd(new Long(0));//不是减免券挂出来的
				ticket.setTktmst_mbrid(new Long(loginUser.getId()));//会员id
				ticket.setTktmst_memo("200-100活动");
				ticket.setTktmst_payid(new Long(paymethod.getId()));//pay id
				ticket.setTktmst_rackcode("000");
				ticket.setTktmst_validatee(new Date());
				ticket.setTktmst_validates(new Date());
				ticket.setTktmst_sodrid(order.getId());//订单id
				ticket.setTktmst_type("015004");
				ticket.setTktmst_value(new Float(ticket_cut_money));
				ticket.setTktmst_validflag(new Long(1));//标记为已使用
				ticket.setTktmst_uodrid(order.getId());
				Tools.getManager(Ticket.class).txCreate(ticket);//创建
				
				//设置订单钱相关的字段
				if(paymethod.getId().equals("0")|| paymethod.getId().equals("44")){//货到付款，精确到0.5元
					order.setOdrmst_acturepaymoney(Tools.getDouble5(new Float(gdsmoney+shipfee-ticket_cut_money)));
				}else{
					order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(gdsmoney+shipfee-ticket_cut_money),2));
				}
				order.setOdrmst_gdsmoney(Tools.getDouble(new Float(gdsmoney),2));
				order.setOdrmst_ordermoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
				order.setOdrmst_getmoney(Tools.getDouble(new Float(ticket_cut_money),2));
				order.setOdrmst_prepayvalue(Tools.getDouble(new Float(0),2));
				
				order.setOdrmst_tktvalue(Tools.getDouble(new Float(ticket_cut_money),2));//E券金额
				order.setOdrmst_tktid(new Long(ticket.getId()));//E券编号，对应tktmst.id
				
				hasSetOrderMoney = true ;*/
			}
		}
		else if(prepay_money>0){//只使用了预存款
			//扣预存款，创建一条预存款使用记录
			Prepay prepay = new Prepay();
			prepay.setPrepay_createdate(new Date());
			prepay.setPrepay_log("下单扣预存款<br/>");
			prepay.setPrepay_memo("下单");
			prepay.setPrepay_mbrid(new Long(loginUser.getId()));
			prepay.setPrepay_odrid(order.getId());
			prepay.setPrepay_status(new Long(0));//统计的时候把status=0的预存款加起来
			prepay.setPrepay_type(new Long(2));//购物消费
			prepay.setPrepay_value(-prepay_money);//一定是负数，表示扣款
			prepay.setPropay_operator(loginUser.getMbrmst_name());//用户名
			Tools.getManager(Prepay.class).txCreate(prepay);
			
			/*//全场折扣活动
			float zhemoney=0f;

			if(normal_money>=200&& normal_money<500){
				zhemoney=Tools.getFloat(normal_money*0.1f,1);
			}else if(normal_money>=500){
				zhemoney=Tools.getFloat(normal_money*0.2f,1);
			}
*/
			
			//设置订单钱相关的字段
			if(paymethod.getId().equals("0")|| paymethod.getId().equals("44")){//货到付款，精确到0.5元
				order.setOdrmst_acturepaymoney(Tools.getDouble5(new Float(gdsmoney+shipfee-prepay_money-d1actvalue)));
			}else{
				order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(gdsmoney+shipfee-prepay_money-d1actvalue),2));
			}
			order.setOdrmst_gdsmoney(Tools.getDouble(new Float(gdsmoney),2));
			order.setOdrmst_ordermoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
			order.setOdrmst_getmoney(Tools.getDouble(new Float(prepay_money+d1actvalue),2));
			order.setOdrmst_prepayvalue(Tools.getDouble(new Float(prepay_money),2));
			
			order.setOdrmst_tktvalue(Tools.getDouble(new Float(d1actvalue),2));//E券金额
			order.setOdrmst_tktid(new Long(0));//E券编号，对应tktmst.id
			
			hasSetOrderMoney = true ;
		}
		
		//如果没有预存款也没有优惠券，那么设置要订单各种价格
		if(!hasSetOrderMoney){
			//全场折扣活动
			/*float zhemoney2=0f;

			if(normal_money>=200&& normal_money<500){
				zhemoney2=Tools.getFloat(normal_money*0.1f,1);
			}else if(normal_money>=500){
				zhemoney2=Tools.getFloat(normal_money*0.2f,1);
			}*/
			if(paymethod.getId().equals("0")|| paymethod.getId().equals("44")){//货到付款，精确到0.5元
				order.setOdrmst_acturepaymoney(Tools.getDouble5(new Float(gdsmoney+shipfee-d1actvalue)));
			}else{
				order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(gdsmoney+shipfee-d1actvalue),2));
			}
			order.setOdrmst_gdsmoney(Tools.getDouble(new Float(gdsmoney),2));
			order.setOdrmst_ordermoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
			order.setOdrmst_getmoney(Tools.getDouble(new Float(d1actvalue),2));
			order.setOdrmst_prepayvalue(Tools.getDouble(new Float(0),2));
			
			order.setOdrmst_tktvalue(Tools.getDouble(new Float(d1actvalue),2));//E券金额
			order.setOdrmst_tktid(new Long(0));//E券编号，对应tktmst.id，没用券设置成0
			
			hasSetOrderMoney = true ;
		}

		//========================结束算钱！！！========================
		order.setOdrmst_centerfee(new Double(0));//没有用
		order.setOdrmst_rthird(new Long(0));//是否第三方收货 无用
		
		order.setOdrmst_paytype(new Long(paymethod.getPaymst_type().intValue()));//支付方式类型（对应paymst_type）
		order.setOdrmst_payid(new Long(paymethod.getId()));//支付方式编号（对应paymst_payid）
		order.setOdrmst_actpay(paymethod.getPaymst_actpay());
		
		order.setOdrmst_paymethod(paymethod.getPaymst_name());//支付方式如“货到付款” “支付宝”
		
		if("0".equals(paymethod.getId())){//快递上门
			order.setOdrmst_shipmethod("快递上门(货到付款)");//发货方式  如“快递上门”和“快递上门（货到付款）”，支付成功后修改
			order.setOdrmst_shipid(new Long(11));//发货方式编号 发货方式编号（对应sndmst_shipid）
		}else{
			order.setOdrmst_shipid(new Long(10));//快递上门
			order.setOdrmst_shipmethod("快递上门");
		}
		
		System.out.println("创建订单：odrid="+order.getId()+" acturepaymoney="+order.getOdrmst_acturepaymoney()+" gdsmoney="+order.getOdrmst_gdsmoney()+" getmoney="+order.getOdrmst_getmoney()+" ordermoney="+order.getOdrmst_ordermoney());
		Tools.getManager(OrderCache.class).txCreate(order);//创建订单！！！！！！！
		
		
		//创建商户对应表记录，这条记录没有用了，但是后台有关联查询，所以需要创建！！！
		OrderShopCache orderShopCache = new OrderShopCache();
		orderShopCache.setOdrshp_odrid(order.getId());
		orderShopCache.setOdrshp_shopcode("08102301");
		orderShopCache.setOdrshp_sndshopcode("00000000");//d1发货全填这个
		orderShopCache.setOdrshp_orderdate(new Date());
		orderShopCache.setOdrshp_shopname("D1便利网自行发货");
		orderShopCache.setOdrshp_country("中国");
		orderShopCache.setOdrshp_province(rprovince);
		orderShopCache.setOdrshp_city(rcity);
		orderShopCache.setOdrshp_gdsmoney(Tools.getFloat(new Float(gdsmoney),2));
		orderShopCache.setOdrshp_shipfee(Tools.getFloat(new Float(shipfee),2));
		orderShopCache.setOdrshp_centerfee(Tools.getFloat(new Float(0),2));
		orderShopCache.setOdrshp_ordermoney(Tools.getFloat(new Float(gdsmoney+shipfee-d1actvalue),2));
		orderShopCache.setOdrshp_payshopmoney(new Float(0));
		orderShopCache.setOdrshp_incomevalue(Tools.getFloat(new Float(gdsmoney+shipfee-d1actvalue),2));
		orderShopCache.setOdrshp_realincome(Tools.getFloat(new Float(gdsmoney+shipfee-d1actvalue),2));
		orderShopCache.setOdrshp_giftid(new Long(0));
		orderShopCache.setOdrshp_giftfee(new Float(0));
		orderShopCache.setOdrshp_downflag(new Long(1));
		
		Tools.getManager(OrderShopCache.class).txCreate(orderShopCache);
		
		
		long total_point_for_cut = total_point ;
		
		if(total_point>0){//如果有积分兑换商品，减用户的积分
			/*
			UsrPoint us = new UsrPoint();
			us.setUsrpoint_createdate(new Date());
			us.setUsrpoint_odrid(order.getId());
			us.setUsrpoint_mbrid(order.getOdrmst_mbrid());
			us.setUsrpoint_usescore(new Long(0));
			us.setUsrpoint_score(new Long(total_point_for_cut));
			Tools.getManager(UsrPoint.class).txCreate(us);
			*/
			/*
			List<SimpleExpression> clist123 = new ArrayList<SimpleExpression>();
			clist123.add(Restrictions.eq("usrscore_mbrid", new Long(loginUser.getId())));
			clist123.add(Restrictions.gt("usrscore_realscr", new Float(0)));
			
			List<Order> olist123 = new ArrayList<Order>();
			olist123.add(Order.asc("usrscore_createdate"));
			
			List<BaseEntity> listus123 = Tools.getManager(UserScore.class).txGetList(clist123, null, 0, 1000);//用户所有积分记录
			if(listus123!=null&&listus123.size()>0){
				for(int i=0;i<listus123.size();i++){
					UserScore us = (UserScore)listus123.get(i);
					if(total_point_for_cut>0){
						if(us.getUsrscore_realscr()!=null){
							if(us.getUsrscore_realscr().longValue()>=total_point_for_cut){
								us.setUsrscore_realscr(Tools.getFloat(new Float(us.getUsrscore_realscr().longValue()-total_point_for_cut),2));
								Tools.getManager(UserScore.class).txUpdate(us, false);
								total_point_for_cut = 0;//扣完了
							}else{
								total_point_for_cut = total_point_for_cut-us.getUsrscore_realscr().longValue();
								us.setUsrscore_realscr(new Float(0));
								Tools.getManager(UserScore.class).txUpdate(us, false);
							}
						}
					}
				}
				
				if(total_point_for_cut>0){
					throw new Exception(this.getClass().getName()+"积分不够支付！");
				}
			}else{
				throw new Exception(this.getClass().getName()+"积分不够！");
			}
			*/
		}
		
		//开始创建订单明细............
		for(int i=0;i<cartList.size();i++){
			Cart cart = cartList.get(i);
			TmallGrp tmgrp=(TmallGrp)Tools.getManager(TmallGrp.class).txGet(cart.getProductId());
			if(tmgrp!=null){
				String tktshop="";
				if(ticket!=null)tktshop=ticket.getTktmst_shopcodes();
				createItem(tmgrp,cart,order.getId(),loginUser.getId(),brandpidstr,ticket_type,tktshop);
				continue;
			}
			
			if(cart.getType().longValue()==14){//限制一个用户只能购买一次
				BuyLimit blm = (BuyLimit)Tools.getManager(BuyLimit.class).txFindByProperty("gdsbuyonemst_gdsid", cart.getProductId());
				if(blm!=null&&blm.getGdsbuyonemst_starttime()!=null&&blm.getGdsbuyonemst_endtime()!=null){
					if(blm.getGdsbuyonemst_starttime().getTime()<=System.currentTimeMillis()&&
							blm.getGdsbuyonemst_endtime().getTime()>=System.currentTimeMillis()){
						BuyLimitDtl bld = new BuyLimitDtl();
						bld.setGdsbuyonedtl_createtime(new Date());
						bld.setGdsbuyonedtl_gdsid(cart.getProductId());
						bld.setGdsbuyonedtl_mbrid(new Long(loginUser.getId()));
						bld.setGdsbuyonedtl_mstid(new Long(blm.getId()));
						bld.setGdsbuyonedtl_odrid(order.getId());
						Tools.getManager(BuyLimitDtl.class).txCreate(bld);
					}
				}
			}
			
			if(cart.getType().longValue()>=0&&cart.getAmount().longValue()>0){//正式商品
				//这里需要读一下商品表，注意是txGet方法
				Product p = (Product)Tools.getManager(Product.class).txGet(cart.getProductId());
				
				Sku sku = null ;
				
				if(!Tools.isNull(cart.getSkuId())){
					sku = (Sku)Tools.getManager(Sku.class).txGet(cart.getSkuId());
				}
				
				//创建另外一条记录，用于占用虚拟库存
				CartItem ci = new CartItem();
				ci.setAmount(cart.getAmount());
				ci.setCreateDate(new Date());
				ci.setOrderId(order.getId());
				ci.setProductId(p.getId());
				ci.setSkuId(cart.getSkuId());
				ci.setUserId(loginUser.getId());
				Tools.getManager(CartItem.class).txCreate(ci);
				
				OrderItemCache orderItem = new OrderItemCache();
				orderItem.setId(SequenceIdGenerator.generate("5"));//注意5是seqid
				
                orderItem.setOdrdtl_shopcode(p.getGdsmst_shopcode());
                orderItem.setOdrdtl_oldodrid(order.getId());
				orderItem.setOdrdtl_purprice(Tools.getDouble(p.getGdsmst_inprice(),2));
				orderItem.setOdrdtl_addshipfee(Tools.getDouble(new Float(p.getGdsmst_addshipfee()),2));//额外运费  特别重的商品，商品表取
				orderItem.setOdrdtl_aspmemo("");//采购记录
				if(cart.getActid()!=null&&cart.getActid().longValue()>0){
				orderItem.setOdrdtl_actid(cart.getActid());
				orderItem.setOdrdtl_actmemo(cart.getActmemo());
				orderItem.setOdrdtl_actmoney(cart.getActmoney());
				}
				
				orderItem.setOdrdtl_odrid(order.getId());//订单号
				orderItem.setOdrdtl_gdsid(cart.getProductId());//product id
				if(sku!=null)orderItem.setOdrdtl_sku1(sku.getSkumst_sku1());//sku id
				orderItem.setOdrdtl_sku2("");//sku2 id 没用 
				
				
				if("0".equals(ticket_type)){
                    if(brandpidstr.length()>0){
					if(brandpidstr.indexOf(cart.getProductId())==-1){
						orderItem.setOdrdtl_examineflag(new Long(1));
					}
                    }else{
                    	String tktshopcode=ticket.getTktmst_shopcodes();
                    	if(Tools.isNull(tktshopcode))tktshopcode="00000000";
                    	if(!tktshopcode.equals(cart.getShopcode())&&!tktshopcode.equals("11111111")){
                    		orderItem.setOdrdtl_examineflag(new Long(1));
                    	}
                    	
                    }
				}else if("1".equals(ticket_type)){
					if(!"00000000".equals(cart.getShopcode())){
						orderItem.setOdrdtl_examineflag(new Long(1));
					}
					
				}else if("2".equals(ticket_type)){
					if(brandpidstr.indexOf(cart.getShopcode())==-1){
						orderItem.setOdrdtl_examineflag(new Long(1));
					}
				}
				
				orderItem.setOdrdtl_referer(cart.getRefererurl());
				orderItem.setOdrdtl_gdsname(cart.getTitle());//商品名
				orderItem.setOdrdtl_memberprice(new Double(p.getGdsmst_memberprice()));//会员价
				orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//市场价
				orderItem.setOdrdtl_vipprice(new Double(p.getGdsmst_vipprice()));//vip 价
				
				if(cart.getType().longValue()==0||cart.getType().longValue()==12){//如果是赠品
					orderItem.setOdrdtl_gifttype(cart.getGiftType());
					orderItem.setOdrdtl_rackcode(cart.getGiftRackcode());
					orderItem.setOdrdtl_buyflag(new Long(2));//赠品为2
				}else{
					orderItem.setOdrdtl_gifttype("");
					orderItem.setOdrdtl_rackcode(p.getGdsmst_rackcode());
					orderItem.setOdrdtl_buyflag(new Long(0));//1为抢购商品
				}
				orderItem.setOdrdtl_downflag(cart.getType());
				Double finalprice = Tools.getDouble(new Float(cart.getMoney().floatValue()/cart.getAmount().longValue()),2);//成交单价
				
				orderItem.setOdrdtl_finalprice(Tools.getDouble(finalprice,2));//最后成交单价
				orderItem.setOdrdtl_gdscount(cart.getAmount());//订购数量
				orderItem.setOdrdtl_totalmoney(Tools.getDouble(cart.getMoney(),2));//成交总金额
				
				orderItem.setOdrdtl_shipstatus(new Long(1));//发货状态，1为未发货
				orderItem.setOdrdtl_sendcount(cart.getAmount());//发货数量，最开始0
				orderItem.setOdrdtl_creatdate(new Date());//创建日期
				
				orderItem.setOdrdtl_promotionword("");//促销语
				orderItem.setOdrdtl_refundcount(new Long(0));//没发货的数量
				orderItem.setOdrdtl_weight(new Long(0));//商品重量  无用
				
				
				
				orderItem.setOdrdtl_stddetail1(p.getGdsmst_stdvalue1());//从商品表取
				orderItem.setOdrdtl_stddetail2(p.getGdsmst_stdvalue2());
				orderItem.setOdrdtl_stddetail3(p.getGdsmst_stdvalue3());
				orderItem.setOdrdtl_stddetail4(p.getGdsmst_stdvalue4());
				orderItem.setOdrdtl_stddetail5(p.getGdsmst_stdvalue5());
				orderItem.setOdrdtl_stddetail6(p.getGdsmst_stdvalue6());
				orderItem.setOdrdtl_stddetail7(p.getGdsmst_stdvalue7());
				orderItem.setOdrdtl_stddetail8(p.getGdsmst_stdvalue8());
				orderItem.setOdrdtl_stddetail9("");//商品没有stddetail9字段
				
				orderItem.setOdrdtl_presellflag(new Long(0));//保留字段，无用
				orderItem.setOdrdtl_incometype(new Long(0));//保留字段，无用
				orderItem.setOdrdtl_incomevalue(new Double(0));//保留字段
				
				orderItem.setOdrdtl_totalincomevalue(Tools.getDouble(finalprice*cart.getAmount(),2));//计算商户总收入 不用
				orderItem.setOdrdtl_eyuan(new Double(0));//商品应发E券 商品表取，价格不能打折送券的商品
				
				orderItem.setOdrdtl_spendcount(Tools.getDouble(new Float((int)cart.getMoney().intValue()),2));//返用户积分
				
				orderItem.setOdrdtl_managememo("");//产品经理留言
				orderItem.setOdrdtl_gdspurmemo("");//采购备注 
				
				orderItem.setOdrdtl_specialflag(p.getGdsmst_specialflag());//0是什么都参与，1表示商品不能用券，2表示不参与联盟返利
				//orderItem.setOdrdtl_gifttype("");//赠品类型
				
				orderItem.setOdrdtl_refcount(p.getGdsmst_refcount());//是否参加返Ｅ券活动，不参加为0，参与为1（目前没有用）
				orderItem.setOdrdtl_jcflag(new Long(0));//没有用
				
				orderItem.setOdrdtl_temp(order.getOdrmst_temp());//商品活动标记，记录订单来源，很重要！如“团购商品”“团购兑换”
				
				//修改兑换码状态
				if(cart.getType().longValue()==13){//兑换码
					Tuandh tuan = (Tuandh)Tools.getManager(Tuandh.class).txFindByProperty("tuandh_cardno", cart.getTuanCode());
					
					if(tuan.getTuandh_status().intValue()==2){
						throw new Exception("兑换码"+tuan.getTuandh_cardno()+"已被使用！");
					}else{
						orderItem.setOdrdtl_tuancardno(cart.getTuanCode());//商户兑换券号
						tuan.setTuandh_status(new Long(2));
						tuan.setTuandh_odrid(order.getId());
						tuan.setTuandh_dhtime(new Date());
						Tools.getManager(Tuandh.class).txUpdate(tuan, false);
					}
				}
				if(cart.getType().longValue()==20){//兑换码
					SgGdsDtl sg = (SgGdsDtl)Tools.getManager(SgGdsDtl.class).txFindByProperty("sggdsdtl_gdsid", cart.getProductId());
					
					if(sg!=null&&sg.getSggdsdtl_status().intValue()==1){
						sg.setSggdsdtl_realnum(new Long(sg.getSggdsdtl_realnum().longValue()+cart.getAmount()));
						Tools.getManager(SgGdsDtl.class).txUpdate(sg, false);
					}
				}
				//修改兑换码状态
				if(cart.getType().longValue()==19){//生日礼物状态修改
					BirthGds birthgds = (BirthGds)Tools.getManager(BirthGds.class).txFindByProperty("birthgds_mbrid", new Long(loginUser.getId()));
					if(birthgds==null||birthgds.getBirthgds_status().longValue()==2){
						throw new Exception("生日礼物已经领取过不能重复领取！");
					}else{
					birthgds.setBirthgds_status(new Long(2));
					birthgds.setBirthgds_odrid(order.getId());
					birthgds.setBirthgds_update(new Date());
					Tools.getManager(BirthGds.class).txUpdate(birthgds, false);
					}
		
				}
				
				
				//修改秒杀商品已秒杀数量，这里的tuanCode是addCart放进去的
				if("SecKill".equals(cart.getTuanCode())){
					SecKill sk_34434 = (SecKill)Tools.getManager(SecKill.class).txFindByProperty("mstjgds_gdsid", cart.getProductId());
					if(sk_34434!=null&&sk_34434.getMstjgds_state()!=null&&sk_34434.getMstjgds_state().longValue()==1){
						if(sk_34434.getMstjgds_count()==null){
							sk_34434.setMstjgds_count(cart.getAmount());
						}else{
							sk_34434.setMstjgds_count(new Long(cart.getAmount().longValue()+sk_34434.getMstjgds_count().longValue()));
						}
						Tools.getManager(SecKill.class).txUpdate(sk_34434, false);
					}
				}
				
				//团购商品增加团购的数量
				if(cart.getType().longValue()==6){
					ProductGroup pg3k = (ProductGroup)Tools.getManager(ProductGroup.class).txGet(cart.getAwardId());//注意，awardId放入的是product group 的id
					if(pg3k!=null){
						long tcount = (pg3k.getTgrpmst_relcount()==null?0:pg3k.getTgrpmst_relcount().longValue());
						tcount=tcount+cart.getAmount().longValue();
						pg3k.setTgrpmst_relcount(new Long(tcount));
						Tools.getManager(ProductGroup.class).txUpdate(pg3k, false);
					}
				}
				
				//创建订单明细
				Tools.getManager(OrderItemCache.class).txCreate(orderItem);
				
				if(cart.getType().longValue()==2){//如果是积分兑换商品，扣除积分并加入一条兑换记录，方便退还积分
					Award award = (Award)Tools.getManager(Award.class).txFindByProperty("award_gdsid", cart.getProductId());
					
					AwardUseLog awl = new AwardUseLog();
					awl.setScrchgawd_applytime(new Date());
					awl.setScrchgawd_awardid(new Long(award.getId()));
					awl.setScrchgawd_mbrid(new Long(loginUser.getId()));
					awl.setScrchgawd_mbrmst_haddr(raddress.getMbrcst_raddress());
					awl.setScrchgawd_mbrmst_name(raddress.getMbrcst_name());
					awl.setScrchgawd_mbrmst_postcode(raddress.getMbrcst_rzipcode());
					awl.setScrchgawd_mbrmst_usephone(raddress.getMbrcst_rphone());
					awl.setScrchgawd_name(loginUser.getMbrmst_name());
					awl.setScrchgawd_status(new Long(1));//状态一定要是1
					awl.setScrchgawd_uid(loginUser.getMbrmst_uid());
					awl.setScrchgawd_updtime(new Date());
					Tools.getManager(AwardUseLog.class).txCreate(awl);
					
					UsrPoint usrpoint = new UsrPoint();
					usrpoint.setUsrpoint_odrid(order.getId());
					usrpoint.setUsrpoint_gdsid(cart.getProductId());
					usrpoint.setUsrpoint_mbrid(Long.parseLong(loginUser.getId()));
					usrpoint.setUsrpoint_score(-cart.getPoint());
					usrpoint.setUsrpoint_shopcode(cart.getShopcode());
					usrpoint.setUsrpoint_type(new Long(-1));
					usrpoint.setUsrpoint_usescore(new Long(0));
					usrpoint.setUsrpoint_createdate(new Date());
					
					Tools.getManager(UsrPoint.class).txCreate(usrpoint);
				}
			}else{//虚拟券、套餐名什么的单独处理
				if(cart.getType().longValue()==-5){//兑换券，创建cart.getAmount张
					for(int xy123=0;xy123<cart.getAmount().intValue();xy123++){
						String awardId = cart.getProductId();
						Ticket t789 = new Ticket();
						t789.setTktmst_createdate(new Date());
						t789.setTktmst_downflag(new Long(1));
						//t789.setTktmst_gdsvalue(new Float(gdsmoney));
						t789.setTktmst_ifcrd(new Long(0));//不是减免券挂出来的
						t789.setTktmst_mbrid(new Long(loginUser.getId()));//会员id
						t789.setTktmst_memo("积分兑换创建");
						t789.setTktmst_payid(new Long(-1));//pay id
						t789.setTktmst_rackcode("000");
						t789.setTktmst_validatee(new Date(System.currentTimeMillis()+30*Tools.DAY_MILLIS));
						t789.setTktmst_validates(new Date());
						t789.setTktmst_sodrid(order.getId());//订单id
						t789.setTktmst_type("003007");//积分换券
						//t789.setTktmst_value(new Float(ticket_cut_money));
						t789.setTktmst_validflag(new Long(0));//标记为未使用
						t789.setTktmst_uodrid(order.getId());
						t789.setTktmst_cardno("");
						t789.setTktmst_baihuo(new Long(0));
						
						
						if("3".equals(awardId)){//15元优惠券，购物满50可以使用
							t789.setTktmst_gdsvalue(new Float(50));
							t789.setTktmst_value(new Float(15));
						}else if("36".equals(awardId)){//30元优惠券，购物满200可以使用
							t789.setTktmst_gdsvalue(new Float(200));
							t789.setTktmst_value(new Float(30));
						}else if("66".equals(awardId)){//5元优惠券，不限购物金额
							t789.setTktmst_gdsvalue(new Float(0));
							t789.setTktmst_value(new Float(5));
						}else if("67".equals(awardId)){//10元优惠券，不限购物金额
							t789.setTktmst_gdsvalue(new Float(0));
							t789.setTktmst_value(new Float(10));
						}else if("92".equals(awardId)){//20元优惠券，购物满100可以使用
							t789.setTktmst_gdsvalue(new Float(100));
							t789.setTktmst_value(new Float(20));
						}else if("294".equals(awardId)){//50元优惠券，购物满300可以使用
							t789.setTktmst_gdsvalue(new Float(300));
							t789.setTktmst_value(new Float(50));
						}else if("526".equals(awardId)){//300减100元优惠券
							t789.setTktmst_gdsvalue(new Float(300));
							t789.setTktmst_value(new Float(100));
						}else if("787".equals(awardId)){//200减50元优惠券
							t789.setTktmst_gdsvalue(new Float(200));
							t789.setTktmst_value(new Float(50));
						}else if("479".equals(awardId)){//10元优惠券，全场无限制使用
							t789.setTktmst_gdsvalue(new Float(0));
							t789.setTktmst_value(new Float(10));
						}else if("480".equals(awardId)){//100元优惠券，购物满200可以使用
							t789.setTktmst_gdsvalue(new Float(200));
							t789.setTktmst_value(new Float(100));
						}
						
						Tools.getManager(Ticket.class).txCreate(t789);//创建兑换生成的优惠券
					}
				}
			}

		}

		//如果用券或者预存款支付完了所有费用，则修改状态
		if(ticket_cut_money+prepay_money>=gdsmoney+shipfee){
			if(order.getOdrmst_orderstatus()!=null&&order.getOdrmst_orderstatus().longValue()==0){
				Tools.getManager(OrderCache.class).txBeforeUpdate(order);
				order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+ new Date()+"预存款或E券全部收款");
				order.setOdrmst_getmoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
				order.setOdrmst_validdate(new Date());
				order.setOdrmst_realstatus(new Long(1));//实收
				order.setOdrmst_realgettime(new Date());
				order.setOdrmst_orderstatus(new Long(2));//确认收款状态
				
				Tools.getManager(OrderCache.class).txUpdate(order, true);
				
				//调用存储过程把订单修改成“确认收款”状态，并执行库存等修改动作！！！
				ProcedureWork work = new ProcedureWork(order.getId());
				Tools.getManager(OrderMain.class).currentSession().doWork(work);//执行work
			}
		}else if(loginUser.getMbrmst_finishdate()!=null&&order.getOdrmst_payid()!=null
				&&order.getOdrmst_payid().longValue()==0){
			confirmGetMoney(order,loginUser);
		}
		
		return order ;
	}
	private void createItem(TmallGrp tmgrp,Cart cart,String odrid,String uid,String brandpidstr,String ticket_type,String tktshopcode){
			String[] gs = tmgrp.getTmallgrp_items().split(",");
			String gsp="";
			float gspall=0f;
			int gslen=gs.length;
			for(int l=0;l<gslen;l++){
				Product p=(Product)Tools.getManager(Product.class).txGet(gs[l]);
				if(p!=null){
							gspall=gspall+p.getGdsmst_memberprice().floatValue();
				}
			}
			float gdtlmoney=cart.getMoney().floatValue();
			String productId=cart.getProductId();
			float dtlmall=0f;
	 for(int l=0;l<gslen;l++){
					Product p=(Product)Tools.getManager(Product.class).txGet(gs[l]);
					float mprice=p.getGdsmst_memberprice().floatValue();
					float dtlm= Tools.getFloat(gdtlmoney*(mprice/gspall),1);
					if(l==gslen-1)dtlm=gdtlmoney-dtlmall;
					dtlmall+=dtlm;
		
		//创建另外一条记录，用于占用虚拟库存
		CartItem ci = new CartItem();
		ci.setAmount(cart.getAmount());
		ci.setCreateDate(new Date());
		ci.setOrderId(odrid);
		ci.setProductId(p.getId());
		ci.setSkuId(cart.getSkuId());
		ci.setUserId(uid);
		Tools.getManager(CartItem.class).txCreate(ci);
		
		OrderItemCache orderItem = new OrderItemCache();
		orderItem.setId(SequenceIdGenerator.generate("5"));//注意5是seqid
		
        orderItem.setOdrdtl_shopcode(p.getGdsmst_shopcode());
        orderItem.setOdrdtl_oldodrid(odrid);
		orderItem.setOdrdtl_purprice(Tools.getDouble(p.getGdsmst_inprice(),2));
		orderItem.setOdrdtl_addshipfee(Tools.getDouble(new Float(p.getGdsmst_addshipfee()),2));//额外运费  特别重的商品，商品表取
		orderItem.setOdrdtl_aspmemo("");//采购记录
		if(cart.getActid()!=null&&cart.getActid().longValue()>0){
		orderItem.setOdrdtl_actid(cart.getActid());
		orderItem.setOdrdtl_actmemo(cart.getActmemo());
		orderItem.setOdrdtl_actmoney(cart.getActmoney()/gslen);
		}
		
		orderItem.setOdrdtl_odrid(odrid);//订单号
		orderItem.setOdrdtl_gdsid(gs[l]);//product id
		orderItem.setOdrdtl_sku1("");//sku id
		orderItem.setOdrdtl_sku2("");//sku2 id 没用 
		
		
		if("0".equals(ticket_type)){
            if(brandpidstr.length()>0){
			if(brandpidstr.indexOf(cart.getProductId())==-1){
				orderItem.setOdrdtl_examineflag(new Long(1));
			}
            }else{
            	if(Tools.isNull(tktshopcode))tktshopcode="00000000";
            	if(!tktshopcode.equals(cart.getShopcode())&&!tktshopcode.equals("11111111")){
            		orderItem.setOdrdtl_examineflag(new Long(1));
            	}
            	
            }
		}else if("1".equals(ticket_type)){
			if(!"00000000".equals(cart.getShopcode())){
				orderItem.setOdrdtl_examineflag(new Long(1));
			}
			
		}else if("2".equals(ticket_type)){
			if(brandpidstr.indexOf(cart.getShopcode())==-1){
				orderItem.setOdrdtl_examineflag(new Long(1));
			}
		}
		
		orderItem.setOdrdtl_referer(cart.getRefererurl());
		orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//商品名
		orderItem.setOdrdtl_memberprice(new Double(mprice));//会员价
		orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//市场价
		orderItem.setOdrdtl_vipprice(new Double(p.getGdsmst_vipprice()));//vip 价
		
		if(cart.getType().longValue()==0||cart.getType().longValue()==12){//如果是赠品
			orderItem.setOdrdtl_gifttype(cart.getGiftType());
			orderItem.setOdrdtl_rackcode(cart.getGiftRackcode());
			orderItem.setOdrdtl_buyflag(new Long(2));//赠品为2
		}else{
			orderItem.setOdrdtl_gifttype("");
			orderItem.setOdrdtl_rackcode(p.getGdsmst_rackcode());
			orderItem.setOdrdtl_buyflag(new Long(0));//1为抢购商品
		}
		orderItem.setOdrdtl_downflag(cart.getType());
		//Double finalprice = Tools.getDouble(new Float(cart.getMoney().floatValue()/cart.getAmount().longValue()),2);//成交单价
		
		orderItem.setOdrdtl_finalprice(Tools.getDouble(dtlm,2));//最后成交单价
		orderItem.setOdrdtl_gdscount(cart.getAmount());//订购数量
		orderItem.setOdrdtl_totalmoney(Tools.getDouble(dtlm,2));//成交总金额
		
		orderItem.setOdrdtl_shipstatus(new Long(1));//发货状态，1为未发货
		orderItem.setOdrdtl_sendcount(cart.getAmount());//发货数量，最开始0
		orderItem.setOdrdtl_creatdate(new Date());//创建日期
		
		orderItem.setOdrdtl_promotionword("");//促销语
		orderItem.setOdrdtl_refundcount(new Long(0));//没发货的数量
		orderItem.setOdrdtl_weight(new Long(0));//商品重量  无用
		
		
		
		orderItem.setOdrdtl_stddetail1(p.getGdsmst_stdvalue1());//从商品表取
		orderItem.setOdrdtl_stddetail2(p.getGdsmst_stdvalue2());
		orderItem.setOdrdtl_stddetail3(p.getGdsmst_stdvalue3());
		orderItem.setOdrdtl_stddetail4(p.getGdsmst_stdvalue4());
		orderItem.setOdrdtl_stddetail5(p.getGdsmst_stdvalue5());
		orderItem.setOdrdtl_stddetail6(p.getGdsmst_stdvalue6());
		orderItem.setOdrdtl_stddetail7(p.getGdsmst_stdvalue7());
		orderItem.setOdrdtl_stddetail8(p.getGdsmst_stdvalue8());
		orderItem.setOdrdtl_stddetail9("");//商品没有stddetail9字段
		
		orderItem.setOdrdtl_presellflag(new Long(0));//保留字段，无用
		orderItem.setOdrdtl_incometype(new Long(0));//保留字段，无用
		orderItem.setOdrdtl_incomevalue(new Double(0));//保留字段
		
		orderItem.setOdrdtl_totalincomevalue(Tools.getDouble(dtlm,2));//计算商户总收入 不用
		orderItem.setOdrdtl_eyuan(new Double(0));//商品应发E券 商品表取，价格不能打折送券的商品
		
		orderItem.setOdrdtl_spendcount(Tools.getDouble(new Float((int)cart.getMoney().intValue()),2));//返用户积分
		
		orderItem.setOdrdtl_managememo("");//产品经理留言
		orderItem.setOdrdtl_gdspurmemo("");//采购备注 
		
		orderItem.setOdrdtl_specialflag(p.getGdsmst_specialflag());//0是什么都参与，1表示商品不能用券，2表示不参与联盟返利
		//orderItem.setOdrdtl_gifttype("");//赠品类型
		
		orderItem.setOdrdtl_refcount(p.getGdsmst_refcount());//是否参加返Ｅ券活动，不参加为0，参与为1（目前没有用）
		orderItem.setOdrdtl_jcflag(new Long(0));//没有用
		
		orderItem.setOdrdtl_temp("");//商品活动标记，记录订单来源，很重要！如“团购商品”“团购兑换”

		//创建订单明细
		Tools.getManager(OrderItemCache.class).txCreate(orderItem);
	}

	}
	
	/**
	 * 支付成功修改订单状态，如果需要支付的金额比较不正确，也返回null
	 * @param order - 订单对象
	 * @param dblAmount - 支付的金额
	 * @return int -1order为null,-2状态不是未支付状态，-3金额不一样，-4数据库执行错误，0成功
	 */
	public int updateOrderStatus(OrderBase order , double dblAmount){
		/*if(order == null) return -1;
		//锁用户订单。如果用memcached做数据库缓存，这块要修改成分布式锁或数据库锁！！！
		synchronized(order){
			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return -2;
			//精确到角
			if((int)Math.round(Tools.doubleValue(order.getOdrmst_acturepaymoney())*10) != (int)Math.round(dblAmount*10)) return -3;//金额不一样
			Tools.getManager(order.getClass()).txBeforeUpdate(order);
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(System.currentTimeMillis())+"支付系统自动收款");
			order.setOdrmst_validdate(new Date());
			order.setOdrmst_orderstatus(new Long(2));
			order.setOdrmst_getmoney(Tools.getDouble(new Double((double)dblAmount),2));
			
			Tools.getManager(order.getClass()).txUpdate(order, true);
			
			//调用存储过程把订单修改成“确认收款”状态，并执行库存等修改动作！！！
			ProcedureWork work = new ProcedureWork(order.getId());
			Tools.getManager(order.getClass()).currentSession().doWork(work);//执行work
			
			if(Tools.longValue(order.getOdrmst_orderstatus()) == 0) return -4;
			return 1;
		}*/
		int ret=updateOrderStatus2013(order,dblAmount);
		if (ret==1){
		updateOrderStatuswork(order);
		}
		return ret;
	}
	
	
	public  boolean confirmGetMoney(OrderBase order,User loginUser){
		if(order.getOdrmst_orderstatus()!=null&&order.getOdrmst_orderstatus().longValue()==0){
				
			int ret=updateOrderStatushf(order);
		if (ret==1){
			updateOrderStatuswork(order);
			return true ;
			}
		}
		
		return false ;
	}
	public int updateOrderStatushf(OrderBase order ){
		if(order == null) return -1;
		//锁用户订单。如果用memcached做数据库缓存，这块要修改成分布式锁或数据库锁！！！
		synchronized(order){
			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return -2;
     		Tools.getManager(order.getClass()).txBeforeUpdate(order);
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(new Date()) +"货到付款自动 确认");
			order.setOdrmst_validdate(new Date());
			order.setOdrmst_orderstatus(new Long(1));
			
			Tools.getManager(order.getClass()).txUpdate(order, true);
			
			if(Tools.longValue(order.getOdrmst_orderstatus()) == 0) return -4;
			return 1;
		}
	}
	
	/**
	 * 支付成功修改订单状态，如果需要支付的金额比较不正确，也返回null
	 * @param order - 订单对象
	 * @param dblAmount - 支付的金额
	 * @return int -1order为null,-2状态不是未支付状态，-3金额不一样，-4数据库执行错误，0成功
	 */
	public int updateOrderStatus2013(OrderBase order , double dblAmount){
		if(order == null) return -1;
		//锁用户订单。如果用memcached做数据库缓存，这块要修改成分布式锁或数据库锁！！！
		synchronized(order){
			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return -2;
			//精确到角
			if((int)Math.round(Tools.doubleValue(order.getOdrmst_acturepaymoney())*10) != (int)Math.round(dblAmount*10)) return -3;//金额不一样
			Tools.getManager(order.getClass()).txBeforeUpdate(order);
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(System.currentTimeMillis())+"支付系统自动收款"+order.getOdrmst_acturepaymoney()+"元");
			order.setOdrmst_validdate(new Date());
			order.setOdrmst_orderstatus(new Long(2));
			order.setOdrmst_getmoney(Tools.getDouble(new Double((double)dblAmount),2));
			order.setOdrmst_realgetmoney(Tools.getDouble(new Double((double)dblAmount),2));
			order.setOdrmst_realstatus(new Long(1));
			order.setOdrmst_realgettime(new Date());
			Tools.getManager(order.getClass()).txUpdate(order, true);
			
			if(Tools.longValue(order.getOdrmst_orderstatus()) == 0) return -4;
			return 1;
		}
	}
	
	public int updateOrderStatuswork(OrderBase order){

		if(order == null) return -1;
		//锁用户订单。如果用memcached做数据库缓存，这块要修改成分布式锁或数据库锁！！！
		synchronized(order){
	
			
			//调用存储过程把订单修改成“确认收款”状态，并执行库存等修改动作！！！
			try {
			ProcedureWork work = new ProcedureWork(order.getId());
			Tools.getManager(order.getClass()).currentSession().doWork(work);//执行work
			
				Tools.getManager(order.getClass()).currentSession().connection().commit();
			} catch (HibernateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
			return 1;
		}

	}
	
	/**
	 * 取消订单
	 * @param orderId
	 */
	public void cancelOrder(OrderBase order){
		if(order==null)return;
		synchronized(order){
			if(order.getOdrmst_orderstatus().longValue()!=-1){
				Tools.getManager(order.getClass()).txBeforeUpdate(order);
				// 1=cache订单，2=main订单，3=recent订单，4=history订单
				if(order.getOdrmst_prepayvalue()!=null&&order.getOdrmst_prepayvalue().floatValue()>0){//使用了预存款
					Prepay prepay = new Prepay();
					prepay.setPrepay_createdate(new Date());
					prepay.setPrepay_log("取消订单退还");
					prepay.setPrepay_memo("取消订单退还");
					prepay.setPrepay_odrid(order.getId());
					prepay.setPrepay_status(new Long(0));
					prepay.setPrepay_type(new Long(4));
					prepay.setPrepay_mbrid(order.getOdrmst_mbrid());
					prepay.setPrepay_value(new Float(order.getOdrmst_prepayvalue()));
					prepay.setPropay_operator(order.getOdrmst_mbrid()+"");
					Tools.getManager(Prepay.class).txCreate(prepay);
					
					order.setOdrmst_prepayvalue(new Double(0));
				}
				
				if(order.getOdrmst_tktvalue()!=null&&order.getOdrmst_tktvalue().floatValue()>0&&order.getOdrmst_tktid().longValue()!=0){//本订单用券了
					Ticket ticket = (Ticket)Tools.getManager(Ticket.class).txGet(order.getOdrmst_tktid()+"");
					
					//使用过得Ticket，不是从百分比减免、也不是品牌减免生成的券才退
					if(ticket.getTktmst_ifcrd().longValue()==0&&!"015004".equals(ticket.getTktmst_type())){
						Tools.getManager(Ticket.class).txBeforeUpdate(ticket);
						ticket.setTktmst_validflag(new Long(0));
						ticket.setTktmst_sodrid("");
						ticket.setTktmst_uodrid("");
						Tools.getManager(Ticket.class).txUpdate(ticket, true);
					}
				}
				
				order.setOdrmst_tktid(new Long(0));
				order.setOdrmst_tktvalue(new Double(0));
				
				order.setOdrmst_orderstatus(new Long(-1));
				Tools.getManager(order.getClass()).txUpdate(order, true);
			}
		}
	}
}
