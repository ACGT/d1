<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%!
	public static ArrayList<OdrShopTh> getOdrThList(HttpServletRequest request,HttpServletResponse response){
		ArrayList<OdrShopTh> list=new ArrayList<OdrShopTh>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		  String th_rname= request.getParameter("th_rname");
		   String odrid= request.getParameter("odrid");
		   String th_phone= request.getParameter("th_phone");
		   String th_createdates= request.getParameter("th_createdates");
		   String th_createdatee= request.getParameter("th_createdatee");
		   String th_thtype= request.getParameter("th_thtype");
		   String th_status= request.getParameter("th_status");
		   String shopCode= request.getParameter("shopcode");
		   if(!Tools.isNull(odrid)){
			   listRes.add(Restrictions.eq("odrshopth_odrid", odrid));
		   }
		   if(!Tools.isNull(th_rname)){
			   listRes.add(Restrictions.like("odrshopth_rname", "%"+th_rname+"%"));
		   }
		   if(!Tools.isNull(th_phone)){
			   listRes.add(Restrictions.like("odrshopth_phone", th_phone+"%"));
		   }
		   if(!Tools.isNull(th_thtype)){
			   listRes.add(Restrictions.eq("odrshopth_thtype", new Long(th_thtype)));
		   }
	
		   if(!Tools.isNull(th_status)){			  
				   listRes.add(Restrictions.eq("odrshopth_status", new Long(th_status)));

		   }

		   if((!Tools.isNull(th_createdates)||!Tools.isNull(th_createdatee))){
				   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	         Date s=null;
	         Date e=null;
			   if(th_createdates.length()>0&&th_createdatee.length()<=0){
			   	try{
			   		 s=format.parse(th_createdates+" 00:00:00");
			   	  
			   	}catch(Exception ex){
			   		
			   	}
			   }
			   else if(th_createdates.length()<=0&&th_createdatee.length()>0){
			   	try{
			   		
			   	     e=format.parse(th_createdatee+" 00:00:00");
			   	}catch(Exception ex){
			   		
			   	}
			   }
			   else if(th_createdates.length()>0&&th_createdatee.length()>0){
			   	try{		
			   	     e=format.parse(th_createdates+" 00:00:00");
			   	     s=format.parse(th_createdatee+" 00:00:00");
			   	}catch(Exception ex){
			   		System.out.print(ex);
			   	}
			   }
			   if(!Tools.isNull(th_createdates)){
				    listRes.add(Restrictions.ge("odrshopth_createdate", s));
			   }
			   if(!Tools.isNull(th_createdatee)){
				    listRes.add(Restrictions.le("odrshopth_createdate", e));
				   }
	
		
		   }

		   if(!Tools.isNull(shopCode)){
			   listRes.add(Restrictions.eq("odrshopth_shopcode", shopCode));
		   }

	    List<Order> olist=new ArrayList<Order>();
	    olist.add(Order.desc("odrshopth_odrid"));
	    olist.add(Order.desc("odrshopth_createdate"));
		List<BaseEntity> list2 = Tools.getManager(OdrShopTh.class).getList(listRes, olist, 0, 500);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((OdrShopTh)be);
		}
		return list;
	}
