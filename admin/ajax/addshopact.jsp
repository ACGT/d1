<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%@include file="/admin/chkshop.jsp"%>
<%
/*
data: {name:req_name,sdate:req_sdate,edate:req_edate,type:req_type,snum1:req_snum1,enum1:req_enum1
			,snum2:req_snum2,enum2:req_enum2,snum3:req_snum3,enum3:req_enum3},
*/


String name=request.getParameter("name");
String sdate=request.getParameter("sdate");
String edate=request.getParameter("edate");
String type=request.getParameter("type");
String snum1=request.getParameter("snum1");
String enum1=request.getParameter("enum1");
String snum2=request.getParameter("snum2");
String enum2=request.getParameter("enum2");
String snum3=request.getParameter("snum3");
String enum3=request.getParameter("enum3");
String ppcode=request.getParameter("ppcode");
String brandcode=request.getParameter("brandcode");
String memo=request.getParameter("memo");
String status=request.getParameter("status");
String shopCode="00000000";
shopCode=session.getAttribute("shopcodelog").toString();
//if(shopCode.equals("00000000")&&Tools.isNull(ppcode)){
//	out.print("{\"success\":false,message:\"D1只能添加推荐位满减！\"}");
//    return;
//}

SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

     D1ActTb acttb=new D1ActTb();
try{

	acttb.setD1acttb_name(name);
	acttb.setD1acttb_starttime(format.parse(sdate));
	acttb.setD1acttb_endtime(format.parse(edate));
	acttb.setD1acttb_shopcode(shopCode);
	acttb.setD1acttb_acttype(new Long(type));
	acttb.setD1acttb_snum1(new Long(snum1));
	acttb.setD1acttb_enum1(new Long(enum1));
	acttb.setD1acttb_snum2(new Long(snum2));
	acttb.setD1acttb_enum2(new Long(enum2));
	acttb.setD1acttb_snum3(new Long(snum3));
	acttb.setD1acttb_enum3(new Long(enum3));
	acttb.setD1acttb_ppcode(ppcode);
	acttb.setD1acttb_brandcode(brandcode);
	acttb.setD1acttb_status(new Long(Tools.parseLong(status)));
	acttb.setD1acttb_memo(memo);
	acttb=(D1ActTb)Tools.getManager(D1ActTb.class).create(acttb);
		if(acttb.getId()!=null){
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("actid",acttb.getId());
			map.put("success",true);
			map.put("message","添加成功");
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


%>