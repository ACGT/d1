<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%>
<%@include file="/inc/header.jsp"%>
<%@page	import=" java.awt.image.BufferedImage,javax.imageio.ImageIO,org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern"%>
<%@include file="/admin/chkshop.jsp"%>
<%!
//获取商家信息
private ArrayList<ShpMst> getShopM(String shopcode)
	{
		ArrayList<ShpMst> rlist = new ArrayList<ShpMst>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("id", shopcode));
		List<BaseEntity> list = Tools.getManager(ShpMst.class).getList(clist, null, 0, 1);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ShpMst)be);
		}
		
		return rlist ;
		
	}

%>
<%
String gdsid=request.getParameter("gdsid");
String type=request.getParameter("t");
if(!type.equals("1")&&!type.equals("2"))
{
	out.print("{\"success\":false,message:\"参数不正确！\"}");
	return;
}
Product p=ProductHelper.getById(gdsid);
if(p==null)
{
	out.print("{\"success\":false,message:\"商品不存在！\"}");
	return;
}

String shopCode=session.getAttribute("shopcodelog").toString();
if(!p.getGdsmst_shopcode().equals(shopCode)){
	   out.print("{\"success\":false,message:\"此商品不是商户的商品不能修改！\"}");
		return;
}
if(type.equals("1"))
{
	//p.setGdsmst_validflag(new Long(0));
	ArrayList<ShpMst> shpm=getShopM(shopCode);
	if(shpm!=null&&shpm.size()>0&&shpm.get(0)!=null&&!Tools.isNull(shpm.get(0).getShpmst_bp())&&!shpm.get(0).getShpmst_bp().equals("1")){
		p.setGdsmst_validflag(new Long(1));
	}
	else{
	    p.setGdsmst_validflag(new Long(0));
	}
}
else
{//当用户点击'保存下架'时，判断Shpmst_bp=0 直接下架;Shpmst_bp=1录入待上架
	ArrayList<ShpMst> shpm=getShopM(shopCode);
	if(shpm!=null&&shpm.size()>0&&shpm.get(0)!=null&&!Tools.isNull(shpm.get(0).getShpmst_bp())&&shpm.get(0).getShpmst_bp().equals("0")){
		p.setGdsmst_validflag(new Long(2));
	}else{
	    p.setGdsmst_validflag(new Long(0));//录入待上架
	}
    //p.setGdsmst_validflag(new Long(0));
}
if(type.equals("1"))
{
   p.setGdsmst_validdate(new Date());
}
if(Tools.getManager(Product.class).update(p,true))
{
	out.print("{\"success\":true,type:1,message:\"修改上架状态成功！\"}");
    return;
	
}else{
		out.print("{\"success\":false,type:1,message:\"修改上架状态失败！\"}");
		return;
	
	}

%>