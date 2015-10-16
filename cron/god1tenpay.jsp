<%@ page contentType="text/html; charset=GBK"%>
<%@page import="java.io.*"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Collections"%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.SimpleExpression"%>

<%@page import="com.d1.bean.OrderBase"%>
<%@page import="com.d1.bean.OrderMain"%>
<%@page import="com.d1.bean.OrderCache"%>
<%@page import="com.d1.bean.OrderRecent"%>
<%@page import="com.d1.bean.OrderTenpay"%>
<%@page import="com.d1.bean.Product"%>
<%@page import="com.d1.dbcache.core.BaseEntity"%>
<%@page import="com.d1.helper.SkuHelper"%>
<%@page import="com.d1.service.OrderTmallService"%>
<%@page import="com.d1.util.*"%>

<%@page import="java.net.*" %>



<%!
public static boolean tenpaytrue(String orderid){
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("d1OrderId", orderid));//d1������
	
	List<BaseEntity> list = Tools.getManager(OrderTenpay.class).getList(clist, null, 0, 10000);
	boolean Tenpaystatus=true;
	if(list!=null&&list.size()>0){
		for(BaseEntity b:list){
			
			OrderTenpay ot = (OrderTenpay)b;
			if (ot.getStatus().longValue()==0){
		   Tenpaystatus=false;
		}
		}
		}

     return Tenpaystatus;
}

public static OrderBase getorderlist(String orderid){
	OrderBase odrbase=null;
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("odrmst_oldodrid", orderid));//d1������
	
	List<BaseEntity> b_list = Tools.getManager(OrderMain.class).getList(clist, null, 0, 10);
	
	if(b_list!=null){
		for(BaseEntity be:b_list){
			
			odrbase=(OrderBase)be;
			if((odrbase.getOdrmst_orderstatus().longValue()==3
					||odrbase.getOdrmst_orderstatus().longValue()==31)&&
					!Tools.isNull(odrbase.getOdrmst_d1shipmethod())&&
					odrbase.getOdrmst_goodsodrid()!=null&&
					odrbase.getOdrmst_goodsodrid().trim().length()>0){
				return odrbase;
				
			}
		}
	}	
b_list = Tools.getManager(OrderRecent.class).getList(clist, null, 0, 10);
	
	if(b_list!=null){
		for(BaseEntity be:b_list){
			
			odrbase=(OrderBase)be;
			if((odrbase.getOdrmst_orderstatus().longValue()==3
					||odrbase.getOdrmst_orderstatus().longValue()==31)&&
					!Tools.isNull(odrbase.getOdrmst_d1shipmethod())&&
					odrbase.getOdrmst_goodsodrid()!=null&&
					odrbase.getOdrmst_goodsodrid().trim().length()>0){
				return odrbase;
				
			}
		}
	}
	
     return null;
}
/**
 * �Լ�������������״̬ͬ����ÿ��һ��ʱ��ͬ��һ�Σ��������������
 * 
 * @throws Exception
 */
