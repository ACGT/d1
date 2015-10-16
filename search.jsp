<%@ page contentType="text/html; charset=UTF-8"%><%@include file="inc/header.jsp"%>
<%@include file="/html/getComment.jsp" %>
<%!
/**
 * 获得服装图 200x250
 * @param product - 商品对象
 * @return String
 */
public static String getImageTo200250(Product product){
	String img = (product != null ? product.getGdsmst_img200250() : null);
	if(!Tools.isNull(img)&&product.getGdsmst_img200250().length()>0) 
	if(img!=null&&img.startsWith("/shopimg/gdsimg")){
		img = "http://images1.d1.com.cn"+img.trim();
	}else{
		img = "http://images.d1.com.cn"+img.trim();
	}
	else{
		return "";
	}
	
	return img;
}
//获得推荐位
private static String getTJNumber(String code){
	String result = "2573";
	if(code != null && !"000".equals(code)){
		if("014".equals(code)){
			result = "2573";//化妆品
		}else if("015009".equals(code)){
			result = "2529";//饰品
		}else if("017001".equals(code)){
			result = "2607";//女装
		}else if("017002".equals(code)){
			result = "2597";//男装
		}else if("017005".equals(code)){
			result = "2691";//女包
		}else if("015002004".equals(code)){
			result = "2648";//名表
		}else{
			if(code.indexOf("014") != -1){
				result = "2573";
			}else if(code.indexOf("015") != -1){
				result = "2529";
			}else if(code.indexOf("017") != -1){
				result = "2607";
			}else{
				result = "2573";
			}
		}
	}
	return result;
}
private static String setrim(String s) {
    int i = s.length();// 字符串最后一个字符的位置
    int j = 0;// 字符串第一个字符
    int k = 0;// 中间变量
    char[] arrayOfChar = s.toCharArray();// 将字符串转换成字符数组
    while ((j < i) && (arrayOfChar[(k + j)] <= ' '))
     ++j;// 确定字符串前面的空格数
    while ((j < i) && (arrayOfChar[(k + i - 1)] <= ' '))
     --i;// 确定字符串后面的空格数
    return (((j > 0) || (i < s.length())) ? s.substring(j, i) : s);// 返回去除空格后的字符串
  }


//0-49   99  199  299 399 499  599  799   999  1999 2999 3999  4999-	

