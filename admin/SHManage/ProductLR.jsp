<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%@include file="/admin/public.jsp"%>
<%
if(session.getAttribute("type_flag")!=null){
	String userid = "";
	if(session.getAttribute("admin_mng") != null){
		userid = session.getAttribute("admin_mng").toString();
	}
	String powername = "d1shop_gdsadd";
	boolean is_power = chk_admpower(userid,powername);
	if(!is_power){
		out.print("对不起，您没有操作权限！");
		return;	
	}
}
%>

<%!public static List<ShopRck> getShopRckList(String shopcode,int parentid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("shoprck_shopcode", shopcode));
	listRes.add(Restrictions.eq("shoprck_parentid", new Long(parentid)));
	List<Order> olist= new ArrayList<Order>();
	olist.add(Order.asc("shoprck_seq"));
	List list = Tools.getManager(ShopRck.class).getList(listRes, olist, 0, 200);	
	if(list == null || list.isEmpty()) return null;	
	return list;
} %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    basePath = basePath.substring(0, (basePath.lastIndexOf("/") == basePath.length() - 1) ? basePath.lastIndexOf("/") : basePath.length());

session.setAttribute("basePath",basePath+"/");
//获取当前时间
String now=Tools.getDate();
%>
<%!  
    private ArrayList<Directory> GetRacklistByRockcode(String Rackcode)
    {
	   ArrayList<Directory> dirlist=new ArrayList<Directory>();
	   dirlist=DirectoryHelper.getByParentcode(Rackcode);
	   return dirlist;	
    }

private ShpMst getshpmst(String shopcode){
	ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(shopcode);
	
	return shpmst;
}
public static List<Provider> getProvideList(String gdsmst_rackcode){
	if(Tools.isNull(gdsmst_rackcode)) return null;
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.like("provide_workscope", "%"+gdsmst_rackcode+"%"));
	listRes.add(Restrictions.eq("provide_status", new Long(1)));
	List<Order> olist= new ArrayList<Order>();
	olist.add(Order.asc("provide_createdate"));
	List list = Tools.getManager(Provider.class).getList(listRes, olist, 0, 200);	
	if(list == null || list.isEmpty()) return null;	
	return list;
}
%>

<% 
String gdsmst_rackcode="";
String act= request.getParameter("act");
if("form_search".equals(act)){
	if(!Tools.isNull(request.getParameter("gdsmst_rackcode"))){
		 gdsmst_rackcode = request.getParameter("gdsmst_rackcode").substring(0, 3);
	
	List<Provider> provide_list=getProvideList(gdsmst_rackcode);
	String str = "";
	if(provide_list!=null&&provide_list.size()>0){
		for(Provider pro:provide_list){
			if(pro!=null){
			    str += "<option value="+pro.getProvide_shopcode()+">"+pro.getProvide_shopcode()+"-"+pro.getProvide_name()+"</option>";
			}
		}
	}
	out.print(str);
	return;
	}
}
 %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新建商品</title>
<script src="/res/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/ShopMJS.js?"+System.currentTimeMillis())%>"></script>

<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/SHPageCss.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css"  />

