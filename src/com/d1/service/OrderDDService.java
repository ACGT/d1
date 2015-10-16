package com.d1.service;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.hibernate.HibernateException;

import com.d1.bean.CartItem;
import com.d1.bean.OrderBase;
import com.d1.bean.OrderCache;
import com.d1.bean.OrderDangD;
import com.d1.bean.OrderItemCache;
import com.d1.bean.OrderShopCache;
import com.d1.bean.Product;
import com.d1.bean.id.OrderIdGenerator;
import com.d1.bean.id.SequenceIdGenerator;
import com.d1.dangdang.HttpInvokeUtil;
import com.d1.helper.ProductHelper;
import com.d1.util.MD5;
import com.d1.util.Tools;
public class OrderDDService {
	/**
	 * �����������������񷽷�
	 * @return OrderCache
	 */
	public OrderCache createOrderFromDangd( Element itemEle,String shopid,String ddid,String relData) throws Exception {
		 String orderID = itemEle.elementTextTrim("orderID"); // ������
	   if(Tools.getManager(OrderDangD.class).txFindByProperty("odrdangd_dangdodrid", orderID)!=null){
			//�Ѿ�ͬ������
			//System.out.println(trade.getTid()+"�������Ѿ�ͬ���������ԣ�");
			return null ;
		}
	   String consigneeName=itemEle.elementTextTrim("consigneeName"); // �ջ�������
	   String consigneeTel=itemEle.elementTextTrim("consigneeTel"); // �ջ��˹̶��绰
	   String consigneeMobileTel=itemEle.elementTextTrim("consigneeMobileTel"); //�ջ����ƶ��绰
	   String consigneeAddr=itemEle.elementTextTrim("consigneeAddr"); // �ջ���ַ
	   String sendGoodsMode=itemEle.elementTextTrim("sendGoodsMode"); // �ͻ���ʽ
	 //  String orderMoney=itemEle.elementTextTrim("orderMoney"); // �����ܽ��
	   String orderTimeStart=itemEle.elementTextTrim("orderTimeStart"); // �µ�ʱ��
	   String lastModifyTime=itemEle.elementTextTrim("lastModifyTime"); // ����޸�ʱ��
	   String orderState=itemEle.elementTextTrim("orderState"); // ����״̬
	   String remark=itemEle.elementTextTrim("remark"); // ��ע
   
	   if(Tools.isNull(consigneeMobileTel)){
		   consigneeMobileTel=consigneeTel;
	   }
			String[] strs=consigneeAddr.split("��");
			String province="";
			String city="";
			if(strs.length>=3){
				province=strs[1];
				city=strs[2];
				city=city+" "+strs[3];
			}
	   
		OrderCache order = new OrderCache();
		
		order.setId(OrderIdGenerator.generate());//order id��ͨ��һ��sequence������
		order.setOdrmst_id(new Long(SequenceIdGenerator.generate("4")));
		if(!Tools.isNull(ddid)){
		order.setOdrmst_mbrid(new Long(3210726));//���ڵ����µ��Ļ�Աid 
		}else{
		 order.setOdrmst_mbrid(new Long(2363598));//���ڵ����µ��Ļ�Աid 
		}

		order.setOdrmst_rname(consigneeName+"(��������)");//�ջ������� 
		order.setOdrmst_orderdate(new Date());//��������
		order.setOdrmst_rsex("");
		
		
		order.setOdrmst_rzipcode("");//�ջ����ʱ�
		order.setOdrmst_raddress(consigneeAddr);//�ջ��˵�ַ
		order.setOdrmst_rphone(consigneeMobileTel);//�ջ��˵绰���ֻ�
		order.setOdrmst_remail("");//�ջ���email
		order.setOdrmst_rcountry("�й�");//����
		order.setOdrmst_rprovince(province);//�ջ���ʡ
		order.setOdrmst_rcity(city);//�ջ��˳���
		
		order.setOdrmst_ourmemo("");
		
		order.setOdrmst_pzipcode("");//�����������Ϣ
		order.setOdrmst_paddress("");//�����������Ϣ
		order.setOdrmst_pcountry("�й�");//�����������Ϣ
		order.setOdrmst_pprovince("");//�����������Ϣ
		order.setOdrmst_pcity("");//�����������Ϣ
		order.setOdrmst_pophone("");//�����������Ϣ
		order.setOdrmst_phphone("");//�����������Ϣ
		order.setOdrmst_pmphone("");//�����������Ϣ 
		order.setOdrmst_pusephone("");//�����������Ϣ 
		order.setOdrmst_pbp("");//�����������Ϣ
		order.setOdrmst_pemail("");//�����������Ϣ
		String pname="d1-�����̳�";
		if(!Tools.isNull(ddid)){
			pname="����С�����̳�";
			}
		order.setOdrmst_pname(pname);//�����������Ϣ����Ӧǰ���id
		
		order.setOdrmst_psex("");
		
		order.setOdrmst_oldodrid(order.getId());//���ڲ�����𵥶���
		order.setOdrmst_odrqus(",001008,001009,");
		order.setOdrmst_orderstatus(new Long(0));//����״̬
		order.setOdrmst_specialtype(new Long(0));//�û��������־��û�ã�
		
	
		order.setOdrmst_shipid(new Long(10));//�������
		order.setOdrmst_shipmethod("�������");
		
		
		
		
		
		order.setOdrmst_realgetmoney(new Double(0));
		
		

		order.setOdrmst_temp("��������");//������Դ
	
		order.setOdrmst_tktid(new Long(0));//Eȯ��ţ���Ӧtktmst.id

		//String relData=odrdtlData;
		 HashMap<String, String> productinfo = null;
		    InputStream in = null;
		   
		    	in = new ByteArrayInputStream(relData.getBytes("GBK"));
		    	SAXReader reader = new SAXReader();
		    	InputStreamReader   isr   =   new   InputStreamReader(in,"GBK");
				Document doc = reader.read(isr);
				Element root = doc.getRootElement();
				String fpinfo="";//��Ʊ��Ϣ
				Iterator fpiter = root.elementIterator("receiptInfo"); 
	           while (fpiter.hasNext()) {
	           	 Element fpele = (Element) fpiter.next();
	           	 fpinfo="��Ʊ̧ͷ:"+fpele.elementTextTrim("receiptName")+",��Ʊ����:"+fpele.elementTextTrim("receiptDetails")+",��Ʊ���:"+fpele.elementTextTrim("receiptMoney");
	           	 
	           }
	          
	     	    String zffs="�̻�����֧��";//֧����ʽ
	           int payid=28;int paytype=4;
	           Iterator zpfsiter = root.elementIterator("buyerInfo"); 
	           double postage=0;
	           double giftCertMoney=0;
	           double giftCardMoney=0;
	           double accountBalance=0;
	           double promoDeductAmount=0;
	           String orderMoney="";
	           while (zpfsiter.hasNext()) {
	           	 Element fpele = (Element) zpfsiter.next();
	           	 zffs=fpele.elementTextTrim("buyerPayMode");
	           	orderMoney=fpele.elementTextTrim("goodsMoney");
	           	postage=Tools.parseDouble(fpele.elementTextTrim("postage")); //�ʷ�
	           	giftCertMoney=Tools.parseDouble(fpele.elementTextTrim("giftCertMoney")); //���֧����ȯ���
	           	giftCardMoney=Tools.parseDouble(fpele.elementTextTrim("giftCardMoney")); //���֧����Ʒ�����
	           	accountBalance=Tools.parseDouble(fpele.elementTextTrim("accountBalance")); //���֧���˻���
	           	promoDeductAmount=Tools.parseDouble(fpele.elementTextTrim("promoDeductAmount")); //�����Żݽ��
	           	
	           	 if(zffs.equals("��������")){
	           		 payid=0;paytype=1;
	           	 }else if(zffs.equals("�ʾֻ��")){
	           		 payid=1;paytype=2;
	           	 }else if(zffs.equals("���л��")){
	           		 payid=2;paytype=3;
	           	 }
	           }
	           double promoDicount=0;
	           String promotionName="";
	           Iterator PromoListiter = root.elementIterator("PromoList"); 
	           while (PromoListiter.hasNext()) {
	               Element PromoListEle = (Element) PromoListiter.next();
	              Iterator iters = PromoListEle.elementIterator("promoItem");
	               while (iters.hasNext()) {
	                   Element productele = (Element) iters.next();
	                   promotionName=promotionName+productele.elementTextTrim("promotionName");
	                   promoDicount=promoDicount+Tools.parseDouble(productele.elementTextTrim("promoDicount"));
	                   }
	           }
	           order.setOdrmst_acturepaymoney(new Double(Tools.parseDouble(orderMoney)));//ʵ��֧�����
	   		
	   		order.setOdrmst_gdsmoney(new Double(Tools.parseDouble(orderMoney)+accountBalance+giftCardMoney));//�ܼ�-�˷�
	   		
	   		
	       	order.setOdrmst_shipfee(new Double(postage));//�����˷�
	           order.setOdrmst_paytype(new Long(paytype));//֧����֧����type
	           order.setOdrmst_payid(new Long(payid));//�̻�����֧��
	   		order.setOdrmst_paymethod(zffs);
	   		order.setOdrmst_internalmemo("<font color=red><b>"+orderID+"��������</b></font><br/><font color=red><b>"+fpinfo+"</b></font>"+promotionName+"");
	   		order.setOdrmst_customerword(remark);//�ͻ�ʱ��+�������
	        order.setOdrmst_difprice(new Double(0));
	        
			//��ȯ�ղ������Ľ��    giftCertMoney
			//��Ʒ��  �����ջ���    giftcardmoney
			//�˻��������ջ���    accountbalance
	      //�����Żݽ���ղ����� promoDeductAmount
	       //�����Żݽ�� promoDicount
			order.setOdrmst_prepayvalue(new Double(accountBalance+giftCardMoney));
			order.setOdrmst_tktvalue(new Double(giftCertMoney+promoDeductAmount+promoDicount));//Eȯ���
			order.setOdrmst_ordermoney(new Double(Tools.parseDouble(orderMoney)+accountBalance+giftCardMoney+postage+giftCertMoney+promoDeductAmount+promoDicount));
			 if(zffs.equals("��������")){
			order.setOdrmst_getmoney(new Double(accountBalance+giftCardMoney+giftCertMoney+promoDeductAmount+promoDicount));//�յ�����Ǯ
			 }else
			 {
				 order.setOdrmst_getmoney(new Double(Tools.parseDouble(orderMoney)+accountBalance+giftCardMoney));//�յ�����Ǯ
			 }
			 
	   		System.out.println("���������ţ�"+orderID);
	   		System.out.println("����OrderCache���ݿ�..."+order.getId());
	   		
	   		Tools.getManager(OrderCache.class).txCreate(order);
	   		
	   		OrderShopCache orderShopCache = new OrderShopCache();
	   		orderShopCache.setOdrshp_odrid(order.getId());
	   		orderShopCache.setOdrshp_shopcode("08102301");
	   		orderShopCache.setOdrshp_sndshopcode("00000000");//d1����ȫ�����
	   		orderShopCache.setOdrshp_orderdate(new Date());
	   		orderShopCache.setOdrshp_shopname("D1���������з���");
	   		orderShopCache.setOdrshp_country("�й�");
	   		orderShopCache.setOdrshp_province("");
	   		orderShopCache.setOdrshp_city("");
	   		
	   		orderShopCache.setOdrshp_gdsmoney(new Float(Tools.parseFloat(orderMoney)));
	   		orderShopCache.setOdrshp_shipfee(new Float(0));
	   		orderShopCache.setOdrshp_centerfee(new Float(0));
	   		
	   		orderShopCache.setOdrshp_ordermoney(new Float(Tools.parseFloat(orderMoney)));
	   		
	   		orderShopCache.setOdrshp_payshopmoney(new Float(0));
	   		
	   		orderShopCache.setOdrshp_incomevalue(new Float(Tools.parseFloat(orderMoney)));
	   		orderShopCache.setOdrshp_realincome(new Float(0));
	   		orderShopCache.setOdrshp_giftid(new Long(0));
	   		orderShopCache.setOdrshp_giftfee(new Float(0));
	   		orderShopCache.setOdrshp_downflag(new Long(1));
	   		
	   		Tools.getManager(OrderShopCache.class).txCreate(orderShopCache);//����odrshp��¼�������¼û���ã�����̨�й�����ѯ�����Ա��봴��
	   		
	      		 Iterator productiter = root.elementIterator("ItemsList"); 
	               while (productiter.hasNext()) {

	                   Element recordEle = (Element) productiter.next();
	                  Iterator iters = recordEle.elementIterator("ItemInfo"); // ��ȡ�ӽڵ�ItemDetail�µ��ӽڵ�SpecilaItemInfo

	                   // ����Header�ڵ��µ�Response�ڵ�
	                   while (iters.hasNext()) {

	                       Element productele = (Element) iters.next();
	                      String outerItemID ="";
	                      if(productele.selectSingleNode("outerItemID")!=null){
	                    	  outerItemID= productele.elementTextTrim("outerItemID"); // �õ�ItemDetail�µ��ӽڵ�SpecilaItemInfo�µ��ֽڵ�outerItemID��ֵ
	                      }
	                      String specialAttribute="";
	                      if(productele.selectSingleNode("specialAttribute")!=null){
	                    	  specialAttribute= productele.elementTextTrim("specialAttribute"); // �õ�ItemDetail�µ��ӽڵ�SpecilaItemInfo�µ��ֽڵ�outerItemID��ֵ
	                      }
	                      String orderCount=productele.elementTextTrim("orderCount"); //��������
	                      String itemID=productele.elementTextTrim("itemID"); //������ƷID
	                       String unitPrice=productele.elementTextTrim("unitPrice"); //�ɽ���
	                      // String itemType=productele.elementTextTrim("itemType"); //��Ʒ����
	                       String itemName=productele.elementTextTrim("itemName"); //��Ʒ����
	                      // System.out.println("outerItemID:" + outerItemID);
	                       String productId="";
	   		        	 String psku="";
	   		        	 if(outerItemID!=null && outerItemID.length()>8){//��sku
	   						 productId=outerItemID.substring(0, 8);
	   						 psku=outerItemID.substring(8);
	   						}if(!Tools.isNull(outerItemID) && !"null".equals(outerItemID) && outerItemID.length()==8){
	   							productId=outerItemID;
	   						}
	   					//if(Tools.isNull(psku) && !Tools.isNull(specialAttribute)){
	   					//	psku=specialAttribute.substring(specialAttribute.lastIndexOf(">>")+2);
	   					//	}
	   					if(Tools.isNull(productId)){
	   						StringBuffer resultStr=new StringBuffer(itemName);
	   						resultStr=resultStr.reverse();
	   						int s=resultStr.toString().indexOf("_");
	   						resultStr=new StringBuffer(resultStr.substring(s+1,s+9));
	   						productId=resultStr.reverse().toString();
	   					}
	   						//System.out.println(psku+"qqqqqqqqqq");
	   		        	 Product p=ProductHelper.getById(productId);
	   		        	
	   		   		    	OrderItemCache orderItem = new OrderItemCache();
	   		   				
	   		   				orderItem.setId(SequenceIdGenerator.generate("5"));
	   		   				orderItem.setOdrdtl_odrid(order.getId());//������
	   		   				
	   		   				orderItem.setOdrdtl_gdsid(productId);//product id
	   		   				
	   		   			    orderItem.setOdrdtl_shopcode(p.getGdsmst_shopcode());
		                    orderItem.setOdrdtl_oldodrid(order.getId());
	   		   				orderItem.setOdrdtl_sku1(psku);
	   		   				orderItem.setOdrdtl_sku2("");//sku2  û��
	   		   			
	   		   				orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//��Ʒ��
	   		   				orderItem.setOdrdtl_memberprice(new Double(Tools.parseDouble(unitPrice)));//��Ա��
	   		   				orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//�г���
	   		   				orderItem.setOdrdtl_vipprice(new Double(Tools.parseDouble(unitPrice)));//vip ��
	   		   				
	   		   				orderItem.setOdrdtl_finalprice(new Double(Tools.parseDouble(unitPrice)));//���ɽ�����
	   		   				
	   		   				orderItem.setOdrdtl_gdscount(new Long(Tools.parseLong(orderCount)));//��������
	   		   				
	   		   				double sumprice=Tools.parseDouble(unitPrice)*Tools.parseDouble(orderCount);
	   		   				orderItem.setOdrdtl_totalmoney(new Double(sumprice));//�ɽ��ܽ��
	   		   				orderItem.setOdrdtl_purprice(new Double(p.getGdsmst_inprice()));

	   		   				orderItem.setOdrdtl_shipstatus(new Long(1));//����״̬��1Ϊδ����
	   		   				orderItem.setOdrdtl_sendcount(new Long(Tools.parseLong(orderCount)));//�����������ʼ0
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
	   		   				
	   		   				orderItem.setOdrdtl_totalincomevalue(Tools.getDouble(sumprice,2));//�����̻������� ����
	   		   				orderItem.setOdrdtl_eyuan(new Double(p.getGdsmst_eyuan()));//��ƷӦ��Eȯ ��Ʒ��ȡ���۸��ܴ�����ȯ����Ʒ
	   		   				
	   		   				orderItem.setOdrdtl_spendcount(new Double(0));//���û�����
	   		   				
	   		   				orderItem.setOdrdtl_managememo("");//��Ʒ��������
	   		   				orderItem.setOdrdtl_gdspurmemo("");//�ɹ���ע 
	   		   				
	   		   				orderItem.setOdrdtl_specialflag(new Long(2));//0��ʲô�����룬1��ʾ��Ʒ������ȯ��2��ʾ���������˷���
	   		   				orderItem.setOdrdtl_gifttype("");//��Ʒ���� 
	   		   				
	   		   				orderItem.setOdrdtl_refcount(new Long(1));//�Ƿ�μӷ���ȯ������μ�Ϊ0������Ϊ1��Ŀǰû���ã�
	   		   				orderItem.setOdrdtl_jcflag(new Long(0));//û����
	   		   				
	   		   				orderItem.setOdrdtl_temp("����");//��Ʒ���ǣ���¼������Դ
	   		   				orderItem.setOdrdtl_tuancardno("");//�̻��һ�ȯ��
	   		   				orderItem.setOdrdtl_bfdtemp(itemID);
	   		   				
	   		   				//����������ϸ
	   		   				System.out.println("�������ݿⶩ����ϸ��"+orderItem.getId());
	   		   				Tools.getManager(OrderItemCache.class).txCreate(orderItem);
	   		   				
	   		   				//��������һ����¼������ռ��������
	   		   				CartItem ci = new CartItem();
	   		   				ci.setAmount(orderItem.getOdrdtl_gdscount());
	   		   				ci.setCreateDate(new Date());
	   		   				ci.setOrderId(order.getId());
	   		   				ci.setProductId(p.getId());
	   		   				ci.setSkuId(orderItem.getOdrdtl_sku1());
	   		   				ci.setUserId("2363598");
	   		   				Tools.getManager(CartItem.class).txCreate(ci);
	   		       	        	
	   		   			
	   		   		}
	   		        	 
	   		        	
	                   }
	            
	    OrderDangD odd=new OrderDangD();
		odd.setOdrdangd_dangdodrid(orderID);
		odd.setOdrdangd_d1odrid(order.getId());
		if(!Tools.isNull(ddid)){
			odd.setOdrdangd_mbrid(new Long(3210726));
			}else{
			 odd.setOdrdangd_mbrid(new Long(2363598));
			}
		
		odd.setOdrdangd_name(consigneeName);
		odd.setOdrdangd_phone(consigneeTel);
		odd.setOdrdangd_mobile(consigneeMobileTel);
		odd.setOdrdangd_status(new Long(0));
		odd.setOdrdangd_createdate(new Date());
		odd.setOdrdangd_tktvalue(Tools.doubleValue(giftCertMoney+giftCertMoney));
		Tools.getManager(OrderDangD.class).txCreate(odd);
		int hfpayid=2;		
		if(zffs.equals("��������")){
			hfpayid=1;
		}
		confirmGetMoney(order.getId(),-1,hfpayid);//�޸Ķ���Ϊȷ���տ�״̬

		return order;
	}