public static String getpricestrmap(Map<String,String> priceMap){
  String pricestr="0-";
	int prnum=0;
	 if(Tools.parseInt(priceMap.get("price1"))>3){
		 pricestr=pricestr+"49,50-";
	 }else{
		 prnum=Tools.parseInt(priceMap.get("price1"));
	 }
	 if(Tools.parseInt(priceMap.get("price2"))+prnum>3){
		 pricestr=pricestr+"99,100-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price2"));
	 }
	 if(Tools.parseInt(priceMap.get("price3"))+prnum>3){
		 pricestr=pricestr+"199,200-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price3"));
	 }
	 if(Tools.parseInt(priceMap.get("price4"))+prnum>3){
		 pricestr=pricestr+"299,300-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price4"));
	 }
	 if(Tools.parseInt(priceMap.get("price5"))+prnum>3){
		 pricestr=pricestr+"399,400-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price5"));
	 }
	 if(Tools.parseInt(priceMap.get("price6"))+prnum>3){
		 pricestr=pricestr+"499,500-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price6"));
	 }
	 if(Tools.parseInt(priceMap.get("price7"))+prnum>3){
		 pricestr=pricestr+"599,600-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price7"));
	 }
	 if(Tools.parseInt(priceMap.get("price8"))+prnum>3){
		 pricestr=pricestr+"799,800-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price8"));
	 }
	 if(Tools.parseInt(priceMap.get("price9"))+prnum>3){
		 pricestr=pricestr+"999,1000-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price9"));
	 }
	 if(Tools.parseInt(priceMap.get("price10"))+prnum>3){
		 pricestr=pricestr+"1999,2000-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price10"));
	 }
	 if(Tools.parseInt(priceMap.get("price11"))+prnum>3){
		 pricestr=pricestr+"2999,3000-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price11"));
	 }
	 if(Tools.parseInt(priceMap.get("price12"))+prnum>3){
		 pricestr=pricestr+"3999,4000-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price12"));
	 }
	 if(Tools.parseInt(priceMap.get("price13"))+prnum>3&&Tools.parseInt(priceMap.get("price14"))>=3){
		 pricestr=pricestr+"4999,5000-";
		
	 }
	 prnum+=Tools.parseInt(priceMap.get("price13"));
	 prnum+=Tools.parseInt(priceMap.get("price14"));
	 if(prnum==0){
		 pricestr=pricestr.substring(0,pricestr.length()-1);
		 pricestr=pricestr.substring(0,pricestr.lastIndexOf("-")+1);
		 
	 }
	 
	return pricestr;
}
private static String urlrepstr(String url){
	if(Tools.isNull(url))return "";
	if(url.endsWith("&"))url=url.substring(0,url.length()-1);
	url=url.replace("?&", "?");
	url=url.replace("&&", "&");
	
	return url;
}
%><%
    //一共有几个参数key_wds=搜索词,sort=排序字段,rackcode=分类,pg=当前页,headsearchkey=头部搜索词,asc=升降序
	String keyWords = request.getParameter("key_wds"),rackcode=request.getParameter("rackcode"),
		sort = request.getParameter("sort"),pg = request.getParameter("pg"),asc = request.getParameter("asc");
  // if(keyWords!=null&&keyWords.indexOf("施华洛")>=0){
	//   keyWords="";
  // }
   String  gourl = request.getParameter("gourl");
    String msflag = request.getParameter("msflag");
    String shopd1 = request.getParameter("shopd1");
    String pprice = request.getParameter("pprice");
    String brand = request.getParameter("brand");
    String stdv1 = request.getParameter("stdv1");
    String stdv2 = request.getParameter("stdv2");
    String stdv3 = request.getParameter("stdv3");
    String stdv6 = request.getParameter("stdv6");
    
	boolean isAsc = ("true".equals(asc)?true:false) ;
	
	String isAscStr = "";
	if(isAsc)isAscStr="true";
	else isAscStr="false";
			
	String sk = request.getParameter("headsearchkey");
	if(sk!=null){
		sk=setrim(sk);
	}
	
	   //if(sk!=null&&sk.indexOf("施华洛")>=0){
		//   sk="";
	  // }
	
	if(!Tools.isNull(sk)){//重新搜索了
		
		if(sk.length()==8&&StringUtils.isDigits(sk)){
			Product searchProduct = (Product)Tools.getManager(Product.class).get(sk);
			if(searchProduct!=null){
				response.sendRedirect("http://www.d1.com.cn/product/"+searchProduct.getId());
				return;
			}
		}
		if(sk.length()==10&&sk.toUpperCase().startsWith("BK")&&"01720270".equals(sk.substring(2))){
				response.sendRedirect("http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=bk01720270&url=http://www.d1.com.cn/product/01720270");
				return;
		}
		if(sk.length()==11&&sk.toUpperCase().startsWith("FAS")){
			Product searchProduct = (Product)Tools.getManager(Product.class).get(sk.substring(3));
			if(searchProduct!=null){
				response.sendRedirect("http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=2012xjdm_fas&url=http://www.d1.com.cn/product/"+searchProduct.getId());
				return;
			}
		}
		if(sk.length()==10&&sk.toUpperCase().startsWith("FM")){
			Product searchProduct = (Product)Tools.getManager(Product.class).get(sk.substring(2));
			if(searchProduct!=null){
				response.sendRedirect("http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=fmdapeidm&url=http://www.d1.com.cn/product/"+searchProduct.getId());
				return;
			}
		}
		if(sk.length()==10&&sk.toUpperCase().startsWith("FA")){
			Product searchProduct = (Product)Tools.getManager(Product.class).get(sk.substring(2));
			if(searchProduct!=null){
				response.sendRedirect("http://www.d1.com.cn/html/index99.asp?id=dmfa12&md=d1_1111&url=http://www.d1.com.cn/product/"+searchProduct.getId());
				return;
			}
		}
		if(sk.length()==10&&sk.toUpperCase().startsWith("WE")){
			Product searchProduct = (Product)Tools.getManager(Product.class).get(sk.substring(2));
			if(searchProduct!=null){
				response.sendRedirect("http://www.d1.com.cn/html/index99.asp?id=dmwe1110&md=d1_1111&url=http://www.d1.com.cn/product/"+searchProduct.getId());
				return;
			}
		}
		if(sk.length()==10&&sk.toUpperCase().startsWith("DM")){
		
			Product searchProduct = (Product)Tools.getManager(Product.class).get(sk.substring(2));
			if(searchProduct!=null){
				if (searchProduct.getGdsmst_validflag()==1){
				if("01416134".equals(sk.substring(2))){
					boolean blngds=true;
					ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);	
					if(cartList!=null){
						for(Cart c123:cartList){
							if(c123.getType().longValue()==14&&c123.getProductId().equals("01416134")){
								blngds=false;
							}
						}
					}

					if(blngds){
					Cart cart =new Cart();
					cart.setAmount(new Long(1));
					cart.setCookie(CartHelper.getCartCookieValue(request, response));
					cart.setCreateDate(new Date());
					cart.setHasChild(new Long(0));
					cart.setHasFather(new Long(0));
					cart.setIp(request.getRemoteHost());
					cart.setMoney(new Float(0));
					cart.setOldPrice(new Float(0));
					cart.setPoint(new Long(0));
					cart.setPrice(new Float(0));
					cart.setSkuId("");
					cart.setTuanCode("");//注意parentId值
					cart.setProductId("01416134");
					cart.setType(new Long(14));
					cart.setUserId(CartHelper.getCartUserId(request, response));
					cart.setVipPrice(new Float(0));
					cart.setTitle("【网易DM刊赠品】"+searchProduct.getGdsmst_gdsname());
					Tools.getManager(Cart.class).create(cart);
					response.sendRedirect("/flow.jsp");
					return;
					}
					else
					{
						response.sendRedirect("http://www.d1.com.cn/html/index99.asp?id=dm1215&md=d1_1111&url=http://www.d1.com.cn/product/"+searchProduct.getId());
						return;
					}
				}
				else{
				response.sendRedirect("http://www.d1.com.cn/html/index99.asp?id=dm1215&md=d1_1111&url=http://www.d1.com.cn/product/"+searchProduct.getId());
				return;
				}
				}
			}
		}
		
		//这里看关键词是否需要跳转，如果需要跳转，直接跳转后不执行搜索
		KeySearch keySearch = (KeySearch)Tools.getManager(KeySearch.class).findByProperty("keysearch_txt",sk.trim());
		if(keySearch!=null&&!Tools.isNull(keySearch.getKeysearch_link())){
			response.sendRedirect(keySearch.getKeysearch_link());
			return;
		}
	
		keyWords = sk ;
		rackcode = null ;
		session.removeAttribute(SearchManager.search_result_session_key);//重新搜索的话把原来session的搜索结果清除
	}else{
		if(keyWords!=null)keyWords=keyWords.replaceAll(" ", "+");
		if(keyWords!=null&&keyWords.length()>0)
		{
		    keyWords = Base64.decode(keyWords);//用base64编码传中文，免得出现乱码问题
		}
		//if(keyWords!=null&&keyWords.indexOf("施华洛")>=0){
			//   keyWords="";
		  // }
	}
	
	if(keyWords!=null)keyWords=keyWords.replaceAll(" +"," ");//把多个空格替换成一个空格
	//搜索结果
	SearchResult sr = SearchManager.getInstance().searchProduct(
			request,response,
			rackcode,
			keyWords,
			60000);//缓存时间，毫秒
			// 添加搜索记录
    if(request.getParameter("headsearchkey")!=null)
	{
		String key=request.getParameter("headsearchkey");
		Searchrecord srecord=new Searchrecord();
		srecord.setSearchrecord_count(new Long(sr.getTotalcount("")));
		srecord.setSearchrecord_createtime(new Date());
		srecord.setSearchrecord_ip(request.getRemoteHost());
		srecord.setSearchrecord_keyword(key);
		if(lUser!=null){
		    srecord.setSearchrecord_mbrname(lUser.getMbrmst_uid());
	    }
		Tools.getManager(Searchrecord.class).create(srecord);
	}
					
	final int PAGE_SIZE = 48 ;//每页多少个
	int currentPage = 1 ;//当前页
	
	if(StringUtils.isDigits(pg)){
		currentPage = new Integer(pg).intValue();
	}
	Object[] obj=sr.getProducts2014(rackcode,pprice,brand,msflag,shopd1,stdv1,stdv2,stdv3,stdv6);
	PageBean pb = new PageBean(Tools.parseLong(obj[0]+"") ,PAGE_SIZE,currentPage);//翻页的PageBean
		
	StringBuffer sb = new StringBuffer();
	sb.append("key_wds="+Base64.encode(keyWords)).append("&");
	if(!Tools.isNull(rackcode)){
		sb.append("rackcode="+rackcode+"&");
		
	}
	
	if(!Tools.isNull(sort)){
		sb.append("sort="+sort+"&");
	}
	if(!Tools.isNull(brand)){
		sb.append("brand="+brand+"&");
		
	}
	if(!Tools.isNull(asc)){
		sb.append("asc="+asc+"&");
	}
	if(!Tools.isNull(msflag)){
		sb.append("msflag="+msflag+"&");
	}
	 if(!Tools.isNull(shopd1)){
		sb.append("shopd1="+shopd1+"&");
	}
	if(!Tools.isNull(pprice)){
		sb.append("pprice="+pprice+"&");
	} 
	if(!Tools.isNull(stdv1)){
		sb.append("stdv1="+stdv1+"&");
	} 
	if(!Tools.isNull(stdv2)){
		sb.append("stdv2="+stdv2+"&");
	} 
	if(!Tools.isNull(stdv3)){
		sb.append("stdv3="+stdv3+"&");
	} 
	if(!Tools.isNull(stdv6)){
		sb.append("stdv6="+stdv6+"&");
	} 
	String pgQueryString = sb.toString();
	
	String ggURL = Tools.addOrUpdateParameter(request,null,null);
	if(ggURL != null) ggURL.replaceAll("pageno=[0-9]*","");
	//搜索结果
	List<Product> list = sr.getProducts(rackcode,pprice,brand,sort,msflag,shopd1,stdv1,stdv2,stdv3,stdv6, isAsc, (currentPage-1)*PAGE_SIZE, PAGE_SIZE);
	//List<Product> list = sr.getProducts(rackcode, sort, isAsc, (currentPage-1)*PAGE_SIZE, PAGE_SIZE);