<script type="text/javascript" src="/d1xheditor/xheditor-zh-cn.min.js"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/uploadify/swfobject.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/uploadify/jquery.uploadify.v2.1.4.js")%>"></script>
<script type="text/javascript" src="/res/js/DatePicker/WdatePicker.js"></script>
<link type="text/css" href="/res/js/DatePicker/skin/whyGreen/datepicker.css" rel="stylesheet" />
<style type="text/css">
.sctpk{margin-top:5px; margin-left:20px; font-size:12px;}
.rcklin {
	border: 1px solid #449ae7;
	width:400px;
	padding:20px 0 20px 20px;
	overflow: scroll; height: 150px;}
}
</style>
</head>
<body style=" background:#fff;height:2500px;">
<%@include file="/res/js/date.js"%>
<form id="form1" name="form1" method="post" action="" target="right">
<div>
<%@include file="/admin/inc/shhead.jsp" %>
<br/>
<br/>
<table style="width:980px; margin:0px auto;" border="0" cellpadding="0" cellspacing="0">
   <tr><td width="174" style="text-align:center;" valign="top">
     <%@include file="/admin/inc/SHleftPM.jsp" %>
   </td>
   <td width="806" valign="top">
   <div id="spfl" style="display:block">
    <table width="806">
      <tr>
      <td style="text-align:center;"> 
         <img src="/admin/SHManage/images/xjsp1_title1.jpg" width="686" height="78"/>
      </td>
      </tr>
      <tr><td>
          <img src="/admin/SHManage/images/xjsp_cpfl.jpg" width="784" height="37"/>
      </td></tr>
      <tr><td>
         <div class="fl_count">
           <div style=" width:760px; height:184px;background:#deefff; ">
               <div id="level1" style="width:150px; border:solid 1px #72bdff; height:100%; float:left;background:#fff;" class="divScroll">
               <%String shpcode=session.getAttribute("shopcodelog").toString();
               ShpMst shpmst=getshpmst(shpcode);
              String shpmstrck=shpmst.getShpmst_rck();
              int gzflag=0;
              if (shpmst.getShpmst_sendtype().longValue()!=2){
            	  gzflag=1;
              }
               ArrayList<Directory> dlist=GetRacklistByRockcode("0");
                   if(dlist!=null&&dlist.size()>0)
                   {
                	  %>
                	  <ul>
                	<%for(int i=0;i<dlist.size();i++)
                	  {
                		  Directory dir=dlist.get(i); 
                		  String rootrck=dir.getId();
                		  if(!Tools.isNull(rootrck)){
                			  rootrck=rootrck.trim();
                		  }
                		  if(dir!=null&&(shpmstrck.indexOf(rootrck)>=0
                				  ||shpcode.equals("00000000")))
                		  {%>
                			  <li attr="<%= rootrck %>" attr1="<%=dir.getRakmst_rackname() %>"><span style="display:block; width:103px; float:left;"><%= dir.getRakmst_rackname()%></span><span style="display:block; width:7px; float:left;margin-top:3px;"><img src="/admin/SHManage/images/jt.jpg"/></span><div class="clear"></div></li>                			  
                		  <%}
                	  }
                	  %>
                	  </ul>
                	  <%               	  
                   }
                   
               %>
               <br/>
                <br/>
                 <br/>
                  <br/>
                   <br/> <br/>
                    <br/>
               </div>
               <div id="level2_1" style="width:5px; border:solid 1px #72bdff; border-left:none;border-right:none; height:100%; float:left;display:none; "></div>
               <div id="level2" style="width:150px; border:solid 1px #72bdff; height:100%; float:left;display:none;background:#fff; " class="divScroll"></div>
               <div id="level3_1" style="width:5px; border:solid 1px #72bdff; border-left:none;border-right:none; height:100%; float:left;display:none; "></div>
               <div id="level3" style="width:150px; border:solid 1px #72bdff; height:100%; float:left;display:none;background:#fff; " class="divScroll"></div>
               <div id="level4_1" style="width:5px; border:solid 1px #72bdff; border-left:none;border-right:none; height:100%; float:left;display:none; "></div>
               <div id="level4" style="width:150px; border:solid 1px #72bdff; height:100%; float:left;display:none;background:#fff; " class="divScroll"></div>
          
            </div>
    
      </td></tr>
      <tr><td>
       <div id="fllbl" style="background:url('/admin/SHManage/images/xjsp1_lbl.jpg') no-repeat; width:787px;height:41px;line-height:50px; color:#333;">
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您选择的产品分类是：
       <span id="lbl1" style="color:#0054b1"></span>
       <span id="lbl2" style="color:#0054b1"></span>
       <span id="lbl3" style="color:#0054b1"></span>
       <span id="lbl4" style="color:#0054b1"></span>
       </div>  
      </td></tr>
      <tr><td style="text-align:center;">
          <a href="javascript:void(0)" onclick="AddDetail()"><img src="/admin/SHManage/images/xjsp_xyb.jpg"/></a>
      </td></tr>
   </table>

  </div>
  
  <div id="spdetail" style="display:none; width:806px;">
  <table width="806">
      <tr>
      <td style="text-align:center;"> 
         <img src="/admin/SHManage/images/xjsp1_title2.jpg" width="686" height="78"/>
      </td>
      </tr>
      <tr height="55" valign="bottom" style="line-height:55px;"><td>
      <input type="hidden" id="hcode" name="hcode"/>
      <div style="width:776px; height:38px; color:#2573c5;line-height:38px; font-weight:bold;border:solid 1px #72bdfe; background:#deefff;padding:0px;margin:0px; overflow:hidden;">
            &nbsp;&nbsp;您选择的类目：<font id="lbl1_1"></font>
       <font id="lbl2_1"></font>
       <font id="lbl3_1"></font>
       <font id="lbl4_1"></font>
       <font style="color:#f00;">&nbsp;&nbsp;(*表示必填项)</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <a href="javascript:void(0)" onclick="CXChooese()"><img src="/admin/SHManage/images/cxml.png" style="vertical-align:middle;"/></a>
       <img src="/admin/SHManage/images/sjx.png" style="vertical-align:middle;"/>
        <font style="font-size:12px; color:#000; font-weight:normal;">返回重选类目会造成已填写信息丢失，请谨慎操作！</font>
      </div>
        
      </td></tr>
      <tr><td height="47" valign="bottom">
      <img src="/admin/SHManage/images/jbxx.jpg"/>
      </td></tr>
      <tr><td>
      <table style="color:#000;">
       <tr><td width="80"><font style="color:#f00">*&nbsp;&nbsp;</font>商&nbsp;品&nbsp;名&nbsp;称：</td>
       <td><input id="gdsmst_title" type="text" name="gdsmst_title"  style="width:420px; line-height:25px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"></input></td>
       </tr>
       <tr><td>&nbsp;&nbsp;&nbsp;商品副标题：</td>
       <td><input id="gdsmst_subtitle" type="text" name="gdsmst_subtitle"  style="line-height:25px;width:420px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"></input></td>
       </tr>
       <tr><td>&nbsp;&nbsp;&nbsp;品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌：</td>
       <td>
       <select id="gdsmst_pp" name="gdsmst_pp">
          
       </select>
       <!-- 
       <input id="gdsmst_pp" type="text" name="gdsmst_pp"  style="line-height:25px; width:270px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"></input></td>
        -->
       </tr>
       <tr><td><font style="color:#f00">*&nbsp;&nbsp;</font>商&nbsp;家&nbsp;编&nbsp;码：</td>
       <td><input id="gdsmst_sjbm" type="text" name="gdsmst_sjbm"  style="line-height:25px; width:270px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"></input></td>
       </tr>
       </tr>
       <tr><td><font style="color:#f00">&nbsp;&nbsp;</font>商&nbsp;品&nbsp;条&nbsp;码：</td>
       <td><input id="gdsmst_barcode" type="text" name="gdsmst_barcode"  style="line-height:25px; width:270px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"></input>国标条形码（支持EAN-13、UPC-12，例如：6917878030623）
