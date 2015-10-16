<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static ArrayList<SecKill> getTodayProduct(){
	ArrayList<SecKill> list=new ArrayList<SecKill>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.gt("id","171"));
	listRes.add(Restrictions.le("mstjgds_starttime",new Date()));
	listRes.add(Restrictions.ge("mstjgds_endtime", new Date()));
	//listRes.add(Restrictions.eq("mstjgds_state", new Long(1)));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.asc("mstjgds_sort"));
	List<BaseEntity> mxlist= Tools.getManager(SecKill.class).getList(listRes, listOrder, 0, 1);
	if(mxlist==null || mxlist.size()==0) return null;
	for(BaseEntity be:mxlist){
		list.add((SecKill)be);
	}
	 return list;
}
static ArrayList<SecKill> getOtherProduct(){
	ArrayList<SecKill> list=new ArrayList<SecKill>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.ge("mstjgds_starttime", new Date()));
	listRes.add(Restrictions.gt("id","171"));
	//listRes.add(Restrictions.eq("mstjgds_state", new Long(1)));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.asc("mstjgds_starttime"));
	List<BaseEntity> mxlist= Tools.getManager(SecKill.class).getList(listRes, listOrder, 0, 1000);
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
<title>2012 第1秒 1元开秒 秒到就赚到-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="/activities/20111230qcms/style/index.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
var the_s=new Array();
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
    	window.location.reload(true);

    }
}

function $getid(id)
{
    return document.getElementById(id);
}

function view_time(the_s_index,objid){

    if(the_s[the_s_index]>=0){
        var the_D=Math.floor((the_s[the_s_index]/3600)/24)
        var the_H=Math.floor((the_s[the_s_index]-the_D*24*3600)/3600);
       
        var the_M=Math.floor((the_s[the_s_index]-the_D*24*3600-the_H*3600)/60);
        var the_S=(the_s[the_s_index]-the_H*3600)%60;
       var divhtml = "距离开始还有:";
       var d="#d_"+the_s_index;
        var h="#h_"+the_s_index;
        var m="#m_"+the_s_index;
        var s="#s_"+the_s_index;
        $(d).text(the_D);
        $(h).text(the_H);
        $(m).text(the_M);
        $(s).text(the_S);
        
        the_s[the_s_index]--;
    }else{
        $getid(objid).innerHTML = "已结束";

    }
}
var pixli = "sec_";
var show_size = 4.0;
var currentpageList = 1;
var pageListTotal;
$(document).ready(function(){
	pageListTotal = Math.ceil($(".secWill_con ul li").length/show_size);
	$(".secWill_con ul li").each(function(){
		var id = $(this).attr("id");
		id = id.replace(/sec\_/gi,"");
		if(id > show_size){
			$(this).hide();
		}
	});
	if($(".secWill_con ul li").length <= show_size){
		$("#arrow_r").attr("class","next");
	}
	
	$("#arrow_r").click(nextList);
	$("#arrow_l").click(prevList);
	
});

var currStartli,currEndli;
var startli,endli;
function nextList(){
	currStartli = (currentpageList - 1) * show_size + 1;
	currEndli = currentpageList * show_size;
	if(currentpageList >= pageListTotal){
		$("#arrow_r").attr("class","next");
	}
	else{
		currentpageList = currentpageList + 1;
		startli = (currentpageList - 1) * show_size + 1;
		endli = (currentpageList) * show_size;
		if(currEndli >= $(".secWill_con ul li").length){
			currEndli = $(".secWill_con ul li").length;
		}
		
		changeshow();
		
		if(currentpageList >= pageListTotal){
			$("#arrow_r").attr("class","next");
		}
		$("#arrow_l").attr("class","prev_yes");
	}
}

function prevList(){
	currStartli = (currentpageList - 1) * show_size + 1;
	currEndli = currentpageList * show_size;
	if(currentpageList <= 1){
		$("#arrow_l").attr("class","");
	}
	else{
		currentpageList = currentpageList - 1;
		startli = (currentpageList - 1) * show_size + 1;
		endli = (currentpageList) * show_size;
		
		changeshow();
		
		if(currentpageList <= 1){
			$("#arrow_l").attr("class","");
		}
		$("#arrow_r").attr("class","next_yes");
	}
}

function changeshow(){
	$(".secWill_con ul li").each(function(){
		var id = $(this).attr("id");
		id = id.replace(/sec\_/gi,"");
		if(id >= currStartli && id<=currEndli){
			//$(this).animate({width:0},"fast");
			//$(this).hide("fast");
			$(this).hide();
		}else if(id >= startli && id <= endli){
			$(this).animate({width:218},"slow");
		}
	});	
}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<div class="sec w">

			<div class= "head">
			<%
