<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/inc/funstyle.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>优雅甜心的着装标配-D1优尚网</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">
.imgdp {
	height: 470px;
	width: 240px;
	border: 1px solid #999999;
	overflow:hidden;
	background-repeat: no-repeat;
	background-position: -53px -20px;
}
.gdsimgdp {
	height: 400px;
	width: 270px;
	border: 1px solid #999999;
	overflow:hidden;
	background-repeat: no-repeat;
	background-position: -65px 0px;
}
.gdsdiv{position:relative;}
.gdsdivprice{position:absolute; width:30px;font-weight:800px; height:30px; dislay:block;right:10px; top:10px; z-index:5000;}
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<%
List<Promotion> list=PromotionHelper.getBrandListByCode("3548", 2);
List<Promotion> list2=PromotionHelper.getBrandListByCode("3550", 3);
List<Promotion> list3=PromotionHelper.getBrandListByCode("3551", 3);
List<Promotion> list4=PromotionHelper.getBrandListByCode("3552", 3);
List<Promotion> list5=PromotionHelper.getBrandListByCode("3553", 3);
ArrayList<PromotionProduct> listgds=PromotionProductHelper. getPProductByCode("8821",9);
ArrayList<PromotionProduct> listgds2=PromotionProductHelper. getPProductByCode("8822",9);
ArrayList<PromotionProduct> listgds5=PromotionProductHelper. getPProductByCode("8825",9);
ArrayList<PromotionProduct> listgds7=PromotionProductHelper. getPProductByCode("8827",9);


%>
<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="3">
<%=getimgstr(list,0)%>			
</td>
	</tr>
	<tr>
		<td colspan="3">
<%=getimgstr(list2,0)%>			
</td>
	</tr>
	<tr>
		<td rowspan="2">
<%
if(list2!=null&&list2.size()>0&&list2.get(1)!=null)
{
	Promotion p=list2.get(1);	
	Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(p.getSplmst_name().trim()); 
	out.print("<a href=\""+p.getSplmst_url()+"\" target=\"_blank\" >");
	out.print("<div class=\"imgdp\" style=\"background-image: url(http://images1.d1.com.cn"+ gdscoll.getGdscoll_bigimgurl()+");\" ></div></a>");
}

%>
</td>
		<td colspan="2">
			<table width="738" height="13" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="468" height="13"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="182" rowspan="2">
                    <div class="gdsdiv"><%=getgdsstr(listgds,1,180)%></div>
</td>
                    <td width="102"><div class="gdsdiv"><%=getgdsstr(listgds,2,100)%></div></td>
                    <td rowspan="2"><div class="gdsdiv"><%=getgdsstr(listgds,3,100)%></div></td>
                  </tr>
                  <tr>
                    <td><div class="gdsdiv"><%=getgdsstr(listgds,4,180)%></div></td>
                  </tr>
                  
                </table>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="182" rowspan="2"><div class="gdsdiv"><%=getgdsstr(listgds,5,180)%></div></td>
                      <td width="182" rowspan="2"><div class="gdsdiv"><%=getgdsstr(listgds,6,180)%></div></td>
                      <td><div class="gdsdiv"><%=getgdsstr(listgds,1,100)%></div></td>
                    </tr>
                    <tr>
                      <td><div class="gdsdiv"><%=getgdsstr(listgds,1,100)%></div></td>
                    </tr>
                  </table></td>
                <td >
<%
if(listgds!=null&&listgds.size()>0&&listgds.get(9)!=null)
{
	PromotionProduct gdsrec=listgds.get(9);	
	Product p=ProductHelper.getById(gdsrec.getSpgdsrcm_gdsid());
	String cutimg="";
	if(!Tools.isNull(gdsrec.getSpgdsrcm_otherimg())){
		cutimg=gdsrec.getSpgdsrcm_otherimg();
	}else{	
			   cutimg=p.getGdsmst_midimg();
			   if(cutimg!=null&&cutimg.startsWith("/shopimg/gdsimg")){
				   cutimg = "http://images1.d1.com.cn"+cutimg;
					}else{
						cutimg = "http://images.d1.com.cn"+cutimg;
					}

		
	}
	out.print("<a href=\"http://www.d1.com.cn/product/"+ p.getId() +"\" target=\"_blank\">");
	out.print("<div class=\"gdsimgdp\" style=\"background-image: url("+ cutimg+");\" ></div></a>");
}

%>
</td>
              </tr>
            </table>
			</td>
	</tr>
	<tr>
		<td colspan="2">
<%=getimgstr(list2,2)%>				
</td>
	</tr>
	<tr>
		<td colspan="3">
<% request.setAttribute("code","8823");
		request.setAttribute("length","8");%>
        <jsp:include   page= "/html/gdsrecnew.jsp"   />
