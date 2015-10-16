<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static ArrayList<AYPrize> getprizelist(){
	ArrayList<AYPrize> list=new ArrayList<AYPrize>();
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("prize_createdate"));
	List<BaseEntity> list2 = Tools.getManager(AYPrize.class).getList(null, listOrder, 0, 100);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((AYPrize)be);
	}
	return list; 
}
//获取今日参加活动的人数
int getTotalPrize(){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	String s=Tools.getDate(new Date())+" 00:00:00";
	String e=Tools.getDate(new Date())+" 23:59:59";
	 SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
     SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd");
     try {
    	 Date starttime=df2.parse(s); 
	     Date endtime=df2.parse(e);
	     listRes.add(Restrictions.ge("answer_createdate", starttime));
	     listRes.add(Restrictions.le("answer_createdate", endtime));

     } catch (ParseException ex) {
    	   ex.printStackTrace();
     }
	
	return Tools.getManager(AYAnswer.class).getLength(listRes);
}

//获取今日问题
static ArrayList<AYQuestion> getTodayQuestion(){
	SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd");
	String ndate="";
	Date dndate=null;
	try{
	  ndate=fmt.format(new Date());
	  dndate=fmt.parse(ndate);
}
catch(Exception ex){
	ex.printStackTrace();
}
	ArrayList<AYQuestion> list=new ArrayList<AYQuestion>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("questionFlag", new Long(1)));
	listRes.add(Restrictions.eq("qviewTime", dndate));
	List<BaseEntity> list2 = Tools.getManager(AYQuestion.class).getList(listRes, null, 0, 5);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		AYQuestion q=(AYQuestion)be;
		String s=Tools.getDate(new Date());
		String e=Tools.getDate(q.getQviewTime());
		if(s.equals(e)){
			list.add(q);
		}
		
	}
	return list; 
}
//获取今日所有参加竞猜的信息
ArrayList<AYAnswer> getTotalAnswer(){
	ArrayList<AYAnswer> list=new ArrayList<AYAnswer>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	//String s=Tools.getDate(new Date())+" 00:00:00";
	//String e=Tools.getDate(new Date())+" 23:59:59";
	// SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    // SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd");
    // try {
    	// Date starttime=df2.parse(s); 
	    // Date endtime=df2.parse(e);
	    // listRes.add(Restrictions.ge("answer_createdate", starttime));
	     //listRes.add(Restrictions.le("answer_createdate", endtime));

     //} catch (ParseException ex) {
    //	   ex.printStackTrace();
    // }
     List<Order> listOrder = new ArrayList<Order>();
 	listOrder.add(Order.desc("answer_createdate"));
 	List<BaseEntity> list2 = Tools.getManager(AYAnswer.class).getList(listRes, listOrder, 0, 100);
 	if(list2==null || list2.size()==0){
 		return null;
 	}
 	for(BaseEntity be:list2){
 		list.add((AYAnswer)be);
 	}
	return list;
}
%>
  <%
  String str="我在 @D1优尚官网 参加了【喝彩奥运，千万礼券免费领】活动，这个活动超给力，不转太不够朋友了！每天都有5个免单机会，10件免费奥运款T恤（不购物也能抽），活动期间还有千万礼券限量领取，你也来试试运气吧，咱们一起为中国奥运健儿加油，别忘了也把这好事转给你的朋友啊！";
  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚奥运活动</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css"  />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
	function AutoScroll(obj){
		$(obj).find("ul:first").animate({
		marginTop:"-46px"
		},200,function(){
		$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
		});
		}
	$(document).ready(function(){
	setInterval('AutoScroll("#scrollDiv1")',5000);
	setInterval('AutoScroll("#scrollDiv2")',3000)
	});
	
	function gettkt(){
		$.ajax({
			type: "POST",
			dataType: "json",
			url: "/ajax/flow/getaytkt.jsp",
			success: function(json) {
				$.alert(json.message);
			}
			
			});
	}
	
	function AddAnswer(){
		var answer=$.trim($("#txtanswer").val());
		if(answer.length==0){
			$.alert("请填写答案！");
		}else{
			
		$.ajax({
			type: "POST",
			data:"answercontent="+answer, 
			dataType: "json",
			url: "/ajax/flow/ayanwser.jsp",
			success: function(json) {
				$.alert(json.message);
			}
			
			});
		}
	}
	
	 function postToWb(){
     	// alert(j);
          var _t = encodeURI(document.title);
          _t=encodeURI('<%=str%>'.replace("@D1优尚官网","@D1优尚网"));
          var _url = encodeURIComponent('http://www.d1.com.cn/html/zt2012/20120727ay/index.jsp');
          var _appkey = encodeURI("7d55b7e157054243b4a6bd7a826cbc40");//你从腾讯获得的appkey
          var _pic ='';//（例如：var _pic='图片url1|图片url2|图片url3....）
          var _site = 'http://www.d1.com.cn/html/zt2012/20120727ay/index.jsp';//你的网站地址
          var _u = 'http://v.t.qq.com/share/share.php?url='+_url+'&appkey='+_appkey+'&site='+_site+'&pic='+_pic+'&title='+_t;
          window.open( _u,'', 'width=700, height=680, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, location=yes, resizable=no, status=no' );
      }
	 function postqqzone(){
        
       var  url='http://www.d1.com.cn/html/zt2012/20120727ay/index.jsp';
       var  desc='<%=str%>';/*默认分享理由(可选)*/
       var  summary='<%=str%>';/*摘要(可选)*/
        var title='<%=str%>';/*分享标题(可选)*/
        var site= 'http://www.d1.com.cn/html/zt2012/20120727ay/index.jsp'; /*分享来源 如：腾讯网(可选)*/
        var pics=''; /*分享图片的路径(可选)*/
        var _u='http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url='+url+'&desc='+desc+'&summary='+summary+'&title='+title+'&site='+site+'&pics='+pics;
	  window.open( _u,'', 'width=700, height=680, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, location=yes, resizable=no, status=no' );
         }
