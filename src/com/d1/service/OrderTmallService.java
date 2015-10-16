package com.d1.service;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.CartItem;
import com.d1.bean.Gift;
import com.d1.bean.GiftItem;
import com.d1.bean.OrderBase;
import com.d1.bean.OrderCache;
import com.d1.bean.OrderItemMain;
import com.d1.bean.OrderMain;
import com.d1.bean.OrderShopMain;
import com.d1.bean.OrderTaobao;
import com.d1.bean.Product;
import com.d1.bean.Provider;
import com.d1.bean.Sku;
import com.d1.bean.TmallGrp;
import com.d1.bean.Variable;
import com.d1.bean.id.OrderIdGenerator;
import com.d1.bean.id.SequenceIdGenerator;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.StringUtils;
import com.d1.util.Tools;
import com.taobao.api.domain.Order;
import com.taobao.api.domain.Trade;

/**
 * 淘宝商城订单同步创建订单的Service方法
 * @author kk
 *
 */
public class OrderTmallService {
	
	/**
	 * 根据淘宝商城取到得Trade对象创建交易，在淘宝中：Trade就是一条交易，Order是一条交易明细
	 * @param trade
	 * @param buyer_message 买家留言
	 * @param sex 性别
	 * @param buyer 买家对象，com.taobao.api.domain.User类型
	 * @param sellor_memo 卖家备注
	 * @param from 来源 商城还是C店
	 * @return OrderMain
	 */
	public OrderMain createOrderFromTmall(Trade trade,String buyer_message,String sex,com.taobao.api.domain.User buyer,String sellor_memo,String from) throws Exception {
		if(Tools.getManager(OrderTaobao.class).txFindByProperty("taobaoOrderId", ""+trade.getTid())!=null){
			//已经同步过了
			//System.out.println(trade.getTid()+"，订单已经同步过，忽略！");
			return null ;
		}
		SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		OrderMain order = new OrderMain();
		
		System.out.println("开始同步淘宝订单，淘宝订单id="+trade.getTid());
		
		String rphone="";
		if(!Tools.isNull(trade.getReceiverMobile())){
			rphone=trade.getReceiverMobile();
		}
		if(!Tools.isNull(trade.getReceiverPhone())){
			rphone=rphone+";"+trade.getReceiverPhone();
		}

		order.setId(OrderIdGenerator.generate());//order id，通过一个sequence创建的
		order.setOdrmst_id(new Long(SequenceIdGenerator.generate("4")));
		
		if("c".equals(from)){
			order.setOdrmst_mbrid(new Long(2055832));//c店订单
		}else if("b2".equals(from)){
			order.setOdrmst_mbrid(new Long(2055841));//b2订单
		}else if("b3".equals(from)){
			order.setOdrmst_mbrid(new Long(3250586));//b3订单
		}else{
			order.setOdrmst_mbrid(new Long(1544012));//用于淘宝商城下单的会员id
		}
		//查询是否有同一个用户下多单，如果是多单测试合并订单
		List<SimpleExpression> cmlist = new ArrayList<SimpleExpression>();
		cmlist.add(Restrictions.eq("odrmst_rphone", rphone)); 
		cmlist.add(Restrictions.eq("odrmst_raddress", trade.getReceiverAddress())); 
		cmlist.add(Restrictions.eq("odrmst_orderstatus", new Long(2))); 
		cmlist.add(Restrictions.eq("odrmst_mbrid", new Long(1544012))); 
		String linkodrstr="";
		List<BaseEntity> omList = Tools.getManager(OrderMain.class).txGetList(cmlist,null,0,50);
		if(omList!=null&&omList.size()>0){
			linkodrstr="'"+order.getId()+"'";
			for(int l=0;l<omList.size();l++){
			linkodrstr+=",'"+((OrderMain)omList.get(l)).getId()+"'";
			}
			for(int l=0;l<omList.size();l++){
				OrderMain om=(OrderMain)omList.get(l);
				om.setOdrmst_linkodrid(linkodrstr);
				Tools.getManager(OrderMain.class).txUpdate(om, true);
			}
		}
		
		
		String rname23123 =  trade.getReceiverName()+"("+trade.getBuyerNick()+")";
		if(rname23123!=null&&StringUtils.getCnLength(rname23123)>=28){
			rname23123 = StringUtils.getCnSubstring(rname23123, 0, 28);
		}
		
		order.setOdrmst_rname(rname23123);//收货人姓名 
		order.setOdrmst_orderdate(new Date());//订单日期
		order.setOdrmst_rsex(sex);
		order.setOdrmst_payid(new Long(20));//支付宝支付
		order.setOdrmst_paymethod("支付宝支付");
		order.setOdrmst_paytype(new Long(4));//支付宝支付的type
		order.setOdrmst_rzipcode(trade.getReceiverZip());//收货人邮编
		order.setOdrmst_raddress(trade.getReceiverAddress());//收货人地址
		
		
		order.setOdrmst_rphone(rphone);//收货人电话、手机
		order.setOdrmst_remail("");//收货人email
		order.setOdrmst_rcountry("中国");//国家
		order.setOdrmst_rprovince(trade.getReceiverState());//收货人省
		order.setOdrmst_rcity(trade.getReceiverCity()+" "+trade.getReceiverDistrict());//收货人城市
		
		order.setOdrmst_shipid(new Long(10));//快递上门
		order.setOdrmst_shipmethod("快递上门");
		
		order.setOdrmst_pzipcode("");//订购人相关信息
		order.setOdrmst_paddress("");//订购人相关信息
		order.setOdrmst_pcountry("中国");//订购人相关信息
		order.setOdrmst_pprovince("");//订购人相关信息
		order.setOdrmst_pcity("");//订购人相关信息
		order.setOdrmst_pophone("");//订购人相关信息
		order.setOdrmst_phphone("");//订购人相关信息
		order.setOdrmst_pmphone("");//订购人相关信息 
		order.setOdrmst_pusephone("");//订购人相关信息 
		order.setOdrmst_pbp(""+trade.getTid());//订购人相关信息---改成天猫订单号
		order.setOdrmst_pemail("");//订购人相关信息

		order.setOdrmst_linkodrid(linkodrstr);
		order.setOdrmst_pname(trade.getBuyerNick());//订购人相关信息，对应前面的id
		
		order.setOdrmst_psex(sex);
		order.setOdrmst_oldodrid(order.getId());//用于补发或拆单对帐
		if(buyer_message==null)buyer_message="";
		
		order.setOdrmst_orderstatus(new Long(0));//订单状态
		order.setOdrmst_specialtype(new Long(0));

		if(trade.getPostFee()!=null)order.setOdrmst_shipfee(Tools.getDouble(new Float(trade.getPostFee()),2));//设置运费
		if(trade.getPayment()!=null)order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(trade.getPayment()),2));//实际支付金额
		
		float postfee = 0f;
		if(trade.getPostFee()!=null)postfee = Tools.getFloat(new Float(trade.getPostFee()).floatValue(),2);
		
		if(trade.getPayment()!=null)order.setOdrmst_gdsmoney(Tools.getDouble(new Float(new Float(trade.getPayment()).floatValue()-postfee),2));//总价-运费
		
		if(trade.getPayment()!=null)order.setOdrmst_ordermoney(Tools.getDouble(new Float(new Float(trade.getPayment()).floatValue()),2));//
		if(trade.getPayment()!=null)order.setOdrmst_getmoney(Tools.getDouble(new Float(trade.getPayment()),2));//收到多少钱
		order.setOdrmst_realgetmoney(Tools.getDouble(new Float(trade.getPayment()),2));//支付宝已经到账，算
		order.setOdrmst_prepayvalue(new Double(0));
		order.setOdrmst_temp("淘宝商城");//订单来源

		if(trade.getDiscountFee()!=null){
			order.setOdrmst_tktvalue(Tools.getDouble(new Float(new Float(trade.getDiscountFee()).floatValue()),2));
		}else{
		order.setOdrmst_tktvalue(new Double(0));//E券金额
		}
		order.setOdrmst_tktid(new Long(0));//E券编号，对应tktmst.id
		
		order.setOdrmst_odrqus("");
		String memo="";
		String message="";
		if(!Tools.isNull(sellor_memo)){
			memo="卖家备注："+sellor_memo+"<br/>";
		}
		if(!Tools.isNull(buyer_message)){
			message="买家留言："+buyer_message;
		}

		order.setOdrmst_ourmemo(memo+message);//卖家备注
		order.setOdrmst_customerword("[送货时间:每天均可送货 务必送前联系,本人签收 须当面拆箱验货（化妆品拒收不可拆产品包装）]<br><span style=\"color:#FF0000\">"+message+"</span>");//送货时间+买家留言
		order.setOdrmst_internalmemo("[务必送前联系,本人签收 须当面拆箱验货（化妆品拒收不可拆产品包装）]<br><span style=\"color:#FF0000\">"+message+"</span><br/><font color=red><b>"+memo+"</b></font>");
		
		Tools.getManager(OrderMain.class).txCreate(order);
		
		
		OrderShopMain orderShopMain = new OrderShopMain();
		orderShopMain.setOdrshp_odrid(order.getId());
		orderShopMain.setOdrshp_shopcode("08102301");
		orderShopMain.setOdrshp_sndshopcode("00000000");//d1发货全填这个
		orderShopMain.setOdrshp_orderdate(new Date());
		orderShopMain.setOdrshp_shopname("D1便利网自行发货");
		orderShopMain.setOdrshp_country("中国");
		orderShopMain.setOdrshp_province("");
		orderShopMain.setOdrshp_city("");
		if(trade.getPayment()!=null)orderShopMain.setOdrshp_gdsmoney(new Float(trade.getPayment()));
		else orderShopMain.setOdrshp_gdsmoney(new Float(0));
		orderShopMain.setOdrshp_shipfee(new Float((postfee)));
		orderShopMain.setOdrshp_centerfee(new Float(0));
		
		if(trade.getPayment()!=null)orderShopMain.setOdrshp_ordermoney(new Float(new Float(trade.getPayment()).floatValue()+postfee));
		else orderShopMain.setOdrshp_ordermoney(new Float(0));
		
		orderShopMain.setOdrshp_payshopmoney(new Float(0));
		
		orderShopMain.setOdrshp_incomevalue(new Float(trade.getPayment()));
		orderShopMain.setOdrshp_realincome(new Float(0));
		orderShopMain.setOdrshp_giftid(new Long(0));
		orderShopMain.setOdrshp_giftfee(new Float(0));
		orderShopMain.setOdrshp_downflag(new Long(1));
		
		Tools.getManager(OrderShopMain.class).txCreate(orderShopMain);//创建odrshp记录，这个记录没有用，但后台有关联查询，所以必须创建
		
		List<Order> list = trade.getOrders();
		
		float post_dtl = 0f ;
		
		if(list!=null&&list.size()==1)post_dtl = postfee ;//淘宝传过来得数据如果只有一条Order，包含运费
		
		ArrayList<Order> list_ad = new ArrayList<Order>();
	
		//加入“淘宝商城单品赠品”，买什么送什么
		Variable val = (Variable)Tools.getManager(Variable.class).txFindByProperty("name", "TMALL_GIFT");
		if(val!=null&&val.getValue()!=null&&val.getValue().length()>0){
			//234834-247237;8234824-4767345;的格式
			String[] vs = val.getValue().split(";");
			if(vs!=null&&vs.length>0){
				for(String vs123:vs){
					for(Order o:list){//订单明细
						if (o.getTitle().indexOf("邮费")>=0)continue;
						String outerSkuId = o.getOuterSkuId() ; //类似   01715909-XL(185) 这样的结构
						long ocount=o.getNum().longValue();
						
						String productId = outerSkuId , sku1 = null;
						if(!Tools.isNull(outerSkuId)){
							if(outerSkuId.indexOf("-")>0){
								productId = outerSkuId.substring(0,outerSkuId.indexOf("-")).trim();//商品id
								sku1 = outerSkuId.substring(outerSkuId.indexOf("-")+1).trim() ;
							}
						}else{
							productId = o.getOuterIid();
						}
						
						if(Tools.isNull(productId)){
							productId = o.getOuterIid();
							sku1 = o.getSkuId();
						}
						
						productId = productId.replaceAll("[^0-9]*", "");
						if(productId.equals(vs123.substring(0,vs123.indexOf("-")))){//说明用户购买了单品赠品的商品
							Order o_gp = new Order();
							o_gp.setOuterIid(vs123.substring(vs123.indexOf("-")+1));
							o_gp.setPayment("0");
							o_gp.setNum(new Long(ocount));//送一个
							list_ad.add(o_gp);
						}
					}
				}
			}
		}
		
		//品牌赠品
				Variable valbrand = (Variable)Tools.getManager(Variable.class).txFindByProperty("name", "TMBRAND_GIFT");
				if(valbrand!=null&&valbrand.getValue()!=null&&valbrand.getValue().length()>0){
					//品牌编号-赠品编号-满额;品牌编号-赠品编号-满额;的格式
					String[] vs = valbrand.getValue().split(";");
					if(vs!=null&&vs.length>0){
						for(String vs123:vs){
							String[] vsdtl=vs123.split("-");
							float gfmn=0f;
							for(Order o:list){//订单明细
								if (o.getTitle().indexOf("邮费")>=0)continue;
								String outerSkuId = o.getOuterSkuId() ; //类似   01715909-XL(185) 这样的结构
								String productId = outerSkuId , sku1 = null;
								if(!Tools.isNull(outerSkuId)){
									if(outerSkuId.indexOf("-")>0){
										productId = outerSkuId.substring(0,outerSkuId.indexOf("-")).trim();//商品id
									}
								}else{
									productId = o.getOuterIid();
								}
								
								if(Tools.isNull(productId)){
									productId = o.getOuterIid();
								}
								
								productId = productId.replaceAll("[^0-9]*", "");
								Product p=(Product)Tools.getManager(Product.class).txGet(productId);

								if(p!=null&&p.getGdsmst_brand()!=null&&p.getGdsmst_brand().trim().equals(vsdtl[0])){//说明用户购买了单品赠品的商品
									gfmn+=Tools.parseFloat(o.getPayment());
								}
							}
							if(gfmn>=Tools.parseFloat(vsdtl[2])){
							Order o_gp = new Order();
							o_gp.setOuterIid(vsdtl[1]);
							o_gp.setPayment("0");
							o_gp.setNum(1L);//送一个
							list_ad.add(o_gp);
							}
						}
					}
				}
		
		boolean zf014=false;
		long tmallnum=0;
		if(list!=null&&list.size()>0){
			for(Order o:list){//创建订单明细
				if (o.getTitle().indexOf("邮费")>=0)continue;
				String outerSkuId = o.getOuterSkuId() ; //类似   01715909-XL(185) 这样的结构
				//tmallnum+=o.getNum().longValue();
				if(!Tools.isNull(outerSkuId)&&outerSkuId.startsWith("014")){
					zf014=true;
					break;
				}
			}
		}
		long giftmstid=668;
		/*if(!"b2".equals(from)){
			
			if("c".equals(from)){
				giftmstid=787;
			}else if("b2".equals(from)){
				giftmstid=0;
			}else if("b3".equals(from)){
				giftmstid=0;
			}
			if(!zf014&&giftmstid==668){
				giftmstid=0;
			}
			*/
		if(giftmstid==668){
		//加入“淘宝商城独有赠品”
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("giftrckdtl_mstid", new Long(giftmstid)));//这里是淘宝商城专用赠品组
		
		List<org.hibernate.criterion.Order> olist = new ArrayList<org.hibernate.criterion.Order>();
		olist.add(org.hibernate.criterion.Order.desc("giftrckdtl_limitmoney"));
		
		List<BaseEntity> resList = Tools.getManager(GiftItem.class).txGetList(clist,olist,0,1000);
		if(resList!=null&&resList.size()>0){
			Gift gf = (Gift)Tools.getManager(Gift.class).txGet(giftmstid+"");
			boolean hasAddGroupGift = false ;//是否加过组赠品，一个订单只加一个组下的赠品
			for(int i=0;i<resList.size();i++){
				GiftItem gi = (GiftItem)resList.get(i);
				if(gi.getGiftrckdtl_gdsid()!=null&&gi.getGiftrckdtl_gdsid().indexOf("-")>-1){//有-的表示是单品赠品，前面是商品id，后面是赠品id
					for(Order o:list){//订单明细
						if (o.getTitle().indexOf("邮费")>=0)continue;
						String outerSkuId = o.getOuterSkuId() ; //类似   01715909-XL(185) 这样的结构
						String productId = outerSkuId , sku1 = null;
						if(!Tools.isNull(outerSkuId)){
							if(outerSkuId.indexOf("-")>0){
								productId = outerSkuId.substring(0,outerSkuId.indexOf("-")).trim();//商品id
								sku1 = outerSkuId.substring(outerSkuId.indexOf("-")+1).trim() ;
							}
						}else{
							productId = o.getOuterIid();
						}
						
						if(Tools.isNull(productId)){
							productId = o.getOuterIid();
							sku1 = o.getSkuId();
						}
						
						productId = productId.replaceAll("[^0-9]*", "");
						if(productId.equals(gi.getGiftrckdtl_gdsid().substring(0,gi.getGiftrckdtl_gdsid().indexOf("-")))){//说明用户购买了单品赠品的商品
							Order o_gp = new Order();
							o_gp.setOuterIid(gi.getGiftrckdtl_gdsid().substring(gi.getGiftrckdtl_gdsid().indexOf("-")+1));
							o_gp.setPayment("0");
							o_gp.setNum(1L);//送一个
							list_ad.add(o_gp);
						}
					}
				}else{
					if(!hasAddGroupGift&&gi.getGiftrckdtl_limitmoney().floatValue()>0f&&new Float(trade.getPayment()).floatValue()>=gi.getGiftrckdtl_limitmoney().floatValue()){

						//金额满足条件，加入赠品
						Order o_gp = new Order();
						o_gp.setOuterIid(gi.getGiftrckdtl_gdsid());
						o_gp.setPayment("0");
						o_gp.setNum(1L);//送一个
						list_ad.add(o_gp);
					    if(gf.getGiftrckmst_selecttype().longValue()==0){
						   hasAddGroupGift = true ;
					      }
					}
				}
				if(gi.getGiftrckdtl_limitmoney().floatValue()==0f){
					//全场赠品每个订单都加
					Order o_gp = new Order();
					o_gp.setOuterIid(gi.getGiftrckdtl_gdsid());
					o_gp.setPayment("0");
					o_gp.setNum(new Long(1));//送一个
					list_ad.add(o_gp);
				}
			}
		}
		}
		//组商品折分成明细
		String grpgdsstr="";
		for(Order o:list){
			if (!Tools.isNull(o.getTitle())&&o.getTitle().indexOf("邮费")>=0)continue;
			String outerSkuId = o.getOuterSkuId() ; //类似   01715909-XL(185) 这样的结构
			String productId = outerSkuId , sku1 = null;
			float gdtlmoney=Tools.parseFloat(o.getTotalFee());
			if(!Tools.isNull(outerSkuId)){
				if(outerSkuId.indexOf("-")>0){
					productId = outerSkuId.substring(0,outerSkuId.indexOf("-")).trim();//商品id
					sku1 = outerSkuId.substring(outerSkuId.indexOf("-")+1).trim() ;
				}
			}else{
				productId = o.getOuterIid();
			}
			
			if(Tools.isNull(productId)){
				productId = o.getOuterIid();
				sku1 = o.getSkuId();
			}
			TmallGrp tmgrp=(TmallGrp)Tools.getManager(TmallGrp.class).txGet(productId);
			if(tmgrp!=null){
				String[] gs = tmgrp.getTmallgrp_items().split(",");
				String gsp="";
				float gspall=0f;
				for(int l=0;l<gs.length;l++){
					Product p=(Product)Tools.getManager(Product.class).txGet(gs[l].trim());
					if(p!=null){
						gsp=gsp+gs[l].trim()+"-"+p.getGdsmst_memberprice()+";";
								gspall=gspall+p.getGdsmst_memberprice().floatValue();
					}
				}
				if(!Tools.isNull(gsp)){
					grpgdsstr=grpgdsstr+productId+";";
					String[] gsparr = gsp.split(";");
					float dtlmall=0f;
					for(int j=0;j<gsparr.length;j++){
						String[] gspitemarr = gsparr[j].split("-");
						if(gspitemarr.length!=2)continue;
						Order o_gp = new Order();
						o_gp.setOuterIid(gspitemarr[0]);
						float dtlm= Tools.getFloat(gdtlmoney*(Tools.parseFloat(gspitemarr[1])/gspall),1);
						if(j==gsparr.length-1)dtlm=gdtlmoney-dtlmall;
						o_gp.setPayment(dtlm +"");
						o_gp.setTotalFee(dtlm +"");
						o_gp.setNum(o.getNum());//送一个
						o_gp.setTitle("tmallgrp:"+productId);
						list_ad.add(o_gp);
						dtlmall+=dtlm;
					}
				}
				
			}
		}
		
		//把全场赠品和单品赠品加入到Order列表里
		for(Order o:list_ad){
			list.add(o);
		}
		
		double giftmoney=0f;
		boolean flag = true ;
		int mzpcount=0;  //几件商品有赠品
		int mblzpcount=0;  //几件商品有赠品美宝莲
		if(list!=null&&flag){
			for(Order o:list){//创建订单明细
				if (!Tools.isNull(o.getTitle())&&o.getTitle().indexOf("邮费")>=0)continue;
				String outerSkuId = o.getOuterSkuId() ; //类似   01715909-XL(185) 这样的结构
				String productId = outerSkuId , sku1 = null;
				if(!Tools.isNull(outerSkuId)){
					if(outerSkuId.indexOf("-")>0){
						productId = outerSkuId.substring(0,outerSkuId.indexOf("-")).trim();//商品id
						sku1 = outerSkuId.substring(outerSkuId.indexOf("-")+1).trim() ;
					}
				}else{
					productId = o.getOuterIid();
				}
				
				if(Tools.isNull(productId)){
					productId = o.getOuterIid();
					sku1 = o.getSkuId();
				}
				if(!Tools.isNull(grpgdsstr)&&grpgdsstr.indexOf(productId)>=0)continue;
				OrderItemMain orderItem = new OrderItemMain();
				
				orderItem.setId(SequenceIdGenerator.generate("5"));
				orderItem.setOdrdtl_odrid(order.getId());//订单号
				
				
				if("c".equals(from)){
				if(outerSkuId!=null&&outerSkuId.endsWith("*")){
					orderItem.setOdrdtl_buyflag(new Long(99));
					outerSkuId=outerSkuId.replace("*", "");
				}
				}else{
					if(o.getPayment()==null||new Float(o.getPayment()).floatValue()==0){
					orderItem.setOdrdtl_buyflag(new Long(2));
					List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
					clist.add(Restrictions.eq("skumst_gdsid", productId));
					clist.add(Restrictions.eq("skumst_validflag", new Long(1)));
					List<org.hibernate.criterion.Order> olist = new ArrayList<org.hibernate.criterion.Order>();
					olist.add(org.hibernate.criterion.Order.desc("skumst_vstock"));
					List<BaseEntity> skulist = Tools.getManager(Sku.class).txGetList(clist,olist,0,1);
					if(skulist!=null&&skulist.size()>0){
						sku1=((Sku)skulist.get(0)).getSkumst_sku1();
					}
					}else{
					orderItem.setOdrdtl_buyflag(new Long(0));
					}
				}
				
				if(sku1==null){
					sku1="";
				}
				
				productId = productId.replaceAll("[^0-9]*", "");
				orderItem.setOdrdtl_gdsid(productId);//product id
				orderItem.setOdrdtl_sku1(sku1);
				orderItem.setOdrdtl_sku2("");//sku2  没用
		
				Product p = (Product)Tools.getManager(Product.class).txGet(productId);
				
				if(p==null){
					//System.out.println("d1商品"+productId+"不存在，同步订单忽略！");
					throw new Exception("同步订单失败，商品不存在！"+productId);
				}
				if(p.getGdsmst_brand()!=null&&p.getGdsmst_brand().equals("001169")){
					giftmoney+=new Double(o.getPayment()).doubleValue();
				}
				//if("01413016".equals(productId)){
				//	mzpcount=mzpcount+o.getNum().intValue();
				//}
				if("01424465".equals(productId)){
					mblzpcount=mblzpcount+o.getNum().intValue();
				}
				 orderItem.setOdrdtl_shopcode(p.getGdsmst_shopcode());
                 orderItem.setOdrdtl_oldodrid(order.getId());
				orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//商品名
				orderItem.setOdrdtl_memberprice(new Double(p.getGdsmst_memberprice()));//会员价
				orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//市场价
				orderItem.setOdrdtl_vipprice(new Double(p.getGdsmst_vipprice()));//vip 价
				
				if(o.getTotalFee()!=null&&new Float(o.getTotalFee()).floatValue()!=0)orderItem.setOdrdtl_finalprice(Tools.getDouble(new Float((new Float(o.getTotalFee()).floatValue())/o.getNum().longValue()),2));//最后成交单价
				else orderItem.setOdrdtl_finalprice(new Double(0));
				
				if(o.getTotalFee()!=null){
				orderItem.setOdrdtl_totalincomevalue(Tools.getDouble(new Float(o.getTotalFee()).floatValue(),2));//计算商户总收入 不用
				}else{
				orderItem.setOdrdtl_totalincomevalue(new Double(0));
				}
				orderItem.setOdrdtl_gdscount(o.getNum());//订购数量
				orderItem.setOdrdtl_purcount(o.getNum());
				if(o.getTotalFee()!=null&&new Float(o.getTotalFee()).floatValue()!=0){
				orderItem.setOdrdtl_totalmoney(Tools.getDouble(new Float(o.getTotalFee()).floatValue(),2));//成交总金额
				}else{
					orderItem.setOdrdtl_totalmoney(new Double(0));
				}
				orderItem.setOdrdtl_purprice(new Double(p.getGdsmst_inprice()));
				
				orderItem.setOdrdtl_downflag(new Long(1));
				
				Provider pv = (Provider)Tools.getManager(Provider.class).txFindByProperty("provide_shopcode", p.getGdsmst_provide());
				if(pv!=null){
					orderItem.setOdrdtl_puraddr(pv.getProvide_address());
					orderItem.setOdrdtl_purshopcode(pv.getProvide_shopcode());
				}
				
				
				orderItem.setOdrdtl_shipstatus(new Long(1));//发货状态，1为未发货
				orderItem.setOdrdtl_sendcount(o.getNum());//发货数量，最开始0
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
				//用于组商品ID
				if(o.getTitle()!=null&&o.getTitle().startsWith("tmallgrp:")){
					orderItem.setOdrdtl_stddetail9(o.getTitle().substring(9));
				}else{
				orderItem.setOdrdtl_stddetail9("");//商品没有stddetail9字段
				}
				
				orderItem.setOdrdtl_presellflag(new Long(0));//保留字段，无用
				orderItem.setOdrdtl_incometype(new Long(0));//保留字段，无用
				orderItem.setOdrdtl_incomevalue(new Double(0));//保留字段
				
				
				
				orderItem.setOdrdtl_eyuan(new Double(0));//商品应发E券 商品表取，价格不能打折送券的商品
				
				orderItem.setOdrdtl_spendcount(new Double(p.getGdsmst_spendcount()));//返用户积分
				
				orderItem.setOdrdtl_managememo("");//产品经理留言
				orderItem.setOdrdtl_gdspurmemo("");//采购备注 
				
				orderItem.setOdrdtl_specialflag(new Long(2));//0是什么都参与，1表示商品不能用券，2表示不参与联盟返利
				orderItem.setOdrdtl_gifttype("");//赠品类型 
				
				orderItem.setOdrdtl_refcount(new Long(1));//是否参加返Ｅ券活动，不参加为0，参与为1（目前没有用）
				orderItem.setOdrdtl_jcflag(new Long(0));//没有用
				
				
				
				orderItem.setOdrdtl_temp("淘宝商城");//商品活动标记，记录订单来源
				orderItem.setOdrdtl_tuancardno("");//商户兑换券号
				
				//创建订单明细
				Tools.getManager(OrderItemMain.class).txCreate(orderItem);
				
				//创建另外一条记录，用于占用虚拟库存
				CartItem ci = new CartItem();
				ci.setAmount(orderItem.getOdrdtl_gdscount());
				ci.setCreateDate(new Date());
				ci.setOrderId(order.getId());
				ci.setProductId(p.getId());
				ci.setSkuId(orderItem.getOdrdtl_sku1());
				ci.setUserId("1544012");
				Tools.getManager(CartItem.class).txCreate(ci);
			}
		}

		//插入一条记录，记录该订单已经同步过了
		OrderTaobao ot = new OrderTaobao();
		ot.setD1OrderId(order.getId());
		//System.out.println(order.getId()+"==========="+""+trade.getTid());
		ot.setTaobaoOrderId(""+trade.getTid());//淘宝订单号
		if("c".equals(from)){
			ot.setMbrid(new Long(2055832));//c店订单
		}else if("b2".equals(from)){
			ot.setMbrid(new Long(2055841));//b2订单
		}else if("b3".equals(from)){
			ot.setMbrid(new Long(3250586));//b3订单
		}else{
			ot.setMbrid(new Long(1544012));//用于淘宝商城下单的会员id
		}
		ot.setStatus(new Long(0));
		ot.setCreatedate(new Date());
		
		Tools.getManager(OrderTaobao.class).txCreate(ot);
		
		
		
		if(!"c".equals(from)&&!"b2".equals(from)&&!"b3".equals(from)){
			
	        String end="2015-06-01 00:00:00";
	       // if(df.parse(end).after(new Date())&&giftmoney>=120f){
	        if(df.parse(end).after(new Date())&&(mzpcount>=2||mblzpcount>=2)){
	        setzp(order.getId(),1,mzpcount,mblzpcount);
	        }
		}
		confirmGetMoney(order.getId(),-1);//修改订单为确认收款状态
		return order;
	}
	
	private void setzp(String orderid,int num,int mzpcount,int mblzpcount){
		
		//for(int i=0;i<num;i++){
			String gdsid="01418107";
			if(mblzpcount>=2)gdsid="01424842";
			String sku="";
		 
					Product p=(Product)Tools.getManager(Product.class).txGet(gdsid);
					
					//Sku sku=SkuHelper.getVirtualStock(productId, sku1)
					OrderItemMain orderItem = new OrderItemMain();
					
					orderItem.setId(SequenceIdGenerator.generate("5"));
					orderItem.setOdrdtl_odrid(orderid);//订单号
					
					orderItem.setOdrdtl_gdsid(gdsid);//product id
	
					//Random rndcard = new Random();
					
					//String[] arrsku={"保加利亚白玫瑰","冰沁活氧","玻尿酸保湿","草莓优格面膜","黑珍珠纳米","胶原蛋白","芦荟纳米","纳豆纳米面膜","苹果多酚","仙人掌","熊果素面膜","燕窝面膜","珍珠粉面膜"};
					//int arri=rndcard.nextInt(13);
					//sku=arrsku[arri];		
					
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
					
					orderItem.setOdrdtl_temp("淘宝商城");//商品活动标记，记录订单来源
					orderItem.setOdrdtl_tuancardno("");//商户兑换券号
					orderItem.setOdrdtl_oldodrid(orderid);
					//创建订单明细
					System.out.println("创建数据库订单明细："+orderItem.getId());
					Tools.getManager(OrderItemMain.class).txCreate(orderItem);
					
					//创建另外一条记录，用于占用虚拟库存
					CartItem ci = new CartItem();
					ci.setAmount(orderItem.getOdrdtl_gdscount());
					ci.setCreateDate(new Date());
					ci.setOrderId(orderid);
					ci.setProductId(p.getId());
					ci.setSkuId(orderItem.getOdrdtl_sku1());
					ci.setUserId("1544012");
					Tools.getManager(CartItem.class).txCreate(ci);
		//}
		
	}

	public void addzp(String orderid,int num,String gdsid,String sku){
		
		//for(int i=0;i<num;i++){
			
		 
					Product p=(Product)Tools.getManager(Product.class).txGet(gdsid);
					
					//Sku sku=SkuHelper.getVirtualStock(productId, sku1)
					OrderItemMain orderItem = new OrderItemMain();
					
					orderItem.setId(SequenceIdGenerator.generate("5"));
					orderItem.setOdrdtl_odrid(orderid);//订单号
					
					orderItem.setOdrdtl_gdsid(gdsid);//product id
	
					//Random rndcard = new Random();
					
					//String[] arrsku={"保加利亚白玫瑰","冰沁活氧","玻尿酸保湿","草莓优格面膜","黑珍珠纳米","胶原蛋白","芦荟纳米","纳豆纳米面膜","苹果多酚","仙人掌","熊果素面膜","燕窝面膜","珍珠粉面膜"};
					//int arri=rndcard.nextInt(13);
					//sku=arrsku[arri];		
					
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
					
					orderItem.setOdrdtl_temp("淘宝商城");//商品活动标记，记录订单来源
					orderItem.setOdrdtl_tuancardno("");//商户兑换券号
					orderItem.setOdrdtl_oldodrid(orderid);
					//创建订单明细
					System.out.println("创建数据库订单明细："+orderItem.getId());
					Tools.getManager(OrderItemMain.class).txCreate(orderItem);
					
					//创建另外一条记录，用于占用虚拟库存
					CartItem ci = new CartItem();
					ci.setAmount(orderItem.getOdrdtl_gdscount());
					ci.setCreateDate(new Date());
					ci.setOrderId(orderid);
					ci.setProductId(p.getId());
					ci.setSkuId(orderItem.getOdrdtl_sku1());
					ci.setUserId("1544012");
					Tools.getManager(CartItem.class).txCreate(ci);
		//}
		
	}
	
	/**
	 * 订单确认收款，如果是淘宝商城的订单还要同步虚拟库存 。orderId必须存在！
	 * @param orderId 订单id
	 * @param getmoney 收到多少钱，大于0才有效，小于0不修改。货到付款填0，支付宝支付填实际数
	 * @return true 操作成功， false表示没有操作，可能是订单id不存在
	 * @throws Exception
	 */
	public synchronized boolean confirmGetMoney(String orderId,float getmoney)throws Exception{
		OrderCache order1 = (OrderCache)Tools.getManager(OrderCache.class).txGet(orderId);
		if(order1!=null){//存在于订单缓存表中
			if(order1.getOdrmst_orderstatus()!=null&&order1.getOdrmst_orderstatus().longValue()==0){
				/*Tools.getManager(OrderCache.class).txBeforeUpdate(order1);
				order1.setOdrmst_ourmemo(order1.getOdrmst_ourmemo()+ new Date()+"支付系统自动收款");
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
		}else{
			OrderMain order2 = (OrderMain)Tools.getManager(OrderMain.class).txGet(orderId);
			if(order2!=null){//存在于订单主表中
				if(order2.getOdrmst_orderstatus()!=null&&order2.getOdrmst_orderstatus().longValue()==0){
					/*Tools.getManager(OrderMain.class).txBeforeUpdate(order2);
					order2.setOdrmst_ourmemo(order2.getOdrmst_ourmemo()+ new Date()+"支付系统自动收款");
					if(getmoney>0)order2.setOdrmst_getmoney(new Double(getmoney));
					order2.setOdrmst_validdate(new Date());
					order2.setOdrmst_orderstatus(new Long(2));//确认收款状态
					Tools.getManager(OrderMain.class).txUpdate(order2, true);
					
					//调用存储过程把订单修改成“确认收款”状态
					ProcedureWork work = new ProcedureWork(orderId);
					Tools.getManager(OrderMain.class).currentSession().doWork(work);//执行work
					
					return true ;*/
					int ret=updateOrderStatus2013(order2,getmoney);
					if (ret==1){
					updateOrderStatuswork(order2);
					return true ;
					}
				}
			}
		}
		
		return false ;
	}
	
	
	public int updateOrderStatus2013(OrderBase order , double dblAmount){
		if(order == null) return -1;
		//锁用户订单。如果用memcached做数据库缓存，这块要修改成分布式锁或数据库锁！！！

			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return -2;
			//精确到角
			Tools.getManager(order.getClass()).txBeforeUpdate(order);
			if(dblAmount>0)order.setOdrmst_getmoney(new Double(dblAmount));
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(new Date()) +"支付系统自动收款");
			order.setOdrmst_validdate(new Date());
			order.setOdrmst_orderstatus(new Long(2));
			order.setOdrmst_realstatus(new Long(1));
			order.setOdrmst_realgettime(new Date());
			Tools.getManager(order.getClass()).txUpdate(order, true);
			
			if(Tools.longValue(order.getOdrmst_orderstatus()) == 0) return -4;
			return 1;
	}
	
	public int updateOrderStatuswork(OrderBase order){

		if(order == null) return -1;
		//锁用户订单。如果用memcached做数据库缓存，这块要修改成分布式锁或数据库锁！！！
	
			
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