%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>D1优尚网-商品搜索-时尚网上购物商城,在线销售化妆品、名表、饰品、女装、男装等个人扮靓物品</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/searchnew.css")%>" rel="stylesheet" type="text/css" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/bfd/bfd_style3.css")%>" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/bfd/bfd-banner-1.1.3.min.js")%>" charset="utf-8"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/search2014.css")%>" rel="stylesheet" type="text/css"  />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart2014.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/search.js")%>"></script>

<style type="text/css">
#imgrollys {height: 300px;width: 100%;overflow: hidden;}
#imgrollys #imgslideys{width: 100%;height: 300px;background-color: white;margin: 0 auto;position: relative;}
#imgRollOuterys{position: absolute;top: 0;height: 300px;width: 100%;z-index: 9;left: 0;overflow: hidden;}
#imgRollOuterys div {height: 300px;margin: 0 auto;width: 100%;overflow: hidden;background: url("") no-repeat scroll center center transparent;}
#imgRollOuterys div a {height: 300px;margin: 0 auto;width: 980px;;display: block;z-index: 99;}
#imgrollys #imgslideys p {margin-right: 50%;bottom: 14px;display: block;position: absolute;right: -89px;z-index: 100;}
#imgrollys .left {background: url("http://images.d1.com.cn/images2012/index2012/13january/white-left.png") no-repeat scroll 0 0 transparent;left: -480px;margin-left: 50%;}
#imgrollys .left, #imgrollys .right {width: 50px;height: 50px;position: absolute;top: 45%;cursor: pointer;z-index: 999;display:none;}
#imgrollys .right {background: url("http://images.d1.com.cn/images2012/index2012/13january/white-right.png") no-repeat scroll 0 0 transparent;right: -480px;margin-right: 50%;}
#imgrollys #imgslideys p a {width: 20px;height: 20px;line-height: 20px;_line-height: 20px;margin-left: 10px;background:url('http://images.d1.com.cn/images2012/index2012/des/y-1.png');color: #FFF7F9;text-align: center;display: inline-block;font-family: Arial;font-size: 12px;}
#imgrollys #imgslideys p a.cur{background:url('http://images.d1.com.cn/images2012/index2012/des/y-2.png');font-weight:bold;}

</style>
<script type="text/javascript">
function pad(num, n) {
    var len = num.toString().length;
    while(len < n) {
        num = "0" + num;
        len++;
    }
    return num;
}

function $getid(id)
{
   return document.getElementById(id);
}

//限时抢购
var the_s=new Array();
function view_time(the_s_index,objid){
	 if(the_s[the_s_index]>=0){
        var the_D=Math.floor((the_s[the_s_index]/3600)/24)
        var the_H=Math.floor((the_s[the_s_index]-the_D*24*3600)/3600);
        var the_M=Math.floor((the_s[the_s_index]-the_D*24*3600-the_H*3600)/60);
        var the_S=(the_s[the_s_index]-the_H*3600)%60;
        html = "";
        if(the_D!=0) html += the_D+"天 ";
        if(the_D!=0 || the_H!=0) {html += pad(the_H,2)+"小时"
        	}else if(the_D==0 && the_H==0){html += "00小时"};
        if(the_D!=0 || the_H!=0 || the_M!=0){ html += pad(the_M,2)+"分"}
        else if(the_D==0 && the_H==0 && the_M==0){html += "00分"};
        html += pad(the_S,2)+ "秒";
        $getid(objid).innerHTML = html;
        the_s[the_s_index]--;
    }
}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" style="margin:0px auto;">