ArrayList<SecKill> list=getTodayProduct();
if(list!=null && list.size()>0){
	for(int i=0; i<list.size();i++){
		SecKill ms=list.get(i);
    	Product product=ProductHelper.getById(ms.getMstjgds_gdsid())  ; 
    	if(product!=null){
    		  java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
              String	nowtime= df.format(new Date());
            String tttime =df.format(ms.getMstjgds_endtime());
    		  %>
    		  
    		
			<img class="flt" src="/activities/20111230qcms/img/ms.gif"/>
           <a href="/product/<%=product.getId() %>" target="_blank"> <img class="hotware" src="<%=ProductHelper.getImageTo400(product) %>"/></a>
             <span class="shoting">
             <div class="title">秒杀进行中：<a href="/product/<%=product.getId() %>" target="_blank"><em><%=Tools.clearHTML(ms.getMstjgds_memo()) %></em></a></div>
             </span>

            	<span class="shoting_pro">请抓紧时间购买，据结束时间还有：</span>
                <span class="hours" id="h">0</span>
                <span class="mins" id="m">00</span>
                <span class="secs" id="s">00</span>
                <span class="shot_num">限量：<em><%=ms.getMstjgds_maxcount().intValue()*10 %></em>件</span>
                <span class="normal_price">市场价：￥<%=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice()) %>  　原价：￥<%=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice()) %></span>
                <span class="shot_price">秒杀价：￥<%=ProductGroupHelper.getRoundPrice(ms.getMstjgds_tjprice()) %> </span>
                       <%
 if(ms.getMstjgds_count().intValue()>=ms.getMstjgds_maxcount() || (ms.getMstjgds_state().intValue()!=1 && ms.getMstjgds_state().intValue()!=0)){
	 %>
	<img class="shot_pic" src="/activities/20111230qcms/img/qinag2.jpg"/>
 <%}else{ %>
  <a href="/product/<%=product.getId() %>" target="_blank">
	  <img class="shot_pic" src="/activities/20111230qcms/img/qiang1.jpg"/></a>
  <%}
%>
               
        <script language=javascript>
		var startDate= new Date("<%=nowtime%>");var endDate= new Date("<%=tttime%>");
		 lasttime=(endDate.getTime()-startDate.getTime())/1000;
		//alert(lasttime);
		setInterval(view_time2,1000);</script>
			  <%}}} %>
			</div>
			 <img class="shot_title" src="http://images.d1.com.cn/zt2011/20111230qcxn/qcms_05.jpg"/>
            <div class="sec_box secwill">
                <!--<h3><span>秒杀预告<em>--><!-- Notice --><!--</em></span></h3>-->
                <div class="scroll_box">
                    <span class="" id="arrow_l">&nbsp;</span>
                    <div class="secWill_con">
                        <ul style="left: 0px;" id="sec_list">
                             <%
ArrayList<SecKill> list2=getOtherProduct();
if(list2!=null && list2.size()>0){
	//System.out.print(list2.size());
	for(int i=0;i<list2.size();i++){
		SecKill skill=list2.get(i);
		Product product=ProductHelper.getById(skill.getMstjgds_gdsid());
		SimpleDateFormat sdf2 = new SimpleDateFormat("MM月dd日 HH:mm:ss");
		  java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
          String	nowtime= df.format(new Date());
        String tttime =df.format(skill.getMstjgds_starttime());
        %>
          <li id="sec_<%=i+1 %>" >

                        <h5>开始时间：<%=sdf2.format(skill.getMstjgds_starttime()) %></h5>

                          <a href="/product/<%=product.getId() %>" target="_blank" ><img src="http://images.d1.com.cn<%=product.getGdsmst_imgurl() %>" width="190" height="190" /></a>

                        <p class="text_link"><a href="/product/<%=product.getId() %>" target="_blank"> <%=Tools.clearHTML(product.getGdsmst_gdsname()) %></a></p>
						<p>市场价：￥<%=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice()) %>   原会员价：￥<%=ProductGroupHelper.getRoundPrice(product.getGdsmst_memberprice()) %></p>
                        <p class="sec_price"><b>秒杀价：￥<%=ProductGroupHelper.getRoundPrice(skill.getMstjgds_tjprice()) %>  限量：<%=skill.getMstjgds_maxcount().intValue()*10 %>件</b></p>

                        <div class="ks_time">距离开始还有:<b id="d_<%=i+1%>">0</b>天<b id="h_<%=i+1%>">00</b>时<b id="m_<%=i+1%>">00</b>分<b id="s_<%=i+1%>">00</b>秒 <span class="tmhvtr" id=tjjs_<%=i%>></span></div>
  <script language=javascript>
  //alert(11111);
var startDate= new Date("<%=nowtime%>");var endDate= new Date("<%=tttime%>");the_s[<%=i+1%>]=(endDate.getTime()-startDate.getTime())/1000;
setInterval("view_time(<%=i+1%>,'tjjs_<%=i+1%>')",1000);</script>
                    </li>
	  <%}
}
%>
                        </ul>
                    </div>
                    <span id="arrow_r" class="next next_yes">&nbsp;</span>
                </div>
            </div>
			<div>
			<img src="http://images.d1.com.cn/zt2011/20111230qcxn/qcms_10.jpg" width="980" height="83" alt=""/>
			<% request.setAttribute("code","7310");
		request.setAttribute("length","50");%>
		<jsp:include   page= "/html/zt2011/20111104hzp/gdsrcm0305.jsp"   />
			</div>
		</div>
</center>
<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>