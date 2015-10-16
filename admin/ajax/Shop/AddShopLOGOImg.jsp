<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%@include file="/html/public.jsp"%>
<%
String sid="";
String img="";

if(request.getParameter("sid")!=null)
{
	sid=request.getParameter("sid");
}
if(request.getParameter("img")!=null)
{
	img=request.getParameter("img");
}

if(Tools.isNull(sid)){
	out.print("{\"succ\":false,message:\"商户信息id不能为空！\"}");
    return;
}
/*
if(Tools.isNull(img)){
	out.print("{\"succ\":false,message:\"店铺首张广告图不能为空！\"}");
    return;
}*/
ShopInfo sif = null;
//System.out.println("111111111111111111"+sid);

//判断编辑器中是否存在外链
if(!check_url(img)){
	  out.print("{\"succ\":false,message:\"您所要保存的内容存在外链，请修改后保存！\"}");
	  return;
}

if(Integer.valueOf(sid)>0){//表示修改
	//System.out.println("update====");
	sif=(ShopInfo)Tools.getManager(ShopInfo.class).get(sid);
	if(sif==null){
		out.print("{\"succ\":false,message:\"该商户信息不存在！\"}");
	    return;
	}
	if(!sif.getShopinfo_shopcode().equals(session.getAttribute("shopcodelog").toString())){
		out.print("{\"succ\":false,message:\"您没有权限执行此操作！\"}");
	    return;
	}
}
try{
    if(Integer.valueOf(sid)>0){
    	sif.setShopinfo_bgimg(img);
		if(Tools.getManager(ShopInfo.class).update(sif, true)){
			out.print("{\"succ\":true,message:\"修改店铺首张广告图成功！\"}");
		    return;
		}else{
			out.print("{\"succ\":false,message:\"修改加店铺首张广告图失败！\"}");
			return;
		}
    }else{//专题添加
    	//System.out.println("add====");
    	sif = new ShopInfo();
    	String index_flag = "";
    	if(session.getAttribute("index_flag") != null){
    		index_flag = session.getAttribute("index_flag").toString();
    	}
    	if(index_flag.equals("0")){
    		sif.setShopinfo_indexflag(new Long(0));//0代表首页
    	}else if(index_flag.equals("1")){
    		sif.setShopinfo_indexflag(new Long(1));//1代表专题
    		sif.setShopinfo_lineflag(1+"");
    	}
    	sif.setShopinfo_bgimg(img);
    	sif.setShopinfo_shopcode(session.getAttribute("shopcodelog").toString());
    	sif.setShopinfo_createdate(new Date());
    	//System.out.println("add1111===="+img.length());
    	ShopInfo si_info = (ShopInfo)Tools.getManager(ShopInfo.class).create(sif);
    	//System.out.println("add2222====");
    	if(si_info.getId() != null ){
    		out.print("{\"succ\":true,shop_id:\""+si_info.getId()+"\",message:\"添加店铺首张广告图成功！\"}");
    		//System.out.println("si_info.getId===="+si_info.getId());
    	    return;
    	}else{
    		out.print("{\"succ\":true,message:\"添加店铺首张广告图失败！\"}");
    	    return;
    	}
		
		
    }
}catch(Exception e){
	//out.print(e.getMessage());
	out.print("{\"succ\":false,message:\"添加店铺首张广告图出错，请稍后重试！\"}");
    return;
}

%>