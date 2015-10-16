<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<style type="text/css">
.newlisthzp {width:960px;overflow:hidden; margin:0px auto; background-color:#d4edfd; }
.newlisthzp ul {width:940px;padding-left:20px;  padding-top:15px; padding-bottom:15px;}
.newlisthzp li {float:left; margin-right:20px;overflow:hidden; width:210px; overflow:hidden; margin-bottom:20px;  }
.newlisthzp p {text-align:left; }
.newlisthzp p strong {font-weight:bold; font-size:15px; color:#a63c4f;margin-right:10px;}
.newlisthzp .retime {background:rgba(0,0,0,0.5);font-size:12px;text-align:left;line-height:16px;overflow:hidden; bottom:0px; margin-top:-41px; position:relative; width:200px; padding-top:3px; padding-bottom:2px;
*background:transparent;filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#b3000000,endColorstr=#b3000000); z-index:1111; height:36px; display:none;  }
.retime a{text-decoration:none; }
.lf{ padding:5px; background-color:#fff; over-flow:hidden; }
.newlisthzp p .newspan{ display:block; width:120px; height:35px; margin-top:5px; text-align:center; line-height:35px; border-right:solid 1px #f3f3f3; float:left;}
.newlisthzp p .newspan1{ display:block; width:79px; height:35px; margin-top:5px; text-align:center; line-height:35px; color:#333;float:left;}
.lb{background-color:#f7f7f7;  padding:5px;  width:200px; height:42px; line-height:20px; font-size:12px;color:#7b7b7b; overflow:hidden;
 text-align:left; vertical-align:middle; padding-top:8px;}
.newlisthzp .lf .di{position:absolute;z-index:999;width:79px;height:79px;border:none;}
</style><%!
public static ArrayList<PromotionProduct> getPProductByCode(String code,int num){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));

	//加入排序条件
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.asc("spgdsrcm_seq"));
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, num);
	if(list==null||list.size()==0)return null;	
	for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			rlist.add(pp);
		}
	return rlist ;
}
ArrayList<PromotionProduct> getPProductByCodeGdsid(String code,String id){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
			clist.add(Restrictions.eq("spgdsrcm_gdsid",id));
			
			List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, null, 0, 100);
			
			if(list!=null){
				for(BaseEntity be:list){
					PromotionProduct pp = (PromotionProduct)be;
					rlist.add(pp);
				}
			}
		
	
	return rlist ;
}
ArrayList<Product> getProduct(String code,int num){
	ArrayList<Product> productlist=new ArrayList<Product>(); 
	ArrayList<Product> productlist1=new ArrayList<Product>(); 
	ArrayList<Product> productlist2=new ArrayList<Product>(); 
	ArrayList<PromotionProduct> list=getPProductByCode(code,num);
	if(list!=null && list.size()>0){
		for(PromotionProduct pProduct:list){
			Product product=ProductHelper.getById(pProduct.getSpgdsrcm_gdsid());
			if(product!=null){
				if(Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0){
				productlist2.add(product);
				}else{
					productlist1.add(product);
				}
			}
		}
	}
	if(productlist1!=null && productlist1.size()>0){
		//System.out.println("总数1："+productlist1.size());
		productlist.addAll(productlist1);
	}
	if(productlist2!=null && productlist2.size()>0){
		//System.out.println("总数2："+productlist2.size());
		productlist.addAll(productlist2);

	}
	if(productlist==null||productlist.size()==0)return null;	
	return productlist;
}
%>
<div class="newlisthzp" style=" text-align:center;overflow:hidden; padding-left:20px; padding-bottom:18px; ">
<ul>
<%
String code="7006";
if(request.getAttribute("code")!=null ){
code=request.getAttribute("code").toString();
int len=25;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString().trim());
}
int num=100;
if(request.getAttribute("num")!=null){
	num=Integer.parseInt((request.getAttribute("num")).toString().trim());
}
ArrayList<Product> productlist=getProduct(code,100);

if(productlist!=null){
	for(Product product:productlist){
		ArrayList<PromotionProduct> pproductlist= getPProductByCodeGdsid(code,product.getId());
		Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
		if(pproductlist!=null && directory!=null){
			
		 PromotionProduct pProduct=pproductlist.get(0);
			 String theimgurl="";
			
				 theimgurl=product.getGdsmst_img240300(); 
				 if(Tools.isNull(theimgurl)){
					 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
						 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
					 }else{
						 theimgurl="http://images.d1.com.cn"+product.getGdsmst_midimg();
					 } 
				 }else{
					 theimgurl="http://images.d1.com.cn"+ theimgurl;
				 }
			
			 String imgalt=Tools.clearHTML(product.getGdsmst_gdsname());
			
			 
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
				String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
			   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice().floatValue());
			   double dl= Tools.getDouble(product.getGdsmst_memberprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
				 String fl=ProductGroupHelper.getRoundPrice((float)dl);
				 out.print("<li style=\"height:290px;\">");
	%>
	
<div class="lf">
      				
  <p style="z-index:999; position:relative;height:200px;"><a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank" >
           								<img src="<%= ProductHelper.getImageTo200(product) %>" width="200" height="200" />
           	           
           				
		
		</a>
		<%
		if(Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0){
			%>
			<span style="position:absolute; width:46px; height:90px; dislay:block; background:url('http://images.d1.com.cn/zt2012/20121113flcx/sx.png'); left:8px; top:-8px; z-index:5000;"></span>
		<%}else{
			if (!Tools.isNull(code)&&(Tools.parseInt(code)<8754||Tools.parseInt(code)>8758)){
			%>
		<span style="position:absolute; width:45px; height:56px; dislay:block; background:url('http://images.d1.com.cn/zt2012/20121228qc750/q.png'); left:8px; top:-8px; z-index:5000;"></span>
			<%}
			}
		%>
		
	</p>	
		<div style="background:#e5e1e0; width:200px;height:80px;padding:0px;">
		<div  style="font-size:12px;padding-left:5px;padding-right:5px;padding-top:3px; padding-bottom:0px;height:38px;">
		 <table style="height:38px;">
			              <tr>
			              <td valign="middle">
		<%=StringUtils.getCnSubstring(Tools.clearHTML(pProduct.getSpgdsrcm_gdsname()),0,66)%>
		</td></tr></table>
		 </div>
			              <div  style="font-size:12px;padding-left:5px;padding-right:5px;"> 
			              <table>
			              <tr>
			              <td valign="middle"><span >市场价：￥<%=Tools.getFormatMoney(product.getGdsmst_saleprice()) %>&nbsp;&nbsp;</span></td>
			              <td> <span style=" font-family:'微软雅黑';color:red; font-weight:bold; font-size:30px;">&nbsp;&nbsp;￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %></span></td></tr>
			              </table>
			                 
			           </div>
		</div>
		
		

</div>  <div class="clear"></div>
	
    </li>
		<%	}
	}
}
	}

%>
</ul>
</div>

