<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%>
<%@include file="/inc/header.jsp"%>
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
<%!
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
    String gdsid=request.getParameter("gdsid");
   String gdsbarcode=request.getParameter("gdsbarcode");
	String shopgoodscode=request.getParameter("sc");
	String g_name=request.getParameter("name");
	String ename=request.getParameter("ename");
	String code=request.getParameter("code");
	String bname=request.getParameter("bname");
	if(bname.equals("无品牌")){
		bname="";
	}
	String shoprck=request.getParameter("shoprck");
	if(!Tools.isNull(shoprck)){
		shoprck=","+shoprck;
	}
	String scj=request.getParameter("scj");
	float scjn=Tools.parseFloat(scj);
	String m=request.getParameter("m");
	//String inp=request.getParameter("inp");
	float mn=Tools.parseFloat(m);
	String cxj=request.getParameter("cxj");
	float cxjn=Tools.parseFloat(cxj);
	String zk=request.getParameter("zk");
	String cd=request.getParameter("cd");
	String begin=request.getParameter("begin");
	String end=request.getParameter("end");
	String des=request.getParameter("des");
	String ddes=request.getParameter("ddes");
	String a1=request.getParameter("a1");
	String provider=request.getParameter("provider");
	String othercost=request.getParameter("othercost");
	String specialflag=request.getParameter("specialflag");
	if(Tools.isNull(othercost)||othercost.equals("null")){
		othercost="0";
	}
	
	if(a1.indexOf(",")>0) { a1=a1.substring(0, a1.length()-1);}
	String a2=request.getParameter("a2");
	if(a2.indexOf(",")>0) { a2=a2.substring(0, a2.length()-1);}
	String a3=request.getParameter("a3");
	if(a3.indexOf(",")>0) { a3=a3.substring(0, a3.length()-1);}
	String a4=request.getParameter("a4");
	if(a4.indexOf(",")>0) { a4=a4.substring(0, a4.length()-1);}
	String a5=request.getParameter("a5");
	if(a5.indexOf(",")>0) { a5=a5.substring(0, a5.length()-1);}
	String a6=request.getParameter("a6");
	if(a6.indexOf(",")>0) { a6=a6.substring(0, a6.length()-1);}
	String a7=request.getParameter("a7");
	if(a7.indexOf(",")>0) { a7=a7.substring(0, a7.length()-1);}
	String a8=request.getParameter("a8");
	if(a8.indexOf(",")>0) { a8=a8.substring(0, a8.length()-1);}
	String a9=request.getParameter("a9");
	if(a9.indexOf(",")>0) { a9=a9.substring(0, a9.length()-1);}
	String a10=request.getParameter("a10");
	if(a10.indexOf(",")>0) { a10=a10.substring(0, a10.length()-1);}
	String a11=request.getParameter("a11");
	if(a11.indexOf(",")>0) { a11=a11.substring(0, a11.length()-1);}
	String a12=request.getParameter("a12");
	if(a12.indexOf(",")>0) { a12=a12.substring(0, a12.length()-1);}
	
	String sku=request.getParameter("skuname");
	if(sku.equals("无")){
		sku="";
	}
	String bcode=request.getParameter("bcode");
	String flag=request.getParameter("f");
	String sku1=request.getParameter("sku");
	String provide=request.getParameter("provide");
	String gdsmst_provideStr=request.getParameter("gdsmst_provideStr");
	if(Tools.isNull(gdsid))
	{
		out.print("{\"success\":false,\"message\":\"商品id不存在！\"}");
		return;
	}
	Product product=ProductHelper.getById(gdsid);
	if(product==null)
	{
		out.print("{\"success\":false,\"message\":\"商品不存在！\"}");
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
		boolean is_add = chk_admpower(userid,"d1shop_gdsadd");
		if(is_add==true && is_edit==false){//有录入权限没有维护权限
			if(product.getGdsmst_validflag() != null){
				if(Tools.parseLong(flag) != product.getGdsmst_validflag()){
					out.print("{\"success\":false,\"message\":\"录入员不能修改商品的状态！\"}");
					return;
				}
				if(product.getGdsmst_validflag()!=0){
					out.print("{\"success\":false,\"message\":\"录入员只能修改录入待上架的商品！\"}");
					return;
				}
			}
			if(product.getGdsmst_inputmngid() != null && !product.getGdsmst_inputmngid().equals(unique_c)){
				out.print("{\"success\":false,\"message\":\"录入员只能修改自己录入的商品！\"}");
				return;
			}
		}
	}
	
	String shopCode=session.getAttribute("shopcodelog").toString();
	   if(!product.getGdsmst_shopcode().equals(shopCode)){
		   out.print("{\"success\":false,message:\"此商品不是商户的商品不能修改！\"}");
			return;
	   }
	/*if(product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag()==0&&Tools.parseInt(flag)!=0)
	   {
		   out.print("{\"success\":false,message:\"此商品未审核，不能修改状态！\"}");
			return;
	   }*/
	//判断金钱
	if(!Tools.isMoney(scj))
	{
		out.print("{\"success\":false,\"message\":\"市场价不是有效的金钱格式！\"}");
		return;
	}
	if(!Tools.isMoney(m))
	{
		out.print("{\"success\":false,\"message\":\"D1价不是有效的金钱格式！\"}");
		return;
	}

	/*if(!Tools.isMoney(inp))
	{
		inp="0";
	}*/
	

	if(!Tools.isNull(cxj)&&!Tools.isMoney(cxj))
	{
		out.print("{\"success\":false,\"message\":\"促销价不是有效的金钱格式！\"}");
		return;
	}
	if(Tools.parseFloat(cxj)==0f){
		begin=null;
		end=null;
	}
	SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	
	if(!Tools.isNull(begin)&&!Tools.isNull(end))
	{
	    Date dabegin=new Date();
	   long b=Tools.parseJsDate(begin);
	    long e=Tools.parseJsDate(end);
	    if(sf.parse(begin).getTime()>= sf.parse(end).getTime())
	    {
	    	out.print("{\"success\":false,\"message\":\"促销开始时间不得大于等于促销结束时间！\"}");
	    	return;
	    }	    
	    if(Tools.getDateDiff(ft.format(ft.parse(begin)),ft.format(ft.parse(end)))>=31){
	    	out.print("{\"success\":false,\"message\":\"促销时间范围在30天内！\"}");
	    	return;
	    }
	}
	
	
	//获取规格id
	/*
	String stdid="";
	Directory dir=DirectoryHelper.getById(code);
	if(dir!=null)
	{
		if(dir.getRakmst_stdid()!=null&&dir.getRakmst_stdid().toString().length()>0)
		{			
			stdid=dir.getRakmst_stdid().toString();			
		}
		else
		{
			Directory dir1=DirectoryHelper.getById(dir.getRakmst_parentrackcode());
			if(dir1!=null&&dir1.getRakmst_stdid().length()>0)
			{				
				stdid=dir1.getRakmst_stdid();
			}
		}
	}
	*/
	
	//向表里添加数据
	 //SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
	//修改商品	
	product.setGdsmst_shopgoodscode(shopgoodscode);
	product.setGdsmst_barcode(gdsbarcode);
	product.setGdsmst_validflag(new Long(flag));
	product.setGdsmst_title(ename);
	product.setGdsmst_gdsname(g_name);	
	product.setGdsmst_brand(bcode);	
	product.setGdsmst_brandname(bname);
	product.setGdsmst_briefintrduce(des);	
	product.setGdsmst_detailintruduce(ddes);	
	product.setGdsmst_memberprice(new Float(m));
	//product.setGdsmst_inprice(new Float(inp));
	product.setGdsmst_saleprice(new Float(scj));
	product.setGdsmst_rackcode(code);
	product.setGdsmst_skuname1(sku);
	product.setGdsmst_stdvalue1(a1);
	product.setGdsmst_stdvalue2(a2);
	product.setGdsmst_stdvalue3(a3);
	product.setGdsmst_stdvalue4(a4);
	product.setGdsmst_stdvalue5(a5);
	product.setGdsmst_stdvalue6(a6);
	product.setGdsmst_stdvalue7(a7);
	product.setGdsmst_stdvalue8(a8);
	product.setGdsmst_stdvalue9(a9);
	product.setGdsmst_stdvalue10(a10);
	product.setGdsmst_stdvalue11(a11);
	product.setGdsmst_stdvalue12(a12);
	product.setGdsmst_shoprck(shoprck);
	product.setGdsmst_updatedate(new Date());	
    product.setGdsmst_provenance(cd);
    if(specialflag.equals("1")){		
	    product.setGdsmst_specialflag(new Long(1));
	}
	else
	{                     
		product.setGdsmst_specialflag(new Long(0));	
	}
    product.setGdsmst_modimngid(unique_c);//修改人
    
    product.setGdsmst_othercost(new Float(othercost));
	product.setGdsmst_provider(provider);
	product.setGdsmst_provide(provide);//主要供应商
	product.setGdsmst_provideStr(gdsmst_provideStr);//其他供应商
	if(begin!=null&&begin.length()>0)
	{
	    product.setGdsmst_promotionstart(sf.parse(begin));
	}else{
		product.setGdsmst_promotionstart(null);
	}
	if(end!=null&&end.length()>0)
	{
		 product.setGdsmst_promotionend(sf.parse(end));
	   // product.setGdsmst_discountenddate(format.parse(end));
	}else{
		product.setGdsmst_promotionend(null);
	}
	/*if(!Tools.isNull(cxj)){
		
		product.setGdsmst_oldmemberprice(new Float(m));
		product.setGdsmst_memberprice(new Float(cxj));
		product.setGdsmst_oldvipprice(new Float(m));
		product.setGdsmst_vipprice(new Float(cxj));
	}
	else
	{*/
		if(!Tools.isNull(cxj)){
			product.setGdsmst_msprice(new Float(cxj));
			}else{
				product.setGdsmst_msprice(new Float(0));
			}
		product.setGdsmst_oldmemberprice(0f);
		product.setGdsmst_memberprice(new Float(m));
		product.setGdsmst_oldvipprice(0f);
		product.setGdsmst_vipprice(new Float(m));
		String kc1=request.getParameter("kc1");
		if(request.getParameter("skuname").equals("无")){
			product.setGdsmst_stock(new Long(kc1));//库存
			product.setGdsmst_virtualstock(new Long(kc1));
		}
	//}    
    
    if(Tools.getManager(Product.class).update(product,true))
    {
    	if(!request.getParameter("skuname").equals("无")){
    	//修改sku
    	if(sku1.length()==0){
 		   out.print("{\"success\":true,message:\"修改商品信息成功！\"}");
 			return; 
 	   }else{
 		   if(sku1.indexOf(",")>0)
 		   {
 			   sku1=sku1.substring(0, sku1.length()-1);
 		   }
 		   String[] slist=sku1.split(",");
 		   if(slist!=null&&slist.length>0)
 		   {
 			   //删除该该商品的所有Sku
 			   ArrayList<Sku> skulist=getSkuListViaProductId(product.getId());
 			   if(skulist!=null&&skulist.size()>0)
 			   {
 				   for(Sku s:skulist)
 				   {
 					   if(s!=null)
 					   {
 						   Tools.getManager(Sku.class).delete(s);
 					   }
 				   }
 			   }
 			   for(String str:slist)
 			   { 		
 				
 				   try{
 					   String skuid=str.split("@")[0];
 					   String name=str.split("@")[1];
					   String stock=str.split("@")[2];
					   String sflag=str.split("@")[3];
					   String vstock=str.split("@")[4];
					   if(stock.equals("")){stock="0";}
					   if(vstock.equals("")){vstock="0";}
 							Sku skunew=new Sku();
 							skunew.setSkumst_createdate(new Date());
 							skunew.setSkumst_gdsid(gdsid);
 							skunew.setSkumst_sku1(name);
 							skunew.setSkumst_stock(new Long(stock));
 							skunew.setSkumst_vstock(new Long(stock));
 							skunew.setSkumst_validflag(new Long(sflag));
 							skunew.setSkumst_sku2("");
 							skunew=(Sku)Tools.getManager(Sku.class).create(skunew);
 					 
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
    }else{
    	 if(sku1.indexOf(",")>0){
			   sku1=sku1.substring(0, sku1.length()-1);
		 }
		 String[] slist=sku1.split(",");
		 if(slist!=null&&slist.length>0){
			   //删除该该商品的所有Sku
		   ArrayList<Sku> skulist=getSkuListViaProductId(product.getId());
		   if(skulist!=null&&skulist.size()>0){
			   for(Sku s:skulist){
				   if(s!=null){
					   Tools.getManager(Sku.class).delete(s);
				   }
			   }
		   }
		 }
		 out.print("{\"success\":true,message:\"修改商品信息和Sku库存信息成功！\"}");
		 return;
    }
    }
    else
    {
    	out.print("{\"success\":false,\"message\":\"修改商品失败，请联系客服！\"}");
    }
	
	
%>