</script>
<style type="text/css">
<!--
.askay {
	font-size: 18px;
	color: #373737;
	font-weight: 800;
}
.STYLE1 {color: #373737}
.txtlin {
	border: 1px solid #DDDDDD;
}
 ul,li{margin:0;padding:0}
.scrollDiv{width:400px;height:28px;line-height:18px;overflow:hidden;padding-top:4px;}
.scrollDiv li{height:28px;padding-left:4px;color:#525252;text-align:left;}
ul,li{ list-style:none;}
.scrollDiv2{width:900px;height:200px;line-height:18px;overflow:hidden;padding-top:4px; padding-left:30px;}
.scrollDiv2 li{height:28px;padding-left:4px;color:#525252;text-align:left;}
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@include file="/inc/head.jsp" %>

  <center>

<!-- ImageReady Slices (奥运活动2.tif) -->
<%  ArrayList<AYQuestion> qlist= getTodayQuestion(); %>
<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_01.jpg" width="980" height="138" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_02.jpg" width="980" height="121" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_03.jpg" width="980" height="184" alt=""></td>
	</tr>
	<tr>
		<td style="font-size:0px;">
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_04.jpg" width="183" height="54" alt="" border="0"></td>
		<td style="font-size:0px;">
		<%if (qlist!=null) {
			AYQuestion qtime=qlist.get(0);
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			String ndate=fmt.format(new Date());
			SimpleDateFormat fmttime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			ndate=ndate+" "+qtime.getQuestiontktend();
			Date endtkttime=fmttime.parse(ndate);
		
		if(Tools.dateValue(endtkttime)<System.currentTimeMillis()){
		%>
		<img src="http://images.d1.com.cn/zt2012/20120727oy/images/aywin_05_2.jpg" width="214" height="54" alt="" border="0" />
		<%}else{ %>
		<a href="javascript:gettkt();">	<img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_05.jpg" width="214" height="54" alt="" border="0" /></a>
		<%}
		}else{
		%>
		<img src="http://images.d1.com.cn/zt2012/20120727oy/images/aywin_05_2.jpg" width="214" height="54" alt="" border="0" />
		<%} %>
		 </td>
		<td colspan="2" style="font-size:0px;">
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_06.jpg" width="583" height="54" alt="" border="0"></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_07.jpg" width="980" height="81" alt=""></td>
	</tr>
	<tr>
		<td colspan="3" background="http://images.d1.com.cn/zt2012/20120727oy/images/oly_08.jpg"><table width="97%" height="62" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="33%" height="15">&nbsp;</td>
            <td width="67%">&nbsp;</td>
          </tr>
          <tr>
            <td height="32">&nbsp;</td>
            <td>
            <%
            SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            java.util.Date   nowszf=new   java.util.Date();   
            java.util.Date   dates=df2.parse("2012-07-27 16:32:00");
            int pcount=(int)(nowszf.getTime()/1000/60-dates.getTime()/1000/60)*7;
            pcount+=getTotalPrize()*11;
	ArrayList<AYPrize> list=getprizelist();
	if(list!=null && list.size()>0){
		%>
		<div id="scrollDiv1" class="scrollDiv">
      <ul>
	<%

	for(AYPrize prize:list){
		String uid=prize.getPrize_muid();
		if(StringUtils.getCnLength(uid)>=3){
			uid= "***"+StringUtils.getCnSubstring(uid,3,uid.length());
			if(StringUtils.getCnLength(uid)>=15){
				uid= "***"+StringUtils.getCnSubstring(uid,3,15);
			}
		}else{
			uid="***"+uid;
		}
			%>
			<li>
			<%=uid+":"+prize.getPrize_content() %>
		</li>
	<%
	
	}%>
	</ul>
	</div>
	<%}
	%>
	 </td>
          </tr>
          <tr>
            <td height="15">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
		<td>
		<a href="/html/zt2012/20120727ay/prizeinfo.jsp"	target="_blank"><img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_09.jpg" width="174" height="62" alt=""/></a></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_10.jpg" width="980" height="180" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_11.jpg" width="980" height="59" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" align="left" valign="bottom" style="background:url('http://images.d1.com.cn/zt2012/20120727oy/images/oly_12.jpg') no-repeat; width:980; height:48;" >
			<a name="jc" id="jc"></a>
			<table width="600" height="48">
			<tr><td width="345" height="35">&nbsp;</td> 
			<td valign="bottom" align="left"><span style="font-size:26px;  color:#FFFFFF;">169512<%//=pcount %></span></td></tr>
		  
		  </table>
	  </td>
	</tr>
	<tr>
		<td height="158" colspan="4" background="http://images.d1.com.cn/zt2012/20120727oy/images/oly_13_1.jpg"><table width="100%" height="158" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="10%">&nbsp;</td>
            <td height="40" colspan="2"><div align="center" class="askay">
            <%
          
            if(qlist!=null && qlist.size()>0){
            	AYQuestion q=qlist.get(0);
            	out.print(q.getQuestionTitle());
            }else{
            %>
           <!--  单人跳水冠军将是那个国家？--> 
            <%} %>
            </div></td>
            <td width="8%">&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td width="64%" height="70">
              <textarea id="txtanswer" name="textfield" cols="80" rows="3" class="txtlin"></textarea>            </td>
            <td width="18%"><!-- <input type="image" name="imageField" src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_13_2.jpg" onclick="AddAnswer()"/>--></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td colspan="2"><span class="STYLE1">注：正确答案将以简体中文字为准，例如：中国。拼音及英文不算正确答案，例：zhongguo或china</span></td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_14.jpg" alt="" width="980" height="34" border="0" usemap="#Map2"></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_15.jpg" width="980" height="96" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_16.jpg" alt="" width="980" height="213" border="0" usemap="#Map"></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_17.jpg" width="980" height="109" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" background="http://images.d1.com.cn/zt2012/20120727oy/images/oly_19.jpg">
		<%
		ArrayList<AYAnswer> alist= getTotalAnswer();
		if(alist!=null && alist.size()>0){
			%>
			<div id="scrollDiv2" class="scrollDiv2">
	      <ul>
		<%

			for(AYAnswer a:alist){
				String uid=a.getAnswer_uid();
				if(StringUtils.getCnLength(uid)>=3){
					uid= "***"+StringUtils.getCnSubstring(uid,3,uid.length());
					if(StringUtils.getCnLength(uid)>=15){
						uid= "***"+StringUtils.getCnSubstring(uid,3,15);
					}
				}else{
					uid="***"+uid;
				}
				AYQuestion q=(AYQuestion)Tools.getManager(AYQuestion.class).get(a.getAnswer_qid()+"") ;
				if(q!=null){
				%>
				<li>
				<%=uid+" #喝彩奥运# "+q.getQuestionTitle()+" 竞猜答案为："+a.getAnswer_content()%>
			</li>
		<%
				}
		}%>
		</ul>
		</div>
		<%}
		%>
		
		</td>
	</tr>
	
	
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/oly_21.jpg" width="980" height="60" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/分隔符.gif" width="183" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/分隔符.gif" width="214" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/分隔符.gif" width="409" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/分隔符.gif" width="174" height="1" alt=""></td>
	</tr>
</table>
<!-- End ImageReady Slices -->

<map name="Map"><area shape="rect" coords="70,5,230,209" href="http://www.d1.com.cn/product/03000112" target="_blank">
<area shape="rect" coords="242,4,395,208" href="http://www.d1.com.cn/product/03000109" target="_blank">
<area shape="rect" coords="414,4,568,209" href="http://www.d1.com.cn/product/03000108" target="_blank">
<area shape="rect" coords="586,6,746,210" href="http://www.d1.com.cn/product/03000106" target="_blank">
<area shape="rect" coords="761,7,916,209" href="http://www.d1.com.cn/product/03000114" target="_blank">
</map>
<map name="Map2">
<area shape="rect" coords="128,9,201,30" href="javascript:postqqzone();">
<area shape="rect" coords="206,9,277,31" href="javascript:void((function(s,d,e,r,l,p,t,z,c) {var%20f='http://v.t.sina.com.cn/share/share.php?appkey=2833634960',u=z||d.location,p=['&url=',e(u),'& title=',e(t||d.title),'&source=',e(r),'&sourceUrl=',e(l),'& content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a() {if(!window.open([f,p].join(''),'mb', ['toolbar=0,status=0,resizable=1,width=600,height=500,left=',(s.width- 600)/2,',top=',(s.height-600)/2].join('')))u.href=[f,p].join('');}; if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();}) (screen,document,encodeURIComponent,'','','','<%=str%>','http://www.d1.com.cn/html/zt2012/20120727ay/index.jsp','utf-8'));">
<area shape="rect" coords="283,9,355,31" href="javascript:postToWb();">
<area shape="rect" coords="361,8,425,30" href="javascript:void((function(s,d,e,r,l,p,t,z,c){var f='http://share.renren.com/share/buttonshare?',u=z||d.location,p=['&url=',e(u),'&title=',e(t||d.title),'&content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a(){if(!window.open([f,p].join(''),'xnshare',['toolbar=0,status=0,resizable=1,width=660,height=470,left=',(s.width-660)/2,',top=',(s.height-470)/2].join('')))u.href=[f,p].join('');};if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();})(screen,document,encodeURIComponent,'','','','<%=str%>','http://www.d1.com.cn/html/zt2012/20120727ay/index.jsp','utf-8'))">
<area shape="rect" coords="432,9,511,30" href="javascript:void((function(s,d,e,r,l,p,t,z,c){var f='http://t.sohu.com/third/post.jsp?',u=z||d.location,p=['&url=',e(u),'&title=',e(t||d.title),'&content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a(){if(!window.open([f,p].join(''),'mb',['toolbar=0,status=0,resizable=1,width=660,height=470,left=',(s.width-660)/2,',top=',(s.height-470)/2].join('')))u.href=[f,p].join('');};if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();})(screen,document,encodeURIComponent,'','','','<%=str%>','http://www.d1.com.cn/html/zt2012/20120727ay/index.jsp','utf-8'));">
</map>
</center>
<div class="clear"></div>
   <%@include file="/inc/foot.jsp" %>
</body>
</html>