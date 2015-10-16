<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.id.SequenceIdGenerator"%><%@include file="../inc/header.jsp"%><%!
public static Map getParameterMap(HttpServletRequest request) {
    // 参数Map
    Map properties = request.getParameterMap();
    // 返回值Map
    Map returnMap = new HashMap();
    Iterator entries = properties.entrySet().iterator();
    Map.Entry entry;
    String name = "";
    String value = "";
    while (entries.hasNext()) {
        entry = (Map.Entry) entries.next();
        name = (String) entry.getKey();
        Object valueObj = entry.getValue();
        if(null == valueObj){
            value = "";
        }else if(valueObj instanceof String[]){
            String[] values = (String[])valueObj;
            for(int i=0;i<values.length;i++){
                value = values[i] + ",";
            }
            value = value.substring(0, value.length()-1);
        }else{
            value = valueObj.toString();
           
        }
        returnMap.put(name, value);
    }
    return returnMap;
}
public static int check(HttpServletRequest request,HttpServletResponse response){
	String strcp_key="0de04d25f205eddc9d521ea1f46dde9a";
	Map rmap=getParameterMap(request);
	 String strbid=rmap.get("bid").toString();
	 String stractive_time=rmap.get("active_time").toString();
	 String strsign=rmap.get("sign").toString();

	long acttime=(new Date()).getTime()/1000;
	long mins=acttime-Tools.parseLong(stractive_time);
    String signrnew=strbid+"#"+stractive_time+"#"+strcp_key+"#"+0+"#";
    String signnew= MD5.to32MD5(signrnew, "Utf-8");
    if(mins/60>=15){
    	return 1;
    }else if(!signnew.equals(strsign)){
    	return 2;
    }else{
    	return 0;
    }
}

static ArrayList<Directory> getAllCategory(){
	ArrayList<Directory> list =new ArrayList<Directory>();

	List<BaseEntity> b_list =Tools.getManager(Directory.class).getList(null, null, 0, 6000);
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((Directory)be);
		}
	}
	
	return list;
}
static ArrayList<Directory> getBaseCategory(){
	ArrayList<Directory> list =new ArrayList<Directory>();
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("rakmst_showflag",new Long(1)));
	clist.add(Restrictions.eq("rakmst_parentrackcode","0"));
	List<BaseEntity> b_list =Tools.getManager(Directory.class).getList(null, null, 0, 100);
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((Directory)be);
		}
	}
	
	return list;
}
static ArrayList<Directory> getRckmst(){
	ArrayList<Directory> list2 =new ArrayList<Directory>();
	ArrayList<Directory> list=getBaseCategory();
	if(list!=null ){
	for(Directory dir:list){
		if(dir.getId().trim().equals("012") || dir.getId().trim().equals("014") || dir.getId().trim().equals("015") || dir.getId().startsWith("02") || dir.getId().startsWith("03")){
				list2.add(dir);
			}
		}
	}
	
	return list2;
}
static ArrayList<Directory> getBaseCategory(String pcode){
	ArrayList<Directory> list =new ArrayList<Directory>();
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	clist.add(Restrictions.like("rakmst_rackcode",pcode+"%"));
	clist.add(Restrictions.eq("rakmst_showflag",new Long(1)));
	clist.add(Restrictions.eq("rakmst_childflag",new Long(0)));
	List<BaseEntity> b_list =Tools.getManager(Directory.class).getList(null, null, 0, 300);
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((Directory)be);
		}
	}
	
	return list;
}


%><%
StringBuffer str=new StringBuffer();
int ret=check(request,response);
if(ret==0){

	
	ArrayList<Directory> list=getRckmst();

	if(list!=null && list.size()>0){

		str.append("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		str.append("<categories>");

			            int i=0;
			            for(Directory r:list){
			         
			            	if(r.getId().startsWith("013"))continue;
			
			            	str.append("<category>");
			            	str.append("<bid>2014070945</bid>");
			            	str.append("<category_name><![CDATA["+r.getRakmst_rackname()+"]]></category_name>");
			            	str.append("<category_id><![CDATA["+r.getId().trim()+"]]></category_id>");
			        	    str.append("<category_parent_id><![CDATA[0]]></category_parent_id>");
			            	str.append("<add_time>"+r.getRakmst_dtcrt().getTime()/1000+"</add_time>");
			            	str.append("<update_time>"+r.getRakmst_dtupd().getTime()/1000+"</update_time>");
			            	str.append("<sort>"+i+"</sort>");
			            	str.append("</category>");
			            	int j=0;
			        	ArrayList<Directory> list2=getBaseCategory(r.getId().trim());
			        	if(list2!=null){
			        		for(Directory r2:list2){
			        			if(r2.getId().startsWith("013"))continue;
			        			str.append("<category>");
				            	str.append("<bid>2014070945</bid>");
				            	str.append("<category_name><![CDATA["+r2.getRakmst_rackname()+"]]></category_name>");
				            	str.append("<category_id><![CDATA["+r2.getId().trim()+"]]></category_id>");
				        	    str.append("<category_parent_id><![CDATA["+r.getId().trim()+"]]></category_parent_id>");
				            	str.append("<add_time>"+r.getRakmst_dtcrt().getTime()/1000+"</add_time>");
				            	str.append("<update_time>"+r.getRakmst_dtupd().getTime()/1000+"</update_time>");
				            	str.append("<sort>"+j+"</sort>");
				            	str.append("</category>");
				            	j++;
			        		}
			        		
			        	}
			        	i++;
			        	}
			            str.append("</categories>");
			      
	}
}
//System.out.print(str.toString());
out.print(str.toString());
 %>