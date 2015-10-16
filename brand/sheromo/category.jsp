<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!

//获得品牌下的分类
static HashMap<String, String> getRackByBrand(String brandcode,String rackcode){
	ArrayList<BrandRck> list=new ArrayList<BrandRck>();

		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("brandrck_brand", brandcode));
		clist.add(Restrictions.ge("brandrck_count", new Long(1)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("brandrck_rackcode"));
		List<BaseEntity> b_list = Tools.getManager(BrandRck.class).getList(clist, olist, 0,1000);
		if(b_list==null || b_list.size()==0) return null;		
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((BrandRck)be);
			}
		}
		//去掉重复分类
	
		HashMap<String, String> racklist=new HashMap<String, String>();
		if(list!=null && list.size()>0){
			for(BrandRck product:list){
				if(!Tools.isNull(rackcode)){
					if(product.getBrandrck_rackcode().trim().startsWith(rackcode)){
						racklist.put(product.getBrandrck_rackcode().trim(), brandcode);
					}
				}else{
					racklist.put(product.getBrandrck_rackcode().trim(), brandcode);
				}
				
			}
		}
		return racklist;
}

%><%
			 String brandname="诗若漫";
			 String rackcode="";
			 String productsort="";
			 String url="";
			 String type="";
			 String ispeishi="";
			 if(request.getAttribute("brandname")!=null){
				 brandname=request.getAttribute("brandname").toString();
			 }
			 if(request.getAttribute("rackcode")!=null){
				 rackcode=request.getAttribute("rackcode").toString();
			 }
			 if(request.getAttribute("productsort")!=null){
				 productsort=request.getAttribute("productsort").toString();
			 }
			 if(request.getAttribute("url")!=null){
				 url=request.getAttribute("url").toString();
			 }
			
			 Brand brand=BrandHelper.getBrandByName(brandname) ;
			 if(brand!=null){

			 	HashMap<String, String> map=getRackByBrand(brand.getBrand_code().trim(),rackcode);
			 	
			 	if(map!=null && !map.isEmpty()){
			 	
			 	List<Map.Entry<String, String>> infoIds =
			 					    new ArrayList<Map.Entry<String, String>>(map.entrySet());
			 	
			 	 HashMap<String, String> map2=new HashMap<String, String>();
			 	//排序后
			 	for (int i = 0; i < infoIds.size(); i++) {
			 	    String id = infoIds.get(i).getKey().toString().trim();
			 	   
			 	    	 Directory dir=DirectoryHelper.getById(id);
					 	    if(dir!=null){
					 	    	map2.put(dir.getRakmst_parentrackcode().trim(), dir.getId());
					 	    	
					 	    }
			 	    }
			 	List<Map.Entry<String, String>> infoIds2 =
			 		    new ArrayList<Map.Entry<String, String>>(map2.entrySet());
			 //排序

			 Collections.sort(infoIds2, new Comparator<Map.Entry<String, String>>() {   
			 public int compare(Map.Entry<String, String> o1, Map.Entry<String, String> o2) {      
			 //return (o2.getValue() - o1.getValue()); 
			 return (o1.getKey()).toString().compareTo(o2.getKey());
			 }
			 }); 
			 String str1="";
		     String str2="";
		     boolean man=false;
		     if(!Tools.isNull(rackcode)){
		    	 if(rackcode.startsWith("03")){
		    		 str1="030001,030002,030003,030004,030005,030006,030007";
		    		 str2="030008,030009,030010,030011";
		    		 man=true;
		    	 }else if(rackcode.startsWith("02")){
		    		 str1="020001,020002,020003,020004,020005,020006,020007";
		    		 str2="020008,020009,020010,020011";
		    	 }
		     }%>
		        <div>
	        <span style="color:#fff;font-size:13px; font-weight:bold;">上装</span> </div>
		     <%
			 for (int j = 0; j < infoIds2.size();j++) {
			     String id = infoIds2.get(j).getKey().toString();
			     Directory dir=DirectoryHelper.getById(id);
			    
			 	    if(dir!=null){
			 	    	boolean isselect=false;
			 	    	if(!Tools.isNull(productsort) && productsort.startsWith(dir.getId())){
			 	    		isselect=true;
			 	    	}
			 	    	if(str1.indexOf(dir.getId())>-1){
			 	    		%>	
			 	    		 <ul class="one" style="padding-left:20px;">
			 	    <li <%if(isselect){%>class="current"<%} %>><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a>
			 	 <%//if((isselect || Tools.isNull(url)) && !dir.getId().trim().equals("020004") && !dir.getId().trim().equals("020005") && !dir.getId().trim().equals("020006") && !dir.getId().trim().equals("020007")){ %>
			 	 
			 	 <ul class="two">
			 	  <% 
			 	 for (int k = 0; k < infoIds.size();k++) {
				     String id2 = infoIds.get(k).getKey().toString();
				     if(id2.startsWith(dir.getId().trim())){
				    	 Directory dir2=DirectoryHelper.getById(id2);
				    	 if(dir2!=null){
				    		 boolean isselect2=false;
					 	    	if(!Tools.isNull(productsort) && productsort.equals(dir2.getId())){
					 	    		isselect2=true;
					 	    	}
				    	 %> 
				    	  <li <%if(isselect2){%>class="selected"<%} %>><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=<%=dir2.getId()%>"><%=dir2.getRakmst_rackname().trim() %></a></li>
				    <%   } }
				      }%>
				     
			 	 </ul>
			 	 <%//} %>
			 	 </li>
			 	 
			 	 </ul>   
			 	    	<%}
			 	    	
			 	    
			 	    
			 	     }
			  } %>
		        <div style="padding-top:20px;">
	        <span style="color:#fff;font-size:13px; font-weight:bold;">下装</span></div>
		     <%
			 for (int j = 0; j < infoIds2.size();j++) {
			     String id = infoIds2.get(j).getKey().toString();
			     Directory dir=DirectoryHelper.getById(id);
			    
			 	    if(dir!=null){
			 	    	boolean isselect=false;
			 	    	if(!Tools.isNull(productsort) && productsort.startsWith(dir.getId())){
			 	    		isselect=true;
			 	    	}
			 	    	if(str2.indexOf(dir.getId())>-1){
			 	    		%>	
			 	    		 <ul class="one" style="padding-left:20px;">
			 	    <li <%if(isselect){%>class="current"<%} %>><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a>
			 	 <%if(isselect || Tools.isNull(url)){ %>
			 	 
			 	 <ul class="two">
			 	  <% 
			 	 for (int k = 0; k < infoIds.size();k++) {
				     String id2 = infoIds.get(k).getKey().toString();
				     if(id2.startsWith(dir.getId().trim())){
				    	 Directory dir2=DirectoryHelper.getById(id2);
				    	 if(dir2!=null){
				    		 boolean isselect2=false;
					 	    	if(!Tools.isNull(productsort) && productsort.equals(dir2.getId())){
					 	    		isselect2=true;
					 	    	}
				    	 %> 
				    	  <li <%if(isselect2){%>class="selected"<%} %>><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=<%=dir2.getId()%>"><%=dir2.getRakmst_rackname().trim() %></a></li>
				    <%   } }
				      }%>
				     
			 	 </ul>
			 	 <%} %>
			 	 </li>
			 	 
			 	 </ul>   
			 	    	<%}
			 	    	
			 	    
			 	    
			 	     }
			  } %>


		        <div style="padding-top:20px;">
	        <span style="color:#fff;font-size:13px; font-weight:bold;">配饰</span> </div>
		     <%
			 for (int j = 0; j < infoIds2.size();j++) {
			     String id = infoIds2.get(j).getKey().toString();
			     Directory dir=DirectoryHelper.getById(id);
			    
			 	    if(dir!=null){
			 	    	boolean isselect=false;
			 	    	if(!Tools.isNull(productsort) && productsort.startsWith(dir.getId())){
			 	    		isselect=true;
			 	    	}
			 	    	if((!man && (dir.getId().startsWith("021") || dir.getId().startsWith("022") || dir.getId().startsWith("023"))) && dir.getId().trim().length()>3 ||  dir.getId().startsWith("023")){
			 	    		%>	
			 	    		 <ul class="one" style="padding-left:20px;">
			 	    <li <%if(isselect){%>class="current"<%} %>><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a>
			 	
			 	 </li>
			 	
			 	 </ul>   
			 	    	<%}
			 	    	
			 	    
			 	    
			 	     }
			  } 
			 	}}
			 %>
		      
	         