（<span style="color:red">此字段填写后，将在微信、UC浏览器等地方扫描购买</span>）</td>
       </tr>
       <tr <%if (gzflag==0) {%>style="display:none;"<%} %>>
       <td colspan="2">
        <table style="color:#000;">
       <tr><td><font style="color:#f00">&nbsp;&nbsp;</font>采&nbsp;购&nbsp;说&nbsp;明：</td>
       <td><textarea id="gdsmst_provider" type="text" name="gdsmst_provider"  style="line-height:25px; width:400px;border:solid 1px #d4d4d4;background:#f8f8f8; height:50px;"></textarea></td>
       </tr>
       <tr><td><font style="color:#f00">&nbsp;&nbsp;</font>额&nbsp;外&nbsp;成&nbsp;本：</td>
       <td><input id="gdsmst_othercost" type="text" name="gdsmst_othercost" value="0" style="line-height:25px; width:150px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"></input>&nbsp;&nbsp;&nbsp;&nbsp;不可用券：<input type="checkbox" name="req_specialflag" value="1"></td>
       </tr>
       <!-- 供应商开始 -->
      
       <%
       String shopCode=session.getAttribute("shopcodelog").toString();
       //只有D1账户和测试账户显示供应商和其他供应商
       if(shopCode.equals("13100902") || shopCode.equals("00000000")){%>
      <tr><td width="80">&nbsp;&nbsp;供&nbsp;应&nbsp;商：</td>
       <td>
       <select id="provide" name="provide" style="width: 325px;" >
       <option value="" id="no_provide">没有供应商</option>
       </select> 
       </td>     
       </tr>
       <tr><td width="80">&nbsp;&nbsp;其他供应商：</td>
       <td>
       <textarea id="gdsmst_provideStr" type="text" name="gdsmst_provideStr"  style="line-height:25px; width:400px;border:solid 1px #d4d4d4;background:#f8f8f8; height:50px;"></textarea>
      	 多个以逗号分开,例如:00000001,00000002 
       </td>     
       </tr>
       <%}%>
       <!-- 供应商结束 -->
       </table>
       </td>
       </tr>
      </table>
      </td></tr>
      <tr><td height="47" valign="bottom">
      <img src="/admin/SHManage/images/jyxx.jpg"/>
      </td></tr>
      <tr><td>
      <table style="color:#000;">
       <tr><td width="80"><font style="color:#f00">*&nbsp;&nbsp;</font>市&nbsp;&nbsp;&nbsp;&nbsp;场&nbsp;&nbsp;&nbsp;&nbsp;价：</td>
       <td><input id="gdsmst_scj" type="text" name="gdsmst_scj"  style=" line-height:25px;width:100px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" onblur="GetZK();"></input></td>
       <td>
          &nbsp;&nbsp;&nbsp;&nbsp;<font style="color:#f00">*&nbsp;&nbsp;</font>D1&nbsp;&nbsp;价：
       </td>
       <td>
          <input id="gdsmst_d1j" type="text" name="gdsmst_d1j"  style=" line-height:25px;width:80px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"  onblur="GetZK();"></input>
    进价：<input id="gdsmst_inp" type="text" name="gdsmst_inp"  style=" line-height:25px;width:60px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="0"  onblur="GetZK();"></input>
     </td>
     <td>     
          折&nbsp;&nbsp;扣：&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td>
          <input id="gdsmst_zk" disabled ="false" type="text" name="gdsmst_zk"  style=" color:#333; line-height:25px;width:100px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"></input>
                 </td>
       </tr>
       <tr><td>&nbsp;&nbsp;&nbsp;促&nbsp;&nbsp;&nbsp;&nbsp;销&nbsp;&nbsp;&nbsp;&nbsp;价：</td>
       <td><input id="gdsmst_cxj" type="text" name="gdsmst_cxj"  style=" line-height:25px;width:100px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"></input></td>
       <td>
          &nbsp;&nbsp;&nbsp;&nbsp;<font style="color:#f00"></font>促&nbsp;销&nbsp;时&nbsp;间：
          </td>
          <td  colspan="3">
          <input id="gdsmst_begin" type="text" name="gdsmst_begin"  style=" line-height:25px;width:120px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"  onFocus="WdatePicker({isShowClear:true,readOnly:true,skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})"  >
         
          </input>
                  至
          <input id="gdsmst_end" type="text" name="gdsmst_end"  style=" line-height:25px;width:120px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"  onFocus="WdatePicker({isShowClear:true,readOnly:true,skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})" ></input>
                   </td>
                   
       </tr>
        <tr>
                   <td>&nbsp;&nbsp;&nbsp;&nbsp;产&nbsp;&nbsp;地：  </td>
                   <td  colspan="5"><input id="gdsmst_station" type="text" name="gdsmst_station"  style=" line-height:25px;width:147px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"></input>
          
       </td>
       </tr>
      </table>
      </td></tr>
      <tr><td height="47" valign="bottom">
      <img src="/admin/SHManage/images/spsx.jpg"/>
      </td></tr>
      <tr>
      <td>
      <input id="hstdid" name="hstdid" type="hidden"></input>
      <input id="hidgg" name="hidgg" type="hidden" value="<%=gzflag %>"></input>
      <div id="allgg">
     
      </div>
      </td>
      </tr>
      <tr><td height="47" valign="bottom">
      <img src="/admin/SHManage/images/tjsku.jpg"/>
      <span style="color: red;"><br/>
	    注：不分SKU商品，下拉框选择“无”，并直接填写库存。<br/>
	  &nbsp;&nbsp;&nbsp;&nbsp;区分SKU商品，下拉框选择“规格”，填写新增SKU后，再填写每个SKU库存。
	  </span>
      </td></tr>
      <tr><td>
          <table id="skutable" style="border:solid 1px #72bdff; border-bottom:none; text-align:center;" width="770" border="0" cellpadding="0" cellspacing="0">
             <tr id="bt" style="background:#deefff;">
             <th height="36" width="154" style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;">
             
             <select id="skuname" name="skuname" onchange="sku_change();">
            <option value="0" >无</option>
            <option value="规格">规格</option>
             </select>
             </th>
             <th width="154"  style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;"><b>库存</b></th>
             <th width="154"  style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;"><b>状态</b></th>
             <th width="154"  style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;"><b>库存同步</b></th>
             <th width="154"  style="border-bottom:solid 1px #72dbff;"><b>操作</b></th></tr>
          
          </table> 
          <script type="text/javascript">
			$(document).ready(function(){
				var skuname = $("#skuname").val();
				if(skuname == 0){//SKU 0无  其它代表有 
					//alert(skuname);
					$("#xz_kc").show();
					$("#xz_sku").hide();
					$("#xzsku").hide();
				}else{
					$("#xz_sku").show();
					$("#xz_kc").hide();
					$("#xzsku").show();
				} 
				//alert(skuname);
			});
			function sku_change(){
				var skuname = $("#skuname").val();
				if(skuname == 0){//SKU 0无  其它代表有 
					var kc1 = $("#kc1").val();
					//alert(kc1);
					if(typeof kc1 != 'undefined'){//库存框不为undefined，隐藏'添加库存'按钮
						$("#xz_kc").hide();
					}else{
						$("#xz_kc").show();
					}
					$("#xz_sku").hide();
					$("#xzsku").hide();//SKU无时，隐藏单选框
				}else{
					$("#xz_sku").show();
					$("#xz_kc").hide();
					$("#xzsku").show();
				} 
			}
		  </script>
          <div style="width:770px; hieght:30px;margin-top:10px; text-align:center; ">
             <table>
             <tr><td style="text-align:right">
             <input type="text" id="xzsku" name="xzsku" style="border:solid 1px #72dbff; width:300px; height:22px;"></input>
             </td>
             <td>&nbsp;&nbsp;&nbsp;&nbsp; 
             <a href="javascript:void(0)" onclick="addSku()">
             <span id="xz_sku"><img src="/admin/SHManage/images/xzsku.png" /></span>
             <span id="xz_kc"><img src="/admin/SHManage/images/xzkc.png" /></span>
             </a></td></tr>
             </table>
            
          </div>
      </td></tr>
      <tr><td height="47" valign="bottom">
      <img src="/admin/SHManage/images/cpjj.jpg"/>
      </td></tr>
      <tr><td>
      <textarea rows="5" id="gdsmst_cpjj" name="gdsmst_cpjj" style="border:solid 1px #d4d4d4;background:#f8f8f8; width:768px"></textarea>
    
      </td></tr>
      <tr><td height="47" valign="bottom">
      <img src="/admin/SHManage/images/cpms.jpg"/>
      </td></tr>
      <tr><td>
      <textarea id="elm1" name="content"  style="width: 800px;height: 400px;"></textarea>
      <div id="uploadList"></div>
      </td></tr>
      <tr><td ></br>商户分类：</br>
      <div class="rcklin">
      <%List<ShopRck> shoprcklist=getShopRckList(shpcode,0);
      if(shoprcklist!=null){
    	    for(ShopRck sprck:shoprcklist){
    	   	String shoprck_id= sprck.getId();
    	   	%>
    	   	<%=sprck.getShoprck_name() %><br />
    	   	<%
    	   	List<ShopRck> shoprcklist2=getShopRckList(shpcode,Tools.parseInt(sprck.getId()));
    	   	int parentnum=0;
    	  	 if(shoprcklist2!=null){
    	  	  parentnum=shoprcklist2.size();
    	  	
    	  	 }
    	  	if(shoprcklist2!=null){
    	   		 int inum=0;
    	        for(ShopRck sprck2:shoprcklist2){
    	       	 shoprck_id= sprck2.getId();
      %>

 <%
 if (inum+1!=parentnum){
   	 out.println("├");
    }else{
    out.println("└");
    }
 %><input type="checkbox" name="shoprck" value="<%=sprck2.getId() %>"  /><%=sprck2.getShoprck_name() %><br />

<%
inum++;
     }
     }
    }  
   }
