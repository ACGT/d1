<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static final String SEPERATOR = ","; 
public static final String BRACER = "\""; 
public static final String NEWLINE = "\n"; 
public static final String REGEX_SPECIAL = ".*[,\n\"].*"; 
public static String write(String[] valuesInLine) throws IOException { 
int count = 0; 
StringBuffer out=new StringBuffer(); 
for (String value: valuesInLine) { 
if (count != 0) 
out.append(SEPERATOR); 
count++; 
if (value.contains(SEPERATOR) || value.contains(BRACER) || value.contains(NEWLINE)) { 
	if (value.contains(BRACER)) { 
	value = value.replace(BRACER, BRACER + BRACER); 
	} 
	if (value.contains(NEWLINE)) { 
	value = value.replace(NEWLINE,"< br />"); 
	} 

out.append(BRACER + value + BRACER); 
} 
else 
out.append(BRACER + value + BRACER); 
} 
out.append(NEWLINE); 
return out.toString(); 
} 
%><%
ArrayList<ProductResult> list=ProductResultHelper.getTodayOtherProductGroups();
if(list!=null && list.size()>0){
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	StringBuffer str=new StringBuffer();
	str.append("bid,outer_id,color,size,sale_price,storage,");
	str.append(format.format(new Date()));
	str.append("\n");
	StringBuffer w=new StringBuffer();
	for(ProductResult r:list){
		String[] result=new String[]{"2059",r.getGdsmst_gdsid(),",",",",Tools.getDouble(r.getGdsmst_memberprice().doubleValue(), 2)+"","1"};
	w.append(write(result));
	}
	str.append(w.toString());
	out.print(str.toString());
	return;
}else{
	out.print("查询商品列表出错");
	return;
}
%>