<%@ page contentType="text/html; charset=GBK"%>
<%@page import="
com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*,
javax.net.ssl.*,
com.pingan.cert.Verify.*,
com.pingan.cert.Interface.*,
com.d1.bean.OrderBase,
com.d1.bean.PingAnUser,
com.d1.helper.OrderHelper,
com.d1.helper.UserHelper,
com.d1.bean.PingAnScoreLog,
com.d1.bean.PingAnScorePay,
com.d1.bean.PingAnUser,
java.util.Date,
java.text.SimpleDateFormat,
java.util.ArrayList,
org.dom4j.Document,
org.dom4j.DocumentException,
org.dom4j.Element,
org.dom4j.io.SAXReader,
org.dom4j.io.XMLWriter,
org.dom4j.Node
"%>
<%
        String act=request.getParameter("act");
		String strOdrID=request.getParameter("odrid");
		String tuimoney=request.getParameter("tuimoney");
		//String act="canceltuihuo";
		//String strOdrID="111127017905";
		double ftuiAmount=0;
		SimpleDateFormat fmtdoc = new SimpleDateFormat("yyyyMMddHHmmss");
		String docname=fmtdoc.format(new Date());
		if("canceltuihuo".equals(act)){
			OrderBase order=OrderHelper.getById(strOdrID);
			PingAnScorePay paorder=(PingAnScorePay)Tools.getManager(PingAnScorePay.class).findByProperty("pinganodr_ttnumber", strOdrID);
             //out.println(paorder.getPinganodr_status());
            /* int orderstatus= order.getOdrmst_orderstatus().intValue();
             //if(orderstatus==3 ||orderstatus==5 ||orderstatus==6 ){out.print("此订单无须退款或还没有发完货，等发货或退货后再退款");return;}
             if(!Tools.isNull(tuimoney)&&(paorder.getPinganodr_amount().floatValue()<Tools.parseFloat(tuimoney)||Tools.parseFloat(tuimoney)<=0)){out.print("退款金额不能超过支付金额");return;}
			if(order==null || paorder==null || paorder.getPinganodr_status()!=0){out.print("订单号不存在");return;}
			*/SAXReader reader = new SAXReader(); 
			   Document doc;
			try {
				doc = reader.read(Const.PROJECT_PATH+"pingan/tuihuoi2015.xml");
				 
		     	SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
		     	SimpleDateFormat fortTTtime = new SimpleDateFormat("yyyy-MM-dd");
			   Element root = doc.getRootElement(); 
			Element thnode = (Element) root.selectSingleNode("//Request/PropertySet"); 
			Element paTuiNode = thnode.addElement("SiebelMessage"); 
			paTuiNode.addElement("ProcessName").setText("PA Redeem Process");
			paTuiNode.addElement("TerminalID").setText("");
			//paTuiNode.addElement("param").setText(paorder.getPinganodr_param());
			paTuiNode.addElement("param").setText("0902079");
			paTuiNode.addElement("FirmID").setText("");
			paTuiNode.addElement("StoreID").setText("");
			paTuiNode.addElement("Operation").setText("Redemption");
			paTuiNode.addElement("Method").setText("CancelRedeemPortionTxn");
			paTuiNode.addElement("TTNumber").setText(docname);
			paTuiNode.addElement("TTTime").setText(fortTTtime.format(new Date()));
			paTuiNode.addElement("CardNumber").setText("");
			paTuiNode.addElement("TransactionType").setText("1000");
			//paTuiNode.addElement("Amount").setText(paorder.getPinganodr_amount().toString());
			paTuiNode.addElement("Amount").setText("10");
            /*
			if(paorder.getPinganodr_amount()-order.getOdrmst_acturepaymoney()==0){
				ftuiAmount=Tools.getDouble(order.getOdrmst_acturepaymoney(), 2);
		    }
			else{
				ftuiAmount=Tools.getDouble(paorder.getPinganodr_amount()-order.getOdrmst_acturepaymoney(),2);
			}
			paTuiNode.addElement("CancelAmount").setText(ftuiAmount+"");*/
			
			//paTuiNode.addElement("CancelAmount").setText(tuimoney);
			paTuiNode.addElement("CancelAmount").setText("5");
			//paTuiNode.addElement("Partner").setText(paorder.getPinganodr_partner());
			paTuiNode.addElement("Partner").setText("79_0");
			//paTuiNode.addElement("CTNumber").setText(strOdrID);
			paTuiNode.addElement("CTNumber").setText("TTNumber0116001");
			paTuiNode.addElement("MemberType").setText("");
			//paTuiNode.addElement("MemberID").setText(paorder.getPinganodr_memberid());
			paTuiNode.addElement("MemberID").setText("110000015850196");
			paTuiNode.addElement("UserName").setText("");
			paTuiNode.addElement("PartyNo").setText("");
			paTuiNode.addElement("ReconcileTime").setText("");
			//paTuiNode.addElement("OrderId").setText(strOdrID);
			paTuiNode.addElement("OrderId").setText("TTNumber0116001");
			paTuiNode.addElement("AccountName").setText("");
			paTuiNode.addElement("TxnType").setText("");
			paTuiNode.addElement("Channel").setText("");
			paTuiNode.addElement("AttchAmount").setText("0");
			paTuiNode.addElement("MemberName").setText("");
			paTuiNode.addElement("IDType").setText("");
			paTuiNode.addElement("IDNo").setText("");
			paTuiNode.addElement("Sex").setText("");
			paTuiNode.addElement("BirthDate").setText("");
			paTuiNode.addElement("Email").setText("");
			paTuiNode.addElement("PhoneNo").setText("");
			paTuiNode.addElement("StartTime").setText("");
			paTuiNode.addElement("EndTime").setText("");
			paTuiNode.addElement("QueryYear").setText("");
			paTuiNode.addElement("QueryMonth").setText("");
			paTuiNode.addElement("pagesize").setText("");
			paTuiNode.addElement("startrownum").setText("");
			paTuiNode.addElement("recordcountneeded").setText("");
			paTuiNode.addElement("Sortorder").setText("");
			paTuiNode.addElement("searchspec").setText("");
			paTuiNode.addElement("Ext1").setText("");
			paTuiNode.addElement("Ext2").setText("");
			try {

		      XMLWriter writer = new XMLWriter(new FileWriter(new File(Const.PROJECT_PATH+"pingan/pinganlog/TH"+docname+".xml")));
			   writer.write(doc);
			   writer.close();
			} catch (Exception ex) {
				   ex.printStackTrace();
			}
         //String strxml= InterfacePost.Postdata(InterfacePost.strTuiHuo, doc.asXML());
       String xmlStr=doc.asXML();
	String dataStr=PinganBisUtil.getNodeValues(xmlStr,  "bizdata","data");
	System.out.println(dataStr);
	String sign=PinganBisUtil.encode(dataStr, "hm.Tf5WifEI4u9hA");
	Element signel = (Element) root.selectSingleNode("//bisdata/bizdata/sign/value");
	signel.addText(sign);
	String encode=PinganBisUtil.getNodeValues(xmlStr,  "bizdata","encode");
			 	String strupurl="https://jk-bis-stg.dmzstg.pingan.com.cn:7443/bis/merService";
				String strxml= InterfacePost.PostXml("114.246.174.48",strupurl,doc.asXML());
         InputStream in = null;
         in = new ByteArrayInputStream(strxml.getBytes("utf-8"));
         System.out.println(doc.asXML());
         Document docget=reader.read(in);
        System.out.println("d1gjlth"+strxml);
         try {

		      XMLWriter writer = new XMLWriter(new FileWriter(new File(Const.PROJECT_PATH+"pingan/pinganlog/TH"+docname+"get.xml")));
			   writer.write(docget);
			   writer.close();
			} catch (Exception ex) {
				   ex.printStackTrace();
			}
             Node rootget = docget.selectSingleNode("/PropertySet");
             List list = rootget.selectNodes("SiebelMessage");
             PingAnScorePay pinganodr= new PingAnScorePay();
             SimpleDateFormat fmtnew = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
             for(Object o:list){  
             Element e = (Element) o;    
             if("00".equals(e.elementText("ErrorCode"))){
          	   pinganodr=(PingAnScorePay)Tools.getManager(PingAnScorePay.class).findByProperty("pinganodr_ttnumber", strOdrID);
          	   if(pinganodr!=null && pinganodr.getPinganodr_status()==0){
          		 PingAnScorePay pinganodr1=new PingAnScorePay();
          		   pinganodr1.setPinganodr_operation(pinganodr.getPinganodr_operation());
              	   pinganodr1.setPinganodr_method(pinganodr.getPinganodr_method());
              	   pinganodr1.setPinganodr_partner(pinganodr.getPinganodr_partner());
              	   pinganodr1.setPinganodr_amount(pinganodr.getPinganodr_amount());
              	    pinganodr1.setPinganodr_ttnumber(pinganodr.getPinganodr_ttnumber()+"1");
              	    pinganodr1.setPinganodr_tttime(pinganodr.getPinganodr_tttime());
              	    pinganodr1.setPinganodr_ctnumber(pinganodr.getPinganodr_ctnumber());
              	    pinganodr1.setPinganodr_status(new Long(-2));
              	    pinganodr1.setPinganodr_memberid(pinganodr.getPinganodr_memberid());
              	    pinganodr1.setPinganodr_odrid(pinganodr.getPinganodr_odrid());
              	    pinganodr1.setPinganodr_errorcode(pinganodr.getPinganodr_errorcode());
                	pinganodr1.setPinganodr_tuitime(pinganodr.getPinganodr_tuitime());
              	   //Tools.getManager(PingAnScorePay.class).create(pinganodr1);
          
              	 PingAnScorePay pinganodr2=new PingAnScorePay();
              	pinganodr2.setPinganodr_operation("Redemption");
              	pinganodr2.setPinganodr_method("CancelRedeemPortionTxn");
              	pinganodr2.setPinganodr_partner("79_0");
              	pinganodr2.setPinganodr_amount(Tools.parseFloat(tuimoney));
              	pinganodr2.setPinganodr_ttnumber(docname);
              	pinganodr2.setPinganodr_memberid(pinganodr.getPinganodr_memberid());
              	pinganodr2.setPinganodr_tttime(pinganodr.getPinganodr_tttime());
              	pinganodr2.setPinganodr_ctnumber(strOdrID);
              	pinganodr2.setPinganodr_status(new Long(-1));
              	pinganodr2.setPinganodr_odrid(strOdrID);
              	pinganodr2.setPinganodr_errorcode(e.elementText("ErrorCode"));
              	pinganodr2.setPinganodr_tuitime(new Date());
      	       //Tools.getManager(PingAnScorePay.class).create(pinganodr2);
 
      	        pinganodr.setPinganodr_ctnumber(docname);
      	       pinganodr.setPinganodr_amount(pinganodr.getPinganodr_amount().floatValue()-Tools.parseFloat(e.elementText("TCAmount")));
      	       //Tools.getManager(PingAnScorePay.class).update(pinganodr, false);
      	            order.setOdrmst_refundtype(new Long(16));
      	            order.setOdrmst_refundmentmoney(new Double(order.getOdrmst_getmoney().doubleValue()-order.getOdrmst_acturepaymoney().doubleValue()));
      	          //  Tools.getManager(order.getClass()).update(order, false);
      	            out.print("成功!");
          	   }
                  	   
          	   
                 }
                 else {
              	 out.print(e.elementText("ErrorMessage"));
                 
                 }
             }
			//System.out.print(strxml);
			} catch (DocumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}
%>