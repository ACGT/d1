<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%!

/**
 * 获得服装图 200x250
 * @param product - 商品对象
 * @return String
 */
public static String getImageTo200250(Product product){
	String img = (product != null ? product.getGdsmst_img200250() : null);
	if(!Tools.isNull(img)) img = "http://images.d1.com.cn/"+img.trim().replace("\\","/");
	
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
//根据商品编号获取搭配（如果商品编号为空，获取全部搭配）
private static ArrayList<Gdscoll>  getGdscollByGdsid(String gdsid)
{
	  boolean flag=false;
	  ArrayList<Gdscoll> result=new ArrayList<Gdscoll>();
	  ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
	
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		//clist.add(Restrictions.ge("gdscoll_cate",new Long(3)));
		clist.add(Restrictions.eq("gdscoll_flag",new Long(1)));
		
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gdscoll_sort"));
		olist.add(Order.desc("gdscoll_createdate"));
		List<BaseEntity> blist=Tools.getManager(Gdscoll.class).getList(clist, olist, 0, 10000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscoll)b);
				}
			}
		}
		
		if(list!=null&&list.size()>0)
		{
			if(gdsid.length()==0)
			{
				result=list;
			}
			else
			{
				for(Gdscoll gdscoll:list)
				{
					if(gdscoll!=null)
					{
						ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid1(gdscoll.getId());
						if(gdlist!=null)
						{
							for(Gdscolldetail gd:gdlist)
							{
								if(gd.getGdscolldetail_gdsid().equals(gdsid))
								{
									flag=true;
								}
							}
						}
						if(flag)
						{
							result.add(gdscoll);
						}
						flag=false;
					}
					
				}
				return result;
			}
		}
		return result;
}


private static String getXGSS(String id)
{
	StringBuilder result=new StringBuilder();
	if(!Tools.isMath(id)){ return "";}
	Tag t=(Tag)Tools.getManager(Tag.class).get(id);
	ArrayList<Tag> list=TagHelper.getTags();
	if(t!=null)
	{
		String str=t.getTag_tag();
		if(str.length()>0)
		{
			String newtag=str.replace('，', ',');
			String[] newstr=newtag.split(",");
	        for(int i=0;i<newstr.length;i++)
	        {
	        	
	        	if(list!=null&&list.size()>0)
	        	{
	        		for(Tag tt:list)
	        		{
	        			if(tt!=null&&tt.getTag_key().length()>0)
	        			{
	        				if(tt.getTag_key().indexOf(newstr[i])>=0)
	        				{
	        					result.append(tt.getTag_key()+",");
	        				}
	        			}
	        		}
	        	}
	        }
		}
	}
   	return result.toString();
}

private static ArrayList<Tag> getXGSS1(String id)
{
	ArrayList<Tag> result=new ArrayList<Tag>();
	if(!Tools.isMath(id)){ return null;}
	Tag t=(Tag)Tools.getManager(Tag.class).get(id);
	ArrayList<Tag> list=TagHelper.getTags();
	if(t!=null)
	{
		String str=t.getTag_tag();
		if(str.length()>0)
		{
			String newtag=str.replace('，', ',');
			String[] newstr=newtag.split(",");
	        for(int i=0;i<newstr.length;i++)
	        {
	        	
	        	if(list!=null&&list.size()>0)
	        	{
	        		for(Tag tt:list)
	        		{
	        			if(tt!=null&&tt.getTag_key().length()>0)
	        			{
	        				if(tt.getTag_key().indexOf(newstr[i])>=0)
	        				{
	        					result.add(tt);
	        					//System.out.print(tt.getTag_key());
	        				}
	        			}
	        		}
	        	}
	        }
		}
	}
   	return result;
}

//获取跳转链接
private static String getrecurl(String code){
	String rurl="";
	ArrayList<Promotion> rlist = new ArrayList<Promotion>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("splmst_code",new Long(3402)));
	clist.add(Restrictions.eq("splmst_name",code));
	List<BaseEntity> list = Tools.getManager(Promotion.class).getList(clist, null, 0, 1);
	if(list!=null){
		for(BaseEntity be:list){
			Promotion pp = (Promotion)be;
			rurl=pp.getSplmst_url();
		}
	}

