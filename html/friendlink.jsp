<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%!
    //获取所有友情链接
    private String getFriendLink()
    {
	    StringBuilder sb=new StringBuilder();
	    ArrayList<FriendLink> list=new ArrayList<FriendLink>();
	    list=FriendLinkHelper.getFriendLinkList();
	    if(list!=null&&list.size()>0)
	    {
	    	sb.append(" <ul class=\"fltable\">");
	    	for(FriendLink fl:list)
	    	{
               if(fl!=null)
               {
            	   sb.append("<li><a href=\"").append(fl.getFriendlink_website().trim()).append("\" target=\"_blank\"");
            	   if(fl.getFriendlink_nofollow().longValue()==1)
            	   {
            		   sb.append(" rel=\"nofollow\"");
            	   }
            	   sb.append("/>");
            	   sb.append(Tools.clearHTML(fl.getFriendlink_keword()));
            	   sb.append("</a></li>");
               }
	    	}
	    	sb.append("</ul>");
	    }
	    return sb.toString();
    }
    
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-友情链接</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
 .centers{margin:0px auto; margin-top:20px; width:960px;}

 .link{ width:963px; display:hidden;  padding-bottom:50px;}
 .top{ background:url(http://images.d1.com.cn/images2012/fl_topbg.jpg) no-repeat; height:7px; margin:0px;}
 .contents{border-left:solid 1px #d4b1b7; border-right:solid 1px #d4b1b7; width:961px; padding-bottom:35px; _margin-top:-10px;}
 h3{ background:url(http://images.d1.com.cn/images2012/fl_s_bg.jpg) repeat-x; height:55px; color:#1e4fae; font-size:14px; font-weight:bold; 
 line-height:55px;  padding-left:35px; }
 .bottom{ background:url(http://images.d1.com.cn/images2012/fl_bbg-1.jpg) no-repeat; height:7px;}

 .fltable{ width:900px; text-align:left; padding:0px; }

 .fltable  li{ display:block; border-bottom:dashed 1px #cdddea; float:left;width:150px; line-height:30px; 
 background:url(http://images.d1.com.cn/images2012/fl_jt.jpg) no-repeat 0px 11px; overflow:hidden;}
 .fltable li a{ color:#1b50b0; text-decoration:none; cursor:hand; padding-left:14px;}
 .fltable li a:hover{ color:#1b50b0; text-decoration:none; cursor:hand;}
</style>

</head>

<body style="background:#fff;">
<%@include file="/inc/head.jsp" %>
<div class="clear"></div>
<div class="centers">
   <div class="link">
       <div class="top"></div>
       <div class="contents">
       <h3>友情链接</h3>
       <center>
       <table>
       <tr><td>
      <%= getFriendLink() %>
      </td>
      </tr>
     </table>
       
       </center>
       </div>
       <div class="clear"></div>
       <div class="bottom">
        
       </div>
   </div>
   <div style=" text-align:center;">d1优尚网更新频率快，已获得几大门户网站链接支持，欢迎服装类，电子商务类，女性类网站与若缇诗交换友情链接。
具体情况请联系 QQ：905931871或2455930652</div>
</div>
<div class="clear"></div>
<%@include file="/inc/foot.jsp" %></body>
</html>