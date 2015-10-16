<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
String rackcode="013007012";
String name="名牌送礼1";
if( request.getAttribute("name")!=null){
	name=request.getAttribute("name").toString();
	ArrayList<Product> list=ProductHelper.getProductListBySCode(rackcode, name);
	//out.print(list.size());
if(list!=null){
	int i=0;
	for(Product product:list){
		if(i%5==0){
			%>
			<tr>
		<%}
		ArrayList<PromotionProduct> plist=PromotionProductHelper.getPromotionProductBySCodeGdsid(rackcode, name,product.getId());
		//ArrayList<Product> productlist=ProductHelper.getProductListBySCode(pproduct.getSpgdsrcm_gdsid());
		if(plist!=null){
			PromotionProduct pproduct=plist.get(0);
			String a_imgstr="";
			String a_textstr="";
		    String mprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_memberprice());
		    String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice());
		    String spgdsrcm_gdsname=pproduct.getSpgdsrcm_gdsname().replace("<font color=red>", "").replace("<font color=blue>", "").replace("</font>", "").replace("<b>", "").replace("</b>", "");
			if(pproduct.getSpgdsrcm_otherlink().trim().length()!=0){
				a_imgstr="<a href="+pproduct.getSpgdsrcm_otherlink().trim()+" target=_blank><img src=http://images.d1.com.cn"+product.getGdsmst_otherimg3()+" width=120 height=120></a>";
				a_textstr="<a href="+pproduct.getSpgdsrcm_otherlink().trim()+" target=_blank>"+spgdsrcm_gdsname+"</a>";
			}else{
				
				a_imgstr="<a href=/product/"+product.getId()+" target=_blank><img class=img1 src=http://images.d1.com.cn"+product.getGdsmst_otherimg3()+" width=120 height=120></a>";
				a_textstr="<a href='/product/"+product.getId()+"' target='_blank'><font color=#aa0000>"+spgdsrcm_gdsname+"</font></a>";
			}
			%>
			<td width="20%" align="center"><table width="130" border="0" cellspacing="0" cellpadding="0" class="sp_outer">
          <tr>
            <td height="130" align="center"><%=a_imgstr%></td>
          </tr>
          <tr>
            <td class="sp_name"><%=a_textstr%></td>
          </tr>
          <tr height=3><td></td></tr>
          <tr>
            <td align="center" class="sp_price01"><font color=#666666>市场价：<strike><%=sprice%>元</strike></font></td>
          </tr>
          <tr>
            <td align="center" class="sp_price02">会员价：<%=mprice%>元</td>
          </tr>
        </table></td>
		<%}
		i++;
		if(i%5==0){
			%>
			</tr>
		<%}
		
	}
	if(i%5!=0){
		for(int j=(i%5)+1;j<=5;j++){
			%>
	          <td width="185" height="130"></td>
	<%
		}%>
		</tr>
	<%}
}
}
//}
%>
