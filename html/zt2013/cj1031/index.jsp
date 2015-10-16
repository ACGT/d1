<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
private ArrayList<LotWinAct> lotwinlist(){
	ArrayList<LotWinAct> list=new ArrayList<LotWinAct>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("id"));
	List<BaseEntity> lotlist= Tools.getManager(LotWinAct.class).getList(null, olist, 0, 50);
	if(lotlist==null || lotlist.size()==0) return null;
	for(BaseEntity be:lotlist){
		list.add((LotWinAct)be);
	}
	return list;
}

private static ArrayList<LotCon> getLotCon(){
	ArrayList<LotCon> list=new ArrayList<LotCon>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("lotcon_winid", new Long(4)));
	//olist.add(Order.desc("id"));
	List<BaseEntity> mxlist= Tools.getManager(LotCon.class).getList(clist, null, 0,2);
	if(mxlist==null || mxlist.size()==0) return null;
	for(BaseEntity be:mxlist){
		list.add((LotCon)be);
	}
	
	List<SimpleExpression> clist2 = new ArrayList<SimpleExpression>();
	clist2.add(Restrictions.eq("lotcon_flag", new Long(0)));
	clist2.add(Restrictions.ne("lotcon_winid", new Long(4)));
	//olist.add(Order.desc("id"));
	List<BaseEntity> mxlist2= Tools.getManager(LotCon.class).getList(clist2, null, 0,19);
	if(mxlist2==null || mxlist2.size()==0) return null;
	for(BaseEntity be:mxlist2){
		list.add((LotCon)be);
	}
	return list;
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />


<title>双十一网购狂欢节</title>
</head>
<style>
body{ margin:0px; padding:0px;  font-size:12px;}
form{ padding:0px; margin:0px;}
  ul,li{margin:0;padding:0}
