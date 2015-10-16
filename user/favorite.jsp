<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——我的收藏夹</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gdsmst.js")%>"></script>

<script type="text/javascript" src="/res/js/product/listCart.js"></script>
</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
        
     <%@include file="left.jsp" %>
     
  <!--右侧-->

  <div class="mbr_right">

		<div class="mylike">

		  &nbsp;&nbsp;<span>我的收藏</span>(共<%=FavoriteHelper.getLengtByUserId(lUser.getId()) %>件商品)

		</div>

		<table width="769"  border="0" cellspacing="0" cellpadding="0"><tr><td height="10"></td></tr></table>

		<table width="769"  border="0" cellspacing="0" cellpadding="0" class="t_title" >

		   <tr>
              
		   <td width="340" style=" text-align:left; _width:390px;"><span style="display:block; margin-left:12px; _ margin-left:6px; float:left;"></span>

		       <span style="display:block; margin-left:25px; float:left;">全选</span>  
		       <span style="display:block; margin-right:85px; float:right;">商品名称/编号</span>

		   <td width="148">收藏时间</td>

		   <td width="110">操作</td>

		   <td>推荐给好友</td>

		   </tr>

		   </table>

		 <table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t" >

			<%
			String pg = request.getParameter("pg");
			int currentPage = 1 ;//当前页
			
			if(StringUtils.isDigits(pg)){
				currentPage = new Integer(pg).intValue();
			}
			
			PageBean pb = new PageBean(FavoriteHelper.getLengtByUserId(lUser.getId()),10,currentPage);
			
			List<BaseEntity> list = FavoriteHelper.getByUserId(lUser.getId(), pb.getStart(), 10);
			if(list!=null&&list.size()>0){
				int i=0;
				for(BaseEntity be:list){
					Favorite f = (Favorite)be;
					Product p = (Product)Tools.getManager(Product.class).get(f.getGdswil_gdsid());
					if(p==null)continue;
					i++;
					String createstr = "";
					if(f.getGdswil_applytime()!=null){
						createstr = Tools.getFormatDate(f.getGdswil_applytime().getTime(),"yyyy-MM-dd HH:mm:ss");
					}
			%>
		   <tr height="70"><td width="340" style=" padding-left:12px;"><input type="checkbox" name="checksub" value="<%= f.getId() %>" id="checksub_<%=i %>" style="float:left; margin-right:12px; margin-top:15px;" />&nbsp;&nbsp;<a href="/product/<%=p.getId()%>" target=_blank><img src="<%=ProductHelper.getImageTo80(p) %>" width="50" border="0" height="50" style=" float:left; vertical-align:bottom" /></a>

		   <div class="sptitle1"><a href="/product/<%=p.getId()%>" target="_blank"><%=p.getGdsmst_gdsname()%></a><br/><%=p.getId() %></div></td>

		  <td width="140"><%=createstr%></td><td width="110"><a href="###" attr="<%=p.getId() %>" onclick="$.inCart(this);"><img src="http://images.d1.com.cn/images2012/New/user/ljgm.jpg" /></a><br/>
		  <a href="###" onclick="delFavorite('<%=f.getId() %>',this);" class="a">删除</a></td><td>
		 	 <div class="share">
								<img src="http://images.d1.com.cn/images2012/New/product/share.jpg" />
								<a href="javascript:void((function(s,d,e,r,l,p,t,z,c) {var%20f='http://v.t.sina.com.cn/share/share.php?appkey=2833634960',u=z||d.location,p=['&url=',e(u),'& title=',e(t||d.title),'&source=',e(r),'&sourceUrl=',e(l),'& content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a() {if(!window.open([f,p].join(''),'mb', ['toolbar=0,status=0,resizable=1,width=600,height=500,left=',(s.width- 600)/2,',top=',(s.height-600)/2].join('')))u.href=[f,p].join('');}; if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();}) (screen,document,encodeURIComponent,'','','','<%=p.getGdsmst_gdsname() %>），市场价<%=p.getGdsmst_saleprice()  %>元，会员价仅<%=p.getGdsmst_memberprice() %>元，全国配送，假一赔二','http://www.d1.com.cn/gdsinfo/<%=p.getId() %>.asp','utf-8'));" title="分享到新浪微博"><img src="http://images.d1.com.cn/images2012/New/sina.gif" alt="分享到新浪微博" /></a>
								<a title="分享到搜狐微博" href="javascript:void((function(s,d,e,r,l,p,t,z,c){var f='http://t.sohu.com/third/post.jsp?',u=z||d.location,p=['&url=',e(u),'&title=',e(t||d.title),'&content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a(){if(!window.open([f,p].join(''),'mb',['toolbar=0,status=0,resizable=1,width=660,height=470,left=',(s.width-660)/2,',top=',(s.height-470)/2].join('')))u.href=[f,p].join('');};if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();})(screen,document,encodeURIComponent,'','','','<%=p.getGdsmst_gdsname() %>），市场价<%=p.getGdsmst_saleprice()  %>元，会员价仅<%=p.getGdsmst_memberprice() %>元，全国配送，假一赔二','http://www.d1.com.cn/gdsinfo/<%=p.getId() %>.asp','utf-8'));" ><img src="http://images.d1.com.cn/images2012/New/sohuwb.gif" width="18" height="17" alt="分享到搜狐微博" /></a>
								<a href="javascript:void(0)" onclick="postToWb();return false;" title="转播到腾讯微博"><img src="http://images.d1.com.cn/images2012/New/wb.gif" alt="转播到腾讯微博" /></a>
								<script type="text/javascript">
								function postToWb(){
			                        var _t = encodeURI(document.title);
			                        _t=encodeURI('<%=p.getGdsmst_gdsname() %>），市场价<%=p.getGdsmst_saleprice()  %>元，会员价仅<%=p.getGdsmst_memberprice() %>元，全国配送，假一赔二');
			                        var _url = encodeURIComponent('http://www.d1.com.cn/gdsinfo/<%=p.getId() %>.asp');
			                        var _appkey = encodeURI("7d55b7e157054243b4a6bd7a826cbc40");//你从腾讯获得的appkey
			                        var _pic = encodeURI('');//（例如：var _pic='图片url1|图片url2|图片url3....）
			                        var _site = 'http://www.d1.com.cn/gdsinfo/<%=p.getId() %>.asp';//你的网站地址
			                        var _u = 'http://v.t.qq.com/share/share.php?url='+_url+'&appkey='+_appkey+'&site='+_site+'&pic='+_pic+'&title='+_t;
			                        window.open( _u,'', 'width=700, height=680, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, location=yes, resizable=no, status=no' );
			                    }
								(function(){
			                        var p = {
			                        url:'http://www.d1.com.cn/gdsinfo/<%=p.getId() %>.asp',
			                        desc:'<%=p.getGdsmst_gdsname() %>），市场价<%=p.getGdsmst_saleprice()  %>元，会员价仅<%=p.getGdsmst_memberprice() %>元，全国配送，假一赔二',/*默认分享理由(可选)*/
			                        summary:'<%=p.getGdsmst_gdsname() %>），市场价<%=p.getGdsmst_saleprice()  %>元，会员价仅<%=p.getGdsmst_memberprice() %>元，全国配送，假一赔二',/*摘要(可选)*/
			                        title:'<%=p.getGdsmst_gdsname() %>），市场价<%=p.getGdsmst_saleprice() %>元，会员价仅<%=p.getGdsmst_memberprice() %>元，全国配送，假一赔二',/*分享标题(可选)*/
			                        site: 'http://www.d1.com.cn/gdsinfo/<%=p.getId() %>.asp', /*分享来源 如：腾讯网(可选)*/
			                        pics:'' /*分享图片的路径(可选)*/
			                        };
			                        var s = [];
			                        for(var i in p){
			                        s.push(i + '=' + encodeURIComponent(p[i]||''));
			                        }
			                        document.write(['<a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?',s.join('&'),'" target="_blank" title="分享到QQ空间"><img src="http://images.d1.com.cn/images2012/New/qq.gif" alt="分享到QQ空间" /></a>'].join(''));
			                        })();
								</script>
							</div>
		  	
		  </td>
		  </tr>
		  
			<%
				}%>
				 <tr ><td id="favorite" colspan="4" style=" text-align:left; background-color:#f4f4f4;" height="40" >

			      <input type="checkbox" style="float:left; margin-left:12px; margin-top:3px; " id="checkall1" onclick="ChkAllClick('checksub','checkall1')" />&nbsp;&nbsp;<font color="#a25663"><b>全选</b></font>&nbsp;&nbsp;

				 
				  <a href="javascript:void(0)" onclick="delFavoriteAll(Alldelete('checksub'),'checksub');"><img src="http://images.d1.com.cn/images2012/New/user/plsc.jpg" style=" vertical-align:middle" /></a>

			   </td></tr>
			<%}
			else
			{%>
				<tr id="favorite"><td colspan="4" style=" text-align:center;" height="100" >
                     您没有收藏任何商品，<a href="http://www.d1.com.cn" ><font color="#0014a7">去首页逛逛</font></a>
			     </td></tr>
			<%}
			%>
		  

		   </table>

		    <table width="769"  border="0" cellspacing="0" cellpadding="0">

			<tr>
			
			<td colspan="7" height="45">
			<% if(list!=null&&list.size()>0)
			   {%>
			 <span class="Pager" style="margin:0px auto; overflow:hidden;">

					           	<span>共<font class="rd"><%=pb.getTotalPages()%></font>页-当前第<font class="rd"><%=pb.getCurrentPage()%></font>页</span>
								<%
									if(pb.getCurrentPage()>1){
								%>
					           	<a href="<%=request.getRequestURI()%>?pg=1">首页</a>
					           	<%} %>
					           	<%
									if(pb.hasPreviousPage()){
								%>
					           	<a href="<%=request.getRequestURI()%>?pg=<%=pb.getPreviousPage()%>">上一页</a>
					           	<%} %>
					           	<%
					           	 for(int i=pb.getStartPage();i<=pb.getEndPage()&&i<=pb.getTotalPages();i++){
					           		 if(i==pb.getCurrentPage()){
					           	%>
					           	<span class="curr"><%=i%></span><%}else{ %>
					           	<a href="<%=request.getRequestURI()%>?pg=<%=i%>"><%=i%></a>
								<%}
					           	 }
					           	if(pb.hasNextPage()){
								%>
					           	<a href="<%=request.getRequestURI()%>?pg=<%=pb.getNextPage()%>">下一页</a>
					           	<%}
					           	if(pb.getCurrentPage()<pb.getTotalPages()){
					           	%>

					           	<a href="<%=request.getRequestURI()%>?pg=<%=pb.getTotalPages()%>">尾页</a>
					           	<%
					           	}
					           	%>

					           </span>	
			
			<%}
				%>

	        </td>

			</tr>

			</table>

		   

		 <table width="769"  border="0" cellspacing="0" cellpadding="0"><tr><td height="50"></td></tr></table>

	  </div>
  
 
	  <!-- 右侧结束 -->
         
     </div>
    <div class="clear"></div>
    <!--中间内容结束-->
    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>