%>
</div>
</td></tr>
 <tr><td>
<div >
 如果有同步商品会自动根据规格复制多个商品如：（白色，灰色）。这样就会自动复制为两个商品，自动加上商品组关联</br>
 <textarea name="gdsgrep" id="gdsgrep" cols="80" rows="3"></textarea>    
 </div>      
      </td></tr>
      <tr><td style="text-align:center;">
          <a href="javascript:void(0)" onclick="AddGdsmst()"><img src="/admin/SHManage/images/xjsp_bcxx.jpg"/></a>
      </td></tr>
   </table>
  </div>
  
  <div id="imagelist" name="imagelist" style="display:none;width:806px; text-align:center;">
    <table style="width:440px; margin:0px auto;overflow:hidden;">
      <tr><td style="text-align:center;">
         <img src="/admin/SHManage/images/xjsp1_title3.jpg"/>
      </td></tr>
      <tr><td><img src="/admin/SHManage/images/tpgl.jpg"/></td></tr>
      <tr><td>
        <table style="text-align:center; overflow:hidden; width:470px;">
           <tr><td>
           <div id="gdsstd"></div>
           <input type="hidden" id="hgdsid" name="hgdsid" value=""/>
           <input type="hidden" id="hstrgdsid" name="hstrgdsid" value=""/>
           <span style="color:red">图片的长宽必须要超过400像素，否则图片无法正常显示           </span></br>
              <table style="border:solid 1px #72dbff;text-align:center;" border="0" cellspacing="0" cellpadding="0">
                 <tr style="background:#deefff;"><td width="100" height="40"><b>图片</b></td><td width="80" style="text-align:center;"><b>预览</b></td>
                 <td width="100"><b>图片格式</b></td><td width="190" colspan="2"><b>操作</b></td></tr>
                 <tr style=" border-bottom:dashed 1px #999" ><td height="74" valign="middle">商品主图</td>
                 <td valign="middle"><div id="spzt" ></div></td>
                 <td valign="middle">800*800</td>
                 <td valign="middle" width="100">
                 <input type="hidden" value="800" id="hw" />
	             <input type="hidden" value="800" id="hh" />
	             <input type="hidden"  value="" id="himgurl_1" />
               <div id="fileQueue" class="sctpk" style="float:left;">
        	    <input type="file" name="uploadify" id="uploadify" /> 
      		   </div>      		   
      		   <div  id="btnupload" style="padding-left:25px;float:left;clear:both;"> </div>
                 </td>
                 <td width="50">
                 </td>
                 </tr>                 
                 <tr style=" border-bottom:dashed 1px #999" ><td height="74" valign="middle">列表图片</td>
                 <td valign="middle"><div id="spzt1" ></div></td>
                 <td valign="middle">240*300</td>
                 <td valign="middle">
                 <input type="hidden" value="240" id="hw1" />
	             <input type="hidden" value="300" id="hh1" />
	             <input type="hidden"  value="" id="himgurl1" />
               <div id="fileQueue1" class="sctpk" style="float:left;">
        	    <input type="file" name="uploadify1" id="uploadify1" /> 
      		   </div>      		   
      		   <div  id="btnupload1" style="padding-left:25px;float:left;clear:both;"> </div>
      		   </br>
      		   <span style="color:red">如果列表图片无法显示，请务必人工上传</span>
                 </td>
                  <td>
                 </td>
                 </tr>
                 <tr style=" border-bottom:dashed 1px #999" ><td height="74" valign="middle">细节图1</td>
                 <td valign="middle"><div id="spzt2" ></div></td>
                 <td valign="middle">800*800</td>
                 <td valign="middle">
                 <input type="hidden" value="800" id="hw2" />
	             <input type="hidden" value="800" id="hh2" />
	             <input type="hidden"  value="" id="himgurl2" />
               <div id="fileQueue2" class="sctpk" style="float:left;">
        	    <input type="file" name="uploadify2" id="uploadify2" /> 
      		   </div>      		   
      		   <div  id="btnupload2" style="padding-left:25px;float:left;clear:both;"> </div>
                
                 </td>
                  <td><a href="javascript:void(0)" onclick="deleteTP('2')">删除</a>
                 </td>
                 </tr>         
                 <tr style=" border-bottom:dashed 1px #999" ><td height="74" valign="middle">细节图2</td>
                 <td valign="middle"><div id="spzt3" ></div></td>
                 <td valign="middle">800*800</td>
                 <td valign="middle">
                 <input type="hidden" value="800" id="hw3" />
	             <input type="hidden" value="800" id="hh3" />
	             <input type="hidden"  value="" id="himgurl3" />
               <div id="fileQueue3" class="sctpk" style="float:left;">
        	    <input type="file" name="uploadify3" id="uploadify3" /> 
      		   </div>      		  
      		   <div  id="btnupload3" style="padding-left:25px;float:left;clear:both;"> </div>
              
                 </td>
                  <td><a href="javascript:void(0)" onclick="deleteTP('3')">删除</a>
                 </td>
                 </tr>     
               <tr style=" border-bottom:dashed 1px #999" ><td height="74" valign="middle">细节图3</td>
                 <td valign="middle"><div id="spzt4" ></div></td>
                 <td valign="middle">800*800</td>
                 <td valign="middle">
                 <input type="hidden" value="800" id="hw4" />
	             <input type="hidden" value="800" id="hh4" />
	             <input type="hidden"  value="" id="himgurl4" />
               <div id="fileQueue4" class="sctpk" style="float:left;">
        	    <input type="file" name="uploadify4" id="uploadify4" /> 
      		   </div>      		   
      		   <div  id="btnupload4" style="padding-left:25px;float:left;clear:both;"> </div>
              
                 </td>
                  <td><a href="javascript:void(0)" onclick="deleteTP('4')">删除</a>
                 </td>
                 </tr>   
                    <tr style=" border-bottom:dashed 1px #999" ><td height="74" valign="middle">细节图4</td>
                 <td valign="middle"><div id="spzt5" ></div></td>
                 <td valign="middle">800*800</td>
                 <td valign="middle">
                 <input type="hidden" value="800" id="hw5" />
	             <input type="hidden" value="800" id="hh5" />
	             <input type="hidden"  value="" id="himgurl5" />
               <div id="fileQueue5" class="sctpk" style="float:left;">
        	    <input type="file" name="uploadify5" id="uploadify5" /> 
      		   </div>      		  
      		   <div  id="btnupload5" style="padding-left:25px;float:left;clear:both;"> </div>
              
                 </td>
                  <td><a href="javascript:void(0)" onclick="deleteTP('5')">删除</a>
                 </td>
                 </tr>       
                 <tr style=" border-bottom:dashed 1px #999" ><td height="74" valign="middle">PNG平铺图</td>
                 <td valign="middle"><div id="spzt6" ></div></td>
                 <td valign="middle">300*300</td>
                 <td valign="middle">
                 <input type="hidden" value="" id="hw6" />
	             <input type="hidden" value="" id="hh6" />
	             <input type="hidden"  value="" id="himgurl6" />
               <div id="fileQueue6" class="sctpk" style="float:left;">
        	    <input type="file" name="uploadify6" id="uploadify6" /> 
      		   </div>      		  
      		   <div  id="btnupload6" style="padding-left:25px;float:left;clear:both;"> </div>
                 </td>
                  <td><a href="javascript:void(0)" onclick="deleteTP('6')">删除</a>
                 </td>
                 </tr>               
              </table>
           </td>
           
           </tr>
           <tr><td><a href="javascript:void(0)" onclick="SCTP('2')"><img src="/admin/SHManage/images/bcxx1.png"/></a>&nbsp;&nbsp;
           <a href="javascript:void(0)" onclick="SCTP('1')"><img src="/admin/SHManage/images/sjxx.png"/></a>&nbsp;&nbsp;
           <a id="ylsp" href="http://www.d1.com.cn"><img src="/admin/SHManage/images/yl.png"/></a>
           </td></tr>
        </table>
      </td></tr>
    </table>
  </div>
   </td>
   </tr>
</table>
 
</div>
</form>
</body>
</html>

<script type="text/javascript">
$(pageInit);
function pageInit()
{  
 <%if(!shpcode.equals("14051306")){%>
 $('#elm1').xheditor({localUrlTest:/^https?:\/\/[^\/]*?(d1\.com.cn)\//i,remoteImgSaveUrl:'/d1xheditor/SaveRemoteimg.jsp',skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
<%}else{%>
$('#elm1').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
<%}%>

}
function submitForm(){$('#form1').submit();}
 /* jQuery(document).ready(function(){
  var editors=$('#elm1').xheditor({//tools:'Cut,Copy,Img,Fullscreen,Emot',
    html5Upload:false,
    upImgUrl:'/servlet/UploadFileServlet',
    upImgExt:"jpg,jpeg,gif,png",
    upMultiple:false,
    onUpload:insertUpload
    });
    
  });

 function insertUpload(arrMsg){
	var i,msg;
	for(i=0;i<arrMsg.length;i++)
	{
	msg=arrMsg[i];
	//alert(msg);
	}

}
*/
  </script>


