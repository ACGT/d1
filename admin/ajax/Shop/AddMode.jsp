<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%@include file="/html/public.jsp"%>
<%!
/*
public static boolean getmsflag(Product p){//判断闪购
	Date nowday=new Date();
	 boolean ismiaoshao=false;
	 SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	 if(p.getGdsmst_promotionstart()!=null&&p.getGdsmst_promotionend()!=null&&p.getGdsmst_msprice()!=null){
	 	Date sdate=p.getGdsmst_promotionstart();
	 	Date edate=p.getGdsmst_promotionend();	

	 	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
	 			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
	 			&&p.getGdsmst_msprice().floatValue()>0f){
	 		ismiaoshao = true;
	 	}

	 }
	 if(ismiaoshao){
	 	ismiaoshao=CartHelper.getsgbuy(p.getId());
	 }
	 return ismiaoshao;
}*/
public static boolean getmsflag(Product p){//判断秒杀
	 boolean ismiaoshao=false;
	 if(p.getGdsmst_promotionstart()!=null&&p.getGdsmst_promotionend()!=null){
	 	ismiaoshao = true;
	 }
	 return ismiaoshao;
}
%>
<%
String mid="";
String type="";
String c="";
String t="";
String f="";
String s="";
String size="";
String shopid = "";
String model_txt = "";
String model_txtcolor = "";
String model_txtmore = "";
String shopmodel_balloon = "";
String shopmodel_balname = "";
long gdsnum=0;
if(request.getParameter("shopid")!=null)
{
	shopid=request.getParameter("shopid");
}
if(request.getParameter("mid")!=null)
{
	mid=request.getParameter("mid");
}
if(request.getParameter("type")!=null)
{
	type=request.getParameter("type");
}
if(request.getParameter("c")!=null)
{
	 c=request.getParameter("c");
}
if(request.getParameter("f")!=null)
{
	f=request.getParameter("f");
}
if(request.getParameter("size")!=null)
{
	size=request.getParameter("size");
}
if(request.getParameter("s")!=null)
{
	s=request.getParameter("s");
}
if(request.getParameter("t")!=null)
{
	t=request.getParameter("t");
}
if(request.getParameter("model_txt")!=null){
	model_txt=request.getParameter("model_txt");
}
if(request.getParameter("model_txtcolor")!=null){
	model_txtcolor=request.getParameter("model_txtcolor");
}
if(model_txtcolor.equals("0")){
	model_txtcolor="F65D57";	
}
if(request.getParameter("model_txtmore")!=null){
	model_txtmore=request.getParameter("model_txtmore");
}
if(request.getParameter("shopmodel_balloon")!=null){
	shopmodel_balloon=request.getParameter("shopmodel_balloon");
}
if(request.getParameter("shopmodel_balname")!=null){
	shopmodel_balname=request.getParameter("shopmodel_balname");
}
if(!Tools.isNull(request.getParameter("gdsnum"))){
	gdsnum=Tools.parseLong(request.getParameter("gdsnum"));
}
 
if(t.equals("0"))
{
  t="ffffff";	
}
if(Tools.isNull(type)){
	out.print("{\"succ\":false,message:\"模块类型不能为空！\"}");
    return;
}
if(Tools.isNull(c)){
	out.print("{\"succ\":false,message:\"模块详细不能为空！\"}");
    return;
}
//type为图文编辑器的时候验证a链接是否存在外链
if(type.equals("1") && !check_url(c)&&!("13100902").equals(session.getAttribute("shopcodelog").toString())){
	  out.print("{\"succ\":false,message:\"您所要保存的内容存在外链，请修改后保存！\"}");
	  return;
}
//if(Tools.isNull(t)){
	//out.print("{\"succ\":false,message:\"模块标题不能为空！\"}");
    //return;
