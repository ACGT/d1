<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static Date addDate(Date d,long day) throws ParseException { 

long time = d.getTime(); 
day = day*24*60*60*1000; 
time+=day; 
return new Date(time); 

} 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>优尚网9周年店庆活动专场第二波-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/jquery-1.3.2.min.js")%>"></script>
<style type="text/css">


input,button{margin:0;font-size:12px;vertical-align:middle;}
body{
	font-size:12px;
	font-family:Arial, Helvetica, sans-serif;
	text-align:center;
	margin:0 auto;
}

a{ margin:0px; padding:0px; text-decoration:none;}
a:hover{color:#ef9b11; text-decoration:underline;}


.numzf {
	font-size: 28px;
	color: #CA1300;
	
}
table td{ margin:0px; padding:0px; font-size:0px;}

-->
</style>
</head>

<script type="text/javascript">
function AutoScroll(obj){
	$(obj).find("ul:first").animate({
	marginTop:"-20px"
	},200,function(){
	$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
	});
	}
	$(document).ready(function(){
		setInterval('AutoScroll("#scrollDiv")',3000)
	});
	
	function checklen(text1){
	        if (text1.length > 140)//textarea控件不能用maxlength属性，就通过这样显示输入字符数了
	        {
	            $.alert("超过字数限制，请您精简部分文字!");
	            $("#zfcontent").text(text1.substr(0, 140));
	        }
	}
	function addzf(){
		var zfcontent=$.trim($("#zfcontent").val())
		
		if(zfcontent.length==0){
			$.alert("请填写祝福内容!");
			//return false;
		}
		else if(zfcontent.length>140){
			$.alert("超过字数限制，请您精简部分文字!");
			//return false;
		}else{
			 $.ajax({
                 type: "post",
                 dataType: "text",
                 contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                 url: "/html/zt2012/1203zndq/function.jsp",
                 cache: false,
                 data:{
                	 zf: "1",
                	 zfcontent: zfcontent
     		      },error: function(XmlHttpRequest, textStatus, errorThrown){
                   //  $.alert('修改信息失败！');
                 },success: function(msg){
                 	//alert(msg);
                 	 if(msg==2){
                 		$.alert("您今天已发表过祝福，请明天再来");
                 	 }
                 	 else if(msg==1){
                 		$.alert("发表成功！");
                 		window.location.href ='/html/zt2012/1203zndq/znzhufu.jsp#add';
                 	 }
                 }
                 }
         	)
		}
	}
	 var i=3;
	    function settime()
	    {
	       i--;
	      
	       if(i<=0)
	       {
	    	   window.location.reload(true);
	       }
	    }
</script>
<script type="text/javascript">

var lasttime=0;

function view_time2(){

    if(lasttime>0){
        var the_D=Math.floor((lasttime/3600)/24)

        var the_H=Math.floor(lasttime/3600);
        var the_M=Math.floor((lasttime-the_H*3600)/60);
        var the_S=(lasttime-the_H*3600)%60;
        //if(the_D!=0) html += '<span class="daynum">'+the_D+"</span>天";
        if(the_D!=0 || the_H!=0) {$("#h").text(the_H);}
        if(the_D!=0 || the_H!=0 || the_M!=0) {$("#m").text(the_M);}
        $("#s").text(the_S);
       // $getid(objid).innerHTML = html+html2+html1;
        lasttime--;
    }else{
    	//window.location.reload(true);

    }
}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<%
String code="2820";
int len=1;
ArrayList<Promotion> list=PromotionHelper.getBrandListByCode(code,100);

SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
SimpleDateFormat   dfdate=new   SimpleDateFormat("yyyy-MM-dd");
//List<SimpleExpression> listResall = new ArrayList<SimpleExpression>();
//listResall.add(Restrictions.ge("znzhufu_createdate", dfdate.parse(dfdate.format(new Date()))));
int countall=Tools.getManager(ZhuFu.class).getLength(null);
java.util.Date   nowszf=new   java.util.Date();   
java.util.Date   dates=df2.parse("2012-3-1 18:30:00");
int zfcount=(int)(nowszf.getTime()/3600/60-dates.getTime()/3600/60)*13;

%>
<table id="__01" width="981" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_01.jpg" width="655" height="154" alt=""></td>
		<td rowspan="2">
			<a href="http://www.d1.com.cn/html/zt2012/1203zndq/znwin.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_02.jpg" width="325" height="283" alt=""></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="154" alt=""></td>
	</tr>
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_03.jpg" width="655" height="129" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="129" alt=""></td>
	</tr>
	<tr>
		<td colspan="10" style=" background:url(http://images.d1.com.cn/zt2012/20120314qchd//dq2_04.jpg); width:980px; height:50px; padding-top:14px; ">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="24%">&nbsp;</td>
            <td width="13%" class="numzf"><%=countall*9+zfcount %></td>
            <td width="63%">&nbsp;</td>
          </tr>
        </table>
			</td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="64" alt=""></td>
	</tr>
	<tr>
		<td colspan="7" style="background:url(http://images.d1.com.cn/zt2012/20120314qchd//dq2_05-1.jpg);width:624px; height:64px;">
			<table width="100%" height="58" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="30%">&nbsp;</td>
            <td width="70%">
            <textarea name="zfcontent" id="zfcontent" cols="58" style="height:50px;" onkeydown='if (this.value.length&gt;=140){event.returnValue=false}' onkeyup="checklen(this.value)"></textarea>
            </td>
          </tr>
        </table>
        </td>
		<td colspan="3">
			<a href="javascript:addzf();"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_06.jpg" width="356" height="64" alt=""></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="64" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_07.jpg" width="379" height="38" alt=""></td>
		<td>
			<a href="http://www.d1.com.cn/jifen/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_08.jpg" width="123" height="38" alt=""></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/zt2012/1203zndq/znwin.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_09.jpg" width="118" height="38" alt=""></a></td>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_10.jpg" width="360" height="38" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="38" alt=""></td>
	</tr>
	<tr>
		<td colspan="5" style=" background:url(http://images.d1.com.cn/zt2012/20120314qchd//dq2_11.jpg); width:606px; height:98px;">
			 		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="67%">&nbsp;</td>
            <td width="33%">
            <%
            String nowtime=null;
            String endtime=null;
            SimpleDateFormat df=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            nowtime= df.format(new Date());
           if(list!=null&&list.size()>0)
           {
        	   if(list.get(0)!=null)
        			   {
        		          endtime=df.format(list.get(0).getSplmst_tjendtime()!=null?list.get(0).getSplmst_tjendtime():new Date());
        			   }
           }
            //SimpleDateFormat   df3=new   SimpleDateFormat("yyyy/MM/dd");
    	    //java.util.Date   nows=new   java.util.Date();   
    	    //java.util.Date   date=df2.parse("2012-02-29 12:00:00");
    	    //if(nows.getHours()>=date.getHours()&&nows.getMinutes()>=date.getMinutes()){
    	    	//endtime =df3.format(addDate(nows,1))+" 12:00:00";
    	   // }else{
     	    	
     	    	//endtime =df3.format(nows)+" 12:00:00";
    	   // }
    	    //endtime ="2012/03/06 12:00:00";
            %>
			<div style="margin-top:40px; overflow:hidden; ">
		<div style="float:left; width:55px; margin-left:10px;  _margin-left:4px;"><span id="h" style="color:#FFFFFF; font-size:25px; font-weight:bold; ">0</span></div>
		<div style="float:left; width:55px; margin-left:12px; _margin-left:8px; +margin-left:6px; margin-left:6px\0;"><span id="m" style="color:#FFFFFF; font-size:25px; font-weight:bold">0</span></div>
		<div style="float:left; width:55px; "><span id="s" style="color:#FFFFFF; font-size:25px; font-weight:bold">0</span></div>
		</div>
		 <script language=javascript>
		var startDate= new Date("<%=nowtime%>");var endDate= new Date("<%=endtime%>");
		 lasttime=(endDate.getTime()-startDate.getTime())/1000;
		//alert(lasttime);
		setInterval(view_time2,1000);</script>			</td>
            
          </tr>
        </table>
		</td>
		<td colspan="5" rowspan="2">
			<a href="http://www.d1.com.cn/zhuanti/20120312cjhzp/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_12.jpg" width="374" height="155" alt=""></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="98" alt=""></td>
	</tr>
	<tr>
		<td rowspan="6">
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_13.jpg" width="10" height="488" alt=""></td>
		<td colspan="4" rowspan="3" >
		    <%
			    
			   
			    if(list!=null && list.size()>0){
			       if(list.get(0)!=null)
			       {%>
			    	 <a href="<%= list.get(0).getSplmst_url().trim() %>" target="_blank" ><img src="<%= list.get(0).getSplmst_picstr().trim() %>" width="596" height="358" alt="<%= Tools.clearHTML(list.get(0).getSplmst_name()) %>" border="0"/></a>
			       <%}
			    }
	    %></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="57" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<a href="http://www.d1.com.cn/zhuanti/20120312cjhzp/index.jsp?#first" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_15.jpg" width="374" height="105" alt=""/></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="105" alt=""></td>
	</tr>
	<tr>
		<td colspan="5" rowspan="3">
			<a href="http://www.d1.com.cn/zhuanti/20120312cjhzp/index.jsp?#second" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_16.jpg" width="374" height="249" alt=""/></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="196" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_17.jpg" width="596" height="14" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="14" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="2">
		 <%
			    String code1="2821";
			  
			    ArrayList<Promotion> lists=PromotionHelper.getBrandListByCode(code1,100);
			   
			    if(lists!=null && lists.size()>0){
			       if(lists.get(0)!=null)
			       {%>
			    	<img src="<%= lists.get(0).getSplmst_picstr().trim() %>" width="596" height="116" alt="<%= Tools.clearHTML(lists.get(0).getSplmst_name()) %>" border="0"/>
			    	<%}
			    }
	    %>
			</td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="39" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<a href="http://www.d1.com.cn/zhuanti/20120312cjhzp/index.jsp?#third" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_19.jpg" width="374" height="77" alt=""></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="77" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_20.jpg" width="980" height="36" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="36" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_21.jpg" width="980" height="80" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="80" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/zhuanti/20120313yd/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_22.jpg" width="331" height="397" alt=""/></a></td>
		<td colspan="6">
			<a href="http://www.d1.com.cn/zhuanti/20120313xdp/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_23.jpg" width="312" height="397" alt=""/></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/zhuanti/20120220oly/oly.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_24.jpg" width="337" height="397" alt=""/></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="397" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/zhuanti/20120308ship/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_25.jpg" width="331" height="397" alt=""/></a></td>
		<td colspan="6">
			<a href="http://www.d1.com.cn/zhuanti/20120307xls/xls.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_26.jpg" width="312" height="397" alt=""/></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/result_rec.asp?aid=7517" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_27.jpg" width="337" height="397" alt=""/></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="397" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/zhuanti/20120214fmtx/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_28.jpg" width="331" height="402" alt=""/></a></td>
		<td colspan="6">
			<a href="http://www.d1.com.cn/zhuanti/20120309piju/piju.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_29.jpg" width="312" height="402" alt=""/></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/zhuanti/20120305nszc/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_30.jpg" width="337" height="402" alt=""/></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="402" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_31.jpg" width="980" height="33" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="33" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//dq2_32-1.jpg" width="980" height="5" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="1" height="5" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="10" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="321" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="48" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="123" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="104" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="14" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="4" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="19" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="12" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120314qchd//分隔符.gif" width="325" height="1" alt=""></td>
		<td></td>
	</tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>