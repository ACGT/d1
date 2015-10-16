<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/inc/funstyle.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>美式休闲-D1优尚网</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">
.newbg001{
	background-image: url(http://images.d1.com.cn/images2013/gdsstyle/bj001.jpg);
	background-repeat: repeat;
}
.newbg002{
	background-image: url(http://images.d1.com.cn/images2013/gdsstyle/bj002.jpg);
	background-repeat: repeat;
}
.newbg003{
	background-image: url(http://images.d1.com.cn/images2013/gdsstyle/bj003.jpg);
	background-repeat: repeat;
}
.newbg004{
	background-image: url(http://images.d1.com.cn/images2013/gdsstyle/bj004.jpg);
	background-repeat: repeat;
}
.newlist {width:980px;overflow:hidden; margin:0px auto;}
.newlist ul {width:980px;padding:0 0 0px; padding-left:4px;  padding-top:15px; padding-bottom:5px;}
.newlist li {float:left; margin-right:4px;overflow:hidden; width:240px; overflow:hidden; }
.newlist p {text-align:left; }
.imgdp {
	height: 474px;
	width: 240px;
	border: 1px solid #999999;
	overflow:hidden;
	background-repeat: no-repeat;
	background-position: -53px -20px;
	position:relative;
}
.gdsimgdp {
	height: 400px;
	width: 270px;
	overflow:hidden;
	background-repeat: no-repeat;
	background-position: -65px 0px;
	position:relative;
}

.gdsdiv{position:relative;}
.gdsdivprice{position:absolute; width:30px;font-weight:bold; height:30px; dislay:block;right:4px; top:4px; z-index:5000;}

.imgdpt{position:absolute;background: #000;color:#fff; font-size:14px; font-weight:800;line-height: 30px;overflow: hidden;bottom: 0px;width: 240px;filter: alpha(opacity=60);-moz-opacity: 0.6;opacity: 0.6;height: 95px;display: block;}
.imgdpt2{position:absolute;background: #000;color:#fff; font-size:14px; font-weight:800;line-height: 30px;overflow: hidden;bottom: 0px;width: 270px;filter: alpha(opacity=60);-moz-opacity: 0.6;opacity: 0.6;height: 95px;display: block;}
.dpprice{ font-size:24px; color:#ff0000; }
.dppricet{ font-size:18px; color:#CCCCCC; }
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->

<%
List<Promotion> list=PromotionHelper.getBrandListByCode("3586", 2);
List<Promotion> list2=PromotionHelper.getBrandListByCode("3587", 3);


ArrayList<PromotionProduct> listgds=getPProductByCode("8856",9);



%>
<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0" align="center">
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
	
	 ArrayList<Gdscolldetail> gdlist1=GdscollHelper.getGdscollBycollid(gdscoll.getId());
     if(gdlist1!=null&&gdlist1.size()>0)
     {
   	    float sum=0f;
	        float zhprice=0;
	        int counts=0;
	        float zk=0.95f;
	        int zzsum=0;

              for(Gdscolldetail gd:gdlist1)
   	       {
   	    	   Product pd=ProductHelper.getById(gd.getGdscolldetail_gdsid());
   	    	   if(pd!=null&&pd.getGdsmst_ifhavegds().longValue()==0&&pd.getGdsmst_validflag().longValue()==1&&gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1&&ProductStockHelper.canBuy(pd))
   	    	   {
   	    		   counts++;
   	    		   zzsum++;
   	    		   sum+=pd.getGdsmst_memberprice().floatValue();
   	    		   zhprice+=Tools.getFloat((int)(pd.getGdsmst_memberprice().floatValue()*zk), 2);
   	    	   }
   	       }
     
	
	out.print("<a href=\""+p.getSplmst_url()+"\" target=\"_blank\" >");
	out.print("<div class=\"imgdp\" style=\"background-image: url(http://images1.d1.com.cn"+ gdscoll.getGdscoll_bigimgurl()+");\" >");
	out.print("<span class=\"imgdpt\">&nbsp;&nbsp;"+gdscoll.getGdscoll_tail()+"<br>");
	out.print("<span class=\"dppricet\">&nbsp;&nbsp;超值组合价：</span><span class=\"dpprice\">￥"+zhprice+" </span></span>");
	out.print("</div></a>");
     }
}

%>
</td>
		<td colspan="2">
			<table width="738" height="13" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="468" height="13"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="182" rowspan="2">
                    <div class="gdsdiv"><%=getgdsstr(listgds,0,180)%></div>
</td>
                    <td width="102"><div class="gdsdiv"><%=getgdsstr(listgds,1,100)%></div></td>
                    <td rowspan="2"><div class="gdsdiv"><%=getgdsstr(listgds,3,180)%></div></td>
                  </tr>
                  <tr>
                    <td><div class="gdsdiv"><%=getgdsstr(listgds,2,100)%></div></td>
                  </tr>
                  
                </table>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="182" rowspan="2"><div class="gdsdiv"><%=getgdsstr(listgds,4,180)%></div></td>
                      <td width="182" rowspan="2"><div class="gdsdiv"><%=getgdsstr(listgds,5,180)%></div></td>
                      <td><div class="gdsdiv"><%=getgdsstr(listgds,6,100)%></div></td>
                    </tr>
                    <tr>
                      <td><div class="gdsdiv"><%=getgdsstr(listgds,7,100)%></div></td>
                    </tr>
                  </table></td>
                <td >
<%
if(listgds!=null&&listgds.size()>8&&listgds.get(8)!=null)
{
	PromotionProduct gdsrec=listgds.get(8);	
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
	out.print("<div class=\"gdsimgdp\" style=\"background-image: url("+ cutimg+");\" >");
	out.print("<span class=\"imgdpt2\">&nbsp;&nbsp;"+StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_gdsname()),0,66)+"<br>");
	out.print("<span class=\"dppricet\">&nbsp;&nbsp;会员价：</span><span class=\"dpprice\">￥"+p.getGdsmst_memberprice()+" </span></span>");
	out.print("</div></a>");
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
		<td colspan="3" class="newbg001">
<% request.setAttribute("code","8857");
		request.setAttribute("length","8");%>
        <jsp:include   page= "/html/gdsrecnew.jsp"   />
</td>
	</tr>	
	
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2013/gdsstyle/分隔符.gif" width="242" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2013/gdsstyle/分隔符.gif" width="495" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2013/gdsstyle/分隔符.gif" width="243" height="1" alt=""></td>
	</tr>
</table>

<%@include file="/inc/foot.jsp"%>
</body>
</html>