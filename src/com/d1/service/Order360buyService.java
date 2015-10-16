package com.d1.service;

import java.io.File;
import java.io.FileWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringEscapeUtils;
import org.hibernate.HibernateException;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.CartItem;
import com.d1.bean.GiftItem;
import com.d1.bean.Order360buy;
import com.d1.bean.OrderBase;
import com.d1.bean.OrderCache;
import com.d1.bean.OrderItemCache;
import com.d1.bean.OrderMain;
import com.d1.bean.OrderShopCache;
import com.d1.bean.Product;
import com.d1.bean.id.OrderIdGenerator;
import com.d1.bean.id.SequenceIdGenerator;
import com.d1.dbcache.core.BaseEntity;
import com.d1.helper.ProductHelper;
import com.d1.util.Tools;

public class Order360buyService {
	/**
	 * �����������������񷽷�
	 * @return OrderCache
	 */
	public OrderCache createOrderFrom360Buy(JSONObject tempJson) throws Exception {
		 String order_id_360buy = StringEscapeUtils.escapeSql(tempJson.getString("order_id"));  
		 String order_total_price = StringEscapeUtils.escapeSql(tempJson.getString("order_total_price"));//�����ܽ��
        // String order_payment = StringEscapeUtils.escapeSql(tempJson.getString("order_payment"));//�û�Ӧ�����
         String freight_price = StringEscapeUtils.escapeSql(tempJson.getString("freight_price"));//��Ʒ���˷�
         String seller_discount = StringEscapeUtils.escapeSql(tempJson.getString("seller_discount"));//�̼��Żݽ��
         String order_seller_price = StringEscapeUtils.escapeSql(tempJson.getString("order_seller_price"));//�������
         if(Tools.getManager(Order360buy.class).txFindByProperty("odr360buy_360odrid", order_id_360buy)!=null){
 			//�Ѿ�ͬ������
 			//System.out.println("����"+order_id_360buy+"�������Ѿ�ͬ����");
 			return null ;
 		}
         //String item_info_list = StringEscapeUtils.escapeSql(tempJson.getString("item_info_list"));
         /*order_id String ��   �����ţ����뷵�ص��ֶΣ� 
         vender_id String ��   �̼ұ�� 
         pay_type String ��   ֧����ʽ 
         order_total_price String ��   �����ܽ�� 
         order_payment String ��   �û�Ӧ����� 
         freight_price String ��   ��Ʒ���˷� 
         seller_discount String ��   �̼��Żݽ�� 
         order_state String ��   ����״̬��Ӣ�ģ� 
         order_state_remark String ��   ����״̬˵�������ģ� 
         delivery_type String ��   �ͻ������ڣ����� 
         invoice_info String ��   ��Ʊ��Ϣ 
         order_remark String ��   ����µ�ʱ������ע 
         order_start_time String ��   �µ�ʱ�� 
         order_end_time String ��   �ᵥʱ�� 
         consignee_info UserInfo ��   �ջ��˻�����Ϣ 
         item_info_list List<ItemInfo> ��   ������Ʒ�б� 
         */
      
         
		OrderCache order = new OrderCache();
		
		order.setId(OrderIdGenerator.generate());//order id��ͨ��һ��sequence������
		order.setOdrmst_id(new Long(SequenceIdGenerator.generate("4")));
		order.setOdrmst_mbrid(new Long(1271857));//���ڲƸ�ͨ�̳��µ��Ļ�Աid 
		
		//ͬ���ջ���
		String consignee_info=StringEscapeUtils.escapeSql(tempJson.getString("consignee_info"));
		JSONObject  jsonuser = JSONObject.fromObject(consignee_info);
		String user_name=StringEscapeUtils.escapeSql(jsonuser.getString("fullname"));
		String user_mobilephone=StringEscapeUtils.escapeSql(jsonuser.getString("mobile"));
		String user_address=StringEscapeUtils.escapeSql(jsonuser.getString("full_address"));
		String province=StringEscapeUtils.escapeSql(jsonuser.getString("province"));
		String city=StringEscapeUtils.escapeSql(jsonuser.getString("city"));
		
		order.setOdrmst_rname(user_name+"(��������)");//�ջ������� 
		order.setOdrmst_orderdate(new Date());//��������
		order.setOdrmst_rsex("");
		order.setOdrmst_payid(new Long(28));//�̻�����֧��
		order.setOdrmst_paymethod("�̻�����֧��");

		order.setOdrmst_paytype(new Long(4));//֧����֧����type
		order.setOdrmst_rzipcode("");//�ջ����ʱ�
		order.setOdrmst_raddress(user_address);//�ջ��˵�ַ
		order.setOdrmst_rphone(user_mobilephone);//�ջ��˵绰���ֻ�
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
		
		order.setOdrmst_pname("d1-�����̳�");//�����������Ϣ����Ӧǰ���id
		
		order.setOdrmst_psex("");
		order.setOdrmst_oldodrid(order.getId());//���ڲ�����𵥶���
		
		
		String fpinfo=StringEscapeUtils.escapeSql(tempJson.getString("invoice_info"));//��Ʊ��Ϣ
		
		String buyerremark =StringEscapeUtils.escapeSql(tempJson.getString("order_remark"));//��ע
		order.setOdrmst_customerword(buyerremark);//�ͻ�ʱ��+�������
		
		order.setOdrmst_internalmemo("<font color=red><b>"+order_id_360buy+"�����̳Ƕ��� �ÿհ�ֽ��ͽ��� ��Ҫ�ŷ��������й�˾���Ƶĵ���</b></font><br/><font color=red><b>"+fpinfo+"</b></font>");

		order.setOdrmst_odrqus(",001008,001009,");
		order.setOdrmst_orderstatus(new Long(0));//����״̬
		order.setOdrmst_specialtype(new Long(0));//�û��������־��û�ã�
		
		order.setOdrmst_shipfee(new Double(freight_price));//�����˷�
		order.setOdrmst_shipid(new Long(10));//�������
		order.setOdrmst_shipmethod("�������");
		
		
		order.setOdrmst_acturepaymoney(new Double(Tools.parseDouble(order_seller_price)+Tools.parseDouble(freight_price)));//ʵ��֧�����
		
		order.setOdrmst_gdsmoney(new Double(Tools.parseDouble(order_seller_price)));//�ܼ�-�˷�
		

		
		
		order.setOdrmst_realgetmoney(new Double(0));
		
		if(buyerremark.startsWith("�ۺ��޻���")&&Tools.parseDouble(order_total_price)==Tools.parseDouble(seller_discount)){
		order.setOdrmst_prepayvalue(new Double(Tools.parseDouble(seller_discount)));
		order.setOdrmst_tktvalue(new Double(0));//Eȯ���
		order.setOdrmst_getmoney(new Double(Tools.parseDouble(order_seller_price)+Tools.parseDouble(freight_price)));//�յ�����Ǯ
		}else{
			order.setOdrmst_prepayvalue(new Double(0));
			order.setOdrmst_tktvalue(new Double(Tools.parseDouble(seller_discount)));//Eȯ���
			order.setOdrmst_getmoney(new Double(Tools.parseDouble(order_seller_price)+Tools.parseDouble(freight_price)+Tools.parseDouble(seller_discount)));//�յ�����Ǯ
		}
		order.setOdrmst_ordermoney(new Double(Tools.parseDouble(order_total_price)+Tools.parseDouble(freight_price)+Tools.parseDouble(seller_discount)));
		order.setOdrmst_temp("��������");//������Դ
		
		
		order.setOdrmst_tktid(new Long(0));//Eȯ��ţ���Ӧtktmst.id
		System.out.println("���������ţ�"+order_id_360buy);
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
		
		orderShopCache.setOdrshp_gdsmoney(new Float(Tools.parseFloat(order_seller_price)));
		orderShopCache.setOdrshp_shipfee(new Float(0));
		orderShopCache.setOdrshp_centerfee(new Float(0));
		
		orderShopCache.setOdrshp_ordermoney(new Float(Tools.parseFloat(order_total_price)));
		
		orderShopCache.setOdrshp_payshopmoney(new Float(0));
		
		orderShopCache.setOdrshp_incomevalue(new Float(Tools.parseFloat(order_seller_price)));
		orderShopCache.setOdrshp_realincome(new Float(0));
		orderShopCache.setOdrshp_giftid(new Long(0));
		orderShopCache.setOdrshp_giftfee(new Float(0));
		orderShopCache.setOdrshp_downflag(new Long(1));
		
		Tools.getManager(OrderShopCache.class).txCreate(orderShopCache);//����odrshp��¼�������¼û���ã�����̨�й�����ѯ�����Ա��봴��
		
		//System.out.println("d1gjl:"+item_info_list);
        //JSONObject  jsonorder = JSONObject.fromObject(item_info_list); 
        JSONArray jsons = tempJson.getJSONArray("item_info_list");  
		boolean flag = true ;
		if(flag){
			  int jsonLength = jsons.size();  
    	      //��json�������ѭ��  

    	        for (int i = 0; i < jsonLength; i++) { //����������ϸ
    	        
    	        JSONObject itemJson = JSONObject.fromObject(jsons.get(i));  
				String outer_sku_id= StringEscapeUtils.escapeSql(itemJson.getString("outer_sku_id"));
				String item_total = StringEscapeUtils.escapeSql(itemJson.getString("item_total"));
				String jd_price = StringEscapeUtils.escapeSql(itemJson.getString("jd_price"));
				String productId="";
				String psku="";
				if(outer_sku_id.length()>8){
				 productId=outer_sku_id.substring(0, 8);
				 psku=repstr(outer_sku_id.substring(8));
				}
				if (Tools.isNull(productId)){
					
					FileWriter fw = new FileWriter(new File("/var/buy360error.txt"),true);
					fw.write("������ƷSKU����ȷ�������ţ�="+order_id_360buy+"---����sku:"+outer_sku_id);
					fw.flush();
					fw.close();
				}
				Product p = (Product)Tools.getManager(Product.class).txGet(productId);
				if (p==null){
					
				FileWriter fw = new FileWriter(new File("/var/buy360error.txt"),true);
				fw.write("������ƷSKU����ȷ�������ţ�="+order_id_360buy+"---����sku:"+outer_sku_id);
				fw.flush();
				fw.close();
					 //System.out.println("������ƷSKU����ȷ�������ţ�="+order_id_360buy+"---����sku:"+outer_sku_id);
				}
		    	OrderItemCache orderItem = new OrderItemCache();
				
				orderItem.setId(SequenceIdGenerator.generate("5"));
				orderItem.setOdrdtl_odrid(order.getId());//������
				orderItem.setOdrdtl_oldodrid(order.getId());
				
				orderItem.setOdrdtl_gdsid(productId);//product id
				
				
				orderItem.setOdrdtl_sku1(psku);
				orderItem.setOdrdtl_sku2("");//sku2  û��
			
				orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//��Ʒ��
				orderItem.setOdrdtl_memberprice(new Double(Tools.parseDouble(jd_price)));//��Ա��
				orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//�г���
				orderItem.setOdrdtl_vipprice(new Double(Tools.parseDouble(jd_price)));//vip ��
				
				orderItem.setOdrdtl_finalprice(new Double(Tools.parseDouble(jd_price)));//���ɽ�����
				
				orderItem.setOdrdtl_gdscount(new Long(Tools.parseLong(item_total)));//��������
				
				double sumprice=Tools.parseDouble(jd_price)*Tools.parseDouble(item_total);
				orderItem.setOdrdtl_totalmoney(new Double(sumprice));//�ɽ��ܽ��
				orderItem.setOdrdtl_purprice(new Double(p.getGdsmst_inprice()));

				orderItem.setOdrdtl_shipstatus(new Long(1));//����״̬��1Ϊδ����
				orderItem.setOdrdtl_sendcount(new Long(Tools.parseLong(item_total)));//�����������ʼ0
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
				
				orderItem.setOdrdtl_temp("�����̳�");//��Ʒ���ǣ���¼������Դ
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
				ci.setUserId("1271857");
				Tools.getManager(CartItem.class).txCreate(ci);
    	        	
			}
    	        SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    	        String end="2013-01-21 00:00:00";
    	        if(new Date().after(df.parse(end))){
    	        	  setzp(Tools.parseDouble(order_seller_price),order.getId());
    	        }
    	      
		}
		/*
		 * fullname String  ��   ���� 
full_address String ��   ��ַ 
telephone String ��   �̶��绰 
mobile String ��   �ֻ� 
province String ��   ʡ 
city String ��   �� 
county String ��   �� 
		 * */
		//����һ����¼����¼�ö����Ѿ�ͬ������


		Order360buy o360=new Order360buy();
		o360.setOdr360buy_360odrid(order_id_360buy);
		o360.setOdr360buy_d1odrid(order.getId());
		o360.setOdr360buy_name(user_name);
		o360.setOdr360buy_phone(user_mobilephone);
		o360.setOdr360buy_status(new Long(0));
		o360.setOdr360buy_createdate(new Date());
		
		Tools.getManager(Order360buy.class).txCreate(o360);
				
				
		confirmGetMoney(order.getId(),-1);//�޸Ķ���Ϊȷ���տ�״̬
		return order;
	}
	
