<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%!
   //获取该商户的所有模块
   private ArrayList<ShopModel> getShopModelList(String shopinfo_id)
   {
	ArrayList<ShopModel> rlist = new ArrayList<ShopModel>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("shopmodel_infoid", new Long(shopinfo_id)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("shopmodel_sort"));
	List<BaseEntity> list = Tools.getManager(ShopModel.class).getList(clist, olist, 0, 22);
	if(clist==null||clist.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((ShopModel)be);
	}
	
	return rlist ;
	
   }
//获取首页商户的信息 
	private ArrayList<ShopInfo> getShopInfoList(String shopcode)
	{ 
		ArrayList<ShopInfo> rlist = new ArrayList<ShopInfo>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("shopinfo_shopcode", shopcode));
		clist.add(Restrictions.eq("shopinfo_indexflag", new Long(0)));//0为首页
		clist.add(Restrictions.eq("shopinfo_del", new Long(0)));//未被删除
		List<BaseEntity> list = Tools.getManager(ShopInfo.class).getList(clist, null, 0, 1);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ShopInfo)be);
		}
		
		return rlist ;
		
	}
//获取专题页商户的信息 
	private ShopInfo getShopInfoById(String zt_id)
	{ 
		ShopInfo shop_info = (ShopInfo)Tools.getManager(ShopInfo.class).get(zt_id);
		if(shop_info==null)return null;
		return shop_info ;
	}
%>
<%
   String index_flag = request.getParameter("index_flag");//值=1表示添加专题 2修改专题 0 首页
   String si_info_id = "";
   if(index_flag!=null){
	   session.setAttribute("index_flag", index_flag);
   }else{
	   index_flag = 0+"";
	   session.setAttribute("index_flag", index_flag);
   }
   String zt_id =  request.getParameter("zt_id");//专题id 专题列表页传过来的值
   ShopInfo si=null;
   ShopInfo si_new = null;
   ArrayList<ShopModel> smlist = null;
   if(zt_id == null){
	   ArrayList<ShopInfo> silist= getShopInfoList(session.getAttribute("shopcodelog").toString());
	   if(silist!=null&&silist.size()>0&&silist.get(0)!=null&&!index_flag.equals("1")){
	       si=silist.get(0);
	       si_new = silist.get(0);//为了判断首页的情况下模板数量
	   }
   }else{
	      si = getShopInfoById(zt_id);
   }
 //获取模块
   smlist=new ArrayList<ShopModel>();
   if(si_new != null||index_flag.equals("1")){
	   smlist = null;
   }else{
	   if(si != null && si.getId() != null){
	   		smlist=getShopModelList(si.getId());
	   }
   }

   ShpMst shpmst = (ShpMst)Tools.getManager(ShpMst.class).get(session.getAttribute("shopcodelog").toString());
   String shopsname = "";//商户缩写名
   if(shpmst!=null){
	   shopsname = shpmst.getShpmst_shopsname();
   }
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>
 <%
   if(!index_flag.equals("0")){%>
	   商户专题页设置
  <% }else{%> 
  	  商户首页设置：
  <%}%>
</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="/admin/SHManage/Shop/SetJS.js?1.37"></script>
<script type="text/javascript" src="/d1xheditor/xheditor-zh-cn.min.js"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/uploadify/swfobject.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/uploadify/jquery.uploadify.v2.1.4.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/DatePicker/WdatePicker.js")%>"></script>
<style type="text/css">
a{ text-decoration:none; color:#3A5FCD;} 
a img{border:none;}
.color_width{width: 70px;}
.model_txt{margin-left: 80px;}
.model_txtcolor{margin-left: 16px;}
</style>
<script type="text/javascript">
//专题页预览
function preview_a(){
	var shop_id_ = $("#shop_id").val();
	var hshopcode = $("#hshopcode").val();
	var shopinfo_lineflag = $("#shopinfo_lineflag").val();
  	var hour_minus = new Date().getHours();	 
  	var chk_pre = shop_id_*1+hshopcode*1-hour_minus*1;
  	if(shopinfo_lineflag == '' || shopinfo_lineflag == 0){
  		window.open('/shopindex.jsp?index_flag=1&sc='+shop_id_+'&chk_pre='+chk_pre);
  		//window.open('/shop-'+shop_id_+'-1-'+chk_pre);
  	}else{
  		//window.open('/shopindex.jsp?index_flag=1&sc='+shop_id_);
  		window.open('/shop/'+shop_id_+'/1');
  	} 
	
}
//首页预览
function preview_b(){
	var shop_id_ = $("#shop_id").val();
	//var hshopcode = $("#hshopcode").val();
	var hshopcode = $("#shopsname").val();
	var shopinfo_lineflag = $("#shopinfo_lineflag").val();
  	var hour_minus = new Date().getHours();	 
  	var chk_pre = shop_id_*1+hshopcode*1-hour_minus*1;
  	if(shopinfo_lineflag == '' || shopinfo_lineflag == 0){
  		window.open('/shopindex.jsp?sc='+hshopcode+'&chk_pre='+chk_pre);
  	}else{
  		//window.open('/shopindex.jsp?sc='+hshopcode);
  		window.open('/shop/'+hshopcode);
  	} 
	
}
</script>
</head>
<body>
<div>
<%@include file="/admin/inc/shhead.jsp" %>
<br/>
<br/>
<form id="form1" name="form1" method="post" action="" target="right">
<table style="width:980px; margin:0px auto;" border="0" cellpadding="0" cellspacing="0" align="center">
   <tr><td width="174" style="text-align:center;" valign="top">
     <%@include file="/admin/inc/shleftwh.jsp" %>
   </td>
   <td width="806" valign="top" align="right">
   <input type="hidden" id="hshopcode" value="<%=session.getAttribute("shopcodelog").toString() %>"></input>
   <input type="hidden" id="shopinfo_lineflag" value="<%= si!=null&&si.getShopinfo_lineflag()!=null?si.getShopinfo_lineflag():"" %>"/>
   <input type="hidden" id="shopsname" value="<%= shopsname%>"/>
   <table style="width:95%; margin:0px auto; font-size:14px; text-align:left; margin-left:10px;" cellpadding="0" cellspacing="0" >
   <tr >
   <td valign="middle" height="50" style="background:#edf7ef;border:solid 1px #ccc;" valign="middle">
   <table cellspacing="0" cellpadding="0" width="100%" height="100%">
   <tr><td width="720">&nbsp;&nbsp;&nbsp;&nbsp;
   <%String index_flag2="";
   if(si!=null &&si.getShopinfo_indexflag()!=null&& si.getShopinfo_indexflag()>=0){
	   index_flag2 = si.getShopinfo_indexflag().toString();
   }
   if(!index_flag.equals("0")&&!index_flag2.equals("3")){%>
	   店铺专题页管理
      <a id="yulan_a" href="javascript:void(0);" onclick="preview_a();" target="_blank" ><img src="http://images.d1.com.cn/zt2013/icon/preview.png" style="vertical-align:middle;"/></a>
  <%}else{%> 
  	  店铺首页管理：
  	  <a href="javascript:void(0);"  onclick="preview_b();" target="_blank" ><img src="http://images.d1.com.cn/zt2013/icon/preview.png" style="vertical-align:middle;"/></a>
  <%}%>
   
   &nbsp;&nbsp;
   
   <a href="javascript:void(0)" onclick="OnLine()" ><img src="http://images.d1.com.cn/zt2013/icon/up.png" style="vertical-align:middle;"/></a> &nbsp;&nbsp;
  
   </td>
   
   <td><a href="javascript:void(0)" onclick="OutLine()"><img src="http://images.d1.com.cn/zt2013/icon/down.png" style="vertical-align:middle;"/></a>&nbsp;&nbsp;&nbsp;&nbsp;
   </td>
   </tr>
   </table>
   <%if(index_flag.equals("0")){%>
   		<input type="hidden" value="0" id="index_flag" name="index_flag" />
	<%}else{%>
		<input type="hidden" value="1" id="index_flag" name="index_flag" />
   <%}%>
   <%if(zt_id == null && index_flag.equals("0")){//首页%>
    	<input type="hidden" value="<%= si!=null&&si.getId()!=null?si.getId():"" %>" id="shop_id" name="shop_id" />  
    <%}else{//专题%>
    	<input type="hidden" value="<%= zt_id%>" id="shop_id" name="shop_id" />  
    <%}%>
   </td></tr>
   <%if(index_flag.equals("0")){%>
   <tr><td height="15"></td></tr>
   <tr style="background:#f0f0f0;height:40px;">
   <td height="25" style="border:solid 1px #ccc;">&nbsp;&nbsp;&nbsp;&nbsp;店铺招牌维护&nbsp;&nbsp;<font style="color:#f00">（宽度必须为：980像素。不可小于980，大于980的超出会被隐藏掉）</font></td> 
   </tr>
   <tr><td style="border:solid 1px #ccc;border-top:none; text-align:center">
   <br/>
  
   <textarea id="sh_logo" style="width: 790px;height: 300px;" >
   <%= si!=null&&!Tools.isNull(si.getId())&&!Tools.isNull(si.getShopinfo_logo())?si.getShopinfo_logo():"" %>
   </textarea> 
   <br/>
   <a href="javascript:void(0)" onclick="SaveLogo()" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"  border="0"/></a>
   </td></tr> 
   
   <tr><td height="15"></td></tr>
   <tr style="background:#f0f0f0;height:40px;">
   <td style="border:solid 1px #ccc;">&nbsp;&nbsp;&nbsp;&nbsp;店铺招牌背景图&nbsp;&nbsp;<font style="color:#f00">（注：如果想实现头部通屏效果，请单独上传一张背景图。宽度必须为1920像素）</font></td>
   </tr>
   <tr>
   <td style="border:solid 1px #ccc;border-top:none; text-align:center;">
   <br/>
   <input type="hidden" value="" id="hw" />
   <input type="hidden" value="" id="hh" />
   <input type="hidden"  value="" id="himgurl" />
   <div id="fileQueue" class="sctpk" style="float:left;">
     <input type="file" name="uploadify" id="uploadify" /> 
   </div>      		
   <div id="btnupload" style="padding-left:25px;float:left;clear:both;"></div>
   <br/><br/>
   <div id="background_img" style="width:100%">
   <%   if(si!=null&&!Tools.isNull(si.getId())){ %>
	     <a href='<%= !Tools.isNull(si.getShopinfo_bigimg())?si.getShopinfo_bigimg():"" %>' target='_blank'>
	     <img src='<%= !Tools.isNull(si.getShopinfo_bigimg())?si.getShopinfo_bigimg():"" %>' width="830" height="94"/>
	     </a>
   <%   } %>
   </div>
   <br/>
   <a href="javascript:void(0)" onclick="Savebackg_img()" ><img src="http://images.d1.com.cn/zt2013/icon/up2.png"  border="0"/></a>
   &nbsp;&nbsp;<a href="javascript:void(0)" onclick="DeleteLogoBgImg()"><img src="http://images.d1.com.cn/zt2013/icon/delete.png"/></a>
   <br/>
   </td>
   </tr>
   
   <%}%>
   <tr><td height="15"></td></tr>
   <tr style="background:#f0f0f0;height:40px;">
   <td style="border:solid 1px #ccc;">&nbsp;&nbsp;&nbsp;&nbsp;店铺首张广告图&nbsp;&nbsp;<font style="color:#f00">（建议：图片宽度为1920像素，高度为520像素）</font></td>
   </tr>
   <tr>
   <td style="border:solid 1px #ccc;border-top:none; text-align:center;">
   <br/>
   <textarea id="bgimg" style="width: 790px;height: 300px;" >
   <%= si!=null&&!index_flag.equals("1")&&!Tools.isNull(si.getId())&&!Tools.isNull(si.getShopinfo_bgimg())?si.getShopinfo_bgimg():"" %>
   </textarea> 
   <!-- <br/>
   <a href="javascript:void(0)" onclick="SaveLogo_1()" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"  border="0"/></a>
    -->
   </td></tr> 
   <!-- 特卖起止时间 -->
   <tr><td height="15"></td></tr>
   <tr style="background:#f0f0f0;height:40px;">
   <td style="border:solid 1px #ccc;">&nbsp;&nbsp;&nbsp;&nbsp;特卖会效果&nbsp;&nbsp;
   <font style="color:#f00">（注：设置倒计时后，将在专题页面展示倒计时效果。但是需要注意的是：专题里的推荐商品，必须都要设置为</font>
   <font style="color:#f00">&nbsp;&nbsp;&nbsp;&nbsp;同样的开始和结束时间。）</font>
   </td>
   </tr>
   <tr>
   <td style="border:solid 1px #ccc;border-top:none; text-align:left;">
   <br/>
   &nbsp;&nbsp;
   	 从<input type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  name="tm_begin" id="tm_begin" value="<%= si!=null&&!index_flag.equals("1")&&!Tools.isNull(si.getId())&&si.getShopinfo_tmbegin()!=null?sdf.format(si.getShopinfo_tmbegin()):"" %>" style="width: 130px;"/>
   	 到<input type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  name="tm_end" id="tm_end" value="<%= si!=null&&!index_flag.equals("1")&&!Tools.isNull(si.getId())&&si.getShopinfo_tmend()!=null?sdf.format(si.getShopinfo_tmend()):"" %>" style="width: 130px;"/>
   <br />
   &nbsp;&nbsp;<input type="checkbox" name="tm_order1" value="1" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_orderflag()!=null&&smlist.get(0).getShopmodel_orderflag()==1) out.print("checked='checked'");%> />设置排序功能&nbsp;&nbsp;<font style=" color: red;">（注：如果设置排序功能，那么只支持显示第一个商品区块，其他商品显示区块将失效。）</font>
   
   <br />
   </td></tr> 
   
   <tr><td height="15"></td></tr>
   <tr style="background:#f0f0f0;height:40px;">
   <td style="border:solid 1px #ccc;">&nbsp;&nbsp;&nbsp;&nbsp;店铺主推商品&nbsp;&nbsp;<font style="color:#f00">（注：将在您店铺页面最下部显示。输入您店铺的商品编号，多个商品用逗号隔开,例如：02002150,02002151.）</font></td>
   </tr>
   <tr>
   <td style="border:solid 1px #ccc; border-top:none; text-align:center;">
   <br/>
	   <table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
	   <tr>
	     <td height="35" valign="middle"> 
		   <textarea rows="2" id="ztgdsmst" name="ztgdsmst" style="border:solid 1px #d4d4d4;background:#f8f8f8; width:760px" ><%= si!=null&&!index_flag.equals("1")&&!Tools.isNull(si.getShopinfo_ztimglist())?si.getShopinfo_ztimglist():"" %></textarea>
		   &nbsp;&nbsp;&nbsp;&nbsp;
	     </td>   
	   </tr>
	   
	   <%if(!index_flag.equals("0")){%>
	   <tr><td align="left">
          &nbsp;&nbsp;&nbsp;&nbsp;专题名称：<input type="text" id="shopinfo_title" style="width:600px;" value="<%= si!=null&&!index_flag.equals("1")&&!Tools.isNull(si.getId())&&!Tools.isNull(si.getShopinfo_title())?si.getShopinfo_title():"" %>"></input>
  	   </td></tr>
  	   <%}%>
	   <tr><td align="left">
	      &nbsp;&nbsp;&nbsp;&nbsp;请输入背景颜色值：#<input type="text" id="bgcolor" style="width:80px;" value="<%= si!=null&&!index_flag.equals("1")&&!Tools.isNull(si.getShopinfo_bgcolor())?si.getShopinfo_bgcolor():"" %>"></input>
	    <br/><!-- <a href="javascript:void(0)" onclick="SaveZtGoods()" ><img src="http://images.d1.com.cn/zt2013/icon/save.png"  border="0" style="vertical-align:middle;"/></a> 
	      -->  </td></tr>
       <tr><td align="left">
                       <table><tr><td>手机banner（将在手机专题顶部显示，宽度最小320，不超过640）：</td><td>
          <div id="fileQueue6" class="sctpk" style="float:left;">
        	     <input type="file" name="sgupload" id="sgupload" /> 
      		   </div>
 <input type="hidden"  value="0" id="sgflag" />
