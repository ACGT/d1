<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加友情链接</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  table a{color:#6495ED; font-size:12px; text-decoration:underline; margin-right:4px; }
  td{ height:30px;}
  input{ width:250px;}
  span{ color:#f00;}
</style>
<script type="text/javascript" language="javascript">
   function Check()
   {
	   var kw=$("#keyword").val();
	   var ws=$("#website").val();
	   if(kw=='')
		   {
		   $('#keyword_notice').html('关键字不能为空！！');
		   return false;
		   }
	   else
		   {
		   $('#keyword_notice').html('');
		    }
	   if(ws=='')
		   {
		   $('#website_notice').html('网址不能为空！！');
		   return false;
		   }
	   else
		   {
		   $('#website_notice').html('');
		   }
	   return true;
	     }
   
   function cancle()
   {
	   $("#keyword").val('');
	   $("#website").val('');
	   $("#qq").val('');
	   $("#page").val('');
	   $("#nofollow").val('0');
	   $("#keyword").focus();
   }
</script>

</head>
<body>
<%
String counterids= request.getParameter("counterids");
long counterid=0;
if(!Tools.isNull(counterids)){
	counterid=Tools.parseLong(counterids);
}
  if("post".equals(request.getMethod().toLowerCase()))   
  {
	  String keyword=request.getParameter("keyword");
	  String website=request.getParameter("website");
	  String qq=request.getParameter("qq");
	  String pages=request.getParameter("page");
	  String nofollow=request.getParameter("nofollow");

	  
	  if(keyword==null||keyword.length()==0)
	  {
		  Tools.outJs(out, "关键字不能为空", "back");
		  return;
	  }
	  if(website==null||website.length()==0)
	  {
		  Tools.outJs(out, "网址不能为空", "back");
		  return;
	  }
	  if(qq!=null&&qq.length()>0&&!Tools.isMath(qq))
	  {
		  Tools.outJs(out, "qq格式不正确！", "back");
		  return;
	  }
	  FriendLink fl=new FriendLink();
	  fl.setFriendlink_keword(keyword);
	  fl.setFriendlink_website(website);
	  fl.setFriendlink_page(pages);
	  fl.setFriendlink_type(new Long(counterid));
	  fl.setFriendlink_qq(qq);
	  fl.setFriendlink_nofollow(new Long(nofollow));
	  fl=(FriendLink)Tools.getManager(FriendLink.class).create(fl);
	  if(fl!=null)
	  {
		  Tools.outJs(out, "添加成功！", "/admin/friendlink/addfriendlink.jsp");
	  }
  }

%>
<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px;">
   <h1 style=" font-size:25px;">添加友情链接</h1>
   <a href="friendlinklist.jsp">友情链接管理</a><br/>
   <form id="friendlink" method="post" action="addfriendlink.jsp" onsubmit="Check();">
   <table style=" margin:0px auto; font-size:14px;text-align:left;">
        <tr><td>关键字：</td><td><input type="text" id="keyword" name="keyword" onblur="Check();"/>&nbsp;&nbsp;<span id="keyword_notice"></span></td></tr>
        <tr><td>网址：</td><td><input type="text" id="website" name="website" onblur="Check();"/>&nbsp;&nbsp;<span id="website_notice">链接地址</span></td></tr>
        <tr><td>联系QQ：</td><td><input type="text" id="qq" name="qq"/>&nbsp;&nbsp;</td></tr>
        <tr><td>品牌馆ID：</td><td><input type="text" id="counterids" name="counterids"/ value=<%=counterid %>>&nbsp;&nbsp;</td></tr>
        <tr><td>显示页面：</td><td><select id="page" name="page">
                                          <option value="1">首页</option>
                                          <option value="2_1">二级页-化妆品</option>
                                          <option value="2_2">二级页-男装</option>
                                          <option value="2_3">二级页-女装</option>
                                          <option value="2_4">二级页-饰品</option>
                                          <option value="2_5">二级页-女包</option>
                                          <option value="2_6">二级页-名表</option>
                                          <option value="3">搜索页</option>
                                          <option value="4">result页</option>
                                          <option value="5">特卖会列表页</option>
                                          <option value="5-1">特卖会专题页</option>
                                          <option value="6" <%if (counterid>0)out.print("selected"); %>>品牌馆页</option>
                                          <option value="7">专题页</option>
                                    </select></td></tr>
        <tr><td>是否nofollow：</td><td><select id="nofollow" name="nofollow">
                                          <option value="0">否</option>
                                          <option value="1">是</option>
                                       </select></td></tr>
                  <tr><td colspan="2"><input type="submit" value="添加" style="width:80px;"/>&nbsp;&nbsp;<input type="button" value="取消" style="width:80px;" onclick="cancle();"/></td></tr>
   </table>
     
   </form>
</div>
</body>
</html>





