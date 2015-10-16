﻿<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/inc/header.jsp"%><%@include file="/admin/chkshop.jsp"%>
<%@include file="/admin/public.jsp"%>
<%
if(session.getAttribute("type_flag")!=null){
	String userid = "";
	if(session.getAttribute("admin_mng") != null){
		userid = session.getAttribute("admin_mng").toString();
	}
	boolean is_edit = chk_admpower(userid,"d1shop_gdsedit");
	boolean is_add =  chk_admpower(userid,"d1shop_gdsadd");
	if(is_edit==false && is_add==false){
		out.print("对不起，您没有操作权限！");
		return;	
	}
}
%>
<%!  
    private ArrayList<Directory> GetRacklistByRockcode(String Rackcode)
    {
	   ArrayList<Directory> dirlist=new ArrayList<Directory>();
	   dirlist=DirectoryHelper.getByParentcode(Rackcode);
	   return dirlist;	
    }
	//获取商品状态
	private String GetFlagname(Long flag)
	{
		if(flag==0) return"录入待上架";
		else if(flag==1) return "上架";
		else if(flag==2) return"下架";
		else if(flag==4) return"隐藏";
		else if(flag==5) return"已审核，待上架";
		else if(flag==-1) return"被打回申请";
		else return"";    
	
	}
  //获取品牌
    public static ArrayList<ShopBrand> getBrandByShop(String shopCode){
    	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
    	clist.add(Restrictions.eq("shopbrand_shopcode", shopCode));	
    	List<BaseEntity> list = Tools.getManager(ShopBrand.class).getList(clist, null, 0, 1000);
    	if(list==null||list.size()==0)return null;
    	
    	ArrayList<ShopBrand> resList = new ArrayList<ShopBrand>();
    	for(BaseEntity brand:list){
    		resList.add((ShopBrand)brand);
    	}
    	return resList;
    }
  
    /**
     * 取sku列表，修改库存时要清除列表
     * @param productId
     * @return
     */
    
    public static ArrayList<Sku> getSkuListViaProductId(String productId){
    	//以前的逻辑是先判断商品表中是否有SKU，再判断gdsmst_skuname1是否有值，现在逻辑是在SKU无的情况下依旧可以查出数据。
    	//因此现在的逻辑改为：只判断商品表中是否存在SKU
    	//if(Tools.isNull(productId)||!SkuHelper.hasSku(productId))return null;
    	Product p = (Product)Tools.getManager(Product.class).get(productId);
    	if(Tools.isNull(productId)||p==null)return null;
    	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
    	clist.add(Restrictions.eq("skumst_gdsid", productId));
    	
    	List<BaseEntity> list = Tools.getManager(Sku.class).getList(clist, null, 0, 100);
    	
    	ArrayList<Sku> rlist = new ArrayList<Sku>();
    	if(list!=null&&list.size()>0){
    		for(BaseEntity sku:list){
    			rlist.add((Sku)sku);
    		}
    	}
    	return rlist ;
    }
  //获取平铺图
    private ArrayList<GdsCutImg> getAllPNG(String gdsid)
    {
       ArrayList<GdsCutImg> gdslist=new ArrayList<GdsCutImg>();
       List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
       clist.add(Restrictions.eq("gdsmst_gdsid", gdsid));

       List<BaseEntity> list = Tools.getManager(GdsCutImg.class).getList(clist, null, 0, 1000);

       if(list==null||list.size()==0)return null;
 		for(BaseEntity c:list){
 			gdslist.add((GdsCutImg)c);
 		}
       return gdslist ;
    }

    //获取细节图   
    private ArrayList<GdsImgDtl> getAllxj(String gdsid)
    {
       ArrayList<GdsImgDtl> gdslist=new ArrayList<GdsImgDtl>();
       List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
       clist.add(Restrictions.eq("gdsimgdtl_gdsid", gdsid));
       List<Order> olist=new ArrayList<Order>();
       olist.add(Order.asc("gdsimgdtl_sort"));
       List<BaseEntity> list = Tools.getManager(GdsImgDtl.class).getList(clist, olist, 0, 1000);

       if(list==null||list.size()==0)return null;
 		for(BaseEntity c:list){
 			gdslist.add((GdsImgDtl)c);
 		}
       return gdslist ;
    }
    public static List<ShopRck> getShopRckList(String shopcode,int parentid){
    	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
    	listRes.add(Restrictions.eq("shoprck_shopcode", shopcode));
    	listRes.add(Restrictions.eq("shoprck_parentid", new Long(parentid)));
    	List<Order> olist= new ArrayList<Order>();
    	olist.add(Order.asc("shoprck_seq"));
    	List list = Tools.getManager(ShopRck.class).getList(listRes, olist, 0, 200);	
    	if(list == null || list.isEmpty()) return null;	
    	return list;
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
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    basePath = basePath.substring(0, (basePath.lastIndexOf("/") == basePath.length() - 1) ? basePath.lastIndexOf("/") : basePath.length());

session.setAttribute("basePath",basePath+"/");
//获取当前时间
String now=Tools.getDate();


String gdsid="";
if(request.getParameter("id")!=null&&request.getParameter("id").toString()!="")
{
  gdsid=request.getParameter("id").toString();	
}
else
{
   out.print("参数不正确！");
   return;	
}
Product p=ProductHelper.getById(gdsid);
String shopCode=session.getAttribute("shopcodelog").toString();
if(p==null||!shopCode.equals(p.getGdsmst_shopcode()))
{
	out.print("商品不存在！");
	return;
}
String rcode=p.getGdsmst_rackcode();//商品分类

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品维护</title>
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
.rcklin {
	border: 1px solid #449ae7;
	width:400px;
	padding:20px 0 20px 20px;
	overflow: scroll; height: 180px;}
}
</style>
</head>
<body style=" background:#fff;">
<div>
<%@include file="/admin/inc/shhead.jsp" %>
<br/>
<br/>
<form id="form1" name="form1" method="post" action="" target="right">
<table style="width:980px; overflow:hidden; margin:0px auto;" border="0" cellpadding="0" cellspacing="0">
   <tr><td width="174" style="text-align:center;" valign="top">
     <%@include file="/admin/inc/SHleftPM.jsp" %>
   </td>
   <td width="806" valign="top">
   <input type="hidden" id="gdsid" value="<%= p.getId() %>"></input>
   <input type="hidden" id="pp" value="<%= p.getGdsmst_brand() %>"></input>
   <input type="hidden" id="rcode" value="<%= p.getGdsmst_rackcode() %>"></input>
   <input type="hidden" id="flag" value="<%= p.getGdsmst_validflag() %>"></input>
  
  <div id="spdetail" style="display:block; width:806px; text-align:left;">
  <table width="100%"> 
      <tr><td height="47" valign="bottom" colspan="2">
      <img src="/admin/SHManage/images/jbxx.jpg"/>
      </td></tr>
      <tr><td colspan="2">
       <table width="100%">
       <tr><td width="80">
       <font style="color:#f00">*&nbsp;&nbsp;</font>D1分类：</td>
       <td width="140"><select id="level1" name="level1" style="padding:3px; color:#464646;" onchange="GetOtherRack1('2',$('#level1 option:selected') .val())">
		<option value="0">--请选择--</option>
		<%
		    ArrayList<Directory> rcklist=GetRacklistByRockcode("0");
		    if(rcklist!=null&&rcklist.size()>0)
		    {
		    	for(int i=0;i<rcklist.size();i++)
		    	{
		    		Directory dir=rcklist.get(i);
		    		if(dir!=null)
		    		{%>
		    			<option value="<%=dir.getId().trim() %>"><%=dir.getRakmst_rackname() %></option>    			
		    		<%}
		    	}
		    }
		%>
		</select>
		</td>
		<td width="140"><select id="level2" name="level2" style="padding:3px;margin-left:3px; color:#464646; display:none;" onchange="GetOtherRack1('3',$('#level2 option:selected') .val())">
		<%
		if(rcode.length()>0&&rcode.length()>=6){
		    ArrayList<Directory> rcklist2=GetRacklistByRockcode(rcode.substring(0,3));
		    if(rcklist2!=null&&rcklist2.size()>0)
		    {
		    	for(int i=0;i<rcklist2.size();i++)
		    	{
		    		Directory dir=rcklist2.get(i);
		    		if(dir!=null)
		    		{%>
		    			<option value="<%=dir.getId().trim() %>"><%=dir.getRakmst_rackname() %></option>    			
		    		<%}
		    	}
		    }
		}
				%>
		</select>
        </td>
		<td width="140"><select id="level3" name="level3" style="margin-left:3px; padding:3px; color:#464646;display:none;" onchange="GetOtherRack1('4',$('#level3 option:selected') .val())">
		<%
		if(rcode.length()>0&&rcode.length()>=9){
		    ArrayList<Directory> rcklist3=GetRacklistByRockcode(rcode.substring(0,6));   
		    if(rcklist3!=null&&rcklist3.size()>0)
		    {
		    	for(int i=0;i<rcklist3.size();i++)
		    	{
		    		Directory dir=rcklist3.get(i);
		    		if(dir!=null)
		    		{%>
		    			<option value="<%=dir.getId().trim() %>"><%=dir.getRakmst_rackname() %></option>    			
		    		<%}
		    	}
		    }
		}
		%>
		</select>
		<input type="hidden" id="hcode" name="hcode"/>
		</td>
		<td width="140">
		<select id="level4" name="level4" style="margin-left:3px; padding:3px; color:#464646;display:none;" onchange="Bindgg($('#level4 option:selected').val())">
		<%
		if(rcode.length()>0&&rcode.length()>=12){
		    ArrayList<Directory> rcklist4=GetRacklistByRockcode(rcode.substring(0,9));   
		    if(rcklist4!=null&&rcklist4.size()>0)
		    {
		    	for(int i=0;i<rcklist4.size();i++)
		    	{
		    		Directory dir=rcklist4.get(i);
		    		if(dir!=null)
		    		{%>
		    			<option value="<%=dir.getId().trim() %>"><%=dir.getRakmst_rackname() %></option>    			
		    		<%}
		    	}
		    }
		}
		%>
		</select>
		</td>
		<td width="100">&nbsp;</td>
        </tr>    
        </table>
        </td></tr>
      <tr><td colspan="2">
	      <table>
	      <tr><td width="80"><font style="color:#f00">*&nbsp;&nbsp;</font>商&nbsp;品&nbsp;名&nbsp;称：</td>
            <td width="706"><input id="gdsmst_title" type="text" name="gdsmst_title"  style="width:420px; line-height:25px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%=p.getGdsmst_gdsname() %>"></input></td>
           </tr>
            <tr><td width="80">&nbsp;&nbsp;&nbsp;商品副标题：</td>
       <td><input id="gdsmst_subtitle" type="text" name="gdsmst_subtitle"  style="line-height:25px;width:420px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%= p.getGdsmst_title() %>"></input></td>
       </tr>
       <tr><td width="80">&nbsp;&nbsp;&nbsp;品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌：</td>
       <td>
       <select id="gdsmst_pp" name="gdsmst_pp">
       <option value="">无品牌</option>
         <%SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
         
         ShpMst shpmst=getshpmst(shopCode);
         String shpmstrck=shpmst.getShpmst_rck();
         int gzflag=0;
         if (shpmst.getShpmst_sendtype().longValue()!=2){
       	  gzflag=1;
         }
 	    if(!shopCode.equals("00000000"))
 	    {
 		    ArrayList<ShopBrand> blist=new ArrayList<ShopBrand>();
 		    blist=getBrandByShop(shopCode);
 		    if(blist!=null&&blist.size()>0)
 		    {
 		    	for(ShopBrand b:blist)
 		    	{
 		    		if(b!=null)
 		    		{%>
 		    			<option value='<%= b.getShopbrand_brand() %>'><%= b.getShopbrand_brandname() %></option>
 		    		<%}
 		    	}
 		    }
 	    }
 	    else
 	    { 	    	
	 	        ArrayList<Brand> blist=new ArrayList<Brand>();
	 	        blist=BrandHelper.getBrandByRackCode(p.getGdsmst_rackcode().substring(0,6));
	 	        if(blist!=null&&blist.size()>0)
	 		    {
	 		    	for(Brand b:blist)
	 		    	{
	 		    		if(b!=null)
	 		    		{%>
	 		    			<option value='<%= b.getBrand_code() %>'><%= b.getBrand_name() %></option>
	 		    		<%}
	 		    	}
	 		    }
 	    	
 	    }        
          %> 
       </select> 
       </td>     
       </tr>
       <tr><td width="80"><font style="color:#f00">*&nbsp;&nbsp;</font>商&nbsp;家&nbsp;编&nbsp;码：</td>
       <td><input id="gdsmst_sjbm" type="text" name="gdsmst_sjbm"  style="line-height:25px; width:270px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%= p.getGdsmst_shopgoodscode() %>" ></input></td>
       </tr>
       <tr><td width="80"><font style="color:#f00">&nbsp;&nbsp;</font>商&nbsp;品&nbsp;条&nbsp;码：</td>
       <td><input id="gdsmst_barcode" type="text" name="gdsmst_barcode"  style="line-height:25px; width:270px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%= p.getGdsmst_barcode() %>" ></input>国标条形码（支持EAN-13、UPC-12，例如：6917878030623）
