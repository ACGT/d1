<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkshop.jsp"%><%!
	public static ArrayList<OdrShopTh> getOdrThList(HttpServletRequest request,HttpServletResponse response,String shopCode){
		ArrayList<OdrShopTh> list=new ArrayList<OdrShopTh>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		  String th_rname= request.getParameter("th_rname");
		   String odrid= request.getParameter("odrid");
		   String th_phone= request.getParameter("th_phone");
		   String th_createdates= request.getParameter("th_createdates");
		   String th_createdatee= request.getParameter("th_createdatee");
		   String th_thtype= request.getParameter("th_thtype");
		   String th_status= request.getParameter("th_status");
		   
		   
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
				   listRes.add(Restrictions.le("odrshopth_status", new Long(th_status)));

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

	
			   listRes.add(Restrictions.eq("odrshopth_shopcode", shopCode));

			  			

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

	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/DatePicker/WdatePicker.js")%>"></script>
<link href="images/odrlist.css" rel="stylesheet" type="text/css"  />
<title>无标题文档</title>
</head>
<script type="text/javascript">
function odrthForm(obj,odrthid){
$.confirm('您确认收到退货并同意退款请点确认,不能恢复！','提示',function(){
    $.ajax({
		type: "get",
		dataType: "json",
		url: '/admin/ajax/odrthshop.jsp',
		cache: false,
		data: {odrthid:odrthid},
		error: function(XmlHttpRequest){
		},success: function(json){
			if(json.code==1){
				$(obj).hide();
				$.alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
	});
}

function odrhhForm(obj,odrthid){

		$.confirm('您确认收到退货并同意换货请点确认,不能恢复！','提示',function(){
    $.ajax({
		type: "get",
		dataType: "json",
		url: '/admin/ajax/odrthshop.jsp',
		cache: false,
		data: {odrthid:odrthid},
		error: function(XmlHttpRequest){
		},success: function(json){
			if(json.code==1){
				$(obj).hide();
				$.alert(json.message+'请刷新页面进行退货操作');
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
	});
}

function odrhhsend(obj,odrthid){

	$.close(); 
	var s="";if((typeof c)!="undefined"){s="?c="+encodeURIComponent(c);}else{s=""+document.location;s=s.replace("http://","");s=s.substring(s.indexOf("/"));s="?c="+encodeURIComponent(s);}$.load('退货单发货',450,'/admin/ajax/odrhhsend.jsp?odrthid='+odrthid);
	$(obj).hide();
}

</script>

<body style="overflow-x: hidden">
<% 
String th_rname= request.getParameter("th_rname")==null?"":request.getParameter("th_rname");
String odrid= request.getParameter("odrid")==null?"":request.getParameter("odrid");
String th_phone= request.getParameter("th_phone")==null?"":request.getParameter("th_phone");
String th_createdates= request.getParameter("th_createdates")==null?"":request.getParameter("th_createdates");
String th_createdatee= request.getParameter("th_createdatee")==null?"":request.getParameter("th_createdatee");
String th_thtype= request.getParameter("th_thtype")==null?"":request.getParameter("th_thtype");
String th_status= request.getParameter("th_status")==null?"":request.getParameter("th_status");

%>
<table width="806" border="0" cellspacing="0" cellpadding="0" align="center">
<form id="search1" name="search1" method="post" action="odrth.jsp" >
<input type="hidden" name="act" value="list" />
  <tr>
    <td height="30" colspan="7">时间为空则默认为30天内</td>
  </tr>
  <tr>
    <td width="59" height="40">订单号：</td>
    <td width="185"><input type="text" name="odrid" class="text" value="<%=odrid%>"/></td>
    <td width="69">退款时间：</td>
    <td width="186"><input type="text" name="th_createdates" class="text"  onclick="WdatePicker();" value="<%=th_createdates%>" style="color:#d4d4d4"  /></td>
    <td width="26">至</td>
    <td colspan="2"><input type="text" name="th_createdatee" class="text"  onclick="WdatePicker();" value="<%=th_createdatee%>" style="color:#d4d4d4" /></td>
  </tr>
  <tr>
    <td height="40">收件人：</td>
    <td><input type="text" name="th_rname" class="text" value="<%=th_rname%>"/></td>
    <td>手机号：</td>
    <td><input type="text" name="th_phone" class="text"  value="<%=th_phone%>"/></td>
    <td>&nbsp;</td>
    <td width="152"><select name="th_thtype" class="text">
      <option value="" <%if(th_thtype.equals("")) {out.println("selected");} %>>全部</option>
	  <option value="1" <%if(th_thtype.equals("1")) {out.println("selected");} %>>退货</option>
	  <option value="2" <%if(th_thtype.equals("2")) {out.println("selected");} %>>换货</option>
    </select>
      <select name="th_status" class="text">
        <option value="" <%if(th_status.equals("")) {out.println("selected");} %>>全部</option>
        <option value="0" <%if(th_status.equals("0")) {out.println("selected");} %>>待受理</option>
        <option value="1" <%if(th_status.equals("1")) {out.println("selected");} %>>已受理</option>
        <option value="2" <%if(th_status.equals("2")) {out.println("selected");} %>>已退货</option>
        <option value="3" <%if(th_status.equals("3")) {out.println("selected");} %>>已换货</option>
      </select></td>
    <td width="129"><input type="image" name="imageField" src="images/search.jpg" /></td>
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
        <td width="80" height="40">订单号</td>
        <td width="145">申请时间<br>处理时间<br>完成时间</td>
        <td width="160">商品名（编码）</td>
           <td width="100">快递</td>
        <td width="67">数量</td>
        <td width="68">退货金额</td>
        <td width="150">退换货原因</td>
        <td width="150">用户备注</td>
        <td width="50">状态</td>
        <td width="80">处理</td>
      </tr>
      <tr>
        <td colspan="9">
 <%
String shopCode=session.getAttribute("shopcodelog").toString();
   SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   String[] thstatus = new String[]{"待受理","已受理","已换货"};  
   String[] thstatus2 = new String[]{"待受理","待退款","已退款"};  
      String ggURL = Tools.addOrUpdateParameter(request,null,null);
      ArrayList<OdrShopTh> list=new ArrayList<OdrShopTh>();
      String act=request.getParameter("act");
      System.out.println(act);
      if(act!=null&&act.equals("list")){
      list=getOdrThList(request,response,shopCode);
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
     	String strodrthid ="";
     	 String strgdsid="";
     	String strname="";
     	String strmemo="";
     	String thwhy="";
     	long thtype=0;
     	 double dmoney=0d;
     	 long lgdscount=0;
     	 long lstatus=0;
     	 int j=0;
     	DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 	      for(int i=(pageno1-1)*30;i<list.size()&&i<pageno1*30;i++)
     	  {
 	    	 OdrShopTh odrth=list.get(i);
 	    	lstatus=odrth.getOdrshopth_status().longValue();
 	    	thtype=odrth.getOdrshopth_thtype().longValue(); 	    	
 	    	strodrid =odrth.getOdrshopth_odrid();
 	     	 strgdsid=odrth.getOdrshopth_gdsid();
 	     	strname=odrth.getOdrshopth_gdsname();
 	     	 dmoney=odrth.getOdrshopth_money().doubleValue();
 	     	 lgdscount=odrth.getOdrshopth_gdscount();
  	     	strmemo=odrth.getOdrshopth_memo();
  	     	thwhy=odrth.getOdrshopth_thwhy();
 	     	strodrthid=odrth.getId();
 	     	
 	   if(!strodrid.equals(nextodrid)){
 	    	if(j!=0){
 	    	out.print(" </table>");
 	    	}
      %>
        
       
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linon">
		 <%	 
 	    	} %>
         <tr>
   
           <td  class="spantxt" width="80" ><span class="spantxt"><a href="admin/odradmin/listdetail.jsp?odrid="<%=strodrid %>" target="_blank"><%=strodrid %></a></span></td>
           <td width="145" ><%=format.format(odrth.getOdrshopth_createdate()) %><br>
<%if(odrth.getOdrshopth_shopcldate()!=null){
out.print(format.format(odrth.getOdrshopth_shopcldate())+"<br>");
}%>
<%  if(odrth.getOdrshopth_cldate()!=null){ %>
			<%=format.format(odrth.getOdrshopth_cldate()) %>
				  <%} %>
</td>
           <td height="40"  width="160" class="spantxt  pdl8"><a href="/product/<%=strgdsid%>" target="_blank"><%=strname %>（<%=strgdsid %>）</a></td>
           <td width="100"><%=odrth.getOdrshopth_shipname()+"("+odrth.getOdrshopth_shipcode()+")" %></td>
           <td align="center" width="67"><%=lgdscount %></td>
           <td align="center" width="68"><%=Tools.parseDouble(dmoney+"", 2) %></td>
           <td align="center" width="150"><%=thwhy %>
           <td align="center" width="150"><%=strmemo %>
           </td>
           <td align="center" width="50" nowrap="nowrap"><% if(thtype==1){
        	   out.print("退货<br/>("+thstatus2[(int)lstatus]+")");
        	   }else{
        		   out.print("换货<br/>("+thstatus[(int)lstatus]+")");
        		} %></td>
           <td align="center" width="80">
           <%if(lstatus==0){
        	   if(thtype==1){%>
           <input type="image" name="imageField22" onclick="odrthForm(this,'<%=strodrthid %>');" src="images/OK.jpg" />
            <%}else{ %>
             <input type="image" name="imageField22" onclick="odrhhForm(this,'<%=strodrthid %>');" src="images/OK.jpg" />
           <%}
           }else if(lstatus==1&&thtype==2){ %>
           <input type="image" name="imageField23" onclick="odrhhsend(this,'<%=strodrthid %>');" src="images/hhsend.jpg" />
           <%}%>
           </td>
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