<%@include file="inc/head.jsp" %>

<div class="clear"></div>

<div class="listbody resultw">
<div class="clsmenu resultw">
   <div class="cm_l f_l">
   <p style="float:left;"><a href="http://www.d1.com.cn/" target="_blank">首页</a></p>
   </div>
   <div class="cstd_l f_l">
   <%String goppurl=request.getRequestURI()+"?"+pgQueryString;
   String stdurl="";
   if(!Tools.isNull(rackcode)){
		stdurl= goppurl.replaceAll("rackcode=[^&]*","");
		stdurl=urlrepstr(stdurl);
		Directory rckm=(Directory)Tools.getManager(Directory.class).get(rackcode);
		if(rckm!=null){
			String mrckname=rckm.getRakmst_rackname();
		
		%>
		<span><a href="<%=stdurl%>"><%="分类:"+mrckname %><b></b></a></span>
		<%	}
	}
   if(!Tools.isNull(brand)){
		stdurl= goppurl.replaceAll("brand=[^&]*","");
		stdurl=urlrepstr(stdurl);
		Brand brandm=(Brand)Tools.getManager(Brand.class).findByProperty("brand_code", brand);
		if(brandm!=null){
			String mbrandname=brandm.getBrand_name();
		
		%>
		<span><a href="<%=stdurl%>"><%="品牌:"+mbrandname %><b></b></a></span>
		<%	}
	}
   if(!Tools.isNull(stdv1)){
		stdurl= goppurl.replaceAll("stdv1=[^&]*","");
		stdurl=urlrepstr(stdurl);
		%>
		<span><a href="<%=stdurl%>"><%="规格:"+stdv1 %><b></b></a></span>
		<%	
	}
   if(!Tools.isNull(stdv2)){
		stdurl= goppurl.replaceAll("stdv2=[^&]*","");
		stdurl=urlrepstr(stdurl);
		%>
		<span><a href="<%=stdurl%>"><%="规格:"+stdv2 %><b></b></a></span>
		<%	
	}
   if(!Tools.isNull(stdv3)){
		stdurl= goppurl.replaceAll("stdv3=[^&]*","");
		stdurl=urlrepstr(stdurl);
		%>
		<span><a href="<%=stdurl%>"><%="规格:"+stdv3 %><b></b></a></span>
		<%	
	}
   if(!Tools.isNull(stdv6)){
		stdurl= goppurl.replaceAll("stdv6=[^&]*","");
		stdurl=urlrepstr(stdurl);
		%>
		<span><a href="<%=stdurl%>"><%="规格:"+stdv6 %><b></b></a></span>
		<%	
	}
   if(!Tools.isNull(pprice)){
		stdurl= goppurl.replaceAll("pprice=[^&]*","");
		stdurl=urlrepstr(stdurl);
		%>
		<span><a href="<%=stdurl%>"><%="价格:"+pprice %><b></b></a></span>
		<%	
	}
	%>
	</div>
	<div class="cm_l f_l">
   <p style="float:left;">>&nbsp;&nbsp;搜索词：<span style="color:red"><%=keyWords %></span></p>
   </div>
	</div>
 <div>
  <div class="stds m_t10">			
  <%if(Tools.isNull(brand)){
	  HashMap<String,String>  brandMap =(HashMap<String,String>)obj[3];
	  if(brandMap!=null&&brandMap.size()>0){
	%>
	<div class="std-attrs" >
       <div class="stda_h">品牌
       </div>
       <div  class="stda_vt">
          <ul class="stda_v"><%
        		  Iterator it = brandMap.keySet().iterator();  
                  int i=0;
                  int rcknamelen=0;
                 	int rcklen=0;
                  while(it.hasNext()) {  
                	  String key = (String)it.next();  
                	  Brand br=BrandHelper.getBrandByCode(key);
                	  if(br==null)continue;
					//if(i >= 30) break;		
					String brand_name=brandMap.get(key);
					if(brand_name != null) brand_name = brand_name.trim();
					i++;
					String newURL = pgQueryString.replaceAll("brand=[^&]*","");
					newURL=urlrepstr(newURL);
					rcknamelen+= brand_name.length();
		    		rcklen+=1;
					%>

					 <li><a href="<%=request.getRequestURI()%>?<%=newURL %>&brand=<%=key %>" title="<%=brand_name %>" ><%=brand_name %></a></li>
<%
					
			}
		%>
			</ul>
			<%if((rcknamelen*12+rcklen*20)>1600){ %>
           <div class="stdmore" onclick="stdmore(this);" style="display: block;">更多&nbsp;<span style="font-size:10px">∨</span></div>
       <div class="stdmore" onclick="stdless(this);" style="display: none;">收起&nbsp;<span style="font-size:10px">∧</span></div>
      <%} %>
       </div>
         <div class="clear"></div>
</div><%
	  }	
  }
         
         	String hotKeyCode = "000";
         	HashMap<String,String> rckmap = (HashMap<String,String>)obj[4];
		    ArrayList<String> list123 = sr.getNextLevelRackcodes(rackcode) ;//得到下一级搜索分类列表
		    if(list123!=null&&list123.size()>0&&rckmap!=null&&rckmap.size()>0){
		    	for(String s123:list123){
		    		int i = 0;
		    		if(i == 0) hotKeyCode = s123;
		    		i++;
		    		Directory dir = new Directory();
		    		dir=(Directory)Tools.getManager(Directory.class).get(s123);
		    		if(dir==null)continue;
		    		ArrayList<String> listnext = sr.getNextLevelRackcodes(dir.getId()) ;//得到下一级搜索分类列表
		    		if(listnext!=null&&listnext.size()>0){
		    			if(dir.getId().startsWith("014"))continue;
		    			if(!rckmap.containsKey(dir.getId()))continue;
		    			String newURL1 = pgQueryString.replaceAll("rackcode=[^&]*","");
		    %>
		    
	<div class="std-attrs" >
       <div class="stda_h"><a href="<%=request.getRequestURI()%>?<%=newURL1%>&rackcode=<%=dir.getId()%>" target="_blank"><%=dir.getRakmst_rackname() %></a>
       </div>
       <div  class="stda_vt">
          <ul class="stda_v">
           <%
           int rcknamelen=0;
       	int rcklen=0;		
					
						int j = 0;
					    for(String sn:listnext){
					    
					    	if(j == 0) hotKeyCode = sn;
					    	j++;
					    	Directory diritem = new Directory();
	
					    	diritem=(Directory)Tools.getManager(Directory.class).get(sn);
					    	if(diritem!=null){
					    		if(!rckmap.containsKey(diritem.getId()))continue;
	                             if(diritem.getRakmst_showflag()==null||diritem.getRakmst_showflag().longValue()!=1)continue;

					    		rcknamelen+= diritem.getRakmst_rackname().length();
					    		rcklen+=1;
					    		String newURL = pgQueryString.replaceAll("rackcode=[^&]*","");
					%>
					
						<li><a href="<%=request.getRequestURI()%>?<%=newURL%>&rackcode=<%=sn%>" ><%=diritem.getRakmst_rackname() %></a></li>
                    <% }
					    	
					    }
					    
				
                  %>
                 </ul>
       </div>
         <div class="clear"></div>
</div>
              <%
		    		}//end if
		    		}
		    }
		    HashMap<String,String> stdrckMap = new HashMap<String,String>();
		    ArrayList<String> list014 = sr.getNextLevelRackcodes("014") ;//得到下一级搜索分类列表
		    String stdhaves="00000089,00000094";
		    if(list014!=null&&list014.size()>0&&rckmap!=null&&rckmap.size()>0){
		    	for(String s123:list014){
		    		int i = 0;
		    		if(i == 0) hotKeyCode = s123;
		    		i++;
		    		Directory dir = new Directory();
		    		dir=(Directory)Tools.getManager(Directory.class).get(s123);
		    		if(dir==null)continue;
		    		ArrayList<String> listnext = sr.getNextLevelRackcodes(dir.getId()) ;//得到下一级搜索分类列表
		    		if(listnext!=null&&listnext.size()>0){
		    			if(!rckmap.containsKey(dir.getId()))continue;
		    			String newURL1 = pgQueryString.replaceAll("rackcode=[^&]*","");
		    %>
		    
	<div class="std-attrs" >
       <div class="stda_h"><a href="<%=request.getRequestURI()%>?<%=newURL1%>&rackcode=<%=dir.getId()%>" target="_blank"><%=dir.getRakmst_rackname() %></a>
       </div>
       <div  class="stda_vt">
          <ul class="stda_v">
           <%
           int rcknamelen=0;
       	int rcklen=0;		
					
						int j = 0;
						String stdid="";
					    for(String sn:listnext){
					    
					    	if(j == 0) hotKeyCode = sn;
					    	j++;
					    	Directory diritem = new Directory();
	
					    	diritem=(Directory)Tools.getManager(Directory.class).get(sn);
					    	if(diritem!=null){
					    		if(!rckmap.containsKey(diritem.getId()))continue;
					    		if(diritem.getRakmst_showflag()==null||diritem.getRakmst_showflag().longValue()!=1)continue;
	                             stdid=diritem.getRakmst_stdid();
	                             if(!Tools.isNull(stdid)&&stdhaves.indexOf(stdid)>=0){
	                             if(Tools.isNull(stdrckMap.get(stdid))){
	                            	 stdrckMap.put(stdid,sn);
	  	                        }
	                             }
					    		rcknamelen+= diritem.getRakmst_rackname().length();
					    		rcklen+=1;
					    		
					String newURL = pgQueryString.replaceAll("rackcode=[^&]*","");
					%>
					
						<li><a href="<%=request.getRequestURI()%>?<%=newURL%>&rackcode=<%=sn%>" ><%=diritem.getRakmst_rackname() %></a></li>
                    <% }
					    	
					    }
					    
				
                  %>
                 </ul>
       </div>
         <div class="clear"></div>
</div>
              <%
		    		}//end if
		    		}
		    }
		    
		    HashMap<String,String> stdsMap = (HashMap<String,String>)obj[2];
		    if(stdsMap!=null&&stdsMap.size()>0){
		    //String[] arrstd =retstr.split("@");
		   String[] arrstd =stdhaves.split(",");
		   for (int k=0;k<arrstd.length;k++){
			   String stdid=arrstd[k];
			   Map<String,Object> mapstdnitem = new HashMap<String,Object>();
			   Map<String,Object> mapstdnitemdtl = new HashMap<String,Object>();
			   List<ProductStandardHelper.Standard> psListitem = ProductStandardHelper.getGGByRackcode(stdrckMap.get(stdid));
			 	if(psListitem != null && !psListitem.isEmpty()){
			 		for(ProductStandardHelper.Standard ps : psListitem){
			 			mapstdnitem.put(ps.getAtrFlag()+"", ps.getAtrname());
			 			mapstdnitemdtl.put(ps.getAtrFlag()+"", ps.getAtrdtl());
			 		}

			 	}
		  	for(int i=0;i<stdsMap.size();i++){
		  		long atrFlag =i+1;
		  		if(i==3)atrFlag=6;
		  		String stdvalues=stdsMap.get(stdid+"stdv"+atrFlag);
		  		if(Tools.isNull(stdvalues))continue;
		  		if(!Tools.isNull(stdv1)&&i==0)continue;
		  		if(!Tools.isNull(stdv2)&&i==1)continue;
		  		if(!Tools.isNull(stdv3)&&i==2)continue;
		  		if(!Tools.isNull(stdv6)&&i==3)continue;
		  		
		  		if(mapstdnitem.get(atrFlag+"")==null||Tools.isNull(mapstdnitem.get(atrFlag+"").toString()))continue;
		  		
				String stdvalueall=mapstdnitemdtl.get(atrFlag+"")!=null?mapstdnitemdtl.get(atrFlag+"").toString():"";

				
				stdvalues=stdvalues.replace("，", ",").replace(" ", "");
				String[] arrstdvalues=stdvalues.split(",");
				if(arrstdvalues.length==0)continue;
				
		  		//String newURL = ggURL.replaceAll("stdv"+atrFlag+"=[^&]*","");
		  		//stdshow+=1;
		    %>
		      <div class="std-attrs" <%//if (stdshow>5){ out.print("class=\"std-attrs hide\" overfour=\"true\""); }else{ out.print("class=\"std-attrs\"");} %> >
		         <div class="stda_h"><%=mapstdnitem.get(atrFlag+"") %>
		         </div>
		         <div class="stda_vt" id="stda_v<%=i%>">
		            <ul class="stda_v">
		            <%
		           int stdlen=0;
		            String stdkeys=",";
		            for(int j=0;j<arrstdvalues.length;j++){
		          	  stdlen+= arrstdvalues[j].length();
		          	  if(stdkeys.indexOf(","+arrstdvalues[j]+",")==-1){
		          	  stdkeys+=arrstdvalues[j]+",";
		          	  }else{
		          		  continue;
		          	  }
		          	String newURL = pgQueryString.replaceAll("stdv"+atrFlag+"=[^&]*","");
		          	  %>
		               <li><a href="<%=request.getRequestURI()%>?<%=newURL%>&stdv<%=atrFlag %>=<%=URLEncoder.encode(arrstdvalues[j],"UTF-8") %>" rel="nofollow"><%=arrstdvalues[j] %></a></li>
		               <%}
		            %>
		            </ul>
		         </div>
		           <div class="clear"></div>
		      </div>
		      <%
		  		
		  		}
		   }
		    }
		    
		    
		    HashMap<String,String> priceMap = (HashMap<String,String>)obj[1];
		    if(priceMap!=null&&priceMap.size()>0){
		  	  String pricestr=getpricestrmap(priceMap);
		  	  if(pricestr.length()>0){
		  	  pricestr=pricestr.substring(0,pricestr.length()-1)+"以上";
		  	  String[] pricearr=pricestr.split(",");
		  	if(pricearr.length>=3){
		  %>
		    <div class="std-attrs" <%//if (stdshow>5){ out.print("class=\"std-attrs hide\" overfour=\"true\""); }else{ out.print("class=\"std-attrs\"");} %> >
		       <div class="stda_h">价格
		       </div>
		       <div class="stda_vt">
		          <ul class="stda_v">
		          <%
		         int stdlen=0;
		          String stdkeys=",";
		          for(int j=0;j<pricearr.length;j++){
		        	String newURL = pgQueryString.replaceAll("pprice"+pricearr[j]+"=[^&]*","");
		        	  %>
		             <li><a href="<%=request.getRequestURI()%>?<%=newURL%>&pprice=<%=pricearr[j] %>" rel="nofollow"><%=pricearr[j] %></a></li>
		             <%}
		          %>
		          </ul>
		       </div>
		         <div class="clear"></div>
		    </div>
		    <%
		  	}
		  		}
		  }
		  	%>
	</div>	    
        

  <div class="r_list m_t10" id="r_list">
    <div class="rl_sort">
    <dl>
 <dd <%=Tools.isNull(sort)?"class=\"rls_02 cur\"":""%>><a href='<%= goppurl%>' rel="nofollow">综合</a></dd>
      <dd <%//if(sort!=null&&sort.equals("sales")&&isAsc){
    	 // out.print("class=\"rls_02u cur\"");
      //}else 
    	  if(sort!=null&&sort.equals("sales")&&!isAsc){
    	  out.print("class=\"rls_02 cur\"");
      }else{
    	  out.print("class=\"rls_02\"");
      }      
      String newURL = goppurl.replaceAll("sort=[^&]*","");
      newURL = newURL.replaceAll("asc=[^&]*","");
      %> >
    	  <a href='<%=newURL%>&sort=sales&asc=false' rel="nofollow">
                             销量&nbsp;</a></dd>
      <dd <%//if(sort!=null&&sort.equals("createtime")&&isAsc){
    	  //out.print("class=\"rls_02u cur\"");
      //}else 
       if(sort!=null&&sort.equals("createtime")&&!isAsc){
    	  out.print("class=\"rls_02 cur\"");
      }else{
    	  out.print("class=\"rls_02\"");
      }      
      %>><a href='<%=newURL%>' rel="nofollow">新品&nbsp;</a></dd>
      <dd <%if(sort!=null&&sort.equals("price")&&!isAsc){
    	  out.print("class=\"rls_04 cur\"");
      }else if(sort!=null&&sort.equals("price")&&isAsc){
    	  out.print("class=\"rls_05 cur\"");
      }else{
    	  out.print("class=\"rls_03\"");
      }   
      
      %>><a href='<%=newURL%>&sort=price&asc=<%=isAsc?"false":"true" %>' rel="nofollow">价格&nbsp;</a></dd>
    </dl>
      <div class="sort_price">
      <!--  按价格选择：<input name="gprice_s" class="sort_pinput" type="text" value="￥" />--<input name="gprice_e" class="sort_pinput"  type="text" value="￥" />-->
       <input name="gourl" id="gourl"  type="hidden" value="<%=goppurl %>" />
      <input name="msflag" id="msflag" type="checkbox" <%if(!Tools.isNull(msflag)) out.print("checked");%> value="1" onclick="goresult()" />&nbsp;限时特价&nbsp;&nbsp;&nbsp;&nbsp;<input name="shopd1" id="shopd1" type="checkbox" <%if(!Tools.isNull(shopd1)) out.print("checked");%> onclick="goresult()" value="1" />&nbsp;D1自营
       </div>
       <div class="sort_page">
       <span><%=pb.getCurrentPage() %>/<%=pb.getTotalPages() %>&nbsp;&nbsp;</span><span>
       <%if(pb.hasPreviousPage()){%><a href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=<%=pb.getPreviousPage() %>"><img src="http://images.d1.com.cn/images2014/result/pagearrow-left.gif" width="21" height="20" />
       </a><%}%>
       &nbsp;&nbsp;&nbsp;&nbsp;<%if(pb.hasNextPage()){%><a href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=<%=pb.getNextPage() %>"><img src="http://images.d1.com.cn/images2014/result/pagearrow-right.gif" width="21" height="20" /></a><%}%></span> </div>
    </div>
    <ul class="m_t10"><%
int size = sr.getTotalcount(rackcode);
int count=0;
if(size>0){
	 SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	    String	nowtime2= DateFormat.format( new Date());
	    boolean	clsflag=true;
 for(Product goods : list){ 
	
	 count++;
 String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
 String id = goods.getId();
 String shopcode=goods.getGdsmst_shopcode();
 String prackcode=goods.getGdsmst_rackcode();
 long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
 long currentTime = System.currentTimeMillis();
 boolean ismiaoshao=false; 
 boolean issgflag=false; 
 String brandname=goods.getGdsmst_brandname();
 String brandcode=goods.getGdsmst_brand();
 if(!Tools.isNull(brandcode))brandcode=brandcode.trim();
String gname=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname().trim()),0,64) ;
String gtitle="";
if(gname.length()<32){
gtitle=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_title()),0,(32-gname.length())*2) ;
}

		//ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(shopcode);
		//String shopname="";
		//if(shpmst!=null)shopname=shpmst.getShpmst_shopname();
		ismiaoshao=CartHelper.getmsflag(goods);
	//boolean	clsflag=false;
	//if(prackcode!=null&&!prackcode.startsWith("020")&&!prackcode.startsWith("030"))clsflag=true;
	D1ActTb acttb=CartHelper.getShopD1actFlag(shopcode,id);
	long gdsnum=0;
	long buynum=0;
	long gdsnum2=0;
	if(ismiaoshao){
	SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", id);
	  if(sg!=null&&sg.getSggdsdtl_status().longValue()==1){
		   gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
           gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum().longValue();
      	
       	 buynum= sg.getSggdsdtl_vbuynum().longValue()+sg.getSggdsdtl_vusrnum().longValue();

           if (gdsnum<=0||gdsnum2<=0 ||goods.getGdsmst_validflag().longValue()==2){
           	  gdsnum=0;

           }
		  
	     if(sg.getSggdsdtl_maxnum().longValue()>sg.getSggdsdtl_realbuynum().longValue()
			&&sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue()>0){
	    	 issgflag=true ;
	     }
	  }
	}
		%>
