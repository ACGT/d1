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
java.net.URLEncoder,
java.text.SimpleDateFormat,
java.util.Date,
javax.net.ssl.*,
java.net.*,
java.text.SimpleDateFormat,
java.util.ArrayList,
java.util.Date,
org.dom4j.Document,
org.dom4j.DocumentException,
org.dom4j.Element,
org.dom4j.io.SAXReader,
org.dom4j.io.XMLWriter,
org.dom4j.Node
"%><%!
private  ArrayList<PingAnScoreLog> getpauplog(){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("status", new Long(0)));//有效的
		
		List<BaseEntity> resList = Tools.getManager(PingAnScoreLog.class).getList(clist,null,0,200);
		ArrayList<PingAnScoreLog> list = new ArrayList<PingAnScoreLog>();
		if(resList!=null){
			for(int i=0;i<resList.size();i++){
				list.add((PingAnScoreLog)resList.get(i));
				System.out.println((PingAnScoreLog)resList.get(i));
			}
		}
		return list ;
	}
%><%
SAXReader reader = new SAXReader(); 
		   Document doc;
		   SimpleDateFormat fmtdoc = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String docname=fmtdoc.format(new Date());
			int count=0;
		try {
			doc = reader.read(Const.PROJECT_PATH+"pingan/upload2015.xml");
			Element root = doc.getRootElement(); 
			//System.out.print(doc.asXML());
			
			ArrayList<PingAnScoreLog> pauplogs = getpauplog();
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			//System.out.print(pauplogs.size());
			count=pauplogs.size();
		if(pauplogs!=null&&pauplogs.size()>0){
			Element upnode = (Element) root.selectSingleNode("//Request/PropertySet/SiebelMessage");	
			for(int j=0;j<pauplogs.size();j++){
				PingAnScoreLog pauplog = pauplogs.get(j);
				Element upnodez = upnode.addElement("ListOfPoints");     
				upnodez.addElement("MemberCode").setText(pauplog.getMembercode());
				upnodez.addElement("MemCodeType").setText(pauplog.getMemcodetype().toString());
				upnodez.addElement("BasePoints").setText(pauplog.getBasepoints().toString());
				upnodez.addElement("PartnerCode").setText(pauplog.getPartnercode());
				upnodez.addElement("ProductNum").setText(pauplog.getProductnum());
				upnodez.addElement("TransDate").setText(fmt.format(pauplog.getTransdate()));
				upnodez.addElement("TransNum").setText(pauplog.getTransnum());
				upnodez.addElement("OrderId").setText(pauplog.getOrderid());
		       }
		     }
			  try {

		      XMLWriter writer = new XMLWriter(new FileWriter(new File(Const.PROJECT_PATH+"pingan/pinganlog/"+docname+"upload.xml")));
			   writer.write(doc);
			   writer.close();
			} catch (Exception ex) {
				   ex.printStackTrace();
			}
			  String xmlStr=doc.asXML();
				String dataStr=PinganBisUtil.getNodeValues(xmlStr,  "bizdata","data");
				System.out.println(dataStr);
				String sign=PinganBisUtil.encode(dataStr, "hm.Tf5WifEI4u9hA");
				Element signel = (Element) root.selectSingleNode("//bisdata/bizdata/sign/value");
				signel.addText(sign); 
				String encode=PinganBisUtil.getNodeValues(xmlStr,  "bizdata","encode");
			 	String strupurl="https://jk-bis-stg.dmzstg.pingan.com.cn:7443/bis/merService";
				String strxml= InterfacePost.PostXml("210.14.155.200",strupurl,doc.asXML());
			//String  upodrurl="https://jk-bis-stg.dmzstg.pingan.com.cn:7443/bis/merService";
			//String strxml= InterfacePost.Postdata(InterfacePost.strUpodr, doc.asXML());
				//String strxml= HttpUtil.postData(upodrurl, PinganBisUtil.encrypt(doc.asXML(),"hm.Tf5WifEI4u9hA"), "UTF-8");
			//System.out.println("============>"+doc.asXML());
			//String strxml= Postdata(InterfacePost.strUpodr, doc.asXML());
	          // Document docget = reader.read("WEB-INF/paget.xml");
	           System.out.println("d1gjlpingan:"+strxml);
			InputStream in = null;
			//String strxml=null;
	           in = new ByteArrayInputStream(strxml.getBytes("UTF-8"));
	           Document docget=reader.read(in);
	           //System.out.println("d1gjlpingan:"+docget.asXML());
	           try {

	 		      XMLWriter writer = new XMLWriter(new FileWriter(new File(Const.PROJECT_PATH+"pingan/pinganlog/"+docname+"uploadget.xml")));
	 			   writer.write(docget);
	 			   writer.close();
	 			} catch (Exception ex) {
	 				   ex.printStackTrace();
	 			}
	               Node rootget = docget.selectSingleNode("/PropertySet/SiebelMessage");
	               List list = rootget.selectNodes("ListOfPoints");
	               PingAnScoreLog pauplogup;
	               SimpleDateFormat fmtnew = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	               for(Object o:list){
	                   Element e = (Element) o;
	                   pauplogup=(PingAnScoreLog)Tools.getManager(PingAnScoreLog.class).findByProperty("transnum", e.elementText("TransNum"));
	                   if("00".equals(e.elementText("SerrorCode"))
	                		&& pauplogup!=null && pauplogup.getStatus().longValue()==0){
	                	  // Tools.getManager(pauplogup.getClass()).clearListCache(pauplogup);
	                	   pauplogup.setStatus(new Long(2));
	                	  // if ("00".equals(e.elementText("SerrorCode"))){
	                	   pauplogup.setSenddate(new Date());
	                	  // }
	                	   pauplogup.setPalog(pauplogup.getPalog()+"<br>"+fmtnew.format(new Date())+" upload success");
	                	  // Tools.getManager(pauplogup.getClass()).update(pauplogup, true);
	                   }
	                   else if(pauplogup!=null && pauplogup.getStatus().longValue()==0){
	                	  // Tools.getManager(pauplogup.getClass()).clearListCache(pauplogup);
	                	   pauplogup.setStatus(new Long(-9));
	                	   pauplogup.setSenddate(new Date());
	                	   pauplogup.setPalog(pauplogup.getPalog()+"<br>"+fmtnew.format(new Date())+" upload err");
	                	 //  Tools.getManager(pauplogup.getClass()).update(pauplogup, true);
	                   }

	               }
	   

		}
		catch(Exception ex){
			ex.printStackTrace();
		}
        System.out.println("成功上传记录： " + count+"条");
%>