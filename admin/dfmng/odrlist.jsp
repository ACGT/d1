<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkdfmng.jsp"%>
<%!/**
 * 对账单--odrmst
 */
public static ArrayList<OrderMain> getOrderMainList(HttpServletRequest request,HttpServletResponse response,String shopCode){
	ArrayList<OrderMain> list=new ArrayList<OrderMain>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	   String req_rname= request.getParameter("req_rname");
	   String req_odrid= request.getParameter("req_odrid");
	   String req_goodsodrid= request.getParameter("req_goodsodrid");
	   String orderdate_s= request.getParameter("orderdate_s");
	   String orderdate_e= request.getParameter("orderdate_e");
	   String req_odrstatus= request.getParameter("req_odrstatus");
	   String req_orddate = request.getParameter("req_orddate");
	   if(!Tools.isNull(req_odrid)){
		   listRes.add(Restrictions.eq("id", req_odrid));
	   }
	   if(!Tools.isNull(req_goodsodrid)){
		   listRes.add(Restrictions.eq("odrmst_goodsodrid", req_goodsodrid));
	   }
	   if(!Tools.isNull(req_rname)){
		   listRes.add(Restrictions.eq("odrmst_rname", req_rname));
	   }	   
	   //System.out.println(req_odrstatus);
	   if(!Tools.isNull(req_odrstatus)){
		   if(Tools.parseInt(req_odrstatus)==1){
			   listRes.add(Restrictions.eq("odrmst_orderstatus", new Long(0)));
		   }else if(Tools.parseInt(req_odrstatus)==2){   
			   listRes.add(Restrictions.ge("odrmst_orderstatus", new Long(1)));
			   listRes.add(Restrictions.le("odrmst_orderstatus",new Long(2)));
		   }else if(Tools.parseInt(req_odrstatus)==3){
			   listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(3)));
			   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(31)));
			   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(61)));
			   //listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(5)));
			   //listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(6)));
		   }else if(Tools.parseInt(req_odrstatus)==4){
			   listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(5)));
			   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(61)));
			   listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(31)));
		   }else if(Tools.parseInt(req_odrstatus)==5){
			   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
		   }else if(Tools.parseInt(req_odrstatus)==6){
			   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
		   }else if(Tools.parseInt(req_odrstatus)==7){
			   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
		   }
	   }

	   if((!Tools.isNull(orderdate_s)||!Tools.isNull(orderdate_e))){
			   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
         Date s=null;
         Date e=null;
		   if(orderdate_s.length()>0&&orderdate_e.length()<=0){
		   	try{
		   		 s=format.parse(orderdate_s+" 00:00:00");
		   	  
		   	}catch(Exception ex){
		   		
		   	}
		   }
		   else if(orderdate_s.length()<=0&&orderdate_e.length()>0){
		   	try{
		   		
		   	     e=format.parse(orderdate_e+" 00:00:00");
		   	}catch(Exception ex){
		   		
		   	}
		   }
		   else if(orderdate_s.length()>0&&orderdate_e.length()>0){
		   	try{
		   	     e=format.parse(orderdate_e+" 00:00:00");
		   	     s=format.parse(orderdate_s+" 00:00:00");
		   	}catch(Exception ex){
		   		//System.out.print(ex);
		   	}
		   }
		   //if(datetype.equals("req_orderdate")){
		   if("1".equals(req_orddate)) {
				//System.out.print(e);
			   if(!Tools.isNull(orderdate_s)){
				    listRes.add(Restrictions.ge("odrmst_orderdate", s));
			   }
			   if(!Tools.isNull(orderdate_e)){
				   
				    listRes.add(Restrictions.le("odrmst_orderdate", e));
			   }			   
		   }else if("2".equals(req_orddate)) {
			   if(!Tools.isNull(orderdate_s)){
				    listRes.add(Restrictions.ge("odrmst_shipdate", s));
			   }
			   if(!Tools.isNull(orderdate_e)){
				    listRes.add(Restrictions.le("odrmst_shipdate", e));
			   }
		   }

	
	   }else{
		   if(Tools.isNull(req_odrid)&&Tools.isNull(req_goodsodrid)&&Tools.isNull(req_rname)){
		   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		   try{
			   Date sDate=null;
			   if(Tools.parseInt(req_odrstatus)==2){
			    sDate=Tools.addDate(new Date(), -20);
			   }else{
				 sDate=Tools.addDate(new Date(), -7); 
			   }
		  
		  //System.out.println(format.format(sDate));
			   if("2".equals(req_orddate)) {
				   listRes.add(Restrictions.ge("odrmst_shipdate", sDate ));
			   }else {
				   listRes.add(Restrictions.ge("odrmst_orderdate", sDate ));
			   }

		   }catch(Exception ex){
			   ex.printStackTrace();
		   }
		   }
	   }

	   if(!Tools.isNull(shopCode)){
		   listRes.add(Restrictions.eq("odrmst_sndshopcode", shopCode));
	   }


    List<Order> olist=new ArrayList<Order>();
    olist.add(Order.desc("odrmst_orderdate"));
	List<BaseEntity> list2 = Tools.getManager(OrderMain.class).getList(listRes, olist, 0, 3000);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((OrderMain)be);
	}
	return list;
}	
/**
	 * 对账单--odrmst_recent
	 */
	public static ArrayList<OrderRecent> getOrderRecentList(HttpServletRequest request,HttpServletResponse response,String shopCode){
		ArrayList<OrderRecent> list=new ArrayList<OrderRecent>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		String req_rname= request.getParameter("req_rname");
		   String req_odrid= request.getParameter("req_odrid");
		   String req_goodsodrid= request.getParameter("req_goodsodrid");
		   String orderdate_s= request.getParameter("orderdate_s");
		   String orderdate_e= request.getParameter("orderdate_e");
		   String req_odrstatus= request.getParameter("req_odrstatus");
		   String req_orddate = request.getParameter("req_orddate");
		   if(!Tools.isNull(req_odrid)){
			   listRes.add(Restrictions.eq("id", req_odrid));
		   }
		   if(!Tools.isNull(req_goodsodrid)){
			   listRes.add(Restrictions.eq("odrmst_goodsodrid", req_goodsodrid));
		   }
		   if(!Tools.isNull(req_rname)){
			   listRes.add(Restrictions.eq("odrmst_rname", req_rname));
		   }	   
		   //System.out.println(req_odrstatus);
		   if(!Tools.isNull(req_odrstatus)){
			   if(Tools.parseInt(req_odrstatus)==1){
				   listRes.add(Restrictions.eq("odrmst_orderstatus", new Long(0)));
			   }else if(Tools.parseInt(req_odrstatus)==2){   
				   listRes.add(Restrictions.ge("odrmst_orderstatus", new Long(1)));
				   listRes.add(Restrictions.le("odrmst_orderstatus",new Long(2)));
			   }else if(Tools.parseInt(req_odrstatus)==3){
				   listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(3)));
				   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(31)));
				   //listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(5)));
				   //listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(6)));
			   }else if(Tools.parseInt(req_odrstatus)==4){
				   listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(5)));
				   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(61)));
				   listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(31)));
			   }else if(Tools.parseInt(req_odrstatus)==5){
				   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
			   }else if(Tools.parseInt(req_odrstatus)==6){
				   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
			   }else if(Tools.parseInt(req_odrstatus)==7){
				   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
			   }
			   
			
		   }

		   if((!Tools.isNull(orderdate_s)||!Tools.isNull(orderdate_e))){
				   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	         Date s=null;
	         Date e=null;
			   if(orderdate_s.length()>0&&orderdate_e.length()<=0){
			   	try{
			   		 s=format.parse(orderdate_s+" 00:00:00");
			   	  
			   	}catch(Exception ex){
			   		
			   	}
			   }
			   else if(orderdate_s.length()<=0&&orderdate_e.length()>0){
			   	try{
			   		
			   	     e=format.parse(orderdate_e+" 00:00:00");
			   	}catch(Exception ex){
			   		
			   	}
			   }
			   else if(orderdate_s.length()>0&&orderdate_e.length()>0){
			   	try{
			   	     e=format.parse(orderdate_e+" 00:00:00");
			   	     s=format.parse(orderdate_s+" 00:00:00");
			   	}catch(Exception ex){
			   		//System.out.print(ex);
			   	}
			   }
			   //if(datetype.equals("req_orderdate")){
			   if("1".equals(req_orddate)) {
					//System.out.print(e);
				   if(!Tools.isNull(orderdate_s)){
					    listRes.add(Restrictions.ge("odrmst_orderdate", s));
				   }
				   if(!Tools.isNull(orderdate_e)){
					   
					    listRes.add(Restrictions.le("odrmst_orderdate", e));
				   }			   
			   }else if("2".equals(req_orddate)) {
				   if(!Tools.isNull(orderdate_s)){
					    listRes.add(Restrictions.ge("odrmst_shipdate", s));
				   }
				   if(!Tools.isNull(orderdate_e)){
					    listRes.add(Restrictions.le("odrmst_shipdate", e));
				   }
			   }

		
		   }else{
			   if(Tools.isNull(req_odrid)&&Tools.isNull(req_goodsodrid)&&Tools.isNull(req_rname)){
			   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			   try{
				   Date sDate=null;
				   if(Tools.parseInt(req_odrstatus)==2){
				    sDate=Tools.addDate(new Date(), -20);
				   }else{
					 sDate=Tools.addDate(new Date(), -7); 
				   }
			  
			  //System.out.println(format.format(sDate));
				   if("2".equals(req_orddate)) {
					   listRes.add(Restrictions.ge("odrmst_shipdate", sDate ));
				   }else {
					   listRes.add(Restrictions.ge("odrmst_orderdate", sDate ));
				   }

			   }catch(Exception ex){
				   ex.printStackTrace();
			   }
			   }
		   }

		   if(!Tools.isNull(shopCode)){
			   listRes.add(Restrictions.eq("odrmst_sndshopcode", shopCode));
		   }


	    List<Order> olist=new ArrayList<Order>();
	    olist.add(Order.desc("odrmst_orderdate"));
		List<BaseEntity> list2 = Tools.getManager(OrderRecent.class).getList(listRes, olist, 0, 3000);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((OrderRecent)be);
		}
		return list;
	}
	

	
	public static ArrayList<OrderBase> getOrderList(HttpServletRequest request,HttpServletResponse response,String shopCode){
		ArrayList<OrderBase> list=new ArrayList<OrderBase>();
		 String req_rname= request.getParameter("req_rname");
		   String req_odrid= request.getParameter("req_odrid");
		   String req_goodsodrid= request.getParameter("req_goodsodrid");
		   String orderdate_s= request.getParameter("orderdate_s");
		   String orderdate_e= request.getParameter("orderdate_e");
		   String req_odrstatus= request.getParameter("req_odrstatus");
		/*ArrayList<OrderCache> listcache=getOrderCacheList(request,response,shopCode);
		if(listcache!=null){
			for(OrderCache ordercache:listcache){
				list.add(ordercache);
			}
		}*/
		ArrayList<OrderMain> listmain=getOrderMainList( request,response,shopCode);
		if(listmain!=null){
			for(OrderMain ordermain:listmain){
				list.add(ordermain);
			}
		}
		if(Tools.isNull(req_odrstatus)||(!Tools.isNull(req_odrstatus)&&Tools.parseInt(req_odrstatus)>=3)){
		ArrayList<OrderRecent> listrecent=getOrderRecentList( request, response,shopCode);
		if(listrecent!=null){
			for(OrderRecent orderrecent:listrecent){
				list.add(orderrecent);
			}
		}
		}
		if(list==null || list.size()==0){
			return null;
		}
		return list;
	}
	public static  ArrayList<OrderItemBase> getOrderDetail(String odrid){
		ArrayList<OrderItemBase> list=new ArrayList<OrderItemBase>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrdtl_odrid", odrid));

		List<BaseEntity> list2 = Tools.getManager(OrderItemCache.class).getList(listRes, null, 0, 20);
		if(list2==null || list2.size()==0){
		 list2 = Tools.getManager(OrderItemMain.class).getList(listRes, null, 0, 20);
		 if(list2==null || list2.size()==0){
				list2 = Tools.getManager(OrderItemRecent.class).getList(listRes, null, 0, 20);
			}
		}
		
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((OrderItemBase)be);
		}
		return list;
	}

	public static boolean odrLimit(Date limitDay) {
		Calendar calendar = Calendar.getInstance();
	    int day = calendar.get(Calendar.DAY_OF_YEAR);
	    calendar.set(Calendar.DAY_OF_YEAR, day - 7);
	    
		return calendar.getTime().before(limitDay);
	}