return rurl;

}
%><%

     String ids="";
     if(request.getParameter("headsearchkey")!=null&&request.getParameter("headsearchkey").length()>0)
     {
    	 ids=request.getParameter("headsearchkey");
     }
    //一共有几个参数key_wds=搜索词,sort=排序字段,rackcode=分类,pg=当前页,headsearchkey=头部搜索词,asc=升降序
	String keyWords = request.getParameter("key_wds"),rackcode=request.getParameter("rackcode"),
		sort = request.getParameter("sort"),pg = request.getParameter("pg"),asc = request.getParameter("asc");
  // if(keyWords!=null&&keyWords.indexOf("施华洛")>=0){
	//   keyWords="";
  // }
  if(!Tools.isNumber(ids)&&(keyWords==null||keyWords.length()<=0)){ return;}
	boolean isAsc = ("true".equals(asc)?true:false) ;
	
	String isAscStr = "";
	if(isAsc)isAscStr="true";
	else isAscStr="false";
	String gourl=getrecurl(ids);
	if (!Tools.isNull(gourl)){
		response.sendRedirect(gourl);
	 return;
	}

			//获取频道
	Tag tag=(Tag)Tools.getManager(Tag.class).get(ids);
	String sk="";
			if(tag!=null)
			{
				sk=tag.getTag_key().trim();
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
	
	final int PAGE_SIZE = 21 ;//每页多少个
	int currentPage = 1 ;//当前页
	
	if(StringUtils.isDigits(pg)){
		currentPage = new Integer(pg).intValue();
	}
	
	PageBean pb = new PageBean(sr.getTotalcount(rackcode),PAGE_SIZE,currentPage);//翻页的PageBean
		
	StringBuffer sb = new StringBuffer();
	sb.append("key_wds="+Base64.encode(keyWords)).append("&");
	
	if(!Tools.isNull(rackcode)){
		sb.append("rackcode="+rackcode+"&");
	}
	
	if(!Tools.isNull(sort)){
		sb.append("sort="+sort+"&");
	}
	
	if(!Tools.isNull(asc)){
		sb.append("asc="+asc+"&");
	}
	
	String pgQueryString = sb.toString();
	//搜索结果
	List<Product> list = sr.getProducts(rackcode, sort, isAsc, (currentPage-1)*PAGE_SIZE, PAGE_SIZE);
	//标签
	//String keyname="111111";
	
		//keyname=request.getParameter("keyname");
	Tag t=new Tag();
	t=TagHelper.getTagsByKey(keyWords);
	//System.out.print(keyname);
	String str="";
	if(t!=null&&t.getTag_tag()!=null&&t.getTag_tag().length()>0)
	{
		str=t.getTag_tag();
	}
	//System.out.print(keyWords);
	String titles=t!=null&&t.getTag_title()!=null&&t.getTag_title().length()>0?t.getTag_title():"【正品行货】"+keyWords+"_"+keyWords+"价格_图片 - D1优尚网";
	String des=t!=null&&t.getTag_description()!=null&&t.getTag_description().length()>0?t.getTag_description():"D1优尚网"+keyWords+"频道，提供最新款"+keyWords+"品牌、"+keyWords+"价格、"+keyWords+"图片以及"+keyWords+"搭配图。想通过网上购物买到名牌"+keyWords+"，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" ;
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title><%= titles %></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="description" content="<%= des%>"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/search.css")%>" rel="stylesheet" type="text/css" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/bfd/bfd_style3.css")%>" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/bfd/bfd-banner-1.1.3.min.js")%>" charset="utf-8"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">
  .search_right_top {width:770px;margin-left:5px;background:url(http://images.d1.com.cn/images2012/tag_s_top.jpg);text-align:left; margin-top:3px; _margin-top:2px;overflow:hidden;_zoom:1; height:28px; border-top:solid 2px #e4df81;
  font-size:14px;line-height:28px; margin-bottom:10px;}
  .search_right_top span{ color:#ba3d1d; font-size:14px; line-height:28px;}
  .xgss{width:760px;margin-left:5px;text-align:left;overflow:hidden;_zoom:1; height:25px; font-size:13px; color:#fcfcfc;margin-bottom:10px; }
  .xgss a{ color:#f3f7f6; margin-left:3px; margin-right:3px; line-height:25px;}
  .xgss a:hover{ color:#f3f7f6; margin-left:3px; margin-right:3px; line-height:25px;}
  h1{ color:#ba3d1d; font-size:14px; line-height:28px; float:left; }
  .search_right_top .hs{ color:#333; float:left; display:block; font-size:14px; line-height:28px;}
  .search_right_top .ss{ color:#ba3d1d; float:left; display:block; font-size:14px; line-height:28px;}
  .rxph{ height:auto; color:#000;}
  .rxph p{text-indent: 2em;}
  .gs_left_content{text-align: center; position: relative;padding-left: 7px;padding-bottom: 10px;}
  .gs_left_content_sub {width: 190px;padding: 10px 0;overflow: hidden;_zoom: 1;}

  .gs_left_content_sub div {float: left;padding-left: 8px;line-height: 18px;width: 112px;padding-right: 8px;text-align: left;padding-top: 2px;}
   hr {width: 95%;color: #DFDFDF;border: dashed 1px #DFDFDF;}

  .gs_left_content_r .span1 {width:auto;  height:23px; line-height:23px; display:block; padding-top:2px;color: #B50126;font-family: "微软雅黑";margin-right: 7px;font-weight: bold; float:left;}
  .gs_left_content_r .span2 { width:auto; height:23px; line-height:23px; display:block;color: #999;padding-top:4px;+padding-top:6px;stext-decoration: line-through;}
  .main{ width:auto; margin:0px auto;}
  .newlist {width:770px; margin:0px auto; background-color:#f0f0f0; padding-bottom:10px;  }
.newlist ul {padding:0 0 0px; padding-left:30px;  padding-top:15px; padding-bottom:15px;}
.newlist li {float:left; margin-right:34px; width:210px;  margin-bottom:20px; overflow:hidden;   }
.newlist p {text-align:left; }
.newlist p strong {font-weight:bold; font-size:15px; color:#a63c4f;margin-right:10px;}
.newlist .retime {background:rgba(0,0,0,0.5);font-size:12px;text-align:left;line-height:16px;overflow:hidden; bottom:0px; margin-top:-41px; position:relative; width:200px; padding-top:3px; padding-bottom:2px;
*background:transparent;filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#b3000000,endColorstr=#b3000000); z-index:1111; height:36px; display:none;  }
.retime a{text-decoration:none; }
.lf{ padding:5px; background-color:#fff; overflow:hidden; }
.newlist p .newspan{ display:block; width:120px; height:35px; margin-top:5px; text-align:center; line-height:35px; border-right:solid 1px #f3f3f3; float:left;}
.newlist p .newspan1{ display:block; width:79px; height:35px; margin-top:5px; text-align:center; line-height:35px; color:#333;float:left;}
.lb{background-color:#f7f7f7;  padding:5px;  width:200px; height:42px; line-height:20px; font-size:12px;color:#7b7b7b; overflow:hidden;
 text-align:left; vertical-align:middle; padding-top:8px;}
.newlist .lf .di{position:absolute;z-index:999;width:79px;height:79px;border:none; +margin-left:-100px;}
  .floatdp{ position:absolute; z-index:22222; background:#fff; width:278px; overflow:hidden;margin-top:-430px; margin-left:-265px; +margin-left:-365px;
}
.floatdp1{ position:absolute; z-index:22222; background:url('http://images.d1.com.cn/images2012/index2012/xsj1.png') no-repeat;
          background-position:right 250px; width:278px; overflow:hidden;margin-top:-430px; margin-left:-265px;+margin-left:-365px;
}
.dpdisplay{ width:246px;}
.dpdisplay ul { list-decoration:none; margin:0px; padding:0px; }
.dpdisplay ul li{  float:left; background:url('http://images.d1.com.cn/images2012/aleeishe/images/0031.jpg') no-repeat; margin:0px; padding:0px; position:none; width:246px;}
.pj{background:#ccc; padding:5px;padding-top:0px; padding-left:6px; padding-bottom:2px;overflow:hidden;}
.pj div{ float:left; width:75px; overflow:hidden;  margin-right:3px; margin-bottom:3px;font-size:12px; color:#aa2e44; font-family:'微软雅黑';}
.pj div a{display:block }
.pj div div{display:block; width:75px; height:20px; background:#e7e8ea; line-height:20px; margin-top:2px; text-align:center;}

.allb {width:246; overflow:hidden; position:relative; margin:0px; padding:0px; background:#808080;}
.allimglist{ overflow:hidden;}
.allimglist img {border:0px;}
.allb ul {position:absolute; display:block; list-style-type:none;z-index:10000;margin:0; padding:0; top:330px; right:10px; width:auto;}
.allb ul li { padding:0px 3px;float:left;display:block; margin:0px;background:url('http://images.d1.com.cn/images2012/index2012/c2.png') no-repeat;cursor:pointer; height:14px; width:14px; }
.allb ul li.on { background:url('http://images.d1.com.cn/images2012/index2012/c1.png') no-repeat; margin:0px; }

.allimglist span{ width:246px; display:block;}
.allimglist ul li{ float:left;}
.dpprice{ position:absolute; z-index:33333; width:155px; overflow:hidden;margin-left:-10px; +margin-left:-110px;margin-top:-150px; background:#cccccc; border:solid 8px #808080; text-align:center; padding-bottom:15px; display:none;}

.next{position:absolute; right:0px; top:310px; curson:hand;}
.pre{position:absolute; left:0px; top:310px; curson:hand;}
  
</style>
<script type="text/javascript">
function scrollresult(imglistobj,cicleobj,flag)
{
    var t = n = 0; 
    var count=$(imglistobj+" span").length;
	$(imglistobj+" span:not(:first-child)").hide();
	$("#pre2012"+flag).click(function(){
		var gdsid=$("#pre2012"+flag).attr('attr');
		var obj=$(imglistobj+" span").filter(":visible").attr("attr");
		if(obj-1<=0) obj=count+1;
		obj=obj-1;
		$(imglistobj+" span").filter(":visible").hide().parent().children().eq(obj-1).fadeIn(500);
		$("#commensapn"+flag).css("display","block");
		selectdp(obj,gdsid,flag);
	});
	$("#next2012"+flag).click(function(){
		var gdsid=$("#next2012"+flag).attr('attr');
		var obj=$(imglistobj+" span").filter(":visible").attr("attr");
		if(obj>=count) obj=0;
		obj=obj-1;
		$(imglistobj+" span").filter(":visible").hide().parent().children().eq(obj+1).fadeIn(500);
		$("#commensapn"+flag).css("display","block");
		selectdp(obj+2,gdsid,flag);
	});
	}

function mdmover(gdsid,flag)
{
	var obj=$("#floatdp"+gdsid+flag);
	obj.css("display","block");
	$("#price"+gdsid+flag).css("display","block");
	}


 function mdm_out(gdsid,flag)
{
	 $("#floatdp"+gdsid+flag).css("display","none");
	 $("#price"+gdsid+flag).css("display","none");
	
}

function getFloatdp(gdsid,count)
{
	var obj=$("#floatdp"+gdsid+count);
	if(obj!=null)
	{
		    $(obj).addClass("floatdp");//css("background","#fff");
			$(obj).html("<img src='http://images.d1.com.cn/images2012/New/Loading.gif' style=\"margin-left:120px; margin-top:120px; margin-bottom:120px; \"/>");
			$.post("/html/resulth1.jsp",{"gdsid":gdsid,"count":count},function(data){
				$(obj).html(data);
				$(obj).removeClass("floatdp");
				$(obj).addClass("floatdp1");
				selectdp(1,gdsid,count);
			});
	
    }
}
function selectdp(flags,gdsid,flag) {	
	var len=$(".floatdp1").find("input[type='checkbox'][name='chk_"+gdsid+"_"+flag+"_"+flags+"']:checked").length;
    $("#count_"+gdsid+"_"+flag).html(len);
	var money=0;
	var tmoney=0;
	var zk=0.95;
	$(".floatdp1").find("input[type='checkbox'][name='chk_"+gdsid+"_"+flag+"_"+flags+"']:checked").each(function(){
			money+=parseInt($(this).attr('m')*zk);
			tmoney+=parseInt($(this).attr('m'));
	});

	$("#money_"+gdsid+"_"+flag).html(money+".0");
	$("#totalmoney_"+gdsid+"_"+flag).html(tmoney+".0");
	$("#cheap_"+gdsid+"_"+flag).html((tmoney-money)+".0");
	
}
function mdm_over(gdsid,flag)
{
	var obj=$("#floatdp"+gdsid+flag);
	if(obj!=null)
		{
		   getFloatdp(gdsid,flag);
		   obj.css("display","block");
		   $("#price"+gdsid+flag).css("display","block");
		}
    
}
function AddInCart(obj){
	var flag=$(obj).attr("flag");
	var gdsid=$(obj).attr("id");
	$("#floatdp"+gdsid+flag).css("display","block");
	$("#price"+gdsid+flag).css("display","block");
	var flags=$('#banner_list'+flag+" span").filter(":visible").attr("attr");
	var code=$('#banner_list'+flag+" span").filter(":visible").attr("code");
	var list=$(".floatdp1").find("input[type='checkbox'][name='chk_"+gdsid+"_"+flag+"_"+flags+"']:checked");
	
	if(list.length<2){
		$.alert('对不起，请至少选择两个商品！');
		return;
	}

	var arr = new Array();
    list.each(function(i){
		arr[i] = $(this).attr('attr');
	});
    $(obj).attr('attr',arr.toString());
    $(obj).attr('code',code);
    $.inCart(obj,{ajaxUrl:'/ajax/flow/gdscollInCart2.jsp',width:600,align:'center'},{"code":$(obj).attr("code")});
}

</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" style="margin:0px auto;">

<%@include file="/inc/head.jsp" %>
<div class="Middle">
<div style="width:980px; text-align:center;">
    <div id="Left" style="width:203px; vertical-align:top;float:left;">
         <div class='search_sClass'>
         <%
         	String hotKeyCode = "000";
		    ArrayList<String> list123 = sr.getNextLevelRackcodes(rackcode) ;//得到下一级搜索分类列表
		    if(list123!=null&&list123.size()>0){
		    
              
					if(list123!=null){
						int i = 0;
					    for(String s123:list123){
					    	if(i == 0) hotKeyCode = s123;
					    	i++;
					    	
					}}//end if
                  %>
                
              <%}
		 List<Promotion> hotMale = PromotionHelper.getBrandListByCode(getTJNumber(hotKeyCode),5);
		 if(hotMale != null && !hotMale.isEmpty()&&(t==null||t.getTag_description()==null||t.getTag_description().length()==0)){
		 %>
         <!--热销排行-->
         <div class="rxph">
             <div class="ltitle">热销排行榜</div><%
             for(Promotion codeTop : hotMale){
             %>
             <a href="<%=StringUtils.encodeUrl(codeTop.getSplmst_url()) %>" target="_blank" rel="nofollow"><img src="<%=codeTop.getSplmst_picstr() %>" class="hotimg" /></a><%
             } %>
         </div><%
		 }
		 else
		 {%>
			 <div class="rxph">
             <div class="ltitle"><%= keyWords %></div><%
            		 out.print(t.getTag_description().trim());
             %>
         </div> 
		 <%}%>
        <!--浏览历史-->
         <div class="search_history">
         	<div class="ltitle">您最近浏览的商品</div>
         	<div class="clear"></div>
         	<%
				    		 List<Product> productList = ProductHelper.getHistoryList(request);
					 if(productList != null && !productList.isEmpty()){
						 int size = productList.size();
					 %>
					 <div class="gs_left_content"><%
					 for(Product goods : productList){
						 if(!ProductHelper.isNormal(goods)) continue;
						 String title = Tools.clearHTML(goods.getGdsmst_gdsname());
					 %>
			             <div class="gs_left_content_sub">
							 <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><img src="<%=ProductHelper.getImageTo80(goods) %>" alt="<%=title %>" align="middle" width="60" height="60" /></a>
							 <div class="gs_left_content_r">
							 	<a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><%=title %></a><br/>
							 	<span class="span1">￥<%=goods.getGdsmst_memberprice() %></span><span class="span2">￥<%=goods.getGdsmst_saleprice() %></span>
							 </div>
				         </div>
						 <hr/><%
						} %>
						 <div style=" height:25px;"></div>
					 </div><%
				 	} %>
         </div>
         
         
     </div>
   </div>
        

    <div id="Right" style="width:770px; overflow:hidden; vertical-align:top; float:left; margin-left:4px;">
           <%
         
                if(keyWords.contains("AF")||keyWords.contains("af")||keyWords.contains("POLO")||keyWords.contains("polo")||keyWords.contains("Hollister")||keyWords.contains("霍利斯特")||keyWords.contains("拉夫劳伦")||keyWords.contains("美国鹰")||keyWords.contains("AE")||keyWords.contains("tommy")
                		||keyWords.contains("南加州")||keyWords.contains("西部")||keyWords.indexOf("牛仔")>=0||keyWords.contains("马球")||keyWords.contains("户外")||keyWords.contains("学院")||keyWords.contains("常春藤")||keyWords.contains("怀旧")||keyWords.contains("洗水")||keyWords.contains("复古"))
                {%>
                	<a href="http://feelmind.d1.com.cn/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/oct/hhhhh.jpg" width="765" height="964"/></a>
                <%}
                 if(keyWords.contains("歌莉娅")||keyWords.contains("阿依莲")||keyWords.contains("E∙LAND")||keyWords.contains("衣恋")||keyWords.contains("衣本色")||keyWords.contains("ebase")||keyWords.contains("迪斯尼")||keyWords.contains("a02")
            		||keyWords.contains("环球")||keyWords.contains("粉嫩")||keyWords.contains("童话")||keyWords.contains("森女")||keyWords.contains("甜美")||keyWords.contains("淑女"))
                 {%>
            	<a href="http://aleeishe.d1.com.cn/" target="_blank"><img src=""/></a>
                <%}
                 if(keyWords.contains("VERO MODA")||keyWords.contains("ONLY")||keyWords.contains("AZONA")||keyWords.contains("DIESEL")||keyWords.contains("阿桑娜")||keyWords.contains("OL通勤")||keyWords.contains("波西米亚")||keyWords.contains("端庄秀美")
                 		||keyWords.contains("北欧")||keyWords.contains("韩国"))
                      {%>
                 	<a href="http://sheromo.d1.com.cn/" target="_blank"><img src=""/></a>
                     <%}
            %>
        <div class="search_right_top">
        <%
            if(sr.getTotalcount(rackcode)>0)
            {
        %>
            <span><b><span class="ss">&nbsp;&nbsp;"</span><h1><%= keyWords %></h1><span class="ss">"搜索结果（<%=sr.getTotalcount(rackcode)%>）</span></b></span>
         <%
            }
            else
            {%>
            	<b><span class="hs">&nbsp;&nbsp;抱歉，没有找到与"</span><h1><%= keyWords %></h1><sapn class="hs">"相关的商品</sapn></b>
            <%}
         %>   
          
        </div>
    
       

            <div class="clear"></div>
            <%
                if(sr.getTotalcount(rackcode)>6)
                {
            
            %>
        <div class="search_sSort">
            <span class="show">&nbsp;&nbsp;
            	<img src="http://images.d1.com.cn/images2010/listtype1.gif" width="17" height="17" align="texttop" />显示方式&nbsp;&nbsp;
         		<a href="<%=request.getRequestURI()%>?key_wds=<%=Base64.encode(keyWords)%>&sort=createtime&asc=false&<%if(!Tools.isNull(rackcode))out.print("rackcode="+rackcode);%>" rel="nofollow"><img src='http://images.d1.com.cn/images2010/listtype3.gif' align="texttop" />最新上架</a>
            	<a href="<%=request.getRequestURI()%>?key_wds=<%=Base64.encode(keyWords)%>&sort=sales&asc=false&<%if(!Tools.isNull(rackcode))out.print("rackcode="+rackcode);%>" rel="nofollow"><img src='http://images.d1.com.cn/images2010/listtype2.gif' align="texttop" />热销排行</a>
                <a href="<%=request.getRequestURI()%>?key_wds=<%=Base64.encode(keyWords)%>&sort=price&asc=false&<%if(!Tools.isNull(rackcode))out.print("rackcode="+rackcode);%>" rel="nofollow"><img src='http://images.d1.com.cn/images2010/listtype5.gif' align="texttop" />价格</a>
                <a href="<%=request.getRequestURI()%>?key_wds=<%=Base64.encode(keyWords)%>&sort=price&asc=true&<%if(!Tools.isNull(rackcode))out.print("rackcode="+rackcode);%>" rel="nofollow"><img src='http://images.d1.com.cn/images2010/listtype4.gif' align="texttop" />价格</a>
            </span>
            <span class="count">共有<font style="color:#F85F00; font-weight:bold;"><%=sr.getTotalcount(rackcode)%></font>个产品&nbsp;&nbsp;&nbsp;&nbsp;
            <%
              	if(pb.hasPreviousPage()){
              %>
              <a href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=<%=pb.getPreviousPage() %>" class="pag1">上一页</a> &nbsp;
				<%}if(pb.hasNextPage()){%>
		          <a href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=<%=pb.getNextPage() %>" class="pag1">下一页</a> &nbsp; 
				<%} %>
            </span>
        </div>
       <%} %>
<%
int size = sr.getTotalcount(rackcode);
int count=0;
if(size>0){
	%>
	       
       <div class="newlist">
       <table><tr><td>
<ul>
	<%for(Product goods:list){
		count++;
 	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
 	   String id = goods.getId();
 	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
 	   long currentTime = System.currentTimeMillis();
        	%>
        	<%
        	if(goods.getGdsmst_rackcode().length()>=6&&(goods.getGdsmst_rackcode().substring(0,3).equals("020")||goods.getGdsmst_rackcode().substring(0,3).equals("030")))
				{
        		   out.print("<li style=\"height:400px;\">");
				}
        	else
        	{
        		out.print("<li style=\"height:400px;\">");
        	}
        	%>
         
    		<div class="lf">
           				<% 
           				if(goods.getGdsmst_rackcode().length()>=6&&(goods.getGdsmst_rackcode().substring(0,3).equals("020")||goods.getGdsmst_rackcode().substring(0,3).equals("030")))
           					{
           					%>
           					   <p style="z-index:999;"><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" target="_blank" >
           				
           							<img src="<%= getImageTo200250(goods) %>" width="200" height="250" />
           	           
           				<%	}
           				    else
           				    {%>
           				    <p style="z-index:999; padding-top:25px; padding-bottom:25px;"><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" target="_blank" >
           				
           				    	<img src="<%= ProductHelper.getImageTo200(goods) %>" width="200" height="200" />
           	           
           				    <%}%>
           				</a>
           						<%  //每个商品对应的搭配列表
                              ArrayList<Gdscoll> gdscolllist=getGdscollByGdsid(goods.getId()); 
           				      if(gdscolllist!=null&&gdscolllist.size()>0)
           				      {%>
           				    	  <div style="position:absolute; margin-top:-46px; +margin-top:-25px;+margin-left:-100px; " onmouseover="mdm_over('<%= goods.getId() %>','<%= count%>')" onmouseout="mdm_out('<%= goods.getId() %>','<%= count%>')"><img src="http://images.d1.com.cn/images2012/index2012/da1.png"/></div>
			   
           				      <%}             %>   
           				      </p>
           				 
                         <p style="height:35px; font-size:13px; color:#999999; ">
			               <span class="newspan">
			               <% if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){%>
			                   <font color="#b80024" style=" font-family:'微软雅黑'"><b>特价:￥<%=Tools.getFormatMoney(goods.getGdsmst_memberprice()) %></b></font>&nbsp;&nbsp;
			                   <font style="text-decoration:line-through;">￥<%=Tools.getFormatMoney(goods.getGdsmst_oldmemberprice()) %></font>
			                   
			               <%}else
			                {%>
			                 <font color="#b80024" style=" font-family:'微软雅黑'"><b>￥<%=Tools.getFormatMoney(goods.getGdsmst_memberprice()) %></b></font>&nbsp;&nbsp;
			                  <%} %>
			                 </span>
			               
			               <span class="newspan1"><a href="http://www.d1.com.cn/product/<%= goods.getId() %>#cmt2" target="_blank">评论(<%= CommentHelper.getCommentLength(id) %>)</a></span>
			           </p>
             </div>
             <p style="height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;" ><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" target="_blank" style="font-size:12px; color:#606060; "><%=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname()),0,54)%></a></p>
                     
              <div class="clear"></div>
              <%
                Comment com=null;
                List<Comment> clist= CommentHelper.getCommentList(id,0,1000);
                if(list!=null&&clist.size()>0)
                {
                	for(Comment c:clist)
                	{
                		if(c.getGdscom_level().longValue()==5)
                		{
                			com=c;
                			break;
                		}
                		else
                		{
                			continue;
                		}
                	}
                	if(com==null)
                	{
                		for(Comment c:clist)
                    	{
                    		if(c.getGdscom_level().longValue()==4)
                    		{
                    			com=c;
                    			break;
                    		}
                    		else
                    		{
                    			continue;
                    		}
                    	}
                		if(com==null)
                		{
                			for(Comment c:clist)
                        	{
                        		if(c.getGdscom_level().longValue()==3)
                        		{
                        			com=c;
                        			break;
                        		}
                        		else
                        		{
                        			continue;
                        		}
                        	}
                		}
                	}
                }
              %>
              <%
                  if(com!=null)
                  {%>
                	  <div class="lb" title="<%= com.getGdscom_content() %>"><b><%= CommentHelper.GetCommentUid(com.getGdscom_uid())+"：" %></b><%= StringUtils.getCnSubstring(com.getGdscom_content(),0,45) %></div>
                  <% 
                  }
                  else
                  {%>
                	<div class="lb" ><b>暂无评论！！！</b></div>  
                  <%}
              %>
               <%
                  //获取搭配浮层
                  
                  if(gdscolllist!=null&&gdscolllist.size()>0)
                  {%>

                	  <div class="floatdp" id="floatdp<%=goods.getId() %><%= count %>" onmouseover="mdmover('<%=goods.getId() %>','<%= count %>')" onmouseout="mdm_out('<%=goods.getId() %>','<%= count%>')">

                      </div>
                       <div id="price<%=goods.getId() %><%= count%>" class="dpprice" onmouseover="mdmover('<%=goods.getId() %>','<%= count %>')" onmouseout="mdm_out('<%=goods.getId() %>','<%= count%>')">
                          <table width="100%">
                           <tr>
                            <td>   
                            <br/>
			                        <font style="text-align:left; font-size:12px; color:#ca0000;display:block; font-weight:bold; margin:0px auto;">&nbsp;说明：<br/>&nbsp;&nbsp;&nbsp;&nbsp;两件或两件以上95折 <br/>&nbsp;&nbsp;&nbsp;&nbsp;请在左侧选择搭配单品。</font>
			                        <br/><font style="color:#333; font-size:14px; font-weight:bold;">共&nbsp;<em id="count_<%=goods.getId() %>_<%=count %>">1</em>&nbsp;件&nbsp;&nbsp;组合购买</font><br/>
			                 <br>
			                 <strike>总价：￥&nbsp;<em id="totalmoney_<%=goods.getId() %>_<%=count %>">0.0</em>&nbsp;元  </strike>
			                 <br>组合价：<font color="#bc0000" face="微软雅黑">￥&nbsp;<em id="money_<%=goods.getId() %>_<%=count %>">0.0</em>&nbsp;</font>元<br>
			                                                  共优惠：￥&nbsp;<em id="cheap_<%=goods.getId() %>_<%=count %>"><%= 0.0 %></em>&nbsp;元  <br><br>
			                  <a href="javascript:void(0)" onclick="AddInCart(this)" flag="<%= count%>" id="<%= goods.getId()%>"><img src="http://images.d1.com.cn/Index/images/ljgmzh.png" />  </a> 
			                  <br/>
			                   <%
					         if((goods.getGdsmst_rackcode().startsWith("020")||goods.getGdsmst_rackcode().startsWith("030"))&&(goods.getGdsmst_brandname()!=null&&goods.getGdsmst_brandname().length()>0&&(goods.getGdsmst_brandname().equals("诗若漫")||goods.getGdsmst_brandname().equals("AleeiShe 小栗舍")||goods.getGdsmst_brandname().equals("FEEL MIND")))){%>
					    	 <a href="/gdscoll/freegdscoll.jsp?id=<%= id%>" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/SEP/DIY.png" style="border:none;"/></a><br/>
					    	
					         <%}
					      %>
			                </td>
                           </tr>
                          </table>  
                      </div>
                  <%}
              %>
             
              </li>
            <%
           } 
	%>
	</ul>
</td></tr></table>
</div>
	
    <%  }%>

   
         <div style="width:770px; border:solid 1px #fff;">
		    <table width="770" border="0" cellspacing="0" cellpadding="0" align="center" class="main" height="35"><%
		    if(size <= 0){
		    %>
		     <tr><td colspan="2" width="770" style="text-align:left;">&nbsp;&nbsp;以下是根据部分搜索词匹配得到的结果</td></tr>
		    <%
		    if(str.length()>0){
		    	String newtag=str.replace('，', ',');
				String[] newstr=newtag.split(",");
			    for(int i=0;i<newstr.length;i++)
			    {%>
			    <tr style="background:#f8f8f8; border-top:solid 1px #ccc;"><td height="27" style=" text-align:left; color:#ba3d1d; font-size:14px;">
			    <b>&nbsp;&nbsp;<%= newstr[i] %></b></td><td style="text-align:right;"><A href="/search.jsp?headsearchkey=<%= URLEncoder.encode(newstr[i], "utf-8")%>" target="_blank" style="color:#0f5694">查看所有结果>>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</A></td></tr>
			    <tr><td colspan="2">
			    	<% request.setAttribute("searchkey",newstr[i]);%>
		               <jsp:include   page= "/channel/getOther.jsp"   />
		       </td></tr>
			    <%}
		    }
		    %>
		   
            <%
            }else if(pb.getTotalPages()>1){ %>
            <tr style='display:block'>
              <td width="131" >共<b><font color="#FF0000"><%=pb.getTotalPages()%></font></b>页，当前第<font color="#CC0000"><b><font color="#FF0000"><%=pb.getCurrentPage()%></font></b></font>页 </td>
              <td ><%if(pb.getCurrentPage()>1){ %> <a href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=1" class="pag1">首页</a> &nbsp;<%} %>
              <%
              	if(pb.hasPreviousPage()){
              %>
              <a href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=<%=pb.getPreviousPage() %>" class="pag1">上一页</a>&nbsp;
				<%}
				for(int i=pb.getStartPage();i<=pb.getEndPage()&&i<=pb.getTotalPages();i++){
					if(currentPage == i){
						%><span class="curr1"><%=i %></span>&nbsp;<%
					}else{
						%><a href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=<%=i%>" class="pag1"><%=i%></a>&nbsp;<%
					}
				}//end for
				if(pb.hasNextPage()){
              %>
              <a href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=<%=pb.getNextPage() %>" class="pag1">下一页</a>&nbsp; 
              <%} %><%if(pb.getCurrentPage()!=pb.getTotalPages()){ %>
              <a href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=<%=pb.getTotalPages() %>" class="pag1">尾页</a><%} %></td>
              </tr><%
            } %>
          </table>
		        
        </div>
        
         <%
            
             if(str.length()>0)
             {%>
            	 <div class="xgss">
            	    &nbsp;&nbsp;相关搜索：
            	
		        <%  //String newtag=getXGSS(id).replace('，', ',');
            	    ArrayList<Tag> elist=new ArrayList<Tag>();
            	     ArrayList<Tag> alist=getXGSS1(ids);
            	     if(alist!=null)
            	     {
            	    	 for(int i=0;i<alist.size();i++)
            	    	 {
            	    		
            	    		 for(int j=i;j<alist.size()-1;j++)
            	    		 {
            	    			 Tag ti=alist.get(i);
            	    			 Tag tj=alist.get(j+1);
            	    			 if(ti.getTag_key().equals(tj.getTag_key()))
            	    			 {
            	    				 ti=null;
            	    			 }
            	    			 elist.add(tj);
            	    		 }
            	    	 }
            	     }
					//String[] newstr=newtag.split(",");
					//数组去重
					// for(int i=0;i<newstr.length;i++){
				           // for(int j=i;j<newstr.length-1;j++){
				              //  if(newstr[i].equals(newstr[j+1])){
				                //	newstr[j+1]="";
				               // }
				           // }
				       // }
                    
					for(int i=0;i<elist.size()&&i<8;i++)
					{
						Tag cc=elist.get(i);
						if(cc!=null)
						{
							
					
		            //for(int i=0;i<newstr.length&&i<10;i++)
		           // {
		            //if(newstr[i].length()>0)
		            //{%>
		            	<a href="http://www.d1.com.cn/channel/<%= cc.getId() %>" target="_blank">
		            	<%=cc.getTag_key() %>
		            	</a>|
		            	
		            <%//}
		           // }
						}
					}
		            out.print(" </div>");
            }%>
        
        
		</div>

	<br/>
</div>     
</div>
 <div class="clear"></div>
<%@include file="/inc/foot.jsp"%>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script type="text/javascript">
$(document).ready(function() {
    $(".search_seltu").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
});
</script>
</body>
</html>