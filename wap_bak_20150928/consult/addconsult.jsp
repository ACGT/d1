<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%><%  
	String backurl = request.getParameter("url");
	if(Tools.isNull(backurl)){
		backurl = request.getHeader("referer");
		if(Tools.isNull(backurl)){
			backurl = "/";
		}
	}
	backurl=backurl.replace("#", "");
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—添加商品咨询</title>
<style type="text/css">
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,hr,pre,form,fieldset,input,textarea,p,label,blockquote,th,td,button,span{padding:0;margin:0;}
body{ background:#fff;color:#4b4b4b; padding-bottom:15px; line-height:21px;  padding-left:5px; }

img{border:none;}
a {text-decoration:none;color:#4169E1}
a:hover {color:#aa2e44}
.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}

.top{ margin-top:3px; }
.top ul li{float:left;border-bottom:solid 1px #000;  }
.top ul li a{ color:#000;}
.top ul li a:hover{ color:#aa2e44;}
</style>
</head>
<body>
<!-- 头部 -->
<%@ include file="../inc/head.jsp" %>
<!-- 头部结束 -->
<div style=" margin-bottom:15px;">
   <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/mindex.jsp">首页</a>>我要咨询
    <br/>
    </div>
    <%
    String msg="";
    String content="";
    String type="1";
    if ("post".equals(request.getMethod().toLowerCase())) {
    	//out.print(request.getParameter("asktype"));
    	if(Tools.isNull(request.getParameter("txtcontent"))){
    		msg="请输入咨询内容";
    	}else{
    		content=request.getParameter("txtcontent");
    		if(request.getParameter("txtcontent").trim().length()>100){
    			msg="超出咨询字数范围";
    		}else{
    			if(Tools.isNull(request.getParameter("productid"))){
    				msg="商品不存在";
    			}else{
    				Product product = ProductHelper.getById(request.getParameter("productid"));
    				if(product == null){
    					msg="找不到您要咨询的物品信息！";
    				}else{
    					if(!Tools.isNull(request.getParameter("asktype")) && !"null".equals(request.getParameter("asktype"))){
    					   type=request.getParameter("asktype");
    					   String gdsask_gdsname = product.getGdsmst_gdsname();
   						
   						String gdsask_content = request.getParameter("txtcontent");
   						GoodsAskCache gac = new GoodsAskCache();
   						gac.setGdsask_content(gdsask_content);
   						gac.setGdsask_createdate(new Date());
   						gac.setGdsask_gdsid(product.getId());
   						gac.setGdsask_gdsname(gdsask_gdsname);
   						gac.setGdsask_mbrid(new Long(lUser.getId()));
   						gac.setGdsask_status(new Long(0));
   						gac.setGdsask_type(new Long(type));
   						gac.setGdsask_uid(lUser.getMbrmst_uid());
   						gac = (GoodsAskCache)Tools.getManager(GoodsAskCache.class).create(gac);
   						if(gac != null && gac.getId() != null){
   							msg="咨询提交成功，请耐心等待回复。我们的回复时间为每天9:00-18:00。";
   							content="";
   						}else{
   							msg="咨询提交出错，请稍后再试！";
   						}
    						
    					}else{
    						msg="请选择咨询类型！";
    					}
    				}
    			}
    		}
    	}
    }
    %>
    <span style="color:red;"><%=msg %></span>
    <% String goodsid="";
       if(request.getParameter("productid")!=null&&request.getParameter("productid").length()>0)
       {
    	   goodsid=request.getParameter("productid");
       }
       
       Product p=ProductHelper.getById(goodsid);
       if(p==null)
       {
    	   out.print("对不起，该商品不存在，不能进行咨询！<a href=\"/mindex.jsp\">返回首页</a>");
       }
       else
       {%>
       <form action="addconsult.jsp" method="post">
       <input  type="hidden" name="productid" value="<%= goodsid%>"/>
    	   &nbsp;商品名称：<a href="/wap/goods.jsp?productid=<%= goodsid%>"><%= Tools.clearHTML(p.getGdsmst_gdsname()) %></a><br/>
    	   &nbsp;咨询类型：
    	    <input name="asktype" type="radio"  value="1" <%if("1".equals(type)){%>checked="checked" <%} %>/>商品咨询</input>
						      <input  name="asktype" type="radio"  value="2" <%if("2".equals(type)){%>checked="checked" <%} %>>库存及配送</input>
						      <input  name="asktype" type="radio"  value="3" <%if("3".equals(type)){%>checked="checked" <%} %>>支付问题</input>
						      <input  name="asktype" type="radio"  value="4" <%if("4".equals(type)){%>checked="checked" <%} %>>发票及保修</input>
						      <input name="asktype" type="radio"  value="5" <%if("5".equals(type)){%>checked="checked" <%} %>>促销及赠品</input>
    	   <br/>
    	   &nbsp;请输入提问内容(100字以内)：<br/>
    	   &nbsp;<textarea rows="5" cols="20" id="txtcontent" name="txtcontent"><%=content %></textarea>
    	   <br/><br/>
    	   &nbsp;<input type="submit"  style=" padding:4px;" value="提&nbsp;交"/>
     </form>
       <%}
    %>
    <br/>&nbsp;<a href="<%=backurl%>">返回上一级>></a><br/>
    		   &nbsp;<a href="/wap/goods.jsp?productid=<%=goodsid %>">返回商品详情>></a>
  <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/mindex.jsp">首页</a>&nbsp;&nbsp;
<a href="">购物车</a>&nbsp;&nbsp;<br/>
<a href="/wap/login.jsp">登录</a>&nbsp;&nbsp;<a href="/wap/emailregist.jsp">注册</a>&nbsp;&nbsp;<a href="/wap/html/help.jsp">帮助</a>

    <br/>
    </div>
</div>


</body>
</html>

