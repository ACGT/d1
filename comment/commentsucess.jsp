<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/inc/islogin.jsp"%>
<%!
 String getlove(int score){
	String love="";
	switch(score){
	case 5:love="非常喜欢";break;
	case 4:love="很喜欢";break;
	case 3:love="还不错";break;
	case 2:love="一般";break;
	case 1:love="不喜欢";break;
	
	}
	return love;
}

List getD1Comment(Long mbrid,String sessionid,String orderid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdscom_mbrid", mbrid));
	listRes.add(Restrictions.eq("sessionid", sessionid));
	listRes.add(Restrictions.eq("gdscom_odrid", orderid));
	return Tools.getManager(D1Comment.class).getList(listRes, null, 0, 10);
}
static ArrayList<OrderScore> getFxScore(String mbrid,String orderid){
	ArrayList<OrderScore> rlist = new ArrayList<OrderScore>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdscomscore_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("gdscomscore_status", new Long(0)));
	clist.add(Restrictions.eq("gdscomscore_orderid", orderid));
	List<BaseEntity> list = Tools.getManager(OrderScore.class).getList(clist, null, 0, 10);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((OrderScore)be);
	}
	return rlist ;
}
%>
<%
if(!Tools.isNull(request.getParameter("orderid"))){
	//判断订单是否属于改用户
	OrderBase obase=OrderHelper.getById(request.getParameter("orderid"));
	 if(obase!=null){
		  if(!lUser.getId().equals(String.valueOf(obase.getOdrmst_mbrid()))){
			  Tools.outJs(out,"你没有权限进行操作！","back");
				return;
		  }
	 }
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品评价 - D1优尚</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/comment.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style>
td{
font-family:微软雅黑;
}
span{
font-family:微软雅黑;
}
</style>
</head>
<body>

<%@include file="/inc/head.jsp" %>

  <div class="center">
 <%@include file="/user/left.jsp" %>

         <div class="mbr_right">
		<div class="myyhq">

		  &nbsp;&nbsp;<span>商品评价</span>

		</div>

		
	 <form>
    
     <%
      if((!Tools.isNull(request.getParameter("sessionid"))) &&  !Tools.isNull(request.getParameter("orderid"))){
    	  List<Comment> list=CommentHelper.getMyNewCommentList(new Long(lUser.getId()),request.getParameter("orderid"));
    	  List<D1Comment> d1list=getD1Comment(new Long(lUser.getId()), request.getParameter("sessionid"),request.getParameter("orderid"));
    	  ArrayList<OrderScore> scorelist= getFxScore(lUser.getId(),request.getParameter("orderid"));
    	  int score=0;
    	  if(scorelist!=null && scorelist.size()>0){
    		  score=scorelist.get(0).getGdscomscore_score().intValue();
    	  }
    	boolean b=false;
    	if(Tools.parseLong(Tools.getDBDate())>Tools.parseLong(request.getParameter("sessionid")) && (Tools.parseLong(Tools.getDBDate())-Tools.parseLong(request.getParameter("sessionid"))<1000000)){
    		b=true;
    	}
    	  
    	  if(list!=null && list.size()>0 ){
  %>
    	  <table border="0" width="100%" >
    	
			
			<%
			if(!Tools.isNull(Tools.getCookie(request,"PINGAN"))){
				%>	
				  <tr><td  height="10">&nbsp;</td></tr>
				<tr> <td  class="peisong_body" align="center" valign="middle"  height="60px" >
				<span style="font-size:16px; font-weight:bold">评价已成功</span></td></tr>
			<%}else{
			%>
			  <tr><td  height="5"></td></tr>
			<tr> 
			<td  class="peisong_body"  valign="top" >
			<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td width="80px">&nbsp;</td>
<td valign="top">
<table width="100%" style="border:dotted #999999 1px;" cellpadding="0" cellspacing="0">
<tr>
<td width="80px">&nbsp;</td>
<td>
<table width="100%" cellpadding="0" cellspacing="0">
<tr><td height="5px"></td></tr>
<tr>
<td align="center"><span style="font-size:16px; font-weight:bold">评价已成功，您获得了<%=score %>积分</span></td>
</tr>
<tr><td height="5px"></td></tr>
<tr><td style=" height:20px;">&nbsp;</td></tr>
<tr>
<td align="center"><span style="font-size:16px; font-weight:bold; color:#C00000;font-family:微软雅黑;">下一步就去微博分享吧！每件商品最多可获得5分享积分。</span></td>
</tr>
<tr><td height="20px"></td></tr>
</table>
</td>
<td width="80px">&nbsp;</td>
</tr>

</table>
</td>
<td width="80px">&nbsp;</td>
</tr>
</table>
	</td></tr>
       
       <tr><td height="10px"></td></tr>
        <%} %>
         
			
			 <tr>
         <td  class="peisong_body" align="center" valign="middle" height="30px" style="background-color:#FEEEF1;">
          <b style="font-size:16px; ">我的评价</b>
            
         </td>
        </tr>
		</table>
    		 <table border="0" width="100%">
    		 <tr><td colspan="3" height="10px"></td></tr>
    		 <tr><td width="100" align="center">商品图片</td><td  align="center">商品名称</td><td width="280" align="center">我的评分</td></tr>
    		 <tr><td colspan="3" height="10px"></td></tr>
    		 <tr><td colspan="3" style="border-bottom:1px dotted #C7C7C7;"></td></tr>
    		 <% 
    		 int i=1;
    		 for(Comment comment:list){
    			String star="http://images.d1.com.cn/images2012/New/user/star"+comment.getGdscom_level().toString()+".jpg";
    			 Product product= ProductHelper.getById(comment.getGdscom_gdsid());
				 String imgurl="http://images.d1.com.cn/images2012/New/user/imgtext.jpg";
				 String linkurl="";
				 String gdsname=comment.getGdscom_gdsname();
				 String img="";
				 if(product!=null){
					 String smallimg = product.getGdsmst_smallimg();
					 if(smallimg.startsWith("/shopimg/gdsimg")){
		    				 smallimg = "http://images1.d1.com.cn"+smallimg.trim();
		     						}else{
		     							smallimg = "http://images.d1.com.cn"+smallimg.trim();
		     						}
					 imgurl=smallimg;
					 linkurl="/product/"+product.getId();
					 gdsname=product.getGdsmst_gdsname();
					 img=ProductHelper.getImageTo400(product);
				 } 
				 String gname=Tools.clearHTML(gdsname);
				 if(gname.indexOf("（")>0){
				 	gname=gname.substring(0,gname.indexOf("（"));
				 }
				 if(gname.indexOf("(")>0){
				 	gname=gname.substring(0,gname.indexOf("("));
				 }

				 String fxcontent="我在@D1优尚官网  买了"+gname+"。说说我的感受："+comment.getGdscom_content()+" 分享一下: ";
				 %>
				  <tr><td colspan="2" height="5">&nbsp;</td></tr>
				  <tr style="border-collapse:collapse;">
            <td align="left">
            <a href="<%=linkurl%>" target="_blank"><img src="<%=imgurl%>" height="80" width="80"/> </a>
               </td>
                     <td align="left" style="padding-left:10px">
                    <a  href='<%=linkurl %>' target="_blank"><%=comment.getGdscom_gdsname()%></a></td>
                <td><img src="<%=star%>"></img>   <span style="color:red"><%=comment.getGdscom_level() %>分</span> --<%=getlove(comment.getGdscom_level().intValue()) %></td>
               
          </tr>
          <tr >
           <td align="center" style="font-weight:bold; padding-top:15px; padding-bottom:10px">
           
           使用心得： </td><td  align="left" colspan="2">
           
            <%=comment.getGdscom_content() %>
			
           </td>
          </tr>
         <tr>
         <td style="background-color:#FEEEF1;" colspan="3">
         <table>
         <tr><td colspan="2" height="30px">&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-weight:bold; color:#AA0001">分享得积分！--在一个微博平台上成功分享本件商品，将得到5积分！最多可获得15积分。</span></td></tr>
        <tr><td colspan="2"><span style="font-weight:bold;color:black;">&nbsp;&nbsp;&nbsp;&nbsp;预览/编辑分享内容：</span></td></tr>
        <tr><td colspan="2" height="10px"></td></tr>
        <tr><td width="15%">&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=linkurl%>" target="_blank"><img src="<%=imgurl%>" height="80" width="80" style=" border:1px solid #C7C7C7;"/> </a></td>
        <td style="font-size:12px;"><textarea name="txtCustomerMemo" id="txtCustomerMemo<%=i %>"  rows="3" cols="75" ><%=fxcontent %></textarea></td></tr>
        <tr><td colspan="2" height="10px"></td></tr>
        <tr><td></td><td>
        <input type="hidden"  id="hgdsid<%=i %>" value="<%=comment.getGdscom_gdsid().trim()%>"/>
        <input type="hidden"  id="hcommenturl<%=i %>" value="<%=img%>"/>
       <input type="hidden"  id="hcommentid<%=i %>" value="<%=comment.getId()%>"/>
       <%
       if(!Tools.isNull(comment.getGdscom_pic1())){
    	   %> 
    	   <img src="http://images.d1.com.cn/wap/yfx_sina.jpg"  id="sina<%=i%>"></img>&nbsp;&nbsp;&nbsp;&nbsp;  
    	   <% }else{%>
    	    <a id="asina<%=i%>" href="javascript:fx<%=i%>('sina');void((function(s,d,e,r,l,p,t,z,c) {var%20f='http://v.t.sina.com.cn/share/share.php?appkey=2833634960',u=z||d.location,p=['&url=',e(u),'& title=',e(t||d.title),'&source=',e(r),'&sourceUrl=',e(l),'& content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a() {if(!window.open([f,p].join(''),'mb', ['toolbar=0,status=0,resizable=1,width=600,height=500,left=',(s.width- 600)/2,',top=',(s.height-600)/2].join('')))u.href=[f,p].join('');}; if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();}) (screen,document,encodeURIComponent,'','','<%=img %>',$('#txtCustomerMemo<%=i %>').val(),'http://www.d1.com.cn/product/<%=product.getId() %>','utf-8'));"><img src="http://images.d1.com.cn/wap/fx_sina.jpg"></img></a><img src="http://images.d1.com.cn/wap/yfx_sina.jpg" style="display:none;" id="sina<%=i%>"></img>&nbsp;&nbsp;&nbsp;&nbsp;
        <% }
       %>
        <%
       if(!Tools.isNull(comment.getGdscom_pic2())){
    	   %> 
    	   <img src="http://images.d1.com.cn/wap/yfx_sohu.jpg"  id="sohu<%=i%>"></img>&nbsp;&nbsp;&nbsp;&nbsp;  
    	   <% }else{%>
    	    <a id="asohu<%=i%>" href="javascript:fx<%=i%>('sohu');void((function(s,d,e,r,l,p,t,z,c){var f='http://t.sohu.com/third/post.jsp?',u=z||d.location,p=['&url=',e(u),'&title=',e(t||d.title),'&content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a(){if(!window.open([f,p].join(''),'mb',['toolbar=0,status=0,resizable=1,width=660,height=470,left=',(s.width-660)/2,',top=',(s.height-470)/2].join('')))u.href=[f,p].join('');};if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();})(screen,document,encodeURIComponent,'','','<%=img %>',$('#txtCustomerMemo<%=i %>').val(),'http://www.d1.com.cn/product/<%=product.getId() %>','utf-8'));"><img src="http://images.d1.com.cn/wap/fx_sohu.jpg"></img></a><img src="http://images.d1.com.cn/wap/yfx_sohu.jpg" style="display:none;" id="sohu<%=i%>"></img>&nbsp;&nbsp;&nbsp;&nbsp;
        <% }
       %>
        <%
       if(!Tools.isNull(comment.getGdscom_pic3())){
    	   %> 
    	   <img src="http://images.d1.com.cn/wap/yfx_tengxun.jpg" id="tx<%=i%>"></img> 
    	   <% }else{%>
    	        <a id="atx<%=i%>" href="javascript:fx<%=i%>('tx');postToWb(<%=i %>);" ><img src="http://images.d1.com.cn/wap/fx_tengxun.jpg"></img></a><img src="http://images.d1.com.cn/wap/yfx_tengxun.jpg" style="display:none;" id="tx<%=i%>"></img>
        <% }
       %>


        </td></tr>
        <tr><td colspan="2" height="10px"></td></tr>
         </table>
         </td>
         <script>
         function fx<%=i%>(fxtype){
        	 var obj="#hcommentid"+<%=i %>;
        	// alert(obj);
        	 var commentid=$(obj).val();
        	 $.ajax({
                 type: "post",
                 dataType: "text",
                 contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                 url: "operation.jsp",
                 cache: false,
                 data:{
                	 commentid: commentid,
                	 fxtype: fxtype,
                	 orderid:<%=request.getParameter("orderid")%>
     		      },error: function(XmlHttpRequest, textStatus, errorThrown){
                   //  $.alert('修改信息失败！');
                 },success: function(msg){
                 	//alert(msg);
                 	 if(msg==1){
                 		 if(fxtype=="sina"){
                 			$("#asina"+<%=i%>).hide();
                 			 $("#sina"+<%=i%>).show();
                 		 }else if(fxtype=="sohu"){
                  			$("#asohu"+<%=i%>).hide();
                			 $("#sohu"+<%=i%>).show();
                		 }
                 		else if(fxtype=="tx"){
                  			$("#atx"+<%=i%>).hide();
                			 $("#tx"+<%=i%>).show();
                			 //postToWb();return false;
                		 }
                 	 }
                 	
                 }
                 }
         	)
         }
         function postToWb(j){
        	// alert(j);
             var _t = encodeURI(document.title);
             _t=encodeURI($('#txtCustomerMemo'+j).val().replace("@D1优尚官网","@D1优尚网"));
             var _url = encodeURIComponent('http://www.d1.com.cn/product/'+$('#hgdsid'+j).val());
             var _appkey = encodeURI("7d55b7e157054243b4a6bd7a826cbc40");//你从腾讯获得的appkey
             var _pic = encodeURI($('#hcommenturl'+j).val());//（例如：var _pic='图片url1|图片url2|图片url3....）
             var _site = 'http://www.d1.com.cn/product/'+$('#hgdsid'+j).val();//你的网站地址
             var _u = 'http://v.t.qq.com/share/share.php?url='+_url+'&appkey='+_appkey+'&site='+_site+'&pic='+_pic+'&title='+_t;
             window.open( _u,'', 'width=700, height=680, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, location=yes, resizable=no, status=no' );
         }
         </script>
         </tr>
          <tr>
            <td colspan="3" align="left" style=" border-bottom:1px dotted #C7C7C7;">
          &nbsp;
           </td>
          </tr>
          <%  i++;}%>
          </table>
          <%}
         String base="未评价";
         String speed="未评价";
         String service="未评价";
         String msn="未评价";
         String other="未评价";
          if(d1list!=null && d1list.size()>0){
        	  D1Comment d1=d1list.get(0);
        	  base=d1.getGdscom_base() ;
        	  speed=d1.getGdscom_speed();
        	  service=d1.getGdscom_service();
        	  msn=d1.getGdscom_msn();
        	  other=d1.getGdscom_other();
          }
        	  %>
        	  				 <table width="100%" border="0" cellspacing="0" cellpadding="0" style="line-height:22px;">
               <tr>
           <td colspan="3" height="10px;">&nbsp;</td>
           </tr>
              <tr>
                <td width="120" rowspan="5" valign="top"> <div align="center"><strong>D1购物评价：</strong></div></td>
                <td width="240">您对此次购物的基本满意度：</td>
                <td ><%=base%></td>
              </tr>
              <tr>
                <td>您对发货速度的满意度：</td>
				<td ><%=speed %></td>
              </tr>
              <tr>
                <td>您对客户服务的满意度：</td>
                <td><%=service %></td>
              </tr>
              <tr>
                <td> 您对快递的满意度：</td>
                <td><%=msn%></td>
              </tr>
              <tr>
                <td>其他建议和意见：</td>
                <td ><%=other%></td>
              </tr>
                 <tr>
           <td colspan="3" height="30px;">&nbsp;</td>
           </tr>
            <tr>
           <td colspan="3" align="center">
           <table>
           <tr><td><span style="font-size:18px; font-weight:bold;color:#b43f5c;">感谢您对D1优尚的支持，欢迎再次光顾！</span></td>
           <td align="left"><a href="/index.jsp" ><img src="http://images.d1.com.cn/images2012/backindex.jpg" border="0"></img></a></td></tr>
           </table>
              </td>
           </tr>
              <tr>
           <td colspan="3" height="20px;">&nbsp;</td>
           </tr>
            </table>
         <% }
          %>
<input type="hidden" id="hfscores"></input>
        </form>
     </div>
     </div>
   
<div class="clear"></div>
   <%@include file="/inc/foot.jsp" %>

</body>
</html>