<li class="libox" style="<%=clsflag?"height:370px":""%>">
<div class="rl_gds">
 <div class="g_simg">
 <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods)%>" title="<%=gname %>" target="_blank">
 <% 
 if(clsflag){
		out.print("<img src=\""+ProductHelper.getImageTo200(goods)+"\" alt=\""+gname+"\" width=\"200\" height=\"200\" />");
		}else{
			if(!Tools.isNull(getImageTo200250(goods))){
			out.print("<img src=\""+getImageTo200250(goods)+"\"  alt=\""+gname+"\" width=\"200\" height=\"250\" />");	
			}else{
  			out.print("<img src=\""+ProductHelper.getImageTo200(goods)+"\" alt=\""+gname+"\" width=\"200\" height=\"200\" style=\"padding:25px 0px;\" />");
			}
		}
		
		%>
		<%if(acttb!=null){ 
		String acttxt="满"+acttb.getD1acttb_snum1()+"<br>减"+acttb.getD1acttb_enum1();
		%>
		<div class="gsimg_acttxt"><%=acttxt %></div>
		<%} %>
		<%if (issgflag){ 
			 String endtime2= DateFormat.format(goods.getGdsmst_promotionend());
		%>
		<div class="list_bg listsg_show"> </div>
		<div class="list_sg  listsg_show">
		已有<%=buynum %>人购买</br>
		仅剩余<%=gdsnum %>件</br>
		<div class="lsgtm" id="tjjs_<%=count%>">

			     <SCRIPT language="javascript">
               var startDate= new Date("<%=nowtime2%>");
               var endDate= new Date("<%=endtime2%>");
               the_s[<%=count%>]=(endDate.getTime()-startDate.getTime())/1000;
               setInterval("view_time(<%=count%>,'tjjs_<%=count%>')",1000);
               </SCRIPT>
		</div>
		</div>
		<%} %>
