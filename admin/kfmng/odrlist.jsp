<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkkfmng.jsp"%>
<%!/**
 * 对账单--odrmst
 */
public static ArrayList<OrderMain> getOrderMainList(HttpServletRequest request,HttpServletResponse response){
	ArrayList<OrderMain> list=new ArrayList<OrderMain>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	 String tmorderid= request.getParameter("tmorderid");
	   String req_rname= request.getParameter("req_rname");
	   String req_phone= request.getParameter("req_phone");
	   String req_vdate= request.getParameter("req_vdate");
	   String req_odrstatus= request.getParameter("req_odrstatus");
	   if(Tools.isNull(tmorderid)&&Tools.isNull(req_rname)&&Tools.isNull(req_phone)){
		   return null;
	   }
	   if(!Tools.isNull(tmorderid)){
		   listRes.add(Restrictions.eq("odrmst_pbp", tmorderid));
	   }
	   if(!Tools.isNull(req_rname)){
		   listRes.add(Restrictions.like("odrmst_rname", "%"+req_rname+"%"));
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

	   if(!Tools.isNull(req_vdate)){
			   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
         Date v=null;
		   if(req_vdate.length()>0){
		   	try{
		   		 v=format.parse(req_vdate+" 00:00:00");
		   	  
		   	}catch(Exception ex){
		   		
		   	}
		    listRes.add(Restrictions.ge("odrmst_validdate", v));
		   }

	   }else{
		   if(Tools.isNull(tmorderid)&&Tools.isNull(req_rname)&&Tools.isNull(req_phone)){
		   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		   try{
			   Date sDate=Tools.addDate(new Date(), -60); 
		        listRes.add(Restrictions.ge("odrmst_validdate", sDate ));
			 

		   }catch(Exception ex){
			   ex.printStackTrace();
		   }
		   }
	   }
 
		   listRes.add(Restrictions.eq("odrmst_sndshopcode", "00000000"));
		   listRes.add(Restrictions.eq("odrmst_mbrid", new Long(1544012)));

    List<Order> olist=new ArrayList<Order>();
    olist.add(Order.desc("odrmst_orderdate"));
	List<BaseEntity> list2 = Tools.getManager(OrderMain.class).getList(listRes, olist, 0, 5);
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
	public static ArrayList<OrderRecent> getOrderRecentList(HttpServletRequest request,HttpServletResponse response){
		ArrayList<OrderRecent> list=new ArrayList<OrderRecent>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		String tmorderid= request.getParameter("tmorderid");
		   String req_rname= request.getParameter("req_rname");
		   String req_phone= request.getParameter("req_phone");
		   String req_vdate= request.getParameter("req_vdate");
		   String req_odrstatus= request.getParameter("req_odrstatus");
		   if(Tools.isNull(tmorderid)&&Tools.isNull(req_rname)&&Tools.isNull(req_phone)){
			   return null;
		   }
		   if(!Tools.isNull(tmorderid)){
			   listRes.add(Restrictions.eq("odrmst_pbp", tmorderid));
		   }
		   if(!Tools.isNull(req_rname)){
			   listRes.add(Restrictions.like("odrmst_rname", "%"+req_rname+"%"));
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

		   if(!Tools.isNull(req_vdate)){
				   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	         Date v=null;
			   if(req_vdate.length()>0){
			   	try{
			   		 v=format.parse(req_vdate+" 00:00:00");
			   	  
			   	}catch(Exception ex){
			   		
			   	}
			    listRes.add(Restrictions.ge("odrmst_validdate", v));
			   }

		   }else{
			   if(Tools.isNull(tmorderid)&&Tools.isNull(req_rname)&&Tools.isNull(req_phone)){
			   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			   try{
				   Date sDate=Tools.addDate(new Date(), -60); 
			        listRes.add(Restrictions.ge("odrmst_validdate", sDate ));
				 

			   }catch(Exception ex){
				   ex.printStackTrace();
			   }
			   }
		   }
	 
			   listRes.add(Restrictions.eq("odrmst_sndshopcode", "00000000"));
			   listRes.add(Restrictions.eq("odrmst_mbrid", new Long(1544012)));


			   
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
	

	
	public static ArrayList<OrderBase> getOrderList(HttpServletRequest request,HttpServletResponse response){
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
		ArrayList<OrderMain> listmain=getOrderMainList( request,response);
		if(listmain!=null){
			for(OrderMain ordermain:listmain){
				list.add(ordermain);
			}
		}
		if(Tools.isNull(req_odrstatus)||(!Tools.isNull(req_odrstatus)&&Tools.parseInt(req_odrstatus)>=3)){
			ArrayList<OrderRecent> listrecent=getOrderRecentList( request, response);
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
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/uploadify/swfobject.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/uploadify/jquery.uploadify.v2.1.4.js")%>"></script>

<title>订单列表</title>
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


function modiaddr(obj,odrid,odrnum){
	var rname=$('#req_rname'+odrnum).val();
	var prv=$('#req_prv'+odrnum).val();
	var city=$('#req_city'+odrnum).val();
	var addr=$('#req_addr'+odrnum).val();
	var zipcode=$('#req_zipcode'+odrnum).val();
	var phone=$('#req_phone'+odrnum).val();

	if (rname == ""){
		 $.alert('收货人不能为空!');
	        return;
	    }  
	 if (prv == ""){
		 $.alert('省不能为空!');
	        return;
	    }  
	if (city == ""){
		$.alert('市不能为空!');
	        return;
	    }
	if (addr == ""){
		$.alert('地址不能为空!');
	        return;
	    }
	if (phone == ""){
		$.alert('电话不能为空!');
	        return;
	    }
	//return;
    $.ajax({
		type: "get",
		dataType: "json",
		url: '/admin/ajax/kfodraddrup.jsp',
		cache: false,
		data: {odrid:odrid,prv:prv,city:city,addr:addr,phone:phone,zipcode:zipcode,rname:rname},
		error: function(XmlHttpRequest){
		},success: function(json){
			if(json.code==1){
				$.alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
function moditax(obj,odrid,odrnum){
	var tatflag = $('input[type=radio][name=taxflag'+odrnum+']:checked').val();
	var taxtit=$('#req_taxtit'+odrnum).val();
	var taxtxt=$('#req_taxtxt'+odrnum).val();
	var memo=$('#req_memo'+odrnum).val();

    if(tatflag.length==0){
    	tatflag=0;
    }
    $.ajax({
            type: "POST",
            dataType: "json",
            url: "/admin/ajax/kfodrtaxup.jsp",
            data:{odrid:odrid,tatflag:tatflag,taxtit:taxtit,taxtxt:taxtxt,memo:memo},
            success: function(json) {
            	$.alert(json.message)
            }

            });
    
}
function modtmfx(obj,odrid,odrnum){
	var tmfx=$('#req_tmfx'+odrnum).val();
	var imgurl=$('#hsgimg'+odrnum).val();

    if(imgurl==null){
    	$.alert('返现截图不能为空!');
        return;
    }
    if(tmfx==null||isNaN(tmfx)||tmfx==0){
    	$.alert('返现金额不能为空。所填金额必须为数字,不能为0!');
        return;
    }
    $.ajax({
            type: "POST",
            dataType: "json",
            url: "/admin/ajax/kfodrfxup.jsp",
            data:{odrid:odrid,tmfx:tmfx,imgurl:imgurl},
            success: function(json) {
            	$.alert(json.message)
            }

            });
    
}
function tmkfodrc(obj,odrid){
	if (confirm("是否确认要取消订单请谨慎，如果一旦取消恢复订单流量很复杂！"))  {  
		
    $.ajax({
            type: "POST",
            dataType: "json",
            url: "/admin/ajax/kfcancdtl.jsp",
            data:{odrid:odrid},
            success: function(json) {
            	$.alert(json.message)
            }

            });
	}
    
}

function addodrzp(obj,odrid,odrnum){
	var gdssku = $('#gdssku'+odrnum+' option:selected') .val();
	var zpgdsid=$('#req_zpgdsid'+odrnum).val();
	if(zpgdsid.length==0){
    	$.alert('赠品商品ID为能为空!');
        return;
    }
    $.ajax({
            type: "POST",
            dataType: "json",
            url: "/admin/ajax/kfodraddzp.jsp",
            data:{odrid:odrid,zpgdsid:zpgdsid,gdssku:gdssku},
            success: function(json) {
            	$.alert(json.message)
            }

            });
    
}
function checksku(obj,num){
	var zpgdsid=$(obj).val();
	if(zpgdsid.length==0){
		$.alert('赠品商品ID为能为空!');
        return;
	}
	 $.ajax({
         type: "POST",
         dataType: "json",
         url: "/admin/ajax/kfzpsku.jsp",
         data:{zpgdsid:zpgdsid},
         success: function(json) {
        	 if(json.code==1){
         	   $.alert(json.message)
        	 }
        	 alert(json.code)
            if(json.code==0){
        		 var skus=eval(json.skulist);
        			$('#zpskuspan'+num).html('');
        			if(skus.length>0){
        				var skuli='<select name="gdssku'+num+'" id="gdssku'+num+'">';
        			   for(var i=0;i<skus.length;i++){
        				   skuli+='<option value="'+skus[i].skuname+'">'+skus[i].skuname+'</option>';
        			   }
        			   skuli+='</select>';
        			   alert(skuli);
        			   $('#zpskuspan'+num).html(skuli);
        			}
        		
        	 }
         }

         });
}
function kfimgact(i){
	 $("#kfupload"+i).uploadify({
		   'uploader'       : '/res/js/uploadify/uploadify.swf?v=' + (new Date()).getTime(),
		   'script'         : '/servlet/Upload?va=' + (new Date()).getTime(),
		   'method' :'GET',
		   'cancelImg'      : '/res/js/uploadify/cancel.png',
		   'folder'         : '/opt/shopimg/gdsimg',
		   'queueID'        : 'fileQueue6',
		   'queueSizeLimit'  :1, 
		   'fileDesc'    : 'jpg文件或jpeg文件或png文件或gif文件',
		   'fileExt' : '*.jpg;*.jpeg;*.png;*.gif',                
		   'auto'           : true,
		   'multi'          : false,
		   'sizeLimit': 5120000,
		   'buttonImg':'/admin/SHManage/images/bdsc.jpg',
		   'hideButton':true, 
		   'buttonText'     : 'BROWSE',
		   'onComplete': function (event, queueID, fileObj, response, data) {//返回函数	  
			   if(response.indexOf(';')>0){
	    		   var sg_arr=response.split(';');
	    		   var sgimgurl="http://www.d1.com.cn"+sg_arr[0]+"?"+Math.round(Math.random()*100000);
					$('#spzt'+i).html('');
					$('#spzt'+i).append("<img src='"+sgimgurl+"' width=\"60\" height=\"60\" style=\"float:left;\"/>");
					$('#hsgimg'+i).val(sg_arr[0]);
	    	   }					   
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
                          <td width="95%" class="STYLE1"><span class="STYLE3">你当前的位置</span>：[订单管理]</td>
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
                    <td class="STYLE1"><div align="center"></div></td>
                    <td class="STYLE1"><div align="center"></div></td>
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
            <%  String tmorderid= request.getParameter("tmorderid");
	   String req_rname= request.getParameter("req_rname");
	   String req_phone= request.getParameter("req_phone");
	   String req_vdate= request.getParameter("req_vdate");
	   String req_odrstatus= request.getParameter("req_odrstatus");
	  
	   %>
              <td width="10%">天猫订单号</td>
              <td width="16%"><input type="text" name="tmorderid" id="tmorderid" value="<%=!Tools.isNull(tmorderid)?tmorderid:""%>" /></td>
              <td width="9%">收货人/旺旺号</td>
              <td width="26%"><input name="req_rname" type="text" id="req_rname" size="40" value="<%=!Tools.isNull(req_rname)?req_rname:""%>" /></td>
              <td width="19%">&nbsp;</td>
              <td width="20%">&nbsp;</td>
            </tr>
            <tr>
              <td>手机号</td>
              <td><input name="req_rname2" type="text" id="req_phone" size="40" value="<%=!Tools.isNull(req_phone)?req_rname:""%>" /></td>
              <td width="9%">付款时间</td>
              <td width="26%"><input name="req_vdate" type="text" id="req_vdate" size="40" value="<%=!Tools.isNull(req_vdate)?req_vdate:""  %>" onclick="WdatePicker();" /></td>
              <td width="19%">&nbsp;</td>
              <td width="20%">&nbsp;</td>
            </tr>
            <tr>
              <td>订单状态</td>
              <td><select name="req_odrstatus" id="req_odrstatus">
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
   
 <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="b5d6e6" >
          <tr>
            <!-- <td width="3%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">
              <input type="checkbox" name="checkbox" value="checkbox" />
            </div></td>-->
            <td width="40%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">商品名称</div></td>
            <td width="7%" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">商品编号</div></td>
            <td width="10%" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">成交价</div></td>
            <td width="8%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">数量 </span></div></td>
            <td width="10%" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">库存</div></td>
            <td width="25%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF" class="STYLE1"><div align="center">基本操作</div></td>
          </tr>

    
 <%
String act=request.getParameter("act");
   SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
   String ggURL = Tools.addOrUpdateParameter(request,null,null);
   ggURL=ggURL.replace("&button=查询", "");
   ArrayList<OrderBase> list=new ArrayList<OrderBase>();

   if(act!=null&&act.equals("list")){
   list=getOrderList(request,response);
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
 	    		  float tmfx=odr.getOdrmst_tmfx().floatValue();
 	    		 long tmfxstatus=odr.getOdrmst_tmfxstatus().longValue();
 	    		String tupimg=odr.getOdrmst_tmfximg();
 	    		  String prv=odr.getOdrmst_rprovince();
 	    		 String city=odr.getOdrmst_rcity();
 	    		String phone=odr.getOdrmst_rphone();
 	    		String addr=odr.getOdrmst_raddress();
 	    		String zipcode=odr.getOdrmst_rzipcode();
 	    		String rname=odr.getOdrmst_rname();
 	    		long taxflag=odr.getOdrmst_taxflag().longValue();
 	    		OdrTmTxt  otmt=(OdrTmTxt)Tools.getManager(OdrTmTxt.class).findByProperty("odrtmtxt_odrid", odr.getId());
 	    		String taxtit="";
                String taxtxt="";
 	    		if(otmt!=null){
 	    			 taxtit=otmt.getOdrtmtxt_taxtitle();
 	                 taxtxt=otmt.getOdrtmtxt_taxtxt();
 	                 
 	    		}
 	    		
                String memo=odr.getOdrmst_internalmemo();
                String shipname=odr.getOdrmst_d1shipmethod();
                String shipcode=odr.getOdrmst_goodsodrid();
                System.out.println(shipcode+"========="+shipname);
      %>      
		   <tr>
		     <td height="24" colspan="6" bgcolor="#FFFFFF">
		       <table width="100%" border="0" cellspacing="0" cellpadding="0">
		         <tr>
		           <td colspan="6" class="pdl8">淘宝订单号：<%=odr.getOdrmst_pbp() %>&nbsp;&nbsp;下单时间：<%=odr.getOdrmst_orderdate() %>&nbsp;&nbsp;会员名：<%=odr.getOdrmst_rname() %>&nbsp;&nbsp;D1订单号：<%=odr.getId() %>
		           <%=!Tools.isNull(shipname)?"快递公司："+shipname+"&nbsp;&nbsp;快递单号："+shipcode:"" %>
		           </td>
		           </tr>
		         <tr>
		           <td width="45%" class="pdl8">
		           收货人：<input type="text" name="req_rname<%=i %>" id="req_rname<%=i %>" value="<%=!Tools.isNull(rname)?rname:""%>" /> <br />
		           省<input type="text" name="req_prv<%=i %>" style="width:100px" id="req_prv<%=i %>" value="<%=!Tools.isNull(prv)?prv:""%>" />
		            市<input type="text" name="req_city<%=i %>" style="width:130px" id="req_city<%=i %>" value="<%=!Tools.isNull(city)?city:""%>" />
		     <br /> 地址：<input type="text" name="req_addr<%=i %>" style="width:280px" id="req_addr<%=i %>" value="<%=!Tools.isNull(addr)?addr:""%>" /><br />   
                   邮编：<input type="text" name="req_zipcode<%=i %>" id="req_zipcode<%=i %>" value="<%=!Tools.isNull(zipcode)?zipcode:""%>" /> <br />
                   电话：<input type="text" name="req_phone<%=i %>" id="req_phone<%=i %>" value="<%=!Tools.isNull(phone)?phone:""%>" />
		             <input type="button" name="imageField3" value="修改收货人信息" onclick="modiaddr(this,'<%=odr.getId() %>',<%=i %>);"  />
		             <br />
		           </span>
		           赠品添加：<input type="text" name="req_zpgdsid<%=i %>" id="req_zpgdsid<%=i %>" onblur="checksku(this,<%=i %>)" />
		           <span id="zpskuspan<%=i %>"></span>
		           <input type="button" name="imageField4" value="添加赠品" onclick="addodrzp(this,'<%=odr.getId() %>',<%=i %>);"  />
		           </td>
		          <td>
		<%if(tmfxstatus==0){ %>
		  返现截图<div id="fileQueue<%=i %>" class="sctpk" >
        	     <input type="file" name="kfupload" id="kfupload<%=i %>" /> 
      		   </div>
      		   <%} %>
<div id="spzt<%=i %>"  ><img src="http://images1.d1.com.cn<%=tupimg%>" width="60" height="60" /></div>
<input type="hidden"  value="<%=tupimg %>" id="hsgimg<%=i %>" />
<%if(tmfxstatus==0){ %>
<script type="text/javascript">
kfimgact(<%=i%>);
</script>
<%} %>
		          返现金额：<input type="text" name="req_tmfx<%=i %>" id="req_tmfx<%=i %>" value="<%=tmfx%>" /><br />
		   <%if(tmfxstatus==1){    %>   
		          返现状态：正在处理</br>
		          <%}if(tmfxstatus==2){  %>
		            返现状态：已返现</br>
		     <%} %>
		     <%if(tmfxstatus==0){ %>
		           <input type="button" name="imageField2" value="返现信息修改" onclick="modtmfx(this,'<%=odr.getId() %>',<%=i %>);"  /></td>
		          <%} %>
		          </td>
		           <td >发票状态：<input type="radio" name="taxflag<%=i %>" id="taxflag<%=i %>" value="0" <%if(taxflag==0)out.print("checked"); %> />不需要
		             <input type="radio" name="taxflag<%=i %>" id="taxflag<%=i %>" value="1" <%if(taxflag==1)out.print("checked"); %> />发票待开&nbsp;&nbsp;<%if(taxflag==5)out.print("发票已开"); %><br />
		             发票抬头：<input type="text" name="req_taxtit<%=i %>" id="req_taxtit<%=i %>" value="<%=taxtit%>" /><br />
		          发票内容：<input type="text" name="req_taxtxt<%=i %>" id="req_taxtxt<%=i %>" value="<%=Tools.isNull(taxtxt)?"化妆品":taxtxt%>" />
		         
		             </td>
		           <td colspan="2">
		           
                     重要留言：<%=memo %><br />
                     <textarea name="req_memo<%=i %>" style="width:180px" id="req_memo<%=i %>"></textarea><br />
                     <input type="button" name="imageField2" value="修改发票留言信息" onclick="moditax(this,'<%=odr.getId() %>',<%=i %>);"  /></td>
		           <td width="10%"> <%String paystatus="未到款";
		           
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
        
         
out.print(paystatus);  %><br/>
 <%if(odrstatus==2){ %>
		           <input type="button" name="imageField"  value="取消订单" onclick="tmkfodrc(this,'<%=odr.getId() %>');"  />
		           <%} %>
</td>
		           </tr>
		           <tr>
		             <td height=30 colspan="6">总价：<%=odr.getOdrmst_acturepaymoney().floatValue()+odr.getOdrmst_tktvalue().floatValue() %>元    用券：<%=odr.getOdrmst_tktvalue() %>元   实际支付：<%=odr.getOdrmst_acturepaymoney().floatValue()%>元</td>
		             </tr>
		           <%
		          long printflag=odr.getOdrmst_printflag().longValue();
		           for(OrderItemBase itembase:listdetail){
			 long dtlstatus=itembase.getOdrdtl_shipstatus().longValue();
			 float gdsprice=itembase.getOdrdtl_finalprice().floatValue();
			 float inprice=itembase.getOdrdtl_purprice().floatValue();
			 String gdsname=itembase.getOdrdtl_gdsname();
			 long gdscount=itembase.getOdrdtl_gdscount();
			 String dtlid=itembase.getId();
			 %>
		           
		           <tr>
		           <td height=30><%=gdsname %></td>
		           <td width="6%"><%=gdsprice %></td>
		           <td width="12%">&nbsp;</td>
		           <td width="7%"><%=gdscount %></td>
		           <td width="21%"><%String statustxt="";

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
		           <td>
		          
		           </td>
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
					           	&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=1">首页</a><%
					           			
					           	if(pBean1.hasPreviousPage()){%>&nbsp;&nbsp;<a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
					           
					           	for(int i=pBean1.getStartPage();i<=pBean1.getEndPage()&&i<=pBean1.getTotalPages();i++){
					           		if(i==currentPage1){
					           		%>&nbsp;&nbsp;<span class="curr"><%=i %></span><%
					           		}else{
					           		%>&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=<%=i %>"><%=i %></a><%
					           		}
					           	}
					           	
					           	%>
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
