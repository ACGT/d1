<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!

//获取分类列表
private static String getResult(String category,String box,int flag){
	if(Tools.isNull(category)||!Tools.isNumber(category)||Tools.isNull(box)||!Tools.isNumber(box)){ return "";}
	ArrayList<Gdscoll_rackcode> grlist=new ArrayList<Gdscoll_rackcode>();
	grlist=Gdscoll_rackcodeHelper.getGdsAttByGdsid(category, box);
	if(grlist==null||grlist.size()<=0) return "";
	StringBuilder sb=new StringBuilder();
	for(Gdscoll_rackcode gr:grlist){
		if(gr!=null){
			String rackname="";
			if(gr.getGr_code()!=null&&Tools.isNumber(gr.getGr_code())){
				Directory dir=DirectoryHelper.getById(gr.getGr_code());
				if(dir!=null){
				rackname=dir.getRakmst_rackname();
				String hh="";
				if(rackname.length()>5){
					 hh="style=\"width:110px;\"";
				}
				if(rackname.length()>9){
					 hh="style=\"width:150px;\"";
				}
				sb.append("<li code=\""+gr.getGr_code()+"\" attr=\""+flag+"\" onclick=\"getProductBycolde(this)\" "+hh+">"+rackname+"</li>");
			}
			}
			
		}
	}
	return sb.toString();
	
}

%>
<%
     Map<String,Object> map = new HashMap<String,Object>();
     String category="";
     String box="";
     int flag=0;
     if(request.getParameter("category")!=null&&request.getParameter("category").length()>0&&Tools.isNumber(request.getParameter("category")))
     {
    	 category=request.getParameter("category");
     }
     else
     {
    	 out.print("{\"succ\":false,\"message\":\"参数错误！\"}");
     }
     if(request.getParameter("box")!=null&&request.getParameter("box").length()>0&&Tools.isNumber(request.getParameter("box")))
     {
    	 box=request.getParameter("box");
     }
     else
     {
    	 out.print("{\"succ\":false,\"message\":\"参数错误！\"}");
     }
     if(request.getParameter("flag")!=null&&request.getParameter("flag").length()>0&&Tools.isNumber(request.getParameter("flag")))
     {
    	 flag=Tools.parseInt(request.getParameter("flag"));
     }
    
     String result="";
     result=getResult(category,box,flag);
     map.put("succ",new Boolean(true));
     map.put("message",result);
     out.print(JSONObject.fromObject(map));

     

%>