<div id="spzt6"  ><img src="<%=si!=null&&!index_flag.equals("1")&&!Tools.isNull(si.getShopinfo_wapbanner())?si.getShopinfo_wapbanner():"" %>" /></div>
<input type="hidden"  value="<%=si!=null&&!index_flag.equals("1")&&!Tools.isNull(si.getShopinfo_wapbanner())?si.getShopinfo_wapbanner():"" %>" id="hsgimg" />
  	   </td></tr>
  	   </table>
  	   </td></tr>
	   </table>
   </td>
   </tr>
   <tr><td height="15"></td></tr>
   <tr style="background:#f0f0f0; height:40px;"><td style="border:solid 1px #ccc;">&nbsp;&nbsp;&nbsp;&nbsp;请输入浮动广告信息：</td></tr>
   <tr><td style="border:solid 1px #ccc; border-top:none;">
   <br/>
   <table border="0" cellpadding="0" cellspacing="0" width="100%" style="text-align:center;">
   <tr><td >
   <textarea id="floatcontent" style="width:790px;height: 300px;" ><%= si!=null&&!index_flag.equals("1")&&!Tools.isNull(si.getShopinfo_floatcontent())?si.getShopinfo_floatcontent():"" %>   </textarea>
   </td></tr>
   <tr><td><br/><!-- <a href="javascript:void(0)" onclick="SaveZtGoods_1()" > --><a href="javascript:void(0)" onclick="SaveShopMore()" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"  border="0"/></a>
   </td></tr>
   </table>
   
   </td>
   </tr>  
   <tr><td align="center"  valign="middle" height="115">
       <a id="addm" href="javascript:void(0)" onclick="AddModel()"><img src="http://images.d1.com.cn/zt2013/icon/add.png"/></a>
         &nbsp;&nbsp;&nbsp;&nbsp;
    <%
   if(!index_flag.equals("0")&&!index_flag2.equals("3")){%>
      <a href="javascript:void(0);" onclick="preview_a();" target="_blank" ><img src="http://images.d1.com.cn/zt2013/icon/preview.png" /></a>
  <%}else{%> 
  	  <a href="javascript:void(0);"  onclick="preview_b();" target="_blank" ><img src="http://images.d1.com.cn/zt2013/icon/preview.png" /></a>
  <%}%>    
       <input type="hidden" value="<%= smlist!=null&&smlist.size()>0?smlist.size():0 %>" id="display" ></input>   
   </td></tr>
   <!-- 模块一 -->
   <tr id="mode_1" <% if(smlist!=null&&smlist.size()>0) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td>
   <table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('1')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>&nbsp;&nbsp; </td></tr>
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid1" value="<% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getId()!=null) out.print(smlist.get(0).getId()); %>"></input>
                              &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type1" onchange="changes(this,'1')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_type()!=null&&smlist.get(0).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_type()!=null&&smlist.get(0).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">
                                是否发布：<select id="mode_flag1">
                        <option value="0" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_flag()!=null&&smlist.get(0).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_flag()!=null&&smlist.get(0).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select>
              </td>
              <td width="33%">
              请输入排序值：<input id="mode_seq1" type="text" style="width:50px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_sort()!=null) out.print(smlist.get(0).getShopmodel_sort()); %>"></input>   </td>
           </tr>
           <tr><td colspan="3" align="center">           
                <div id="mode_h1" style="background:#fff;<% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_type()!=null&&smlist.get(0).getShopmodel_type()!=1) out.print("display:none;"); %>">
                   <div style="color:red">用\${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
                   <br/><textarea id="mode_html1" style="width: 790px;height: 300px;" ><% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_content()!=null){out.print(smlist.get(0).getShopmodel_content());} %></textarea>
                <br/>
                </div>
                <div id="mode_list1" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_type()!=null&&smlist.get(0).getShopmodel_type()!=2)||(smlist==null||smlist.size()==0)) out.print("display:none;");  %>">
                 &nbsp;&nbsp;请输入模块背景颜色值：#<input class="color_width" type="text" id="mode_titile1" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_title()!=null) out.print(smlist.get(0).getShopmodel_title()); %>"></input>
                 &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt1" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_txt()!=null) out.print(smlist.get(0).getShopmodel_txt()); %>"></input></span>
                 &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor1" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_txtcolor()!=null) out.print(smlist.get(0).getShopmodel_txtcolor()); %>"></input></span>
                <br/>
                 &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore1" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_txtmore()!=null) out.print(smlist.get(0).getShopmodel_txtmore()); %>"></input>
                <br/> 显示商品数：<input id="mode_gdsnum1" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null) out.print(smlist.get(0).getShopmodel_gdsnum()!=null?smlist.get(0).getShopmodel_gdsnum().longValue():0); %>"></input>&nbsp;&nbsp;  
                 &nbsp;&nbsp;请选择图片尺寸：<select id="mode_tpcc1">
                <option value="14" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_size()!=null&&smlist.get(0).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
                <br/>
			    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst1" name="mode_gdsmst1" 
			        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;" ><% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_list()!=null){out.print(smlist.get(0).getShopmodel_list());} %>
			    </textarea>  
			    <br/>
			    &nbsp;&nbsp;浮层文字：
			    <textarea id="shopmodel_balname1" name="shopmodel_balname1" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_balname()!=null) out.print(smlist.get(0).getShopmodel_balname()); %></textarea>
			    <br />
			    &nbsp;&nbsp;浮层图片：  
			    <input type="radio" name="shopmodel_balloon1" onclick="changlayertitle(0,1);" value="0" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_balloon()!=null&&smlist.get(0).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
			    <input type="radio" name="shopmodel_balloon1" onclick="changlayertitle(1,1);" value="1" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_balloon()!=null&&smlist.get(0).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
			    <input type="radio" name="shopmodel_balloon1" onclick="changlayertitle(2,1);" value="2" <% if(smlist!=null&&smlist.size()>0&&smlist.get(0)!=null&&smlist.get(0).getShopmodel_balloon()!=null&&smlist.get(0).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
                <br />
                &nbsp;<input type="checkbox" name="tm_flag1" value="1"/>商品秒杀起止时间和特卖会起止时间一致
                <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
                <br />
                </div>                 
                </td></tr>
                <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('1')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块一结束 -->  
   <tr><td height="15"></td></tr>
     <!-- 模块二 -->
   <tr id="mode_2" <% if(smlist!=null&&smlist.size()>1) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('2')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  </td></tr>
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid2" value="<% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getId()!=null) out.print(smlist.get(1).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type2" onchange="changes(this,'2')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_type()!=null&&smlist.get(1).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_type()!=null&&smlist.get(1).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag2">
                        <option value="0" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_flag()!=null&&smlist.get(1).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_flag()!=null&&smlist.get(1).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%">
              请输入排序值：<input id="mode_seq2" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_sort()!=null) out.print(smlist.get(1).getShopmodel_sort()); %>"></input> </td>                 
       </tr>
           <tr><td colspan="3" align="center">
   <div id="mode_h2" style="background:#fff;<% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_type()!=null&&smlist.get(1).getShopmodel_type()!=1) out.print("display:none;"); %>">
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <br/><textarea id="mode_html2" style="width: 790px;height: 300px;" ><% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_content()!=null){out.print(smlist.get(1).getShopmodel_content());} %></textarea>
    <br/></div>
    <div id="mode_list2" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_type()!=null&&smlist.get(1).getShopmodel_type()!=2)||(smlist==null||smlist.size()<2)) out.print("display:none;");  %>">
     &nbsp;&nbsp;请输入模块背景颜色值：#<input type="text" id="mode_titile2" value="<% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_title()!=null) out.print(smlist.get(1).getShopmodel_title()); %>"></input>
      &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt2" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_txt()!=null) out.print(smlist.get(1).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor2" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_txtcolor()!=null) out.print(smlist.get(1).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore2" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_txtmore()!=null) out.print(smlist.get(1).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum2" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null) out.print(smlist.get(1).getShopmodel_gdsnum()!=null?smlist.get(1).getShopmodel_gdsnum().longValue():0); %>"></input>&nbsp;&nbsp;
     &nbsp;&nbsp;请选择图片尺寸：<select id="mode_tpcc2">
      			<option value="14" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
               	<option value="10" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_size()!=null&&smlist.get(1).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst2" name="mode_gdsmst2" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_list()!=null){out.print(smlist.get(1).getShopmodel_list());} %>
    </textarea>   
    <br/>
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname2" name="shopmodel_balname2" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_balname()!=null) out.print(smlist.get(1).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：
    <input type="radio" name="shopmodel_balloon2" onclick="changlayertitle(0,2);" value="0" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_balloon()!=null&&smlist.get(1).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon2" onclick="changlayertitle(1,2);" value="1" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_balloon()!=null&&smlist.get(1).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon2" onclick="changlayertitle(2,2);" value="2" <% if(smlist!=null&&smlist.size()>1&&smlist.get(1)!=null&&smlist.get(1).getShopmodel_balloon()!=null&&smlist.get(1).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag2" value="2"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div>
    </td></tr>
                <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('2')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
      </td>
      </tr>
      </table>
      
   </td>
   </tr>
   <!-- 模块二结束 -->
   <tr><td height="15"></td></tr>
     <!-- 模块三-->
   <tr id="mode_3" <% if(smlist!=null&&smlist.size()>2) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td>
   <table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;">
   <a href="javascript:void(0)" onclick="DeleteModeDetail('3')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a> </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;">
        <input type="hidden" id="hmodeid3" value="<% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getId()!=null) out.print(smlist.get(2).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type3" onchange="changes(this,'3')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_type()!=null&&smlist.get(2).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_type()!=null&&smlist.get(2).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag3">
                        <option value="0" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_flag()!=null&&smlist.get(2).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_flag()!=null&&smlist.get(2).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%">
              请输入排序值：<input id="mode_seq3" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_sort()!=null) out.print(smlist.get(2).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h3" style="background:#fff;<% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_type()!=null&&smlist.get(2).getShopmodel_type()!=1) out.print("display:none;"); %>">
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <br/><textarea id="mode_html3" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_content()!=null){out.print(smlist.get(2).getShopmodel_content());} %>
    </textarea><br/>
    </div>
    <div id="mode_list3" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_type()!=null&&smlist.get(2).getShopmodel_type()!=2)||(smlist==null||smlist.size()<3)) out.print("display:none;");  %>">
       &nbsp;&nbsp;请输入模块背景颜色值：#<input type="text" id="mode_titile3" value="<% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_title()!=null) out.print(smlist.get(2).getShopmodel_title()); %>"></input>
   	  &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt3" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_txt()!=null) out.print(smlist.get(2).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor3" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_txtcolor()!=null) out.print(smlist.get(2).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore3" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_txtmore()!=null) out.print(smlist.get(2).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum3" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null) out.print(smlist.get(2).getShopmodel_gdsnum()!=null?smlist.get(2).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
     &nbsp;&nbsp;请选择图片尺寸：<select id="mode_tpcc3">
     			<option value="14" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>20&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_size()!=null&&smlist.get(2).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst3" name="mode_gdsmst3" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_list()!=null){out.print(smlist.get(2).getShopmodel_list());} %>
    </textarea>   
     <br/>  
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname3" name="shopmodel_balname3" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_balname()!=null) out.print(smlist.get(2).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon3" onclick="changlayertitle(0,3);" value="0" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_balloon()!=null&&smlist.get(2).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon3" onclick="changlayertitle(1,3);" value="1" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_balloon()!=null&&smlist.get(2).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon3" onclick="changlayertitle(2,3);" value="2" <% if(smlist!=null&&smlist.size()>2&&smlist.get(2)!=null&&smlist.get(2).getShopmodel_balloon()!=null&&smlist.get(2).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag3" value="3"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div> 
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('3')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块三结束 -->
   <tr><td height="15"></td></tr>
        <!-- 模块四-->
   <tr id="mode_4" <% if(smlist!=null&&smlist.size()>3) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('4')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  </td></tr>
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;">
        <input type="hidden" id="hmodeid4" value="<% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getId()!=null) out.print(smlist.get(3).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type4" onchange="changes(this,'4')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_type()!=null&&smlist.get(3).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_type()!=null&&smlist.get(3).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag4">
                        <option value="0" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_flag()!=null&&smlist.get(3).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_flag()!=null&&smlist.get(3).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%">
              请输入排序值：<input id="mode_seq4" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_sort()!=null) out.print(smlist.get(3).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h4" style="background:#fff;<% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_type()!=null&&smlist.get(3).getShopmodel_type()!=1) out.print("display:none;"); %>">
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <br/><textarea id="mode_html4" style="width: 790px;height: 300px;" ><% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_content()!=null){out.print(smlist.get(3).getShopmodel_content());} %></textarea>
    <br/>
    </div>
    <div id="mode_list4" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_type()!=null&&smlist.get(3).getShopmodel_type()!=2)||(smlist==null||smlist.size()<4)) out.print("display:none;");  %>">
        &nbsp;&nbsp;请输入模块背景颜色值：#<input type="text" id="mode_titile4" value="<% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_title()!=null) out.print(smlist.get(3).getShopmodel_title()); %>"></input>
   		&nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt4" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_txt()!=null) out.print(smlist.get(3).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor4" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_txtcolor()!=null) out.print(smlist.get(3).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore4" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_txtmore()!=null) out.print(smlist.get(3).getShopmodel_txtmore()); %>"></input>
     <br/>  显示商品数：<input id="mode_gdsnum4" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null) out.print(smlist.get(3).getShopmodel_gdsnum()!=null?smlist.get(3).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
     
        &nbsp;&nbsp;请选择图片尺寸：<select id="mode_tpcc4">
        		<option value="14" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_size()!=null&&smlist.get(3).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst4" name="mode_gdsmst4" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_list()!=null){out.print(smlist.get(3).getShopmodel_list());} %>
    </textarea><br/>  
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname4" name="shopmodel_balname4" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_balname()!=null) out.print(smlist.get(3).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon4" onclick="changlayertitle(0,4);" value="0" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_balloon()!=null&&smlist.get(3).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon4" onclick="changlayertitle(1,4);" value="1" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_balloon()!=null&&smlist.get(3).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon4" onclick="changlayertitle(2,4);" value="2" <% if(smlist!=null&&smlist.size()>3&&smlist.get(3)!=null&&smlist.get(3).getShopmodel_balloon()!=null&&smlist.get(3).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag4" value="4"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div>  
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('4')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块四结束 -->
   <tr><td height="15"></td></tr>
   <!-- 模块五-->
   <tr id="mode_5" <% if(smlist!=null&&smlist.size()>4) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('5')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid5" value="<% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getId()!=null) out.print(smlist.get(4).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type5" onchange="changes(this,'5')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_type()!=null&&smlist.get(4).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_type()!=null&&smlist.get(4).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag5">
                        <option value="0" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_flag()!=null&&smlist.get(4).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_flag()!=null&&smlist.get(4).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" >
              请输入排序值：<input id="mode_seq5" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_sort()!=null) out.print(smlist.get(4).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h5" style="background:#fff;<% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_type()!=null&&smlist.get(4).getShopmodel_type()!=1) out.print("display:none;"); %>">
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <br/><textarea id="mode_html5" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_content()!=null){out.print(smlist.get(4).getShopmodel_content());} %>
    </textarea><br/>
    </div>
    <div id="mode_list5" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_type()!=null&&smlist.get(4).getShopmodel_type()!=2)||(smlist==null||smlist.size()<5)) out.print("display:none;");  %>">
      &nbsp;&nbsp;请输入模块背景颜色值：#<input type="text" id="mode_titile5" value="<% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_title()!=null) out.print(smlist.get(4).getShopmodel_title()); %>"></input>
     &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt5" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_txt()!=null) out.print(smlist.get(4).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor5" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_txtcolor()!=null) out.print(smlist.get(4).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore5" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_txtmore()!=null) out.print(smlist.get(4).getShopmodel_txtmore()); %>"></input>
     <br/>  显示商品数：<input id="mode_gdsnum5" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null) out.print(smlist.get(4).getShopmodel_gdsnum()!=null?smlist.get(4).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
     
     &nbsp;&nbsp; 请选择图片尺寸：<select id="mode_tpcc5">
     			<option value="14" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_size()!=null&&smlist.get(4).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst5" name="mode_gdsmst5" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_list()!=null){out.print(smlist.get(4).getShopmodel_list());} %>
    </textarea><br /> 
     &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname5" name="shopmodel_balname5" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_balname()!=null) out.print(smlist.get(4).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon5" onclick="changlayertitle(0,5);" value="0" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_balloon()!=null&&smlist.get(4).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon5" onclick="changlayertitle(1,5);" value="1" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_balloon()!=null&&smlist.get(4).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon5" onclick="changlayertitle(2,5);" value="2" <% if(smlist!=null&&smlist.size()>4&&smlist.get(4)!=null&&smlist.get(4).getShopmodel_balloon()!=null&&smlist.get(4).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag5" value="5"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div>  
    </td></tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('5')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块五结束 -->
   <tr><td height="15"></td></tr>
    <!-- 模块六-->
   <tr id="mode_6" <% if(smlist!=null&&smlist.size()>5) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('6')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a> 
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid6" value="<% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getId()!=null) out.print(smlist.get(5).getId()); %>"></input>
       &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type6" onchange="changes(this,'6')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_type()!=null&&smlist.get(5).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_type()!=null&&smlist.get(5).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag6">
                        <option value="0" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_flag()!=null&&smlist.get(5).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_flag()!=null&&smlist.get(5).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%">
              请输入排序值：<input id="mode_seq6" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_sort()!=null) out.print(smlist.get(5).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h6" style="background:#fff;<% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_type()!=null&&smlist.get(5).getShopmodel_type()!=1) out.print("display:none;"); %>">
   <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <br/><textarea id="mode_html6" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_content()!=null){out.print(smlist.get(5).getShopmodel_content());} %>
    </textarea><br/>
    </div>
    <div id="mode_list6" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_type()!=null&&smlist.get(5).getShopmodel_type()!=2)||(smlist==null||smlist.size()<6)) out.print("display:none;");  %>">
     &nbsp;&nbsp; 请输入模块背景颜色值：#<input type="text" id="mode_titile6" value="<% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_title()!=null) out.print(smlist.get(5).getShopmodel_title()); %>"></input>
      &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt6" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_txt()!=null) out.print(smlist.get(5).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor6" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_txtcolor()!=null) out.print(smlist.get(5).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore6" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_txtmore()!=null) out.print(smlist.get(5).getShopmodel_txtmore()); %>"></input>
     <br/>   显示商品数：<input id="mode_gdsnum6" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null) out.print(smlist.get(5).getShopmodel_gdsnum()!=null?smlist.get(5).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
     
     &nbsp;&nbsp;请选择图片尺寸：<select id="mode_tpcc6">
     			<option value="14" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_size()!=null&&smlist.get(5).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst6" name="mode_gdsmst6" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_list()!=null){out.print(smlist.get(5).getShopmodel_list());} %>
    </textarea><br/> 
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname6" name="shopmodel_balname6" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_balname()!=null) out.print(smlist.get(5).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon6" onclick="changlayertitle(0,6);" value="0" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_balloon()!=null&&smlist.get(5).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon6" onclick="changlayertitle(1,6);" value="1" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_balloon()!=null&&smlist.get(5).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon6" onclick="changlayertitle(2,6);" value="2" <% if(smlist!=null&&smlist.size()>5&&smlist.get(5)!=null&&smlist.get(5).getShopmodel_balloon()!=null&&smlist.get(5).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag6" value="6"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div> 
    </td></tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('6')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块六结束 -->
   <tr><td height="15"></td></tr>
   <!-- 模块七-->
   <tr id="mode_7" <% if(smlist!=null&&smlist.size()>6) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('7')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid7" value="<% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getId()!=null) out.print(smlist.get(6).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type7" onchange="changes(this,'7')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_type()!=null&&smlist.get(6).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_type()!=null&&smlist.get(6).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag7">
                        <option value="0" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_flag()!=null&&smlist.get(6).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_flag()!=null&&smlist.get(6).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%">
              请输入排序值：<input id="mode_seq7" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_sort()!=null) out.print(smlist.get(6).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h7" style="background:#fff;<% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_type()!=null&&smlist.get(6).getShopmodel_type()!=1) out.print("display:none;"); %>">
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <br/><textarea id="mode_html7" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_content()!=null){out.print(smlist.get(6).getShopmodel_content());} %>
    </textarea><br/>
    </div>
    <div id="mode_list7" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_type()!=null&&smlist.get(6).getShopmodel_type()!=2)||(smlist==null||smlist.size()<7)) out.print("display:none;");  %>">
      &nbsp;&nbsp;请输入模块背景颜色值：#<input type="text" id="mode_titile7" value="<% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_title()!=null) out.print(smlist.get(6).getShopmodel_title()); %>"></input>
      &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt7" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_txt()!=null) out.print(smlist.get(6).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor7" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_txtcolor()!=null) out.print(smlist.get(6).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore7" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_txtmore()!=null) out.print(smlist.get(6).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum7" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null) out.print(smlist.get(6).getShopmodel_gdsnum()!=null?smlist.get(6).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
     &nbsp;&nbsp;请选择图片尺寸：<select id="mode_tpcc7">
     			<option value="14" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_size()!=null&&smlist.get(6).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
     &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst7" name="mode_gdsmst7" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_list()!=null){out.print(smlist.get(6).getShopmodel_list());} %>
    </textarea> <br/>
     &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname7" name="shopmodel_balname7" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_balname()!=null) out.print(smlist.get(6).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon7" onclick="changlayertitle(0,7);" value="0" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_balloon()!=null&&smlist.get(6).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon7" onclick="changlayertitle(1,7);" value="1" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_balloon()!=null&&smlist.get(6).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon7" onclick="changlayertitle(2,7);" value="2" <% if(smlist!=null&&smlist.size()>6&&smlist.get(6)!=null&&smlist.get(6).getShopmodel_balloon()!=null&&smlist.get(6).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag7" value="7"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div>  
    </td></tr>
	<tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('7')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块七结束 -->
   <tr><td height="15"></td></tr>
    <!-- 模块八-->
   <tr id="mode_8" <% if(smlist!=null&&smlist.size()>7) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('8')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid8" value="<% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getId()!=null) out.print(smlist.get(7).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type8" onchange="changes(this,'8')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_type()!=null&&smlist.get(7).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_type()!=null&&smlist.get(7).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag8">
                        <option value="0" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_flag()!=null&&smlist.get(7).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_flag()!=null&&smlist.get(7).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" >  请输入排序值：<input id="mode_seq8" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_sort()!=null) out.print(smlist.get(7).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h8" style="background:#fff;<% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_type()!=null&&smlist.get(7).getShopmodel_type()!=1) out.print("display:none;"); %>">
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <br/><textarea id="mode_html8" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_content()!=null){out.print(smlist.get(7).getShopmodel_content());} %>
    </textarea><br/>
    </div>
    <div id="mode_list8" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_type()!=null&&smlist.get(7).getShopmodel_type()!=2)||(smlist==null||smlist.size()<8)) out.print("display:none;");  %>">
      &nbsp;&nbsp;请输入模块背景颜色值：#<input type="text" id="mode_titile8" value="<% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_title()!=null) out.print(smlist.get(7).getShopmodel_title()); %>"></input>
      &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt8" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_txt()!=null) out.print(smlist.get(7).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor8" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_txtcolor()!=null) out.print(smlist.get(7).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore8" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_txtmore()!=null) out.print(smlist.get(7).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum8" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null) out.print(smlist.get(7).getShopmodel_gdsnum()!=null?smlist.get(7).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
            
     &nbsp;&nbsp;请选择图片尺寸：<select id="mode_tpcc8">
     			<option value="14" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_size()!=null&&smlist.get(7).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst8" name="mode_gdsmst8" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_list()!=null){out.print(smlist.get(7).getShopmodel_list());} %>
    </textarea><br/> 
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname8" name="shopmodel_balname8" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_balname()!=null) out.print(smlist.get(7).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon8" onclick="changlayertitle(0,8);" value="0" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_balloon()!=null&&smlist.get(7).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon8" onclick="changlayertitle(1,8);" value="1" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_balloon()!=null&&smlist.get(7).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon8" onclick="changlayertitle(2,8);" value="2" <% if(smlist!=null&&smlist.size()>7&&smlist.get(7)!=null&&smlist.get(7).getShopmodel_balloon()!=null&&smlist.get(7).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag8" value="8"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div>  
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('8')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块八结束 -->
   <tr><td height="15"></td></tr>
    <!-- 模块九-->
   <tr id="mode_9" <% if(smlist!=null&&smlist.size()>8) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('9')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid9" value="<% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getId()!=null) out.print(smlist.get(8).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type9" onchange="changes(this,'9')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_type()!=null&&smlist.get(8).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_type()!=null&&smlist.get(8).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag9">
                        <option value="0" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_flag()!=null&&smlist.get(8).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_flag()!=null&&smlist.get(8).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%"> 请输入排序值：<input id="mode_seq9" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_sort()!=null) out.print(smlist.get(8).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h9" style="background:#fff;<% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_type()!=null&&smlist.get(8).getShopmodel_type()!=1) out.print("display:none;"); %>">
   <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <br/>
    <textarea id="mode_html9" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_content()!=null){out.print(smlist.get(8).getShopmodel_content());} %>
    </textarea><br/>
    </div>
    <div id="mode_list9" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_type()!=null&&smlist.get(8).getShopmodel_type()!=2)||(smlist==null||smlist.size()<9)) out.print("display:none;");  %>">
       &nbsp;&nbsp;请输入模块背景颜色值：#<input type="text" id="mode_titile9" value="<% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_title()!=null) out.print(smlist.get(8).getShopmodel_title()); %>"></input>
       &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt9" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_txt()!=null) out.print(smlist.get(8).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor9" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_txtcolor()!=null) out.print(smlist.get(8).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore9" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_txtmore()!=null) out.print(smlist.get(8).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum9" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null) out.print(smlist.get(8).getShopmodel_gdsnum()!=null?smlist.get(8).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
             &nbsp;&nbsp;请选择图片尺寸：<select id="mode_tpcc9">
     			<option value="14" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_size()!=null&&smlist.get(8).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst9" name="mode_gdsmst9" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_list()!=null){out.print(smlist.get(8).getShopmodel_list());} %>
    </textarea><br/> 
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname9" name="shopmodel_balname9" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_balname()!=null) out.print(smlist.get(8).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon9" onclick="changlayertitle(0,9);" value="0" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_balloon()!=null&&smlist.get(8).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon9" onclick="changlayertitle(1,9);" value="1" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_balloon()!=null&&smlist.get(8).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon9" onclick="changlayertitle(2,9);" value="2" <% if(smlist!=null&&smlist.size()>8&&smlist.get(8)!=null&&smlist.get(8).getShopmodel_balloon()!=null&&smlist.get(8).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag9" value="9"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div> 
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('9')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块九结束 -->
   <tr><td height="15"></td></tr>
   <!-- 模块十-->
   <tr id="mode_10" <% if(smlist!=null&&smlist.size()>9) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('10')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid10" value="<% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getId()!=null) out.print(smlist.get(9).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type10" onchange="changes(this,'10')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_type()!=null&&smlist.get(9).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_type()!=null&&smlist.get(9).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag10">
                        <option value="0" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_flag()!=null&&smlist.get(9).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_flag()!=null&&smlist.get(9).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" >  请输入排序值：<input id="mode_seq10" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_sort()!=null) out.print(smlist.get(9).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h10" style="background:#fff;<% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_type()!=null&&smlist.get(9).getShopmodel_type()!=1) out.print("display:none;"); %>">
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <textarea id="mode_html10" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_content()!=null){out.print(smlist.get(9).getShopmodel_content());} %>
    </textarea>
    </div>
    <div id="mode_list10" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_type()!=null&&smlist.get(9).getShopmodel_type()!=2)||(smlist==null||smlist.size()<10)) out.print("display:none;");  %>">
  &nbsp;&nbsp; 请输入模块背景颜色值：#<input type="text" id="mode_titile10" value="<% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_title()!=null) out.print(smlist.get(9).getShopmodel_title()); %>"></input>
   &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt10" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_txt()!=null) out.print(smlist.get(9).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor10" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_txtcolor()!=null) out.print(smlist.get(9).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore10" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_txtmore()!=null) out.print(smlist.get(9).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum10" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null) out.print(smlist.get(9).getShopmodel_gdsnum()!=null?smlist.get(9).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
            &nbsp;&nbsp; 请选择图片尺寸：<select id="mode_tpcc10">
     			<option value="14" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_size()!=null&&smlist.get(9).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst10" name="mode_gdsmst10" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_list()!=null){out.print(smlist.get(9).getShopmodel_list());} %>
    </textarea> <br />
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname10" name="shopmodel_balname10" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_balname()!=null) out.print(smlist.get(9).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon10" onclick="changlayertitle(0,10);" value="0" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_balloon()!=null&&smlist.get(9).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon10" onclick="changlayertitle(1,10);" value="1" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_balloon()!=null&&smlist.get(9).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon10" onclick="changlayertitle(2,10);" value="2" <% if(smlist!=null&&smlist.size()>9&&smlist.get(9)!=null&&smlist.get(9).getShopmodel_balloon()!=null&&smlist.get(9).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag10" value="10"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div> 
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('10')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块十结束 -->
   <tr><td height="15"></td></tr>
   <!-- 模块十一-->
   <tr id="mode_11" <% if(smlist!=null&&smlist.size()>10) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('10')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid11" value="<% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getId()!=null) out.print(smlist.get(10).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type11" onchange="changes(this,'11')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_type()!=null&&smlist.get(10).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_type()!=null&&smlist.get(10).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag11">
                        <option value="0" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_flag()!=null&&smlist.get(10).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_flag()!=null&&smlist.get(10).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" >   请输入排序值：<input id="mode_seq11" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_sort()!=null) out.print(smlist.get(10).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h11" style="background:#fff;<% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_type()!=null&&smlist.get(10).getShopmodel_type()!=1) out.print("display:none;"); %>">
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <textarea id="mode_html11" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_content()!=null){out.print(smlist.get(10).getShopmodel_content());} %>
    </textarea>
    </div>
    <div id="mode_list11" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_type()!=null&&smlist.get(10).getShopmodel_type()!=2)||(smlist==null||smlist.size()<11)) out.print("display:none;");  %>">
  &nbsp;&nbsp; 请输入模块背景颜色值：#<input type="text" id="mode_titile11" value="<% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_title()!=null) out.print(smlist.get(10).getShopmodel_title()); %>"></input>
   &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt11" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_txt()!=null) out.print(smlist.get(10).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor11" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_txtcolor()!=null) out.print(smlist.get(10).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore11" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_txtmore()!=null) out.print(smlist.get(10).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum11" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null) out.print(smlist.get(10).getShopmodel_gdsnum()!=null?smlist.get(10).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
           &nbsp;&nbsp; 请选择图片尺寸：<select id="mode_tpcc11">
     			<option value="14" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_size()!=null&&smlist.get(10).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst11" name="mode_gdsmst11" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_list()!=null){out.print(smlist.get(10).getShopmodel_list());} %>
    </textarea> <br/>
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname11" name="shopmodel_balname11" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_balname()!=null) out.print(smlist.get(10).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon11" onclick="changlayertitle(0,11);" value="0" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_balloon()!=null&&smlist.get(10).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon11" onclick="changlayertitle(1,11);" value="1" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_balloon()!=null&&smlist.get(10).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon11" onclick="changlayertitle(2,11);" value="2" <% if(smlist!=null&&smlist.size()>10&&smlist.get(10)!=null&&smlist.get(10).getShopmodel_balloon()!=null&&smlist.get(10).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag11" value="11"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div>  
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('11')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块十一结束 -->
   <tr><td height="15"></td></tr>
   <!-- 模块十二-->
   <tr id="mode_12" <% if(smlist!=null&&smlist.size()>11) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('12')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid12" value="<% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getId()!=null) out.print(smlist.get(11).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type12" onchange="changes(this,'12')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_type()!=null&&smlist.get(11).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_type()!=null&&smlist.get(11).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag12">
                        <option value="0" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_flag()!=null&&smlist.get(11).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_flag()!=null&&smlist.get(11).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" >    请输入排序值：<input id="mode_seq12" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_sort()!=null) out.print(smlist.get(11).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h12" style="background:#fff;<% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_type()!=null&&smlist.get(11).getShopmodel_type()!=1) out.print("display:none;"); %>">
   <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <textarea id="mode_html12" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_content()!=null){out.print(smlist.get(11).getShopmodel_content());} %>
    </textarea>
    </div>
    <div id="mode_list12" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_type()!=null&&smlist.get(11).getShopmodel_type()!=2)||(smlist==null||smlist.size()<12)) out.print("display:none;");  %>">
  &nbsp;&nbsp; 请输入模块背景颜色值：#<input type="text" id="mode_titile12" value="<% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_title()!=null) out.print(smlist.get(9).getShopmodel_title()); %>"></input>
   &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt12" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_txt()!=null) out.print(smlist.get(11).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor12" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_txtcolor()!=null) out.print(smlist.get(11).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore12" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_txtmore()!=null) out.print(smlist.get(11).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum12" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null) out.print(smlist.get(11).getShopmodel_gdsnum()!=null?smlist.get(11).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
          &nbsp;&nbsp; 请选择图片尺寸：<select id="mode_tpcc12">
     			<option value="14" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板/option>
                <option value="9" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_size()!=null&&smlist.get(11).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst12" name="mode_gdsmst12" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_list()!=null){out.print(smlist.get(11).getShopmodel_list());} %>
    </textarea><br/> 
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname12" name="shopmodel_balname12" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_balname()!=null) out.print(smlist.get(11).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon12" onclick="changlayertitle(0,12);" value="0" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_balloon()!=null&&smlist.get(11).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon12" onclick="changlayertitle(1,12);" value="1" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_balloon()!=null&&smlist.get(11).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon12" onclick="changlayertitle(2,12);" value="2" <% if(smlist!=null&&smlist.size()>11&&smlist.get(11)!=null&&smlist.get(11).getShopmodel_balloon()!=null&&smlist.get(11).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag12" value="12"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div>  
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('12')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块十二结束 -->
   <tr><td height="15"></td></tr>
   <!-- 模块十三-->
   <tr id="mode_13" <% if(smlist!=null&&smlist.size()>12) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('13')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid13" value="<% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getId()!=null) out.print(smlist.get(12).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type13" onchange="changes(this,'13')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_type()!=null&&smlist.get(12).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_type()!=null&&smlist.get(12).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag13">
                        <option value="0" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_flag()!=null&&smlist.get(12).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_flag()!=null&&smlist.get(12).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" >     请输入排序值：<input id="mode_seq13" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_sort()!=null) out.print(smlist.get(12).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h13" style="background:#fff;<% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_type()!=null&&smlist.get(12).getShopmodel_type()!=1) out.print("display:none;"); %>">
   <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <textarea id="mode_html13" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_content()!=null){out.print(smlist.get(12).getShopmodel_content());} %>
    </textarea>
    </div>
    <div id="mode_list13" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_type()!=null&&smlist.get(12).getShopmodel_type()!=2)||(smlist==null||smlist.size()<13)) out.print("display:none;");  %>">
  &nbsp;&nbsp; 请输入模块背景颜色值：#<input type="text" id="mode_titile13" value="<% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_title()!=null) out.print(smlist.get(12).getShopmodel_title()); %>"></input>
   &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt13" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_txt()!=null) out.print(smlist.get(12).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor13" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_txtcolor()!=null) out.print(smlist.get(12).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore13" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_txtmore()!=null) out.print(smlist.get(12).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum13" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null) out.print(smlist.get(12).getShopmodel_gdsnum()!=null?smlist.get(12).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
         &nbsp;&nbsp; 请选择图片尺寸：<select id="mode_tpcc13">
     			<option value="14" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_size()!=null&&smlist.get(12).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst13" name="mode_gdsmst13" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_list()!=null){out.print(smlist.get(12).getShopmodel_list());} %>
    </textarea> <br/>
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname13" name="shopmodel_balname13" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_balname()!=null) out.print(smlist.get(12).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon13" onclick="changlayertitle(0,13);" value="0" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_balloon()!=null&&smlist.get(12).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon13" onclick="changlayertitle(1,13);" value="1" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_balloon()!=null&&smlist.get(12).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon13" onclick="changlayertitle(2,13);" value="2" <% if(smlist!=null&&smlist.size()>12&&smlist.get(12)!=null&&smlist.get(12).getShopmodel_balloon()!=null&&smlist.get(12).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag13" value="13"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div>  
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('13')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块十三结束 -->
   <tr><td height="15"></td></tr>
   <!-- 模块十四-->
   <tr id="mode_14" <% if(smlist!=null&&smlist.size()>13) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('14')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid14" value="<% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getId()!=null) out.print(smlist.get(13).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type14" onchange="changes(this,'14')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_type()!=null&&smlist.get(13).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_type()!=null&&smlist.get(13).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag14">
                        <option value="0" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_flag()!=null&&smlist.get(13).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_flag()!=null&&smlist.get(13).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" >    请输入排序值：<input id="mode_seq14" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_sort()!=null) out.print(smlist.get(13).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h14" style="background:#fff;<% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_type()!=null&&smlist.get(13).getShopmodel_type()!=1) out.print("display:none;"); %>">
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <textarea id="mode_html14" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_content()!=null){out.print(smlist.get(13).getShopmodel_content());} %>
    </textarea>
    </div>
    <div id="mode_list14" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_type()!=null&&smlist.get(13).getShopmodel_type()!=2)||(smlist==null||smlist.size()<14)) out.print("display:none;");  %>">
  &nbsp;&nbsp; 请输入模块背景颜色值：#<input type="text" id="mode_titile14" value="<% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_title()!=null) out.print(smlist.get(13).getShopmodel_title()); %>"></input>
   &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt14" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_txt()!=null) out.print(smlist.get(13).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor14" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_txtcolor()!=null) out.print(smlist.get(13).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore14" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_txtmore()!=null) out.print(smlist.get(13).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum14" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null) out.print(smlist.get(13).getShopmodel_gdsnum()!=null?smlist.get(13).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
          &nbsp;&nbsp; 请选择图片尺寸：<select id="mode_tpcc14">
     			<option value="14" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_size()!=null&&smlist.get(13).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst14" name="mode_gdsmst14" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_list()!=null){out.print(smlist.get(13).getShopmodel_list());} %>
    </textarea><br/> 
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname14" name="shopmodel_balname14" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_balname()!=null) out.print(smlist.get(13).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon14" onclick="changlayertitle(0,14);" value="0" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_balloon()!=null&&smlist.get(13).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon14" onclick="changlayertitle(1,14);" value="1" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_balloon()!=null&&smlist.get(13).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon14" onclick="changlayertitle(2,14);" value="2" <% if(smlist!=null&&smlist.size()>13&&smlist.get(13)!=null&&smlist.get(13).getShopmodel_balloon()!=null&&smlist.get(13).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag14" value="14"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div> 
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('14')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块十四结束 -->
   <tr><td height="15"></td></tr>
   <!-- 模块十五-->
   <tr id="mode_15" <% if(smlist!=null&&smlist.size()>14) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('15')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid15" value="<% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getId()!=null) out.print(smlist.get(14).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type15" onchange="changes(this,'15')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_type()!=null&&smlist.get(14).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_type()!=null&&smlist.get(14).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag15">
                        <option value="0" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_flag()!=null&&smlist.get(14).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_flag()!=null&&smlist.get(14).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" >     请输入排序值：<input id="mode_seq15" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_sort()!=null) out.print(smlist.get(14).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h15" style="background:#fff;<% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_type()!=null&&smlist.get(14).getShopmodel_type()!=1) out.print("display:none;"); %>">
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <textarea id="mode_html15" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_content()!=null){out.print(smlist.get(14).getShopmodel_content());} %>
    </textarea>
    </div>
    <div id="mode_list15" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_type()!=null&&smlist.get(14).getShopmodel_type()!=2)||(smlist==null||smlist.size()<15)) out.print("display:none;");  %>">
  &nbsp;&nbsp; 请输入模块背景颜色值：#<input type="text" id="mode_titile15" value="<% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_title()!=null) out.print(smlist.get(14).getShopmodel_title()); %>"></input>
   &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt15" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_txt()!=null) out.print(smlist.get(14).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor15" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_txtcolor()!=null) out.print(smlist.get(14).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore15" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_txtmore()!=null) out.print(smlist.get(14).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum15" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null) out.print(smlist.get(14).getShopmodel_gdsnum()!=null?smlist.get(14).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
         &nbsp;&nbsp; 请选择图片尺寸：<select id="mode_tpcc15">
     			<option value="14" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_size()!=null&&smlist.get(14).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst15" name="mode_gdsmst15" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_list()!=null){out.print(smlist.get(14).getShopmodel_list());} %>
    </textarea><br/> 
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname15" name="shopmodel_balname15" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_balname()!=null) out.print(smlist.get(14).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon15" onclick="changlayertitle(0,15);" value="0" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_balloon()!=null&&smlist.get(14).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon15" onclick="changlayertitle(1,15);" value="1" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_balloon()!=null&&smlist.get(14).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon15" onclick="changlayertitle(2,15);" value="2" <% if(smlist!=null&&smlist.size()>14&&smlist.get(14)!=null&&smlist.get(14).getShopmodel_balloon()!=null&&smlist.get(14).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag15" value="15"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div> 
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('15')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块十五结束 -->
   <tr><td height="15"></td></tr>
   <!-- 模块十六-->
   <tr id="mode_16" <% if(smlist!=null&&smlist.size()>15) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('16')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid16" value="<% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getId()!=null) out.print(smlist.get(15).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type16" onchange="changes(this,'16')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_type()!=null&&smlist.get(15).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_type()!=null&&smlist.get(15).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag16">
                        <option value="0" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_flag()!=null&&smlist.get(15).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_flag()!=null&&smlist.get(15).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" >   请输入排序值：<input id="mode_seq16" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_sort()!=null) out.print(smlist.get(15).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h16" style="background:#fff;<% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_type()!=null&&smlist.get(15).getShopmodel_type()!=1) out.print("display:none;"); %>">
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <textarea id="mode_html16" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_content()!=null){out.print(smlist.get(15).getShopmodel_content());} %>
    </textarea>
    </div>
    <div id="mode_list16" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_type()!=null&&smlist.get(15).getShopmodel_type()!=2)||(smlist==null||smlist.size()<16)) out.print("display:none;");  %>">
  &nbsp;&nbsp; 请输入模块背景颜色值：#<input type="text" id="mode_titile16" value="<% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_title()!=null) out.print(smlist.get(15).getShopmodel_title()); %>"></input>
   &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt16" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_txt()!=null) out.print(smlist.get(15).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor16" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_txtcolor()!=null) out.print(smlist.get(15).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore16" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_txtmore()!=null) out.print(smlist.get(15).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum16" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null) out.print(smlist.get(15).getShopmodel_gdsnum()!=null?smlist.get(15).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
           &nbsp;&nbsp; 请选择图片尺寸：<select id="mode_tpcc16">
     			<option value="14" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_size()!=null&&smlist.get(15).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst16" name="mode_gdsmst16" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_list()!=null){out.print(smlist.get(15).getShopmodel_list());} %>
    </textarea><br/> 
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname16" name="shopmodel_balname16" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_balname()!=null) out.print(smlist.get(15).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon16" onclick="changlayertitle(0,16);" value="0" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_balloon()!=null&&smlist.get(15).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon16" onclick="changlayertitle(1,16);" value="1" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_balloon()!=null&&smlist.get(15).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon16" onclick="changlayertitle(2,16);" value="2" <% if(smlist!=null&&smlist.size()>15&&smlist.get(15)!=null&&smlist.get(15).getShopmodel_balloon()!=null&&smlist.get(15).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag16" value="16"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div> 
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('16')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块十六结束 -->
   <tr><td height="15"></td></tr>
   <!-- 模块十七-->
   <tr id="mode_17" <% if(smlist!=null&&smlist.size()>16) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('17')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid17" value="<% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getId()!=null) out.print(smlist.get(16).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type17" onchange="changes(this,'17')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_type()!=null&&smlist.get(16).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_type()!=null&&smlist.get(16).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag17">
                        <option value="0" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_flag()!=null&&smlist.get(16).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_flag()!=null&&smlist.get(16).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" >   请输入排序值：<input id="mode_seq17" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_sort()!=null) out.print(smlist.get(16).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h17" style="background:#fff;<% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_type()!=null&&smlist.get(9).getShopmodel_type()!=1) out.print("display:none;"); %>">
  <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <textarea id="mode_html17" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_content()!=null){out.print(smlist.get(16).getShopmodel_content());} %>
    </textarea>
    </div>
    <div id="mode_list17" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_type()!=null&&smlist.get(16).getShopmodel_type()!=2)||(smlist==null||smlist.size()<17)) out.print("display:none;");  %>">
  &nbsp;&nbsp; 请输入模块背景颜色值：#<input type="text" id="mode_titile17" value="<% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_title()!=null) out.print(smlist.get(16).getShopmodel_title()); %>"></input>
   &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt17" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_txt()!=null) out.print(smlist.get(16).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor17" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_txtcolor()!=null) out.print(smlist.get(16).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore17" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_txtmore()!=null) out.print(smlist.get(16).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum17" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null) out.print(smlist.get(16).getShopmodel_gdsnum()!=null?smlist.get(16).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
           &nbsp;&nbsp; 请选择图片尺寸：<select id="mode_tpcc17">
     			<option value="14" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_size()!=null&&smlist.get(16).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst17" name="mode_gdsmst17" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_list()!=null){out.print(smlist.get(16).getShopmodel_list());} %>
    </textarea><br/> 
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname17" name="shopmodel_balname17" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_balname()!=null) out.print(smlist.get(16).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon17" onclick="changlayertitle(0,17);" value="0" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_balloon()!=null&&smlist.get(16).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon17" onclick="changlayertitle(1,17);" value="1" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_balloon()!=null&&smlist.get(16).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon17" onclick="changlayertitle(2,17);" value="2" <% if(smlist!=null&&smlist.size()>16&&smlist.get(16)!=null&&smlist.get(16).getShopmodel_balloon()!=null&&smlist.get(16).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag17" value="17"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div> 
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('17')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块十七结束 -->
   <tr><td height="15"></td></tr>
   <!-- 模块十八-->
   <tr id="mode_18" <% if(smlist!=null&&smlist.size()>17) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('18')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid18" value="<% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getId()!=null) out.print(smlist.get(17).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type18" onchange="changes(this,'18')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_type()!=null&&smlist.get(17).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_type()!=null&&smlist.get(17).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag18">
                        <option value="0" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_flag()!=null&&smlist.get(17).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_flag()!=null&&smlist.get(17).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" >  请输入排序值：<input id="mode_seq18" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_sort()!=null) out.print(smlist.get(17).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h18" style="background:#fff;<% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_type()!=null&&smlist.get(17).getShopmodel_type()!=1) out.print("display:none;"); %>">
   <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <textarea id="mode_html18" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_content()!=null){out.print(smlist.get(17).getShopmodel_content());} %>
    </textarea>
    </div>
    <div id="mode_list18" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_type()!=null&&smlist.get(17).getShopmodel_type()!=2)||(smlist==null||smlist.size()<18)) out.print("display:none;");  %>">
  &nbsp;&nbsp; 请输入模块背景颜色值：#<input type="text" id="mode_titile18" value="<% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_title()!=null) out.print(smlist.get(17).getShopmodel_title()); %>"></input>
   &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt18" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_txt()!=null) out.print(smlist.get(17).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor18" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_txtcolor()!=null) out.print(smlist.get(17).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore18" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_txtmore()!=null) out.print(smlist.get(17).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum18" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null) out.print(smlist.get(17).getShopmodel_gdsnum()!=null?smlist.get(17).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
            &nbsp;&nbsp; 请选择图片尺寸：<select id="mode_tpcc18">
     			<option value="14" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_size()!=null&&smlist.get(17).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst18" name="mode_gdsmst18" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_list()!=null){out.print(smlist.get(17).getShopmodel_list());} %>
    </textarea><br/> 
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname18" name="shopmodel_balname18" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_balname()!=null) out.print(smlist.get(17).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon18" onclick="changlayertitle(0,18);" value="0" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_balloon()!=null&&smlist.get(17).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon18" onclick="changlayertitle(1,18);" value="1" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_balloon()!=null&&smlist.get(17).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon18" onclick="changlayertitle(2,18);" value="2" <% if(smlist!=null&&smlist.size()>17&&smlist.get(17)!=null&&smlist.get(17).getShopmodel_balloon()!=null&&smlist.get(17).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag18" value="18"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div>
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('18')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块十八结束 -->
   <tr><td height="15"></td></tr>
   <!-- 模块十九-->
   <tr id="mode_19" <% if(smlist!=null&&smlist.size()>18) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('19')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid19" value="<% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getId()!=null) out.print(smlist.get(18).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type19" onchange="changes(this,'19')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_type()!=null&&smlist.get(18).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_type()!=null&&smlist.get(18).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag19">
                        <option value="0" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_flag()!=null&&smlist.get(18).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_flag()!=null&&smlist.get(18).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" >请输入排序值：<input id="mode_seq19" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_sort()!=null) out.print(smlist.get(18).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h19" style="background:#fff;<% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_type()!=null&&smlist.get(18).getShopmodel_type()!=1) out.print("display:none;"); %>">
   <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <textarea id="mode_html19" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_content()!=null){out.print(smlist.get(18).getShopmodel_content());} %>
    </textarea>
    </div>
    <div id="mode_list19" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_type()!=null&&smlist.get(18).getShopmodel_type()!=2)||(smlist==null||smlist.size()<19)) out.print("display:none;");  %>">
  &nbsp;&nbsp; 请输入模块背景颜色值：#<input type="text" id="mode_titile19" value="<% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_title()!=null) out.print(smlist.get(18).getShopmodel_title()); %>"></input>
   &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt19" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_txt()!=null) out.print(smlist.get(18).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor19" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_txtcolor()!=null) out.print(smlist.get(18).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore19" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_txtmore()!=null) out.print(smlist.get(18).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum19" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null) out.print(smlist.get(18).getShopmodel_gdsnum()!=null?smlist.get(18).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
              &nbsp;&nbsp; 请选择图片尺寸：<select id="mode_tpcc19">
     			<option value="14" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_size()!=null&&smlist.get(18).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst19" name="mode_gdsmst19" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_list()!=null){out.print(smlist.get(18).getShopmodel_list());} %>
    </textarea><br/> 
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname19" name="shopmodel_balname19" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_balname()!=null) out.print(smlist.get(18).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon18" onclick="changlayertitle(0,19);" value="0" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_balloon()!=null&&smlist.get(18).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon19" onclick="changlayertitle(1,19);" value="1" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_balloon()!=null&&smlist.get(18).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon19" onclick="changlayertitle(2,19);" value="2" <% if(smlist!=null&&smlist.size()>18&&smlist.get(18)!=null&&smlist.get(18).getShopmodel_balloon()!=null&&smlist.get(18).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag19" value="19"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div>
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('19')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块十九结束 -->
    <tr><td height="15"></td></tr>
   <!-- 模块二十-->
   <tr id="mode_20" <% if(smlist!=null&&smlist.size()>19) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('20')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid20" value="<% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getId()!=null) out.print(smlist.get(19).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type20" onchange="changes(this,'20')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_type()!=null&&smlist.get(19).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_type()!=null&&smlist.get(19).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag20">
                        <option value="0" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_flag()!=null&&smlist.get(19).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_flag()!=null&&smlist.get(19).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" >请输入排序值：<input id="mode_seq20" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_sort()!=null) out.print(smlist.get(19).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h20" style="background:#fff;<% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_type()!=null&&smlist.get(19).getShopmodel_type()!=1) out.print("display:none;"); %>">
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <textarea id="mode_html20" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_content()!=null){out.print(smlist.get(19).getShopmodel_content());} %>
    </textarea>
    </div>
    <div id="mode_list20" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_type()!=null&&smlist.get(19).getShopmodel_type()!=2)||(smlist==null||smlist.size()<20)) out.print("display:none;");  %>">
  &nbsp;&nbsp; 请输入模块背景颜色值：#<input type="text" id="mode_titile20" value="<% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_title()!=null) out.print(smlist.get(19).getShopmodel_title()); %>"></input>
   &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt20" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_txt()!=null) out.print(smlist.get(19).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor20" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_txtcolor()!=null) out.print(smlist.get(19).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore20" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_txtmore()!=null) out.print(smlist.get(19).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum20" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null) out.print(smlist.get(19).getShopmodel_gdsnum()!=null?smlist.get(19).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
              &nbsp;&nbsp; 请选择图片尺寸：<select id="mode_tpcc20">
     			<option value="14" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_size()!=null&&smlist.get(19).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst20" name="mode_gdsmst20" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_list()!=null){out.print(smlist.get(19).getShopmodel_list());} %>
    </textarea><br/> 
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname20" name="shopmodel_balname20" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_balname()!=null) out.print(smlist.get(19).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon20" onclick="changlayertitle(0,20);" value="0" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_balloon()!=null&&smlist.get(19).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon20" onclick="changlayertitle(1,20);" value="1" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_balloon()!=null&&smlist.get(19).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon20" onclick="changlayertitle(2,20);" value="2" <% if(smlist!=null&&smlist.size()>19&&smlist.get(19)!=null&&smlist.get(19).getShopmodel_balloon()!=null&&smlist.get(19).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag20" value="20"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div>
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('20')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块二十结束 -->
    <tr><td height="15"></td></tr>
   <!-- 模块二十一-->
   <tr id="mode_21" <% if(smlist!=null&&smlist.size()>20) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('21')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid21" value="<% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getId()!=null) out.print(smlist.get(20).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type21" onchange="changes(this,'21')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_type()!=null&&smlist.get(20).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_type()!=null&&smlist.get(20).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag21">
                        <option value="0" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_flag()!=null&&smlist.get(20).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_flag()!=null&&smlist.get(20).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" > 请输入排序值：<input id="mode_seq21" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_sort()!=null) out.print(smlist.get(20).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h21" style="background:#fff;<% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_type()!=null&&smlist.get(20).getShopmodel_type()!=1) out.print("display:none;"); %>">
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <textarea id="mode_html21" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_content()!=null){out.print(smlist.get(20).getShopmodel_content());} %>
    </textarea>
    </div>
    <div id="mode_list21" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_type()!=null&&smlist.get(20).getShopmodel_type()!=2)||(smlist==null||smlist.size()<21)) out.print("display:none;");  %>">
  &nbsp;&nbsp; 请输入模块背景颜色值：#<input type="text" id="mode_titile21" value="<% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_title()!=null) out.print(smlist.get(20).getShopmodel_title()); %>"></input>
   &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt21" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_txt()!=null) out.print(smlist.get(20).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor21" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_txtcolor()!=null) out.print(smlist.get(20).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore21" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_txtmore()!=null) out.print(smlist.get(20).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum21" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null) out.print(smlist.get(20).getShopmodel_gdsnum()!=null?smlist.get(20).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
             &nbsp;&nbsp; 请选择图片尺寸：<select id="mode_tpcc21">
     			<option value="14" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_size()!=null&&smlist.get(20).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst21" name="mode_gdsmst21" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_list()!=null){out.print(smlist.get(20).getShopmodel_list());} %>
    </textarea><br/> 
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname21" name="shopmodel_balname21" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_balname()!=null) out.print(smlist.get(20).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon21" onclick="changlayertitle(0,21);" value="0" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_balloon()!=null&&smlist.get(20).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon21" onclick="changlayertitle(1,21);" value="1" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_balloon()!=null&&smlist.get(20).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon21" onclick="changlayertitle(2,21);" value="2" <% if(smlist!=null&&smlist.size()>20&&smlist.get(20)!=null&&smlist.get(20).getShopmodel_balloon()!=null&&smlist.get(20).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag21" value="21"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div>
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('21')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块二十一结束 -->
    <tr><td height="15"></td></tr>
   <!-- 模块二十二-->
   <tr id="mode_22" <% if(smlist!=null&&smlist.size()>21) out.print("style=\"display:block\""); else  out.print("style=\"display:none\""); %>>
   <td><table cellspacing="0" cellpadding="0" border="0" width="832" height="100%">
   <tr style="background:#f0f0f0; height:40px;"><td width="50%" style="border:solid 1px #ccc;border-right:none;">&nbsp;&nbsp;&nbsp;&nbsp;自定义模块</td>
   <td align="right" style="border:solid 1px #ccc;border-left:none;"><a href="javascript:void(0)" onclick="DeleteModeDetail('22')" ><img src="http://images.d1.com.cn/zt2013/icon/delete2.png"/></a>  
   </td>
   </tr> 
   <tr><td colspan="2" style="border:solid 1px #ccc;border-top:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#d8eef9;font-size:12px;">
        <tr><td width="34%" style="border-right:solid 1px #fff;"><input type="hidden" id="hmodeid22" value="<% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getId()!=null) out.print(smlist.get(21).getId()); %>"></input>
      &nbsp;&nbsp;请选择模块显示方式：<select id="mode_type22" onchange="changes(this,'22')">
                        <option value="1" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_type()!=null&&smlist.get(21).getShopmodel_type()==1) out.print("selected"); %> >图文编辑框</option>
                        <option value="2" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_type()!=null&&smlist.get(21).getShopmodel_type()==2) out.print("selected"); %>>商品推荐</option>
                     </select></td>
              <td width="33%" style="border-right:solid 1px #fff;">是否发布：<select id="mode_flag22">
                        <option value="0" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_flag()!=null&&smlist.get(21).getShopmodel_flag()==0) out.print("selected"); %>>未发布</option>
                        <option value="1" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_flag()!=null&&smlist.get(21).getShopmodel_flag()==1) out.print("selected"); %>>已发布</option>
                     </select></td>
              <td width="33%" >   请输入排序值：<input id="mode_seq22" type="text" style="width:50px;" value="<% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_sort()!=null) out.print(smlist.get(21).getShopmodel_sort()); %>"></input>                  
   </td></tr>
   <tr><td colspan="3" align="center">
   <div id="mode_h22" style="background:#fff;<% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_type()!=null&&smlist.get(21).getShopmodel_type()!=1) out.print("display:none;"); %>">
    <div style="color:red">用${1234}格式可以获取推荐位的列表，1234为推荐位的id。</div>
    <textarea id="mode_html22" style="width: 790px;height: 300px;"><% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_content()!=null){out.print(smlist.get(21).getShopmodel_content());} %>
    </textarea>
    </div>
    <div id="mode_list22" style="font-size:12px;text-align:left;<% if((smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_type()!=null&&smlist.get(21).getShopmodel_type()!=2)||(smlist==null||smlist.size()<22)) out.print("display:none;");  %>">
  &nbsp;&nbsp; 请输入模块背景颜色值：#<input type="text" id="mode_titile22" value="<% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_title()!=null) out.print(smlist.get(21).getShopmodel_title()); %>"></input>
   &nbsp;&nbsp;<span class="model_txt">模块标题：<input type="text" id="mode_txt22" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_txt()!=null) out.print(smlist.get(21).getShopmodel_txt()); %>"></input></span>
      &nbsp;&nbsp;<span class="model_txtcolor">标题颜色：#<input class="color_width" type="text" id="mode_txtcolor22" style="background:#fff;" value="<% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_txtcolor()!=null) out.print(smlist.get(21).getShopmodel_txtcolor()); %>"></input></span>
      <br/>
      &nbsp;&nbsp;标题点击链接：<input type="text" id="mode_txtmore22" style="background:#fff;width: 463px;" value="<% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_txtmore()!=null) out.print(smlist.get(21).getShopmodel_txtmore()); %>"></input>
     <br/>显示商品数：<input id="mode_gdsnum22" type="text" style="width:30px;background:#fff;" value="<% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null) out.print(smlist.get(21).getShopmodel_gdsnum()!=null?smlist.get(21).getShopmodel_gdsnum().longValue():0); %>" />&nbsp;&nbsp;
           &nbsp;&nbsp; 请选择图片尺寸：<select id="mode_tpcc22">
     			<option value="14" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==14) out.print("selected"); %>>粉色疯抢：200*200*4</option>
                <option value="15" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==15) out.print("selected"); %>>粉色疯抢：200*250*4</option>
                <option value="16" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==16) out.print("selected"); %>>粉色疯抢：240*300*3</option>
                <option value="1" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==1) out.print("selected"); %>>200*200每排四个商品</option>
                <option value="2" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==2) out.print("selected"); %>>160*160每排五个商品</option>
                <option value="3" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==3) out.print("selected"); %>>200*250每排四个商品</option>
                <option value="4" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==4) out.print("selected"); %>>240*300每排四个商品</option>
                <option value="5" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==5) out.print("selected"); %>>240*300每排三个商品</option>
                <option value="6" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==6) out.print("selected"); %>>160*200每排四个商品</option>
                <option value="7" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==7) out.print("selected"); %>>240*300*4/行春节模板</option>
                <option value="8" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==8) out.print("selected"); %>>200*250*4/行春节模板</option>
                <option value="9" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==9) out.print("selected"); %>>200*200*4/行春节模板</option>
                <option value="10" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==10) out.print("selected"); %>>200*200*4/行默认模板</option>
                <option value="11" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==11) out.print("selected"); %>>200*250*4/行默认模板</option>
                <option value="12" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==12) out.print("selected"); %>>240*300*4/行默认模板</option>
                <option value="13" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_size()!=null&&smlist.get(21).getShopmodel_size()==13) out.print("selected"); %>>160*160*4/行默认模板</option>
                </select>
                <br/>
    &nbsp;&nbsp;<textarea rows="2" id="mode_gdsmst22" name="mode_gdsmst22" 
        style="border:solid 1px #d4d4d4;background:#f8f8f8; width:700px;"><% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_list()!=null){out.print(smlist.get(21).getShopmodel_list());} %>
    </textarea><br/> 
    &nbsp;&nbsp;浮层文字：
    <textarea id="shopmodel_balname22" name="shopmodel_balname22" cols="35" rows="3"><% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_balname()!=null) out.print(smlist.get(21).getShopmodel_balname()); %></textarea>
    <br />
    &nbsp;&nbsp;浮层图片：  
    <input type="radio" name="shopmodel_balloon22" onclick="changlayertitle(0,22);" value="0" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_balloon()!=null&&smlist.get(21).getShopmodel_balloon()==0) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/redimg1.png"/></input>
    <input type="radio" name="shopmodel_balloon22" onclick="changlayertitle(1,22);" value="1" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_balloon()!=null&&smlist.get(21).getShopmodel_balloon()==1) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/greenimg2.png"></input>
    <input type="radio" name="shopmodel_balloon22" onclick="changlayertitle(2,22);" value="2" <% if(smlist!=null&&smlist.size()>21&&smlist.get(21)!=null&&smlist.get(21).getShopmodel_balloon()!=null&&smlist.get(21).getShopmodel_balloon()==2) out.print("checked='checked'"); %>><img src="http://images.d1.com.cn/images/orangeimg3.png"></input>
    <br />
    &nbsp;<input type="checkbox" name="tm_flag22" value="22"/>商品秒杀起止时间和特卖会起止时间一致
    <font style="color: red;">（系统将自动帮您把秒杀时间和特卖会起止时间不一致的商品，全部统一修改为特卖会起止时间）</font>
    <br />
    </div>
    </td>
    </tr>
    <tr><td colspan="3" style="background:#fff;" align="center">
                <a href="javascript:void(0)" onclick="AddModeDetail('22')" ><img src="http://images.d1.com.cn/zt2013/icon/save2.png"/></a> 
   
                </td></tr>
      </table>
   </td></tr>
   </table>   
   </td>
   </tr>
   <!-- 模块二十二结束 -->
   
    </table> 