<script language="javascript">
	function ChkAllClick(sonName, cbAllId){
	 var arrSon = document.getElementsByName(sonName);
	 var cbAll = document.getElementById(cbAllId);
	 var tempState=cbAll.checked;
	 for(i=0;i<arrSon.length;i++) {
	  if(arrSon[i].checked!=tempState)
	           arrSon[i].click();
	 }
	}
	
	function Alldelete(sonName){
		 var arrSon = document.getElementsByName(sonName);
		 var result="";
		 for(i=0;i<arrSon.length;i++) {
		   if(arrSon[i].checked==true)
		     result+=arrSon[i].value+",";
		 }
		 result=result.substring(0,result.length-1);
		 if(result=="")
			 {
			 $.alert('您没有选择任何想要删除的商品');
			 return "";
			 }
		 else
			 {
			 return result;
			 }
		}
	
	function delFavoriteAll(ids,obj){
		if(ids=="")
			{
			return;
			}
		if(!window.confirm('您确认要删除所选择的商品吗？')) return;
		$.post("/ajax/product/favoriteDel.jsp",{"ids":ids},function(json){
			if(json.success){
				 //var arrSon = document.getElementsByName(obj);
				 window.location.reload();
				}
			else{
				$.alert(json.message);
			}
		},"json");
	}
	function delFavorite(id,obj){
		if(!window.confirm('您确认要删除吗？')) return;
		$.post("/ajax/product/favoriteDel.jsp",{"id":id},function(json){
			if(json.success){
				//var tr = $(obj).parent().parent();
				//var table = tr.parent();
				//tr.remove();
				//if(table.find("tr").length==0){
				//	$('#favorite').hide();
				//}
				window.location.reload();
			}else{
				$.alert(json.message);
			}
		},"json");
	}
</script>


