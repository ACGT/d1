<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/html/header.jsp" %>
<%!static ArrayList<Directory> getBaseCategory(){
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
//获取推荐位
public static ArrayList<SplRck> GetPRckList(String splcode)
{
	ArrayList<SplRck> list=new ArrayList<SplRck>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("splrck_rackcode", splcode));
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.asc("splrck_seq"));
	List<BaseEntity> b_list = Tools.getManager(SplRck.class).getList(clist, olist, 0, 100);
	if(b_list!=null){
		for(BaseEntity be:b_list){
					list.add((SplRck)be);
	     }
	}
	return list;
}
static ArrayList<Directory> getSubRckmst(String pcode){
	ArrayList<Directory> list2 =new ArrayList<Directory>();
	ArrayList<Directory> list=getAllCategory();
	if(list!=null ){
	for(Directory dir:list){
		if(dir.getRakmst_parentrackcode().trim().equals(pcode)&&dir.getRakmst_showflag()!=null&&dir.getRakmst_showflag().longValue()==1){
				list2.add(dir);
			}
		}
	}
	return list2;
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
static ArrayList<Directory> getRckmst(){
	ArrayList<Directory> list2 =new ArrayList<Directory>();
	ArrayList<Directory> list=getBaseCategory();
	if(list!=null ){
	for(Directory dir:list){
		if(!dir.getId().startsWith("017")&&!dir.getId().startsWith("013")&&dir.getId().trim().length()==3)
		list2.add(dir);
		}
	}
	
	return list2;
}
%>
<%
JSONObject json = new JSONObject();

ArrayList<SplRck> list=GetPRckList("013002006"); 
if(list!=null && list.size()>0){
	json.put("pstatus", "1");
	JSONArray jsonitemarr = new JSONArray();
	 for(SplRck r:list){
		 if (r.getId().equals("000"))continue;
		 JSONObject jsonitem = new JSONObject();
		 
		 JSONArray jsonarr = new JSONArray();
		 jsonitem.put("catename", r.getSplrck_name().trim());
		 jsonitem.put("catecode", r.getId().trim());
		 ArrayList<Promotion> list2=PromotionHelper.getBrandListByCode(r.getId(), 100);
     	if(list2!=null&&list2.size()>0){
     		for(Promotion r2:list2){
		    			JSONObject jitemdtl = new JSONObject();
		    			jitemdtl.put("catename", r2.getSplmst_name());
		    			jitemdtl.put("catecode", r2.getSplmst_url());
		    			
		    			JSONObject jsonitem3 = new JSONObject();
		    			 JSONArray jsonarr3 = new JSONArray();
		    			 ArrayList<Directory> list3=getSubRckmst(r2.getSplmst_url());
		    		     	if(list3!=null&&list3.size()>0){
		    		     		for(Directory r3:list3){
		    		     			if(r3.getRakmst_gdscount().longValue()<=0)continue;
		    				    			JSONObject jitemdtl3 = new JSONObject();
		    				    			jitemdtl3.put("catename", r3.getRakmst_rackname().trim());
		    				    			jitemdtl3.put("catecode", r3.getId().trim());
		    				    			jsonarr3.add(jitemdtl3);
		    				    			
		    				    	}
		    		     		
		    				    	
		    				    }
		    	   jitemdtl.put("item", jsonarr3);
		    	   jsonarr.add(jitemdtl);
		    			
		    	}
     	
		    	
		    }
    	jsonitem.put("item", jsonarr);
     	jsonitemarr.add(jsonitem);
   
     	
	 }
	 json.put("cateroot", jsonitemarr);
	
}else{
json.put("pstatus", "0");
return;
}
out.print(json);
//out.print("{\"pstatus\": \"1\", \"cateroot\": [{\"catename\": \"家纺/居家\", \"catecode\": \"012\",");
		//out.print("\"item\": [{ \"catename\": \"家用清洁\",	\"catecode\": \"012001\"}]}]}");
	               
%>
