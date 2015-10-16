<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%>
<%@page import="
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
		SimpleDateFormat fmtdoc = new SimpleDateFormat("yyyyMMddHHmmss");
		String docname=fmtdoc.format(new Date());

		
		//PingAnScoreLog palog=(PingAnScoreLog)Tools.getManager(PingAnScoreLog.class).findByProperty("status", new Long(-1));
		PingAnScoreLog palog=(PingAnScoreLog)Tools.getManager(PingAnScoreLog.class).findByProperty("transnum", "196102051783");
             //out.println(paorder.getPinganodr_status());

         if(palog==null){out.print("订单号不存在");return;}
			SAXReader reader = new SAXReader(); 
			   Document doc;
			try {
				doc = reader.read(Const.PROJECT_PATH+"pingan/tuihuo2015.xml");
				 
		     	SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
		     	SimpleDateFormat fortTTtime = new SimpleDateFormat("yyyy-MM-dd");
			   Element root = doc.getRootElement(); 
			  
			/*  
	<Request>
    <PropertySet>
      <SiebelMessage>
        <ListOfPoints>
        </ListOfPoints>
        <ListOfPoints>
        </ListOfPoints>
        <Method>CancelAccrualTxn</Method>
        <PartnerCode>79_0</PartnerCode>
        <MemberCode>110000020220991</MemberCode>
        <MemCodeType>3</MemCodeType>
        <TransNum>111108004936</TransNum>
        <BasePoints>1196.4</BasePoints>
        <PreTransDate>2011-11-08</PreTransDate>
        <THTransDate>2011-11-18</THTransDate>
        <ProductNum>0902034</ProductNum>
        <OrderId>111108004936</OrderId>
      </SiebelMessage>
    </PropertySet>
  </Request>
			dl1.InnerXml="CancelAccrualTxn";
			dl2.InnerXml=dr["PartnerCode"].ToString();
			dl3.InnerXml=dr["MemberCode"].ToString();
			dl4.InnerXml=dr["MemCodeType"].ToString();
			dl5.InnerXml=dr["TransNum"].ToString();
			dl6.InnerXml=dr["BasePoints"].ToString();
			dl7.InnerXml=(Convert.ToDateTime(dr["transdate"])).ToString("yyyy-MM-dd",DateTimeFormatInfo.InvariantInfo);
			dl8.InnerXml=(Convert.ToDateTime(dr["tuihuodate"])).ToString("yyyy-MM-dd",DateTimeFormatInfo.InvariantInfo);
			dl9.InnerXml=dr["ProductNum"].ToString();
			dl10.InnerXml=dr["OrderId"].ToString();
			*/
			Element paTuiNode = (Element) root.selectSingleNode("//Request/PropertySet/SiebelMessage"); 
			paTuiNode.addElement("Method").setText("CancelAccrualTxn");
			paTuiNode.addElement("PartnerCode").setText(palog.getPartnercode());
			paTuiNode.addElement("MemberCode").setText(palog.getMembercode());
			paTuiNode.addElement("MemCodeType").setText(palog.getMemcodetype().toString());
			paTuiNode.addElement("TransNum").setText(palog.getTransnum());
			paTuiNode.addElement("BasePoints").setText(palog.getBasepoints().toString());
			paTuiNode.addElement("PreTransDate").setText(fortTTtime.format(palog.getTransdate()));
			//paTuiNode.addElement("THTransDate").setText(fortTTtime.format(palog.getTuihuodate()));
			paTuiNode.addElement("THTransDate").setText(fortTTtime.format(palog.getTransdate()));
			paTuiNode.addElement("ProductNum").setText(palog.getProductnum());
			paTuiNode.addElement("OrderId").setText(palog.getOrderid());
			
		//String posturl="https://eairiis-prddmz.paic.com.cn/invoke/wm.tn/receive?";
        // String strxml= InterfacePost.Postdata(posturl, doc.asXML());
          String xmlStr=doc.asXML();
				String dataStr=PinganBisUtil.getNodeValues(xmlStr,  "bizdata","data");
				System.out.println(dataStr);
				String sign=PinganBisUtil.encode(dataStr, "hm.Tf5WifEI4u9hA");
				Element signel = (Element) root.selectSingleNode("//bisdata/bizdata/sign/value");
				signel.addText(sign); 
         String encode=PinganBisUtil.getNodeValues(xmlStr,  "bizdata","encode");
			 	String strupurl="https://jk-bis-stg.dmzstg.pingan.com.cn:7443/bis/merService";
				String strxml= InterfacePost.PostXml("210.14.155.200",strupurl,doc.asXML());
				try {

				      XMLWriter writer = new XMLWriter(new FileWriter(new File(Const.PROJECT_PATH+"pingan/pinganlog/JFTH"+docname+".xml")));
					   writer.write(doc);
					   writer.close();
					} 
					catch (Exception ex) {
						   ex.printStackTrace();
					}
         InputStream in = null;
         in = new ByteArrayInputStream(strxml.getBytes("utf-8"));
        
         Document docget=reader.read(in);
         //System.out.println("现在退货："+docget.asXML());
         try {

		      XMLWriter writer = new XMLWriter(new FileWriter(new File(Const.PROJECT_PATH+"pingan/pinganlog/JFTH"+docname+"get.xml")));
			   writer.write(docget);
			   writer.close();
			} catch (Exception ex) {
				   ex.printStackTrace();
			}
         /*
         <PropertySet>
  <SiebelMessage>
    <ErrorCode>00</ErrorCode>
    <ErrorMessage>成功</ErrorMessage>
  </SiebelMessage>
</PropertySet>
         */
          Node rootget = docget.selectSingleNode("/PropertySet");
             List list = rootget.selectNodes("SiebelMessage");
             PingAnScorePay pinganodr= new PingAnScorePay();
             SimpleDateFormat fmtnew = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
             for(Object o:list){  
             Element e = (Element) o;    
             if("00".equals(e.elementText("ErrorCode"))){
            	 Tools.getManager(palog.getClass()).clearListCache(palog);
            	 palog.setStatus(new Long(-2));
            	 palog.setPalog(palog.getPalog()+"<br>"+fmtnew.format(new Date())+ "tuijifen success");
       	        //Tools.getManager(PingAnScoreLog.class).update(palog, true);
      	            //out.print("成功!");
      	          out.print(e.elementText("ErrorMessage"));
                 }
                 else {
                	 Tools.getManager(palog.getClass()).clearListCache(palog);
                	 palog.setStatus(new Long(-8));
                	 palog.setPalog(palog.getPalog()+"<br>"+fmtnew.format(new Date())+ "tuijifen err");
           	      //  Tools.getManager(PingAnScoreLog.class).update(palog, true);
              	 out.print(e.elementText("ErrorMessage"));
                 
                 }
             }
			//System.out.print(strxml);
			} catch (DocumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				
			} 
%>