.cyhead{
	margin:0 auto;
	background-image: url(http://images.d1.com.cn/zt2013/cj1311/cj11_01_01.jpg);
	background-repeat: no-repeat;
	background-position: center;
	height:384px;
}
.cyhead2{
	margin:0 auto;
	background-image: url(http://images.d1.com.cn/zt2013/cj1311/cj11_01_02.jpg);
	background-repeat: no-repeat;
	background-position: center;
	height:290px;
}
.bg01{background-image: url(http://images.d1.com.cn/zt2013/cj1311/bg01.jpg);
	background-repeat: no-repeat;
	background-position: left top; }
.hitcj{ width:980px; margin:0 auto; padding-top:50px; height:240px;}


.cjboxt {
	font-family: "微软雅黑";
	color: #FFFFFF;
	font-size: 50px;
	font-weight: bold;
}
.cjboxtxt{font-family: "微软雅黑";
	color: #FFFFFF;
	font-size: 23px;
	font-weight: bold;}
.cjboxbq {font-family: "微软雅黑";color: #f9af3a; font-size:14px;font-weight: bold;}
.cjboxnum{ font-family: "微软雅黑";font-size:60px; color:#fab324;font-weight: bold;}
.cjboxinput{ height:26px;}

.cjboxgdst{ font-size:12px;  color: #ffffff;}
.cjboxgdsp{font-family: "微软雅黑";color: #FFFF00;font-size:16px; }
.lotbutton{float:left;width:100%;text-align:center;margin-bottom:15px;margin-top: 10px;}


#scrollDiv{width:900px;height:300px; margin-top:8px;line-height:21px;overflow:hidden}
#scrollDiv li{height:21px; width:430px;padding-left:8px;color:#525252;text-align:left;float:left;overflow:hidden}

.pstime{margin:0 auto;height:35px; width:320px;padding-left:180px; padding-top:20px;}
</style>
<script type="text/javascript">
function $getid(id)
{
    return document.getElementById(id);
}
//限时抢购
var the_s=new Array();
function view_time(the_s_index,objid){
	 if(the_s[the_s_index]>=0){
        var the_D=Math.floor((the_s[the_s_index]/3600)/24)
        var the_H=Math.floor((the_s[the_s_index]-the_D*24*3600)/3600);
        var the_M=Math.floor((the_s[the_s_index]-the_D*24*3600-the_H*3600)/60);
        var the_S=(the_s[the_s_index]-the_H*3600)%60;
        html = "";
        if(the_D!=0) html += '<em>'+the_D+"</em>天";
        if(the_D!=0 || the_H!=0) html += '<em>'+(the_H)+"</em>小时";
        if(the_D!=0 || the_H!=0 || the_M!=0) html += '<em>'+the_M+"</em>分";
        html += '<em>'+the_S+"</em>秒";
        $getid(objid).innerHTML = html;
        the_s[the_s_index]--;
    }else{
        $getid(objid).innerHTML = "已结束";
    }
}
function getlot(){
	 <%
	 if(lUser==null){
	 %>
	 $.close(); 	Login_Dialog();
			<%}else{
				
			%>
	$.close(); 
	var s3="";if((typeof c)!="undefined"){s3="?c="+encodeURIComponent(c);}else{s3=""+document.location;s3=s3.replace("http://","");s3=s3.substring(s3.indexOf("/"));s3="?c="+encodeURIComponent(s3);}$.load('中奖提醒',450,'/html/zt2013/cj1031/myprize.jsp');
			<%
			}%>
}


</script>
<body>

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<div style="background:#d70b52;">
<div class="cyhead">
<div class="pstime">
<span id="xstj_1" style="display:block; width:320px; overflow:hidden;  height:33px; overflow:hidden; line-height:33px; font-size:20px; color:#000000; font-family:'微软雅黑';font-weight:bold;">
		    <em>00</em><em>00</em><em>00</em>
		     <%SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
						       
						       String	nowtime2= DateFormat.format( new Date());
						       String endtime2= "2013/11/11 00:00:00";
						    %>
						     <SCRIPT language="javascript">
                             var startDate= new Date("<%=nowtime2%>");
                             var endDate= new Date("<%=endtime2%>");
                             the_s[0]=(endDate.getTime()-startDate.getTime())/1000;
                             setInterval("view_time(0,'xstj_1')",1000);
                             </SCRIPT></span>
</div>

</div>
<div class="cyhead2">
<a href="#" onclick="getlot();" ><div class="hitcj"></div></a>
</div>


<table width="980" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><img src="http://images.d1.com.cn/zt2013/cj1311/cj11_03-3.jpg" width="980" height="372" border="0" usemap="#Map" /></td>
  </tr>
  <tr>
    <td><table width="980" height="635" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="36" class="bg01">&nbsp;</td>
        <td bgcolor="#be181c"><table width="944" border="0" cellspacing="0" cellpadding="0">
        <%ArrayList<LotCon> lotlist=getLotCon(); 
        int j=0;
        if (lotlist!=null)
        {
        	int num=lotlist.size();
        for (LotCon be:lotlist){
        	Product product = ProductHelper.getById(be.getLotcon_gdsid());
        	if(product == null){
        		continue;
        	}
        	String smallimg=ProductHelper.getImageTo160(product);
        	if(j==0||j%6==0){
        		out.print("<tr><td width=\"5\">&nbsp;</td>");
        	}
 
        %>
            <td height="153"><img src="<%=smallimg %>" width="150" height="150" /></td>
 
          <%if((j+1)%6==0){
        	  out.println("</tr>");
          }
          j=j+1;
          } }%>
        <td height="153"><img src="http://images.d1.com.cn/zt2013/cj1311/q100.jpg" width="150" height="150" /></td>
        <td height="153"><img src="http://images.d1.com.cn/zt2013/cj1311/q50.jpg" width="150" height="150" /></td>
        <td height="153"><img src="http://images.d1.com.cn/zt2013/cj1311/q20.jpg" width="150" height="150" /></td>
       </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="942" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td><img src="http://images.d1.com.cn/zt2013/cj1311/cj11_07.jpg" width="942" height="104" /></td>
      </tr>
      <tr>
        <td height="325" valign="top" bgcolor="#9A1914"><table width="910" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="310" bgcolor="#FFFFFF">
<div id="scrollDiv">
              <ul>
              <%
              ArrayList<LotWinAct> list=lotwinlist();
              if (list!=null)
              {
              for(LotWinAct be:list){ 
            	  String Lotwin8zn_uid="";
            	  if(be.getLotwin8zn_uid().length()>4){
            		  Lotwin8zn_uid=be.getLotwin8zn_uid().substring(0,4);
                	  }
                	  else{
                	   Lotwin8zn_uid=be.getLotwin8zn_uid();
                	  }

            	//String Lotwin8zn_uid=be.getLotwin8zn_uid().substring(0,4);
            	String Lotwin8zn_memo=be.getLotwin8zn_memo();
            	if(be.getLotwin8zn_winid()!=null&&(be.getLotwin8zn_winid().longValue()==4||be.getLotwin8zn_winid().longValue()==3)){
              %>
              
			  <li><span style="color:#C00000"><%=Lotwin8zn_uid%>***&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%=Lotwin8zn_memo%></span></li>
      <%}else{ %>
       <li><%=Lotwin8zn_uid%>***&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%=Lotwin8zn_memo%></li>
      <%}} }%>
			  </ul>
              </div>
			  <script>
function AutoScroll(obj){
$(obj).find("ul:first").animate({
marginTop:"-230px"
},288,function(){
//$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
	for(i=1;i<=13;i++){
		$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
		}
	$(this).css({marginTop:"0px"})
});
}
$(document).ready(function(){
setInterval('AutoScroll("#scrollDiv")',5000)
});

</script>
</td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="980" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><img src="http://images.d1.com.cn/zt2013/cj1311/cj11_10.jpg" width="980" height="97" /></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF">
<% request.setAttribute("code","8963");
		request.setAttribute("length","200");%>
      <jsp:include   page= "gdsrec.jsp"   />
</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="980" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><img src="http://images.d1.com.cn/zt2013/cj1311/cj11_12.jpg" width="980" height="97" /></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF">
<% request.setAttribute("code","8964");
		request.setAttribute("length","200");%>
      <jsp:include   page= "gdsrec.jsp"   />
</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="980" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><img src="http://images.d1.com.cn/zt2013/cj1311/cj11_14.jpg" width="980" height="98" /></td>
      </tr>
      <tr> <td bgcolor="#FFFFFF">
        <a href="http://www.d1.com.cn/zhuanti/201310/20131029zp/" target="_blank"><img src="http://images.d1.com.cn/zt2013/cj1311/event_02.jpg" /></a>
        <a href="http://www.d1.com.cn/zhuanti/201311/1104nzhd/" target="_blank"><img src="http://images.d1.com.cn/zt2013/cj1311/event_01-4.jpg" /></a>
        <a href="http://www.d1.com.cn/zhuanti/201310/1030nan/" target="_blank"><img src="http://images.d1.com.cn/zt2013/cj1311/event_04.jpg" /></a>
        <a href="http://www.d1.com.cn/zhuanti/201310/20131029fz/" target="_blank"><img src="http://images.d1.com.cn/zt2013/cj1311/event_03-3.jpg" /></a>
        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
        <td>&nbsp;</td>
      </tr>
</table>
</div>

<map name="Map" id="Map">
<area shape="rect" coords="-1,0,980,232" href="#" onclick="getlot();" />
</map>

<%@include file="/inc/foot.jsp"%>
</body>
</html>