//}
if(Tools.isNull(s)){
	out.print("{\"succ\":false,message:\"请填写排序值！\"}");
    return;
}
if(type.equals("2")){
	if(Tools.isNull(size)){
		out.print("{\"succ\":false,message:\"请选择图片尺寸！\"}");
	    return;
	}
}
String tm_flag = request.getParameter("tm_flag");
String shopmodel_orderflag = request.getParameter("shopmodel_orderflag");
String type_num = request.getParameter("type_num");//是否设置排序只存在于第一个模板，所以通过type_num判断是否是第一个模板，1为第一个模板
String cwid="";
String noExsitsgid="";
String noqxgid="";
String zqgid="";
ShopInfo shop_info=(ShopInfo)Tools.getManager(ShopInfo.class).get(shopid);
try{
	if(type.equals("2")&&!c.startsWith("$")){
		//整理商品编号
		
		String[] goodsarr=c.replace('，', ',').split(",");
		if(goodsarr!=null&&goodsarr.length>0){
			for(String str:goodsarr){
				if(Tools.isNull(str)||str.length()!=8 && str.length() != 4 && str.length() != 11){
					cwid+=str+",";
				}
				if(str.length()==8){//商品编号
					Product p=ProductHelper.getById(str);
					if(p==null&&str.length()==8){
						noExsitsgid+=str+",";
					}
					if(p!=null&&!p.getGdsmst_shopcode().equals(session.getAttribute("shopcodelog").toString())&&!("13100902").equals(session.getAttribute("shopcodelog").toString())){//测试账户放开限制
						noqxgid+=str+",";
					}
					else{
						zqgid+=str+",";
					}
					/*tm_flag>0表示前台勾选了'商品秒杀起止时间和特卖会起止时间一致', 
					先根据shopid从shopinfo取出数据，看看特卖的起止时间是否存在。
					若存在，判断商品有无秒杀，有的话，同步时间，没有，则不作处理。*/
					if(Integer.valueOf(tm_flag)>0 && shop_info != null){
						if(shop_info.getShopinfo_tmbegin()==null){
							out.print("{\"succ\":false,message:\"特卖会效果的开始时间为空！\"}");
						    return;
						}else if(shop_info.getShopinfo_tmend()==null){
							out.print("{\"succ\":false,message:\"特卖会效果的结束时间为空！\"}");
						    return;
						}else{
							if(getmsflag(p)){//判断商品有无秒杀
								p.setGdsmst_promotionstart(shop_info.getShopinfo_tmbegin());
								p.setGdsmst_promotionend(shop_info.getShopinfo_tmend());
								Tools.getManager(Product.class).update(p,true);
							}
						}
					}
					
				}else if(str.length()==4){//推荐位号
					PromotionProduct pProduct_l = null;
					for(int z =0;z<goodsarr.length;z++){
					//根据推荐编码获得推荐商品信息列表
					 ArrayList<PromotionProduct> list=PromotionProductHelper.getPProductByCode(goodsarr[z],100);
					 ArrayList gdsidlist=new ArrayList();
					 if(list!=null && list.size()>0){
					 	for(PromotionProduct pProduct:list){
					 		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
					 	}
					 	if(gdsidlist!=null && gdsidlist.size()>0){
						 	int i=0;
						 	//通过商品id过滤商品信息--有货
						 	ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
						 	/*if(productlist!=null){
						 		for(Product product:productlist){
						 			//根据推荐位号,商品编号获得推荐商品信息
						 			ArrayList<PromotionProduct> pproductlist= PromotionProductHelper.getPProductByCodeGdsid(goodsarr[z],product.getId());
						 			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
						 			if(pproductlist!=null && directory!=null){
						 				pProduct_l=pproductlist.get(0); 
						 			}
						 		}
						 	}*/
						 	if(productlist == null){
								noExsitsgid+=str+",";
							}
							if(productlist!=null&&!productlist.get(z).getGdsmst_shopcode().equals(session.getAttribute("shopcodelog").toString())&&!("13100902").equals(session.getAttribute("shopcodelog").toString())){
								noqxgid+=str+",";
							}else{
								zqgid+=str+",";
							}
							
							/*tm_flag>0表示前台勾选了'商品秒杀起止时间和特卖会起止时间一致', 
							先根据shopid从shopinfo取出数据，看看特卖的起止时间是否存在。
							若存在，判断商品有无秒杀，有的话，同步时间，没有，则不作处理。*/
							if(Integer.valueOf(tm_flag)>0 && shop_info != null){
								for(Product p:productlist){
									if(shop_info.getShopinfo_tmbegin()==null){
										out.print("{\"succ\":false,message:\"特卖会效果的开始时间为空！\"}");
									    return;
									}else if(shop_info.getShopinfo_tmend()==null){
										out.print("{\"succ\":false,message:\"特卖会效果的结束时间为空！\"}");
									    return;
									}else{
										if(getmsflag(p)){//判断商品有无秒杀
											p.setGdsmst_promotionstart(shop_info.getShopinfo_tmbegin());
											p.setGdsmst_promotionend(shop_info.getShopinfo_tmend());
											Tools.getManager(Product.class).update(p,true);
										}
									}
							   }
					 	  }
						 }
					}
				}
				}else if(str.length()==11 && str.indexOf("all")>0){//代表是商户编号+all
					zqgid+=str+",";
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
	}
	
	
	ShopModel sm=new ShopModel();
	if(mid.equals("")){
		sm.setShopmodel_flag(new Long(f));
		sm.setShopmodel_shopcode(session.getAttribute("shopcodelog").toString());
		sm.setShopmodel_sort(new Long(s));
		sm.setShopmodel_gdsnum(new Long(gdsnum));
		//sm.setShopmodel_title(t); lsx注释掉的
		sm.setShopmodel_type(new Long(type));
		if(type.equals("1")){
			sm.setShopmodel_content(c);
			sm.setShopmodel_list("");
			sm.setShopmodel_size(null);
		}
		else
		{
			sm.setShopmodel_content("");
			sm.setShopmodel_list(zqgid);
			sm.setShopmodel_size(new Long(size));
			sm.setShopmodel_txt(model_txt);
			sm.setShopmodel_txtcolor(model_txtcolor);
			sm.setShopmodel_txtmore(model_txtmore);
			sm.setShopmodel_balloon(new Long(shopmodel_balloon));
			sm.setShopmodel_balname(shopmodel_balname);
			if(type_num.equals("1")){
				sm.setShopmodel_orderflag(new Long(shopmodel_orderflag));
			}
		}
		sm.setShopmodel_createdate(new Date());
		sm.setShopmodel_infoid(new Long(shopid));
		sm=(ShopModel)Tools.getManager(ShopModel.class).create(sm);
		if(sm.getId()!=null)
		{
			out.print("{\"succ\":true,val:\""+sm.getId()+"\",message:\"添加模块信息成功！\"}");
		    return;
		}
		else
		{
			out.print("{\"succ\":false,message:\"添加模块信息失败！\"}");
		    return;
		}
	}
	else
	{
		sm=(ShopModel)Tools.getManager(ShopModel.class).get(mid);
		if(sm!=null&&sm.getId()!=null){
			sm.setShopmodel_flag(new Long(f));
			sm.setShopmodel_shopcode(session.getAttribute("shopcodelog").toString());
			sm.setShopmodel_sort(new Long(s));
			sm.setShopmodel_title(t);
			sm.setShopmodel_type(new Long(type));
			sm.setShopmodel_gdsnum(new Long(gdsnum));
			if(type.equals("1")){
				sm.setShopmodel_content(c);
				sm.setShopmodel_list("");
				sm.setShopmodel_size(null);
			}
			else
			{
				sm.setShopmodel_content("");
				sm.setShopmodel_list(c);
				sm.setShopmodel_size(new Long(size));
				sm.setShopmodel_txt(model_txt);
				sm.setShopmodel_txtcolor(model_txtcolor);
				sm.setShopmodel_txtmore(model_txtmore);
				sm.setShopmodel_balloon(new Long(shopmodel_balloon));
				sm.setShopmodel_balname(shopmodel_balname);
				if(type_num.equals("1")){
					sm.setShopmodel_orderflag(new Long(shopmodel_orderflag));
				}
				//System.out.println("=2222222222==");
			}		
			if(sm.getShopmodel_infoid()==null){
				sm.setShopmodel_infoid(new Long(shopid));
			}
	        if(Tools.getManager(ShopModel.class).update(sm,true)){
	        	out.print("{\"succ\":true,val:\""+sm.getId()+"\",message:\"修改模块信息成功！\"}");
			    return;
	        }
	        else{
	        	out.print("{\"succ\":false,message:\"修改模块信息出错，请稍后重试！\"}");
	        	return;
	        }
		}
		else{
			out.print("{\"succ\":false,message:\"参数不正确，请稍后重试！\"}");
			return;
		} 
	}
	
}
catch(Exception e){
	out.print("{\"succ\":false,message:\"操作出错，请稍后重试！\"}");
    return;
}

%>