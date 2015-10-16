<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.*"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%>
<%@include file="/ShowOrder/myshow.jsp"%>
<%!
/**
 * 快递查询接口方法
 * 
 * @param key
 *            ：商家用户key值，在http://www.kuaidi100.com/openapi申请的
 * @param com
 *            ：快递公司代码，在http://www.kuaidi100.com/openapi网上的技术文档里可以查询到
 * @param nu
 *            ：快递单号，请勿带特殊符号，不支持中文（大小写不敏感）
 * @return 快递100返回的url，然后放入页面iframe标签的src即可
 * @see
 */
public String searchkuaiDiInfo(String key, String com, String nu)
{
    String content = "";
    try
    {
        URL url = new URL("http://www.kuaidi100.com/applyurl?key=" + key + "&com=" + com
                          + "&nu=" + nu);
        URLConnection con = url.openConnection();
        con.setAllowUserInteraction(false);
        InputStream urlStream = url.openStream();
        byte b[] = new byte[10000];
        int numRead = urlStream.read(b);
        content = new String(b, 0, numRead);
        while (numRead != -1)
        {
            numRead = urlStream.read(b);
            if (numRead != -1)
            {
                // String newContent = new String(b, 0, numRead);
                String newContent = new String(b, 0, numRead, "UTF-8");
                content += newContent;
            }
        }
        urlStream.close();
    }
    catch (Exception e)
    {
        e.printStackTrace();
    }
    return content;
}
private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
public int getPsid(String shipname){
	int psid=0;
	if(shipname.indexOf("EMS")>=0 ){
		psid=1;
	}else if(shipname.indexOf("圆通")>=0 ){
		psid=2;
	}else if(shipname.indexOf("韵达")>=0 ){
		psid=3;
	}else if(shipname.indexOf("顺丰")>=0 ){
		psid=4;
	}else if(shipname.indexOf("申通")>=0 ){
		psid=5;
	}else if(shipname.indexOf("中通")>=0 ){
		psid=6;
	}else if(shipname.indexOf("优速")>=0 ){
		psid=7;
	}else if(shipname.indexOf("天天")>=0 ){
		psid=8;
	}else if(shipname.indexOf("国通")>=0 ){
		psid=9;
	}else if(shipname.indexOf("汇通快递")>=0 ){
		psid=10;
	}else if(shipname.indexOf("全峰")>=0 ){
		psid=11;
	}else if(shipname.indexOf("百世汇通")>=0 ){
		psid=12;
	}else if(shipname.indexOf("宅急送")>=0 ){
		psid=13;
	}
	return psid;
}
public String getPsTitle(int psId)
   {
	   String result="";
	   switch(psId)
	   {
	   case 3002:
		   result="EMS";
		   break;
	   case 1011:
		   result="申通快递";
		   break;
	   case 4024:
		   result="北京乐运通";
		   break;
	   case 2001:
		   result="宅急送";
		   break;
	   default:
			   result="";
			   break;
	   }   
	   return result;
   }
public String getPsHref(int psId)
{
	   String result="";
	   switch(psId)
	   {
		   case 1:
			   result="http://www.ems.com.cn/";
			   break;
		   case 2:
			   result="http://www.yto.net.cn/";
			   break;
		   case 3:
			   result="http://www.yundaex.com/";
			   break;	  
		   case 4:
			   result="http://www.sf-express.com/cn/sc";
			   break;
		   case 5:
			   result="http://www.sto.cn/";
			   break;
		   case 6:
			   result="http://www.zto.cn";
			   break;
		   case 11:
			   result="http://www.qfkd.com.cn";
			   break;
		   case 13:
			   result="http://www.zjs.com.cn/WS_Business/WS_Business_GoodsTrack.aspx/";
			   break;		   

		   default:
				   result="";
				   break;
	   }
	   return result;
}
public String getPsPhone(int psId)
{
	   String result="";
	   switch(psId)
	   {
	   
	       case 1:
		      result="11185";
			   break;
	       case 2:
			   result="010-81974057";
			   break;
	       case 3:
			   result="400-821-6789";
			   break;
	       case 4:
			   result="4008-111-111";
			   break;
		   case 5:
			   result="0571-82122222";
			   break;
		   case 6:
			   result="4008270270";
			   break;  
		   case 11:
			   result="4001-000-001";
			   break;
		   case 13:
			   result="400-6789000";
			   break;
	
		   
		   default:
				   result="";
				   break;
	   }
	   return result;
}

   public String getPsdate(int psId)
   {
	   String result="";
	   switch(psId)
	   {
		   case 3002:
			   result="5-7个工作日";
			   break;
		   case 1011:
			   result="3-5个工作日";
			   break;
		   case 4204:
			   result="1-2天（仅限北京地区）";
			   break;
		   case 2001:
			   result="3-5个工作日";
			   break;
		   default:
				   result="";
				   break;
	   }
	   return result;
   }
   
   public String getPsTele(int psId)
   {
	   String result="";
	   switch(psId)
	   {
		   case 3002:
			   result="11185";
			   break;
		   case 1011:
			   result="0571-82122222";
			   break;
		   case 4204:
			   result="010-83603381";
			   break;
		   case 2001:
			   result="400-6789-0000";
			   break;
		   default:
				   result="";
				   break;
	   }
	   return result;
   }
   
   
   
