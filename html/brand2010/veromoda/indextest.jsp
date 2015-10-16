<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="keywords" content="VEROMODA,VERO MODA,女装,连衣裙,特价" />
<title>VEROMODA专柜正品，女装特价销售2折起，VERO MODA女装，VERO MODA特价，VERO MODAT恤，VERO MODA连衣裙，VEROMODA女装热卖中</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/brand.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
</head>

<body bgcolor="#FFFFFF" text="#000000" topmargin="0">
<!-- 头部开始 -->
<center>
<%@include file="/inc/head.jsp"%>
</center>
<!-- 头部结束 -->
<%
String lasturl="index.jsp?1=1";
String tourl="index.jsp?1=1";
String productname="";
String sequence="-1";
String productsort="020";
String sequenceprice="-1";
String brandname="VERO MODA";
if(request.getParameter("productname")!=null){
	lasturl+="&productname="+request.getParameter("productname").toString();
	productname=request.getParameter("productname").toString();
}
if(request.getParameter("sequence")!=null){
	lasturl+="&sequence="+request.getParameter("sequence").toString();
	sequence=request.getParameter("sequence").toString();
}
if(request.getParameter("productsort")!=null){
	lasturl+="&productsort="+request.getParameter("productsort").toString();
	productsort=request.getParameter("productsort").toString();
}
if(request.getParameter("sequenceprice")!=null){
	sequenceprice=request.getParameter("sequenceprice").toString();
}
//if(request.getParameter("sequenceprice")==null){
	tourl=lasturl;
//}

%>
 <form name=formpage method=post action="index.jsp">
          <input type=hidden name=pageno/>
 </form>
 <center>
<table width="980" border="0" cellpadding="0" cellspacing="0" align="center" >
<tr><td width="980" height="294" ><img src="http://images.d1.com.cn/0730test/VEROMODA.jpg" width="980" height="293" border="0" usemap="#Map"/></td>
</tr>
</table>

<table width="980" border="0" cellpadding="0" cellspacing="0">
<tr bgcolor="b3b3b3">
<td width="17"></td>
<td align="center" valign="middle"  class="td1"><a  class="a1" href="index.jsp?sequence=1" >最新上架</a></td>
<td  class="td1"><a class="a1"  href="index.jsp?productsort=020">热销推荐</a></td>
<td  class="td1"><a class="a1"  href="index.jsp?productsort=020002">百搭T恤</a></td>
<td  class="td1"><a class="a1"  href="index.jsp?productsort=020001">淑女衬衫</a></td>
<td  class="td1"><a class="a1" href="index.jsp?productsort=020008,020009">牛仔裤</a></td>
<td  class="td1"><a class="a1" href="index.jsp?productsort=020010004">连衣裙</a></td>
<td  class="td1"><a class="a1"  href="index.jsp?productsort=020006,020007" >外套/大衣</a></td>
<td  class="td1"><a class="a1"  href="index.jsp?productsort=020&productname=allsale&sequence=4">清仓甩库</a></td>
<td  class="td1"><a class="a1"  href="index.jsp?productsort=020">全部商品</a></td>
</tr>
</table>

<table width="980" border="0" cellspacing="0" cellpadding="0"  height="35" align="center">
      <tr>    
	<td width="884" align="right"><a href="<%=tourl%>&sequenceprice=1"><img src="http://images.d1.com.cn/0730test/pxan_03.gif" width="49" height="32" border="0"></a></td>
		<td width="96"><a href="<%=tourl%>&sequenceprice=0"><img src="http://images.d1.com.cn/0730test/pxan_04.jpg" width="58" height="32" border="0"></a></td>
    </tr>    
    </table>
<%
int total=0;

int currentPageIndex=1;
int pagesize=40;
int PageCount=(total/pagesize)+1;
ArrayList<Product> list=new ArrayList<Product>();
if(request.getParameter("productsort")==null)
{
	ArrayList<PromotionProduct> pplist=PromotionProductHelper.getPProductByCode("8144");
	if(pplist!=null&&pplist.size()>0){
		for(PromotionProduct pp:pplist){
			Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
			if(product!=null&&product.getGdsmst_validflag()!=null&&product.getGdsmst_ifhavegds()!=null&&product.getGdsmst_ifhavegds().longValue()==0&&product.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(product))
			{
				list.add(product);
			}
		}
		total=list.size();
	}
	else{
		list=null;	  
	}
	
}
else{
	total=ProductHelper.getPageTotalByRCode(brandname, productname, productsort+"%");
	list=ProductHelper.getProductListByRCode( brandname, productname, sequence, productsort+"%", sequenceprice,currentPageIndex,pagesize);

}


if(total%pagesize==0){
	PageCount=total/pagesize;
}
if(!Tools.isNull(request.getParameter("pageno")) && Tools.isNumber(request.getParameter("pageno").trim())){
	currentPageIndex=Integer.valueOf(request.getParameter("pageno")).intValue();
}

