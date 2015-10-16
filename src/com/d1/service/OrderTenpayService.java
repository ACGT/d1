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
 * �����Ƹ�ͨ��ض��������񷽷�
 * @author kk
 */
public class OrderTenpayService {
	/**
	 * �����Ƹ�ͨ���׵����񷽷�
	 * @return OrderCache
	 */
	public OrderCache createOrderFromTenpay(HttpServletRequest request,HttpServletResponse response) throws Exception {

		for(int i=0;i<Integer.parseInt(request.getParameter("total_product_type"));i++)
		{
			OrderTenpay ot2 =(OrderTenpay)Tools.getManager(OrderTenpay.class).txFindByProperty("tenpayOrderId", request.getParameter("transaction_id_"+i));
			if (ot2!=null) {

					FileWriter fw = new FileWriter(new File("/var/Tenpayerror.txt"),true);
					fw.write("�Ƹ�ͨ�ӿڶ���������������"+request.getParameter("transaction_id_"+i)+"�Ƹ�ͨ�������Ѿ�����"+System.getProperty("line.separator"));
					fw.flush();
					fw.close();
				return null;
			}
		}
		
		OrderCache order = new OrderCache();
		
		order.setId(OrderIdGenerator.generate());//order id��ͨ��һ��sequence������
		order.setOdrmst_id(new Long(SequenceIdGenerator.generate("4")));
		order.setOdrmst_mbrid(new Long(2316985));//���ڲƸ�ͨ�̳��µ��Ļ�Աid 
		
		order.setOdrmst_rname(request.getParameter("recv_name"));//�ջ������� 
		order.setOdrmst_orderdate(new Date());//��������
		order.setOdrmst_rsex("");
		order.setOdrmst_payid(new Long(25));//�Ƹ�֧ͨ��
		order.setOdrmst_paymethod("��Ѷ�Ƹ�ͨ");
		order.setOdrmst_paytype(new Long(4));//֧����֧����type
		order.setOdrmst_rzipcode(request.getParameter("recv_zipcode"));//�ջ����ʱ�
		order.setOdrmst_raddress(request.getParameter("recv_addr"));//�ջ��˵�ַ
		String rphone="";
		if(!Tools.isNull(request.getParameter("recv_mobile"))){
			rphone=request.getParameter("recv_mobile");
		}
		if(!Tools.isNull(request.getParameter("recv_phone"))){
			rphone=rphone+" "+request.getParameter("recv_phone");
		}
		order.setOdrmst_rphone(rphone);//�ջ��˵绰���ֻ�
		order.setOdrmst_remail("");//�ջ���email
		order.setOdrmst_rcountry("�й�");//����
		order.setOdrmst_rprovince(request.getParameter("recv_province"));//�ջ���ʡ
		order.setOdrmst_rcity(request.getParameter("recv_city")+" "+request.getParameter("recv_area"));//�ջ��˳���
		
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
		
		order.setOdrmst_pname("d1-�Ƹ�ͨ�̳�");//�����������Ϣ����Ӧǰ���id
		
		order.setOdrmst_psex("");
		order.setOdrmst_oldodrid(order.getId());//���ڲ�����𵥶���
		String buyerremark = "";
		if(request.getParameter("remark")!=null){
			buyerremark = request.getParameter("remark");
		}
		order.setOdrmst_customerword("<pan style=\"color:#FF0000\">"+buyerremark+"</span>");//�ͻ�ʱ��+�������
		
		order.setOdrmst_orderstatus(new Long(0));//����״̬
		order.setOdrmst_specialtype(new Long(0));//�û��������־��û�ã�
		
	
		
		//��ȡ��Ʒ��Ǯ
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
		order.setOdrmst_shipfee(new Double(0));//�����˷�
		}
		else{
		order.setOdrmst_shipfee(new Double(10));//�����˷�
		}
		order.setOdrmst_shipid(new Long(10));//�������
		order.setOdrmst_shipmethod("�������");
		
