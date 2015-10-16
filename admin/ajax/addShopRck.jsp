<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%@include file="/admin/chkshop.jsp"%>
<%!
public static List<ShopRck> getShopRckList(String shopcode,int parentid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("shoprck_shopcode", shopcode));
	listRes.add(Restrictions.eq("shoprck_parentid", new Long(parentid)));
	List<Order> olist= new ArrayList<Order>();
	olist.add(Order.asc("shoprck_seq"));
	List list = Tools.getManager(ShopRck.class).getList(listRes, olist, 0, 200);	
	if(list == null || list.isEmpty()) return null;	
	return list;
}
public static String getContent(String shopcode){
	StringBuilder sb=new StringBuilder();
	List<ShopRck> shoprcklist=getShopRckList(shopcode,0);
	int num=0;
 	 if(shoprcklist!=null){
 		num=shoprcklist.size();
 	
 	 }
	
	sb.append("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"linon\">");	 
	sb.append("<tr><td width=\"180\" height=\"25\"  class=\"spantxt  pdl8\"><input type=\"text\" id=\"req_seq\" name=\"req_seq\" value=\"").append(num+1).append("\" style=\"width:20px;\" />");
	sb.append("&nbsp;<input type=\"text\" id=\"req_name\" name=\"req_name\" style=\"width:100px;\" /></td>");
	sb.append("<td width=\"190\" align=\"center\"><input type=\"submit\" name=\"Submit2\" value=\"添加一级分类\"  onClick=\"addshoprck('','');\" /></td>");
	sb.append("<td width=\"90\" align=\"center\">&nbsp;</td>");
    sb.append("<td width=\"90\" align=\"center\">&nbsp;</td>");
	sb.append("<td width=\"90\" align=\"center\">&nbsp;</td></tr>");

	 if(shoprcklist!=null){
    for(ShopRck sprck:shoprcklist){
   	String shoprck_id= sprck.getId();
   	List<ShopRck> shoprcklist2=getShopRckList(shopcode,Tools.parseInt(sprck.getId()));
   	int parentnum=0;
  	 if(shoprcklist2!=null){
  	  parentnum=shoprcklist2.size();
  	
  	 }
  
  	  sb.append("<tr><td height=\"25\"  class=\"spantxt  pdl8\">");
  	  sb.append("<input name=\"req_seq0").append(shoprck_id).append("\" id=\"req_seq0").append(shoprck_id).append("\" style=\"width:20px;\" type=\"text\" value=\"").append(sprck.getShoprck_seq()).append("\"  />");
      sb.append("&nbsp;<input name=\"req_name0").append(shoprck_id).append("\" id=\"req_name0").append(shoprck_id).append("\" style=\"width:100px;\"  type=\"text\"  value=\"").append(sprck.getShoprck_name()).append("\" /></td>");
      sb.append("<td align=\"center\"><span class=\"spantxt  pdl8\">");
      sb.append("<input name=\"req_seq1").append(shoprck_id).append("\" id=\"req_seq1").append(shoprck_id).append("\" value=\"").append(parentnum+1).append("\" style=\"width:20px;\" type=\"text\"/>");
      sb.append(" <input type=\"text\" name=\"req_name1").append(shoprck_id).append("\" id=\"req_name1").append(shoprck_id).append("\" style=\"width:100px;\"  />");
      sb.append("</span></td>");
      sb.append("<td align=\"center\"><span class=\"spantxt  pdl8\">");
      sb.append("  <input type=\"submit\" name=\"Submit3\" onClick=\"addshoprck('").append(shoprck_id).append("','1');\" value=\"添加子分类\" />");
      sb.append("</span></td>");
      sb.append("<td align=\"center\"><span class=\"spantxt  pdl8\">");
      sb.append(" <input type=\"submit\" name=\"Submit32\" onClick=\"addshoprck('").append(shoprck_id).append("','0');\" value=\"修改\" />");
      sb.append("</span></td>");
      sb.append("<td align=\"center\"><span class=\"spantxt  pdl8\">");
      sb.append("<input type=\"submit\" name=\"Submit3210\" onClick=\"delshoprck('").append(shoprck_id).append("');\"  value=\"删除\" />");
      sb.append("</span></td></tr>");

   	 if(shoprcklist2!=null){
   		 int inum=0;
        for(ShopRck sprck2:shoprcklist2){
       	 shoprck_id= sprck2.getId();

   
    sb.append("<tr><td height=\"25\"  class=\"spantxt  pdl8\"> ");
      if (inum+1!=parentnum){
       	 sb.append("├");
        }else{
       	sb.append("└");
        }
       
      sb.append("<input name=\"req_seq0").append(shoprck_id).append("\" id=\"req_seq0").append(shoprck_id).append("\" type=\"text\" style=\"width:20px;\" value=\"").append(sprck2.getShoprck_seq()).append("\"  /> ");                
       sb.append("&nbsp;<input name=\"req_name0").append(shoprck_id).append("\" id=\"req_name0").append(shoprck_id).append("\"  type=\"text\" style=\"width:100px;\" value=\"").append(sprck2.getShoprck_name()).append("\"  /></td>");
      sb.append("<td align=\"center\">&nbsp;</td>");
      sb.append("<td align=\"center\">&nbsp;</td>");
      sb.append("<td align=\"center\"><span class=\"spantxt  pdl8\">");
       sb.append(" <input type=\"submit\" name=\"Submit322\" onClick=\"addshoprck('").append(shoprck_id).append("','0');\" value=\"修改\" />");
      sb.append("</span></td>");
      sb.append("<td align=\"center\"><span class=\"spantxt  pdl8\">");
      sb.append("  <input type=\"submit\" name=\"Submit\" onClick=\"delshoprck('").append(shoprck_id).append("');\" value=\"删除\" />");
      sb.append("</span></td>");
    sb.append("</tr>");
     inum++;
       }
   	 }
    }  
	 }
  sb.append("<tr> <td height=\"25\"  class=\"spantxt  pdl8\">&nbsp;</td>");
      sb.append("<td colspan=\"2\" align=\"center\">&nbsp;</td>");
      sb.append("<td align=\"center\">&nbsp;</td>");
      sb.append("<td align=\"center\">&nbsp;</td></tr></table>");	
	
      return sb.toString();
}
%>
<%
String req_seq="";
if(request.getParameter("req_seq")!=null)
{
	req_seq=request.getParameter("req_seq");
}
String req_name=request.getParameter("req_name");
String flag=request.getParameter("flag");
String parentid=request.getParameter("parentid");
if(!flag.equals("-1")){
if(Tools.isNull(req_seq)){
	out.print("{\"success\":false,message:\"排序编号不能为空！\"}");
    return;
}
if(Tools.isNull(req_name)){
	out.print("{\"success\":false,message:\"分类名称不能为空！\"}");
    return;
}
}

