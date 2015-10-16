<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!

//获得品牌下的分类
static ArrayList<BrandRck> getRackByBrand(String brandcode,String rackcode){
	    ArrayList<BrandRck> list=new ArrayList<BrandRck>();
	    ArrayList<BrandRck> rlist=new ArrayList<BrandRck>();
	    
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("brandrck_brand", brandcode));
		clist.add(Restrictions.ge("brandrck_count", new Long(1)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("brandrck_seq"));
		List<BaseEntity> b_list = Tools.getManager(BrandRck.class).getList(clist, olist, 0,1000);
		if(b_list==null || b_list.size()==0) return null;		
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((BrandRck)be);
			}
		}
		//去掉重复分类
	    if(list!=null && list.size()>0){
			for(BrandRck product:list){
				if(!Tools.isNull(rackcode)){
					if(product.getBrandrck_rackcode().trim().startsWith(rackcode)){
						rlist.add(product);
					}
				}else{
					rlist.add(product);
				}
				
			}
		}
		return rlist;
}

//获得品牌下的分类南方
static ArrayList<BrandRck> getRackByBrandSouth(String brandcode,String rackcode){
	    ArrayList<BrandRck> list=new ArrayList<BrandRck>();
	    ArrayList<BrandRck> rlist=new ArrayList<BrandRck>();
	    
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("brandrck_brand", brandcode));
		clist.add(Restrictions.ge("brandrck_count", new Long(1)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("brandrck_southseq"));
		List<BaseEntity> b_list = Tools.getManager(BrandRck.class).getList(clist, olist, 0,1000);
		if(b_list==null || b_list.size()==0) return null;		
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((BrandRck)be);
			}
		}
		//去掉重复分类
	    if(list!=null && list.size()>0){
			for(BrandRck product:list){
				if(!Tools.isNull(rackcode)){
					if(product.getBrandrck_rackcode().trim().startsWith(rackcode)){
						rlist.add(product);
					}
				}else{
					rlist.add(product);
				}
				
			}
		}
		return rlist;
}



%>
<style>
 .two{ display:none;}
</style>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<script>
    function getdisplay(rackcode)
    {
    	if(rackcode=='033'||rackcode=='015009'||rackcode=='032001'||rackcode=='032002'||rackcode=='032005'||rackcode=='032003')
    		{
	    		var obj=$("ul[attr*='111']");      
		        if(obj.length>0)
		        {
		        	   obj.css('display','block');
		        }
    		}
    	else if(rackcode=='023'||rackcode=='022002'||rackcode=='021'){
    		var obj=$("ul[attr*='222']");      
	        if(obj.length>0)
	        {
	        	   obj.css('display','block');
	        }
    	}
    	else
    		{
		    	if(rackcode.length>=6&&rackcode!=''){
			    	var obj=$("ul[attr*='"+rackcode.substring(0,6)+"']");      
			        if(obj.length>0)
			        {
			        	   obj.css('display','block');
			        }
		    	}
    		}
    	
    }
    
</script>

