<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
String code="";
int num=0;
ArrayList<PromotionProduct> pplist=PromotionProductHelper. getPProductByCode(code);
if(pplist!=null && pplist.size()>0){
	ArrayList<String> gdsidlist=new ArrayList<String>();
	for(PromotionProduct pp:pplist){
		gdsidlist.add(pp.getSpgdsrcm_gdsid());
	}
	if(gdsidlist!=null && gdsidlist.size()>0){
		ArrayList<ProductGroup> list=ProductGroupHelper. getProductGroupsByCode(gdsidlist,num);
		if(list!=null){
			 for(int i=1;i<=list.size();i++){
				 
				 ProductGroup product=list.get(i-1);
				 String ProductName=product.getTgrpmst_gdname();
				 String AutoLink=" index.jsp?ID="+product.getId();
				 if(ProductName.length()>300){
					 ProductName=ProductName.substring(0,300);
				 }
				 SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				 String	nowtime= DateFormat.format(new Date());
				String tgrpmst_id=product.getId();
				 Long lastcount=product.getTgrpmst_supreme()-product.getTgrpmst_relcount();
				 String sprice=ProductGroupHelper.getRoundPrice(product.getTgrpmst_sprice().floatValue());
				 String nprice=ProductGroupHelper.getRoundPrice(product.getTgrpmst_nprice().floatValue());
				 String pprice=ProductGroupHelper.getRoundPrice(product.getTgrpmst_nprice().floatValue()-product.getTgrpmst_sprice().floatValue());
				 double dl= Tools.getDouble(product.getTgrpmst_sprice().doubleValue()*10/product.getTgrpmst_nprice().doubleValue(),1);
				 String fl=ProductGroupHelper.getRoundPrice((float)dl);
				 String	endtime= DateFormat.format(product.getTgrpmst_endtime());
				Date d1=new Date();
				 long diff = product.getTgrpmst_endtime().getTime() - d1.getTime();
				 %>	
				 <tr>
		<td width="490" height="514" background="<%=product.getTgrpmst_actimg()%>">
		<div class="tgleft">
		<A class="a_but" 
      href="/tuan/index.jsp?ID=<%=tgrpmst_id%>" target=_blank></A>	
	  <div class="tgtxt">
	  <%
		
if (diff<30*24*3600 && diff>0){%>

<span class=time id=tjjs_<%=i%>></span>
   <SCRIPT type="text/javascript">
var startDate= new Date("<%=nowtime%>");var endDate= new Date("<%=endtime%>");the_s[<%=i%>]=(endDate.getTime()-startDate.getTime())/1000;
setInterval("view_time(<%=i%>,'tjjs_<%=i%>')",1000);</SCRIPT>
<%}%>
	 </div>
	  <div class="tgtxt">已经有<span class="numcs"><%=product.getTgrpmst_hotmodulus()%></span>人已购买<br>
<span style="font-size:12px; color:#999999;">数量有限，快点下单吧！</span></div>
	  </div>
	  
		<A class=a_gdsimgcs 
      href="/tuan/index.jsp?ID=<%=tgrpmst_id%>" 
      target=_blank></A>		 <div style="clear:both"></div></td>
		<%}
			 }
	}
}
%>