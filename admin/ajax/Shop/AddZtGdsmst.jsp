<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>

<%
String sid="";
String gid="";
String c="";
String fp="";
String fc="";

String shopinfo_title = "";
if(request.getParameter("shopinfo_title")!=null){
	shopinfo_title = request.getParameter("shopinfo_title");
}
if(request.getParameter("sid")!=null)
{
	sid=request.getParameter("sid");
}
if(request.getParameter("goods")!=null)
{
	gid=request.getParameter("goods");
}
if(request.getParameter("color")!=null)
{
	c=request.getParameter("color");
}
/*
if(request.getParameter("fpos")!=null)
{
	fp=request.getParameter("fpos");
}*/
if(request.getParameter("fcon")!=null)
{
	fc=request.getParameter("fcon");
}
if(Tools.isNull(sid)){
	out.print("{\"succ\":false,message:\"商户信息id不能为空！\"}");
    return;
}

if(Tools.isNull(shopinfo_title)){
	out.print("{\"succ\":false,message:\"专题名称不能为空！\"}");
    return;
}

if(Tools.isNull(c)||c.length()!=6){
	out.print("{\"succ\":false,message:\"背景颜色值必须是6位，不用添加’#‘号！\"}");
    return;
}

ShopInfo sif=(ShopInfo)Tools.getManager(ShopInfo.class).get(sid);
if(sif==null && Integer.valueOf(sid)!=-1){
	out.print("{\"succ\":false,message:\"该商户信息不存在！\"}");
    return;
}
if(Integer.valueOf(sid)!=-1 && !sif.getShopinfo_shopcode().equals(session.getAttribute("shopcodelog").toString())){
	out.print("{\"succ\":false,message:\"您没有权限执行此操作！\"}");
    return;
}
String cwid="";
String noExsitsgid="";
String noqxgid="";
String zqgid="";
try{
	
	if(!Tools.isNull(gid)){
		//整理商品编号
		String[] goodsarr=gid.split(",");
		if(goodsarr!=null&&goodsarr.length>0){
			for(String str:goodsarr){
				if(Tools.isNull(str)||str.length()!=8 && str.length() != 4){
					cwid+=str+",";
				}
				if(str.length()==8){//商品编号
					Product p=ProductHelper.getById(str);
					if(p==null){
						noExsitsgid+=str+",";
					}
					if(p!=null&&!p.getGdsmst_shopcode().equals(session.getAttribute("shopcodelog").toString())&&!("13100902").equals(session.getAttribute("shopcodelog").toString())){//测试账户放开限制
						noqxgid+=str+",";
					}else{
						zqgid+=str+",";
					}
				}else if(str.length()==4){//推荐位号
					PromotionProduct pProduct_l = null;
					for(int z =0;z<goodsarr.length;z++){
					//根据推荐编码获得推荐商品信息列表
					 ArrayList<PromotionProduct> list=PromotionProductHelper.getPProductByCode(goodsarr[z],100);
					// System.out.println("---------------"+goodsarr[z]+"--"+list.size());
					 ArrayList gdsidlist=new ArrayList();
					 if(list!=null && list.size()>0){
					 	for(PromotionProduct pProduct:list){
					 		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
					 	}
					 	if(gdsidlist!=null && gdsidlist.size()>0){
						 	int i=0;
						 	//通过商品id过滤商品信息--有货
						 	ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
						 	//System.out.println("---------------"+goodsarr[z]+"--"+productlist.get(z).getGdsmst_shopcode());
						 	//if(productlist!=null){
						 		//for(Product product:productlist){
						 			//根据推荐位号,商品编号获得推荐商品信息
						 			//ArrayList<PromotionProduct> pproductlist= PromotionProductHelper.getPProductByCodeGdsid(goodsarr[z],product.getId());
						 			//Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
						 			//if(pproductlist!=null && directory!=null){
						 			//	pProduct_l=pproductlist.get(0); 
						 			//}
						 		//}
						 	//}
						 	if(productlist == null){
								noExsitsgid+=str+",";
							}
						 	if(productlist!=null&&!productlist.get(z).getGdsmst_shopcode().equals(session.getAttribute("shopcodelog").toString())&&!("13100902").equals(session.getAttribute("shopcodelog").toString())){
								noqxgid+=str+",";
							}else{
								zqgid+=str+",";
							}
							
						 }
					}
				}
					
				}
					
			}
		}
		
		if(cwid.length()>0||noExsitsgid.length()>0||noqxgid.length()>0){
			String msg="";
			if(cwid.length()>0){
				msg+="以下商品编号有误："+cwid.substring(0,cwid.length()-1)+";";
			}
			if(noExsitsgid.length()>0){
				msg+="以下商品不存在："+noExsitsgid.substring(0,noExsitsgid.length()-1)+";";
			}
			if(noqxgid.length()>0)
			{
				msg+="以下商品您没有权限操作："+noqxgid.substring(0,noqxgid.length()-1)+";";
			}
			out.print("{\"succ\":false,message:\"您选择的商品不符合条件，错误是（"+msg+"）\"}");
		    return;
		}	
    	zqgid=zqgid.substring(0,zqgid.length()-1);
	}
	String index_flag = "";
	if(session.getAttribute("index_flag") != null){
		index_flag = session.getAttribute("index_flag").toString();
	}
	
    //System.out.println("===="+Integer.valueOf(sid));
   if(Integer.valueOf(sid)==-1){//添加
	   sif = new ShopInfo();
		if(index_flag.equals("0")){
			sif.setShopinfo_indexflag(new Long(0));//0代表首页
		}else if(index_flag.equals("1")){
			sif.setShopinfo_indexflag(new Long(1));//1代表专题
			sif.setShopinfo_lineflag(1+"");
		}
		sif.setShopinfo_shopcode(session.getAttribute("shopcodelog").toString());
		sif.setShopinfo_createdate(new Date());
		sif.setShopinfo_title(shopinfo_title);
	    sif.setShopinfo_ztimglist(zqgid);
	    sif.setShopinfo_bgcolor(c);
	    sif.setShopinfo_floatcontent(fc);
	    ShopInfo sif_info = (ShopInfo)Tools.getManager(ShopInfo.class).create(sif);
	    if(sif_info.getId() != null ){
    		out.print("{\"succ\":true,shop_id:\""+sif_info.getId()+"\",message:\"添加主推商品、专题名称、背景颜色值成功！\"}");
    		//System.out.println("sif_info.getId===="+sif_info.getId());
    	    return;
    	}else{
    		out.print("{\"succ\":true,message:\"添加主推商品、专题名称、背景颜色值失败！\"}");
    	    return;
    	}
   }else{
	   if(sif.getShopinfo_indexflag() == null){
			if(index_flag.equals("0")){
				sif.setShopinfo_indexflag(new Long(0));//0代表首页
			}else if(index_flag.equals("1")){
				sif.setShopinfo_indexflag(new Long(1));//1代表专题
				sif.setShopinfo_lineflag(1+"");
			}
		}
		
		sif.setShopinfo_title(shopinfo_title);
	    sif.setShopinfo_ztimglist(zqgid);
	    sif.setShopinfo_bgcolor(c);
	    sif.setShopinfo_floatcontent(fc);
	    //sif.setShopinfo_floatposition(new Long(fp));
		if(Tools.getManager(ShopInfo.class).update(sif, true)){
			out.print("{\"succ\":true,message:\"添加主推商品、专题名称、背景颜色值成功！\"}");
		    return;
		}else{
			out.print("{\"succ\":false,message:\"添加主推商品、专题名称、背景颜色值失败！\"}");
			return;
		}
   }
}catch(Exception e){
	//out.print(e.getMessage());
	out.print("{\"succ\":false,message:\"添加主推商品、专题名称、背景颜色值出错，请稍后重试！\"}");
    return;
}

%>