</td>
	</tr>
	<tr>
		<td colspan="3">
<%=getimgstr(list3,0)%>			
</td>
	</tr>
	<tr>
		<td colspan="2">
			<table width="738" height="13" border="0" cellpadding="0" cellspacing="0">
              <tr>
			      <td width="270" height="400">
<%
if(listgds2!=null&&listgds2.size()>0&&listgds2.get(0)!=null)
{
	PromotionProduct gdsrec=listgds2.get(0);	
	Product p=ProductHelper.getById(gdsrec.getSpgdsrcm_gdsid());
	String cutimg="";
	if(!Tools.isNull(gdsrec.getSpgdsrcm_otherimg())){
		cutimg=gdsrec.getSpgdsrcm_otherimg();
	}else{	
			   cutimg=p.getGdsmst_midimg();
			   if(cutimg!=null&&cutimg.startsWith("/shopimg/gdsimg")){
				   cutimg = "http://images1.d1.com.cn"+cutimg;
					}else{
						cutimg = "http://images.d1.com.cn"+cutimg;
					}

		
	}
	out.print("<a href=\"http://www.d1.com.cn/product/"+ p.getId() +"\" target=\"_blank\">");
	out.print("<div class=\"gdsimgdp\" style=\"background-image: url("+ cutimg+");\" ></div></a>");
}

%>
</td>
                <td width="468" height="13"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="102">
<div class="gdsdiv"><%=getgdsstr(listgds2,1,100)%></div>
</td>
                      <td width="182" rowspan="2">
                      <div class="gdsdiv"><%=getgdsstr(listgds2,2,180)%></div>
                      </td>
                      <td rowspan="2"><div class="gdsdiv"><%=getgdsstr(listgds2,3,100)%></div></td>
                    </tr>
                    <tr>
                      <td width="182"><div class="gdsdiv"><%=getgdsstr(listgds2,4,180)%></div></td>
                    </tr>
                  </table>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="182" rowspan="2"><div class="gdsdiv"><%=getgdsstr(listgds2,5,180)%></div></td>
                        <td width="102"><div class="gdsdiv"><%=getgdsstr(listgds2,6,100)%></div></td>
                        <td rowspan="2"><div class="gdsdiv"><%=getgdsstr(listgds2,7,180)%></div></td>
                      </tr>
                      <tr>
                        <td><div class="gdsdiv"><%=getgdsstr(listgds2,8,100)%></div></td>
                      </tr>
                  </table></td>
            
              </tr>
            </table>
			</td>
		<td rowspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/fgnew_10.jpg" width="737" height="76" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
<% request.setAttribute("code","8824");
		request.setAttribute("length","8");%>
        <jsp:include   page= "/html/gdsrecnew.jsp"   />
</td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="images/fgnew_12.jpg" width="980" height="169" alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<img src="images/fgnew_13.jpg" width="242" height="477" alt=""></td>
		<td colspan="2">
			<table width="738" height="13" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="468" height="13"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="182" rowspan="2">&nbsp;</td>
                      <td width="102">&nbsp;</td>
                      <td rowspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="182" rowspan="2">&nbsp;</td>
                      <td width="102">&nbsp;</td>
                      <td rowspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                  </table></td>
                <td width="270" height="400">&nbsp;</td>
              </tr>
            </table>
			</td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/fgnew_15.jpg" width="738" height="76" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
<% request.setAttribute("code","8826");
		request.setAttribute("length","8");%>
        <jsp:include   page= "/html/gdsrecnew.jsp"   />
</td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="images/fgnew_17.jpg" width="980" height="144" alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<img src="images/fgnew_18.jpg" width="242" height="479" alt=""></td>
		<td colspan="2"><table width="738" height="13" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="468" height="13"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="182" rowspan="2">&nbsp;</td>
                  <td width="102">&nbsp;</td>
                  <td rowspan="2">&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                </tr>
              </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="182" rowspan="2">&nbsp;</td>
                    <td width="102">&nbsp;</td>
                    <td rowspan="2">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
              </table></td>
            <td width="270" height="400">&nbsp;</td>
          </tr>
        </table></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/fgnew_20.jpg" width="738" height="77" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
<% request.setAttribute("code","8828");
		request.setAttribute("length","8");%>
        <jsp:include   page= "/html/gdsrecnew.jsp"   />
</td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="images/fgnew_22.jpg" width="980" height="155" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="images/fgnew_23.jpg" width="980" height="49" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="images/分隔符.gif" width="242" height="1" alt=""></td>
		<td>
			<img src="images/分隔符.gif" width="495" height="1" alt=""></td>
		<td>
			<img src="images/分隔符.gif" width="243" height="1" alt=""></td>
	</tr>
</table>
<!-- End Save for Web Slices -->
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>