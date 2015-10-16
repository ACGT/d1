<%@ page contentType="text/html; charset=UTF-8"%>
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

    private ArrayList<Directory> GetRacklistByRockcode(String Rackcode)
    {
	   ArrayList<Directory> dirlist=new ArrayList<Directory>();
	   dirlist=DirectoryHelper.getByParentcode(Rackcode);
	   return dirlist;	
    }
    //根据商品编码获取商品
    private ArrayList<Product> getProduct(String gcode,String brandcode,String name,String gdsid,String validflag,Date begin,Date end,String fl,String SHfl,String sjcode)
    {
    	//shopcodelog
    	ArrayList<Product> plist=new ArrayList<Product>();
    	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_shopcode",gcode));
		if(brandcode.length()>0)
		{
			clist.add(Restrictions.eq("gdsmst_brand", brandcode));			
		}
		if(name.length()>0)
		{	
			clist.add(Restrictions.like("gdsmst_gdsname", "%"+name+"%"));		
		}
		if(gdsid.length()>0){
			
			clist.add(Restrictions.eq("id", gdsid));		
		}
		if(validflag.length()>0)
		{	
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(validflag)));		
		}
		
		if(begin!=null)
		{	
			clist.add(Restrictions.ge("gdsmst_createdate", begin));
		}
		if(end!=null)
		{	
			clist.add(Restrictions.le("gdsmst_createdate", end));
		}
		if(fl.length()>0)
		{	
			clist.add(Restrictions.like("gdsmst_rackcode", fl+"%"));	
		}
		if(SHfl.length()>0)
		{	
			clist.add(Restrictions.like("gdsmst_shoprck", "%"+SHfl+",%"));	
		}	
		if(sjcode.length()>0)
		{	
			clist.add(Restrictions.eq("gdsmst_shopgoodscode", sjcode));			
		}
		int lengds=2000;
		//if(brandcode.length()>0||name.length()>0||gdsid.length()>0||validflag.length()>0||begin!=null
			//	||end!=null||fl.length()>0||SHfl.length()>0||sjcode.length()>0){
			//lengds=500;
		//}
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("gdsmst_createdate"));
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0, lengds);
		
		if(b_list!=null){
			for(BaseEntity be:b_list){
				plist.add((Product)be);
			}
		}	
		return plist;
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

    private ShpMst getshpmst(String shopcode){
    	ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(shopcode);
    	
    	return shpmst;
    }

    //获取Sku
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

%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    basePath = basePath.substring(0, (basePath.lastIndexOf("/") == basePath.length() - 1) ? basePath.lastIndexOf("/") : basePath.length());

session.setAttribute("basePath",basePath+"/");
//获取当前时间
String now=Tools.getDate();
//获取参数
String act="";
if(request.getParameter("act")!=null)
{
	act=request.getParameter("act");
}

String pp="";
if(request.getParameter("bcode")!=null)
{
   pp=request.getParameter("bcode");
}
String name="";
if(request.getParameter("gname")!=null)
{
	name=request.getParameter("gname");
}
String gdsid="";
if(request.getParameter("gid")!=null)
{
	gdsid=request.getParameter("gid");
}
String flag="";
if(request.getParameter("flag")!=null)
{
	flag=request.getParameter("flag");
}
String begin="";
if(request.getParameter("begin")!=null)
{
	begin=request.getParameter("begin");
}
String end1="";
if(request.getParameter("end")!=null)
{
	end1=request.getParameter("end");
}
String rcode="";
if(request.getParameter("rcode")!=null)
{
	rcode=request.getParameter("rcode");
}
String scode="";
if(request.getParameter("scode")!=null)
{
	scode=request.getParameter("scode");
}
//商家编码
String sjcode="";
if(request.getParameter("sjcode")!=null)
{
   sjcode=request.getParameter("sjcode");	
}

