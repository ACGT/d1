<%@ page contentType="text/html; charset=GBK"%><%@include file="validate.jsp"%>
<%@ page import="com.d1.bean.*,com.d1.service.*,com.d1.util.*" %>
<%
//post�������£�
//sign_type=md5&service_version=1.0&input_charset=gbk&sign_key_index=1&req_seq=10000003
//&total_product_type=1&product_id_0=100000&product_count_0=1&remark=���췢��&create_time=20110825
//&recv_name=����&recv_province=�㶫ʡ&recv_city=������&recv_area=��ɽ��&recv_addr=��Ѷ����9¥
//&recv_zipcode=518000&recv_mobile=13222222222&recv_phone=&send_type=0&transport_type=1
//&sign=12345678901234567890123456789012

/******************�̻���������

<?xml version="1.0" encoding="GBK" ?>
<root>
<sign_type>md5</sign_type>
<service_version>1.0</service_version>
    <input_charset>gbk</input_charset>
    <sign_key_index>1</sign_key_index>
    <res_seq>10000003</res_seq>

<retcode>0</retcode>
<retmsg>�µ��ɹ�</retmsg>
    <sp_billno>123456789</tsp_billno>
    <lock_start>20110825110000</lock_start>
    <lock_end>20110825110500</lock_end>
    <transport_num>3</transport_num>
    <transport_desc_0>ƽ��</transport_desc_0>  
    <transport_type_0>0</transport_type_0>
    <transport_money_0>0</transport_money_0>
    <transport_desc_1>��ͨ���</transport_desc_1>
    <transport_type_1>1</transport_type_1>
    <transport_money_1>0</transport_money_1>
    <transport_desc_2>�Ӽ����</transport_desc_2>
    <transport_type_2>2</transport_type_2>
    <transport_money_2>2000</transport_money_2>
    <sign>12345678901234567890123456789012</sign>
    </root>

*************/
        //�����Ӧxml����

		StringBuffer sb=new StringBuffer("");
		sb.append("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
		sb.append("<root>");
        sb.append("<sign_type>"+sign_type+"</sign_type>");
        sb.append("<service_version>"+service_version+"</service_version>");
        sb.append("<sign_key_index>"+sign_key_index+"</sign_key_index>");
        sb.append("<res_seq>"+req_seq+"</res_seq>");
        int fee=1000;
        if(result)
        {
        //���sign�ַ���
        ArrayList<String> results=new ArrayList<String>();
       try{
    	   OrderCache oc=null;
    	   try{
    		   System.out.println("�ۻ��µ���ʼ..........");
        OrderTenpayService ots = (OrderTenpayService)Tools.getService(OrderTenpayService.class);
		 oc=ots.createOrderFromTenpay(request, response);
    	   }
    	   catch(Exception ex1){
    		   ex1.printStackTrace();
				System.out.println("�ۻ��µ������Զ������µ�..........");
				try{
			        OrderTenpayService ots = (OrderTenpayService)Tools.getService(OrderTenpayService.class);
					 oc=ots.createOrderFromTenpay(request, response);
			    	   }
			    	   catch(Exception ex2){
			    			System.out.println("�ۻ������µ�ʧ��..........");
			    		   ex2.printStackTrace();
			
			    	   }
				
    	   }
		 //ҵ�������ȡ
        if(oc!=null)
        {
        	sb.append("<retcode>0</retcode><retmsg>�µ��ɹ�</retmsg>");
        	results.add("retcode=0");
	    	results.add("retmsg=�µ��ɹ�");
	    	 sb.append("<sp_billno>"+oc.getId()+"</sp_billno>");
	         results.add("sp_billno="+oc.getId());
	       //��ݲ������
	       
	         if (oc.getOdrmst_shipfee().doubleValue()==0){
	        	 fee=0;
	         }
	     
	         
        }
        else
        {
        	sb.append("<retcode>1</retcode><retmsg>�µ�ʧ��</retmsg>");
        	results.add("retcode=1");
	    	results.add("retmsg=�µ�ʧ��");
	    	 sb.append("<sp_billno></sp_billno>");
	         results.add("sp_billno=");
        }
       }
        catch(Exception ex){
        	/*FileWriter fw = new FileWriter(new File("/var/Tenpayerror.txt"),true);
			fw.write("�Ƹ�ͨ�ӿڶ���������������1��"+ex);
			fw.flush();
			fw.close();*/
        	sb.append("<retcode>1</retcode><retmsg>�µ�ʧ��</retmsg>");
        	results.add("retcode=1");
	    	results.add("retmsg=�µ�ʧ��");
	    	 sb.append("<sp_billno></sp_billno>");
	         results.add("sp_billno=");
        }
        
       
       
        sb.append("<transport_num>3</transport_num>");
        sb.append("<transport_desc_0>ƽ��</transport_desc_0>");
        sb.append("<transport_type_0>1</transport_type_0>");
        sb.append("<transport_money_0>"+fee+"</transport_money_0>");
        sb.append("<transport_desc_1>��ͨ���</transport_desc_1>");
        sb.append("<transport_type_1>2</transport_type_1>");
        sb.append("<transport_money_1>"+fee+"</transport_money_1>");
        sb.append("<transport_desc_2>EMS���</transport_desc_2>");
        sb.append("<transport_type_2>3</transport_type_2>");
        sb.append("<transport_money_2>"+fee+"</transport_money_2>");      
        
        results.add("transport_num=3");
        results.add("transport_desc_0=ƽ��");
        results.add("transport_type_0=1");
        results.add("transport_money_0="+fee+"");
        results.add("transport_desc_1=��ͨ���");
        results.add("transport_type_1=2");
        results.add("transport_money_1="+fee+"");
        results.add("transport_desc_2=EMS���");
        results.add("transport_type_2=3");
        results.add("transport_money_2="+fee+"");
        
        
        results.add("sign_type="+request.getParameter("sign_type"));
	    results.add("service_version="+request.getParameter("service_version"));
	    results.add("sign_key_index="+request.getParameter("sign_key_index"));
	    results.add("res_seq="+request.getParameter("req_seq"));
	    
	    
		  //�������ַ�������
		    
		    
		    Collections.sort(results);
		
	        String signtype = "";
	    
	        if(results!=null){
	        	for(String x:results){
	        		
	        		signtype+=x+"&";
	        	
	        	}
	        }
	   signtype+="key=qimenghaoyed1234567ymzou51665136";
	    //signtype+="key=123456";
        //out.print(signtype);
	    if(result)
	    {
	    	sb.append("<sign>"+com.d1.util.MD5.to32MD5(signtype)+"</sign>");
	    }
        }
        else
        {
        	sb.append("<retcode>203000</retcode>");
	    	sb.append("<retmsg>�µ�ʧ�ܿ�ʼ</retmsg>");
        }
        
        
        sb.append("</root>");
        response.setContentType("text/xml");
       
       
        out.print(sb);



%>