	private void setzp(double ordermoney,String orderid){
		String gdsid="";
		String sku="";
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("giftrckdtl_mstid", new Long(781)));//������ר����Ʒ��
		clist.add(Restrictions.le("giftrckdtl_limitmoney", new Float(ordermoney)));//������ר����Ʒ��
		List<org.hibernate.criterion.Order> olist = new ArrayList<org.hibernate.criterion.Order>();
		olist.add(org.hibernate.criterion.Order.desc("giftrckdtl_limitmoney"));
		
		List<BaseEntity> resList = Tools.getManager(GiftItem.class).txGetList(clist,olist,0,10);
		if(resList!=null&&resList.size()>0){
			
				GiftItem gi = (GiftItem)resList.get(0);
				gdsid=gi.getGiftrckdtl_gdsid();
				if("01517367".equals(gdsid)){
					sku="��ɫ";
				}
				if(!Tools.isNull(gdsid)){
					Product p=ProductHelper.getById(gdsid);
					OrderItemCache orderItem = new OrderItemCache();
					
					orderItem.setId(SequenceIdGenerator.generate("5"));
					orderItem.setOdrdtl_odrid(orderid);//������
					
					orderItem.setOdrdtl_gdsid(gdsid);//product id
					
					orderItem.setOdrdtl_shopcode(p.getGdsmst_shopcode());
	                orderItem.setOdrdtl_oldodrid(orderid);
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
					
					orderItem.setOdrdtl_totalincomevalue(new Double(0));//�����̻������� ����
					orderItem.setOdrdtl_eyuan(new Double(p.getGdsmst_eyuan()));//��ƷӦ��Eȯ ��Ʒ��ȡ���۸��ܴ�����ȯ����Ʒ
					
					orderItem.setOdrdtl_spendcount(new Double(0));//���û�����
					
					orderItem.setOdrdtl_managememo("");//��Ʒ��������
					orderItem.setOdrdtl_gdspurmemo("");//�ɹ���ע 
					
					orderItem.setOdrdtl_specialflag(new Long(2));//0��ʲô�����룬1��ʾ��Ʒ������ȯ��2��ʾ���������˷���
					orderItem.setOdrdtl_gifttype("");//��Ʒ���� 
					
					orderItem.setOdrdtl_refcount(new Long(1));//�Ƿ�μӷ���ȯ������μ�Ϊ0������Ϊ1��Ŀǰû���ã�
					orderItem.setOdrdtl_jcflag(new Long(0));//û����
					orderItem.setOdrdtl_buyflag(new Long(2));    //��Ʒ��ʶ��������ƷΪ0 ��ƷΪ2
					orderItem.setOdrdtl_temp("�����̳�");//��Ʒ���ǣ���¼������Դ
					orderItem.setOdrdtl_tuancardno("");//�̻��һ�ȯ��
					
					//����������ϸ
					System.out.println("�������ݿⶩ����ϸ��"+orderItem.getId());
					Tools.getManager(OrderItemCache.class).txCreate(orderItem);
					
					//��������һ����¼������ռ��������
					CartItem ci = new CartItem();
					ci.setAmount(orderItem.getOdrdtl_gdscount());
					ci.setCreateDate(new Date());
					ci.setOrderId(orderid);
					ci.setProductId(p.getId());
					ci.setSkuId(orderItem.getOdrdtl_sku1());
					ci.setUserId("1271857");
					Tools.getManager(CartItem.class).txCreate(ci);
				}
			}
		
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
			order1.setOdrmst_ourmemo(order1.getOdrmst_ourmemo()+Tools.stockFormatDate(new Date()) +"����ͬ�������տ�");
			if(getmoney>0)order1.setOdrmst_getmoney(new Double(getmoney));
			order1.setOdrmst_validdate(new Date());
			order1.setOdrmst_orderstatus(new Long(2));//ȷ���տ�״̬
			Tools.getManager(OrderCache.class).txUpdate(order1, true);
			
			//���ô洢���̰Ѷ����޸ĳɡ�ȷ���տ״̬
			ProcedureWork work = new ProcedureWork(orderId);
			Tools.getManager(OrderMain.class).currentSession().doWork(work);//ִ��work
			*/
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
		str=str.replace("f", "����");
		str=str.replace("z", " ");
		return str;
	}
}
