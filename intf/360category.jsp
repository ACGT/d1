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

static ArrayList<Directory> getAllCategory(){
	ArrayList<Directory> list =new ArrayList<Directory>();
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.asc("id"));
	List<BaseEntity> b_list =Tools.getManager(Directory.class).getList(null, listOrder, 0, 3000);
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((Directory)be);
		}
	}
	
	return list;
}
static ArrayList<Directory> getRckmst(){
	ArrayList<Directory> list2 =new ArrayList<Directory>();
	ArrayList<Directory> list=getAllCategory();
	if(list!=null ){
	for(Directory dir:list){
		if(dir.getId().trim().startsWith("012") || dir.getId().trim().startsWith("014") || dir.getId().trim().startsWith("015") || dir.getId().trim().startsWith("017")){
				list2.add(dir);
			}
		}
	}
	
	return list2;
}
static ArrayList<Directory> getSubRckmst(String pcode){
	ArrayList<Directory> list =new ArrayList<Directory>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("rakmst_parentrackcode", pcode));
	List<BaseEntity> b_list =Tools.getManager(Directory.class).getList(listRes, null, 0, 1);
	if(b_list==null || b_list.size()==0){
		return null;
	}
	for(BaseEntity be:b_list){
			list.add((Directory)be);
		}

	return list;
}
%><%
ArrayList<Directory> list=getRckmst();

if(list!=null && list.size()>0){
	StringBuffer stbCatsFile=new StringBuffer();
	 stbCatsFile.append("bid,");
     stbCatsFile.append("category_id,");
     stbCatsFile.append("category_name,");
     stbCatsFile.append("category_pid,");
     stbCatsFile.append("isfinal,");
     stbCatsFile.append("\n");
	StringBuffer w=new StringBuffer();
	for(Directory r:list){
		ArrayList<Directory> list2= getSubRckmst(r.getId().trim());
		if(list2!=null){
			String[] result=new String[]{"2059",r.getId().trim(),Tools.clearHTML( r.getRakmst_rackname().trim()),r.getRakmst_parentrackcode().trim(),"FALSE"};
			w.append(write(result));
		}else{
			String[] result2=new String[]{"2059",r.getId().trim(),Tools.clearHTML( r.getRakmst_rackname().trim()),r.getRakmst_parentrackcode().trim(),"TRUE"};
			w.append(write(result2));
		}
	
	
	}
	stbCatsFile.append(w.toString());
	out.print(stbCatsFile.toString());
	return;
}else{
	out.print("查询商品分类出错");
	return;
}
%>