	/**
	* ����ȷ���տ�Ƹ�ͨ�Ѿ����֧�� ��orderId������ڣ�����״̬������0��
	* @param orderId ����id
	* @param getmoney �յ�����Ǯ������0����Ч��С��0���޸ġ�
	* @return true �����ɹ��� false��ʾû�в����������Ƕ���id������
	* @throws Exception
	*/
	public  boolean confirmGetMoney(String orderId,float getmoney,int hfpayid)throws Exception{
		OrderCache order1 = (OrderCache)Tools.getManager(OrderCache.class).txGet(orderId);
		if(order1==null)return false ;
		
		if(order1.getOdrmst_orderstatus()!=null&&order1.getOdrmst_orderstatus().longValue()==0){
			/*Tools.getManager(OrderCache.class).txBeforeUpdate(order1);
			order1.setOdrmst_ourmemo(order1.getOdrmst_ourmemo()+ Tools.stockFormatDate(new Date())+"����ͬ�������տ�");
			if(getmoney>0)order1.setOdrmst_getmoney(new Double(getmoney));
			order1.setOdrmst_validdate(new Date());
			order1.setOdrmst_orderstatus(new Long(2));//ȷ���տ�״̬
			Tools.getManager(OrderCache.class).txUpdate(order1, true);
			
			//���ô洢���̰Ѷ����޸ĳɡ�ȷ���տ״̬
			ProcedureWork work = new ProcedureWork(orderId);
			Tools.getManager(OrderMain.class).currentSession().doWork(work);//ִ��work
			
			return true ;
			*/
			
			
			int ret=updateOrderStatus2013(order1,getmoney,hfpayid);
			if (ret==1){
			updateOrderStatuswork(order1);
			return true ;
			}
		}
		
		return false ;
	}
	

	
	public int updateOrderStatus2013(OrderBase order , double dblAmount,int hfpayid){
		if(order == null) return -1;
		//���û������������memcached�����ݿ⻺�棬���Ҫ�޸ĳɷֲ�ʽ�������ݿ���������
		synchronized(order){
			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return -2;
			//��ȷ����
			//if((int)Math.round(Tools.doubleValue(order.getOdrmst_acturepaymoney())*10) != (int)Math.round(dblAmount*10)) return -3;//��һ��
			Tools.getManager(order.getClass()).txBeforeUpdate(order);
			if(dblAmount>0)order.setOdrmst_getmoney(new Double(dblAmount));
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(new Date()) +"����ͬ�������տ�");
			order.setOdrmst_validdate(new Date());
			order.setOdrmst_orderstatus(new Long(hfpayid));
			
			Tools.getManager(order.getClass()).txUpdate(order, true);
			
			if(Tools.longValue(order.getOdrmst_orderstatus()) == 0) return -4;
			return 1;
		}
	}
	
	public int updateOrderStatuswork(OrderBase order){

		if(order == null) return -1;
		//���û������������memcached�����ݿ⻺�棬���Ҫ�޸ĳɷֲ�ʽ�������ݿ���������
		synchronized(order){
	
			
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
	/**
	 * i    (
o   )
-    /
t    (
y    )
��ɫ  #
��ɫ  *
ǳ��ɫu
��ɫ  v
�ո�  z
	 * @param str
	 * @return
	 */
	private static String repstr(String str){
		str=str.replace("i", "��");
		str=str.replace("o", "��");
		str=str.replace("-", "/");
		str=str.replace("t", "(");
		str=str.replace("y", ")");
		str=str.replace("#", "��ɫ");
		str=str.replace("*", "��ɫ");
		str=str.replace("u", "��ɫ");
		str=str.replace("v", "��ɫ");
		str=str.replace("k", "��ɫ");
		str=str.replace("g", "��ɫ");
		str=str.replace("n", "��ɫ");
		str=str.replace("z", " ");
		return str;
	}

	


	
}
