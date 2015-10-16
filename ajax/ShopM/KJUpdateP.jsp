<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
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
<%
   //gdsid:gid,sale:s,m:m1,f:flag,sku:sku
   String gdsid=request.getParameter("gdsid");
   if(Tools.isNull(gdsid)){
	    out.print("{\"success\":false,message:\"商品id不存在！\"}");
		return;
   }
   Product p =ProductHelper.getById(gdsid);
   if(p==null)
   {
	   out.print("{\"success\":false,message:\"商品不存在！\"}");
		return;
   }
   String flag=request.getParameter("f");
   if(flag.equals(""))
   {
	   out.print("{\"success\":false,message:\"请选择商品状态！\"}");
		return;
   }
    String unique_c = "";
	if(session.getAttribute("unique_code") != null){
		unique_c= session.getAttribute("unique_code").toString();
	}
 	//判断录入员修改信息的时候，商品的状态是不是未上架
 	if(session.getAttribute("type_flag")!=null){
 		String userid = "";
 		if(session.getAttribute("admin_mng") != null){
 			userid = session.getAttribute("admin_mng").toString();
 		}
 		boolean is_edit = chk_admpower(userid,"d1shop_gdsedit");
 		boolean is_add =  chk_admpower(userid,"d1shop_gdsadd");
 		if(is_add == true && is_edit==false){//有录入权限没有维护权限
			if(p.getGdsmst_validflag() != null){
				if(Tools.parseLong(flag) != p.getGdsmst_validflag()){
					out.print("{\"success\":false,\"message\":\"录入员不能修改商品的状态！\"}");
					return;
				}
				if(p.getGdsmst_validflag()!=0){
					out.print("{\"success\":false,\"message\":\"录入员只能修改录入待上架的商品！\"}");
					return;
				}
			}
			if(p.getGdsmst_inputmngid() != null && !p.getGdsmst_inputmngid().equals(unique_c)){
				out.print("{\"success\":false,\"message\":\"录入员只能修改自己录入的商品！\"}");
				return;
			}
		}
 	}
 
   String shopCode=session.getAttribute("shopcodelog").toString();
   if(!p.getGdsmst_shopcode().equals(shopCode)){
	   out.print("{\"success\":false,message:\"此商品不是商户的商品不能修改！\"}");
		return;
   }
   /*
   if(p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag()==0)
   {
	   out.print("{\"success\":false,message:\"此商品未审核，不能修改状态！\"}");
		return;
   }*/
   String s=request.getParameter("sale");
   if(s.equals("")){
	   out.print("{\"success\":false,message:\"请填写市场价！\"}");
		return;
   }
   if(!Tools.isMoney(s)){
	   out.print("{\"success\":false,message:\"市场价不是有效的金钱格式！\"}");
		return;
   }
   String m=request.getParameter("m");
   if(m.equals("")){
	   out.print("{\"success\":false,message:\"请填写D1价！\"}");
		return;
   }
   if(!Tools.isMoney(m)){
	   out.print("{\"success\":false,message:\"D1价不是有效的金钱格式！\"}");
		return;
   }
   if(Tools.parseFloat(s)<Tools.parseFloat(m))
   {
	   out.print("{\"success\":false,message:\"D1价得大于市场价！\"}");
		return;
   }
  
   String sku=request.getParameter("sku");
   //修改商品
   p.setGdsmst_saleprice(new Float(s));
   p.setGdsmst_memberprice(new Float(m));
   p.setGdsmst_validflag(new Long(flag));
   p.setGdsmst_modimngid(unique_c);//修改人
   
   if(Tools.getManager(Product.class).update(p, true))
   {
	   if(sku.length()==0){
		   out.print("{\"success\":true,message:\"修改商品信息成功！\"}");
			return; 
	   }
	   else
	   {
		   if(sku.indexOf(",")>0)
		   {
			   sku=sku.substring(0, sku.length()-1);
		   }
		   String[] slist=sku.split(",");
		   if(slist!=null&&slist.length>0)
		   {
			   for(String str:slist)
			   {
				   try{
					   Sku skuitem=SkuHelper.getById(str.split("@")[0]);
					   int stock=Tools.parseInt(str.split("@")[1]);
					   if(skuitem!=null)
					   {
						   skuitem.setSkumst_stock(new Long(stock));
						   Tools.getManager(Sku.class).update(skuitem,true);
						   
					   }
					   else
					   {
						   out.print("{\"success\":false,message:\"Sku信息获取失败！\"}");
							return;
					   }
				   }
				   catch(Exception e){
					   out.print("{\"success\":false,message:\"修改Sku的库存信息失败！\"}");
						return;
				   }
			   }
			  
		   }
		   out.print("{\"success\":true,message:\"修改商品信息和Sku库存信息成功！\"}");
			return;
		   
	   }
   }
   else
   {
	   out.print("{\"success\":false,message:\"修改商品信息失败！\"}");
		return;
   }
%>