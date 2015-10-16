<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static Date addDate(Date d,long day) throws ParseException { 

long time = d.getTime(); 
day = day*24*60*60*1000; 
time+=day; 
return new Date(time); 

} 
static ArrayList<SecKill> getTodayProduct(){
	ArrayList<SecKill> list=new ArrayList<SecKill>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.ge("mstjgds_endtime", new Date()));
	listRes.add(Restrictions.eq("mstjgds_state", new Long(1)));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.asc("mstjgds_sort"));
	listOrder.add(Order.desc("id"));
	List<BaseEntity> mxlist= Tools.getManager(SecKill.class).getList(listRes, listOrder, 0,18);
	if(mxlist==null || mxlist.size()==0) return null;
	for(BaseEntity be:mxlist){
		list.add((SecKill)be);
	}
	 return list;
}
static ArrayList<SecKill> getTodayProductend(){
	ArrayList<SecKill> list=new ArrayList<SecKill>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	//listRes.add(Restrictions.ge("mstjgds_endtime", new Date()));
	listRes.add(Restrictions.eq("mstjgds_state", new Long(2)));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.asc("mstjgds_downtime"));
	listOrder.add(Order.desc("id"));
	List<BaseEntity> mxlist= Tools.getManager(SecKill.class).getList(listRes, listOrder, 0,3);
	if(mxlist==null || mxlist.size()==0) return null;
	for(BaseEntity be:mxlist){
		list.add((SecKill)be);
	}
	 return list;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>优尚网9周年店庆活动专场-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/jquery-1.3.2.min.js")%>"></script>
<style type="text/css">
<!--
body,h1,h2,h3,h4,h5,h6,p,ul,ol,li,form,img,dl,dt,dd,table,th,td,blockquote,fieldset,div,strong,label,em{margin:0;padding:0;border:0;}
ul,ol,li{list-style:none;}
input,button{margin:0;font-size:12px;vertical-align:middle;}
body{
	font-size:12px;
	font-family:Arial, Helvetica, sans-serif;
	margin:0 auto;
}
table{border-collapse:collapse;border-spacing:0;}

