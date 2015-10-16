package com.d1.service;

import java.sql.SQLException;
import java.util.Date;
import java.util.Iterator;

import org.dom4j.Element;
import org.hibernate.HibernateException;

import com.d1.bean.CartItem;
import com.d1.bean.OdrVancl;
import com.d1.bean.OrderBase;
import com.d1.bean.OrderCache;
import com.d1.bean.OrderDangD;
import com.d1.bean.OrderItemCache;
import com.d1.bean.OrderMain;
import com.d1.bean.OrderShopCache;
import com.d1.bean.Product;
import com.d1.bean.id.OrderIdGenerator;
import com.d1.bean.id.SequenceIdGenerator;
import com.d1.helper.ProductHelper;
import com.d1.util.DESUtil;
import com.d1.util.Tools;

public class OrderVanclService {
	/**
	 * �������Ͷ��������񷽷�
	 * @return OrderCache
	 */
	public OrderCache createOrderFromVancl( Element itemEle,Element itemnotice) throws Exception {
		 String orderID = itemEle.elementTextTrim("orderid"); // ������
		   orderID=deccode(orderID);
		  // System.out.println("�����ţ�"+orderID);
		   if(Tools.getManager(OdrVancl.class).txFindByProperty("odrvancl_orderid", orderID)!=null){
				//�Ѿ�ͬ������
				//System.out.println(orderID+"�������Ѿ�ͬ���������ԣ�");
				return null ;
			}
		   String username=itemEle.elementTextTrim("username"); // �ջ�������
		   String usertel=itemEle.elementTextTrim("usertel"); // �ջ��˹̶��绰
		   String userphone=itemEle.elementTextTrim("userphone"); //�ջ����ƶ��绰
		   String areaid=itemEle.elementText("areaid");//ʡ��
		   String postalcode=itemEle.elementText("postalcode");//��������
		   String address=itemEle.elementTextTrim("address"); // �ջ���ַ
		   String receivetime=itemEle.elementTextTrim("receivetime"); // �ͻ�ʱ��
		   String needinvoice=itemEle.elementTextTrim("needinvoice"); // �Ƿ���Ҫ��Ʊ
		   String totalprice=itemEle.elementTextTrim("totalprice"); // �����ܽ��
		   String transferprice=itemEle.elementTextTrim("transferprice"); // �����˷�
		   String paidprice=itemEle.elementTextTrim("paidprice"); // �Ѹ������������֧�����˻����֧������Ʒ��֧����-
		   String unpaidprice=itemEle.elementTextTrim("unpaidprice"); // Ӧ�����ʵ��Ӧ�ô�ӡ������浥�ϵĽ�Ҳ�ǿ����ԱӦ�����û���ȡ�Ľ��
		   String paymenttype=itemEle.elementTextTrim("paymenttype"); // ֧����ʽ
		   String comment=itemEle.elementTextTrim("comment"); // �û�����
		   
		
		   username=deccode(username);
		   usertel=deccode(usertel);
		   userphone=deccode(userphone);
		   areaid=deccode(areaid);
		   postalcode=deccode(postalcode);
		   address=deccode(address);
		   receivetime=deccode(receivetime);
		   needinvoice=deccode(needinvoice);
		   totalprice=deccode(totalprice);
		   transferprice=deccode(transferprice);
		   paidprice=deccode(paidprice);
		   unpaidprice=deccode(unpaidprice);
		   paymenttype=deccode(paymenttype);
		   comment=deccode(comment);
		   if(Tools.isNull(userphone)){
			   userphone=usertel;
		   }
		   String province=address.substring(0,address.indexOf("��ʡ��"));
			String city=address.substring(address.indexOf("��ʡ��")+3,address.indexOf("������"));
			city=city.replace("���У�", " ");
			OrderCache order = new OrderCache();
			
			order.setId(OrderIdGenerator.generate());//order id��ͨ��һ��sequence������
			order.setOdrmst_id(new Long(SequenceIdGenerator.generate("4")));
	
			 order.setOdrmst_mbrid(new Long(3295935));//���ڷ����µ��Ļ�Աid 

			order.setOdrmst_rname(username+"(���Ͷ���)");//�ջ������� 
			order.setOdrmst_orderdate(new Date());//��������
			order.setOdrmst_rsex("");
			
			
			order.setOdrmst_rzipcode(postalcode);//�ջ����ʱ�
			order.setOdrmst_raddress(address);//�ջ��˵�ַ
			order.setOdrmst_rphone(userphone);//�ջ��˵绰���ֻ�
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
			String pname="D1�����̳�";
			order.setOdrmst_pname(pname);//�����������Ϣ����Ӧǰ���id
			order.setOdrmst_psex("");
       		order.setOdrmst_oldodrid(order.getId());//���ڲ�����𵥶���
			order.setOdrmst_odrqus(",001008,001009,");
			order.setOdrmst_orderstatus(new Long(0));//����״̬
			order.setOdrmst_specialtype(new Long(0));//�û��������־��û�ã�
			order.setOdrmst_shipid(new Long(10));//�������
			order.setOdrmst_shipmethod("�������");

			order.setOdrmst_realgetmoney(new Double(0));
			order.setOdrmst_temp("���Ͷ���");//������Դ
		
			order.setOdrmst_tktid(new Long(0));//Eȯ��ţ���Ӧtktmst.id
          
		     	    String zffs="�̻�����֧��";//֧����ʽ
		           int payid=28;int paytype=4;
		           double promoDicount=0;
		           String strnotice="";
		           if(itemnotice!=null){
		        	   strnotice="��Ʊ��Ϣ:";  
		        	   String invoicetitle=itemnotice.elementTextTrim("invoicetitle"); // ��Ʊ̧ͷ
		        	   strnotice+="��Ʊ̧ͷ:"+invoicetitle+"<br>";
		        	   Iterator invoicedetail = itemnotice.elementIterator("invoicedetail"); 
		   	        while (invoicedetail.hasNext()) {
		   	     	   Element recordEle = (Element) invoicedetail.next();
		    		   String noticename=recordEle.elementTextTrim("name"); // ���ƣ���ʵ���ܿ��ߵ���ʽ���ߡ������û�Ҫ�󿪾߰칫��Ʒ����ʵ��ֻ�ܿ����ǡ�ʳƷ�����򿪾ߡ�ʳƷ��
		    		   String noticeunit=recordEle.elementTextTrim("unit"); // ��λ
		    		   String noticeprice=recordEle.elementTextTrim("price"); // ���
		    		   strnotice+="����:"+noticename+"<br>";
		    		   strnotice+="��λ:"+noticeunit+"<br>";
		    		   strnotice+="���:"+noticeprice+"<br>";
		   	        }
		        	  
		        	   
		           }
		           if(needinvoice.equals("True")){
		        	   order.setOdrmst_taxflag(new Long(1));
		           }
		           
		        order.setOdrmst_acturepaymoney(new Double(Tools.parseDouble(totalprice)));//ʵ��֧�����
     	   		order.setOdrmst_gdsmoney(new Double(Tools.parseDouble((Tools.parseDouble(totalprice)-Tools.parseDouble(transferprice))+"")));//�ܼ�-�˷�
    	   		order.setOdrmst_ordermoney(new Double(Tools.parseDouble(totalprice)));
		       	order.setOdrmst_shipfee(new Double(transferprice));//�����˷�
				order.setOdrmst_getmoney(new Double(Tools.parseDouble(totalprice)));//�յ�����Ǯ
		           order.setOdrmst_paytype(new Long(paytype));//֧����֧����type
		           order.setOdrmst_payid(new Long(payid));//�̻�����֧��
		   		order.setOdrmst_paymethod(zffs);
		   		order.setOdrmst_internalmemo("<font color=red><b>"+orderID+"���Ͷ���</b></font><br/><font color=red><b>"+comment+"</b></font><font color=red><b>"+strnotice+"</b></font>");
		   		order.setOdrmst_customerword(comment);//�ͻ�ʱ��+�������
		        order.setOdrmst_difprice(new Double(0));
				order.setOdrmst_prepayvalue(new Double(0));
				order.setOdrmst_tktvalue(new Double(0));//Eȯ���
		        
		        
		   		System.out.println("���Ͷ����ţ�"+orderID);
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
		   		
		   		orderShopCache.setOdrshp_gdsmoney(new Float(Tools.parseFloat(totalprice)));
		   		orderShopCache.setOdrshp_shipfee(new Float(0));
		   		orderShopCache.setOdrshp_centerfee(new Float(0));
		   		
		   		orderShopCache.setOdrshp_ordermoney(new Float(Tools.parseFloat(totalprice)));
		   		
		   		orderShopCache.setOdrshp_payshopmoney(new Float(0));
		   		
		   		orderShopCache.setOdrshp_incomevalue(new Float(Tools.parseFloat(totalprice)));
		   		orderShopCache.setOdrshp_realincome(new Float(0));
		   		orderShopCache.setOdrshp_giftid(new Long(0));
		   		orderShopCache.setOdrshp_giftfee(new Float(0));
		   		orderShopCache.setOdrshp_downflag(new Long(1));
		   		
		   		Tools.getManager(OrderShopCache.class).txCreate(orderShopCache);//����odrshp��¼�������¼û���ã�����̨�й�����ѯ�����Ա��봴��
		   		
		      		 Iterator orderdetail = itemEle.elementIterator("orderdetail"); 
		                  // ����Header�ڵ��µ�Response�ڵ�
		                   while (orderdetail.hasNext()) {

		                       Element productele = (Element) orderdetail.next();
		                      String outerItemID ="";
		                      if(productele.selectSingleNode("barcode")!=null){
		                    	  outerItemID= productele.elementTextTrim("barcode"); // �õ�ItemDetail�µ��ӽڵ�SpecilaItemInfo�µ��ֽڵ�outerItemID��ֵ
		                      }
		                       String orderCount=productele.elementTextTrim("qty"); //��������
		                       String unitPrice=productele.elementTextTrim("price"); //�ɽ���
		                       String amount=productele.elementTextTrim("amount"); //С��
		                       outerItemID=deccode(outerItemID);
		                       orderCount=deccode(orderCount);
		                       unitPrice=deccode(unitPrice);
		                       amount=deccode(amount);

		                     String productId="";
		   		        	 String psku="";
		   		        	 if(outerItemID!=null && outerItemID.length()>8){//��sku
		   						 productId=outerItemID.substring(0, 8);
		   						 psku=outerItemID.substring(8);
		   						}if(!Tools.isNull(outerItemID) && !"null".equals(outerItemID) && outerItemID.length()==8){
		   							productId=outerItemID;
		   						}
		   	
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
	
		   		   				orderItem.setOdrdtl_totalmoney(new Double(Tools.parseDouble(unitPrice)*Tools.parseInt(orderCount)));//�ɽ��ܽ��	   		   				orderItem.setOdrdtl_purprice(new Double(p.getGdsmst_inprice()));

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
		   		   				
		   		   				orderItem.setOdrdtl_totalincomevalue(Tools.getDouble(Tools.parseDouble(unitPrice),2));//�����̻������� ����
		   		   				orderItem.setOdrdtl_eyuan(new Double(0));//��ƷӦ��Eȯ ��Ʒ��ȡ���۸��ܴ�����ȯ����Ʒ
		   		   				
		   		   				orderItem.setOdrdtl_spendcount(new Double(0));//���û�����
		   		   				
		   		   				orderItem.setOdrdtl_managememo("");//��Ʒ��������
		   		   				orderItem.setOdrdtl_gdspurmemo("");//�ɹ���ע 
		   		   				
		   		   				orderItem.setOdrdtl_specialflag(new Long(2));//0��ʲô�����룬1��ʾ��Ʒ������ȯ��2��ʾ���������˷���
		   		   				orderItem.setOdrdtl_gifttype("");//��Ʒ���� 
		   		   				
		   		   				orderItem.setOdrdtl_refcount(new Long(1));//�Ƿ�μӷ���ȯ������μ�Ϊ0������Ϊ1��Ŀǰû���ã�
		   		   				orderItem.setOdrdtl_jcflag(new Long(0));//û����
		   		   				
		   		   				orderItem.setOdrdtl_temp("����");//��Ʒ���ǣ���¼������Դ
		   		   				orderItem.setOdrdtl_tuancardno("");//�̻��һ�ȯ��
		   		   				
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
		   		   				ci.setUserId("3295935");
		   		   				Tools.getManager(CartItem.class).txCreate(ci);
		   		       	        	
		   		   			
		   		   		}

		                   String orderstatus=itemEle.elementTextTrim("orderstatus"); // ����״̬
		        		   String orderstatusname=itemEle.elementTextTrim("orderstatusname"); // ����״̬����
		        		   String orderdistributetime=itemEle.elementTextTrim("orderdistributetime"); //����ȷ����Чʱ��
		        		   orderstatus=deccode(orderstatus);
		        		   orderstatusname=deccode(orderstatusname);
		        		   orderdistributetime=deccode(orderdistributetime);

		    OdrVancl ovancl=new OdrVancl();
            ovancl.setOdrvancl_odrid(order.getId());
             ovancl.setOdrvancl_orderid(orderID);
            ovancl.setOdrvancl_orderstatus(orderstatus);
            ovancl.setOdrvancl_orderstatusname(orderstatusname);
            ovancl.setOdrvacl_paidprice(new Double(paidprice));
            ovancl.setOdrvancl_orderdistributetime(orderdistributetime);
            ovancl.setOdrvancl_paymenttype(paymenttype);
            ovancl.setOdrvancl_totalprice(new Double(totalprice));
            ovancl.setOdrvancl_transferprice(new Double(transferprice));
             ovancl.setOdrvancl_unpaidprice(new Double(unpaidprice));
             ovancl.setOdrvancl_needinvoice(needinvoice);
            
			Tools.getManager(OdrVancl.class).txCreate(ovancl);

					
			confirmGetMoney(order.getId(),Tools.parseFloat(totalprice));//�޸Ķ���Ϊȷ���տ�״̬
			return order;
		}

		/**
		* ����ȷ���տ�Ƹ�ͨ�Ѿ����֧�� ��orderId������ڣ�����״̬������0��
		* @param orderId ����id
		* @param getmoney �յ�����Ǯ������0����Ч��С��0���޸ġ�
		* @return true �����ɹ��� false��ʾû�в����������Ƕ���id������
		* @throws Exception
		*/
		public synchronized boolean confirmGetMoney(String orderId,float getmoney)throws Exception{
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
				
				return true ;*/
						
				int ret=updateOrderStatus2013(order1,getmoney);
				if (ret==1){
				updateOrderStatuswork(order1);
				return true ;
				}else{
					return false ;
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
				order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(new Date()) +"����ͬ�������տ�");
				order.setOdrmst_validdate(new Date());
				order.setOdrmst_orderstatus(new Long(2));
				
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
		
		
		
		private String deccode(String str){
			String strret="";
			try{
			String key="bjlsysgs";
			String iv="bjlsysgs";
			 strret=DESUtil.decryptDES(str, key, iv);
					//DESUtil.decryptDES(str,key,iv);
			}catch(Exception e){
				e.printStackTrace();
			}
			return strret;
		}
}