%><%
/*
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "sg_admin");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/DatePicker/WdatePicker.js")%>"></script>
<script type="text/javascript" src="/res/js/manage/manage.js"></script>
<link href="/admin/odradmin/images/odrlist.css" rel="stylesheet" type="text/css"  />
<title>闪购列表</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;

}
td{	font-size: 12px;}
.STYLE1 {font-size: 12px}
.STYLE3 {font-size: 12px; font-weight: bold; }
.STYLE4 {
	color: #03515d;
	font-size: 12px;
}
.GPager{overflow:hidden;_zoom:1;color: #4B4B4B;text-align:center;}
.GPager .span{margin-right:30px;}
.GPager .rd{color:#CC0000;}
.GPager a{font-size:12px;text-decoration: none;color: #8B8B8B;line-height: 28px;padding: 3px 8px 3px 8px;border: 1px solid #A4A4A4;background-image: url(http://images.d1.com.cn/images2010/pgbg.gif);margin:0 5px;}
.GPager a:hover{color:#AA2E44;}
.GPager .curr{font-size: 12px;text-decoration: none;color: #8B8B8B;line-height: 28px;padding: 3px 8px 3px 8px;border: 1px solid #A4A4A4;background-color: #CDCDCD;}

-->
</style>
<script>
var  highlightcolor='#c1ebff';
//此处clickcolor只能用win系统颜色代码才能成功,如果用#xxxxxx的代码就不行,还没搞清楚为什么:(
var  clickcolor='#51b2f6';
function  changeto(){
source=event.srcElement;
if  (source.tagName=="TR"||source.tagName=="TABLE")
return;
while(source.tagName!="TD")
source=source.parentElement;
source=source.parentElement;
cs  =  source.children;
//alert(cs.length);
if  (cs[1].style.backgroundColor!=highlightcolor&&source.id!="nc"&&cs[1].style.backgroundColor!=clickcolor)
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor=highlightcolor;
}
}

function  changeback(){
if  (event.fromElement.contains(event.toElement)||source.contains(event.toElement)||source.id=="nc")
return
if  (event.toElement!=source&&cs[1].style.backgroundColor!=clickcolor)
//source.style.backgroundColor=originalcolor
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor="";
}
}


function  clickto(){
source=event.srcElement;
if  (source.tagName=="TR"||source.tagName=="TABLE")
return;
while(source.tagName!="TD")
source=source.parentElement;
source=source.parentElement;
cs  =  source.children;
//alert(cs.length);
if  (cs[1].style.backgroundColor!=clickcolor&&source.id!="nc")
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor=clickcolor;
}
else
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor="";
}
}

function odrpriceup(t,id){
	var price=$(t).val();
    $.ajax({
            type: "POST",
            dataType: "json",
            url: "/admin/ajax/odrupprice.jsp",
            data:{price:price,id:id},
            success: function(json) {
            	$.alert(json.message)
            }

            });
    
}

</script>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30" background="http://images.d1.com.cn/manage/tab_05.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="12" height="30"><img src="http://images.d1.com.cn/manage/tab_03.gif" width="12" height="30" /></td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="46%" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="5%"><div align="center"><img src="http://images.d1.com.cn/manage/tb.gif" width="16" height="16" /></div></td>
                          <td width="95%" class="STYLE1"><span class="STYLE3">你当前的位置</span>：[闪购管理]-[添加新闪购]</td>
              </tr>
            </table></td>
            <td width="54%"><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td width="60"><table width="87%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"></td>
                    <td class="STYLE1"></td>
                  </tr>
                </table></td>
                <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"><div align="center"><img src="http://images.d1.com.cn/manage/22.gif" width="14" height="14" /></div></td>
                    <td class="STYLE1"><div align="center">新增</div></td>
                  </tr>
                </table></td>
                <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"><!--<div align="center"><img src="http://images.d1.com.cn/manage/33.gif" width="14" height="14" /></div>--></td>
                    <td class="STYLE1"><!--<div align="center">修改</div>--></td>
                  </tr>
                </table></td>
                <td width="52"><table width="88%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"></td>
                    <td class="STYLE1"></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table>
          </td>
        <td width="16"><img src="http://images.d1.com.cn/manage/tab_07.gif" width="16" height="30" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="8" background="http://images.d1.com.cn/manage/tab_12.gif">&nbsp;</td>
        <td>
          <form id="form1" name="form1" method="post" action="?act=list">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="90">
            <tr>
            <%  String req_gdsid= request.getParameter("req_gdsid");
	   String req_gdsname= request.getParameter("req_gdsname");
	   String req_sdate= request.getParameter("req_sdate");
	   String req_edate= request.getParameter("req_edate");
	   String req_odrstatus= request.getParameter("req_odrstatus");

	   %>
              <td width="10%">订单号</td>
              <td width="16%"><input type="text" name="req_gdsid" id="req_gdsid" value="<%=!Tools.isNull(req_gdsid)?req_gdsid:""%>" /></td>
              <td width="9%">收货人</td>
              <td width="26%"><input name="req_gdsname" type="text" id="req_gdsname" size="40" value="<%=!Tools.isNull(req_gdsname)?req_gdsname:""%>" /></td>
              <td width="19%">&nbsp;</td>
              <td width="20%">&nbsp;</td>
            </tr>
            <tr>
              <td width="10%">闪购开始时间</td>
              <td width="16%"><input type="text" name="req_sdate" id="req_sdate" value="<%=!Tools.isNull(req_sdate)?req_sdate:"" %>" onclick="WdatePicker();" /></td>
              <td width="9%">结束时间</td>
              <td width="26%"><input name="req_edate" type="text" id="req_edate" size="40" value="<%=!Tools.isNull(req_edate)?req_edate:""  %>" onclick="WdatePicker();" /></td>
              <td width="19%">&nbsp;</td>
              <td width="20%">&nbsp;</td>
            </tr>
            <tr>
              <td>发货状态：</td>
              <td><select name="req_odrstatus" id="req_odrstatus">
               <option value="" selected>全部</option>
                <option value="" <%if("".equals(req_odrstatus)){out.println("selected");} %>>全部</option>
	  <option value="2" <%if(req_odrstatus==null || "2".equals(req_odrstatus)){out.println("selected");} %>>待发货</option>
	  <option value="3" <%if("3".equals(req_odrstatus)){out.println("selected");} %>>已发货</option>
	  <option value="4" <%if("4".equals(req_odrstatus)){out.println("selected");} %>>已妥投</option>
	  <option value="5" <%if("5".equals(req_odrstatus)){out.println("selected");} %>>已取消</option>
              </select></td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td><input type="submit" name="button" id="button" value="查询"  /></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
          </table>
          </form>
        <div id="sglist">
   
 <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="b5d6e6" onmouseover="changeto()"  onmouseout="changeback()">
          <tr>
            <!-- <td width="3%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">
              <input type="checkbox" name="checkbox" value="checkbox" />
            </div></td>-->
            <td width="19%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">商品名称</div></td>
            <td width="11%" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">商品单价</div></td>
            <td width="8%" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">进价</div></td>
            <td width="6%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">数量 </span></div></td>
            <td width="25%" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">发货状态</div></td>
            <td width="31%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF" class="STYLE1"><div align="center">基本操作</div></td>
          </tr>

    
 <%String shopcode=session.getAttribute("dfshopcode").toString();
String act=request.getParameter("act");
   SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
   String ggURL = Tools.addOrUpdateParameter(request,null,null);
   ggURL=ggURL.replace("&button=查询", "");
   ArrayList<OrderBase> list=new ArrayList<OrderBase>();

   if(act!=null&&act.equals("list")){
   list=getOrderList(request,response,shopcode);
   }
      //分页
      int pageno1=1;
      
      if(ggURL != null) 
      	   {
      	     ggURL.replaceAll("pageno1=[0-9]*","");
      	   }
      //翻页
        int totalLength1 = (list != null ?list.size() : 0);
        int PAGE_SIZE = 30;
        int currentPage1 = 1 ;
        String pg1 ="1";
        if(request.getParameter("pageno1")!=null)
        {
        	pg1= request.getParameter("pageno1");
        }
      
        if(StringUtils.isDigits(pg1))currentPage1 = Integer.parseInt(pg1);
        PageBean pBean1 = new PageBean(totalLength1,PAGE_SIZE,currentPage1);
        int end1 = pBean1.getStart()+PAGE_SIZE;
        if(end1 > totalLength1) end1 = totalLength1;
        
      	String pageURL1 = ggURL.replaceAll("pageno1=[^&]*","");
      	if(!pageURL1.endsWith("&")) pageURL1 = pageURL1 + "&";

      if(list!=null&&list.size()>0)
      {
     	 if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
 		   {

 			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
 		   }
     	 String	strname ="";
     	int status=0;
     	int cls=0;
     	int mailflag=0;
     	String gdsid="";
     	String sdate="";
     	String edate="";
     	 int j=0;
     	DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 	      for(int i=(pageno1-1)*30;i<list.size()&&i<pageno1*30;i++)
     	  {
 	    	 OrderBase odr=list.get(i);
 	    	 long odrstatus=odr.getOdrmst_orderstatus().longValue();
 	
 	    	 // User user=UserHelper.getById(odr.getOdrmst_mbrid().toString());
 	    	 //去掉取消的订单
 	    	ArrayList<OrderItemBase> listdetail= getOrderDetail(odr.getId());
 	    	ArrayList<OrderItemBase> listdetail1 = new ArrayList<OrderItemBase>();
 	    	for(int l=0;l<listdetail.size();l++) {
 	    		if(listdetail.get(l).getOdrdtl_shipstatus().longValue()>0) {
 	    			listdetail1.add(listdetail.get(l));
 	    		}
 	    	}
 	    	listdetail = listdetail1;
 	    	
 	    	  if (listdetail!=null&&listdetail.size()>0){

 
      %>      
		   <tr>
		     <td height="24" colspan="6" bgcolor="#FFFFFF">
		       <table width="100%" border="0" cellspacing="0" cellpadding="0">
		         <tr>
		           <td width="19%" class="pdl8">订单编号：<a href="listdetail.jsp?odrid=<%=odr.getId() %>" target="rightdisplay" ><span class="spantxt"><%= odr.getId()%></span></a>&nbsp;&nbsp;<span><br />
		             下单时间：<%=fmt.format(odr.getOdrmst_orderdate())%><br />
		             送货时间：<%=(odr.getOdrmst_shipdate()==null?"":fmt.format(odr.getOdrmst_shipdate())) %></span></td>
		           <td width="11%"><%if ((odrstatus>=1&&odrstatus<=3)||odrstatus==31) {%><a href="printdtl.jsp?odrid=<%=odr.getId() %>" target="_blank"><img src="/admin/odradmin/images/print.jpg" width="26" height="26" border="0"  /></a><%} %></td>
		           <td colspan="3"><%if ((odrstatus>=1&&odrstatus<=2)) {

%><select name="shipname<%=i %>" id="shipname<%=i %>" class="text">
		             <option value="EMS">EMS</option>
		             <option value="宅急送">宅急送</option>
		             <option value="圆通速递">圆通速递</option>
		             <option value="韵达快运">韵达快运</option>
		             <option value="顺丰快递">顺丰快递</option>
		             <option value="申通快递">申通快递</option>
		             <option value="中通快递">中通快递</option>
		             <option value="优速快递">优速快递</option>
		             <option value="天天快递">天天快递</option>
		             <option value="国通快递">国通快递</option>
		             <option value="汇通快递">汇通快递</option>
		             <option value="全峰快递">全峰快递</option>
		             <option value="百世汇通">百世汇通</option>
		             <option value="快捷速递">快捷速递</option>
		             <option value="微特派快递">微特派快递</option>
		             <option value="其它快递">其它快递</option>      </select>快递单号：
		             <input name="shipcode<%=i %>" id="shipcode<%=i %>" type="text" class="text" size="16" />
		             <%}
        if((odrstatus>=3) && !odrLimit(odr.getOdrmst_shipdate())) {
        	out.print(odr.getOdrmst_d1shipmethod()+"--单号："+odr.getOdrmst_goodsodrid());
        }
        
        if(odrstatus==3 && odrLimit(odr.getOdrmst_shipdate())) {
        	String shipname=odr.getOdrmst_d1shipmethod();
       	%>
		             <select name="shipname<%=i %>" id="shipname<%=i %>" class="text">
		               <option value="EMS" <%if (!Tools.isNull(shipname)&&shipname.equals("EMS")){out.print("selected");}%> >EMS</option>
		               <option value="宅急送" <%if (!Tools.isNull(shipname)&&shipname.equals("宅急送")){out.print("selected");}%>>宅急送</option>
		               <option value="圆通速递" <%if (!Tools.isNull(shipname)&&shipname.equals("圆通速递")){out.print("selected");}%>>圆通速递</option>
		               <option value="韵达快运" <%if (!Tools.isNull(shipname)&&shipname.equals("韵达快运")){out.print("selected");}%>>韵达快运</option>
		               <option value="顺丰快递" <%if (!Tools.isNull(shipname)&&shipname.equals("顺丰快递")){out.print("selected");}%>>顺丰快递</option>
		               <option value="申通快递" <%if (!Tools.isNull(shipname)&&shipname.equals("申通快递")){out.print("selected");}%>>申通快递</option>
		               <option value="中通快递" <%if (!Tools.isNull(shipname)&&shipname.equals("中通快递")){out.print("selected");}%>>中通快递</option>
		               <option value="优速快递" <%if (!Tools.isNull(shipname)&&shipname.equals("优速快递")){out.print("selected");}%>>优速快递</option>
		               <option value="天天快递" <%if (!Tools.isNull(shipname)&&shipname.equals("天天快递")){out.print("selected");}%>>天天快递</option>
		               <option value="国通快递" <%if (!Tools.isNull(shipname)&&shipname.equals("国通快递")){out.print("selected");}%>>国通快递</option>
		               <option value="汇通快递" <%if (!Tools.isNull(shipname)&&shipname.equals("汇通快递")){out.print("selected");}%>>汇通快递</option>
		               <option value="全峰快递" <%if (!Tools.isNull(shipname)&&shipname.equals("全峰快递")){out.print("selected");}%>>全峰快递</option>
		               <option value="百世汇通" <%if (!Tools.isNull(shipname)&&shipname.equals("百世汇通")){out.print("selected");}%>>百世汇通</option>
		               <option value="快捷速递" <%if (!Tools.isNull(shipname)&&shipname.equals("快捷速递")){out.print("selected");}%>>快捷速递</option>
		               <option value="微特派快递" <%if (!Tools.isNull(shipname)&&shipname.equals("微特派快递")){out.print("selected");}%>>微特派快递</option>
		               <option value="其它快递" <%if (!Tools.isNull(shipname)&&shipname.equals("其它快递")){out.print("selected");}%>>其它快递</option>
		               
		               </select>快递单号：
		             <input name="shipcode<%=i %>" id="shipcode<%=i %>" type="text" class="text" size="16" value="<%=odr.getOdrmst_goodsodrid()%>"/>      	
		             <%
        }
        %></td>
		           <td width="30%"> <%String paystatus="未到款";
        
        if(odr.getOdrmst_payid()!=null&&odr.getOdrmst_payid().longValue()>0&&odr.getOdrmst_payid().longValue()!=44){
        	if(odrstatus==0){
        		paystatus="未到款";
        	}else if(odrstatus==1||odrstatus==2){
        		paystatus="已收款";
        	}
        }else{
        	if(odrstatus==0){
        		paystatus="未确认";
        	}else if(odrstatus==1){
        		paystatus="已确认";
        	}
        }
        if(odrstatus<0&&odrstatus!=-2){
        	paystatus="用户取消";
        }else if(odrstatus==-2){
        	paystatus="缺货取消";
        }else if(odrstatus==3){
        	paystatus="订单全发";
        }else if(odrstatus==31){
        	paystatus="部分发货";
        }else if(odrstatus==5 || odrstatus==51 || odrstatus==6 || odrstatus==61){
        	paystatus="交易完成";
        }
        if(odrstatus==1|| odrstatus==2){
        %>
		             <input type="button" name="imageField2"  value="发货" onclick="sendForm(this,'<%=odr.getId() %>',<%=i %>);"  />
		             <%}
        if(odrstatus==3 && odrLimit(odr.getOdrmst_shipdate())){
        %>
		             <input type="button" name="imageField2" value="修改" onclick="saveShipCode(this,'<%=odr.getId() %>',<%=i %>);"  />
		             <%}
out.print(paystatus);  %></td>
		           </tr>
		           <%for(OrderItemBase itembase:listdetail){
			 long dtlstatus=itembase.getOdrdtl_shipstatus().longValue();
			 float gdsprice=itembase.getOdrdtl_finalprice().floatValue();
			 float inprice=itembase.getOdrdtl_purprice().floatValue();
			 String gdsname=itembase.getOdrdtl_gdsname();
			 long gdscount=itembase.getOdrdtl_gdscount();
			 %>
		         <tr>
		           <td height=30><%=gdsname %></td>
		           <td><%=gdsprice %></td>
		           <td width="8%">
		            <input type="text" name="req_price" id="req_price" style="width:50px"  value="<%=inprice %>" onblur="odrpriceup(this,'<%=itembase.getId() %>')" />
		           </td>
		           <td width="6%"><%=gdscount %></td>
		           <td width="26%"><%String statustxt="";

if(dtlstatus==1&&inprice>=0){
	statustxt="未发货";
}else if(dtlstatus==-1||(inprice<0&&dtlstatus==1)){
	statustxt="商家取消";
}else if(dtlstatus==-2||inprice<0){
	statustxt="用户取消";
}else if(dtlstatus==-3||inprice<0){
	statustxt="退货";
}else if(dtlstatus==-4||inprice<0){
	statustxt="换货";
}else if(dtlstatus==2||dtlstatus==3){
	statustxt="已发货";
}
out.print(statustxt);
%></td>
		           <td>&nbsp;</td>
		           </tr>
		              <%} %>
		         </table>
		       
		       </td>
		     </tr>
		   <%j=j++;
      }
     	  }}
%>
  </table>	
           	  <!-- 分页 -->
           	   <%
					           if(pBean1.getTotalPages()>=1){
					           %>
           	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
           <tr>
                    <td class="STYLE1" height="32"></td>
                    <td class="STYLE1"></td>
    
          </tr>
          <tr>
            <td class="STYLE4" height="28">&nbsp;&nbsp;共有 <%=totalLength1 %> 条记录，当前第 <%=pBean1.getCurrentPage() %>/<%=pBean1.getTotalPages() %> 页</td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
                <tr>
                  <td colspan="4" >
                 
 <span class="GPager" style="margin:0px auto; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean1.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean1.getCurrentPage() %></font>页</span>
					           	&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=1">首页</a><%if(pBean1.hasPreviousPage()){%>&nbsp;&nbsp;<a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
					           	for(int i=pBean1.getStartPage();i<=pBean1.getEndPage()&&i<=pBean1.getTotalPages();i++){
					           		if(i==currentPage1){
					           		%>&nbsp;&nbsp;<span class="curr"><%=i %></span><%
					           		}else{
					           		%>&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=<%=i %>"><%=i %></a><%
					           		}
					           	}%>
					           	<%if(pBean1.hasNextPage()){%>&nbsp;&nbsp;<a href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下一页</a><%}%>
					           	&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>	
			           	  </span>
</td>
                 
                  <td width="40"></td>
                </tr>
            </table></td>
          </tr>
        </table>
           	  <%}
       
           	  %>

        
        </div>
        </td>
        <td width="8" background="http://images.d1.com.cn/manage/tab_15.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="35" background="http://images.d1.com.cn/manage/tab_19.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="12" height="35"><img src="http://images.d1.com.cn/manage/tab_18.gif" width="12" height="35" /></td>
        <td>&nbsp;</td>
        <td width="16"><img src="http://images.d1.com.cn/manage/tab_20.gif" width="19" height="35" /></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