public synchronized void orderStateSyncGoTenpay(HttpSession session) throws Exception{
	System.out.println("�ۻ�ͬ������״̬...");
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("status", new Long(1)));//״̬Ϊ0�ĲƸ�ͨ������ʾû��ͬ��������״̬
	//clist.add(Restrictions.eq("d1OrderId", "191646083201"));//״̬Ϊ0�ĲƸ�ͨ������ʾû��ͬ��������״̬
	
	List<BaseEntity> list = Tools.getManager(OrderTenpay.class).getList(clist, null, 0, 10000);
	//System.out.println("d1gjlteset"+list.size());
	if(list!=null&&list.size()>0){
		
		String aaa="";
		for(BaseEntity b:list){
			
			OrderTenpay ot = (OrderTenpay)b;
			//System.out.println(tenpaytrue(ot.getD1OrderId())+"ͬ������״̬..."+ot.getStatus());

			if(ot.getStatus().longValue()!=1)continue;
			if(!tenpaytrue(ot.getD1OrderId()))continue;
			String d1OrderId = ot.getD1OrderId();
			OrderBase order1 = getorderlist(d1OrderId);
			
			if(order1!=null){//��������
				
				if((order1.getOdrmst_orderstatus().longValue()==3
						||order1.getOdrmst_orderstatus().longValue()==31)&&
						!Tools.isNull(order1.getOdrmst_d1shipmethod())&&
						order1.getOdrmst_goodsodrid()!=null&&
						order1.getOdrmst_goodsodrid().trim().length()>0){//ʵ�ʷ���״̬
					//System.out.println("ͬ������״̬..."+order1.getId()+order1.getOdrmst_d1shipmethod()+" �˵���="+order1.getOdrmst_goodsodrid()+" ����״̬="+order1.getOdrmst_orderstatus());

					String shipNumber = order1.getOdrmst_goodsodrid();//�˵���
					String  shipmethod= order1.getOdrmst_d1shipmethod();
					//String shipNumber = "E123456";
					String postCode="999";
					String postTenpay = "����";
					String postTele="";
					/*
					
˳����
��ͨ���
����լ����
ȫ����
Բͨ�ٵ�
����Բͨ
��ͨ���
�ϴ����
������ͨ
EMS
�����ϴ�
������ͨ
լ����
1	EMS	11185	http://www.ems.com.cn
2	˳��	4008111111	http://www.sf-express.com
3	��ͨ	021-39206666	http://www.sto.cn
4	Բͨ	021-69777888	http://www.yto.net.cn
5	�ϴ�	021-62215588	http://www.yundaex.com
6	լ����	4006789000	http://www.zjs.com.cn
7	��ͨ	021-59130908	http://www.zto.cn
8	����
95105366	http://www.cre.cn
999	����		

					*/
					if(shipmethod!=null&&shipmethod.trim().equals("EMS")){ postTenpay="EMS"; postCode="1"; postTele="11185";}
					else if(shipmethod!=null&&(shipmethod.trim().equals("��ͨ���")
							||shipmethod.trim().equals("������ͨ"))){
						postTenpay="��ͨ"; postCode="3"; postTele="021-39206666"; }
					else if(shipmethod!=null&&(shipmethod.trim().equals("������ͨ")
							||shipmethod.trim().equals("��ͨ���")))
						{ postTenpay="��ͨ"; postCode="7"; postTele="021-59130908";}//˳��
					else if(shipmethod!=null&&shipmethod.trim().equals("˳����"))
						{ postTenpay="˳��"; postCode="2"; postTele="4008111111";}//˳��
					else if(shipmethod!=null&&(shipmethod.trim().equals("լ����")
								||shipmethod.trim().equals("����լ����")))
						{ postTenpay="լ����"; postCode="6"; postTele="4006789000";}//լ����
					else if(shipmethod!=null&&(shipmethod.trim().equals("Բͨ�ٵ�")
								||shipmethod.trim().equals("����Բͨ")))
					    { postTenpay="Բͨ"; postCode="4"; postTele="021-69777888";}//Բͨ
					else if(shipmethod!=null&&(shipmethod.trim().equals("�ϴ����")
								||shipmethod.trim().equals("�����ϴ�")))
					    { postTenpay="�ϴ�"; postCode="5"; postTele="021-62215588";}//Բͨ
					else postTenpay = shipmethod.trim();
					
					//�����˵��Ź����������˾����
					/*if(shipNumber.startsWith("E")||shipNumber.startsWith("e")){ postTenpay="EMS"; postCode="1"; postTele="11185";}
					else if((shipNumber.startsWith("36")||shipNumber.startsWith("268")||shipNumber.startsWith("568")||shipNumber.startsWith("468")||shipNumber.startsWith("58"))&&shipNumber.trim().length()==12)
						{  postTenpay="��ͨ"; postCode="3"; postTele="021-39206666"; }
					else if((shipNumber.startsWith("6000")&&shipNumber.trim().length()==10))
						{ postTenpay="����"; }//����ͨ
					else if((shipNumber.startsWith("762")||shipNumber.startsWith("778"))&&shipNumber.trim().length()==12)
						{ postTenpay="��ͨ"; postCode="7"; postTele="021-59130908";}//˳��
					else if(shipNumber.startsWith("301")&&shipNumber.trim().length()==12)
						{ postTenpay="˳��"; postCode="2"; postTele="4008111111";}//˳��
					else if(shipNumber.trim().length()==10&&(shipNumber.startsWith("1")||shipNumber.startsWith("0")||shipNumber.startsWith("97")))
						{ postTenpay="լ����"; postCode="6"; postTele="4006789000";}//լ����
					else if(shipNumber.trim().length()==10)
					    { postTenpay="Բͨ"; postCode="4"; postTele="021-69777888";}//Բͨ
					else postTenpay = "����";*/
				
					ArrayList<String> results=new ArrayList<String>();
					results.add("sign_type=md5");
					results.add("service_version=1.0");
					results.add("input_charset=gbk");
					results.add("sign_key_index=1");
					results.add("spid=1212236301");
					results.add("req_seq="+new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
					results.add("deliver_result=0");
					results.add("deliver_desc=�����ɹ�");
					results.add("deliver_time="+new SimpleDateFormat("yyyyMMdd").format(order1.getOdrmst_shipdate()==null?new Date():order1.getOdrmst_shipdate()));
					results.add("transaction_id="+ot.getTenpayOrderId());
					results.add("sp_billno="+ot.getD1OrderId());
					results.add("transport_code="+postCode);
					results.add("transport_info="+postTenpay);
					//results.add("transport_billno="+order1.getOdrmst_goodsodrid());
					results.add("transport_billno="+shipNumber);
					results.add("transport_phone="+postTele);
					
					// System.out.println("<br/>"+results);
					//�������ַ�������
				    //System.out.println("55555");
				   Collections.sort(results);
				
			        String signtype = "";
			    
			        if(results!=null){
			        	for(String x:results){
			        		
			        		signtype+=x+"&";
			        	
			        	}
			        }
			        if(signtype.indexOf("&")==0)
			        {
			          signtype=signtype.substring(1, signtype.length());
			        }
			        
			       signtype+="sign="+com.d1.util.MD5.to32MD5(signtype+"key=qimenghaoyed1234567ymzou51665136");
			       // signtype+="sign="+com.d1.util.MD5.to32MD5(signtype+"key=123456");
				       
		            //String reend=HttpUtil.getUrlContentByPost("http://113.108.1.170/app/merchant/notify",signtype, "UTF-8");
		           // String reend=HttpUtil.getUrlContentByGet(StringUtils.encodeUrl("http://113.108.1.170/app/merchant/notify?"+signtype,"GBK"),"GBK");
		            String reend=HttpUtil.getUrlContentByGet(StringUtils.encodeUrl("http://juhui.tenpay.com/app/merchant/notify?"+signtype,"GBK"),"GBK");
		           //System.out.println("d1gjl:"+reend);
		            reend=reend.substring(reend.indexOf("<retcode>")+9,reend.indexOf("</retcode>"));
		           
		            if(reend.equals("0"))
		            {
						//�޸�ͬ��״̬
						System.out.print("�ۻ�ͬ�������ɹ�:"+order1.getId()+"");
						Tools.getManager(OrderTenpay.class).clearListCache(ot);
						ot.setStatus(new Long(2));
						Tools.getManager(OrderTenpay.class).update(ot, true);
						
		            }	
		            
					//System.out.println(reend);	
					//aaa+=HttpUtil.getUrlContentByPost("http://113.108.1.170/app/merchant/notify", signtype, "UTF-8");
					
				}else{
					if(order1.getOdrmst_orderstatus().longValue()<0){
						Tools.getManager(OrderTenpay.class).clearListCache(ot);
						ot.setStatus(new Long(-1));
						Tools.getManager(OrderTenpay.class).update(ot, true);
					}
					
				}
				}else{
				//System.out.println("d1���������ڣ��޸Ķ���״̬ʧ�ܡ�orderid="+d1OrderId);
				aaa+="d1���������ڣ��޸Ķ���״̬ʧ��";
				
			}
			
		}
		//return aaa;
		
	}
	//return "û��Ҫͬ��������";
	
}




%>


<%
if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){
    orderStateSyncGoTenpay(request.getSession());
}
%>