if(list!=null){

	%>
	 <table width="980" border="0" cellspacing="4" cellpadding="0" align="center" >
<%
int i=0;
for(Product product:list){
	if((i+1)%4==1){
		%>
		<tr>
		<%}
	String gdsmst_imgurl="http://images.d1.com.cn"+product.getGdsmst_imgurl();
		String t=product.getGdsmst_layertype();
		String x=product.getGdsmst_layertitle();
	 	request.setAttribute("t", t);
	    request.setAttribute("x", x);
	    float memberprice=product.getGdsmst_memberprice().floatValue();
		String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
	   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice().floatValue());
		%>
		 <td  align="center" valign="top" style="width=245">
           <table border="0" cellspacing="0" cellpadding="0" align="center" width=220>
           <tr><td height=200 align=center valign=middle>
           <table border="0" cellspacing="0" cellpadding="0" align="center" width=200>
           <tr><td style="border:#cccccc 1px solid;">
           <a href="/product/<%=product.getId()%>" target=_blank style="text-decoration:none;font-size:12px;">
           <img src="<%=gdsmst_imgurl%>" border=0>
		<jsp:include   page= "/sales/showLayer.jsp"   />  
		   </a></div>
           </td></tr>
           </table>
           </td></tr>
           <tr><td><a href="/product/<%=product.getId()%>" style="text-decoration:none;font-size:12px;line-height:22px"><span ><font color=#333333>
           <%=product.getGdsmst_gdsname()%></font></span></a>
           </td></tr>
           <tr>
           <td>
           <span class="main1"  style="font-size:12px;line-height:20px">
           	市场价：<%=sprice%>元<br>
                              会员价：<font color="#ec008c"><%=strmprice%>元</font><br>
                              </span>
           </td>
           </tr>
           </table></td>
	
<%
i++;
if(i%4==0){%> 
	<tr height=15><td></td></tr>
<%}
if(i==list.size() && i%4!=0){
	 for(int m=1;m<=4-(i%4);m++){
		%> 
		 <td width="25%"></td>
<%}} 
}%>
</tr></table>	
<%
}
%>
<table width="98%" border="0" cellspacing="0" cellpadding="0" style="font-size:12px">
    <tr height="35">
    <td width="50%"></td>
   	<td align="center">
 共&nbsp;<b class="eng"><font color="#FF0000"><%=total%></font></b>&nbsp;条记录 &nbsp;&nbsp;共 <b class="eng"><font color="#FF0000"><%=PageCount%></font></b> 页,当前第 <b class="eng"><font color="#FF0000"><%=currentPageIndex%></font></b> 页&nbsp;&nbsp;&nbsp;&nbsp;
                  <%if (currentPageIndex!=1) {%>
                  <a href="javascript:gopage(1)" ><font color="#666666">第一页</font></a> |
                  <%}
			  if (currentPageIndex>1 ){%>
                  <a href="javascript:gopage(<%=currentPageIndex-1%>)" ><font color="#666666">上一页</font></a> &nbsp;&nbsp;
                  <%
			  }
              if (currentPageIndex<PageCount ){
			%>
                  <a href="javascript:gopage(<%=currentPageIndex+1%>)"><font color="#666666">下一页</font></a>&nbsp;&nbsp;
                  <%}
			  if (currentPageIndex!=PageCount){
			%>
                  <a href="javascript:gopage(<%=PageCount%>)"><font color="#666666">末页</font></a>
                  <%}%>
                  &nbsp;
                  <input name="gotonum" type="text" id="gotonum" value="<%=currentPageIndex%>" style="border:1px solid #CCC;width:25px; height:20px;text-align:center;">
                   <input type="button" name="gobtn" value="Go" onClick="javascript:gotopage(document.getElementById('gotonum').value);">
                  </td>
                  </tr>
                  </table>
</center>
<center>
<%@include file="../../../inc/foot.jsp"%>
</center>
  <script language="javascript">
			  var gotonum;
			  gotonum=<%=PageCount%>;
			  function gotopage(args) {
				if(isNumber(args) && args>gotonum) gopage(gotonum); //输入数字大于最大页数
				if(isNumber(args) && args<=gotonum && args>0) gopage(args); //输入正确范围
				if(isNumber(args) && args<1) gopage(1); //输入数字小于0
			  }
function gopage(i)
{
	 if(window.document.formpage==undefined)
	  {
		 $.alert("没有设置pageListForm，无法提交");
	    return;
	  }
  document.formpage.pageno.value=i;
 document.formpage.submit();
}
//判断是否为数字
function jumpTo() {
  var topage = document.getElementById("gotonum").value;
  if(topage)
	  var pattern=/^[0-9]+$/; 
  var result=pattern.exec(topage);
	if(result==null){
		$.alert("页码只能是数字");
		return;
	}else if(topage == 0){
		$.alert("页码必须大于0");
		return;
	}else{
		gopage(topage);
	}
}

</script>
</body>

</html>