		order.setOdrmst_acturepaymoney(new Double(totalmoney+order.getOdrmst_shipfee()));//ʵ��֧�����
		
		order.setOdrmst_gdsmoney(new Double(totalmoney));//�ܼ�-�˷�
		
		order.setOdrmst_ordermoney(new Double(order.getOdrmst_acturepaymoney()));
		
		order.setOdrmst_getmoney(new Double(0));//�յ�����Ǯ
		order.setOdrmst_realgetmoney(new Double(0));
		
		
		order.setOdrmst_prepayvalue(new Double(0));
		order.setOdrmst_temp("�Ƹ�ͨ");//������Դ
		
		order.setOdrmst_tktvalue(new Double(0));//Eȯ���
		order.setOdrmst_tktid(new Long(0));//Eȯ��ţ���Ӧtktmst.id
		
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
		
		Tools.getManager(OrderShopCache.class).txCreate(orderShopCache);//����odrshp��¼�������¼û���ã�����̨�й�����ѯ�����Ա��봴��
		
		
		int totalProducts = new Integer(request.getParameter("total_product_type")).intValue();//���˶��ټ���Ʒ
		float giftmoney=0f;
		String gdsstr="";
		boolean flag = true ;
		if(flag){
			for(int i=0;i<totalProducts;i++){//����������ϸ
				
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
				orderItem.setOdrdtl_odrid(order.getId());//������
				
				orderItem.setOdrdtl_gdsid(gdsid);//product id
				gdsstr=gdsstr+","+gdsid;
				String gdssku1="";
				if(!Tools.isNull(request.getParameter("arg1_"+i))){
					gdssku1=java.net.URLDecoder.decode(request.getParameter("arg1_"+i), "GBK");
				}
				
				 orderItem.setOdrdtl_shopcode(p.getGdsmst_shopcode());
                 orderItem.setOdrdtl_oldodrid(order.getId());
				orderItem.setOdrdtl_sku1(gdssku1);
				orderItem.setOdrdtl_sku2("");//sku2  û��
				//1�ֱ���Ʒ 8%     2 ��ױƷ 4%  	3  ��װ 15%
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
				orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//��Ʒ��
				orderItem.setOdrdtl_memberprice(new Double(p.getGdsmst_memberprice()));//��Ա��
				orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//�г���
				orderItem.setOdrdtl_vipprice(new Double(p.getGdsmst_vipprice()));//vip ��
				double finalprice=Tools.parseDouble(request.getParameter("product_money_"+i))/Tools.parseDouble(request.getParameter("product_count_"+i));
				orderItem.setOdrdtl_finalprice(new Double(finalprice/100));//���ɽ�����
				
				orderItem.setOdrdtl_gdscount(new Long(request.getParameter("product_count_"+i)));//��������
				orderItem.setOdrdtl_totalmoney(new Double(Tools.parseDouble(request.getParameter("product_money_"+i))/100));//�ɽ��ܽ��
				orderItem.setOdrdtl_purprice(new Double(p.getGdsmst_inprice()));

				orderItem.setOdrdtl_shipstatus(new Long(1));//����״̬��1Ϊδ����
				orderItem.setOdrdtl_sendcount(new Long(request.getParameter("product_count_"+i)));//�����������ʼ0
				orderItem.setOdrdtl_creatdate(new Date());//��������
				orderItem.setOdrdtl_refundcount(new Long(0));//û����������
				orderItem.setOdrdtl_rackcode(p.getGdsmst_rackcode());
				if(p.getGdsmst_rackcode()!=null&&(p.getGdsmst_rackcode().startsWith("02")||p.getGdsmst_rackcode().startsWith("03"))){
					giftmoney+=orderItem.getOdrdtl_totalmoney().floatValue();
				}
				
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
				
				int num = new Integer(request.getParameter("product_count_"+i)).intValue();
				
				orderItem.setOdrdtl_totalincomevalue(Tools.getDouble(new Double(Tools.parseDouble(request.getParameter("product_money_"+i))/100),2));//�����̻������� ����
				orderItem.setOdrdtl_eyuan(new Double(0));//��ƷӦ��Eȯ ��Ʒ��ȡ���۸��ܴ�����ȯ����Ʒ
				
				orderItem.setOdrdtl_spendcount(new Double(0));//���û�����
				
				orderItem.setOdrdtl_managememo("");//��Ʒ��������
				orderItem.setOdrdtl_gdspurmemo("");//�ɹ���ע 
				
				orderItem.setOdrdtl_specialflag(new Long(2));//0��ʲô�����룬1��ʾ��Ʒ������ȯ��2��ʾ���������˷���
				orderItem.setOdrdtl_gifttype("");//��Ʒ���� 
				
				orderItem.setOdrdtl_refcount(new Long(1));//�Ƿ�μӷ���ȯ������μ�Ϊ0������Ϊ1��Ŀǰû���ã�
				orderItem.setOdrdtl_jcflag(new Long(0));//û����
				
				orderItem.setOdrdtl_temp("�Ƹ�ͨ�̳�");//��Ʒ���ǣ���¼������Դ
				orderItem.setOdrdtl_tuancardno("");//�̻��һ�ȯ��
				//odrdtl_egblancecode
				orderItem.setOdrdtl_egblancecode(tenpayId);///������ϸ�ͲƸ�ͨ������ӦID
				
				//����������ϸ
				System.out.println("�������ݿⶩ����ϸ��"+orderItem.getId());
				Tools.getManager(OrderItemCache.class).txCreate(orderItem);
				

				        TenpayNumFee tenpaygdsup =(TenpayNumFee)Tools.getManager(TenpayNumFee.class).txFindByProperty("tenpaynumfee_gdsstr", gdsid);
				        if(tenpaygdsup!=null&&tenpaygdsup.getTenpaynumfee_allmoney().longValue()<6){
				        	    tenpaygdsup.setTenpaynumfee_allmoney(new Float(tenpaygdsup.getTenpaynumfee_allmoney().floatValue()+num));
				        		Tools.getManager(TenpayNumFee.class).txUpdate(tenpaygdsup , true);
				        		}
	
				
				//��������һ����¼������ռ��������
				CartItem ci = new CartItem();
				ci.setAmount(orderItem.getOdrdtl_gdscount());
				ci.setCreateDate(new Date());
				ci.setOrderId(order.getId());
				ci.setProductId(p.getId());
				ci.setSkuId(orderItem.getOdrdtl_sku1());
				ci.setUserId("2316985");
				Tools.getManager(CartItem.class).txCreate(ci);
				//�����Ƹ�ͨD1������Ӧ��ϵ��
				OrderTenpay ot=new OrderTenpay();
				ot.setD1OrderId(order.getId());
				ot.setTenpayOrderId(tenpayId);//�൱��session id��һ������
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
		clist.add(Restrictions.eq("giftrckdtl_mstid", new Long(795)));//������ר����Ʒ��
		clist.add(Restrictions.le("giftrckdtl_limitmoney", new Float(ordermoney)));//������ר����Ʒ��
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
					orderItem.setOdrdtl_odrid(orderid);//������
					orderItem.setOdrdtl_oldodrid(orderid);
					orderItem.setOdrdtl_gdsid(gdsid);//product id
					
					
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
					
					orderItem.setOdrdtl_temp("�Ƹ�ͨ�̳�");//��Ʒ���ǣ���¼������Դ
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
					orderItem.setOdrdtl_odrid(orderid);//������
					
					orderItem.setOdrdtl_gdsid(gdsid);//product id
					/*��ɫ	0	0	
����	0	0	
����	0	0	
��ɫ	0	0	
����	0	0	
��ɫ	0	0	
õ��	0	0	
ǳ��	0	0	
����	0	0	
���Ϻ�	0	0	*/
					Random rndcard = new Random();
					
					String sku="";
					if(flag==1){
					String[] arrsku={"��ɫ","����","����","��ɫ","����","��ɫ","õ��","ǳ��","����","���Ϻ�"};
					int arri=rndcard.nextInt(10);
					sku=arrsku[arri];
					}else if(flag==2){
					String[] arrsku={"��ɫL","��ɫM","��ɫXL","��ɫL","��ɫM","��ɫXL","��ɫL","��ɫM","��ɫXL"};
					int arri=rndcard.nextInt(9);
					sku=arrsku[arri];
					sku="��ɫ";
					}else if(flag==3){
						String[] arrsku={"����","õ��"};
						int arri=rndcard.nextInt(2);
						sku=arrsku[arri];
						sku="õ��";
					}
					

					
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
					
					orderItem.setOdrdtl_temp("�Ƹ�ͨ�̳�");//��Ʒ���ǣ���¼������Դ
					orderItem.setOdrdtl_tuancardno("");//�̻��һ�ȯ��
					orderItem.setOdrdtl_oldodrid(orderid);
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
					ci.setUserId("2316985");
					Tools.getManager(CartItem.class).txCreate(ci);
	
		
	}
	
	/**
	 * ����ȷ���տ�Ƹ�ͨ�Ѿ����֧�� ��orderId������ڣ�����״̬������0��
	 * @param orderId ����id
	 * @param getmoney �յ�����Ǯ������0����Ч��С��0���޸ġ�
	 * @return true �����ɹ��� false��ʾû�в����������Ƕ���id������
	 * @throws Exception
	 */
	public  boolean confirmGetMoney(String orderId,float getmoney)throws Exception{
		OrderCache order1 = (OrderCache)Tools.getManager(OrderCache.class).txGet(orderId);
		if(order1==null)return false ;
		
		if(order1.getOdrmst_orderstatus()!=null&&order1.getOdrmst_orderstatus().longValue()==0){
			/*Tools.getManager(OrderCache.class).txBeforeUpdate(order1);
			order1.setOdrmst_ourmemo(order1.getOdrmst_ourmemo()+ new Date()+"�Ƹ�ͨ�տ�");
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
		
		return false ;
	}
	public int updateOrderStatus2013(OrderBase order , double dblAmount){
		if(order == null) return -1;
		//���û������������memcached�����ݿ⻺�棬���Ҫ�޸ĳɷֲ�ʽ�������ݿ���������
		synchronized(order){
			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return -2;
			//��ȷ����
			Tools.getManager(order.getClass()).txBeforeUpdate(order);
			if(dblAmount>0)order.setOdrmst_getmoney(new Double(dblAmount));
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(new Date()) +"�Ƹ�ͨ�տ�");
			order.setOdrmst_validdate(new Date());
			order.setOdrmst_orderstatus(new Long(2));
			
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
	 * ���������ȷ�϶���
	 * @param order
	 * @param dblAmount
	 * @return
	 */
	public boolean updateOrderStatus(OrderBase order , double dblAmount){
		if(order == null) return false;
		//���û������������memcached�����ݿ⻺�棬���Ҫ�޸ĳɷֲ�ʽ�������ݿ���������
		synchronized(order){
			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return false;
			//��ȷ����
			if((int)Math.round(Tools.doubleValue(order.getOdrmst_acturepaymoney())*10) != (int)Math.round(dblAmount*10)) return false;//��һ��
			Tools.getManager(order.getClass()).txBeforeUpdate(order);
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+ new Date()+"�Ƹ�ͨ�տ�");
			order.setOdrmst_validdate(new Date());
			order.setOdrmst_orderstatus(new Long(2));
			order.setOdrmst_getmoney(Tools.getDouble(new Double((double)dblAmount),2));
			
			Tools.getManager(order.getClass()).txUpdate(order, true);
			
			//���ô洢���̰Ѷ����޸ĳɡ�ȷ���տ״̬����ִ�п����޸Ķ���������
			ProcedureWork work = new ProcedureWork(order.getId());
			Tools.getManager(order.getClass()).currentSession().doWork(work);//ִ��work
			
			if(Tools.longValue(order.getOdrmst_orderstatus()) == 0) return false;
			return true;
		}
	}
	
}