public static List<ShpMst> getShopList(){

	List list = Tools.getManager(ShpMst.class).getList(null, null, 0, 200);	
	if(list == null || list.isEmpty()) return null;	
	return list;
}
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单管理</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<link href="../odradmin/images/odrlist.css" rel="stylesheet" type="text/css"  />
<script type="text/javascript">
function odrthForm(obj,odrthid){
    $.ajax({
		type: "get",
		dataType: "json",
		url: '/admin/ajax/odrth.jsp',
		cache: false,
		data: {odrthid:odrthid},
		error: function(XmlHttpRequest){
		},success: function(json){
				$.alert(json.message);
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
</script>
</head>
<body style="text-align:center;" style="overflow-x: hidden">

<table style="width:980px;" border="0" cellpadding="0" cellspacing="0" align="center">
   <tr>
   <td width="980" valign="top">
<table width="980" border="0" cellspacing="0" cellpadding="0" align="center">
<form id="search1" name="search1" method="post" action="index.jsp" >
<input type="hidden" name="act" value="list" />
  <tr>
    <td height="30" colspan="7">时间为空则默认为30天内</td>
  </tr>
  <tr>
    <td width="59" height="40">订单号：</td>
    <td width="185"><input type="text" name="odrid" class="text" value="<%=!Tools.isNull(request.getParameter("odrid"))?request.getParameter("odrid").toString():"" %>" /></td>
    <td width="69">退款时间：</td>
    <td width="186"><input type="text" name="th_createdates" class="text"   value="<%=!Tools.isNull(request.getParameter("th_createdates"))?request.getParameter("th_createdates").toString():"" %>"  style="color:#d4d4d4"  /></td>
    <td width="26">至</td>
    <td colspan="2"><input type="text" name="th_createdatee" class="text"  value="<%=!Tools.isNull(request.getParameter("th_createdatee"))?request.getParameter("th_createdatee").toString():"" %>"  style="color:#d4d4d4" /></td>
  </tr>
  <tr>
    <td height="40">商户：</td>
    <td>
    <%List<ShpMst> shoplist=getShopList(); %>
<select name="shopcode" class="text">
 <option value="" <%=Tools.isNull(request.getParameter("shopcode"))?"selected":"" %>>全部</option>
 <%for(ShpMst shpmst:shoplist){
	 out.print(" <option value=\""+shpmst.getId()+"\" "+(!Tools.isNull(request.getParameter("shopcode"))&&request.getParameter("shopcode").toString().equals(shpmst.getId())?"selected":"") +">"+shpmst.getShpmst_shopname()+"</option>");
 }%>
 </select>
</td>
    <td>手机号：</td>
    <td><input type="text" name="th_phone" class="text"  value="<%=!Tools.isNull(request.getParameter("th_phone"))?request.getParameter("th_phone").toString():"" %>"  /></td>
    <td>&nbsp;</td>
    <td width="152"><select name="th_thtype" class="text">
 	  <option value="1" <%=(!Tools.isNull(request.getParameter("th_thtype"))&&request.getParameter("th_thtype").toString().equals("1")?"selected":"") %>>退货</option>
	  <option value="2" <%=(!Tools.isNull(request.getParameter("th_thtype"))&&request.getParameter("th_thtype").toString().equals("2")?"selected":"") %>>换货</option>
    </select>
      <select name="th_status" class="text">
        <option value="" <%=Tools.isNull(request.getParameter("th_status"))?"selected":"" %>>全部</option>
        <option value="0" <%=!Tools.isNull(request.getParameter("th_status"))&&request.getParameter("th_status").toString().equals("0")?"selected":"" %>>待受理</option>
        <option value="1" <%=!Tools.isNull(request.getParameter("th_status"))&&request.getParameter("th_status").toString().equals("1")?"selected":"" %>>已受理</option>
        <option value="2" <%=!Tools.isNull(request.getParameter("th_status"))&&request.getParameter("th_status").toString().equals("2")?"selected":"" %>>已退款</option>
        <option value="3" <%=!Tools.isNull(request.getParameter("th_status"))&&request.getParameter("th_status").toString().equals("3")?"selected":"" %>>已换货</option>
      </select></td>
    <td width="129"><input type="image" name="imageField" src="../odradmin/images/search.jpg" /></td>
  </tr>
  </form>
  <tr>
    <td height="30" colspan="7">&nbsp;</td>
  </tr>

  <tr>
    <td class="menuodrtd"  colspan="7">退货列表</td>
  </tr>
    <tr>
      <td height="2" colspan="7" bgcolor="#449ae7"></td>
    </tr>
    <tr>
      <td colspan="7">&nbsp;</td>
    </tr>
    <tr>
    <td colspan="7"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="lin">
      <tr class="odrt">
        <td width="136" height="40">订单号</td>
        <td width="180">商品名（编码）</td>
        <td width="67">数量</td>
        <td width="68">金额</td>
        <td width="120">状态</td>
        <td width="140">申请时间<br>受理时间<br>完成时间</td>
      </tr>
      <tr>
        <td colspan="6">
 <%
//String shopCode=session.getAttribute("shopcodelog").toString();
   SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   String[] thstatus = new String[]{"待受理","已受理","已换货"};  
   String[] thstatus2 = new String[]{"待受理","等退款","已退款"}; 
      String ggURL = Tools.addOrUpdateParameter(request,null,null);
      ArrayList<OdrShopTh> list=new ArrayList<OdrShopTh>();
      String act=request.getParameter("act");
      System.out.println(act);
      if(act!=null&&act.equals("list")){
      list=getOdrThList(request,response);
      }
      //分页
      int pageno1=1;
      
      if(ggURL != null) 
      	   {
      	     ggURL.replaceAll("pageno1=[0-9]*","");
      	   }
      //翻页
        int totalLength1 = (list != null ?list.size() : 0);
        int PAGE_SIZE = 30;
        int currentPage1 = 1 ;
        String pg1 ="1";
        if(request.getParameter("pageno1")!=null)
        {
        	pg1= request.getParameter("pageno1");
        }
      
        if(StringUtils.isDigits(pg1))currentPage1 = Integer.parseInt(pg1);
        PageBean pBean1 = new PageBean(totalLength1,PAGE_SIZE,currentPage1);
        int end1 = pBean1.getStart()+PAGE_SIZE;
        if(end1 > totalLength1) end1 = totalLength1;
        
      	String pageURL1 = ggURL.replaceAll("pageno1=[^&]*","");
      	if(!pageURL1.endsWith("&")) pageURL1 = pageURL1 + "&";
      if(list!=null&&list.size()>0)
      {
     	 if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
 		   {
 			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
 		   }
     	 String nextodrid="";
     	 String	strodrid ="";
     	String strsubodrid ="";
     	 String strgdsid="";
     	String strname="";
     	 double dmoney=0d;
     	 long lgdscount=0;
     	 long lstatus=0;
     	 long thtype=0;
     	 String odrthid=""; 
     	 int j=0;
     	DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 	      for(int i=(pageno1-1)*30;i<list.size()&&i<pageno1*30;i++)
     	  {
 	    	 OdrShopTh odrth=list.get(i);
 	    	odrthid=odrth.getId();
 	    	lstatus=odrth.getOdrshopth_status().longValue();
 	    	strodrid =odrth.getOdrshopth_odrid();
 	     	 strgdsid=odrth.getOdrshopth_gdsid();
 	     	strname=odrth.getOdrshopth_gdsname();
 	     	 dmoney=odrth.getOdrshopth_money().doubleValue();
 	     	 lgdscount=odrth.getOdrshopth_gdscount();
 	     	strsubodrid=odrth.getOdrshopth_subodrid().toString();
 	     	thtype=odrth.getOdrshopth_thtype().longValue();
 	   if(!strodrid.equals(nextodrid)){
 	    	if(j!=0){
 	    	out.print(" </table>");
 	    	}
      %>
        
        
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linon">
		 <%	 
 	    	} %>
         <tr>
           <td  class="spantxt" width="136"><span class="spantxt"><%=strodrid %></span></td>
           <td height="40"  class="spantxt" width="180"><%=strname %>（<%=strgdsid %>）</td>
           <td align="center" width="67"><%=lgdscount %></td>
           <td align="center" width="68"><%=Tools.parseDouble(dmoney+"", 2) %></td>
           <td align="center" width="120"><% if(thtype==1){
        	   out.print("退货("+thstatus2[(int)lstatus]+")");
        	   }else{
        		   out.print("换货("+thstatus[(int)lstatus]+")");
        		} %></td>
        	<td align="center" width="140"><%=format.format(odrth.getOdrshopth_createdate()) %><br>
				  <%if(odrth.getOdrshopth_shopcldate()!=null){ %>
				  <%=format.format(odrth.getOdrshopth_shopcldate()) %><br>
				  <%}
				  if(odrth.getOdrshopth_cldate()!=null){ %>
				  <%=format.format(odrth.getOdrshopth_cldate()) %>
				  <%} %></td>
         
         </tr>
 

	 <%j=j++;
	 nextodrid=strodrid;
	   }
      }
%>
  </table>
			</td>
        </tr>
           	  <!-- 分页 -->
						    <%
					           if(pBean1.getTotalPages()>=1){
					           %>
					           <tr>
					   <td colspan="7" height="45">
					           <span class="GPager" style="margin:0px auto; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean1.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean1.getCurrentPage() %></font>页</span>
					           	&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=1">首页</a><%if(pBean1.hasPreviousPage()){%>&nbsp;&nbsp;<a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
					           	for(int i=pBean1.getStartPage();i<=pBean1.getEndPage()&&i<=pBean1.getTotalPages();i++){
					           		if(i==currentPage1){
					           		%>&nbsp;&nbsp;<span class="curr"><%=i %></span><%
					           		}else{
					           		%>&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=<%=i %>"><%=i %></a><%
					           		}
					           	}%>
					           	<%if(pBean1.hasNextPage()){%>&nbsp;&nbsp;<a href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下一页</a><%}%>
					           	&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>
					           </span> </td>
				     </tr><%}%>	
        
    </table></td>
  </tr>
  <tr>
      <td colspan="7">&nbsp;</td>
    </tr>
</table>  

   </td>
   </tr>
</table>
</body>
</html>