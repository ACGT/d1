<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
public static ArrayList<DhGdsM> getdhgdsmList(String card){
	ArrayList<DhGdsM> rlist = new ArrayList<DhGdsM>();

			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("dhgdsm_card",card));
			List<BaseEntity> list = Tools.getManager(DhGdsM.class).getList(clist, null, 0, 100);
			
			if(list!=null){
				for(BaseEntity be:list){
					DhGdsM pp = (DhGdsM)be;
                     rlist.add(pp);
				}
			}
	return rlist ;
}
%>
<%
List<DhGdsM> dhgdsmList = getdhgdsmList("mqwyjf1210dk");
String j=request.getParameter("num");
if(Tools.isNull(j) || !Tools.isNumber(j)){
	out.print("-1");
	return;
}
StringBuilder sb = new StringBuilder();
if(dhgdsmList != null){

	  String gdsarrstr2="";String selectgdsid2="";
	  sb.append("<p>&nbsp;</p>");
	  sb.append(" <div class=\"spgg1\" style=\"padding-bottom:0px; margin-bottom:0px;\">");
	  sb.append("  <div id=\"skuname").append(j).append("\" class=\"skuname1\">");
	  sb.append("	<p>选择颜色：<font id=\"sizecount").append(j).append("\"></font></p>");
	  sb.append("<ul>");
	  String selectSku2 = "";
										    		
										    		int i=1;
											    	for(DhGdsM dhgds : dhgdsmList){
											    		String gId = Tools.trim(dhgds.getDhgdsm_gdsid());
											    		Product goods = ProductHelper.getById(gId);
											    		sb.append("<li>");
											    		sb.append("<A hideFocus title=\"").append(dhgds.getDhgdsm_title()).append("\" onclick=\"choosegdsid").append(j).append("(this)\" href=\"javascript:void(0);\" ");
											    		sb.append("attr=\"").append(dhgds.getDhgdsm_gdsid()).append("\">");
											    		sb.append("<img  height=80 width=80 src=\"").append(ProductHelper.getImageTo80(goods) ).append("\"/>");
											    		sb.append("</a><br/><br/><br/>").append(dhgds.getDhgdsm_title()).append("</li>");
											    		
											    		if (i==1){
											    			selectSku2=dhgds.getDhgdsm_title();
											    			selectgdsid2=dhgds.getDhgdsm_gdsid();
											    			gdsarrstr2=gId;
											    		}
											    		else{
											    		gdsarrstr2=gdsarrstr2+","+gId;
											    		}
											    		i++;
											    	}
											    	sb.append("</ul></div>");
											    	sb.append("<script type=\"text/javascript\">");
											    	sb.append("function choosegdsid").append(j).append("(obj){");
											    	sb.append(" var skuid = $(\"#skuname").append(j).append("\");");
											    	sb.append(" if (skuid.length==0) return;");
											    	sb.append("  var skuid = skuid.find('li'); var s=''; if (skuid.length > 0){	skuid.each(function(){");
											    	sb.append("$(this).removeClass('select').find('a').removeClass('current');});");
											    	sb.append("	$(obj).parent().addClass('select').find('a').addClass('current');");
											    	sb.append(" var skuItem = skuid.find('a');	skuItem.each(function(){if($(this).hasClass('current')){");
											    	sb.append("s = $(this).attr('attr');}});");
											    	sb.append("$('#sizecount").append(j).append("').html($(obj).attr('title'))");
											    	sb.append("}}</script>");
											    	sb.append("</div>");
											    	
	    }
Map<String,Object> map = new HashMap<String,Object>();
map.put("success",new Boolean(true));
map.put("message",sb.toString());

out.print(JSONObject.fromObject(map));
return;
