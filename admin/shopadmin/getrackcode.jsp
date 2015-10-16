<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="/admin/chkrgt.jsp"%><%
String pcode = request.getParameter("pcode");
if(pcode != null){
	ArrayList<Directory> list=DirectoryHelper.getByParentcode(pcode);
	if(list!=null && list.size()>0){
	StringBuilder sb = new StringBuilder();
		for(Directory d : list){
			sb.append(d.getId().trim()).append("|").append(d.getRakmst_rackname()).append(",");
		}
		int length = sb.length();
		if(length>0){
			sb.delete(length-1,length);
		}
		out.print(sb.toString());
	}else{
		out.print("-1");
	}
	return;
}
String rackcode=request.getParameter("rackcode");
if(!Tools.isNull(rackcode)){
	ArrayList<Brand> list=BrandHelper. getBrandByRackCode(rackcode);
	if(list!=null && list.size()>0){
		StringBuilder sb = new StringBuilder();
			for(Brand b : list){
				sb.append(b.getBrand_code().trim()).append("|").append(b.getBrand_name().trim()).append(",");
			}
			int length = sb.length();
			if(length>0){
				sb.delete(length-1,length);
			}
			out.print(sb.toString());
		}else{
			out.print("-1");
		}
	return;
}
String ggid=request.getParameter("ggid");
if(!Tools.isNull(ggid)){
	ProductStandard ps=ProductStandardHelper.getById(ggid);
	if(ps!=null){
		StringBuilder sb = new StringBuilder();
		sb.append(ps.getStdmst_atrname1().trim()).append("|");
		sb.append(ps.getStdmst_atrname2().trim()).append("|");
		sb.append(ps.getStdmst_atrname3().trim()).append("|");
		sb.append(ps.getStdmst_atrname4().trim()).append("|");
		sb.append(ps.getStdmst_atrname5().trim()).append("|");
		sb.append(ps.getStdmst_atrname6().trim()).append("|");
		sb.append(ps.getStdmst_atrname7().trim()).append("|");
		sb.append(ps.getStdmst_atrname8().trim()).append(",");
		
		sb.append(ps.getStdmst_atrdtl1().trim()).append("|");
		sb.append(ps.getStdmst_atrdtl2().trim()).append("|");
		sb.append(ps.getStdmst_atrdtl3().trim()).append("|");
		sb.append(ps.getStdmst_atrdtl4().trim()).append("|");
		sb.append(ps.getStdmst_atrdtl5().trim()).append("|");
		sb.append(ps.getStdmst_atrdtl6().trim()).append("|");
		sb.append(ps.getStdmst_atrdtl7().trim()).append("|");
		sb.append(ps.getStdmst_atrdtl8().trim());
		out.print(sb.toString());
	}else{
		out.print("-1");
	}
	return;
}
%>