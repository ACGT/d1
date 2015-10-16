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
"%><%
//String searchUrl="https://eairiis-prddmz.paic.com.cn/invoke/wm.tn/receive?";
String searchUrl="https://jk-bis-stg.dmzstg.pingan.com.cn:7443/bis/merService";
String odrid=request.getParameter("odrid");
String act=request.getParameter("act");
if (!"chkodr".equals(act)){return;}
SAXReader reader = new SAXReader(); 
Document doc;
SimpleDateFormat fmtdoc = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	String docname=fmtdoc.format(new Date());
try {
	doc = reader.read(Const.PROJECT_PATH+"pingan/pasearch2015.xml");
	Element root = doc.getRootElement(); 
	 
	//System.out.print(doc.asXML());
	//PingAnScorePay pinganodr =(PingAnScorePay)Tools.getManager(PingAnScorePay.class).findByProperty("pinganodr_odrid", odrid);
	SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
	//System.out.print(pauplogs.size());
//if(pinganodr!=null){
	Element upnode = (Element) root.selectSingleNode("//Request/PropertySet/SiebelMessage/TTNumber");
 	//upnode.addText(odrid); 
 	upnode.addText("TTNumber0116001"); 
 	Element partner = (Element) root.selectSingleNode("//Request/PropertySet/SiebelMessage/Partner");
 	partner.addText(InterfacePost.strPayPartner); 
 // }
	//System.out.print(doc.asXML());
try {

   XMLWriter writer = new XMLWriter(new FileWriter(new File(Const.PROJECT_PATH+"pingan/pinganlog/search"+docname+".xml")));
	   writer.write(doc);
	   writer.close();
	} catch (Exception ex) {
		   ex.printStackTrace();
	}
	//String strxml= InterfacePost.Postdata(searchUrl, doc.asXML());
	//PinganBisUtil
	//Value=base64(aes(md5(data下的原生数据),key))
	String xmlStr=doc.asXML();
	String dataStr=PinganBisUtil.getNodeValues(xmlStr,  "bizdata","data");
	System.out.println(dataStr);
	String sign=PinganBisUtil.encode(dataStr, "hm.Tf5WifEI4u9hA");
	Element signel = (Element) root.selectSingleNode("//bisdata/bizdata/sign/value");
	signel.addText(sign);
	String encode=PinganBisUtil.getNodeValues(xmlStr,  "bizdata","encode");
			 	String strupurl="https://jk-bis-stg.dmzstg.pingan.com.cn:7443/bis/merService";
				String strxml= InterfacePost.PostXml("114.246.174.48",strupurl,doc.asXML());
				//String strxml= Postdata(searchUrl, doc.asXML());
   // Document docget = reader.read("WEB-INF/paget.xml");
	InputStream in = null;
	//String strxml=null;
	System.out.println(doc.asXML());
	System.out.println("d1gjlpasearch:"+strxml.getBytes("UTF-8"));
    in = new ByteArrayInputStream(strxml.getBytes("UTF-8"));
    //System.out.print(docget.asXML());
    Document docget=reader.read(in);
    /*System.out.println("d1gjlpasearch:"+docget.asXML());
  try {

	      XMLWriter writer = new XMLWriter(new FileWriter(new File(Const.PROJECT_PATH+"pingan/pinganlog/search"+docname+"get.xml")));
		   writer.write(docget);
		   writer.close();
		} catch (Exception ex) {
			   ex.printStackTrace();
		}*/
        Node rootget = docget.selectSingleNode("/PropertySet");
        List list = rootget.selectNodes("SiebelMessage");
        PingAnScoreLog pauplogup;
        SimpleDateFormat fmtnew = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for(Object o:list){
            Element e = (Element) o;
            
            out.println("ErrorCode = " +  e.elementText("ErrorCode"));
            out.println("ErrorMessage = " +e.elementText("ErrorMessage"));
        }


}
catch(Exception ex){
	ex.printStackTrace();
}

%>