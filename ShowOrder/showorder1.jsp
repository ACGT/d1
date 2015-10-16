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
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/shaidan/show.js?"+System.currentTimeMillis())%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/showorder.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/uploadify/swfobject.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/uploadify/jquery.uploadify.v2.1.4.js")%>"></script>


</head>

<body>
<%@include file="/inc/head.jsp" %>
<div class="center">

<table cellpadding="0" cellspacing="0" border="0">
<tr><td class="sleft">

 <% 
 String gdsid="";
	    String odrid=request.getParameter("orderid");
		String odtlid=request.getParameter("odtlid");
 		//String gdsid=request.getParameter("gdsid");
		// if(Tools.isNull(odrid) && Tools.isNull(odtlid)){
		//	 Tools.outJs(out,"参数错误！","back");
		//		return; 
		// }
		
		 if(!Tools.isNull(odrid)){
			  OrderBase base=OrderHelper.getById2(odrid);
			    if(base==null){
			    	 Tools.outJs(out,"该订单不存在！","back");
						return;
			    }
			    //System.out.println(base.getOdrmst_mbrid()+"ssss"+lUser.getId()+"www");
			    if( !base.getOdrmst_mbrid().equals(new Long(lUser.getId()))){
			    	 Tools.outJs(out,"你没有权限进行操作！","back");
						return;
			    }
			    List<OrderItemBase> list=OrderItemHelper.getOdrdtlListByOrderId(odrid);
			    boolean hasgdsid=false;
				if(list!=null && list.size()>0){
					for(OrderItemBase item:list){
						if(getMyShowByOrder(lUser.getId(),base.getId(),item.getOdrdtl_gdsid(),item.getId())==0){//商品未晒单
							gdsid=item.getOdrdtl_gdsid();
							odtlid=item.getId();
							break;
						}
					}
		    	}
		 }
	  
	    /**
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
 		
 		//没有参数默认为最新订单
 		if(Tools.isNull(odtlid)){
 			for(OrderItemBase item:itemlist){
 				if(getMyShowByOrder(lUser.getId(),item.getOdrdtl_odrid(),item.getOdrdtl_gdsid(),item.getId())==0){
					odtlid=item.getId();
					odrid=item.getOdrdtl_odrid();
					gdsid=item.getOdrdtl_gdsid();
					break;
				}
 			}
 		}
 		if(Tools.isNull(odtlid)){
 			Tools.outJs(out,"您没有未晒单的商品！","back");
			return;
 		}
 		boolean b=false;	  String  imgurl="";
 		if(!Tools.isNull(odtlid)){
 			OrderItemBase itembase=getById(odtlid);
 			if(itembase!=null){
 				Product p=ProductHelper.getById(itembase.getOdrdtl_gdsid());
 			
 				  if(p!=null){
 				gdsid=p.getId();
 				odrid=itembase.getOdrdtl_odrid();
 					   b=true;
 					    imgurl=p.getGdsmst_recimg();
 					   if(Tools.isNull(imgurl)){
 						   imgurl=p.getGdsmst_midimg();
 					   }
 						imgurl="http://images.d1.com.cn"+imgurl; 
 				   }
 			}
 		}
	    %>
       <div class="fstep">
	  <span>&nbsp;&nbsp;&nbsp;&nbsp;<font style="color:red;">*</font> 第一步：确认您要晒的宝贝<font class="msg">（晒一件宝贝，得30积分）</font></span>
	 <input type="hidden" id="hmbrid" value="<%=lUser.getId()%>"/>
	 <input type="hidden" id="showorder"  value="<%=odrid%>"/>
	 <input type="hidden" id="showgdsid"  value="<%=gdsid%>"/>
	 <input type="hidden" id="hodtlid" value="<%=odtlid%>"/>
	 <input type="hidden" value="" id="hw" />
	<input type="hidden" value="" id="hh" />
	<input type="hidden"  value="" id="himgurl" />
	<%
	if(b){
	%>	<table cellpadding="0" cellspacing="0" border="0">
	<tr><td width="200">
			 <div id="fstepimg" onclick="choosemain()">&nbsp;&nbsp;&nbsp;&nbsp;
			  <img id="chooseimg" src="<%=imgurl %>" attr="<%=gdsid%>"  keys="<%=odtlid %>"  code="<%=odrid%>" width="120" height="120" />
		  </div>
	     <div id="zimg" class="zdiv1" onclick="choosemain()"></div>
	     </td>
	     <td valign="bottom"><a href="/user/myshoworder.jsp" class="msg">重新选择宝贝&gt;&gt;</a></td>
	     </tr>
	     </table>
		<%}
	
	%>

	   
	</div>
	<div style="clear:both;height:10px;">&nbsp;</div>
	<div class="sstep">
	  <div style="clear:both;">   <span>&nbsp;&nbsp;&nbsp;&nbsp;<font style="color:red;">*</font>第二步：上传宝贝图片</span>&nbsp;&nbsp;&nbsp;&nbsp;<font class="msg">(请选择jpg、jpeg、png、gif格式的图片，图片大小不能超过4M)</font></div>
	         <div id="fileQueue" class="sctpk" style="float:left;<%if(!b){%>display:none;<%}%> ">
        	 <input type="file" name="uploadify" id="uploadify" /> 
      		</div>
      		<div id="divshowmsg" style="float:left;padding-left:25px; display:none;"> 
      		<a id="aimg" target="_blank">
      		<img id="testimgs" style="display:block;border:none;" src="" /></a>
        	
		  </div>
      		<div  id="btnupload" style="padding-left:25px;float:left;clear:both;<%if(!b){%>display:block;<%}%>"> <a href="javascript:void(0);" onclick="checkorder();" ><img src="http://images.d1.com.cn/images2012/sd/an_03.jpg" border="0"/></a></div>
      		
          <div style="height:20px;clear:both;">&nbsp;</div>
	</div>

<div class="sstep">
	     <span>&nbsp;&nbsp;&nbsp;&nbsp;<font style="color:red;">*</font>第三步：优格点评-购买/穿着/使用心得</span>
	    <div class="divcontent">
	    <textarea id="tcontent" cols="90" rows="4" style="color:gray;font-size:12px;" onfocus="checkcontent();" onblur="checkcontentblur();" onkeyup="checklen();"></textarea><br />
	    <span id="spanmsg" class="msg">(您可以输入200个字)</span>
	    </div>
	    <div style="clear:both;padding-top:50px;padding-bottom:50px;text-align:center">
	    <a href="javascript:void(0)" onclick="cmtshoworder();" ><img src="http://images.d1.com.cn/images2012/sd/an_20.jpg" border="0"/></a>
	    
	    </div>
	</div>


</td><td class="sright" valign="top">

<div class="aboutsd">
<h3 style="padding-top:5px;padding-left:5px;">晒单小贴士：	</h3>
<ul>
<li><p>1、晒单成功后，您将获得30至200个积分的奖励。</p>
<p style="padding-top:5px;">**晒单成功并审核通过后您将获30积分；</p>
<p style="padding-top:5px;">**如果您提交的商品清晰地展示全貌，将获得50积分；</p>
<p style="padding-top:5px;">**对于清晰的真人秀，将根据图片整体效果获得100至200个积分奖励！！</p></li>
<li>2、如果晒单图片与商品不符，晒单无法通过审核获得积分。</li>
<li>3、晒单范围：四个月内购买的商品。	</li>
</ul>

</div>

</td></tr>
</table>
</div>
<div class="clear"></div>
<%@include file="/inc/foot.jsp" %>

</body>
</html>