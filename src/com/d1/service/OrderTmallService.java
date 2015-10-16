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
 * �Ա��̳Ƕ���ͬ������������Service����
 * @author kk
 *
 */
public class OrderTmallService {
	
	/**
	 * �����Ա��̳�ȡ����Trade���󴴽����ף����Ա��У�Trade����һ�����ף�Order��һ��������ϸ
	 * @param trade
	 * @param buyer_message �������
	 * @param sex �Ա�
	 * @param buyer ��Ҷ���com.taobao.api.domain.User����
	 * @param sellor_memo ���ұ�ע
	 * @param from ��Դ �̳ǻ���C��
	 * @return OrderMain
	 */
	public OrderMain createOrderFromTmall(Trade trade,String buyer_message,String sex,com.taobao.api.domain.User buyer,String sellor_memo,String from) throws Exception {
		if(Tools.getManager(OrderTaobao.class).txFindByProperty("taobaoOrderId", ""+trade.getTid())!=null){
			//�Ѿ�ͬ������
			//System.out.println(trade.getTid()+"�������Ѿ�ͬ���������ԣ�");
			return null ;
		}
		SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		OrderMain order = new OrderMain();
		
		System.out.println("��ʼͬ���Ա��������Ա�����id="+trade.getTid());
		
		String rphone="";
		if(!Tools.isNull(trade.getReceiverMobile())){
			rphone=trade.getReceiverMobile();
		}
		if(!Tools.isNull(trade.getReceiverPhone())){
			rphone=rphone+";"+trade.getReceiverPhone();
		}

		order.setId(OrderIdGenerator.generate());//order id��ͨ��һ��sequence������
		order.setOdrmst_id(new Long(SequenceIdGenerator.generate("4")));
		
		if("c".equals(from)){
			order.setOdrmst_mbrid(new Long(2055832));//c�궩��
		}else if("b2".equals(from)){
			order.setOdrmst_mbrid(new Long(2055841));//b2����
		}else if("b3".equals(from)){
			order.setOdrmst_mbrid(new Long(3250586));//b3����
		}else{
			order.setOdrmst_mbrid(new Long(1544012));//�����Ա��̳��µ��Ļ�Աid
		}
		//��ѯ�Ƿ���ͬһ���û��¶൥������Ƕ൥���Ժϲ�����
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
		
		order.setOdrmst_rname(rname23123);//�ջ������� 
		order.setOdrmst_orderdate(new Date());//��������
		order.setOdrmst_rsex(sex);
		order.setOdrmst_payid(new Long(20));//֧����֧��
		order.setOdrmst_paymethod("֧����֧��");
		order.setOdrmst_paytype(new Long(4));//֧����֧����type
		order.setOdrmst_rzipcode(trade.getReceiverZip());//�ջ����ʱ�
		order.setOdrmst_raddress(trade.getReceiverAddress());//�ջ��˵�ַ
		
		
		order.setOdrmst_rphone(rphone);//�ջ��˵绰���ֻ�
		order.setOdrmst_remail("");//�ջ���email
		order.setOdrmst_rcountry("�й�");//����
		order.setOdrmst_rprovince(trade.getReceiverState());//�ջ���ʡ
		order.setOdrmst_rcity(trade.getReceiverCity()+" "+trade.getReceiverDistrict());//�ջ��˳���
		
		order.setOdrmst_shipid(new Long(10));//�������
		order.setOdrmst_shipmethod("�������");
		
		order.setOdrmst_pzipcode("");//�����������Ϣ
		order.setOdrmst_paddress("");//�����������Ϣ
		order.setOdrmst_pcountry("�й�");//�����������Ϣ
		order.setOdrmst_pprovince("");//�����������Ϣ
		order.setOdrmst_pcity("");//�����������Ϣ
		order.setOdrmst_pophone("");//�����������Ϣ
		order.setOdrmst_phphone("");//�����������Ϣ
		order.setOdrmst_pmphone("");//�����������Ϣ 
		order.setOdrmst_pusephone("");//�����������Ϣ 
		order.setOdrmst_pbp(""+trade.getTid());//�����������Ϣ---�ĳ���è������
		order.setOdrmst_pemail("");//�����������Ϣ

		order.setOdrmst_linkodrid(linkodrstr);
		order.setOdrmst_pname(trade.getBuyerNick());//�����������Ϣ����Ӧǰ���id
		
		order.setOdrmst_psex(sex);
		order.setOdrmst_oldodrid(order.getId());//���ڲ�����𵥶���
		if(buyer_message==null)buyer_message="";
		
		order.setOdrmst_orderstatus(new Long(0));//����״̬
		order.setOdrmst_specialtype(new Long(0));

		if(trade.getPostFee()!=null)order.setOdrmst_shipfee(Tools.getDouble(new Float(trade.getPostFee()),2));//�����˷�
		if(trade.getPayment()!=null)order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(trade.getPayment()),2));//ʵ��֧�����
		
		float postfee = 0f;
		if(trade.getPostFee()!=null)postfee = Tools.getFloat(new Float(trade.getPostFee()).floatValue(),2);
		
		if(trade.getPayment()!=null)order.setOdrmst_gdsmoney(Tools.getDouble(new Float(new Float(trade.getPayment()).floatValue()-postfee),2));//�ܼ�-�˷�
		
		if(trade.getPayment()!=null)order.setOdrmst_ordermoney(Tools.getDouble(new Float(new Float(trade.getPayment()).floatValue()),2));//
		if(trade.getPayment()!=null)order.setOdrmst_getmoney(Tools.getDouble(new Float(trade.getPayment()),2));//�յ�����Ǯ
		order.setOdrmst_realgetmoney(Tools.getDouble(new Float(trade.getPayment()),2));//֧�����Ѿ����ˣ���
		order.setOdrmst_prepayvalue(new Double(0));
		order.setOdrmst_temp("�Ա��̳�");//������Դ

		if(trade.getDiscountFee()!=null){
			order.setOdrmst_tktvalue(Tools.getDouble(new Float(new Float(trade.getDiscountFee()).floatValue()),2));
		}else{
		order.setOdrmst_tktvalue(new Double(0));//Eȯ���
		}
		order.setOdrmst_tktid(new Long(0));//Eȯ��ţ���Ӧtktmst.id
		
		order.setOdrmst_odrqus("");
		String memo="";
		String message="";
		if(!Tools.isNull(sellor_memo)){
			memo="���ұ�ע��"+sellor_memo+"<br/>";
		}
		if(!Tools.isNull(buyer_message)){
			message="������ԣ�"+buyer_message;
		}

		order.setOdrmst_ourmemo(memo+message);//���ұ�ע
		order.setOdrmst_customerword("[�ͻ�ʱ��:ÿ������ͻ� �����ǰ��ϵ,����ǩ�� �뵱������������ױƷ���ղ��ɲ��Ʒ��װ��]<br><span style=\"color:#FF0000\">"+message+"</span>");//�ͻ�ʱ��+�������
		order.setOdrmst_internalmemo("[�����ǰ��ϵ,����ǩ�� �뵱������������ױƷ���ղ��ɲ��Ʒ��װ��]<br><span style=\"color:#FF0000\">"+message+"</span><br/><font color=red><b>"+memo+"</b></font>");
		
		Tools.getManager(OrderMain.class).txCreate(order);
		
		
		OrderShopMain orderShopMain = new OrderShopMain();
		orderShopMain.setOdrshp_odrid(order.getId());
		orderShopMain.setOdrshp_shopcode("08102301");
		orderShopMain.setOdrshp_sndshopcode("00000000");//d1����ȫ�����
		orderShopMain.setOdrshp_orderdate(new Date());
		orderShopMain.setOdrshp_shopname("D1���������з���");
		orderShopMain.setOdrshp_country("�й�");
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
		
		Tools.getManager(OrderShopMain.class).txCreate(orderShopMain);//����odrshp��¼�������¼û���ã�����̨�й�����ѯ�����Ա��봴��
		
		List<Order> list = trade.getOrders();
		
		float post_dtl = 0f ;
		
		if(list!=null&&list.size()==1)post_dtl = postfee ;//�Ա����������������ֻ��һ��Order�������˷�
		
		ArrayList<Order> list_ad = new ArrayList<Order>();
	
		//���롰�Ա��̳ǵ�Ʒ��Ʒ������ʲô��ʲô
		Variable val = (Variable)Tools.getManager(Variable.class).txFindByProperty("name", "TMALL_GIFT");
		if(val!=null&&val.getValue()!=null&&val.getValue().length()>0){
			//234834-247237;8234824-4767345;�ĸ�ʽ
			String[] vs = val.getValue().split(";");
			if(vs!=null&&vs.length>0){
				for(String vs123:vs){
					for(Order o:list){//������ϸ
						if (o.getTitle().indexOf("�ʷ�")>=0)continue;
						String outerSkuId = o.getOuterSkuId() ; //����   01715909-XL(185) �����Ľṹ
						long ocount=o.getNum().longValue();
						
						String productId = outerSkuId , sku1 = null;
						if(!Tools.isNull(outerSkuId)){
							if(outerSkuId.indexOf("-")>0){
								productId = outerSkuId.substring(0,outerSkuId.indexOf("-")).trim();//��Ʒid
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
						if(productId.equals(vs123.substring(0,vs123.indexOf("-")))){//˵���û������˵�Ʒ��Ʒ����Ʒ
							Order o_gp = new Order();
							o_gp.setOuterIid(vs123.substring(vs123.indexOf("-")+1));
							o_gp.setPayment("0");
							o_gp.setNum(new Long(ocount));//��һ��
							list_ad.add(o_gp);
						}
					}
				}
			}
		}
		
		//Ʒ����Ʒ
				Variable valbrand = (Variable)Tools.getManager(Variable.class).txFindByProperty("name", "TMBRAND_GIFT");
				if(valbrand!=null&&valbrand.getValue()!=null&&valbrand.getValue().length()>0){
					//Ʒ�Ʊ��-��Ʒ���-����;Ʒ�Ʊ��-��Ʒ���-����;�ĸ�ʽ
					String[] vs = valbrand.getValue().split(";");
					if(vs!=null&&vs.length>0){
						for(String vs123:vs){
							String[] vsdtl=vs123.split("-");
							float gfmn=0f;
							for(Order o:list){//������ϸ
								if (o.getTitle().indexOf("�ʷ�")>=0)continue;
								String outerSkuId = o.getOuterSkuId() ; //����   01715909-XL(185) �����Ľṹ
								String productId = outerSkuId , sku1 = null;
								if(!Tools.isNull(outerSkuId)){
									if(outerSkuId.indexOf("-")>0){
										productId = outerSkuId.substring(0,outerSkuId.indexOf("-")).trim();//��Ʒid
									}
								}else{
									productId = o.getOuterIid();
								}
								
								if(Tools.isNull(productId)){
									productId = o.getOuterIid();
								}
								
								productId = productId.replaceAll("[^0-9]*", "");
								Product p=(Product)Tools.getManager(Product.class).txGet(productId);

								if(p!=null&&p.getGdsmst_brand()!=null&&p.getGdsmst_brand().trim().equals(vsdtl[0])){//˵���û������˵�Ʒ��Ʒ����Ʒ
									gfmn+=Tools.parseFloat(o.getPayment());
								}
							}
							if(gfmn>=Tools.parseFloat(vsdtl[2])){
							Order o_gp = new Order();
							o_gp.setOuterIid(vsdtl[1]);
							o_gp.setPayment("0");
							o_gp.setNum(1L);//��һ��
							list_ad.add(o_gp);
							}
						}
					}
				}
		
		boolean zf014=false;
		long tmallnum=0;
		if(list!=null&&list.size()>0){
			for(Order o:list){//����������ϸ
				if (o.getTitle().indexOf("�ʷ�")>=0)continue;
				String outerSkuId = o.getOuterSkuId() ; //����   01715909-XL(185) �����Ľṹ
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
		//���롰�Ա��̳Ƕ�����Ʒ��
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("giftrckdtl_mstid", new Long(giftmstid)));//�������Ա��̳�ר����Ʒ��
		
		List<org.hibernate.criterion.Order> olist = new ArrayList<org.hibernate.criterion.Order>();
		olist.add(org.hibernate.criterion.Order.desc("giftrckdtl_limitmoney"));
		
		List<BaseEntity> resList = Tools.getManager(GiftItem.class).txGetList(clist,olist,0,1000);
		if(resList!=null&&resList.size()>0){
			Gift gf = (Gift)Tools.getManager(Gift.class).txGet(giftmstid+"");
			boolean hasAddGroupGift = false ;//�Ƿ�ӹ�����Ʒ��һ������ֻ��һ�����µ���Ʒ
			for(int i=0;i<resList.size();i++){
				GiftItem gi = (GiftItem)resList.get(i);
				if(gi.getGiftrckdtl_gdsid()!=null&&gi.getGiftrckdtl_gdsid().indexOf("-")>-1){//��-�ı�ʾ�ǵ�Ʒ��Ʒ��ǰ������Ʒid����������Ʒid
					for(Order o:list){//������ϸ
						if (o.getTitle().indexOf("�ʷ�")>=0)continue;
						String outerSkuId = o.getOuterSkuId() ; //����   01715909-XL(185) �����Ľṹ
						String productId = outerSkuId , sku1 = null;
						if(!Tools.isNull(outerSkuId)){
							if(outerSkuId.indexOf("-")>0){
								productId = outerSkuId.substring(0,outerSkuId.indexOf("-")).trim();//��Ʒid
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
						if(productId.equals(gi.getGiftrckdtl_gdsid().substring(0,gi.getGiftrckdtl_gdsid().indexOf("-")))){//˵���û������˵�Ʒ��Ʒ����Ʒ
							Order o_gp = new Order();
							o_gp.setOuterIid(gi.getGiftrckdtl_gdsid().substring(gi.getGiftrckdtl_gdsid().indexOf("-")+1));
							o_gp.setPayment("0");
							o_gp.setNum(1L);//��һ��
							list_ad.add(o_gp);
						}
					}
				}else{
					if(!hasAddGroupGift&&gi.getGiftrckdtl_limitmoney().floatValue()>0f&&new Float(trade.getPayment()).floatValue()>=gi.getGiftrckdtl_limitmoney().floatValue()){

						//�������������������Ʒ
						Order o_gp = new Order();
						o_gp.setOuterIid(gi.getGiftrckdtl_gdsid());
						o_gp.setPayment("0");
						o_gp.setNum(1L);//��һ��
						list_ad.add(o_gp);
					    if(gf.getGiftrckmst_selecttype().longValue()==0){
						   hasAddGroupGift = true ;
					      }
					}
				}
				if(gi.getGiftrckdtl_limitmoney().floatValue()==0f){
					//ȫ����Ʒÿ����������
					Order o_gp = new Order();
					o_gp.setOuterIid(gi.getGiftrckdtl_gdsid());
					o_gp.setPayment("0");
					o_gp.setNum(new Long(1));//��һ��
					list_ad.add(o_gp);
				}
			}
		}
		}
		//����Ʒ�۷ֳ���ϸ
		String grpgdsstr="";
		for(Order o:list){
			if (!Tools.isNull(o.getTitle())&&o.getTitle().indexOf("�ʷ�")>=0)continue;
			String outerSkuId = o.getOuterSkuId() ; //����   01715909-XL(185) �����Ľṹ
			String productId = outerSkuId , sku1 = null;
			float gdtlmoney=Tools.parseFloat(o.getTotalFee());
			if(!Tools.isNull(outerSkuId)){
				if(outerSkuId.indexOf("-")>0){
					productId = outerSkuId.substring(0,outerSkuId.indexOf("-")).trim();//��Ʒid
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
						o_gp.setNum(o.getNum());//��һ��
						o_gp.setTitle("tmallgrp:"+productId);
						list_ad.add(o_gp);
						dtlmall+=dtlm;
					}
				}
				
			}
		}
		
		//��ȫ����Ʒ�͵�Ʒ��Ʒ���뵽Order�б���
		for(Order o:list_ad){
			list.add(o);
		}
		
		double giftmoney=0f;
		boolean flag = true ;
		int mzpcount=0;  //������Ʒ����Ʒ
		int mblzpcount=0;  //������Ʒ����Ʒ������
		if(list!=null&&flag){
			for(Order o:list){//����������ϸ
				if (!Tools.isNull(o.getTitle())&&o.getTitle().indexOf("�ʷ�")>=0)continue;
				String outerSkuId = o.getOuterSkuId() ; //����   01715909-XL(185) �����Ľṹ
				String productId = outerSkuId , sku1 = null;
				if(!Tools.isNull(outerSkuId)){
					if(outerSkuId.indexOf("-")>0){
						productId = outerSkuId.substring(0,outerSkuId.indexOf("-")).trim();//��Ʒid
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
				orderItem.setOdrdtl_odrid(order.getId());//������
				
				
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
				orderItem.setOdrdtl_sku2("");//sku2  û��
		
				Product p = (Product)Tools.getManager(Product.class).txGet(productId);
				
				if(p==null){
					//System.out.println("d1��Ʒ"+productId+"�����ڣ�ͬ���������ԣ�");
					throw new Exception("ͬ������ʧ�ܣ���Ʒ�����ڣ�"+productId);
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
				orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//��Ʒ��
				orderItem.setOdrdtl_memberprice(new Double(p.getGdsmst_memberprice()));//��Ա��
				orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//�г���
				orderItem.setOdrdtl_vipprice(new Double(p.getGdsmst_vipprice()));//vip ��
				
				if(o.getTotalFee()!=null&&new Float(o.getTotalFee()).floatValue()!=0)orderItem.setOdrdtl_finalprice(Tools.getDouble(new Float((new Float(o.getTotalFee()).floatValue())/o.getNum().longValue()),2));//���ɽ�����
				else orderItem.setOdrdtl_finalprice(new Double(0));
				
				if(o.getTotalFee()!=null){
				orderItem.setOdrdtl_totalincomevalue(Tools.getDouble(new Float(o.getTotalFee()).floatValue(),2));//�����̻������� ����
				}else{
				orderItem.setOdrdtl_totalincomevalue(new Double(0));
				}
				orderItem.setOdrdtl_gdscount(o.getNum());//��������
				orderItem.setOdrdtl_purcount(o.getNum());
				if(o.getTotalFee()!=null&&new Float(o.getTotalFee()).floatValue()!=0){
				orderItem.setOdrdtl_totalmoney(Tools.getDouble(new Float(o.getTotalFee()).floatValue(),2));//�ɽ��ܽ��
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
				
				
				orderItem.setOdrdtl_shipstatus(new Long(1));//����״̬��1Ϊδ����
				orderItem.setOdrdtl_sendcount(o.getNum());//�����������ʼ0
				orderItem.setOdrdtl_creatdate(new Date());//��������
				orderItem.setOdrdtl_refundcount(new Long(0));//û����������
				orderItem.setOdrdtl_rackcode(p.getGdsmst_rackcode());
				
				orderItem.setOdrdtl_stddetail1(p.getGdsmst_stdvalue1());//����Ʒ��ȡ
				orderItem.setOdrdtl_stddetail2(p.getGdsmst_stdvalue2());
				orderItem.setOdrdtl_stddetail3(p.getGdsmst_stdvalue3());
				orderItem.setOdrdtl_stddetail4(p.getGdsmst_stdvalue4());
				orderItem.setOdrdtl_stddetail5(p.getGdsmst_stdvalue5());
				orderItem.setOdrdtl_stddetail6(p.getGdsmst_stdvalue6());
				orderItem.setOdrdtl_stddetail7(p.getGdsmst_stdvalue7());
				orderItem.setOdrdtl_stddetail8(p.getGdsmst_stdvalue8());
				//��������ƷID
				if(o.getTitle()!=null&&o.getTitle().startsWith("tmallgrp:")){
					orderItem.setOdrdtl_stddetail9(o.getTitle().substring(9));
				}else{
				orderItem.setOdrdtl_stddetail9("");//��Ʒû��stddetail9�ֶ�
				}
				
				orderItem.setOdrdtl_presellflag(new Long(0));//�����ֶΣ�����
				orderItem.setOdrdtl_incometype(new Long(0));//�����ֶΣ�����
				orderItem.setOdrdtl_incomevalue(new Double(0));//�����ֶ�
				
				
				
				orderItem.setOdrdtl_eyuan(new Double(0));//��ƷӦ��Eȯ ��Ʒ��ȡ���۸��ܴ�����ȯ����Ʒ
				
				orderItem.setOdrdtl_spendcount(new Double(p.getGdsmst_spendcount()));//���û�����
				
				orderItem.setOdrdtl_managememo("");//��Ʒ��������
				orderItem.setOdrdtl_gdspurmemo("");//�ɹ���ע 
				
				orderItem.setOdrdtl_specialflag(new Long(2));//0��ʲô�����룬1��ʾ��Ʒ������ȯ��2��ʾ���������˷���
				orderItem.setOdrdtl_gifttype("");//��Ʒ���� 
				
				orderItem.setOdrdtl_refcount(new Long(1));//�Ƿ�μӷ���ȯ������μ�Ϊ0������Ϊ1��Ŀǰû���ã�
				orderItem.setOdrdtl_jcflag(new Long(0));//û����
				
				
				
				orderItem.setOdrdtl_temp("�Ա��̳�");//��Ʒ���ǣ���¼������Դ
				orderItem.setOdrdtl_tuancardno("");//�̻��һ�ȯ��
				
				//����������ϸ
				Tools.getManager(OrderItemMain.class).txCreate(orderItem);
				
				//��������һ����¼������ռ��������
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

		//����һ����¼����¼�ö����Ѿ�ͬ������
		OrderTaobao ot = new OrderTaobao();
		ot.setD1OrderId(order.getId());
		//System.out.println(order.getId()+"==========="+""+trade.getTid());
		ot.setTaobaoOrderId(""+trade.getTid());//�Ա�������
		if("c".equals(from)){
			ot.setMbrid(new Long(2055832));//c�궩��
		}else if("b2".equals(from)){
			ot.setMbrid(new Long(2055841));//b2����
		}else if("b3".equals(from)){
			ot.setMbrid(new Long(3250586));//b3����
		}else{
			ot.setMbrid(new Long(1544012));//�����Ա��̳��µ��Ļ�Աid
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
		confirmGetMoney(order.getId(),-1);//�޸Ķ���Ϊȷ���տ�״̬
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
					orderItem.setOdrdtl_odrid(orderid);//������
					
					orderItem.setOdrdtl_gdsid(gdsid);//product id
	
					//Random rndcard = new Random();
					
					//String[] arrsku={"�������ǰ�õ��","���߻���","�����ᱣʪ","��ݮ�Ÿ���Ĥ","����������","��ԭ����","«������","�ɶ�������Ĥ","ƻ�����","������","�ܹ�����Ĥ","������Ĥ","�������Ĥ"};
					//int arri=rndcard.nextInt(13);
					//sku=arrsku[arri];		
					
					orderItem.setOdrdtl_sku1(sku);
					orderItem.setOdrdtl_sku2("");//sku2  û��
				
					orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//��Ʒ��
					orderItem.setOdrdtl_memberprice(new Double(p.getGdsmst_memberprice()));//��Ա��
					orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//�г���
					orderItem.setOdrdtl_vipprice(new Double(p.getGdsmst_vipprice()));//vip ��
					
					orderItem.setOdrdtl_finalprice(new Double(0));//���ɽ�����
					
					orderItem.setOdrdtl_gdscount(new Long(1));//��������
					
					
					orderItem.setOdrdtl_totalmoney(new Double(0));//�ɽ��ܽ��
					orderItem.setOdrdtl_purprice(new Double(p.getGdsmst_inprice()));
		
					orderItem.setOdrdtl_shipstatus(new Long(1));//����״̬��1Ϊδ����
					orderItem.setOdrdtl_sendcount(new Long(1));//�����������ʼ0
					orderItem.setOdrdtl_creatdate(new Date());//��������
					orderItem.setOdrdtl_refundcount(new Long(0));//û����������
					orderItem.setOdrdtl_rackcode(p.getGdsmst_rackcode());
					
					orderItem.setOdrdtl_stddetail1(p.getGdsmst_stdvalue1());//����Ʒ��ȡ
					orderItem.setOdrdtl_stddetail2(p.getGdsmst_stdvalue2());
					orderItem.setOdrdtl_stddetail3(p.getGdsmst_stdvalue3());
					orderItem.setOdrdtl_stddetail4(p.getGdsmst_stdvalue4());
					orderItem.setOdrdtl_stddetail5(p.getGdsmst_stdvalue5());
					orderItem.setOdrdtl_stddetail6(p.getGdsmst_stdvalue6());
					orderItem.setOdrdtl_stddetail7(p.getGdsmst_stdvalue7());
					orderItem.setOdrdtl_stddetail8(p.getGdsmst_stdvalue8());
					
					orderItem.setOdrdtl_stddetail9("");//��Ʒû��stddetail9�ֶ�
					
					orderItem.setOdrdtl_presellflag(new Long(0));//�����ֶΣ�����
					orderItem.setOdrdtl_incometype(new Long(0));//�����ֶΣ�����
					orderItem.setOdrdtl_incomevalue(new Double(0));//�����ֶ�
					orderItem.setOdrdtl_buyflag(new Long(2));    //��Ʒ��ʶ��������ƷΪ0 ��ƷΪ2
					orderItem.setOdrdtl_totalincomevalue(new Double(0));//�����̻������� ����
					orderItem.setOdrdtl_eyuan(new Double(p.getGdsmst_eyuan()));//��ƷӦ��Eȯ ��Ʒ��ȡ���۸��ܴ�����ȯ����Ʒ
					
					orderItem.setOdrdtl_spendcount(new Double(0));//���û�����
					
					orderItem.setOdrdtl_managememo("");//��Ʒ��������
					orderItem.setOdrdtl_gdspurmemo("");//�ɹ���ע 
					
					orderItem.setOdrdtl_specialflag(new Long(2));//0��ʲô�����룬1��ʾ��Ʒ������ȯ��2��ʾ���������˷���
					orderItem.setOdrdtl_gifttype("");//��Ʒ���� 
					
					orderItem.setOdrdtl_refcount(new Long(1));//�Ƿ�μӷ���ȯ������μ�Ϊ0������Ϊ1��Ŀǰû���ã�
					orderItem.setOdrdtl_jcflag(new Long(0));//û����
					
					orderItem.setOdrdtl_temp("�Ա��̳�");//��Ʒ���ǣ���¼������Դ
					orderItem.setOdrdtl_tuancardno("");//�̻��һ�ȯ��
					orderItem.setOdrdtl_oldodrid(orderid);
					//����������ϸ
					System.out.println("�������ݿⶩ����ϸ��"+orderItem.getId());
					Tools.getManager(OrderItemMain.class).txCreate(orderItem);
					
					//��������һ����¼������ռ��������
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
					orderItem.setOdrdtl_odrid(orderid);//������
					
					orderItem.setOdrdtl_gdsid(gdsid);//product id
	
					//Random rndcard = new Random();
					
					//String[] arrsku={"�������ǰ�õ��","���߻���","�����ᱣʪ","��ݮ�Ÿ���Ĥ","����������","��ԭ����","«������","�ɶ�������Ĥ","ƻ�����","������","�ܹ�����Ĥ","������Ĥ","�������Ĥ"};
					//int arri=rndcard.nextInt(13);
					//sku=arrsku[arri];		
					
					orderItem.setOdrdtl_sku1(sku);
					orderItem.setOdrdtl_sku2("");//sku2  û��
				
					orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//��Ʒ��
					orderItem.setOdrdtl_memberprice(new Double(p.getGdsmst_memberprice()));//��Ա��
					orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//�г���
					orderItem.setOdrdtl_vipprice(new Double(p.getGdsmst_vipprice()));//vip ��
					
					orderItem.setOdrdtl_finalprice(new Double(0));//���ɽ�����
					
					orderItem.setOdrdtl_gdscount(new Long(1));//��������
					
					
					orderItem.setOdrdtl_totalmoney(new Double(0));//�ɽ��ܽ��
					orderItem.setOdrdtl_purprice(new Double(p.getGdsmst_inprice()));
		
					orderItem.setOdrdtl_shipstatus(new Long(1));//����״̬��1Ϊδ����
					orderItem.setOdrdtl_sendcount(new Long(1));//�����������ʼ0
					orderItem.setOdrdtl_creatdate(new Date());//��������
					orderItem.setOdrdtl_refundcount(new Long(0));//û����������
					orderItem.setOdrdtl_rackcode(p.getGdsmst_rackcode());
					
					orderItem.setOdrdtl_stddetail1(p.getGdsmst_stdvalue1());//����Ʒ��ȡ
					orderItem.setOdrdtl_stddetail2(p.getGdsmst_stdvalue2());
					orderItem.setOdrdtl_stddetail3(p.getGdsmst_stdvalue3());
					orderItem.setOdrdtl_stddetail4(p.getGdsmst_stdvalue4());
					orderItem.setOdrdtl_stddetail5(p.getGdsmst_stdvalue5());
					orderItem.setOdrdtl_stddetail6(p.getGdsmst_stdvalue6());
					orderItem.setOdrdtl_stddetail7(p.getGdsmst_stdvalue7());
					orderItem.setOdrdtl_stddetail8(p.getGdsmst_stdvalue8());
					
					orderItem.setOdrdtl_stddetail9("");//��Ʒû��stddetail9�ֶ�
					
					orderItem.setOdrdtl_presellflag(new Long(0));//�����ֶΣ�����
					orderItem.setOdrdtl_incometype(new Long(0));//�����ֶΣ�����
					orderItem.setOdrdtl_incomevalue(new Double(0));//�����ֶ�
					orderItem.setOdrdtl_buyflag(new Long(2));    //��Ʒ��ʶ��������ƷΪ0 ��ƷΪ2
					orderItem.setOdrdtl_totalincomevalue(new Double(0));//�����̻������� ����
					orderItem.setOdrdtl_eyuan(new Double(p.getGdsmst_eyuan()));//��ƷӦ��Eȯ ��Ʒ��ȡ���۸��ܴ�����ȯ����Ʒ
					
					orderItem.setOdrdtl_spendcount(new Double(0));//���û�����
					
					orderItem.setOdrdtl_managememo("");//��Ʒ��������
					orderItem.setOdrdtl_gdspurmemo("");//�ɹ���ע 
					
					orderItem.setOdrdtl_specialflag(new Long(2));//0��ʲô�����룬1��ʾ��Ʒ������ȯ��2��ʾ���������˷���
					orderItem.setOdrdtl_gifttype("");//��Ʒ���� 
					
					orderItem.setOdrdtl_refcount(new Long(1));//�Ƿ�μӷ���ȯ������μ�Ϊ0������Ϊ1��Ŀǰû���ã�
					orderItem.setOdrdtl_jcflag(new Long(0));//û����
					
					orderItem.setOdrdtl_temp("�Ա��̳�");//��Ʒ���ǣ���¼������Դ
					orderItem.setOdrdtl_tuancardno("");//�̻��һ�ȯ��
					orderItem.setOdrdtl_oldodrid(orderid);
					//����������ϸ
					System.out.println("�������ݿⶩ����ϸ��"+orderItem.getId());
					Tools.getManager(OrderItemMain.class).txCreate(orderItem);
					
					//��������һ����¼������ռ��������
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
	 * ����ȷ���տ������Ա��̳ǵĶ�����Ҫͬ�������� ��orderId������ڣ�
	 * @param orderId ����id
	 * @param getmoney �յ�����Ǯ������0����Ч��С��0���޸ġ�����������0��֧����֧����ʵ����
	 * @return true �����ɹ��� false��ʾû�в����������Ƕ���id������
	 * @throws Exception
	 */
	public synchronized boolean confirmGetMoney(String orderId,float getmoney)throws Exception{
		OrderCache order1 = (OrderCache)Tools.getManager(OrderCache.class).txGet(orderId);
		if(order1!=null){//�����ڶ����������
			if(order1.getOdrmst_orderstatus()!=null&&order1.getOdrmst_orderstatus().longValue()==0){
				/*Tools.getManager(OrderCache.class).txBeforeUpdate(order1);
				order1.setOdrmst_ourmemo(order1.getOdrmst_ourmemo()+ new Date()+"֧��ϵͳ�Զ��տ�");
				if(getmoney>0)order1.setOdrmst_getmoney(new Double(getmoney));
				order1.setOdrmst_validdate(new Date());
				order1.setOdrmst_orderstatus(new Long(2));//ȷ���տ�״̬
				Tools.getManager(OrderCache.class).txUpdate(order1, true);
				
				//���ô洢���̰Ѷ����޸ĳɡ�ȷ���տ״̬
				ProcedureWork work = new ProcedureWork(orderId);
				Tools.getManager(OrderMain.class).currentSession().doWork(work);//ִ��work
				
				return true ;*/
				int ret=updateOrderStatus2013(order1,getmoney);
				if (ret==1){
				updateOrderStatuswork(order1);
				return true ;
				}
			}
		}else{
			OrderMain order2 = (OrderMain)Tools.getManager(OrderMain.class).txGet(orderId);
			if(order2!=null){//�����ڶ���������
				if(order2.getOdrmst_orderstatus()!=null&&order2.getOdrmst_orderstatus().longValue()==0){
					/*Tools.getManager(OrderMain.class).txBeforeUpdate(order2);
					order2.setOdrmst_ourmemo(order2.getOdrmst_ourmemo()+ new Date()+"֧��ϵͳ�Զ��տ�");
					if(getmoney>0)order2.setOdrmst_getmoney(new Double(getmoney));
					order2.setOdrmst_validdate(new Date());
					order2.setOdrmst_orderstatus(new Long(2));//ȷ���տ�״̬
					Tools.getManager(OrderMain.class).txUpdate(order2, true);
					
					//���ô洢���̰Ѷ����޸ĳɡ�ȷ���տ״̬
					ProcedureWork work = new ProcedureWork(orderId);
					Tools.getManager(OrderMain.class).currentSession().doWork(work);//ִ��work
					
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
		//���û������������memcached�����ݿ⻺�棬���Ҫ�޸ĳɷֲ�ʽ�������ݿ���������

			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return -2;
			//��ȷ����
			Tools.getManager(order.getClass()).txBeforeUpdate(order);
			if(dblAmount>0)order.setOdrmst_getmoney(new Double(dblAmount));
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(new Date()) +"֧��ϵͳ�Զ��տ�");
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
		//���û������������memcached�����ݿ⻺�棬���Ҫ�޸ĳɷֲ�ʽ�������ݿ���������
	
			
			//���ô洢���̰Ѷ����޸ĳɡ�ȷ���տ״̬����ִ�п����޸Ķ���������
			try {
			ProcedureWork work = new ProcedureWork(order.getId());
			Tools.getManager(order.getClass()).currentSession().doWork(work);//ִ��work
			
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