%> 
<%
String orderid = "";
Double points = new Double(0);
if (request.getParameter("orderid") != null
		&& request.getParameter("orderid").length() > 0) {
	orderid = request.getParameter("orderid");
}
OrderBase ob = null;
ArrayList<OrderItemBase> oilist = new ArrayList<OrderItemBase>();
List<OrderItemBase> oilists = null;
ob = OrderHelper.getById(orderid);
if (ob == null) {
	ob = OrderHelper.getHistoryById(orderid);
}
if (ob == null) {
	response.sendRedirect("/mindex.jsp");
	return;
}

if(!lUser.getId().equals(String.valueOf(ob.getOdrmst_mbrid()))){
	response.sendRedirect("/mindex.jsp");
	return;
}
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—<%=orderid  %></title>
<style type="text/css">
   body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,hr,pre,form,fieldset,input,textarea,p,label,blockquote,th,td,button,span{padding:0;margin:0;}
body{ background:#fff;color:#4b4b4b; padding-bottom:15px; line-height:18px;  padding-left:3px}
* html,* html body{background-image:url(about:blank);background-attachment:fixed;}
img{border:none;}
ul{list-style:none;}

a {text-decoration:none;color:#4169E1}
a:hover {color:#aa2e44}
.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}


</style>
</head>
<body>
<!-- 头部 -->
<%@ include file="../inc/head.jsp" %>
<!-- 头部结束 -->
<div style=" margin-bottom:15px;">
   <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>><a href="/wap/user/orderdetail.jsp?orderid=<%=orderid%>">订单详情</a>>物流信息
    <br/>
    </div>
      &nbsp;订单号：<%=orderid %>
   <table  width="100%">
    	<%
		  String d1shipmethod = ob.getOdrmst_d1shipmethod();
		  %>
	    <tr><td colspan="2" style=" background:#FFDEAD; color:#f00;">&nbsp;订单追踪</td></tr>
		  <tr><td colspan="2"> <%
			   if(!Tools.isNull(d1shipmethod)){
			   %>
			   货单号：<%=Tools.formatString(ob.getOdrmst_goodsodrid()) %>
			   <br/><%
			   String kdURL = getPsHref(getPsid(d1shipmethod));
			   String kdPhone = getPsPhone(getPsid(d1shipmethod));
			   %>
				      配送公司：<%
				  if(Tools.isNull(kdURL)){
				  	%>[<%=d1shipmethod %>]<%
				  }else{
				    %><a href="<%=kdURL %>">[<%=d1shipmethod %>]</a><%
				  } %><br/>
				   <%if(!Tools.isNull(kdPhone)){ %>配送公司电话：<%=kdPhone %><br /><%} %>
					             
				   发货时间：<%out.print(ob.getOdrmst_shipdate() == null ? "" :dateFormat.format(ob.getOdrmst_shipdate())); %><br />
				
				<!-- 物流提示开始 -->
				<% 
			   /*if(d1shipmethod.indexOf("韵达")>=0){
			   String backstr=HttpUtil.getUrlContentByGet("http://join.yunda.ancto.com/query/json.php?partnerid=yunda&mailno="+ob.getOdrmst_goodsodrid()+"&charset=utf8","utf-8");
			   if(!Tools.isNull(backstr)){
			   JSONObject  jsonob = JSONObject.fromObject(backstr); 
			 	 String json_order_search = jsonob.getString("mailno");  
			 	 JSONArray jsons = jsonob.getJSONArray("steps");  
			     int jsonLength = jsons.size();  
			       for (int i = 0; i < jsonLength; i++) {  
			    	   JSONObject tempJson = JSONObject.fromObject(jsons.get(i));
			    	 String  address=  tempJson.getString("address");
			    	 String  time=  tempJson.getString("time");
			    	 String  remark=  tempJson.getString("remark");
			    	out.print("<tr><td width=\"50\"></td>");
			    	out.print("<td width=\"200\">"+time+"</td>");
			    	out.print("<td>"+address+remark+"</td></tr>");
			       }
			   }*/
			   //}else{
				   int apitype=1;
				   if(d1shipmethod.indexOf("EMS")>=0|| d1shipmethod.indexOf("顺丰")>=0
						   ||d1shipmethod.indexOf("申通")>=0||d1shipmethod.indexOf("圆通")>=0){
					   apitype=2;
				   }
						   String com="";
						   if(d1shipmethod.indexOf("中通")>=0){
							   com="zhongtong";
						   }else if(d1shipmethod.indexOf("宅急送")>=0){
							   com="zhaijisong";
						   }else if(d1shipmethod.indexOf("优速")>=0){
							   com="youshuwuliu";
						   }else if(d1shipmethod.indexOf("天天")>=0){
							   com="tiantian";
						   }else if(d1shipmethod.indexOf("顺丰")>=0){
							   com="shunfeng";
						   }else if(d1shipmethod.indexOf("圆通")>=0){
							   com="yuantong";
						   }else if(d1shipmethod.indexOf("申通")>=0){
							   com="shentong";
						   }else if(d1shipmethod.indexOf("全峰")>=0){
							   com="quanfengkuaidi";
						   }else if(d1shipmethod.indexOf("汇通")>=0){
							   com="huitongkuaidi";
						   }else if(d1shipmethod.indexOf("国通")>=0){
							   com="guotongkuaidi";
						   }else if(d1shipmethod.indexOf("EMS")>=0){
							   com="ems";									   
						   }else if(d1shipmethod.indexOf("韵达")>=0){
							   com="yunda";									   
						   }
						   if(!Tools.isNull(com)){
							   if(apitype==2){
									String sk100info= searchkuaiDiInfo("b1a8923eac35cde8",com,ob.getOdrmst_goodsodrid());
									 
									out.print("<tr>");
								    	out.print("<td colspan=\"2\" >");	
								    	%>
<iframe name="kuaidi100" id="kuaidi100" src="<%=sk100info %>" width="600" height="270" marginwidth="0" marginheight="0" 
                                              hspace="0" vspace="0" frameborder="0" scrolling="no"></iframe>
								    	<%
								    	out.print("</td></tr>");
								}else{
							   
				   String gourl="http://api.kuaidi100.com/api?id=b1a8923eac35cde8";
			         gourl=gourl+"&com="+com+"&nu="+ob.getOdrmst_goodsodrid()+"&show=0&muti=1&order=desc";
			        //System.out.println("gourl==="+gourl);
				   String backstr=HttpUtil.getUrlContentByGet(gourl,"utf-8");
				   if(!Tools.isNull(backstr)){ 
				   JSONObject  jsonob = JSONObject.fromObject(backstr); 
					 String k100status = jsonob.getString("status");
					 if(k100status.equals("1")){
				 	 JSONArray jsons = jsonob.getJSONArray("data");  
				     int jsonLength = jsons.size();  
				       for (int i = 0; i < jsonLength; i++) {  
				    	   JSONObject tempJson = JSONObject.fromObject(jsons.get(i));
				    	 String  context=  tempJson.getString("context");
				    	 String  time=  tempJson.getString("time");
				      	out.print("<tr>");
				    	out.print("<td width=\"200\">"+time+"</td>");
				    	out.print("<td>"+context+"</td></tr>");
				       }
					 }
			   }else{
				   out.print("<tr>");
			    	out.print("<td width=\"200\"></td>");
			    	out.print("<td>接口出现异常或物流单暂无结果!</td></tr>");
		
			   }
			}
				}
			   //} 
			    %>
				<!-- 物流提示结束 -->
			   <%
			   } %></td></tr>

<tr><td colspan="2">&nbsp;<a href="myorder.jsp">返回我的订单>></a></td></tr>
 </table>
    		
</div>



<!-- 尾部 -->
<%@ include file="../inc/userfoot.jsp" %>
<!-- 尾部结束 -->

</body>
</html>

