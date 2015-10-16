package com.d1.service;

import java.io.File;
import java.io.FileWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.HibernateException;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.CartItem;
import com.d1.bean.GiftItem;
import com.d1.bean.OrderBase;
import com.d1.bean.OrderCache;
import com.d1.bean.OrderItemCache;
import com.d1.bean.OrderMain;
import com.d1.bean.OrderShopCache;
import com.d1.bean.OrderTenpay;
import com.d1.bean.Product;
import com.d1.bean.TenpayFee;
import com.d1.bean.TenpayGds;
import com.d1.bean.TenpayNumFee;
import com.d1.bean.id.OrderIdGenerator;
import com.d1.bean.id.SequenceIdGenerator;
import com.d1.dbcache.core.BaseEntity;
import com.d1.helper.ProductHelper;
import com.d1.util.StringUtils;
import com.d1.util.Tools;

/**
 * 创建财付通相关订单的事务方法
 * @author kk
 */
public class OrderTenpayService {
	/**
	 * 创建财付通交易的事务方法
	 * @return OrderCache
	 */
	public OrderCache createOrderFromTenpay(HttpServletRequest request,HttpServletResponse response) throws Exception {

		for(int i=0;i<Integer.parseInt(request.getParameter("total_product_type"));i++)
		{
			OrderTenpay ot2 =(OrderTenpay)Tools.getManager(OrderTenpay.class).txFindByProperty("tenpayOrderId", request.getParameter("transaction_id_"+i));
			if (ot2!=null) {

					FileWriter fw = new FileWriter(new File("/var/Tenpayerror.txt"),true);
					fw.write("财付通接口订单创建订单出错："+request.getParameter("transaction_id_"+i)+"财付通订单号已经存在"+System.getProperty("line.separator"));
					fw.flush();
					fw.close();
				return null;
			}
		}
		
		OrderCache order = new OrderCache();
		
		order.setId(OrderIdGenerator.generate());//order id，通过一个sequence创建的
		order.setOdrmst_id(new Long(SequenceIdGenerator.generate("4")));
		order.setOdrmst_mbrid(new Long(2316985));//用于财付通商城下单的会员id 
		
		order.setOdrmst_rname(request.getParameter("recv_name"));//收货人姓名 
		order.setOdrmst_orderdate(new Date());//订单日期
		order.setOdrmst_rsex("");
		order.setOdrmst_payid(new Long(25));//财付通支付
		order.setOdrmst_paymethod("腾讯财付通");
		order.setOdrmst_paytype(new Long(4));//支付宝支付的type
		order.setOdrmst_rzipcode(request.getParameter("recv_zipcode"));//收货人邮编
		order.setOdrmst_raddress(request.getParameter("recv_addr"));//收货人地址
		String rphone="";
		if(!Tools.isNull(request.getParameter("recv_mobile"))){
			rphone=request.getParameter("recv_mobile");
		}
		if(!Tools.isNull(request.getParameter("recv_phone"))){
			rphone=rphone+" "+request.getParameter("recv_phone");
		}
		order.setOdrmst_rphone(rphone);//收货人电话、手机
		order.setOdrmst_remail("");//收货人email
		order.setOdrmst_rcountry("中国");//国家
		order.setOdrmst_rprovince(request.getParameter("recv_province"));//收货人省
		order.setOdrmst_rcity(request.getParameter("recv_city")+" "+request.getParameter("recv_area"));//收货人城市
		
		order.setOdrmst_ourmemo("");
		
		order.setOdrmst_pzipcode("");//订购人相关信息
		order.setOdrmst_paddress("");//订购人相关信息
		order.setOdrmst_pcountry("中国");//订购人相关信息
		order.setOdrmst_pprovince("");//订购人相关信息
		order.setOdrmst_pcity("");//订购人相关信息
		order.setOdrmst_pophone("");//订购人相关信息
		order.setOdrmst_phphone("");//订购人相关信息
		order.setOdrmst_pmphone("");//订购人相关信息 
		order.setOdrmst_pusephone("");//订购人相关信息 
		order.setOdrmst_pbp("");//订购人相关信息
		order.setOdrmst_pemail("");//订购人相关信息
		
		order.setOdrmst_pname("d1-财付通商城");//订购人相关信息，对应前面的id
		
		order.setOdrmst_psex("");
		order.setOdrmst_oldodrid(order.getId());//用于补发或拆单对帐
		String buyerremark = "";
		if(request.getParameter("remark")!=null){
			buyerremark = request.getParameter("remark");
		}
		order.setOdrmst_customerword("<pan style=\"color:#FF0000\">"+buyerremark+"</span>");//送货时间+买家留言
		
		order.setOdrmst_orderstatus(new Long(0));//订单状态
		order.setOdrmst_specialtype(new Long(0));//用户的特殊标志（没用）
		
	
		
		//获取商品价钱
        float totalmoney=0;
        boolean freeflag=false;



		
		if(request.getParameter("total_product_type")!=null&&StringUtils.isDigits(request.getParameter("total_product_type")))
		{
			for(int i=0;i<Integer.parseInt(request.getParameter("total_product_type"));i++)
			{
				//Product p=(Product)Tools.getManager(Product.class).txGet(request.getParameter("product_id_"+i));
				totalmoney+=Tools.parseFloat(request.getParameter("product_money_"+i))/100;
				//p=null;

			}
			
		}
		
		
		
		if(totalmoney>=99){
		order.setOdrmst_shipfee(new Double(0));//设置运费
		}
		else{
		order.setOdrmst_shipfee(new Double(10));//设置运费
		}
		order.setOdrmst_shipid(new Long(10));//快递上门
		order.setOdrmst_shipmethod("快递上门");
		
		order.setOdrmst_acturepaymoney(new Double(totalmoney+order.getOdrmst_shipfee()));//实际支付金额
		
		order.setOdrmst_gdsmoney(new Double(totalmoney));//总价-运费
		
		order.setOdrmst_ordermoney(new Double(order.getOdrmst_acturepaymoney()));
		
		order.setOdrmst_getmoney(new Double(0));//收到多少钱
		order.setOdrmst_realgetmoney(new Double(0));
		
		
		order.setOdrmst_prepayvalue(new Double(0));
		order.setOdrmst_temp("财付通");//订单来源
		
		order.setOdrmst_tktvalue(new Double(0));//E券金额
		order.setOdrmst_tktid(new Long(0));//E券编号，对应tktmst.id
		
		System.out.println("创建OrderCache数据库..."+order.getId());
		
		Tools.getManager(OrderCache.class).txCreate(order);
		
		
		OrderShopCache orderShopCache = new OrderShopCache();
		orderShopCache.setOdrshp_odrid(order.getId());
		orderShopCache.setOdrshp_shopcode("08102301");
		orderShopCache.setOdrshp_sndshopcode("00000000");//d1发货全填这个
		orderShopCache.setOdrshp_orderdate(new Date());
		orderShopCache.setOdrshp_shopname("D1便利网自行发货");
		orderShopCache.setOdrshp_country("中国");
		orderShopCache.setOdrshp_province("");
		orderShopCache.setOdrshp_city(request.getParameter("recv_city"));
		
		orderShopCache.setOdrshp_gdsmoney(new Float(totalmoney));
		orderShopCache.setOdrshp_shipfee(new Float(10));
		orderShopCache.setOdrshp_centerfee(new Float(0));
		
		orderShopCache.setOdrshp_ordermoney(new Float(totalmoney+order.getOdrmst_shipfee()));
		
		orderShopCache.setOdrshp_payshopmoney(new Float(0));
		
		orderShopCache.setOdrshp_incomevalue(new Float(totalmoney));
		orderShopCache.setOdrshp_realincome(new Float(0));
		orderShopCache.setOdrshp_giftid(new Long(0));
		orderShopCache.setOdrshp_giftfee(new Float(0));
		orderShopCache.setOdrshp_downflag(new Long(1));
		
		Tools.getManager(OrderShopCache.class).txCreate(orderShopCache);//创建odrshp记录，这个记录没有用，但后台有关联查询，所以必须创建
		
		
		int totalProducts = new Integer(request.getParameter("total_product_type")).intValue();//买了多少件商品
		float giftmoney=0f;
		String gdsstr="";
		boolean flag = true ;
		if(flag){
			for(int i=0;i<totalProducts;i++){//创建订单明细
				
				String tenpayId = request.getParameter("transaction_id_"+i);
				
				
				String productId = request.getParameter("product_id_"+i);
				String gdsid=productId;
				TenpayFee tenpayfee =(TenpayFee)Tools.getManager(TenpayFee.class).txFindByProperty("tenpayfee_gdsid", productId);
				if(tenpayfee!=null){
					gdsid=gdsid.substring(0,8);
				}
				
				Product p = (Product)Tools.getManager(Product.class).txGet(gdsid);
				TenpayGds tenpaygds=(TenpayGds)Tools.getManager(TenpayGds.class).txFindByProperty("tenpaygds_gdsid", gdsid);
				
				OrderItemCache orderItem = new OrderItemCache();
				
				orderItem.setId(SequenceIdGenerator.generate("5"));
				orderItem.setOdrdtl_odrid(order.getId());//订单号
				
				orderItem.setOdrdtl_gdsid(gdsid);//product id
				gdsstr=gdsstr+","+gdsid;
				String gdssku1="";
				if(!Tools.isNull(request.getParameter("arg1_"+i))){
					gdssku1=java.net.URLDecoder.decode(request.getParameter("arg1_"+i), "GBK");
				}
				
				 orderItem.setOdrdtl_shopcode(p.getGdsmst_shopcode());
                 orderItem.setOdrdtl_oldodrid(order.getId());
				orderItem.setOdrdtl_sku1(gdssku1);
				orderItem.setOdrdtl_sku2("");//sku2  没用
				//1手表饰品 8%     2 化妆品 4%  	3  服装 15%
				double fdbl=0;
				if (tenpaygds!=null){
					fdbl=tenpaygds.getTenpaygds_bl().doubleValue();
				}else{
					if(p.getGdsmst_rackcode()!=null&&(p.getGdsmst_rackcode().startsWith("02")
							||p.getGdsmst_rackcode().startsWith("03"))){
						fdbl=0.15;
					}else if(p.getGdsmst_rackcode()!=null&&(p.getGdsmst_rackcode().startsWith("015002")
							||p.getGdsmst_rackcode().startsWith("015009"))){
						fdbl=0.08;;
					}else{
						fdbl=0.04;
					}
				}
				orderItem.setOdrdtl_insurancefee(new Double(fdbl));
				orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//商品名
				orderItem.setOdrdtl_memberprice(new Double(p.getGdsmst_memberprice()));//会员价
				orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//市场价
				orderItem.setOdrdtl_vipprice(new Double(p.getGdsmst_vipprice()));//vip 价
				double finalprice=Tools.parseDouble(request.getParameter("product_money_"+i))/Tools.parseDouble(request.getParameter("product_count_"+i));
				orderItem.setOdrdtl_finalprice(new Double(finalprice/100));//最后成交单价
				
				orderItem.setOdrdtl_gdscount(new Long(request.getParameter("product_count_"+i)));//订购数量
				orderItem.setOdrdtl_totalmoney(new Double(Tools.parseDouble(request.getParameter("product_money_"+i))/100));//成交总金额
				orderItem.setOdrdtl_purprice(new Double(p.getGdsmst_inprice()));

				orderItem.setOdrdtl_shipstatus(new Long(1));//发货状态，1为未发货
				orderItem.setOdrdtl_sendcount(new Long(request.getParameter("product_count_"+i)));//发货数量，最开始0
				orderItem.setOdrdtl_creatdate(new Date());//创建日期
				orderItem.setOdrdtl_refundcount(new Long(0));//没发货的数量
				orderItem.setOdrdtl_rackcode(p.getGdsmst_rackcode());
				if(p.getGdsmst_rackcode()!=null&&(p.getGdsmst_rackcode().startsWith("02")||p.getGdsmst_rackcode().startsWith("03"))){
					giftmoney+=orderItem.getOdrdtl_totalmoney().floatValue();
				}
				
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
				
				int num = new Integer(request.getParameter("product_count_"+i)).intValue();
				
				orderItem.setOdrdtl_totalincomevalue(Tools.getDouble(new Double(Tools.parseDouble(request.getParameter("product_money_"+i))/100),2));//计算商户总收入 不用
				orderItem.setOdrdtl_eyuan(new Double(0));//商品应发E券 商品表取，价格不能打折送券的商品
				
				orderItem.setOdrdtl_spendcount(new Double(0));//返用户积分
				
				orderItem.setOdrdtl_managememo("");//产品经理留言
				orderItem.setOdrdtl_gdspurmemo("");//采购备注 
				
				orderItem.setOdrdtl_specialflag(new Long(2));//0是什么都参与，1表示商品不能用券，2表示不参与联盟返利
				orderItem.setOdrdtl_gifttype("");//赠品类型 
				
				orderItem.setOdrdtl_refcount(new Long(1));//是否参加返Ｅ券活动，不参加为0，参与为1（目前没有用）
				orderItem.setOdrdtl_jcflag(new Long(0));//没有用
				
				orderItem.setOdrdtl_temp("财付通商城");//商品活动标记，记录订单来源
				orderItem.setOdrdtl_tuancardno("");//商户兑换券号
				//odrdtl_egblancecode
				orderItem.setOdrdtl_egblancecode(tenpayId);///订单明细和财付通订单对应ID
				
				//创建订单明细
				System.out.println("创建数据库订单明细："+orderItem.getId());
				Tools.getManager(OrderItemCache.class).txCreate(orderItem);
				

				        TenpayNumFee tenpaygdsup =(TenpayNumFee)Tools.getManager(TenpayNumFee.class).txFindByProperty("tenpaynumfee_gdsstr", gdsid);
				        if(tenpaygdsup!=null&&tenpaygdsup.getTenpaynumfee_allmoney().longValue()<6){
				        	    tenpaygdsup.setTenpaynumfee_allmoney(new Float(tenpaygdsup.getTenpaynumfee_allmoney().floatValue()+num));
				        		Tools.getManager(TenpayNumFee.class).txUpdate(tenpaygdsup , true);
				        		}
	
				
				//创建另外一条记录，用于占用虚拟库存
				CartItem ci = new CartItem();
				ci.setAmount(orderItem.getOdrdtl_gdscount());
				ci.setCreateDate(new Date());
				ci.setOrderId(order.getId());
				ci.setProductId(p.getId());
				ci.setSkuId(orderItem.getOdrdtl_sku1());
				ci.setUserId("2316985");
				Tools.getManager(CartItem.class).txCreate(ci);
				//创建财付通D1订单对应关系表
				OrderTenpay ot=new OrderTenpay();
				ot.setD1OrderId(order.getId());
				ot.setTenpayOrderId(tenpayId);//相当于session id的一个参数
				ot.setProductid(productId);
				ot.setOrdermoney(new Double(Tools.parseDouble(request.getParameter("product_money_"+i))/100));
				ot.setStatus(new Long(0));
				Tools.getManager(OrderTenpay.class).txCreate(ot);
			}
			SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	        String end="2013-07-01 00:00:00";
	        if(df.parse(end).after(new Date())){
	        	  setzp(giftmoney,order.getId());
	        }

	        String end3="2013-08-26 00:00:00";
	        if((gdsstr.indexOf("01517308")>=0||gdsstr.indexOf("01517389")>=0||gdsstr.indexOf("01517528")>=0
	        		||gdsstr.indexOf("01513987")>=0)&&df.parse(end3).after(new Date())){
	        	setzp2(order.getId(),2);
	        } 
	        String end4="2013-08-26 00:00:00";
	        if((gdsstr.indexOf("01517623")>=0||gdsstr.indexOf("01517624")>=0||gdsstr.indexOf("01517418")>=0
	        		||gdsstr.indexOf("01517625")>=0)&&df.parse(end4).after(new Date())){
	        	setzp2(order.getId(),3);
	        }

		}

		return order;
	}
	
