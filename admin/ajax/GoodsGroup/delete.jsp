<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%!
    public static List<GoodsGroupDetail> getGroupDetail(String id){
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdsgrpdtl_mstid", new Long(id)));	
	List list = Tools.getManager(GoodsGroupDetail.class).getList(listRes, null, 0, 100);
	
	if(list == null || list.isEmpty()) return null;	
	int size = list.size();	
	List<GoodsGroupDetail> ggdList = new ArrayList<GoodsGroupDetail>();
	for(int i=0;i<size;i++){
		GoodsGroupDetail ggd = (GoodsGroupDetail)list.get(i);
		Product goods = ProductHelper.getById(ggd.getGdsgrpdtl_gdsid());
		if(goods == null) continue;		
		ggdList.add(ggd);
	}		
	return ggdList;
}

%>
<%
String id = request.getParameter("id");
if(Tools.isNull(id)){
	out.print("{\"succ\":false,message:\"参数不正确！\"}");
    return;
}
GoodsGroup gg=(GoodsGroup)Tools.getManager(GoodsGroup.class).get(id);
if(gg==null)
{
	out.print("{\"succ\":false,message:\"记录不存在！\"}");
    return;
}
List<GoodsGroupDetail> ggdlist=getGroupDetail(id);
if(ggdlist!=null&&ggdlist.size()>0)
{
    for(GoodsGroupDetail ggd:ggdlist)
    {
    	if(ggd!=null)
    	{
    		try{
    		Tools.getManager(GoodsGroupDetail.class).delete(ggd);    	
    		}
    		catch(Exception e){
    			out.print("{\"succ\":false,message:\"删除出错，请稍后重试！\"}");
    		    return;
    		}
    	}
    	
    }
}
try{
	Tools.getManager(GoodsGroup.class).delete(gg);    	
	}
	catch(Exception e){
		out.print("{\"succ\":false,message:\"删除出错，请稍后重试！\"}");
	    return;
	}
out.print("{\"succ\":true,message:\"删除成功！\"}");
%>