</a>
</div>
<div class="g_price">
<span class="g_mprice">￥<font style="font-size:21px;">
<%
if(ismiaoshao){
out.print(Tools.getFormatMoney(goods.getGdsmst_msprice()));
}else{
out.print(Tools.getFormatMoney(goods.getGdsmst_memberprice()));
}
int comnum= CommentHelper.getCommentLength(id);
int numflag=goods.getGdsmst_buylimit().intValue();

%>
</font></span><span class="m_t10">&nbsp;&nbsp;&nbsp;&nbsp;￥<s><%=Tools.getFormatMoney(goods.getGdsmst_saleprice()) %></s>&nbsp;&nbsp;</span>
<%if(ismiaoshao&&!issgflag){ %>
<span class="g_hot">直降</span>  
<%}else if(issgflag){ %>
<span class="g_hot"><img src="http://images.d1.com.cn/images2014/result/list_sg.png"></img></span>  
<%} %>
</div>
<div class="clear"></div>
 <div class="g_title">
<span class="g_name"> 
 <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods)%>" title="<%=gname %>" target="_blank"> <%=gname %>
<%if(!gtitle.equals("null")&&gtitle.length()>0) {%>
<span style="color:#c51520"><%=gtitle %></span>
<%} %>
</a>
</span>
 <span class="<%=comnum>0?"g_com":""%>">
 <%=comnum>0?"<a href=\"http://www.d1.com.cn/product/"+id+"#cmt\" target=\"_blank\">"+comnum+"篇评论</a>":"&nbsp;" %></span>
 </div>
 <%if(clsflag){ %>
    <div class="g_incart" style="text-align:center">
     <span><input name="gdsnum<%=id %>"  id="gdsnum<%=id %>" class="gdsnum" value="1" type="text" /></span>
<span class="g_numbut m_l10"><a href="###" onclick="addnum('<%=id %>','<%=numflag%>')"><img src="http://images.d1.com.cn/images2014/result/amountarrow-up.gif" width="16" height="14" /></a><br />
 <a href="###" onclick="lessnum('<%=id %>','<%=numflag%>')"><img src="http://images.d1.com.cn/images2014/result/amountarrow-down.gif" width="16" height="14" /></a></span><span class="m_l10">
   <a href="###" attr="<%=goods.getId() %>" onclick="addlistCart(this);"><img src="http://images.d1.com.cn/images2014/result/addcart.jpg" width="108" height="26" /></a>
 </div>
 
 <%} %>
 <%if (!Tools.isNull(brandname)&&!brandname.equals("D1推荐")){ %>
 <div class="g_shop">
     <%="<a href=\"http://www.d1.com.cn/result.jsp?productsort="+prackcode.substring(0,3)+"&brand="+brandcode+"\" target=\"_blank\">"+brandname+"</a>" %>
</div><%} %>
</div>
</li>
<%
           } %>
           </ul>
            <div class="clear"></div>
           <%
           if(pb.getTotalPages()>1){
           %>
           <div class="GPager">
           	<span>共<font class="rd"><%=pb.getTotalPages() %></font>页-当前第<font class="rd"><%=pb.getCurrentPage() %></font>页</span>
           	<%if(pb.getCurrentPage()>1){ %><a href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=1">首页</a><%}%><%if(pb.hasPreviousPage()){%><a href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=<%=pb.getPreviousPage() %>">上一页</a><%}%><%
           	for(int i=pb.getStartPage();i<=pb.getEndPage()&&i<=pb.getTotalPages();i++){
           		if(i==currentPage){
           		%><span class="curr"><%=i %></span><%
           		}else{
 
           		%><a href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=<%=i%>"><%=i %></a><%
           		}
           	}%>
           	<%if(pb.hasNextPage()){%><a href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=<%=pb.getNextPage() %>">下一页</a><%}%>
           	<%if(pb.getCurrentPage()<pb.getTotalPages()){%><a href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=<%=pb.getTotalPages() %>">尾页</a><%} %>
           </div><%}
           %>
           
           <%
}else{
	   %><div style="color:red;text-align:center;">没有满足条件的搜索结果！！！</div><%
} %>     
     
        	 
  </div>

 <div class="clear"></div>
<%@include file="inc/foot.jsp"%>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script  type="text/javascript">
$(function(){
		//当鼠标滑入时将div的class换成divOver
		$('.libox').hover(function(){
				$(this).css('border', 'solid 1px #c51520');
				$(this).addClass("cur")
			},function(){
            $(this).css('border',  'solid 1px #fff');	
            $(this).removeClass("cur")
			}
		);
		});
		
function addlistCart(obj){
	    var counts=$("#gdsnum"+$(obj).attr("attr")).val();
	    $.inCart(obj,{ajaxUrl:'/ajax/flow/listInCart.jsp',width:400,align:'center',gdscount:counts});

}
function goresult(){
    var gourl=$("#gourl").val();
    var msflag='';
    $("input[name='msflag']:checkbox").each(function(){
 	   if($(this).attr("checked")){
 		  msflag += $(this).val()	  
 	   }
    });
    
    var shopd1='';
    $("input[name='shopd1']:checkbox").each(function(){
 	   if($(this).attr("checked")){
 		  shopd1 += $(this).val()		  
 	   }
    });
    if(msflag!=""){
    	gourl=gourl+"&msflag="+msflag;
    }else{
    	//gourl=gourl.replace("msflag=[^&]*","");
    	gourl=gourl.replace(/msflag=(.+?)$/,"");
    }
    if(shopd1!=""){
    	gourl=gourl+"&shopd1="+shopd1;
    }else{
    	gourl=gourl.replace(/shopd1=(.+?)$/,"");
    }
    
     window.location.href = gourl;

   }	
function addnum(id, flag)
{

    if (flag == 1) {
        $.alert('该商品只能买一件！！！');
        return;
    }
    var new_val = Number($("#gdsnum"+id).val());
    $("#gdsnum"+id).val(new_val+1);
}

function lessnum(id, flag)
{
    var new_val = Number($("#gdsnum"+id).val());
    if(new_val>1){
    	 $("#gdsnum"+id).val(new_val-1);
    }
}
function stdmore(t){
    $(t).hide().next().show();
   // $(t).parent().css('height', 'auto');
	 $(t).parent().addClass("hg_auto");
}
function stdless(t){
    $(t).hide().prev().show();
	// $(t).parent().css('height', '32px');
	  $(t).parent().removeClass("hg_auto");

}
function morestd(t){
            $(t).hide();
            $('#lessstd').show();
            $('[overFour]').show();

        }

function lessstd(t){
            $(t).hide();
            $('#morestd').show();
            $('[overFour]').hide();
        }

</script>
<script type="text/javascript">
$(document).ready(function() {
	 //导航栏浮动
	var m=$(".search_sSort").offset().top;  
	$(window).bind("scroll",function(){
    var i=$(document).scrollTop(),
    g=$(".search_sSort");
	if(i>=m)
	{
		 g.addClass('newbanner1120');
	}
    else{g.removeClass('newbanner1120');}
	});
    //$(".newlist").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
});

</script>
</body>
</html>