	private void setzp(float ordermoney,String orderid){
		String gdsid="";
		String sku="";
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("giftrckdtl_mstid", new Long(795)));//这里是专用赠品组
		clist.add(Restrictions.le("giftrckdtl_limitmoney", new Float(ordermoney)));//这里是专用赠品组
		List<org.hibernate.criterion.Order> olist = new ArrayList<org.hibernate.criterion.Order>();
		olist.add(org.hibernate.criterion.Order.desc("giftrckdtl_limitmoney"));
		
		List<BaseEntity> resList = Tools.getManager(GiftItem.class).txGetList(clist,olist,0,10);
		if(resList!=null&&resList.size()>0){
			
				GiftItem gi = (GiftItem)resList.get(0);
				gdsid=gi.getGiftrckdtl_gdsid();
				if(!Tools.isNull(gdsid)){
					Product p=ProductHelper.getById(gdsid);
					OrderItemCache orderItem = new OrderItemCache();
					
					orderItem.setId(SequenceIdGenerator.generate("5"));
					orderItem.setOdrdtl_odrid(orderid);//订单号
					orderItem.setOdrdtl_oldodrid(orderid);
					orderItem.setOdrdtl_gdsid(gdsid);//product id
					
					
					orderItem.setOdrdtl_sku1(sku);
					orderItem.setOdrdtl_sku2("");//sku2  没用
				
					orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//商品名
					orderItem.setOdrdtl_memberprice(new Double(p.getGdsmst_memberprice()));//会员价
					orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//市场价
					orderItem.setOdrdtl_vipprice(new Double(p.getGdsmst_vipprice()));//vip 价
					
					orderItem.setOdrdtl_finalprice(new Double(0));//最后成交单价
					
					orderItem.setOdrdtl_gdscount(new Long(1));//订购数量
					
					
					orderItem.setOdrdtl_totalmoney(new Double(0));//成交总金额
					orderItem.setOdrdtl_purprice(new Double(p.getGdsmst_inprice()));
		
					orderItem.setOdrdtl_shipstatus(new Long(1));//发货状态，1为未发货
					orderItem.setOdrdtl_sendcount(new Long(1));//发货数量，最开始0
					orderItem.setOdrdtl_creatdate(new Date());//创建日期
					orderItem.setOdrdtl_refundcount(new Long(0));//没发货的数量
					orderItem.setOdrdtl_rackcode(p.getGdsmst_rackcode());
					
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
					orderItem.setOdrdtl_buyflag(new Long(2));    //赠品标识，正常商品为0 赠品为2
					orderItem.setOdrdtl_totalincomevalue(new Double(0));//计算商户总收入 不用
					orderItem.setOdrdtl_eyuan(new Double(p.getGdsmst_eyuan()));//商品应发E券 商品表取，价格不能打折送券的商品
					
					orderItem.setOdrdtl_spendcount(new Double(0));//返用户积分
					
					orderItem.setOdrdtl_managememo("");//产品经理留言
					orderItem.setOdrdtl_gdspurmemo("");//采购备注 
					
					orderItem.setOdrdtl_specialflag(new Long(2));//0是什么都参与，1表示商品不能用券，2表示不参与联盟返利
					orderItem.setOdrdtl_gifttype("");//赠品类型 
					
					orderItem.setOdrdtl_refcount(new Long(1));//是否参加返Ｅ券活动，不参加为0，参与为1（目前没有用）
					orderItem.setOdrdtl_jcflag(new Long(0));//没有用
					
					orderItem.setOdrdtl_temp("财付通商城");//商品活动标记，记录订单来源
					orderItem.setOdrdtl_tuancardno("");//商户兑换券号
					
					//创建订单明细
					System.out.println("创建数据库订单明细："+orderItem.getId());
					Tools.getManager(OrderItemCache.class).txCreate(orderItem);
					
					//创建另外一条记录，用于占用虚拟库存
					CartItem ci = new CartItem();
					ci.setAmount(orderItem.getOdrdtl_gdscount());
					ci.setCreateDate(new Date());
					ci.setOrderId(orderid);
					ci.setProductId(p.getId());
					ci.setSkuId(orderItem.getOdrdtl_sku1());
					ci.setUserId("2316985");
					Tools.getManager(CartItem.class).txCreate(ci);
				}
			}
		
	}
	
	private void setzp2(String orderid,int flag){
		String gdsid="";
		//if(flag==1){
		//  gdsid="02001900";
		//}else 
			if(flag==2){
		  gdsid="01517367";
		}else if(flag==3){
			  gdsid="01517622";
		}
					Product p=ProductHelper.getById(gdsid);
					
					//Sku sku=SkuHelper.getVirtualStock(productId, sku1)
					OrderItemCache orderItem = new OrderItemCache();
					
					orderItem.setId(SequenceIdGenerator.generate("5"));
					orderItem.setOdrdtl_odrid(orderid);//订单号
					
					orderItem.setOdrdtl_gdsid(gdsid);//product id
					/*白色	0	0	
宝蓝	0	0	
淡黄	0	0	
粉色	0	0	
果绿	0	0	
黑色	0	0	
玫红	0	0	
浅紫	0	0	
天蓝	0	0	
西瓜红	0	0	*/
					Random rndcard = new Random();
					
					String sku="";
					if(flag==1){
					String[] arrsku={"白色","宝蓝","淡黄","粉色","果绿","黑色","玫红","浅紫","天蓝","西瓜红"};
					int arri=rndcard.nextInt(10);
					sku=arrsku[arri];
					}else if(flag==2){
					String[] arrsku={"白色L","白色M","白色XL","黑色L","黑色M","黑色XL","灰色L","灰色M","灰色XL"};
					int arri=rndcard.nextInt(9);
					sku=arrsku[arri];
					sku="红色";
					}else if(flag==3){
						String[] arrsku={"海蓝","玫红"};
						int arri=rndcard.nextInt(2);
						sku=arrsku[arri];
						sku="玫红";
					}
					

					
					orderItem.setOdrdtl_sku1(sku);
					orderItem.setOdrdtl_sku2("");//sku2  没用
				
					orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//商品名
					orderItem.setOdrdtl_memberprice(new Double(p.getGdsmst_memberprice()));//会员价
					orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//市场价
					orderItem.setOdrdtl_vipprice(new Double(p.getGdsmst_vipprice()));//vip 价
					
					orderItem.setOdrdtl_finalprice(new Double(0));//最后成交单价
					
					orderItem.setOdrdtl_gdscount(new Long(1));//订购数量
					
					
					orderItem.setOdrdtl_totalmoney(new Double(0));//成交总金额
					orderItem.setOdrdtl_purprice(new Double(p.getGdsmst_inprice()));
		
					orderItem.setOdrdtl_shipstatus(new Long(1));//发货状态，1为未发货
					orderItem.setOdrdtl_sendcount(new Long(1));//发货数量，最开始0
					orderItem.setOdrdtl_creatdate(new Date());//创建日期
					orderItem.setOdrdtl_refundcount(new Long(0));//没发货的数量
					orderItem.setOdrdtl_rackcode(p.getGdsmst_rackcode());
					
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
					orderItem.setOdrdtl_buyflag(new Long(2));    //赠品标识，正常商品为0 赠品为2
					orderItem.setOdrdtl_totalincomevalue(new Double(0));//计算商户总收入 不用
					orderItem.setOdrdtl_eyuan(new Double(p.getGdsmst_eyuan()));//商品应发E券 商品表取，价格不能打折送券的商品
					
					orderItem.setOdrdtl_spendcount(new Double(0));//返用户积分
					
					orderItem.setOdrdtl_managememo("");//产品经理留言
					orderItem.setOdrdtl_gdspurmemo("");//采购备注 
					
					orderItem.setOdrdtl_specialflag(new Long(2));//0是什么都参与，1表示商品不能用券，2表示不参与联盟返利
					orderItem.setOdrdtl_gifttype("");//赠品类型 
					
					orderItem.setOdrdtl_refcount(new Long(1));//是否参加返Ｅ券活动，不参加为0，参与为1（目前没有用）
					orderItem.setOdrdtl_jcflag(new Long(0));//没有用
					
					orderItem.setOdrdtl_temp("财付通商城");//商品活动标记，记录订单来源
					orderItem.setOdrdtl_tuancardno("");//商户兑换券号
					orderItem.setOdrdtl_oldodrid(orderid);
					//创建订单明细
					System.out.println("创建数据库订单明细："+orderItem.getId());
					Tools.getManager(OrderItemCache.class).txCreate(orderItem);
					
					//创建另外一条记录，用于占用虚拟库存
					CartItem ci = new CartItem();
					ci.setAmount(orderItem.getOdrdtl_gdscount());
					ci.setCreateDate(new Date());
					ci.setOrderId(orderid);
					ci.setProductId(p.getId());
					ci.setSkuId(orderItem.getOdrdtl_sku1());
					ci.setUserId("2316985");
					Tools.getManager(CartItem.class).txCreate(ci);
	
		
	}
	
	/**
	 * 订单确认收款，财付通已经完成支付 。orderId必须存在，订单状态必须是0！
	 * @param orderId 订单id
	 * @param getmoney 收到多少钱，大于0才有效，小于0不修改。
	 * @return true 操作成功， false表示没有操作，可能是订单id不存在
	 * @throws Exception
	 */
	public  boolean confirmGetMoney(String orderId,float getmoney)throws Exception{
		OrderCache order1 = (OrderCache)Tools.getManager(OrderCache.class).txGet(orderId);
		if(order1==null)return false ;
		
		if(order1.getOdrmst_orderstatus()!=null&&order1.getOdrmst_orderstatus().longValue()==0){
			/*Tools.getManager(OrderCache.class).txBeforeUpdate(order1);
			order1.setOdrmst_ourmemo(order1.getOdrmst_ourmemo()+ new Date()+"财付通收款");
			if(getmoney>0)order1.setOdrmst_getmoney(new Double(getmoney));
			order1.setOdrmst_validdate(new Date());
			order1.setOdrmst_orderstatus(new Long(2));//确认收款状态
			Tools.getManager(OrderCache.class).txUpdate(order1, true);
			
			//调用存储过程把订单修改成“确认收款”状态
			ProcedureWork work = new ProcedureWork(orderId);
			Tools.getManager(OrderMain.class).currentSession().doWork(work);//执行work
			
			return true ;*/
			int ret=updateOrderStatus2013(order1,getmoney);
			if (ret==1){
			updateOrderStatuswork(order1);
			return true ;
			}
		}
		
		return false ;
	}
	public int updateOrderStatus2013(OrderBase order , double dblAmount){
		if(order == null) return -1;
		//锁用户订单。如果用memcached做数据库缓存，这块要修改成分布式锁或数据库锁！！！
		synchronized(order){
			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return -2;
			//精确到角
			Tools.getManager(order.getClass()).txBeforeUpdate(order);
			if(dblAmount>0)order.setOdrmst_getmoney(new Double(dblAmount));
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(new Date()) +"财付通收款");
			order.setOdrmst_validdate(new Date());
			order.setOdrmst_orderstatus(new Long(2));
			
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
	 * 多个订单表确认订单
	 * @param order
	 * @param dblAmount
	 * @return
	 */
	public boolean updateOrderStatus(OrderBase order , double dblAmount){
		if(order == null) return false;
		//锁用户订单。如果用memcached做数据库缓存，这块要修改成分布式锁或数据库锁！！！
		synchronized(order){
			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return false;
			//精确到角
			if((int)Math.round(Tools.doubleValue(order.getOdrmst_acturepaymoney())*10) != (int)Math.round(dblAmount*10)) return false;//金额不一样
			Tools.getManager(order.getClass()).txBeforeUpdate(order);
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+ new Date()+"财付通收款");
			order.setOdrmst_validdate(new Date());
			order.setOdrmst_orderstatus(new Long(2));
			order.setOdrmst_getmoney(Tools.getDouble(new Double((double)dblAmount),2));
			
			Tools.getManager(order.getClass()).txUpdate(order, true);
			
			//调用存储过程把订单修改成“确认收款”状态，并执行库存等修改动作！！！
			ProcedureWork work = new ProcedureWork(order.getId());
			Tools.getManager(order.getClass()).currentSession().doWork(work);//执行work
			
			if(Tools.longValue(order.getOdrmst_orderstatus()) == 0) return false;
			return true;
		}
	}
	
}
