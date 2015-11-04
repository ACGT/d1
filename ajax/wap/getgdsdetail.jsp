<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject,java.util.regex.*"%><%@include file="/html/header.jsp" %>
<%!
private static BrandMst getbrandmst(String brandcode,String rackcode){
	BrandMst  brandm=null;
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("id",brandcode));
	clist.add(Restrictions.eq("brandmst_rackcode",rackcode));
	
	
	List<BaseEntity> list = Tools.getManager(BrandMst.class).getList(clist, null, 0, 1);
	if(list!=null){
		for(BaseEntity be:list){
			brandm = (BrandMst)be;
		}
	}

  return brandm;

}
%>
<%
JSONObject json = new JSONObject();
Map<String,Object> map = new HashMap<String,Object>();
String id=request.getParameter("id");
Product p=ProductHelper.getById(id);
if(p==null){
	json.put("pstatus", "0");
	return;
}else{
	String reg = "width=?.*?(\\s+)|height=?.*?(\\s+)|WIDTH\\s*\\:?.*?(\\;+)|width\\s*\\:?.*?(\\;+)";
	map.put("pstatus", "1");
	map.put("gdsid", id);
	map.put("gdsjtxt",p.getGdsmst_briefintrduce());
	BrandMst brandmst=getbrandmst(p.getGdsmst_brand(),p.getGdsmst_rackcode().substring(0,3));
	String brandurl="";
	if(brandmst!=null&&!Tools.isNull(brandmst.getBrandmst_authorization())){
		brandurl="<a href=\""+brandmst.getBrandmst_page()+"\" target=\"_blank\"><img src=\""+brandmst.getBrandmst_authorization()+"\" ></a>";
	}
	map.put("gdsdetail", brandurl+p.getGdsmst_detailintruduce().replaceAll (reg, "$1").replace("<br>", "").replace("<BR>", ""));
}
out.print(JSONObject.fromObject(map));
%>