<%
             String flagbrand="2";
			 String brandname="FEEL MIND";
			 String rackcode="";
			 String productsort="";
			 String url="";
			 String type="";
			 String ispeishi="";
			 if(request.getAttribute("brandname")!=null){
				 brandname=request.getAttribute("brandname").toString();
			 }
			 if(request.getAttribute("flag")!=null){
				 flagbrand=request.getAttribute("flag").toString();
				 
			 }
			 if(request.getAttribute("rackcode")!=null){
				 rackcode=request.getAttribute("rackcode").toString();
			 }
			 if(request.getAttribute("productsort")!=null){
				 productsort=request.getAttribute("productsort").toString();
				 rackcode=productsort;
			 }
			 
			 ArrayList<BrandRck> brlist=new ArrayList<BrandRck>();
			 ArrayList<BrandRck> brlist1=new ArrayList<BrandRck>();
	          if(flagbrand.equals("1"))
	          {
	        	  brlist=getRackByBrandSouth("001346","03");
	        	  brlist1=getRackByBrandSouth("001346","02");
	          }
	          else
	          {
	        	  brlist=getRackByBrand("001346","03");
	        	  brlist1=getRackByBrand("001346","02");
	          }
			%>
			
			<%
				if(flagbrand.equals("1"))
				{%>
				 <h3><a   style="font-size:15px; color:#fff;" href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030" target="_blank">男装分类</a></h3>
			     <ul class="one" style="padding-left:20px;">			
   		 	       <li <%if("030002".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030002">T恤<font style=" font-size:12px;">&nbsp;▶</font></a>
   		 	       <ul class="two" id="ul1" attr="030002">
   		 	        <%
   		 	         
   		 	        	  if(brlist!=null&&brlist.size()>0)
   		 	        	  {
   		 	        		  for(BrandRck br:brlist)
   		 	        		  {
   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030002"))
   		 	        			  {
   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   		 	        					  if(dir!=null)
   		 	        					  {%>
   		 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   		 	        					  <%}
   		 	        			  }
   		 	        		  }
   		 	        	  }
   		 	         
   		 	       %>
   		 	       </ul>
   		 	     </li>
   		 	     <li <%if("030001".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030001">衬衫<font style=" font-size:12px;">&nbsp;▶</font></a>
   		 	       <ul class="two" id="ul2" attr="030001">
   		 	        <%
   		 	         
   		 	        	  if(brlist!=null&&brlist.size()>0)
   		 	        	  {
   		 	        		  for(BrandRck br:brlist)
   		 	        		  {
   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030001"))
   		 	        			  {
   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   		 	        					  if(dir!=null)
   		 	        					  {%>
   		 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   		 	        					  <%}
   		 	        			  }
   		 	        		  }
   		 	        	  }
   		 	         
   		 	       %>
   		 	       </ul>
   		 	     </li>
   		 	     <li <%if("030003".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030003">POLO<font style=" font-size:12px;">&nbsp;▶</font></a>
   		 	       <ul class="two" id="ul3" attr="030003">
   		 	        <%
   		 	         
   		 	        	  if(brlist!=null&&brlist.size()>0)
   		 	        	  {
   		 	        		  for(BrandRck br:brlist)
   		 	        		  {
   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030003"))
   		 	        			  {
   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   		 	        					  if(dir!=null)
   		 	        					  {%>
   		 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   		 	        					  <%}
   		 	        			  }
   		 	        		  }
   		 	        	  }
   		 	         
   		 	       %>
   		 	       </ul>
   		 	     </li>
   		 	     <li <%if("030004".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030004">毛衫<font style=" font-size:12px;">&nbsp;▶</font></a>
   		 	       <ul class="two" id="ul4" attr="030004">
   		 	       <%
   		 	         
   		 	        	  if(brlist!=null&&brlist.size()>0)
   		 	        	  {
   		 	        		  for(BrandRck br:brlist)
   		 	        		  {
   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030004"))
   		 	        			  {
   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   		 	        					  if(dir!=null)
   		 	        					  {%>
   		 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   		 	        					  <%}
   		 	        			  }
   		 	        		  }
   		 	        	  }
   		 	         
   		 	       %>
   		 	       </ul>
   		 	     </li>
   		 	      <li <%if("030005".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030005">卫衣<font style=" font-size:12px;">&nbsp;▶</font></a>
   		 	       <ul class="two" id="ul5" attr="030005">
   		 	       <%
   		 	         
   		 	        	  if(brlist!=null&&brlist.size()>0)
   		 	        	  {
   		 	        		  for(BrandRck br:brlist)
   		 	        		  {
   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030005"))
   		 	        			  {
   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   		 	        					  if(dir!=null)
   		 	        					  {%>
   		 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   		 	        					  <%}
   		 	        			  }
   		 	        		  }
   		 	        	  }
   		 	         
   		 	       %>
   		 	       </ul>
   		 	     </li>
   		 	      <li <%if("030006".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030006">外套<font style=" font-size:12px;">&nbsp;▶</font></a>
   		 	       <ul class="two" id="ul6" attr="030006">
   		 	       <%
   		 	         
   		 	        	  if(brlist!=null&&brlist.size()>0)
   		 	        	  {
   		 	        		  for(BrandRck br:brlist)
   		 	        		  {
   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030006"))
   		 	        			  {
   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   		 	        					  if(dir!=null)
   		 	        					  {%>
   		 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   		 	        					  <%}
   		 	        			  }
   		 	        		  }
   		 	        	  }
   		 	         
   		 	       %>
   		 	       </ul>
   		 	     </li>
   		 	    
   		 	      <li <%if("030007".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030007">棉服/羽绒服<font style=" font-size:12px;">&nbsp;▶</font></a>
   		 	       <ul class="two" id="ul7" attr="030007">
   		 	       <%
   		 	         
   		 	        	  if(brlist!=null&&brlist.size()>0)
   		 	        	  {
   		 	        		  for(BrandRck br:brlist)
   		 	        		  {
   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030007"))
   		 	        			  {
   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   		 	        					  if(dir!=null)
   		 	        					  {%>
   		 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   		 	        					  <%}
   		 	        			  }
   		 	        		  }
   		 	        	  }
   		 	         
   		 	       %>
   		 	       </ul>
   		 	     </li>
   		 	    
   				<li <%if("030008".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030008">长裤<font style=" font-size:12px;">&nbsp;▶</font></a>
   		 	       <ul class="two" id="ul8" attr="030008">
   		 	        <%
   		 	         
   		 	        	  if(brlist!=null&&brlist.size()>0)
   		 	        	  {
   		 	        		  for(BrandRck br:brlist)
   		 	        		  {
   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030008"))
   		 	        			  {
   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   		 	        					  if(dir!=null)
   		 	        					  {%>
   		 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   		 	        					  <%}
   		 	        			  }
   		 	        		  }
   		 	        	  }
   		 	         
   		 	       %>
   		 	       </ul>
   		 	     </li>  
   		 	     <li <%if("030009".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030009">短裤<font style=" font-size:12px;">&nbsp;▶</font></a>
   		 	       <ul class="two" id="ul9" attr="030009">
   		 	        <%
   		 	         
   		 	        	  if(brlist!=null&&brlist.size()>0)
   		 	        	  {
   		 	        		  for(BrandRck br:brlist)
   		 	        		  {
   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030009"))
   		 	        			  {
   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   		 	        					  if(dir!=null)
   		 	        					  {%>
   		 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   		 	        					  <%}
   		 	        			  }
   		 	        		  }
   		 	        	  }
   		 	         
   		 	       %>
   		 	       </ul>
   		 	     </li>
   		 	     
   		 	     
   		 	     <li><a href="javascript:void(0)">配饰<font style=" font-size:12px;">&nbsp;▶</font></a>
   		 	       <ul class="two" id="ul10" attr="111">
   		 	            <li <%if(rackcode.equals("033")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=033">男包</a></li>
   			 	        					      <li <%if(rackcode.equals("015009")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=015009">饰品</a></li>
   			 	        					      <li <%if(rackcode.equals("032001")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032001">帽子</a></li>
   			 	        					      <li <%if(rackcode.equals("032002")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032002">围巾</a></li>	
   			 	        					      <li <%if(rackcode.equals("032005")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032005">腰带</a></li>
   			 	        					      <li <%if(rackcode.equals("032003")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032003">袜子</a></li>
   			 	        					      <li <%if(rackcode.equals("031")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=031">男鞋</a></li>
   			 	    </ul>
   		 	     </li>
   		        </ul>	
				<h3><a  style="font-size:15px; color:#fff;" href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020" target="_blank">女装分类</a></h3>
				<ul class="one" style="padding-left:20px;">			
			 	     <li <%if("020002".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020002">T恤</a>
			 	       <ul class="two" id="ul11" attr="020002">
			 	        <%
			 	         
			 	        	  if(brlist1!=null&&brlist1.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist1)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020002"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	     <li <%if("020001".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020001">衬衫<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" id="ul12" attr="020001">
			 	        <%
			 	         
			 	        	  if(brlist1!=null&&brlist1.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist1)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020001"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	     <li <%if("020003".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020003">POLO<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" id="ul13" attr="020003">
			 	        <%
			 	         
			 	        	  if(brlist1!=null&&brlist1.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist1)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020003"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	     <li <%if("020004".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020004">毛衫<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" id="ul14" attr="020004">
			 	       <%
			 	         
			 	        	  if(brlist1!=null&&brlist1.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist1)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020004"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	      <li <%if("020005".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020005">卫衣<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" id="ul15" attr="020005">
			 	       <%
			 	         
			 	        	  if(brlist1!=null&&brlist1.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist1)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020005"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	      <li <%if("020006".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020006">外套<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" id="ul16" attr="020006">
			 	       <%
			 	         
			 	        	  if(brlist1!=null&&brlist1.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist1)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020006"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	   
			 	      <li <%if("020007".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020007">棉服/羽绒服<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" id="ul17" attr="020007">
			 	       <%
			 	         
			 	        	  if(brlist1!=null&&brlist1.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist1)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020007"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	  
					<li <%if("020008".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020008">长裤<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" id="ul18" attr="020008">
			 	        <%
			 	         
			 	        	  if(brlist1!=null&&brlist1.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist1)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020008"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>  
			 	     <li <%if("020009".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020009">短裤<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" id="ul19" attr="020009">
			 	        <%
			 	         
			 	        	  if(brlist1!=null&&brlist1.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist1)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020009"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	     
			 	     
			 	     <li><a href="javascript:void(0)">配饰<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" id="ul20" attr="222">
			 	       			 <li <%if(rackcode.equals("015009")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=015009">饰品</a></li>
				 	        	 <li <%if(rackcode.equals("022005")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=022005">腰带</a></li>
				 	        	 <li <%if(rackcode.equals("021")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=021">女鞋</a></li>
			 	       </ul>
			 	     </li>
			 </ul>
				<%
				}
				else
				{			
				%>
				
				<h3><a  style="font-size:15px; color:#fff;" href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030" target="_blank">男装分类</a></h3>
				 <ul class="one" style="padding-left:20px;">
   			   
   			 	    <li <%if("030007".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030007">棉服/羽绒服<font style=" font-size:12px;">&nbsp;▶</font></a>
   			 	       <ul class="two" id="ul1" attr="030007">
   			 	       <%
   			 	         
   			 	        	  if(brlist!=null&&brlist.size()>0)
   			 	        	  {
   			 	        		  for(BrandRck br:brlist)
   			 	        		  {
   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030007"))
   			 	        			  {
   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   			 	        					  if(dir!=null)
   			 	        					  {%>
   			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   			 	        					  <%}
   			 	        			  }
   			 	        		  }
   			 	        	  }
   			 	         
   			 	       %>
   			 	       </ul>
   			 	     </li>
   			 	   
   			 	     <li <%if("030006".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030006">外套<font style=" font-size:12px;">&nbsp;▶</font></a>
   			 	       <ul class="two" id="ul2" attr="030006">
   			 	       <%
   			 	         
   			 	        	  if(brlist!=null&&brlist.size()>0)
   			 	        	  {
   			 	        		  for(BrandRck br:brlist)
   			 	        		  {
   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030006"))
   			 	        			  {
   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   			 	        					  if(dir!=null)
   			 	        					  {%>
   			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   			 	        					  <%}
   			 	        			  }
   			 	        		  }
   			 	        	  }
   			 	         
   			 	       %>
   			 	       </ul>
   			 	     </li>
   			 	      <li <%if("030005".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030005">卫衣<font style=" font-size:12px;">&nbsp;▶</font></a>
   			 	       <ul class="two" id="ul3" attr="030005">
   			 	       <%
   			 	         
   			 	        	  if(brlist!=null&&brlist.size()>0)
   			 	        	  {
   			 	        		  for(BrandRck br:brlist)
   			 	        		  {
   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030005"))
   			 	        			  {
   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   			 	        					  if(dir!=null)
   			 	        					  {%>
   			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   			 	        					  <%}
   			 	        			  }
   			 	        		  }
   			 	        	  }
   			 	         
   			 	       %>
   			 	       </ul>
   			 	     </li>
   			 	     <li <%if("030004".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030004">毛衫<font style=" font-size:12px;">&nbsp;▶</font></a>
   			 	       <ul class="two" id="ul4" attr="030004">
   			 	       <%
   			 	         
   			 	        	  if(brlist!=null&&brlist.size()>0)
   			 	        	  {
   			 	        		  for(BrandRck br:brlist)
   			 	        		  {
   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030004"))
   			 	        			  {
   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   			 	        					  if(dir!=null)
   			 	        					  {%>
   			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   			 	        					  <%}
   			 	        			  }
   			 	        		  }
   			 	        	  }
   			 	         
   			 	       %>
   			 	       </ul>
   			 	     </li>
   			 	     <li <%if("030001".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030001">衬衫<font style=" font-size:12px;">&nbsp;▶</font></a>
   			 	       <ul class="two" id="ul5" attr="030001">
   			 	        <%
   			 	         
   			 	        	  if(brlist!=null&&brlist.size()>0)
   			 	        	  {
   			 	        		  for(BrandRck br:brlist)
   			 	        		  {
   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030001"))
   			 	        			  {
   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   			 	        					  if(dir!=null)
   			 	        					  {%>
   			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   			 	        					  <%}
   			 	        			  }
   			 	        		  }
   			 	        	  }
   			 	         
   			 	       %>
   			 	       </ul>
   			 	     </li>
   			 	     <li <%if("030002".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030002">T恤<font style=" font-size:12px;">&nbsp;▶</font></a>
   			 	       <ul class="two" id="ul6" attr="030002">
   			 	        <%
   			 	         
   			 	        	  if(brlist!=null&&brlist.size()>0)
   			 	        	  {
   			 	        		  for(BrandRck br:brlist)
   			 	        		  {
   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030002"))
   			 	        			  {
   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   			 	        					  if(dir!=null)
   			 	        					  {%>
   			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   			 	        					  <%}
   			 	        			  }
   			 	        		  }
   			 	        	  }
   			 	         
   			 	       %>
   			 	       </ul>
   			 	     </li>
   			 	     <li <%if("030003".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030003">POLO<font style=" font-size:12px;">&nbsp;▶</font></a>
   		 	       <ul class="two" id="ul7" attr="030003">
   		 	        <%
   		 	         
   		 	        	  if(brlist!=null&&brlist.size()>0)
   		 	        	  {
   		 	        		  for(BrandRck br:brlist)
   		 	        		  {
   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030003"))
   		 	        			  {
   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   		 	        					  if(dir!=null)
   		 	        					  {%>
   		 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   		 	        					  <%}
   		 	        			  }
   		 	        		  }
   		 	        	  }
   		 	         
   		 	       %>
   		 	       </ul>
   		 	     </li>
   			 	     <li <%if("030008".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030008">长裤<font style=" font-size:12px;">&nbsp;▶</font></a>
   			 	       <ul class="two" id="ul8" attr="030008">
   			 	        <%
   			 	         
   			 	        	  if(brlist!=null&&brlist.size()>0)
   			 	        	  {
   			 	        		  for(BrandRck br:brlist)
   			 	        		  {
   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030008"))
   			 	        			  {
   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   			 	        					  if(dir!=null)
   			 	        					  {%>
   			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   			 	        					  <%}
   			 	        			  }
   			 	        		  }
   			 	        	  }
   			 	         
   			 	       %>
   			 	       </ul>
   			 	     </li>
   			 	     <li <%if("030009".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030009">短裤<font style=" font-size:12px;">&nbsp;▶</font></a>
   			 	       <ul class="two" id="ul9" attr="030009">
   			 	        <%
   			 	         
   			 	        	  if(brlist!=null&&brlist.size()>0)
   			 	        	  {
   			 	        		  for(BrandRck br:brlist)
   			 	        		  {
   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030009"))
   			 	        			  {
   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
   			 	        					  if(dir!=null)
   			 	        					  {%>
   			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
   			 	        					  <%}
   			 	        			  }
   			 	        		  }
   			 	        	  }
   			 	         
   			 	       %>
   			 	       </ul>
   			 	     </li>
   			 	     
   			 	     
   			 	     <li><a href="javascript:void(0)">配饰<font style=" font-size:12px;">&nbsp;▶</font></a>
   			 	       <ul class="two" id="ul10" attr="111">
   			 	        <li <%if(rackcode.equals("033")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=033">男包</a></li>
   			 	        <li <%if(rackcode.equals("015009")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=015009">饰品</a></li>
   			 	        <li <%if(rackcode.equals("032001")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032001">帽子</a></li>
   			 	        <li <%if(rackcode.equals("032002")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032002">围巾</a></li>	
   			 	        <li <%if(rackcode.equals("032005")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032005">腰带</a></li>
   			 	        <li <%if(rackcode.equals("032003")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032003">袜子</a></li>
   			 	        <li <%if(rackcode.equals("031")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=031">男鞋</a></li>
   			 	           
   			 	       </ul>
   			 	     </li>
   			      </ul>	   
				 <h3><a  style="font-size:15px; color:#fff;" href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020" target="_blank">女装分类</a></h3>
				  <ul class="one" style="padding-left:20px;">
				 
				 	    <li <%if("020007".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020007">棉服/羽绒服<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" id="ul11" attr="020007">
				 	       <%
				 	         
				 	        	  if(brlist1!=null&&brlist1.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist1)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020007"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 
				 	     <li <%if("020006".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020006">外套<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" id="ul12" attr="020006">
				 	       <%
				 	         
				 	        	  if(brlist1!=null&&brlist1.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist1)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020006"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 	      <li <%if("020005".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020005">卫衣<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" id="ul13" attr="020005">
				 	       <%
				 	         
				 	        	  if(brlist1!=null&&brlist1.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist1)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020005"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 	     <li <%if("020004".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020004">毛衫<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" id="ul14" attr="020004">
				 	       <%
				 	         
				 	        	  if(brlist1!=null&&brlist1.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist1)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020004"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 	     <li <%if("020001".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020001">衬衫<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" id="ul15" attr="020001">
				 	        <%
				 	         
				 	        	  if(brlist1!=null&&brlist1.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist1)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020001"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 	     <li <%if("020002".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020002">T恤<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" id="ul16" attr="020002">
				 	        <%
				 	         
				 	        	  if(brlist1!=null&&brlist1.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist1)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020002"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 	     <li <%if("020003".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020003">POLO<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" id="ul17" attr="020003">
			 	        <%
			 	         
			 	        	  if(brlist1!=null&&brlist1.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist1)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020003"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
				 	     <li <%if("020008".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020008">长裤<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" id="ul18" attr="020008">
				 	        <%
				 	         
				 	        	  if(brlist1!=null&&brlist1.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist1)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020008"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 	     <li <%if("020009".equals(rackcode))   {%>class="current"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020009">短裤<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" id="ul19" attr="020009">
				 	        <%
				 	         
				 	        	  if(brlist1!=null&&brlist1.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist1)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020009"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li <%if(rackcode.equals(dir.getId())){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 	     
				 	     
				 	     <li><a href="javascript:void(0)">配饰<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" id="ul20" attr="222">
				 	            <li <%if(rackcode.equals("015009")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=015009">饰品</a></li>
				 	        	<li <%if(rackcode.equals("022005")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=022005">腰带</a></li>
				 	        	<li <%if(rackcode.equals("021")){%>class="selected"<%} %>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=021">女鞋</a></li>
				 	           
				 	       </ul>
				 	     </li>
				 </ul>	       
				
		           
   			
   			<%}        	   
     %>

		        
<script>
$(document).ready(function(){
	$('.one li:not(.two li)').each(function(i){
    	$(this).mouseover(function(){
    		overul(i+1);
    	});
    	$(this).mouseout(function(){
    		outul(i+1);
    	});
    });
	var rc='<%=rackcode%>';
	if(rc!='020'&&rc!='030')
	{
		getdisplay('<%=rackcode%>');
	}
	
	
});
function overul(flag)
{
    var obj =$('#ul'+flag);
    if(obj.length>0)
    	{
    	   obj.css('display','block');
    	}
}
function outul(flag)
{
    var obj =$('#ul'+flag);
    if(obj.length>0)
    	{
    	   obj.css('display','none');
    	}
}
  
   
</script>         