.clearfloat{height:0;font-size:1px;clear:both;line-height:0;}
#container{  width:960px; text-align:left; margin:0 auto; }
a{color:#333;text-decoration:none;}
a:hover{color:#ef9b11; text-decoration:underline;}

.layout_main{ width:897px;}
.content_bottom UL LI {FLOAT: left;padding:15px 0 0 15px;}
.content_bottom UL LI.brand_item {WIDTH: 270px; HEIGHT: 270px;}
.brand_item A {DISPLAY: block; WIDTH: 270px; HEIGHT: 270px;}
.brand_item A:hover {TEXT-DECORATION: none;}
.brand_item A.brand_name img{border: 2px solid #b69d6b;}
.brand_item A.brand_detail img{border: 2px solid #daa900;}
#endproduct{ filter:progid:DXImageTransform.Microsoft.BasicImage(grayscale=1); }
.numzf {
	font-size: 28px;
	color: #CA1300;
}

.zngdslist{  width:938px; height:448px; background-color:#ECF8F4; padding:10px 0 10px 0; }
.zngdslist li{
	FLOAT: left;
	padding:10px;
	_padding:8px;
	width:275px;
	_width:273px;
	height:420px;
	background-color:#1B98CE;
	margin-left:14px;
}
.zngdslist li .gdsimg{WIDTH: 270px; HEIGHT: 270px;}
.zngdslist li .gdsitem {WIDTH: 270px;HEIGHT: 140px; padding-top:5px;color:#FFFFFF;}
.zngdslist li .gdsitem .title{
height: 36px;
height: 34pxurl(0);
overflow: hidden;
line-height: 18px; font-size:14px; }

a{color:#333;text-decoration:none;}
a:hover{color:#ef9b11; text-decoration:underline;}
.areatxt {	border: 1px solid #cccccc;	background-color: #F4F4F4;}
.gdspiclist{  width:938px;  background-color:#ECF8F4; padding:10px 0 10px 0; }
.gdspiclist li{
	FLOAT: left;
	width:460px;
	height:245px;
}
-->
</style>
</head>
<SCRIPT type=text/javascript>
	$(document).ready(function(){
                  // 判断img轮转，实现a跳转
		// 推荐品牌滑动翻转效果
		brandPicTurn();
	});
	function brandPicTurn(){
		$(".brand_detail").hide();
		$(".brand_item").hover(
			function(){
				$(this).children(".brand_name").hide();
				$(this).children(".brand_detail").show();
			}
			, function(){
				$(this).children(".brand_detail").hide();
				$(this).children(".brand_name").show();
			}
		);
	}
</SCRIPT>
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
	function addzf1(){
		$.alert("该活动已结束");
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
                 url: "function.jsp",
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
                 		window.location.href ='znzhufu.jsp#add';
                 		//setInterval("settime()",1000);
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

	    function Tktget(id){
	        $.post("/html/zt2012/1203zndq/mktktget.jsp",{"id":id},function(json){
	    		if(json.success){
	    			$.alert(json.message);

	    			}
	    		else{
	    			$.alert(json.message);
	    		}
	    	},"json");
	        
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
SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
SimpleDateFormat   dfdate=new   SimpleDateFormat("yyyy-MM-dd");
//List<SimpleExpression> listResall = new ArrayList<SimpleExpression>();
//listResall.add(Restrictions.ge("znzhufu_createdate", dfdate.parse(dfdate.format(new Date()))));
int countall=Tools.getManager(ZhuFu.class).getLength(null);
java.util.Date   nowszf=new   java.util.Date();   
java.util.Date   dates=df2.parse("2012-3-1 18:30:00");
int zfcount=(int)(nowszf.getTime()/1000/60-dates.getTime()/1000/60)*13;

%>
<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="6">
		<table id="__01" width="980" height="564" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/zntj4_01.jpg" width="980" height="55" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/zntj4_02.jpg" width="980" height="109" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/zntj4_03.jpg" width="433" height="65" alt=""></td>
		<td>
			<a href="#" onclick="Tktget('1');"><img src="http://images.d1.com.cn/zt2012/20120305nszc/zntj4_04.jpg" width="487" height="65" alt=""></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/zntj4_05.jpg" width="60" height="65" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/zntj4_06.jpg" width="980" height="86" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/zntj4_07_2.jpg" width="980" height="84" alt=""></td>
	</tr>
	<tr>
		<td height="42" colspan="3" background="http://images.d1.com.cn/zt2012/20120305nszc/zntj4_08.jpg"><table width="100%" height="42" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="25%">&nbsp;</td>
            <td width="13%" class="numzf"><%=countall*9+zfcount %></td>
            <td width="62%">&nbsp;</td>
          </tr>
        </table></td>
	</tr>
	<tr>
		<td colspan="3">
		<table id="__01" width="980" height="71" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="657" background="http://images.d1.com.cn/zt2012/20120305nszc/zntj4_09_01.jpg"><table width="100%" height="69" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="32%">&nbsp;</td>
            <td width="68%"><textarea name="zfcontent" id="zfcontent" cols="58" rows="4" class="areatxt" onkeydown='if (this.value.length&gt;=140){event.returnValue=false}' onkeyup="checklen(this.value)"></textarea>
            </td>
          </tr>
        </table></td>
		<td>
			<a href="javascript:addzf1();"><img src="http://images.d1.com.cn/zt2012/20120305nszc/zntj4_09_02.jpg" alt="" width="169" height="71" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/zntj4_09_03.jpg" width="154" height="71" alt=""></td>
	</tr>
</table>
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/zntj4_10.jpg" width="980" height="52" alt="" usemap="#link"></td>
	</tr>
</table>
		</td>
	</tr>
		<tr>
		<td height="77" colspan="6" background="http://images.d1.com.cn/zt2012/20120305nszc/zntj_11.jpg">
		<table width="100%" height="77" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="67%">&nbsp;</td>
            <td width="18%">
            <%
            String nowtime=null;
            String endtime=null;
            SimpleDateFormat df=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            nowtime= df.format(new Date());
          
            SimpleDateFormat   df3=new   SimpleDateFormat("yyyy/MM/dd");
    	    java.util.Date   nows=new   java.util.Date();   
    	    java.util.Date   date=df2.parse("2012-02-29 12:00:00");
    	    if(nows.getHours()>=date.getHours()&&nows.getMinutes()>=date.getMinutes()){
    	    	endtime =df3.format(addDate(nows,1))+" 12:00:00";
    	    }else{
     	    	
     	    	endtime =df3.format(nows)+" 12:00:00";
    	    }
    	    //endtime ="2012/03/06 12:00:00";
            %>
			<div style="margin-top:10px; margin-left:10px;">
		<div style="float:left; width:40px;"><span id="h" style="color:#FFFFFF; font-size:25px; font-weight:bold; ">0</span></div>
		<div style="float:left; margin-left:20px; width:40px;"><span id="m" style="color:#FFFFFF; font-size:25px; font-weight:bold">0</span></div>
		<div style="float:left; margin-left:20px; width:40px;"><span id="s" style="color:#FFFFFF; font-size:25px; font-weight:bold">0</span></div>
		</div>
		 <script language=javascript>
		var startDate= new Date("<%=nowtime%>");var endDate= new Date("<%=endtime%>");
		 lasttime=(endDate.getTime()-startDate.getTime())/1000;
		//alert(lasttime);
		setInterval(view_time2,1000);</script>			</td>
            <td width="15%">&nbsp;</td>
          </tr>
        </table>		</td>
	</tr>
	<tr>
	  <td background="http://images.d1.com.cn/zt2012/20120305nszc/zntj_12.jpg">&nbsp;</td>
	  <td colspan="4">
	  <div class="zngdslist">
	    <ul>
	    <%
	    String code="7489";
	    int len=3;
	    ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,100);
	    ArrayList gdsidlist=new ArrayList();
	    if(list!=null && list.size()>0){
	    	
	    	for(PromotionProduct pProduct:list){
	    		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
	    		
	    	}
	    	if(gdsidlist!=null && gdsidlist.size()>0){
	    		
	    	int i=0;
	    	ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
	    	int l=0;
	    	if(productlist!=null){
	    		for(Product product:productlist){
	    			ArrayList<PromotionProduct> pproductlist= PromotionProductHelper.getPProductByCodeGdsid(code,product.getId());
	    			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
	    			if(pproductlist!=null && directory!=null){
	    				
	    			 PromotionProduct pProduct=pproductlist.get(0);
	    %>
	      <li>
		  <div class="gdsimg"><a href="http://www.d1.com.cn/product/<%=product.getId()%>" target="_blank"><img src="http://images.d1.com.cn/<%=product.getGdsmst_midimg()%>" width="270" height="270" broder="0"></a></div>
		  <div class="gdsitem">
		  <span class="title"><%=Tools.substring(pProduct.getSpgdsrcm_gdsname(),(int)40)%></span><br>
		  <span><font size="6">&nbsp;&nbsp;￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %></font>&nbsp;&nbsp;&nbsp;<font size="4"><S>原售价:￥<%=Tools.getFormatMoney(product.getGdsmst_oldmemberprice()) %></S></font></span><br><br>
		  <span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" attr="<%=product.getId() %>" onclick="$.inCart(this);"><img src="http://images.d1.com.cn/zt2012/20120305nszc/04.jpg" width="111" height="28" broder="0"></a></span><br>
		  </div>
		  </li>
		  <%
		l++;
			}
	}
}
	}
}
%>
        </ul>
	  </div>	  </td>
	  <td background="http://images.d1.com.cn/zt2012/20120305nszc/zntj_14.jpg">&nbsp;</td>
  </tr>
	
	<tr>
		<td colspan="6">
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/zntj_15.jpg" width="980" height="36" alt=""></td>
	</tr>
	<tr>
		<td colspan="6">
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/zntj_16.jpg" width="980" height="85" alt=""></td>
	</tr>
	<tr>
	  <td background="http://images.d1.com.cn/zt2012/20120305nszc/zntj_12.jpg">&nbsp;</td>
	  <td colspan="4" align="center" bgcolor="#ECF8F4">
	  <div class="gdspiclist">
	    <ul>
	  <%int i=1;
	  ArrayList<Promotion>  recommendList=new ArrayList<Promotion>();
			                            recommendList = PromotionHelper.getBrandListByCode("2817" ,18);
			                            if(recommendList != null && !recommendList.isEmpty()){
			                            	for(Promotion recommend : recommendList){
			                            		String imgurl = recommend.getSplmst_picstr();
			                            		String url=StringUtils.encodeUrl(recommend.getSplmst_url());

			                            		%>
      
	      <li><a href="<%=url %>" target="_blank"><img src="<%=imgurl %>" width="451" height="230" broder="0"></a></li>
    <%}} %>
      </ul></div></td>
	  <td background="http://images.d1.com.cn/zt2012/20120305nszc/zntj_14.jpg">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="6">
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/zntj_18.jpg" width="980" height="58" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/分隔符.gif" width="20" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/分隔符.gif" width="593" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/分隔符.gif" width="173" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/分隔符.gif" width="37" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/分隔符.gif" width="136" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120305nszc/分隔符.gif" width="21" height="1" alt=""></td>
	</tr>
</table>
<map name="link" id="link"><area shape="rect" coords="388,2,505,24" href="/jifen/index.jsp" target="_blank" />
<area shape="rect" coords="510,3,620,27" href="znwin.jsp" target="_blank" /></map>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>