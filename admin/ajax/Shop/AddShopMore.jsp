<%@ page contentType="text/html; charset=UTF-8" import="java.util.regex.*,java.net.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.*,"%><%@include file="/html/header.jsp" %><%!
/**
 * 
 * @param imgUrl 图片地址
 * @return 
 */ 
public static BufferedImage getBufferedImage(String imgUrl) { 
    URL url = null; 
    InputStream is = null; 
    BufferedImage img = null; 
    try { 
        url = new URL(imgUrl); 
        is = url.openStream(); 
        img = ImageIO.read(is); 
    } catch (MalformedURLException e) { 
        e.printStackTrace(); 
    } catch (IOException e) { 
        e.printStackTrace(); 
    } finally { 
           
        try { 
            is.close(); 
        } catch (IOException e) { 
            e.printStackTrace(); 
        } 
    } 
    return img; 
} 
%>
<%@include file="/html/public.jsp"%>

<%
String sid="";
String img="";

if(request.getParameter("sid")!=null){
	sid=request.getParameter("sid");
}
if(request.getParameter("img")!=null){
	img=request.getParameter("img");
}

if(Tools.isNull(sid)){
	out.print("{\"succ\":false,message:\"商户信息id不能为空！\"}");
    return;
}

String gid="";
String c="";

String shopinfo_title = "";
if(request.getParameter("shopinfo_title")!=null){
	shopinfo_title = request.getParameter("shopinfo_title");
}
if(request.getParameter("goods")!=null){
	gid=request.getParameter("goods");
}
if(request.getParameter("color")!=null){
	c=request.getParameter("color");
}

if(Tools.isNull(shopinfo_title)){
	out.print("{\"succ\":false,message:\"专题名称不能为空！\"}");
    return;
}

if(Tools.isNull(c)||c.length()!=6){
	out.print("{\"succ\":false,message:\"背景颜色值必须是6位，不用添加’#‘号！\"}");
    return;
}
String con="";
if(request.getParameter("con")!=null){
	con=request.getParameter("con");
}

ShopInfo sif = null;
//判断编辑器中是否存在外链
if(!check_url(img) || !check_url(con) && !("13100902").equals(session.getAttribute("shopcodelog").toString())){
	  out.print("{\"succ\":false,message:\"您所要保存的内容存在外链，请修改后保存！\"}");
	  return;
}
sif=(ShopInfo)Tools.getManager(ShopInfo.class).get(sid);

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
					 ArrayList gdsidlist=new ArrayList();
					 if(list!=null){
					 	for(PromotionProduct pProduct:list){
					 		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
					 	}
					 	if(gdsidlist!=null && gdsidlist.size()>0){
						 	int i=0;
						 	//通过商品id过滤商品信息--有货
						 	ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
						 	if(productlist == null){
								noExsitsgid+=str+",";
							}
						 	if(productlist!=null&&!productlist.get(z).getGdsmst_shopcode().equals(session.getAttribute("shopcodelog").toString())&&!("13100902").equals(session.getAttribute("shopcodelog").toString())){
								noqxgid+=str+",";
							}else{
								zqgid+=str+",";
							}
							
						 }
					}else{
						noExsitsgid+=str+",";
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
	
	String tm_begin=request.getParameter("tm_begin");//特卖会开始时间
	String tm_end=request.getParameter("tm_end");//特卖会结束时间
	String wapimg=request.getParameter("wapimg");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date start = null;
	Date end = null;
    try{
	   if(!Tools.isNull(tm_begin)){
		 start = sdf.parse(tm_begin);
	   }
	   if(!Tools.isNull(tm_end)){
		 end = sdf.parse(tm_end);
	   }
    }catch(Exception e){
	   e.printStackTrace();
	   System.out.println("字符串转换日期失败!");
    }
	
	String index_flag = "";
	if(session.getAttribute("index_flag") != null){
		index_flag = session.getAttribute("index_flag").toString();
	}
	 String  regex = "<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>";  
	  Pattern  pattern = Pattern.compile(regex);
	  Matcher m_image = pattern.matcher(img);  
	  long imgh=0;
  while(m_image.find()){  
  	//提取字符串中的src路径
      Matcher m = Pattern.compile("src=\"?(.*?)(\"|>|\\s+)").matcher(m_image.group());
      while(m.find())
      {
   
             BufferedImage image=getBufferedImage(m.group(1)); 
             if (image!=null) 
             { 
           	  imgh=image.getHeight(); 
             } 
             
      }
   }  
	
	if(Integer.valueOf(sid)==-1){//添加
		sif = new ShopInfo();
    	if(index_flag.equals("0")){
    		sif.setShopinfo_indexflag(new Long(0));//0代表首页
    	}else if(index_flag.equals("1")){
    		sif.setShopinfo_indexflag(new Long(1));//1代表专题
    	}
		 
    	sif.setShopinfo_adheight(new Long(imgh));
    	sif.setShopinfo_bgimg(img);
    	sif.setShopinfo_title(shopinfo_title);
	    sif.setShopinfo_ztimglist(zqgid);
	    sif.setShopinfo_bgcolor(c);
	    sif.setShopinfo_floatcontent(con);
    	sif.setShopinfo_shopcode(session.getAttribute("shopcodelog").toString());
    	sif.setShopinfo_createdate(new Date());
    	sif.setShopinfo_tmbegin(start);
    	sif.setShopinfo_tmend(end);
    	sif.setShopinfo_wapbanner(wapimg);
    	ShopInfo si_info = (ShopInfo)Tools.getManager(ShopInfo.class).create(sif);
    	if(si_info.getId() != null ){
    		out.print("{\"succ\":true,shop_id:\""+si_info.getId()+"\",message:\"添加信息成功！\"}");
    		//System.out.println("si_info.getId===="+si_info.getId());
    	    return;
    	}else{
    		out.print("{\"succ\":true,message:\"添加信息失败！\"}");
    	    return;
    	}
	}else{
		sif.setShopinfo_adheight(new Long(imgh));
		sif.setShopinfo_bgimg(img);
		sif.setShopinfo_title(shopinfo_title);
	    sif.setShopinfo_ztimglist(zqgid);
	    sif.setShopinfo_bgcolor(c);
	    sif.setShopinfo_floatcontent(con);
	    sif.setShopinfo_tmbegin(start);
    	sif.setShopinfo_tmend(end);
    	sif.setShopinfo_wapbanner(wapimg);
		if(Tools.getManager(ShopInfo.class).update(sif, true)){
			out.print("{\"succ\":true,message:\"修改信息成功！\"}");
		    return;
		}else{
			out.print("{\"succ\":false,message:\"修改信息失败！\"}");
			return;
		}
	}
    
}catch(Exception e){
	out.print("{\"succ\":false,message:\"添加信息出错，请稍后重试！\"}");
    return;
}

%>