<%@ page contentType="text/html; charset=GBK"%><%@include file="validate.jsp"%>
<%@ page import="com.d1.bean.*,com.d1.service.*,com.d1.util.*,org.hibernate.criterion.*,com.d1.dbcache.core.BaseEntity" %><%
//post����
//sign_type=md5&service_version=1.0&
//input_charset=gbk&sign_key_index=1&
//req_seq=10000004&total_fee=11000&
//fee_type=1&transaction_id=1234567890123456789012345678&
//sp_billno=123456789&time_end=20110825110300&
//transport_type=1&transport_fee=1000&
//product_fee=10000&sign=12345678901234567890123456789012


/******************�̻���������

<?xml version="1.0" encoding="GBK" ?>
<root>
<sign_type>md5</sign_type>
<service_version>1.0</service_version>
    <input_charset>gbk</input_charset>
    <sign_key_index>1</sign_key_index>
    <res_seq>10000004</res_seq>

<retcode>0</retcode>
<retmsg>�ɹ�</retmsg>
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
		if(result)
		{
		ArrayList<String> results=new ArrayList<String>();
		
		
		OrderTenpayService ots = (OrderTenpayService)Tools.getService(OrderTenpayService.class);
		if(request.getParameter("sp_billno")!=null&&request.getParameter("total_fee")!=null&&request.getParameter("transaction_id")!=null)
		{
			 double feei=Tools.parseDouble(request.getParameter("transport_fee"))/100;
		      String include_transport=request.getParameter("include_transport");
		     if(Tools.isNull(include_transport))
		     {
		    	 include_transport="";
		     }
		      double total_fee=Tools.parseDouble(request.getParameter("total_fee"))/100;
			OrderTenpay uptenpay =(OrderTenpay)Tools.getManager(OrderTenpay.class).findByProperty("tenpayOrderId", request.getParameter("transaction_id"));
			uptenpay.setTotal_fee(Tools.getDouble(total_fee,2));
			uptenpay.setTransport_fee(Tools.getDouble(feei,2));
			uptenpay.setInclude_transport(include_transport);
			uptenpay.setStatus(new Long(1));
			Tools.getManager(OrderTenpay.class).update(uptenpay, true);
			OrderItemCache orderitemcache = (OrderItemCache)Tools.getManager(OrderItemCache.class).findByProperty("odrdtl_egblancecode", request.getParameter("transaction_id"));
			//System.out.println("�տ"+request.getParameter("transaction_id"));
			//System.out.println("�տ"+orderitemcache.getOdrdtl_gdscount());
			//System.out.println("�տ"+total_fee+"------"+feei);
			if (orderitemcache!=null){
			orderitemcache.setOdrdtl_finalprice(Tools.getDouble(((total_fee-feei)/orderitemcache.getOdrdtl_gdscount().longValue()),2));
			orderitemcache.setOdrdtl_totalmoney(Tools.getDouble((total_fee-feei),2));
			Tools.getManager(OrderItemCache.class).update(orderitemcache, true);
			}
			List<SimpleExpression> clist2 = new ArrayList<SimpleExpression>();
			clist2.add(Restrictions.eq("d1OrderId", request.getParameter("sp_billno")));//d1������

			List<BaseEntity> list22 = Tools.getManager(OrderTenpay.class).getList(clist2, null, 0, 10000);
			
			

			
			boolean Tenpaystatus=false;
			double tmoney=0;
			double allnummoney=0;
			String gdsstr="";
			double allmoney=0;
			double allfee=0;
			String tejiastr="";
			
			if(list22!=null&&list22.size()>0){
				for(BaseEntity b:list22){
					
					OrderTenpay ot = (OrderTenpay)b;
					if (ot.getStatus().longValue()==0){
				   Tenpaystatus=true;
				   }
					  tmoney+=ot.getTotal_fee().doubleValue();
					  allfee+=ot.getTransport_fee().doubleValue();
					  tejiastr+=ot.getInclude_transport();
				}
			}
			//System.out.println("d1jgjl:"+request.getParameter("sp_billno")+"="+tmoney+"----"+freeflag+"---Tenpaystatus="+Tenpaystatus);
			if (!Tenpaystatus){
			boolean result1=true;
			try{
				OrderCache ordercache2 = (OrderCache)Tools.getManager(OrderCache.class).get(request.getParameter("sp_billno"));
            	if(Tools.getDouble(tmoney,2)>=Tools.getDouble(ordercache2.getOdrmst_acturepaymoney().doubleValue(), 2)
            			||tejiastr!="")
				{
					result=ots.confirmGetMoney(request.getParameter("sp_billno"), Float.parseFloat(Tools.getDouble(tmoney,2)+""));

					if(result)
					{
						OrderCache ordercache = (OrderCache)Tools.getManager(OrderCache.class).get(request.getParameter("sp_billno"));
						if(ordercache!=null)
						{
							//����һ����¼����¼�ö����Ѿ�ͬ������
							/*OrderTenpay ot = new OrderTenpay();
							ot.setD1OrderId(request.getParameter("sp_billno"));
							ot.setTenpayOrderId(request.getParameter("transaction_id"));//�൱��session id��һ������
							ot.setStatus(new Long(0));
							Tools.getManager(OrderTenpay.class).create(ot);
							*/
							Tools.getManager(ordercache.getClass()).clearListCache(ordercache);
							ordercache.setOdrmst_realgettime(new Date());
							//ordercache.setOdrmst_shipfee(Tools.parseDouble(request.getParameter("transport_fee")));
							//ordercache.setOdrmst_gdsmoney(Tools.parseDouble(request.getParameter("product_fee")));
							ordercache.setOdrmst_taxflag(Tools.parseLong(request.getParameter("need_invoice")));
								int p = Tools.parseInt(request.getParameter("send_type"));
								String deliver="";
							switch (p){
								case 1:
									deliver="ֻ�������ͻ�";
									break;
								case 2:
									deliver="ֻ��ĩ�ͻ�";
									break;
								case 3:
									deliver="��������ĩ�����ͻ�";
									break;
							}
							int sendid = Tools.parseInt(request.getParameter("split_send"));
							String memo="";
						switch (sendid){
							case 0:
								memo="���ܷ�������";
								break;
							case 1:
								memo="�����ܷ�������";
								break;
						}
						
						int transport_type = Tools.parseInt(request.getParameter("transport_type"));
						String transport_typetx="";
						switch (transport_type){
							case 1:
								transport_typetx="ƽ��";
								break;
							case 2:
								transport_typetx="��ͨ���";
								break;
							case 3:
								transport_typetx="EMS���";
								break;
						}
						
							//�ͻ�ʱ��+�������//
							//fee_type=1&input_charset=gbk&need_invoice=0&product_fee=2900&req_seq=201301061425993503&send_type=2&service_version=1.0&sign_key_index=1&sign_type=md5&sp_billno=130106006891&split_send=0&time_end=20130106175351&total_fee=3900&transaction_id=1212236301201301060213589765
							//&transport_fee=1000&transport_type=1&key=qimenghaoyed1234567ymzou51665136
					       
					      ordercache.setOdrmst_internalmemo(ordercache.getOdrmst_internalmemo()+ "[�ͻ�ʱ��:"+deliver+" �����ǰ��ϵ,����ǩ�� �뵱������������ױƷ���ղ��ɲ��Ʒ��װ��]<br><span style=\"color:#FF0000\">�������:"+memo+"&nbsp;&nbsp;������ʽ��"+transport_typetx+"</span><br>�Ż�˵����"+tejiastr);
					      ordercache.setOdrmst_shipfee(new Double(allfee));//�����˷�
					     // ordercache.setOdrmst_tktvalue(new Double(ordercache.getOdrmst_acturepaymoney().doubleValue()-tmoney));
					    //  ordercache.setOdrmst_acturepaymoney(new Double(tmoney));
					      ordercache.setOdrmst_getmoney(new Double(tmoney));
					      ordercache.setOdrmst_ordermoney(new Double(tmoney));
					      ordercache.setOdrmst_gdsmoney(new Double(tmoney-allfee));
							String fpcontent="";
							if(request.getParameter("need_invoice")!=null&&request.getParameter("need_invoice").length()>0&&request.getParameter("need_invoice").equals("1"))
							{
								if(request.getParameter("invoice_title_type")!=null&&request.getParameter("invoice_title_type").length()>0)
								{
									if(request.getParameter("invoice_title_type").equals("1")){
									   fpcontent+="̧ͷ �Ǹ���&nbsp;&nbsp;";
									}
									else
									{
										fpcontent+="̧ͷ �ǹ�˾&nbsp;&nbsp;";
									}
								}
								if(request.getParameter("invoice_title_content")!=null&&request.getParameter("invoice_title_content").length()>0)
								{
									
										fpcontent+="̧ͷ���� ��"+request.getParameter("invoice_title_content")+"&nbsp;&nbsp;��Ʊ����:"+request.getParameter("invoice_content");
								}
								ordercache.setOdrmst_customerword(ordercache.getOdrmst_customerword()+"����Ʊ&nbsp;&nbsp;"+fpcontent+"<br>�ͻ�ʱ��:"+deliver);
								
							
							}
							if(!Tools.getManager(ordercache.getClass()).update(ordercache,true))
							{
								result1=false;
							}
							
						}
						else
						{
							result1=false;
						}
						
					}
					else
					{
						result1=false;
					}
				}
				else
				{
					result1=false;
				}
			}
			catch(Exception ex)
			{
				//out.print(ex.getMessage());
				result1=false;
				
			}

			if(result1)
			{
				sb.append("<retcode>0</retcode>");
				sb.append("<retmsg>�ɹ�</retmsg>");
				results.add("retcode=0");
		    	results.add("retmsg=�ɹ�");
				
			}
			else
			{
				sb.append("<retcode>1</retcode>");
				sb.append("<retmsg>ʧ��</retmsg>");
				results.add("retcode=1");
		    	results.add("retmsg=ʧ��");
			}
			}
			else{
				sb.append("<retcode>0</retcode>");
				sb.append("<retmsg>�ɹ�</retmsg>");
				results.add("retcode=0");
		    	results.add("retmsg=�ɹ�");
			}
		}
		else
		{
			sb.append("<retcode>1</retcode>");
			sb.append("<retmsg>ʧ��</retmsg>");
			results.add("retcode=1");
	    	results.add("retmsg=ʧ��");
		}
			
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
        //System.out.println("d1gjldeliver:"+signtype);
	    if(result)
	    {
	    	sb.append("<sign>"+com.d1.util.MD5.to32MD5(signtype)+"</sign>");
	    }
	    
		}
		else
		{
			sb.append("<retcode>204000</retcode>");
	    	sb.append("<retmsg>����ʧ�ܿ�ʼ</retmsg>");
		}
		sb.append("</root>");
		response.setContentType("text/xml");
		out.print(sb);




%>