String shopCode=session.getAttribute("shopcodelog").toString();


if(Tools.isNull(parentid)&&Tools.isNull(flag)){
	ShopRck addrck=new ShopRck();
try{

	addrck.setShoprck_shopcode(shopCode);
	addrck.setShoprck_seq(new Long(req_seq));
	addrck.setShoprck_name(req_name);
	addrck.setShoprck_parentid(new Long(0));
	addrck.setShoprck_createdate(new Date());
	addrck=(ShopRck)Tools.getManager(ShopRck.class).create(addrck);
		if(addrck.getId()!=null){
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("success",true);
			map.put("message","添加成功");
			map.put("content",getContent(shopCode));
			out.print(JSONObject.fromObject(map));
			return;
		}
		else
		{
			out.print("{\"success\":false,message:\"添加失败，请稍后重试！\"}");
		    return;
		}
		
	}
	catch(Exception e){
		out.print("{\"success\":false,message:\"添加出错，请稍后重试！\"}");
	    return;
	}
}else if(!Tools.isNull(parentid)&&!Tools.isNull(flag)&&flag.equals("1")){
	ShopRck addrck=new ShopRck();
	try{
		addrck.setShoprck_shopcode(shopCode);
		addrck.setShoprck_seq(new Long(req_seq));
		addrck.setShoprck_name(req_name);
		addrck.setShoprck_parentid(new Long(parentid));
		addrck.setShoprck_createdate(new Date());
		addrck=(ShopRck)Tools.getManager(ShopRck.class).create(addrck);
			if(addrck.getId()!=null){
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("success",true);
				map.put("message","添加成功");
				map.put("content",getContent(shopCode));
				out.print(JSONObject.fromObject(map));
				return;
			}
			else
			{
				out.print("{\"success\":false,message:\"添加失败，请稍后重试！\"}");
			    return;
			}
			
		}
		catch(Exception e){
			out.print("{\"success\":false,message:\"添加出错，请稍后重试！\"}");
		    return;
		}
}else if(!Tools.isNull(flag)&&!flag.equals("-1")){
	ShopRck addrck=(ShopRck)Tools.getManager(ShopRck.class).get(parentid);
	if (!addrck.getShoprck_shopcode().equals(shopCode)){
		out.print("{\"success\":false,message:\"修改失败！\"}");
	    return;
	}
	try{
		    	
		addrck.setShoprck_seq(new Long(req_seq));
		addrck.setShoprck_name(req_name);
		Tools.getManager(ShopRck.class).update(addrck, true);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("success",true);
		map.put("message","修改成功");
		map.put("content",getContent(shopCode));
		out.print(JSONObject.fromObject(map));
		 return;

			
		}
		catch(Exception e){
			out.print("{\"success\":false,message:\"修改出错，请稍后重试！\"}");
		    return;
		}
}else if(!Tools.isNull(flag)&&flag.equals("-1")){
	ShopRck addrck=(ShopRck)Tools.getManager(ShopRck.class).get(parentid);
	if (addrck.getShoprck_shopcode().equals(shopCode)){
		Tools.getManager(ShopRck.class).delete(parentid);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("success",true);
		map.put("message","删除成功");
		map.put("content",getContent(shopCode));
		out.print(JSONObject.fromObject(map));
		return;
	}else{
		out.print("{\"success\":false,message:\"删除失败！\"}");
	    return;
	}
}

%>