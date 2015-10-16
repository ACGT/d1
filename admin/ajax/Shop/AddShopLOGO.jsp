<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%@include file="/html/public.jsp"%>
<%!
//获取该商户的信息
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
%>
<%
String logoimg="";
if(request.getParameter("img")!=null)
{
	logoimg=request.getParameter("img");
}
String shop_code = session.getAttribute("shopcodelog").toString();

if(Tools.isNull(logoimg) && !shop_code.equals("00000000") && !shop_code.equals("13100902")){
	out.print("{\"succ\":false,message:\"LOGO图不能为空！\"}");
    return;
}

//判断编辑器中是否存在外链
if(!check_url(logoimg)){
	  out.print("{\"succ\":false,message:\"您所要保存的内容存在外链，请修改后保存！\"}");
	  return;
}
try{
	ShopInfo sif=new ShopInfo();
	ArrayList<ShopInfo> silist=getShopInfoList(session.getAttribute("shopcodelog").toString());
	if(silist!=null&&silist.size()>0){
		sif=silist.get(0);
		if(sif!=null&&sif.getId()!=null&&sif.getId().length()>0){
			if(sif.getShopinfo_indexflag() == null){
				sif.setShopinfo_indexflag(new Long(0));
			}
			sif.setShopinfo_logo(logoimg);
			if(Tools.getManager(ShopInfo.class).update(sif, true)){
				out.print("{\"succ\":true,val:\""+sif.getId()+"\",message:\"更新店铺招牌成功！\"}");
			    return;
			}
			else
			{
				out.print("{\"succ\":false,message:\"修改店铺招牌出错，请稍后重试！\"}");
			}
		}
	}
	else{
		sif.setShopinfo_indexflag(new Long(0));
		sif.setShopinfo_createdate(new Date());
		sif.setShopinfo_logo(logoimg);
		sif.setShopinfo_shopcode(session.getAttribute("shopcodelog").toString());
		sif.setShopinfo_ztimglist("");
		sif=(ShopInfo)Tools.getManager(ShopInfo.class).create(sif);
        if(sif!=null&&!Tools.isNull(sif.getId())){
        	out.print("{\"succ\":true,val:\""+sif.getId()+"\",message:\"添加店铺招牌成功！\"}");
		    return;
        }
        else{
        	out.print("{\"succ\":false,message:\"添加店铺招牌出错，请稍后重试！\"}");
        }
	}
}
catch(Exception e){
	out.print("{\"succ\":false,message:\"添加L店铺招牌出错，请稍后重试！\"}");
    return;
}

%>