（<span style="color:red">此字段填写后，将在微信、UC浏览器等地方扫描购买</span>）</td>
       </tr>
        <tr <%if (gzflag==0) {%>style="display:none;"<%} %>>
       <td colspan="2">
        <table style="color:#000;">
       <tr><td><font style="color:#f00">&nbsp;&nbsp;</font>采&nbsp;购&nbsp;说&nbsp;明：</td>
       <td><textarea id="gdsmst_provider" type="text" name="gdsmst_provider"  style="line-height:25px; width:400px;border:solid 1px #d4d4d4;background:#f8f8f8; height:50px;"><%= p.getGdsmst_provider() %></textarea></td>
       </tr>
       <tr><td><font style="color:#f00">&nbsp;&nbsp;</font>额&nbsp;外&nbsp;成&nbsp;本：</td>
       <td><input id="gdsmst_othercost" type="text" name="gdsmst_othercost" value="<%= p.getGdsmst_othercost() %>" style="line-height:25px; width:150px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"></input>&nbsp;&nbsp;&nbsp;&nbsp;不可用券：<input type="checkbox" name="req_specialflag" <%=p.getGdsmst_specialflag().longValue()==1?"checked":"" %> value="1"></td>
       </tr>
       <!-- 供应商开始 -->
       <%//只有D1账户和测试账户显示供应商和其他供应商
       if(shopCode.equals("13100902") || shopCode.equals("00000000")){%>
      <tr><td width="80">&nbsp;&nbsp;供&nbsp;应&nbsp;商：</td>
       <td>
       <select id="provide" name="provide" style="width: 325px;">
       <option value="">没有供应商</option>
         <%
         String gdsmst_rackcode="";
         if(!Tools.isNull(p.getGdsmst_rackcode())){
        	 gdsmst_rackcode = p.getGdsmst_rackcode().substring(0, 3);
         }
         List<Provider> provide_list=getProvideList(gdsmst_rackcode);
	    if(provide_list!=null&&provide_list.size()>0){
	    	for(Provider pro:provide_list){
	    		if(pro!=null){%>
	    			<option <%if(pro.getProvide_shopcode().equals(p.getGdsmst_provide())) {%> selected="selected"<%}%> value='<%= pro.getProvide_shopcode() %>'><%= pro.getProvide_shopcode() %>-<%= pro.getProvide_name() %></option>
	    		<%}
	    	}
	    }
 	     %>
       </select> 
       </td>     
       </tr>
       <tr><td width="80">&nbsp;&nbsp;其他供应商：</td>
       <td>
       <textarea id="gdsmst_provideStr" type="text" name="gdsmst_provideStr"  style="line-height:25px; width:400px;border:solid 1px #d4d4d4;background:#f8f8f8; height:50px;"><%=Tools.isNull(p.getGdsmst_provideStr())?"":p.getGdsmst_provideStr() %></textarea>
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
      
   
      <tr><td colspan="2" height="47" valign="bottom">
      <img src="/admin/SHManage/images/jyxx.jpg"/>
      </td></tr>
      <tr><td colspan="2">
      <table style="color:#000;">
       <tr><td width="80"><font style="color:#f00">*&nbsp;&nbsp;</font>市&nbsp;&nbsp;&nbsp;&nbsp;场&nbsp;&nbsp;&nbsp;&nbsp;价：</td>
       <td><input id="gdsmst_scj" type="text" name="gdsmst_scj"  style=" line-height:25px;width:100px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" onblur="GetZK();" value="<%=Tools.getFloat(p.getGdsmst_saleprice(),1) %>"></input></td>
       <td>
          &nbsp;&nbsp;&nbsp;&nbsp;<font style="color:#f00">*&nbsp;&nbsp;</font>D1&nbsp;&nbsp;价：
       </td>
       <td>
          <input id="gdsmst_d1j" type="text" name="gdsmst_d1j"  style=" line-height:25px;width:80px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"  onblur="GetZK();" 
          value="<%=Tools.getFloat(p.getGdsmst_memberprice(),1)%>"></input>
                 <!--  进价：<input id="gdsmst_inp" type="text" name="gdsmst_inp"  style=" line-height:25px;width:60px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%=Tools.getFloat(p.getGdsmst_inprice(),1) %>"  onblur="GetZK();"></input>
     --></td>
     <td>     
          折&nbsp;&nbsp;扣：&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td>
          <input id="gdsmst_zk" disabled ="false" type="text" name="gdsmst_zk"  style=" color:#333; line-height:25px;width:100px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"></input>
                 </td>
       </tr>
       <tr><td>&nbsp;&nbsp;&nbsp;商&nbsp;品&nbsp;状&nbsp;态：</td>
       <td><select id="gdsmst_validflag" name="gdsmst_validflag">
			<option value="-2">--请选择--</option>
			<option value="1">上架</option>
			<option value="2">下架</option>
			<option value="0">录入待上架</option>			
			</select>
	  </td>
      <td>&nbsp;&nbsp;&nbsp;&nbsp;产&nbsp;&nbsp;地：  </td>
                   <td colspan="3"><input id="gdsmst_station" type="text" name="gdsmst_station"  style=" line-height:25px;width:147px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%= p.getGdsmst_provenance() %>"></input>
          
       </td>
       </tr>
       <tr> 
       <td>&nbsp;&nbsp;&nbsp;促&nbsp;&nbsp;&nbsp;&nbsp;销&nbsp;&nbsp;&nbsp;&nbsp;价：</td>
       <td><input id="gdsmst_cxj" type="text" name="gdsmst_cxj"  style=" line-height:25px;width:100px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" 
       value="<%=Tools.getFloat(p.getGdsmst_msprice(),1) %>" >
         </input></td>
       <td>
          &nbsp;&nbsp;&nbsp;&nbsp;<font style="color:#f00"></font>促&nbsp;销&nbsp;时&nbsp;间：
          </td>
          <td colspan="3">
          <input id="gdsmst_begin" type="text" name="gdsmst_begin"  style=" line-height:25px;width:120px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"  onFocus="WdatePicker({isShowClear:true,readOnly:true,skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="<%= p.getGdsmst_promotionstart()!=null&&p.getGdsmst_promotionstart().toString().length()>0?Tools.stockFormatDate(p.getGdsmst_promotionstart()):"" %>" >
         
          </input>
                  至
          <input id="gdsmst_end" type="text" name="gdsmst_end"  style=" line-height:25px;width:120px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;"  onFocus="WdatePicker({isShowClear:true,readOnly:true,skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="<%= p.getGdsmst_promotionend()!=null&&p.getGdsmst_promotionend().toString().length()>0?Tools.stockFormatDate(p.getGdsmst_promotionend()):"" %>" ></input>
                   </td></tr>
       
      </table>
      </td></tr>
      <tr><td colapn="2" height="47" valign="bottom">
      <img src="/admin/SHManage/images/spsx.jpg"/>
      </td></tr>
      <tr>
      <td colspan="2">
      <input id="hstdid" name="hstdid" type="hidden"></input>
          <input id="hidgg" name="hidgg" type="hidden" value="<%=gzflag %>"></input>
      <div id="allgg">
     
      </div>
      </td>
      </tr>
      <tr><td colspan="2" height="47" valign="bottom">
      <img src="/admin/SHManage/images/tjsku.jpg"/>
	  <span style="color: red;"><br/>
	    注：不分SKU商品，下拉框选择“无”，并直接填写库存。<br/>
	  &nbsp;&nbsp;&nbsp;&nbsp;区分SKU商品，下拉框选择“规格”，填写新增SKU后，再填写每个SKU库存。
	  </span>
      </td></tr>
      <tr><td colspan="2">
          <table id="skutable" style="border:solid 1px #72bdff; border-bottom:none; text-align:center;" width="770" border="0" cellpadding="0" cellspacing="0">
             <tr id="bt" style="background:#deefff;">
             <th height="36" width="154" style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;">
             
             <select id="skuname" name="skuname" onchange="sku_change();">
            <option value="0" <% if(p.getGdsmst_skuname1().equals("")||p.getGdsmst_skuname1().equals("无")){%> selected="true" <%} %>>无</option>
            <%if(!Tools.isNull(p.getGdsmst_skuname1()) && !p.getGdsmst_skuname1().equals("规格")){%>
            <option value="<%=p.getGdsmst_skuname1() %>" selected="true" ><%=p.getGdsmst_skuname1() %></option>
             <%}else{%>
             	<option value="规格" <% if(p.getGdsmst_skuname1().equals("规格")){%> selected="true" <%} %>>规格</option>
             <%}%>
             
             </select>
             </th>
             <th width="154"  style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;"><b>库存</b></th>
             <th width="154"  style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;"><b>状态</b></th>
             <th width="154"  style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;"><b>库存同步</b></th>
             <th width="154"  style="border-bottom:solid 1px #72dbff;"><b>操作</b></th></tr>
           <%
           if(!p.getGdsmst_skuname1().equals("")&&!p.getGdsmst_skuname1().equals("无")){
              ArrayList<Sku> slist=getSkuListViaProductId(p.getId());
              if(slist!=null&&slist.size()>0)
              {
                for(Sku s:slist)
                {
                %>
            	  <tr><td height="36" style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;" attr="<%= s.getId() %>"><%=s.getSkumst_sku1() %></td>
                   <td style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;" >
                   <input type="text" id="kc1" name="kc1" style="border:solid 1px #d4d4d4;background:#f8f8f8;width:140px;height:22px;" value="<%= s.getSkumst_stock() %>"></input></td>
                   <td style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;"><select id="zt1" name="zt1">
		             <option value="1" <% if(s.getSkumst_validflag()==1) {%>selected="true"<%}  %>>上架</option>
		             <option value="0" <% if(s.getSkumst_validflag()==0) {%>selected="true"<%}  %>>下架</>
		           </select></td>
		          <td style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;">
		          <input type="text" id="kctb1" name="kctb1" style="border:solid 1px #d4d4d4;background:#f8f8f8;width:140px;height:22px;" value="<%= s.getSkumst_vstock() %>"></input></td>
		          <td style="border-bottom:solid 1px #72dbff;"><a href="javascript:void(0)" onclick="deleteSku(this)" style="color:#333; text-decoration:none;">删除</a></td>
		          </tr>
              <%}
              }
           }else{%>
           		<tr><td height="36" style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;" attr=""></td>
                   <td style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;" >
                   <input type="text" id="kc1" name="kc1" style="border:solid 1px #d4d4d4;background:#f8f8f8;width:140px;height:22px;" value="<%= p.getGdsmst_stock() %>"></input></td>
                   <td style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;"><select id="zt1" name="zt1">
		             <option value="1" <% if(p.getGdsmst_validflag()==1) {%>selected="true"<%}  %>>上架</option>
		             <option value="0" <% if(p.getGdsmst_validflag()==0) {%>selected="true"<%}  %>>下架</>
		           </select></td>
		          <td style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;">
		          <input type="text" id="kctb1" name="kctb1" style="border:solid 1px #d4d4d4;background:#f8f8f8;width:140px;height:22px;" value="<%= p.getGdsmst_stock() %>"></input></td>
		          <td style="border-bottom:solid 1px #72dbff;"><a href="javascript:void(0)" onclick="deleteSku(this)" style="color:#333; text-decoration:none;">删除</a></td>
		          </tr>
           <%}%>
          </table> 
          <script type="text/javascript">
			$(document).ready(function(){
				var skuname = $("#skuname").val();
				//alert(skuname);
				if(skuname == 0){//SKU 0无  其它代表有 
					var kc1 = $("#kc1").val();
					//alert(kc1);
					if(kc1 != ''){//库存有值，隐藏'添加库存'按钮
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
      <tr><td colspan="2" height="47" valign="bottom">
      <img src="/admin/SHManage/images/cpjj.jpg"/>
      </td></tr>
      <tr><td colspan="2">
      <textarea rows="5" id="gdsmst_cpjj" name="gdsmst_cpjj" style="border:solid 1px #d4d4d4;background:#f8f8f8; width:768px"><%= p.getGdsmst_briefintrduce()%></textarea>
      </td></tr>
      <tr><td colspan="2" height="47" valign="bottom">
      <img src="/admin/SHManage/images/cpms.jpg"/>
      </td></tr>
      <tr><td colspan="2">
      <textarea id="elm1" name="content"  style="width: 800px;height: 400px;"><%= p.getGdsmst_detailintruduce() %></textarea>
      <div id="uploadList"></div>
      </td></tr>
     <tr><td colspan="2"></br>商户分类：</br>
    <div class="rcklin">
      <%List<ShopRck> shoprcklist=getShopRckList(shopCode,0);
      if(shoprcklist!=null){
    	    for(ShopRck sprck:shoprcklist){
    	   	String shoprck_id= sprck.getId();
    	   	%>
    	   	<%=sprck.getShoprck_name() %><br />
    	   	<%
    	   	List<ShopRck> shoprcklist2=getShopRckList(shopCode,Tools.parseInt(sprck.getId()));
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
 %><input type="checkbox" name="shoprck" value="<%=sprck2.getId() %>" <%if(!Tools.isNull(p.getGdsmst_shoprck())&&p.getGdsmst_shoprck().indexOf(sprck2.getId()+",")>=0){out.print("checked");} %>  /><%=sprck2.getShoprck_name() %><br />

<%
inum++;
     }
     }
    }  
   }
%>
</div>  </td></tr>
   </table>
  </div>
  
  <div id="imagelist" name="imagelist" style="display:block;width:806px; text-align:center;">
    <table style="width:440px; margin:0px auto;overflow:hidden;">     
      <tr><td><img src="/admin/SHManage/images/tpgl.jpg"/></td></tr>
      <tr><td>
        <table style="text-align:center; overflow:hidden; width:470px;">
           <tr><td>
           <input type="hidden" id="hgdsid" name="hgdsid" value="<%=gdsid%>"/>
              <table style="border:solid 1px #72dbff;text-align:center;" border="0" cellspacing="0" cellpadding="0">
                 <tr style="background:#deefff;"><td width="100" height="40"><b>图片</b></td><td width="80" style="text-align:center;"><b>预览</b></td>
                 <td width="100"><b>图片格式</b></td><td width="190" colspan="2"><b>操作</b></td></tr>
                 <tr style=" border-bottom:dashed 1px #999" ><td height="74" valign="middle">商品主图</td>
                 <td valign="middle"><div id="spzt" ><img src='<%= !Tools.isNull(p.getGdsmst_midimg())&& p.getGdsmst_midimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://www.d1.com.cn" %><%= p.getGdsmst_midimg() %>' width="60" height="60"/></div></td>
                 <td valign="middle">800*800</td>
                 <td valign="middle" width="100">
                 <input type="hidden" value="800" id="hw" />
	             <input type="hidden" value="800" id="hh" />
	             <input type="hidden"  value="" id="himgurl_1" />
               <div id="fileQueue" class="sctpk" style="float:left;">
        	    <input type="file" name="uploadify" id="uploadify" /> 
      		   </div>
		       </div>
      		   <div  id="btnupload" style="padding-left:25px;float:left;clear:both;"> </div>
                 </td>
                 <td width="50">
                 </td>
                 </tr>                 
                 <tr style=" border-bottom:dashed 1px #999" ><td height="74" valign="middle">列表图片</td>
                 <td valign="middle"><div id="spzt1" ><img src='<%= !Tools.isNull(p.getGdsmst_img240300())&& p.getGdsmst_img240300().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://www.d1.com.cn" %><%= p.getGdsmst_img240300() %>' width="60" height="75"/></div></td>
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
                 <%ArrayList<GdsImgDtl> xjlist=getAllxj(p.getId());
                    String xjt1="";
          	        String xjt2="";
          	        String xjt3="";
          	        String xjt4="";
          	        String xjt_id1="";
          	        String xjt_id2="";
          	        String xjt_id3="";
          	        String xjt_id4="";
                   if(xjlist!=null&&xjlist.size()>0)
                   {     
                	   int i=0;
                	   for(GdsImgDtl gds:xjlist)
                	   {
                		   if(!gds.getGdsimgdtl_bigimg().equals(""))
                		   {i++;
                			   //String ls=gds.getGdsimgdtl_bigimg();
                			   //ls=ls.substring(ls.length()-5,ls.length()-4);
                			   //if(ls.equals("3")){xjt1=gds.getGdsimgdtl_smallimg();xjt_id1=gds.getId();}
                			   //if(ls.equals("4")){xjt2=gds.getGdsimgdtl_smallimg();xjt_id2=gds.getId();}
                			   //if(ls.equals("5")){xjt3=gds.getGdsimgdtl_smallimg();xjt_id3=gds.getId();}
                			   //if(ls.equals("6")){xjt4=gds.getGdsimgdtl_smallimg();xjt_id4=gds.getId();}
                			   if(gds.getGdsimgdtl_sort()==1){
                				   xjt1=gds.getGdsimgdtl_smallimg();xjt_id1=gds.getId();
                			   }
                			   if(gds.getGdsimgdtl_sort()==2){
                				   xjt2=gds.getGdsimgdtl_smallimg();xjt_id2=gds.getId();
                			   }
                			   if(gds.getGdsimgdtl_sort()==3){
                				   xjt3=gds.getGdsimgdtl_smallimg();xjt_id3=gds.getId();
                			   }
                			   if(gds.getGdsimgdtl_sort()==4){
                				   xjt4=gds.getGdsimgdtl_smallimg();xjt_id4=gds.getId();
                			   }
                		   }
                	   }
                   }
                 %>
                 <tr style=" border-bottom:dashed 1px #999" ><td height="74" valign="middle">细节图1</td>
                 <td valign="middle">
                 <input type="hidden" id="del_zj1" value="<%if(xjt1.length()>0) {out.print(xjt_id1);}%>"></input>
                 <div id="spzt2" ><% if(xjt1.length()>0) {%><img src="http://www.d1.com.cn<%= xjt1 %>" width="60" height="60"/><%} %></div></td>
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
                  <td><a href="javascript:void(0)" onclick="deleteTP1('2')">删除</a>
                 </td>
                 </tr>         
                 <tr style=" border-bottom:dashed 1px #999" ><td height="74" valign="middle">细节图2</td>
                 <td valign="middle"><input type="hidden" id="del_zj2" value="<%if(xjt2.length()>0) {out.print(xjt_id2);}%>"></input>
                 <div id="spzt3" ><% if(xjt2.length()>0) {%><img src="http://www.d1.com.cn<%= xjt2 %>" width="60" height="60"/><%} %></div></td>
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
                  <td><a href="javascript:void(0)" onclick="deleteTP1('3')">删除</a>
                 </td>
                 </tr>     
               <tr style=" border-bottom:dashed 1px #999" ><td height="74" valign="middle">细节图3</td>
                 <td valign="middle"><div id="spzt4" >
                 <input type="hidden" id="del_zj3" value="<%if(xjt3.length()>0) {out.print(xjt_id3);}%>"></input>
                 <% if(xjt3.length()>0) {%><img src="http://www.d1.com.cn<%= xjt3 %>" width="60" height="60"/><%} %></div></td>
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
                  <td><a href="javascript:void(0)" onclick="deleteTP1('4')">删除</a>
                 </td>
                 </tr>   
                    <tr style=" border-bottom:dashed 1px #999" ><td height="74" valign="middle">细节图4</td>
                 <td valign="middle">
                 <input type="hidden" id="del_zj4" value="<%if(xjt4.length()>0) {out.print(xjt_id4);}%>"></input>
                 <div id="spzt5" ><% if(xjt4.length()>0) {%><img src="http://www.d1.com.cn<%= xjt4 %>" width="60" height="60"/><%} %></div></td>
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
                  <td><a href="javascript:void(0)" onclick="deleteTP1('5')">删除</a>
                 </td>
                 </tr>  
                 <%  ArrayList<GdsCutImg> gcilist=getAllPNG(p.getId()); %>     
                 <tr style=" border-bottom:dashed 1px #999" ><td height="74" valign="middle">PNG平铺图</td>
                 <td valign="middle">
                 <input type="hidden" id="del_zj5" value="<%if(gcilist!=null&&gcilist.size()>0){ out.print(gcilist.get(0).getId());}%>"></input>                 
                 <div id="spzt6" ><% if(gcilist!=null&&gcilist.size()>0){%><img src="<%= !Tools.isNull(gcilist.get(0).getGdscutimg_100())&& gcilist.get(0).getGdscutimg_100().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://www.d1.com.cn" %><%= gcilist.get(0).getGdscutimg_100() %>" width="60" height="60"/><%} %></div></td>
                 <td valign="middle">300*300</td>
                 <td valign="middle">
                 <input type="hidden" value="300" id="hw6" />
	             <input type="hidden" value="300" id="hh6" />
	             <input type="hidden"  value="" id="himgurl6" />
               <div id="fileQueue6" class="sctpk" style="float:left;">
        	    <input type="file" name="uploadify6" id="uploadify6" /> 
      		   </div>
      		   
      		   <div  id="btnupload6" style="padding-left:25px;float:left;clear:both;"> </div>
                 </td>
                  <td><a href="javascript:void(0)" onclick="deleteTP1('6')">删除</a>
                 </td>
                 </tr>               
              </table>
           </td>
           
           </tr>
           <tr><td>
           <a href="javascript:void(0)" onclick="Allupdate()"><img src="/admin/SHManage/images/update.png"/></a>
           &nbsp;&nbsp;
           <a id="ylsp" href="http://www.d1.com.cn/Product/<%=p.getId() %>" target="_blank"><img src="/admin/SHManage/images/yl.png"/></a>
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
Bind_pM($('#pp').val(),$('#rcode').val(),$('#flag').val());
SCTPInit();
$(pageInit);
function pageInit()
{  
	 <%if(!shopCode.equals("14051306")){%>
	 $('#elm1').xheditor({localUrlTest:/^https?:\/\/[^\/]*?(d1\.com.cn)\//i,remoteImgSaveUrl:'/d1xheditor/SaveRemoteimg.jsp',skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
	<%}else{%>
	$('#elm1').xheditor({skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
	<%}%>}
function submitForm(){$('#form1').submit();}
/*
jQuery(document).ready(function(){
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

}*/
</script>