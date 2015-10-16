<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/admin/chkshop.jsp"%>
<%
	String id = request.getParameter("id");
	String indexflag = request.getParameter("indexflag");
	if(Tools.isNull(id)){
		out.print("{\"code\":0,message:\"参数错误！\"}");
		return;
	}
	ShopInfo act_list = (ShopInfo)Tools.getManager(ShopInfo.class).get(id);
	if(act_list != null){
		if(indexflag.equals("3")){
		ArrayList<ShopInfo> si = getShopInfoList(act_list.getShopinfo_shopcode());
		if(si != null && si.size()>0){
			out.print("{\"code\":1,message:\"只能设置一个专题为首页！\"}");
		    return;
		}
		}
		act_list.setId(id);
		act_list.setShopinfo_indexflag(new Long(indexflag));
		if(Tools.getManager(ShopInfo.class).update(act_list, true)){
			out.print("{\"code\":1,message:\"操作成功！\"}");
		    return;
		}
	}else{
		out.print("{\"code\":0,message:\"操作失败！\"}");
		return;
	}
%>
<%!
//获取首页商户的信息
	private ArrayList<ShopInfo> getShopInfoList(String shopcode){
		ArrayList<ShopInfo> rlist = new ArrayList<ShopInfo>();
		List<Criterion> clist = new ArrayList<Criterion>();
		clist.add(Restrictions.sqlRestriction(" (shopinfo_indexflag = 3)"));
		clist.add(Restrictions.eq("shopinfo_shopcode", shopcode));
		clist.add(Restrictions.eq("shopinfo_del", new Long(0)));//未被删除
		List<BaseEntity> list = Tools.getManager(ShopInfo.class).getListCriterion(clist, null, 0, 2);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ShopInfo)be);
		}
		return rlist ;
		
	}

%>