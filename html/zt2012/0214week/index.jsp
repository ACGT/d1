<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
private ArrayList<WeekAct> weekactlist(){
	ArrayList<WeekAct> list=new ArrayList<WeekAct>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("weekact_flag", new Long(1)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("weekact_sort"));
	olist.add(Order.desc("id"));
	List<BaseEntity> weeklist= Tools.getManager(WeekAct.class).getList(clist, olist, 0, 50);
	if(weeklist==null || weeklist.size()==0) return null;
	for(BaseEntity be:weeklist){
		list.add((WeekAct)be);
	}
	return list;
}
static String getUid(String str){
	if(str==null)str="";
	return "***"+StringUtils.getCnSubstring(str,0,10);
}
private long icount=0;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/jquery-1.3.2.min.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>

<title>一周主打星。D1优尚网</title>
<style type="text/css">
<!--
.tlput {
	width: 150px;
	border: 1px solid #C2C2C2;
	height: 26px;
	font-size:14px;
}
.line {
	border: 1px solid #A44153;
}
form{ padding:0px; margin:0px;}
  ul,li{margin:0;padding:0}
.scrollDiv{width:245px;height:250px;line-height:21px;overflow:hidden}
.scrollDiv li{height:80px;padding-left:4px;color:#525252;text-align:left}
ul,li{ list-style:none;}
.scrollDiv .user{ padding-top:10px;left:0;width:80px;text-align:center;color:#999;float:left;}
.scrollDiv .user a{color:#005aa0;}
.scrollDiv .u-icon img{border:2px solid #EAEAEA;}
.scrollDiv .u-txt{padding-top:10px;left:0;width:150px;color:#999; font-size:12px; float:right;}
.scrollDiv .tail{ height:80px;}
-->
</style>
</head>

<body>
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<table width="980" border="0" align="center" style="margin-top:10px;" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="http://images.d1.com.cn/zt2012/week0214/weekact_1.jpg" width="980" height="76"></td>
  </tr>
  <tr>
    <td>
           <%
              ArrayList<WeekAct> list=weekactlist();
              if (list!=null)
              {  	  icount=(long)list.size();
              long num=0;
              for(WeekAct be:list){ 
            	  String Weekact_plid=be.getWeekact_plid();
            	  String arrcomment[]=null;
          
            	  if (!Tools.isNull(Weekact_plid)){
            		  arrcomment=Weekact_plid.split(",");
                     }
              %>
    <table width="980" height="38" border="0" <%if (num!=0){ %>style="margin-top:10px;"<%} %> cellpadding="0" cellspacing="0" class="line">
      <tr>
        <td width="720" height="19" rowspan="2" align="right"><a href="<%=be.getWeekact_url()%>" target="_blank"><img src="<%=be.getWeekact_imgurl()%>" width="714" height="308" border=0></a></td>
        <td width="260" height="50" align="center"><img src="http://images.d1.com.cn/zt2012/week0214/weekact_3.jpg" width="235" height="51"></td>
      </tr>
      <tr>
        <td><div id="scrollDiv<%=num%>" class="scrollDiv">
          <ul>
          <%if (arrcomment!=null){
          for(int i = 0; i<arrcomment.length ;i++){ 
        	  Comment comment = CommentHelper.getById(arrcomment[i]);
        	  if (comment!=null){
        	  User user = UserHelper.getById(String.valueOf(comment.getGdscom_mbrid()));
				String hfusername = getUid(comment.getGdscom_uid());
				String level = UserHelper.getLevelText(user);
        	  %>
              <li>
              <div class="tail">
                <div class="user">
                  <div class="u-icon"> <img src="<%=UserHelper.getLevelImage(level) %>" width="63" height="63" /> </div>
                </div>
                <div class="u-txt" align="left" > <span><%=hfusername %></span><br>
                    <span ><%String comment_content=comment.getGdscom_content();
                            if (comment_content.length()>22){
                            	out.print( comment_content.subSequence(0, 22));
                            } else{
                            	out.print(comment_content);
                            }
                            %></span> </div>
              </div>
            </li>
            <%}
        	 
          }  
          %>
                     <script>
function AutoScroll(obj){
$(obj).find("ul:first").animate({
marginTop:"-46px"
},200,function(){
$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
});
}
$(document).ready(function(){
	setInterval('AutoScroll("#scrollDiv'+<%=num%>+'")',5000)
});


</script>  
        <%
          num++; 
  
          }%>
			 
          </ul>
        </div>
        <div align="right"><a href="<%=be.getWeekact_url()%>#cmt2" target="_blank" style=" font-size:14px; color:#A74053">查看更多评论</a>&nbsp;&nbsp;&nbsp;&nbsp;</div></td>
</td>
      </tr>
    </table>
      <%} }%>
 
    </td>
  </tr>
</table>
<%@include file="/inc/foot.jsp"%>
</body>
</html>