</td>
</tr>
</table>
</form>
</div>
</body>
</html>
<script type="text/javascript">

function sgimgact(){
	 $("#sgupload").uploadify({
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
					$('#spzt6').html('');
					$('#spzt6').append("<img src='"+sgimgurl+"' />");
					$('#hsgimg').val('http://images1.d1.com.cn'+sg_arr[0]);
	    	   }					   
	       }

		});
}
sgimgact();
SCTPinit();
$(pageInit);
function pageInit()
{  
 $('#mode_html1').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#sh_logo').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#bgimg').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html2').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html3').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html4').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html5').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html6').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html7').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html8').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html9').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html10').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html11').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html12').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html13').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html14').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html15').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html16').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html17').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html18').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html19').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html20').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html21').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#mode_html22').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});

 $('#floatcontent').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
 $('#sh_zpimg').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
}
function submitForm(){$('#form1').submit();}
function changlayertitle(adr,type){
	if(adr < 4){//前三个爆炸图中的文字是一样的
		var shopmodel_balloon = $("input[name='shopmodel_balloon"+type+"']:checked").val();
		$('#shopmodel_balname'+type).text("<font color=#ffffff style=font-size:14pt>第一行<br><font style=font-size:14pt>第二行</font></font>");
	}
}

  </script>
