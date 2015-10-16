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

String j=request.getParameter("num");
if(Tools.isNull(j) || !Tools.isNumber(j)){
	out.print("-1");
	return;
}
String plist="02000791,02000792,02000793,02000795,02000794,02000796,02000797";
List<Cart> list = CartHelper.getCartItems(request,response);
int num=0;
if(list!=null){
	for(Cart c_23049:list){
		if(c_23049.getType().longValue()==14 && plist.indexOf(c_23049.getProductId())>=0){
			num++;
		}
	}
}
int hasnum=Tools.parseInt(j)-2;
if((hasnum+num)>5){
out.print("{\"success\":false,\"message\":\"一个订单中最多只能选5件赠品\"}");
return;
}
List<DhGdsM> dhgdsmList = getdhgdsmList("mqwyjf1210dk");
StringBuilder sb = new StringBuilder();
if(dhgdsmList != null){

	  String gdsarrstr2="";String selectgdsid2="";
	  sb.append("<p>&nbsp;</p>");
	  sb.append(" <div class=\"spgg1\" style=\"padding-bottom:0px; margin-bottom:0px;\">");
	  sb.append("  <div id=\"skuname").append(j).append("\" class=\"skuname\">");
	  sb.append("	<p>选择颜色：<font id=\"sizecount").append(j).append("\"></font></p>");
	  sb.append("<ul>");
	  String selectSku2 = "";
										    		
										    		int i=1;
											    	for(DhGdsM dhgds : dhgdsmList){
											    		String gId = Tools.trim(dhgds.getDhgdsm_gdsid());
											    		Product goods = ProductHelper.getById(gId);
											    		sb.append("<li>");
											    		sb.append("<a  href=\"javascript:void(0);\" title=\"").append(dhgds.getDhgdsm_title()).append("\" onclick=\"chooseskuname").append(j).append("(this)\" hidefocus=\"true\"");
											    		sb.append("attr=\"").append(dhgds.getDhgdsm_gdsid()).append("\">");
											    		sb.append("<span>").append(dhgds.getDhgdsm_title()).append("</span>");
											    		sb.append("</a></li>");
											    		
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
											    	sb.append("function chooseskuname").append(j).append("(obj){");
											    	sb.append(" var skuid = $(\"#skuname").append(j).append("\");");
											    	sb.append(" if (skuid.length==0) return;");
											    	sb.append("  var skuid = skuid.find('li'); var s=''; if (skuid.length > 0){	skuid.each(function(){");
											    	sb.append("$(this).removeClass('select').find('a').removeClass('current');});");
											    	sb.append("	$(obj).parent().addClass('select').find('a').addClass('current');");
											    	sb.append("$('#sizecount").append(j).append("').html($(obj).attr('title'))");
											    	sb.append("}}</script>");
											    	sb.append("</div>");
											    	
	    }
Map<String,Object> map = new HashMap<String,Object>();
map.put("success",new Boolean(true));
map.put("message",sb.toString());

out.print(JSONObject.fromObject(map));
return;
