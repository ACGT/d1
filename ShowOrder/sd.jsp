<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp"%><%@include file="myshow.jsp"%><%@include file="/inc/islogin.jsp"%>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern"%>
<%
String path = request.getContextPath();

String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网-晒单</title>

<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/shaidan/show.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/showorder.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/res/js/uploadify/swfobject.js"></script>
<script type="text/javascript" src="/res/js/uploadify/jquery.uploadify.v2.1.4.js"></script>



</head>

<body>
<%@include file="/inc/head.jsp" %>
<div class="center">

<div class="sleft">

 <% 
 /**
	    String odrid=request.getParameter("orderid");
 		String gdsid=request.getParameter("gdsid");
		 if(Tools.isNull(odrid)){
			 Tools.outJs(out,"参数错误！","back");
				return; 
		 }
		
	    OrderBase base=OrderHelper.getById2(odrid);
	    if(base==null){
	    	 Tools.outJs(out,"该订单不存在！","back");
				return;
	    }
	    //System.out.println(base.getOdrmst_mbrid()+"ssss"+lUser.getId()+"www");
	    if(!base.getOdrmst_mbrid().equals(new Long(lUser.getId()))){
	    	 Tools.outJs(out,"你没有权限进行操作！","back");
				return;
	    }

 		if(!Tools.isNull(gdsid)){
 		    List<OrderItemBase> list=OrderItemHelper.getOdrdtlListByOrderId(odrid.trim());
 		    boolean hasgdsid=false;
 			if(list!=null && list.size()>0){
 				for(OrderItemBase item:list){
 					if(item.getOdrdtl_gdsid().trim().equals(gdsid.trim())){
 						hasgdsid=true;
 					}
 				}
 	    	}
 			if(!hasgdsid){
 				Tools.outJs(out,"该订单未购买该商品！","back");
 				return;
 			}
 			int isshow=getMyShowByOrder(lUser.getId(), odrid, gdsid);
 	    	if(isshow>0){
 	    		 Tools.outJs(out,"您已经对该订单的该商品进行过晒单！","back");
 					return;
 	    	}
		 }
 		**/
 		ArrayList<OrderItemBase> itemlist= getOdrDtlIn4Months(lUser.getId());
 		if(itemlist==null || itemlist.size()==0){
 			Tools.outJs(out,"您没有未晒单的商品！","back");
			return;
 		}
	    %>
    <div class="fstep">
	  <span>&nbsp;&nbsp;&nbsp;&nbsp;<font style="color:red;">*</font> 第一步：选择您要晒的宝贝<font class="msg">（晒一件宝贝，得100积分）</font></span>
	 <input type="hidden" id="showorder"/>
	 <input type="hidden" id="hmbrid" value="<%=lUser.getId()%>"/>
	 <input type="hidden" id="showgdsid"/>
	  <div class="otherbb">
	      <div id="focus">
			    <ul id="obb">		
    	<% 
    	if(itemlist!=null && itemlist.size()>0){
    		for(OrderItemBase item:itemlist){
    		//	if(!item.getOdrdtl_gdsid().equals(gdsid)){
    				 Product p1=ProductHelper.getById(item.getOdrdtl_gdsid());
    				 if(p1!=null){
    					  String  imgurl1=p1.getGdsmst_recimg();
    					   if(Tools.isNull(imgurl1)){
    						   imgurl1=p1.getGdsmst_midimg();
    					   }
    						imgurl1="http://images.d1.com.cn"+imgurl1; 
    				 
    				%>
    				 <li><a href="javascript:void(0)" attr="<%=item.getOdrdtl_gdsid() %>" code="<%=item.getOdrdtl_odrid() %>" onclick="chooseobb(this)"><img src="<%=imgurl1 %>" width="100" height="100" /><div class="div1"></div>
    
    				 <img src="http://images.d1.com.cn/images2012/sd/an_12.jpg"  style="  margin-top:15px;"/></a></li>
    			<% }
    		//	}
    		}
    	}
	    %>
	  </ul>
				 <div class='preNext pre2012'>
		            <img id="tprev1" src="http://images.d1.com.cn/images2012/sd/sdprev.jpg"  width="9" height="16"/>
				 </div>
				 <div class='preNext next2012' >
				    <img src="http://images.d1.com.cn/images2012/sd/sdnext.jpg" width="9" height="16"/>
				 </div>
			</div>
	   </div>
	   
	</div>
	
	<div style="clear:both;height:10px;">&nbsp;</div>
	<div class="sstep">
	     <span>&nbsp;&nbsp;&nbsp;&nbsp;<font style="color:red;">*</font>第二步：上传宝贝图片</span>&nbsp;&nbsp;&nbsp;&nbsp;<font class="msg">(请选择jpg、jpeg、png、gif格式的图片，图片大小不能超过4M)</font>
	         <div id="fileQueue" class="sctpk">
        	 <input type="file" name="uploadify" id="uploadify"/><br/>
      
      		</div>
         
	   
	   
	     <div style="height:20px;">&nbsp;</div>
	</div>

<div class="sstep">
	     <span>&nbsp;&nbsp;&nbsp;&nbsp;<font style="color:red;">*</font>第三步：优格点评-购买/穿着/使用心得</span>
	    <div class="divcontent">
	    <textarea id="tcontent" cols="90" rows="4" style="color:gray;font-size:12px;" onfocus="checkcontent();" onblur="checkcontentblur();" onkeyup="checklen();"></textarea><br />
	    <span id="spanmsg" class="msg">(您可以输入200个字)</span>
	    </div>
	    <div style="clear:both;padding-top:50px;padding-bottom:50px;text-align:center">
	    <a href="javascript:void(0)" onclick="startupload();" ><img src="http://images.d1.com.cn/images2012/sd/an_20.jpg" border="0"/></a>
	    <input  type="button" onclick="showmsg('')" value="点击"/>
	   
	    </div>
	</div>
</div>

<div class="sright">
<div class="aboutsd">
<h3 style="padding-top:5px;padding-left:5px;">晒单小贴士：	</h3>
<ul>
<li>1、红字带星号的步骤都完成之后才能晒图成功，优格们一定要知道！</li>
<li>2、晒单成功后，您将获得100积分。</li>
<li>3、如果照片是优格和购买宝贝的合影，那就更欢迎啦！也许还会被推荐到晒单频道呢！会有更多朋友能够一睹优格和宝贝的风采哦~	</li>
</ul>

</div>
</div>
</div>

<div class="clear"></div>
<%@include file="/inc/foot.jsp" %>

</body>
</html>