<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%!
public static ArrayList<PromotionProduct>  PProductByCode(String code,int num){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("spgdsrcm_seq"));
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, num+10);
	if(list==null||list.size()==0)return null;	
	
	int total = 0 ;
	if(list!=null){
		for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
			if(product == null) continue;
			rlist.add(pp);
			total++;
			if(total==num)break;
		}
	}
		
	//for(BaseEntity be:list){
		//PromotionProduct pp = (PromotionProduct)be;
		//rlist.add(pp);
	//}
	return rlist ;
}

public static ArrayList<Product> getProductlist(ArrayList gdsidlist ,int num){
	
	ArrayList<Product> list=new ArrayList<Product> ();
	if(gdsidlist!=null){
		for(int i=0;i<gdsidlist.size();i++){
			 Product plist= ProductHelper.getById(gdsidlist.get(i).toString());
			if(plist!=null){
					list.add(plist);
			}
		}
	}
	if(list==null || list.size()==0){
		return null;
	}
	
	return list;
}

public static ArrayList<PromotionProduct> getPProductByCodeGdsid(String code,String id){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
			clist.add(Restrictions.eq("spgdsrcm_gdsid",id));
			
			List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, null, 0, 100);
			
			if(list!=null){
				for(BaseEntity be:list){
					PromotionProduct pp = (PromotionProduct)be;
					Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
					if(product == null ) continue;
					rlist.add(pp);
				}
			}
		
	
	return rlist ;
}
%>
<div style="width:980px;  text-align:center;">
<div style="width:965px; overflow:hidden;  padding-bottom:18px; ">
<%
String code="7006";
if(request.getAttribute("code")!=null ){
code=request.getAttribute("code").toString();
int len=25;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString().trim());
}
ArrayList<PromotionProduct> list=PProductByCode(code,len);
ArrayList gdsidlist=new ArrayList();
if(list!=null && list.size()>0){
	
	for(PromotionProduct pProduct:list){
		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
		
	}
	if(gdsidlist!=null && gdsidlist.size()>0){
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
	int i=0;
	ArrayList<Product> productlist=getProductlist(gdsidlist,100);
	int l=0;
	if(productlist!=null){
		for(Product product:productlist){
			
			ArrayList<PromotionProduct> pproductlist= getPProductByCodeGdsid(code,product.getId());
			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
	   
			if(pproductlist!=null && directory!=null){
			
			 PromotionProduct pProduct=pproductlist.get(0);
		     if(Tools.isNull(pProduct.getSpgdsrcm_gdsname()))continue;
			 String theimgurl="";
			 String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
			 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
				 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
			 }else{
				 if(product.getGdsmst_rackcode().startsWith("014")){
				 theimgurl=product.getGdsmst_imgurl();
				 }else{
					 theimgurl=product.getGdsmst_img200250();
				 }
			 }
			 if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
				 theimgurl = "http://images1.d1.com.cn"+theimgurl;
					}else{
						theimgurl = "http://images.d1.com.cn"+theimgurl;
					}
		
			 String spgdsrcm_layertype=pProduct.getSpgdsrcm_layertype();
			 String t="";
				String x="";
				if(spgdsrcm_layertype.trim().length()!=0){ 
					t=spgdsrcm_layertype;
					x=pProduct.getSpgdsrcm_layertitle();
					//PromotionProductHelper.showLayer(spgdsrcm_layertype, promotionProduct.getSpgdsrcm_layertitle());
				}else{
					t=product.getGdsmst_layertype();
					x=product.getGdsmst_layertitle();
					//PromotionProductHelper.showLayer(product.getGdsmst_layertype(),product.getGdsmst_layertitle());
				}
			 request.setAttribute("t", t);
			   request.setAttribute("x", x);
			   float memberprice=product.getGdsmst_memberprice().floatValue();
			   float tjprice=pProduct.getSpgdsrcm_tjprice().floatValue();
				String strtjprice=ProductGroupHelper.getRoundPrice(tjprice);
				String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
			   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice() );
			   String saleprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice());
			   String brandname=product.getGdsmst_brandname();
%>

<div style="  float:left;  width:231px;height:360px; /*FF*/ *height:360px;/*IE7*/ _height:360px;/*IE6*/ _width:232px; <%if (l!=0 && i%4!=0 ){ %>		  margin-left:15px; <%}else{%> margin-left:10px; _margin-left:5px;/*IE6*/ <% }%> margin-top:8px; padding-top:10px; line-height:21px; background-color:#DCDCDC; overflow:hidden;" >

<dl style="text-align:left;">
<dt style="width:205px; text-align:center;padding-left:15px; ">
<%if (product.getGdsmst_rackcode().startsWith("014")){ %>
			<div style="position:relative;left;width:200px;height:200px;">
			<%}else{ %>
				<div style="position:relative;left;width:200px;height:250px;">
			<%} %>
		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
		<img src="<%=theimgurl%>" border=1 style="border-color:#c0c0c0" >
		</a>
		<%if(product.getGdsmst_validflag().longValue()!=1){ %>
		<span style="position:absolute; width:100px; height:100px; dislay:block; background:url('http://images.d1.com.cn/zt2013/1211/buyend.png'); left:0px; top:0px; z-index:5000;"></span>
		<%} %>
		</div>
		</dt>
		<dd style="width:231px; text-align:left; float:left">
	<table width="230" height="60" border="0" cellpadding="0" cellspacing="0" style="background-color:#DCDCDC">
  <tr>
    <td width="72" height="36" rowspan="2" class="d12price"><table width="72" height="60" border="0" cellpadding="0" cellspacing="0" bgcolor="#DD0808">
      <tr>
        <td height="20" colspan="2" align="center" class="pricet"  >双12价</td>
      </tr>
      <tr>
        <td width="18" class="pricet">￥</td>
        <td width="54" class="d12msprice"><%=strtjprice%></td>
      </tr>
    </table></td>
    <td height="40" colspan="2" valign="top" style="line-height:18px;padding-left:5px;" ><%=Tools.substring(imgalt,48)%></td>
  </tr>
  <tr>
    <td width="78">原价<s>￥<%=strmprice%></s></td>
    <td width="80" class="msspan">仅12小时</td>
  </tr>
  <tr>
    <td height="25" colspan="3" align="center" bgcolor="#989898">		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
    <span  class="pricet">立即抢购</span></a></td>
  </tr>
</table>
</dd>
</dl>
</div>
		<%
		l++;
			}
	}
}
	}
}
}
%>
</div>
</div>