//定义时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Date begins =null;
if(begin.length()>0) begins=sdf.parse(begin);
Date ends =null;
if(end1.length()>0)  ends=sdf.parse(end1);

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品管理</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/ShopMJS.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/DatePicker/WdatePicker.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/SHPageCss.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css"  />
<style type="text/css">
.GPager{ width:100%; height:50px;; text-align:center; line-height:50px;}
.GPager a{ background:#deefff;border:1px solid #73bdfc; padding:5px; margin:2px; color:#333;}
.curr{background:#f7f7f7;border:1px solid #73bdfc;padding:5px; margin:2px;}
.GPager a:visited{ background:#deefff;border:1px solid #73bdfc; padding:5px; margin:2px;}

</style>
</head>
</head>


<body style=" background:#fff;">
<%@include file="/res/js/date.js"%>
<%@include file="/admin/inc/shhead.jsp" %>
<form id="form1">
<div>
<br/>
<br/>
<table style="width:1000px; margin:0px auto;" border="0" cellpadding="0" cellspacing="0">
   <tr><td width="174" style="text-align:center;" valign="top">
     <%@include file="/admin/inc/SHleftPM.jsp" %>
   </td>
   <td width="926" valign="top">
   <table width="100%" border="0" cellspacing="0" cellpadding="0" style="color:#464646">
<tr><td colspan="2" height="40">品&nbsp;&nbsp;牌： <select id="gdsmst_pp" name="gdsmst_pp" style="padding:3px; width:200px; color:#464646;">
          <option value="">无品牌</option>
          <%
          ArrayList<ShopBrand> blist=new ArrayList<ShopBrand>();
          String shopCode=session.getAttribute("shopcodelog").toString();
          if(!session.getAttribute("shopcodelog").toString().trim().equals("00000000"))
    	    {
      
		          ArrayList<ShopBrand> blist_new=new ArrayList<ShopBrand>();
		          blist_new=getBrandByShop(session.getAttribute("shopcodelog").toString());
		          if(blist_new!=null&&blist_new.size()>0)
		          {
		          	for(ShopBrand b:blist_new)
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
    	    	ArrayList<Brand> blist_new=new ArrayList<Brand>();
    	    	ArrayList<Brand> blist_new2=new ArrayList<Brand>();
    	    	blist_new=BrandHelper.getAllBrands();
    	    	String brand_code = ",";
  	        if(blist_new!=null&&blist_new.size()>0)
  		    {
  	        	//System.out.println("111111111111==="+blist_new.size());
  	        	for(int i=0;i<blist_new.size();i++){
  	        		if(brand_code.indexOf(","+blist_new.get(i).getBrand_code()+",")==-1){
  	        			brand_code+=blist_new.get(i).getBrand_code()+",";
  	        			blist_new2.add(blist_new.get(i));
  	  	        	}
  	        	}
  	        	//System.out.println("222222222222==="+blist_new2.size());
  		    	for(Brand b:blist_new2)
  		    	{
  		    		if(b!=null)
  		    		{%>
  		    			<option value='<%= b.getBrand_code() %>'><%=b.getBrand_rackcode()+"---"+b.getBrand_name() %></option>
  		    		<%}
  		    	}
  		    }
    	    	
    	    }
     
          
          %>
       </select>
    &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;商品名称：<input type="text" id="name" name="name"style=" color:#333; line-height:25px;width:150px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%= name%>"></input>  
    &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;商品编号：<input type="text" id="gdsid" id="gdsid" style=" color:#333; line-height:25px;width:150px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%= gdsid%>"></input>
</td></tr>
<tr><td colspan="2"  height="40">商品状态：
<select id="gdsmst_validflag" name="gdsmst_validflag">
<option value="-2">--请选择--</option>
<option value="1">上架</option>
<option value="2">下架</option>
<option value="0">录入待上架</option>
<!-- 
<option value="4">隐藏</option>
<option value="5">已审核,待上架</option>
<option value="-1">被打回的申请</option>
 -->
</select>
   &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;时间：<input type="text" id="begin" name="begin" onclick="WdatePicker();" style=" color:#333; line-height:25px;width:80px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%= begin%>"></input>
   &nbsp; 至&nbsp;<input type="text" id="end" name="end" onclick="WdatePicker();" style=" color:#333; line-height:25px;width:80px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%= end1%>"></input>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;商家编码：<input type="text" id="shopcode"  name="shopcode" style=" color:#333; line-height:25px;width:80px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%= sjcode%>"></input>          
</td></tr>
<tr><td height="40" colspan="2">
<table><tr><td>D1分类：<select id="level1" name="level1" style="padding:3px; color:#464646;" onchange="GetOtherRack1('2',$('#level1 option:selected') .val())">
<option value="0">--请选择--</option>
<%String shpcode=session.getAttribute("shopcodelog").toString();
ShpMst shpmst=getshpmst(shpcode);
String shpmstrck=shpmst.getShpmst_rck();
    ArrayList<Directory> rcklist=GetRacklistByRockcode("0");
    if(rcklist!=null&&rcklist.size()>0)
    {
    	for(int i=0;i<rcklist.size();i++)
    	{
    		Directory dir=rcklist.get(i);
    		String rootrck=dir.getId();
  		  if(!Tools.isNull(rootrck)){
  			  rootrck=rootrck.trim();
  		  }
    		if(dir!=null&&(shpmstrck.indexOf(rootrck)>=0
  				  ||shpcode.equals("00000000")))
    		{%>
    			<option value="<%=dir.getId().trim() %>"><%=dir.getRakmst_rackname() %></option>    			
    		<%}
    	}
    }
%>
</select></td>
<td><select id="level2" name="level2" style="padding:3px;margin-left:3px; color:#464646; display:none;" onchange="GetOtherRack1('3',$('#level2 option:selected') .val())">
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
<td><select id="level3" name="level3" style="margin-left:3px; padding:3px; color:#464646;display:none;" onchange="GetOtherRack1('4',$('#level3 option:selected') .val())">
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
</select></td>
<td><select id="level4" name="level4" style="margin-left:3px; padding:3px; color:#464646;display:none;">
<%
if(rcode.length()>0&&rcode.length()>=12){
    ArrayList<Directory> rcklist3=GetRacklistByRockcode(rcode.substring(0,9));   
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
</select></td>
</tr></table>
</td>
</tr>
<tr ><td colspan="2">店内分类：
<select id="g_level1" name="g_level1" style="padding:3px; color:#464646;">
<option value="">全部</option>

<%
		List<ShopRck> shoprcklist=getShopRckList(shopCode,0);
		int num=0;
	 	 if(shoprcklist!=null){
	 		num=shoprcklist.size();
	 	
	 	 } if(shoprcklist!=null){
         for(ShopRck sprck:shoprcklist){
        	String shoprck_id= sprck.getId();
        	String shoprck_name= sprck.getShoprck_name();
        	List<ShopRck> shoprcklist2=getShopRckList(shopCode,Tools.parseInt(sprck.getId()));
        	int parentnum=0;
       	 if(shoprcklist2!=null){
       	  parentnum=shoprcklist2.size();
       	
       	 }
        	 %>
        	  <option value="<%=shoprck_id%>"><%=shoprck_name %></option>
        	 <%
        	 if(shoprcklist2!=null){
        		 int inum=0;
             for(ShopRck sprck2:shoprcklist2){
            	 shoprck_id= sprck2.getId();
            	 shoprck_name= sprck2.getShoprck_name();
        if (inum+1!=parentnum){
        	   shoprck_name="├"+shoprck_name;
             }else{
            	  shoprck_name="└"+shoprck_name;
             }%>
           <option value="<%=shoprck_id%>"><%=shoprck_name %></option>
           <%
            	inum++;
            }
             }
        	 }
         } %>
</select>

<input type="hidden" value="<%=pp %>" id="pph"></input>
<input type="hidden" value="<%=flag %>" id="fh"></input>
<input type="hidden" value="<%= rcode %>" id="ch"></input>
<input type="hidden" value="<%= scode %>" id="sh"></input></td></tr>
<tr><td colspan="2" c style="text-align:right;">
<a href="javascript:void(0)" onclick="Search_M();"><img src="/admin/SHManage/images/search.png"/></a>&nbsp;&nbsp;&nbsp;&nbsp;
</td></tr>
</table>
<%

   
    String ggURL = Tools.addOrUpdateParameter(request,null,null);
    ArrayList<Product> productList =new ArrayList<Product>();
    if(!Tools.isNull(act)||!Tools.isNull(pp)||!Tools.isNull(name)||!Tools.isNull(gdsid)||!Tools.isNull(flag)|| begins!=null||ends!=null||!Tools.isNull(rcode)||!Tools.isNull(scode)||!Tools.isNull(sjcode)){
    productList=getProduct(session.getAttribute("shopcodelog").toString(),pp,name,gdsid,flag,begins,ends,rcode,scode,sjcode);
    }
   
    int totalLength = (productList != null ?productList.size() : 0);
    int PAGE_SIZE = 20 ;
    int currentPage = 1 ;
    String pg = request.getParameter("pageno");
    if(StringUtils.isDigits(pg))currentPage = Integer.parseInt(pg);
    PageBean pBean = new PageBean(totalLength,PAGE_SIZE,currentPage);   
    int end = pBean.getStart()+PAGE_SIZE;
    if(end > totalLength) end = totalLength;  
    String pageURL = ggURL.replaceAll("pageno=[0-9]+","&");
    if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
    pageURL = pageURL.replaceAll("&+", "&");    
    if(productList != null && !productList.isEmpty()){  	  
 	   List<Product> gList = productList.subList(pBean.getStart(),end);
 	   if(gList != null && !gList.isEmpty()){
	   %>
	   <br/>
	   <br/>
	   <table cellpadding="0" cellspacing="0" border="0" id="gtable" width="100%"> 
	   <tr><td colspan="13">
	   <table cellpadding="0" cellspacing="0" border="0" width="100%" >
	    <tr style="background:#deefff; ">
	   
	   <td style="width:5%;border:solid 1px #ccc;border-right:none; text-align:center;"> <input type="checkbox" id="allSelect" name="allselect" width="5%" onclick="SelectAll(this)" style="display:none;"></input></td>
	   <td width="80%"style="height:45px;border:solid 1px #ccc;border-left:none;border-right:none; valign="middle">	   
	    &nbsp;&nbsp;<a href="javascript:void(0)" onclick="" style="display:none;"><img src="/admin/SHManage/images/sj1.png" vertical-align="middle"/></a>
	    &nbsp;&nbsp;<a href="javascript:void(0)" onclick="" style="display:none;"><img src="/admin/SHManage/images/xj.png" vertical-align="middle"/></a>
	    &nbsp;&nbsp;<a href="javascript:void(0)" onclick="" style="display:none;"><img src="/admin/SHManage/images/bjdnfl.png" vertical-align="middle"/></a>
	    &nbsp;&nbsp;<a href="javascript:void(0)" onclick="" style="display:none;"><img src="/admin/SHManage/images/szfbt.png" vertical-align="middle"/></a>
	    &nbsp;&nbsp;<a href="javascript:void(0)" onclick="" style="display:none;"><img src="/admin/SHManage/images/xzglbs.png" vertical-align="middle"/></a>
	   </td>
	   <td  valign="middle" style="width:15%; border:solid 1px #ccc;border-left:none; text-align:right;"><a href="/admin/SHManage/ProductLr.jsp" style="display:none;"><img src="/admin/SHManage/images/addnewg.png"/></a>&nbsp;&nbsp;</td></tr>
	   </table>
	   </td></tr>
	  
	  <tr height="30" style="background:#f7f7f7;text-align:center;">
	   <td style="border-left:solid 1px #ccc; border-bottom:dashed 1px #959595;" width="3%">选择</td>
	   <td width="6%" style=" border-bottom:dashed 1px #959595;">商品编号</td>
	   <td width="6%" style=" border-bottom:dashed 1px #959595;">图片</td>
	   <td width="6%" style=" border-bottom:dashed 1px #959595;">商品名称</td>
	   <td width="6%" style=" border-bottom:dashed 1px #959595;">品牌</td>
	   <td width="6%" style=" border-bottom:dashed 1px #959595;">商家编码</td>
	   <td width="6%" style=" border-bottom:dashed 1px #959595;">所属类目</td>
	   <td width="3%" style=" border-bottom:dashed 1px #959595;">市场价</td>
	   <td width="3%" style=" border-bottom:dashed 1px #959595;">D1价</td>
	   <td width="6%" style=" border-bottom:dashed 1px #959595;">库存</td>
	   <td width="6%" style=" border-bottom:dashed 1px #959595;">商品状态</td>
	   <td width="6%" style=" border-bottom:dashed 1px #959595;">更新时间</td>
	   <td width="6%" style=" border-bottom:dashed 1px #959595;border-right:solid 1px #ccc;">操作</td></tr>
	   <%
	      //遍历商品
	      int count=2;
	      for(Product p:gList)
	      {
	    	  if(p!=null)
	    	  { count++;
	    	   Directory dir=DirectoryHelper.getById(p.getGdsmst_rackcode());
	    	  
	    	  %>
	    		<tr id="tr_<%=p.getId() %>"><td height="70" style="background:#deefff;border-left:solid 1px #ccc;border-bottom:solid 1px #ccc; text-align:center; "><input type="checkbox" name="sgoods"></input></td>
	    		<td style="border-right:solid 1px #ccc;border-bottom:solid 1px #ccc; text-align:center; "><img src="/admin/SHManage/images/add.jpg" style="vertical-align:middle;" attr="<%= count %>" onclick="Bind_SKU('<%= p.getId() %>',this)"/><%=p.getId() %></td>
	    		<td style="border-right:solid 1px #ccc;border-bottom:solid 1px #ccc; text-align:center; "><a href="<%= !Tools.isNull(p.getGdsmst_midimg())&&p.getGdsmst_midimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_midimg())?"":p.getGdsmst_midimg() %>" target="_blank"><img src="<%= !Tools.isNull(p.getGdsmst_midimg())&&p.getGdsmst_midimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_midimg())?"":p.getGdsmst_midimg() %>" width="50" height="50"/></a></td>
	            <td style="border-right:solid 1px #ccc;border-bottom:solid 1px #ccc;  "><a href="http://www.d1.com.cn/product/<%=p.getId() %>" target="_blank" style="color:#333; text-decoration:none;"><%=Tools.isNull(p.getGdsmst_gdsname())?"":p.getGdsmst_gdsname() %></a></td>
	            <td style="border-right:solid 1px #ccc;border-bottom:solid 1px #ccc; text-align:center; "><%=Tools.isNull(p.getGdsmst_brandname())?"":p.getGdsmst_brandname() %></td>
	            <td style="border-right:solid 1px #ccc;border-bottom:solid 1px #ccc; text-align:center; "><%=Tools.isNull(p.getGdsmst_shopgoodscode())?"":p.getGdsmst_shopgoodscode() %></td>
	    		<td style="border-right:solid 1px #ccc;border-bottom:solid 1px #ccc; text-align:center; "><%= Tools.isNull(p.getGdsmst_rackcode())||dir==null?"":dir.getRakmst_rackname() %></td>
	    		<td style="border-right:solid 1px #ccc;border-bottom:solid 1px #ccc; text-align:center; "><input type="text" style="width:35px; " id="scj_<%= p.getId() %>" value="<%=Tools.isNull(p.getGdsmst_saleprice().toString())?"":Tools.getFloat(p.getGdsmst_saleprice(), 1) %>"></input></td>
	    		<td style="border-right:solid 1px #ccc;border-bottom:solid 1px #ccc; text-align:center; "><input type="text" style="width:35px;  " id="mj_<%= p.getId() %>" value="<%=Tools.isNull(p.getGdsmst_memberprice().toString())?"":Tools.getFloat(p.getGdsmst_memberprice(), 1) %>"></input></td>
	    		<%p = (Product)Tools.getManager(Product.class).get(p.getId()); 
	    		if(p != null &&!p.getGdsmst_skuname1().equals("")&&!p.getGdsmst_skuname1().equals("无")){
	    			//获取库存
	 	    	      long sku_stock=0;
	 	    	      ArrayList<Sku> skulist=getSkuListViaProductId(p.getId());
	    		      if(skulist!=null&&skulist.size()>0){
	    		    	for(Sku s:skulist)
	    		    	{
	    		    	   if(s!=null)
	    		    	   {
	    		    		   sku_stock+=s.getSkumst_stock();
	    		    	   }
	    		    	}
	    		      }
	    		    %> 
	    		    <td style="border-right:solid 1px #ccc;border-bottom:solid 1px #ccc; text-align:center; "><%= sku_stock %></td> 
	    			<%}
	    			else
	    			{ %>
	    			<td style="border-right:solid 1px #ccc;border-bottom:solid 1px #ccc; text-align:center; "><%= Tools.isNull(p.getGdsmst_stock().toString())?"":p.getGdsmst_stock() %></td>	
	    			<%}%>
	    		
	    		<td style="border-right:solid 1px #ccc;border-bottom:solid 1px #ccc; text-align:center; "><select id="vflag_<%= p.getId() %>" style="width:90px; font-size:11px;">
	    		                                                                                                <option value="-2" >请选择</option>
	    		                                                                                                <% if(!Tools.isNull(p.getGdsmst_validflag().toString())&&p.getGdsmst_validflag()==0){ %>
	    		                                                                                                <option value="0"  selected="true">录入待上架</option>	 
	    		                                                                                                <%} else{%>   		                                                                                                
	    		                                                                                                <option value="1" <% if(!Tools.isNull(p.getGdsmst_validflag().toString())&&p.getGdsmst_validflag()==1){ %> selected="true"<%} %>>上架</option>
	    		                                                                                                <option value="2" <% if(!Tools.isNull(p.getGdsmst_validflag().toString())&&p.getGdsmst_validflag()==2){ %> selected="true"<%} %>>下架</option>
                                                                                                                <%} %>
	    		                                                                                                </select></td>
	    		<td style="border-right:solid 1px #ccc;border-bottom:solid 1px #ccc; text-align:center; "><%=   sdf.format(p.getGdsmst_updatedate()) %></td>
	    		<td style="border-right:solid 1px #ccc;border-bottom:solid 1px #ccc; text-align:center; "><a href="/admin/SHManage/UpdateP.jsp?id=<%=p.getId() %>" style="color:#27408B;text-decoration:none;">编辑</a>
	    		<!-- &nbsp;&nbsp;<a href="javascript:void(0)" onclick="Delete_Product('<%= p.getId() %>')" style="color:#27408B;">删除</a> -->
	    		<br/><a href="javascript:void(0)" onclick="KJUpdate('<%= p.getId() %>')" style="color:#27408B; text-decoration:none;">快捷修改</a>
	    		</td>
	    		</tr>  
	    	  <%}
	      }	 
       if(pBean.getTotalPages()>1){
       %>
       <tr><td colspan="13" height="50" width="100%" style="text-align:center;">
       <div class="GPager">
       	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
       	<%if(pBean.getCurrentPage()>1){ %>
       	<a href="<%=pageURL.substring(0, pageURL.length()-1) %>">首页</a><%}%>
       	<%if(pBean.hasPreviousPage()){%><a href="<%=pageURL.substring(0, pageURL.length()-1)%><% if(pBean.getPreviousPage()!=1) {%>&pageno=<%=pBean.getPreviousPage()%><%}%>">上一页</a><%}%>
       	<%
       	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
       		if(i==currentPage){
       		%><span class="curr"><%=i %></span><%
       		}else{
       			if(i==1)
       			{%>
       				<a href="<%=pageURL.substring(0, pageURL.length()-1) %>"><%=i %></a>
       			<%}
       			else
       			{
       		%><a href="<%=pageURL %>pageno=<%=i %>"><%=i %></a><%
       		    }
       		}
       	}%>
       	<%if(pBean.hasNextPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getNextPage()%>">下一页</a><%}%>
       	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="<%=pageURL %>pageno=<%=pBean.getTotalPages() %>">尾页</a><%} %>
       </div></td></tr><%}%>
        </table>
       <%}
 	  
    }
    else
	   {%>
		 <div>没有满足条件的商品！！！</div>  
	   <%}
%>
   
   </td>
   </tr>
</table>

</div>
</form>
</body>
</html>
<script type="text/javascript">
  Bind_SM($('#pph').val(),$('#ch').val(),$('#fh').val());
 </script>
