<%@ page contentType="text/html; charset=UTF-8" import="java.math.*,java.util.regex.*"%>
<%@include file="/html/getComment.jsp" %>

<%!
public String adimgget(String adstr){
String  regex = "<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>";  
Pattern  pattern = Pattern.compile(regex);
Matcher m_image = pattern.matcher(adstr);  
while(m_image.find()){  
	//提取字符串中的src路径
  Matcher m = Pattern.compile("src=\"?(.*?)(\"|>|\\s+)").matcher(m_image.group());
  while(m.find())
  {
	  return m.group(1);
  }
}  
return "";
}
	/*
	* 计算字符串的字节长度(字母数字计1，汉字及标点计2)
	*
	*/
	public static int byteLength(String string){
		int count = 0;
		for(int i=0;i<string.length();i++){
		if(Integer.toHexString(string.charAt(i)).length()==4){
			count += 2;
		}else{
			count++;
		}
		}
		return count;
	}
	/*
	* 按指定长度，省略字符串部分字符
	* @para String 字符串
	* @para length 保留字符串长度
	* @return 省略后的字符串
	*/
	public static String stringformat(String string,int length){
	StringBuffer sb = new StringBuffer();
	if(byteLength(string)>length){
		int count = 0;
		for(int i=0;i<string.length();i++){
			char temp = string.charAt(i);
			if(Integer.toHexString(temp).length()==4){
				count += 2;
			}else{
				count++;
			}
			if(count<length-3){
				sb.append(temp);
			}
			if(count==length-3){
				sb.append(temp);
				break;
			}
			if(count>length-3){
				sb.append(" ");
				break;
			}
		}
		sb.append("...");
	}else{
		sb.append(string);
	}
		return sb.toString();
	}

   //获取该商户的所有模块
   private ArrayList<ShopModel> getShopModelList(String shopinfo_id)
   {
	ArrayList<ShopModel> rlist = new ArrayList<ShopModel>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("shopmodel_infoid", new Long(shopinfo_id)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("shopmodel_sort"));
	List<BaseEntity> list = Tools.getManager(ShopModel.class).getList(clist, olist, 0, 22);
	if(clist==null||clist.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((ShopModel)be);
	}
	
	return rlist ;
	
   }
	//根据传过来的商户缩写名查询出shopcode
	private ArrayList<ShpMst> getShopSM(String shopsname){
		ArrayList<ShpMst> rlist = new ArrayList<ShpMst>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("shpmst_shopsname", shopsname));
		List<BaseEntity> list = Tools.getManager(ShpMst.class).getList(clist, null, 0, 1);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ShpMst)be);
		}
		return rlist ;
	}
	//获取首页商户的信息
	private ArrayList<ShopInfo> getShopInfoList(String shopcode)
	{
		ArrayList<ShopInfo> rlist = new ArrayList<ShopInfo>();
		List<Criterion> clist = new ArrayList<Criterion>();
		//List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		//clist.add(Restrictions.eq("shopinfo_indexflag", new Long(0)));//0为首页  3在专题页被设置的首页
		clist.add(Restrictions.sqlRestriction(" (shopinfo_indexflag = 3 or shopinfo_indexflag = 0)"));
		clist.add(Restrictions.eq("shopinfo_shopcode", shopcode));
		clist.add(Restrictions.eq("shopinfo_del", new Long(0)));//未被删除
		//List<BaseEntity> list = Tools.getManager(ShopInfo.class).getList(clist, null, 0, 1);
		List<BaseEntity> list = Tools.getManager(ShopInfo.class).getListCriterion(clist, null, 0, 2);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ShopInfo)be);
		}
		return rlist ;
		
	}
	//通过shopcode查询
		private ArrayList<ShopInfo> getShopInfoListforZt(String shopcode)
		{
			ArrayList<ShopInfo> rlist = new ArrayList<ShopInfo>();
			List<Criterion> clist = new ArrayList<Criterion>();
			//List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("shopinfo_indexflag", new Long(0)));//0为首页  3在专题页被设置的首页
			//clist.add(Restrictions.sqlRestriction(" (shopinfo_indexflag = 3 or shopinfo_indexflag = 1)"));
			clist.add(Restrictions.eq("shopinfo_shopcode", shopcode));
			clist.add(Restrictions.eq("shopinfo_del", new Long(0)));//未被删除
			//List<BaseEntity> list = Tools.getManager(ShopInfo.class).getList(clist, null, 0, 1);
			List<BaseEntity> list = Tools.getManager(ShopInfo.class).getListCriterion(clist, null, 0, 2);
			if(clist==null||clist.size()==0)return null;
			for(BaseEntity be:list){
				rlist.add((ShopInfo)be);
			}
			return rlist ;
			
		}
	
	//获取专题页商户的信息 
	private ShopInfo getShopInfoById(String zt_id)
	{ 
		ShopInfo shop_info = (ShopInfo)Tools.getManager(ShopInfo.class).get(zt_id);
		if(shop_info==null)return null;
		return shop_info ;
	}	
	
	//获取新品
	public static ArrayList<Product> getProductList(String shopcode,int num){
		ArrayList<Product> list=new ArrayList<Product>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_shopcode", shopcode));
		clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("gdsmst_createdate"));
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,num);
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Product)be);
			}
		}	
		else
		{
			return null;
		}
	     return list;
	}
	//根据商品分类 、品牌、商户编号$rack=023001$brand=小栗舍$shop=23165468$count=564
		public static ArrayList<Product> getProductListnum(String recstr){
			//System.out.println("------------------------"+recstr);
			
			String[] recarr=("0"+recstr).split("\\$");
			String rack="";
			String brand="";
			String shop="";
			String count="";
			for(int i=1;i<recarr.length;i++){
				
				if(recarr[i].startsWith("rack="))rack=recarr[i].substring(5);
				else if(recarr[i].startsWith("brand="))brand=recarr[i].substring(6);
				else if(recarr[i].startsWith("shop="))shop=recarr[i].substring(5);
				else if(recarr[i].startsWith("count="))count=recarr[i].substring(6);
				
			}
			if(rack==""&&brand==""&&shop==""&&count=="")return null;
			int num=100;
			if(!Tools.isNull(count))num=Tools.parseInt(count);
			if(num>100)num=100;
			ArrayList<Product> list=new ArrayList<Product>();
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			if(!Tools.isNull(rack))clist.add(Restrictions.like("gdsmst_rackcode", rack+"%"));
			if(!Tools.isNull(brand))clist.add(Restrictions.eq("gdsmst_brand", brand));
			if(!Tools.isNull(shop))clist.add(Restrictions.eq("gdsmst_shopcode", shop));
			clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.desc("gdsmst_createdate"));

			List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,num);
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((Product)be);
				}
			}	
			else
			{
				return null;
			}
		     return list;
		}
	
	public static List<ShopRck> getShopRckList(String shopcode,int parentid){
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("shoprck_shopcode", shopcode));
		listRes.add(Restrictions.eq("shoprck_parentid", new Long(parentid)));
		List<Order> olist= new ArrayList<Order>();
		olist.add(Order.asc("shoprck_seq"));
		List list = Tools.getManager(ShopRck.class).getList(listRes, olist, 0, 200);	
		if(list == null || list.isEmpty()) return null;	
		return list;
	}

public static boolean getmsflag(Product p){
		Date nowday=new Date();
		 boolean ismiaoshao=false;
		 SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		 if(p.getGdsmst_promotionstart()!=null&&p.getGdsmst_promotionend()!=null&&p.getGdsmst_msprice()!=null){
		 	Date sdate=p.getGdsmst_promotionstart();
		 	Date edate=p.getGdsmst_promotionend();	

		 	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
		 			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
		 			&&p.getGdsmst_msprice().floatValue()>=0f){
		 		ismiaoshao = true;
		 	}

		 }
		 if(ismiaoshao){

		 	ismiaoshao=CartHelper.getsgbuy(p.getId());
		 }
		 return ismiaoshao;
		}

	public static String format_two(float value) {  
        BigDecimal bd = new BigDecimal(value);  
        bd = bd.setScale(2, RoundingMode.HALF_UP);  
        return bd.toString();  
    } 
%>
<%//根据推荐编码获得推荐商品信息列表
	String act= request.getParameter("act");
	String code= request.getParameter("code");
	if("form_search".equals(act)){
		//System.out.println("==code=="+code);
		ArrayList<PromotionProduct> list=PromotionProductHelper.getPProductByCode(code,300);
		int v = 0;
		if(list!=null && list.size()>0){
		SpecialProduct sp = (SpecialProduct)Tools.getManager(SpecialProduct.class).get(code);
		if(sp!= null && !Tools.isNull(sp.getSprckmst_explain()) && Tools.isNumber(sp.getSprckmst_explain().trim())){	
			v = Integer.valueOf(sp.getSprckmst_explain());
		}
		String str = "[";
		for(int i=0;i<v;i++){
			Product p=ProductHelper.getById(list.get(i).getSpgdsrcm_gdsid());//根据推荐位表得出商品表
			//System.out.println("===="+CartHelper.getmsflag(p)+"==ee="+p.getGdsmst_promotionend()+"-id-"+p.getId()+"==="+list.get(i).getSpgdsrcm_gdsid());
			if(p!=null && CartHelper.getmsflag(p)){
				str+= "{\"id\":\""+ p.getId().substring(3) +"\",\"endTime\":\""+ p.getGdsmst_promotionend().getTime() +"\"}";
				str += ",";
			}
		}
		str = str.substring(0,str.length()-1);
		str+="]";
		out.print(str);
		//System.out.println("===="+str.trim());
		}
		
		return;
	}

String chePingAn1 = Tools.getCookie(request,"PINGAN");
String flags="2";
ShopInfo si=null;
String index_flag = "";
if(request.getParameter("index_flag")!=null){
	index_flag = request.getParameter("index_flag");
}else{
	index_flag = 0+"";
}
String shopcode="";
if(request.getParameter("sc")!=null&&request.getParameter("sc").length()>0){
	shopcode=request.getParameter("sc");
}

if(shopcode.equals("")){
	out.print("参数不正确！<a href=\"http://www.d1.com.cn/\">返回D1首页</a>");
}else{
	//20160110添加，status!=1的店不显示。
	ShpMst shopmst=null;
	ArrayList<ShpMst> shpmstlist2= getShopSM(shopcode);
	if(shpmstlist2!=null&&shpmstlist2.size()>0){
	System.out.println("%%%%%%%###########################"+shopcode);
		shopmst=shpmstlist2.get(0);
		if(shopmst.getShpmst_status()!=1){
			response.setContentType("text/html; charset=gb2312");
			response.sendRedirect("/404.jsp");
		}
	}
}
String shopinfo_logo = "";
String shopinfo_bigimg = "";
String xs_shopcode = "";
String ztid=shopcode;
if(ztid!=null&&ztid.equals("305")){
	// Tools.setCookie(response,"rcmdusr_uid","mqbyzx1312",(int)(Tools.DAY_MILLIS/1000*1));
	  Tools.setCookie(response,"rcmdusr_rcmid","309",(int)(Tools.DAY_MILLIS/1000*1));
}

ShpMst sm2 = null; 
if(index_flag!=null && index_flag.equals("0")){//值为0代表预览首页
	ArrayList<ShpMst> shpmstlist= getShopSM(shopcode);
	if(shpmstlist!=null&&shpmstlist.size()>0){
		sm2=shpmstlist.get(0);
	}
	shopcode = sm2.getId();
	ArrayList<ShopInfo> silist= getShopInfoList(sm2.getId());
	if(silist!=null&&silist.size()>0){
		for(int i = 0 ;i<silist.size();i++){
			if(silist.get(i).getShopinfo_indexflag() == 3){
				si=silist.get(i);
				break;
			}
		}
		if(si==null){
			si=silist.get(0);
		}
	}
}else{//专题页预览
	//System.out.println("222222222222");
	   si = getShopInfoById(shopcode);
	   
	   if(!Tools.isNull(si.getShopinfo_shopcode())){
		   xs_shopcode = si.getShopinfo_shopcode();
		   shopcode = si.getShopinfo_shopcode();
	   }
	   if(si.getShopinfo_shopcode()!=null && !si.getShopinfo_shopcode().equals("00000000")){
		   ArrayList<ShopInfo> silist= getShopInfoListforZt(si.getShopinfo_shopcode());
		   if(silist!=null&&silist.size()>0){
				for(int i = 0 ;i<silist.size();i++){
					if(silist.get(i).getShopinfo_indexflag() == 3){
						si=silist.get(i);
						break;
					}
				}
				if(si==null){
					si=silist.get(0);
				}
			}
		   //System.out.println("======="+silist);
		   if(silist!=null&&si!=null&&si.getShopinfo_logo()!=null){
			   shopinfo_logo = si.getShopinfo_logo();
			   shopinfo_bigimg = si.getShopinfo_bigimg();
		   }
	   }
	 //System.out.println("----"+si.getId()+"========"+"shopinfo_logo:"+shopinfo_logo);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！">
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买">
<title>
<%
   if(!index_flag.equals("0")){
	   if(si!=null&&si.getId()!=null){
		   out.print(si.getShopinfo_title()!=null?si.getShopinfo_title():"");
	   }
   }else{%> 
  	 D1优尚网-时尚网上购物商城,在线销售化妆品、名表、饰品、女装、男装等个人扮靓物品
  <%}%>
</title>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js?"+System.currentTimeMillis())%>"></script>
<script>
  var ws=window.screen.width;    
</script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/comment.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/shopindex.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/res/js/wapcheck.js?1406565937421"></script>

<script>
<%if(session.getAttribute("wapurl_flag")==null&&request.getParameter("sc")!=null&&request.getParameter("sc").length()<8){%>
if(checkMobile()){
	window.location.href="http://m.d1.cn/wap/shop.html?id=<%=request.getParameter("sc")%>";
}
<%}%>
</script>
<script type="text/javascript" src="/res/wap/js/loadDuiHuan.js"></script>
<style type="text/css">
.widauto {
	width:100%;
	height:520px;
	position: relative;
	z-index: 2;	
	overflow: hidden;
}
.widauto_dz {
	width:980px;;
	margin:0px auto; 
	text-align:center;
	overflow:hidden;
}
.imgabs {
	height:500px;
	position: absolute;
	top: 0px;
}
.page_f{
	margin-top:10px; 
	margin-left:10px; 
	position:fixed; 
	_position:absolute;
	_bottom:auto; 
	_top:expression(eval(document.documentElement.scrollTop));
	z-index:99999;
}
.page_djs{
	margin-top:20px; 
	/*margin-left:142px;*/ 
	right:142px;
	position:absolute;
	padding-top:6px; 
	text-align:center;
	width:440px;
	height:38px;
	background-color:#000000;
	filter: alpha(opacity=50);
	-moz-opacity: 0.5;
	opacity: 0.5;
	_position:absolute;
	_bottom:auto; 
	_top:expression(eval(document.documentElement.scrollTop));
	z-index:9;
}
.page_djs2{
	margin-top:20px; 
	/*margin-left:142px;*/ 
	right:142px;
	position:absolute;
	padding-top:6px; 
	text-align:center;
	width:440px;
	height:38px;
	z-index:10;
}
.sty_time{
	color: #FFFFFF;
	font-weight: normal;
}
.other_help {
   clear: both;
  /* background: none repeat scroll 0 0 #F0F0F0;
   height: 226px;
   margin-top: 10px;
   overflow: hidden;
   padding-top: 10px;*/
}
    .imgdp {
	height: 300px;
	width: 238px;
	border: 1px solid #8b8b8b;
	overflow:hidden;
	background-repeat: no-repeat;
	/*background-position: -73px -20px;*/
	position:relative;
	margin:0px;
	padding:0px;
}
 .imgdp250 {
	height: 250px;
	width: 238px;
	border: 1px solid #8b8b8b;
	overflow:hidden;
	background-repeat: no-repeat;
	background-position: 20px; 
	position:relative;
	margin:0px;
	padding:0px;
}
 .imgdp200 {
	height: 200px;
	width: 238px;
	border: 1px solid #8b8b8b;
	overflow:hidden;
	background-repeat: no-repeat;
	background-position: 20px; 
	position:relative;
	margin:0px;
	padding:0px;
}
.imgdpt{position:absolute;
	background: #414141;
	color:#FFFFFF; 
	font-family:微软雅黑;
	font-size:12px; 
	font-weight:800;
	line-height: 30px;
	verflow: hidden;
	bottom: 0px;
	width: 240px;
	filter: alpha(opacity=70);
	-moz-opacity: 0.7;
	opacity: 0.7;
	height: 28px;
	display: block;
	margin:0px;
	padding:0px;
	left:0px;
}
.STYLE1 {
	font-family: "微软雅黑";
	font-size: 16px;
	color: #f0d56a;
}
.STYLE2 {
	font-family: "微软雅黑";
	font-size: 36px;
	color: #f0d56a;
	font-weight: bold;
	line-height: 48px;
}
.STYLE3 {
	font-family: "微软雅黑";
	font-size: 10px;
	color: #FFFFFF;
}
.mebprice{
/*font-family: 'impact';*/
font-family: '微软雅黑';
font-size: 18px;
line-height: 30px;
color: #e4393c;
}
.mebprice b {
font-size: 30px;
}
.saleprice{
font-family:'微软雅黑';
font-size: 14px;
color: #999;
}
.title{
font-family:'微软雅黑';
font-size: 14px;
/*white-space: nowrap;*/
}
.td_overfl a { color:#333; text-decoration:none;font-size: 14px;}
.td_overfl a:hover{color:#37F;;text-decoration:none;font-size: 14px;}
.title2{color: #FF6259; font-size:14px; font-family:'微软雅黑';
}
.title2 span{
width:200px;display:block;overflow:hidden;white-space:nowrap;word-break:keep-all;color: #e4393c;
}

#theLink{ 
display:block;/*因为标签a是内链元素，所以利用这句话将内链元素转化成块状元素，后面的width和height才起作用*/ 
width:200px; 
height:36px; 
margin:0 auto; 
background:url('http://images.d1.com.cn/zt2014/0110/jg002.jpg') no-repeat; 
} 
#theLink:hover{background:url('http://images.d1.com.cn/zt2014/0110/jg001.jpg') no-repeat;} 
#now_buy{ 
display:block;/*因为标签a是内链元素，所以利用这句话将内链元素转化成块状元素，后面的width和height才起作用*/ 
width:200px; 
height:36px; 
margin-left: -2px; 
background:url('http://images.d1.com.cn/zt2014/0110/jg002.jpg') no-repeat; 
} 
#now_buy:hover{background:url('http://images.d1.com.cn/zt2014/0110/jg001.jpg') no-repeat;} 
.td_overfl span{width:200px; display:block;overflow:hidden;/*white-space:nowrap;word-break:keep-all;*/}

.hottxt{
	position:absolute;
	left: 5px;
	top: 5px;
	width: 51px;
	height: 57px;
	padding: 14px 10px 0 10px;
	/*background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -71px;*/
	font-family: "微软雅黑", sans-serif;
	font-size: 17px;
	color: white;
	line-height: 20px;
	text-align: center;
	font-style: normal;
	/*-webkit-transform: rotate(-15deg) translate3d( 0, 0, 0);
	transform: rotate(-15deg);*/
}
.zhutuitxt{
	position:absolute;
	left: -15px;
	top: -3px;
	width: 51px;
	height: 57px;
	padding: 14px 10px 0 10px;
	font-family: "微软雅黑", sans-serif;
	font-size: 17px;
	color: white;
	line-height: 20px;
	text-align: center;
	font-style: normal;
	-webkit-transform: rotate(-15deg) translate3d( 0, 0, 0);
	transform: rotate(-15deg);
}
#nocolor:hover{
color: #515151;
}
.sm_font{padding-left: 74px;padding-top: 15px; font-family: '微软雅黑'; font-weight:bold; font-size: 28pt;}	
.sm_font_a{position:absolute; padding-left: 17px;padding-top: 30px; text-align: center; }
#css_a{
display:block;
width:80px;
height:17px;
line-height:17px;
font-family: '微软雅黑'; font-size: 11pt;
}

.ld_intro{
	width:222px;
	height: 18px;
	line-height: 18px;
	color: #e4393c;;
	margin-bottom: 10px;
	font-family:"微软雅黑";
	font-size: 14px;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}
.shname_text{
width:222px;
height: 50px;
line-height: 25px;
text-align: left;
width: 100%;
font-size: 14px;
font-weight: normal;
color: #333;
overflow: hidden;
/*white-space: nowrap;
text-overflow: ellipsis;*/
font-family:'微软雅黑';
}
.pbox_off {
position: relative;
top: -3px;
font-size: 12px;
color: white;
background-color: gray;
border-radius: 3px;
padding: 0 5px;
margin: 0 7px 0 3px;
}  
.order_sty{
width:980px; margin:0px auto; overflow:hidden;
font-size: 14px;
}
.order_sty li{
float: left; margin-right: 10px;
}
.temaif span{
width:190px;
display:block;overflow:hidden;white-space:nowrap;word-break:keep-all;
text-align: left; padding-left: 12px; padding-right: 12px; color: #E4393C;; font-family:'宋体';
}
.temaif2 span{
width:225px;
display:block;overflow:hidden;white-space:nowrap;word-break:keep-all;
text-align: left; padding-left: 12px; padding-right: 12px; color: #E4393C;; font-family:'宋体';
}
.lijiqiang {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/lijiqiang.png);
background-position: 0px 0px;
width: 83px;
height: 34px;
color: white;
right:8px;
bottom: 45px;
}
.zhekou_t {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/checknap.png);
background-position: 0px 0px;
width: 39px; height: 18px;
left:12px;
bottom: 136px;
}

</style>
 <script type="text/javascript">
	//$(document).ready(function(){
	$(window).load(function(){
		//var sw=window.screen.width;//获取屏幕宽度
		var sw = $(window).width(); //浏览器时下窗口可视区域宽度
		
		var img_w = $("#imgabs img").width();//获取首张广告图宽度
		var img_h = $("#imgabs img").height();//获取首张广告图高度
		var left = (img_w-sw)/2;
		//$(".imgabs").css("width",sw);
		//$("#imgabs").css("left",-left);
		//setTimeout(function(){
			//$("#widauto").css("height",img_h+10);
			//$("#imgabs").css("height",img_h);
		//}, 60000);
		var m_left = (sw-980)/2;
		//alert(m_left);
		$(".page_djs").css("right",m_left);
		$(".page_djs2").css("right",m_left);	
		
		
		
	})
	$(document).ready(function() {
		asyloadjs();
	});
	function asyloadjs(){
		//粉色疯抢三种模板的样式
		$('.fenfq').hover(function(){
			$(this).css('border', 'solid 1px #f0424e');
		},function(){
        	$(this).css('border',  'solid 1px #C8C8C8');	
		}
		);
	}
	
	  var the_s=new Array();
	  var lasttime=0;
	  function vms_time(){
		
		  var data = jsonData;
		
		  for(var i=0;i<data.length;i++){
		  
			  var end = data[i].endTime;
			  var now = new Date().getTime();
			  lasttime = (end - now)/1000;
			  //alert(lasttime+"===");
			  if(lasttime>0){
				  var the_D=Math.floor((lasttime/3600)/24)
			      var the_H=Math.floor((lasttime-the_D*3600*24)/3600);
				  if(the_H<10){
					  the_H='0'+the_H;
				  }
		          var the_M=Math.floor((lasttime-the_D*3600*24-the_H*3600)/60);
		          if(the_M<10){
		        	  the_M='0'+the_M;
				  }
		          var the_S=Math.floor((lasttime-the_H*3600)%60);
		          if(the_S<10){
		        	  the_S='0'+the_S;
				  }
		          $("#pmstime"+data[i].id).text(the_D+"天 "+the_H+":"+the_M+":"+the_S );
		      }else{
		    	  $("#pmstime"+data[i].id).text("已结束");
		      }
		 }  
	 }
	  function vms_time(endt,id){
		  var now = new Date().getTime();
		  lasttime = (endt - now)/1000;
		  //alert(lasttime+"===");
		  if(lasttime>0){
			  var the_D=Math.floor((lasttime/3600)/24)
		      var the_H=Math.floor((lasttime-the_D*3600*24)/3600);
			  if(the_H<10){
				  the_H='0'+the_H;
			  }
	          var the_M=Math.floor((lasttime-the_D*3600*24-the_H*3600)/60);
	          if(the_M<10){
	        	  the_M='0'+the_M;
			  }
	          var the_S=Math.floor((lasttime-the_H*3600)%60);
	          if(the_S<10){
	        	  the_S='0'+the_S;
			  }
	          $("#pmstime"+id).text("剩余："+the_D+"天 "+the_H+"时"+the_M+"分"+the_S+"秒" );
	      }else{
	    	  $("#pmstime"+id).text("已结束");
	      }
 }
	  
	  var lasttime2=0;
	  function vms_time2(){
		  if(lasttime2>0){
			  var the_D=Math.floor((lasttime2/3600)/24)
		      var the_H=Math.floor((lasttime2-the_D*3600*24)/3600);
			  if(the_H<10){
				  the_H='0'+the_H;
			  }
	          var the_M=Math.floor((lasttime2-the_D*3600*24-the_H*3600)/60);
	          if(the_M<10){
	        	  the_M='0'+the_M;
			  }
	          var the_S=Math.floor((lasttime2-the_H*3600)%60);
	          if(the_S<10){
	        	  the_S='0'+the_S;
			  }
	          $("#tm_D").text(the_D);
	          $("#tm_H").text(the_H);
	          $("#tm_M").text(the_M);
	          $("#tm_s").text(the_S);
	          lasttime2--;
	      }else{
	    	  $("#tm_djs").text("已结束");
	      }
	 }
	  
	  function asyloadmodel(model_id,type){
		  var click_flag = $("#click_flag").val();
		  var have_gds = $("input[name='have_gds']:checked").val();
		  if(typeof have_gds == 'undefined'){
			  have_gds = "无货";
		  }
		  $.ajax({
				type: "post",
				dataType: "json",
				url: '/admin/ajax/asyloadmodel.jsp',
				cache: false,
				data: {model_id:model_id,type:type,click_flag:click_flag,have_gds:have_gds},
				error: function(XmlHttpRequest){
					alert("页面刷新出错，请稍后重试！");
				},success: function(json){
					//alert(json.code);
					//alert(json.content);
					//alert(json.click_flag);
					if(json.code==1){
						$('#asy_load'+model_id).html(json.content);
						if(json.click_flag == 1 &&　type == 3){
							$("#click_flag").val("2");
						}else if(json.click_flag == 2 &&　type == 3){
							$("#click_flag").val("1");
						}
						//$("#click_flag").val(json.click_flag);
						if(click_flag==2){//降序  箭头向下  销量和折扣做死
							   if(type==1){//销量
								    //$("#xiaoliangw").css("color","#ff1260");
									//$("#xiaoliang").attr("src","http://images.d1.com.cn/zt2014/0110/downarrow-red.gif");
							   }else if(type==2){//折扣
								    //$("#zhekouw").css("color","#ff1260");
									//$("#zhekou").attr("src","http://images.d1.com.cn/zt2014/0110/downarrow-red.gif");
							   }else if(type==3){//价格
								   $("#jiagew").css("color","#ff1260");
								   $("#jiage").attr("src","http://images.d1.com.cn/zt2014/0110/prizearrow-up.gif");
							   }
						}else{
							   if(type==1){//销量
								   //$("#xiaoliangw").css("color","#4B4B4B");
								   //$("#xiaoliang").attr("src","http://images.d1.com.cn/zt2014/0110/downarrow1-grey.gif");
							   }else if(type==2){//折扣
								   //$("#zhekouw").css("color","#4B4B4B");
								   //$("#zhekou").attr("src","http://images.d1.com.cn/zt2014/0110/downarrow1-grey.gif");
							   }else if(type==3){//价格
								   $("#jiagew").css("color","#4B4B4B");
								   $("#jiage").attr("src","http://images.d1.com.cn/zt2014/0110/prizearrow-down.gif");
							   }
						}
						
						
					}
					
				},beforeSend: function(){
				},complete: function(){
					asyloadjs();
				}
		});
	  }
	
	  
	 
</script>

</head> 

<body >
<input type="hidden" id="xs_shopcode" name="xs_shopcode" value="<%=xs_shopcode%>"/>
<%@include file="/inc/head.jsp" %>
<%
System.out.println("########################22233334");

if(("522").equals(request.getParameter("sc"))){ %>
<style>
.bannertop {
background-image: url(http://images.d1.com.cn/zt2014/08/0820/cosmetic0818_01.jpg);
background-repeat: no-repeat;
background-position: center;
height: 248px;
padding-top:390px;
}
div.orbit-wrapper { position: relative; overflow: visible; padding:0 15px;height: 300px;margin:0 auto;}
div.orbit { position: relative; overflow: hidden;}
div.orbit span { display:none;}
div.orbit a img{ position: absolute; display:block;width: 194px; box-shadow: 0 3px 8px rgba(0,0,0,0.5); padding:3px; border:#ccc 1px solid; background:#fff; }
div.orbit-wrapper h4{ display: none; }
div.timer {display: none;}
div.slider-nav { display: block; }
div.slider-nav span { width: 50px; height: 50px;  color: #fff; text-align: center; position: absolute; z-index: 100; top: 80px; cursor: pointer; text-indent:-9999px;}
div.slider-nav span.right { right: 0px; background:url(http://images.d1.com.cn/zt2014/08/0820/next.png) no-repeat; }
div.slider-nav span.left { left:0px;background:url(http://images.d1.com.cn/zt2014/08/0820/prev.png)  no-repeat; }

</style>
<div class="bannertop">
<!-- 代码 开始 -->
<div class="orbit-wrapper">			
	<div id="featured" class="orbit">
		<a href="http://www.d1.com.cn/result.jsp?productsort=014&brand=000142" target="_blank"><img src="http://images.d1.com.cn/zt2014/08/0820/1.jpg" /></a>
    <a href="http://www.d1.com.cn/result.jsp?productsort=014&brand=000430" target="_blank"><img src="http://images.d1.com.cn/zt2014/08/0820/2.jpg" /></a>
    <a href="http://www.d1.com.cn/result.jsp?productsort=014&brand=002146" target="_blank"><img src="http://images.d1.com.cn/zt2014/08/0820/3.jpg" /></a>
    <a href="http://www.d1.com.cn/result.jsp?productsort=014&brand=001782" target="_blank"><img src="http://images.d1.com.cn/zt2014/08/0820/4.jpg" /></a>
    <a href="http://www.d1.com.cn/result.jsp?productsort=014&brand=000625" target="_blank"><img src="http://images.d1.com.cn/zt2014/08/0820/5.jpg" /></a>
	</div>
</div>
</div>
<script type="text/javascript" src="/res/js/shop/jq.orbit.js"></script>
<script type="text/javascript" src="/res/js/shop/orbit.js"></script>
<!-- 代码 结束 -->
<%} %>
<%
  if(si==null){ 
  %>
    该商户还没有设置首页！<a href="http://www.d1.com.cn">返回D1首页</a> 
  <%}
  else {
	  String chk_pre="";
	  if(request.getParameter("chk_pre")!=null&&request.getParameter("chk_pre").length()>0){
		  chk_pre=request.getParameter("chk_pre");
	  }else{
		  chk_pre=0+"";
	  }
	  //未上线的专题页可以预览  简单算法为：专题id*商户编号-当前分钟数
	  String ss = si.getShopinfo_shopcode();
	  int hour_minus = new Date().getHours();	 
	  int chk = Integer.parseInt(si.getId())+Integer.parseInt(ss)-hour_minus;
	  //System.out.println("时间差"+hour_minus+"==chk=="+chk+"si.getId()=="+si.getId());
	  
  if(!Tools.isNull(si.getShopinfo_lineflag())&& si.getShopinfo_lineflag().equals("1")||Integer.parseInt(chk_pre) == chk){
  %>
  <div style="float:left;" class="page_f">
  <%= si!=null&&!Tools.isNull(si.getShopinfo_floatcontent())?si.getShopinfo_floatcontent():"" %>
  </div>
	<div style="width:100%; margin:0px auto;overflow:hidden;<% if(si!=null&&si.getId()!=null) out.print("background:#"+si.getShopinfo_bgcolor()+";");%>" >
	
	<% //店招背景图
	    if(si!=null&&!Tools.isNull(si.getShopinfo_bigimg())||(!Tools.isNull(si.getShopinfo_logo())||!Tools.isNull(shopinfo_logo)))
	    {%>
	      <div style="background:url('<%= si.getShopinfo_bigimg()==null ? shopinfo_bigimg : si.getShopinfo_bigimg()%>') top center no-repeat;">
	    <%}
	%>
	
	<% if((si!=null&&!Tools.isNull(si.getShopinfo_logo()))||!Tools.isNull(shopinfo_logo)){%>
	  <div class="widauto_dz">
	      <%= si!=null&&(si.getShopinfo_logo()==null||si.getShopinfo_logo().equals(""))?shopinfo_logo:si.getShopinfo_logo() %>
	  </div>
	  <%if(si!=null&&!Tools.isNull(si.getShopinfo_bigimg())&&!Tools.isNull(si.getShopinfo_logo()))
	    {%></div><%}%>
	 <%}
	%> 
	<% if(si!=null&&!Tools.isNull(si.getShopinfo_bgimg())){%>
	
	<div style="clear: both;"></div>
	  <div class="widauto" id="widauto">
	  <%
		  
		String adbg= adimgget(si.getShopinfo_bgimg());
		%><style type="text/css">
		.shopad_banner {
			background-repeat: no-repeat;
			background-position: center;
			height:520px;
		}
		</style>
			 <div style="background-image: url(<%=adbg%>);" class="shopad_banner">
			 </div>
			  <%
		if(si.getShopinfo_tmend() != null){
		SimpleDateFormat df=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String	nowtime= df.format(new Date());
        String tttime =df.format(si.getShopinfo_tmend());
		%>
		<!-- 特卖会倒计时 -->
	   <div class="page_djs">
 		<script language=javascript>
		var startDate2= new Date("<%=nowtime%>");
		var endDate2= new Date("<%=tttime%>");
		lasttime2=(endDate2.getTime()-startDate2.getTime())/1000;
		setInterval(vms_time2,1000);</script>
	   </div>
	   <div class="page_djs2" >
	   <img src="http://images.d1.com.cn/zt2014/0110/clock.png" style=" vertical-align: middle;"/>
	     <span id="tm_djs" style=" vertical-align: middle; font-family: '微软雅黑'; font-size: 14pt; color: #FFFFFF; font-weight: bold;">&nbsp;距活动结束还剩：
	        &nbsp;<span class="sty_time" id="tm_D"></span>&nbsp;天
	        &nbsp;<span class="sty_time" id="tm_H"></span>&nbsp;时
	        &nbsp;<span class="sty_time" id="tm_M"></span>&nbsp;分
	        &nbsp;<span class="sty_time" id="tm_s"></span>&nbsp;秒
	        </span>
	   </div>
	   <%}%>
	 </div>
	
	 
	  <%} %> 
	<input type="hidden" id="click_flag" name="click_flag" value="2"/>
	   <% ArrayList<ShopModel> smlist=getShopModelList(si.getId().toString());
	   if(smlist!=null&&smlist.size()>0){
	    	   for(ShopModel sm:smlist){
	    		   if(sm!=null){%>
	    		   <%
	    		   if(sm.getShopmodel_orderflag()!= null && sm.getShopmodel_orderflag() == 1){
	    			  String gdsidlist=sm.getShopmodel_list();
	    			  String[] gdsidarr=gdsidlist.split(",");
    			   	  SpecialProduct sp = null;
    			   	  if(gdsidarr[0].indexOf("all")== -1){
    			   		 sp	= (SpecialProduct)Tools.getManager(SpecialProduct.class).get(gdsidarr[0]);
    			   	  }
    			   	  //主推模板不支持排序
	    		   //System.out.println("======"+sp);
    			      if(sp== null || Tools.isNull(sp.getSprckmst_explain())){	
	    		   %>
	    		   <div style="text-align: center; padding-bottom: 15px; padding-top: 0px;"><img src="http://images.d1.com.cn/zt2014/0110/dotline2.gif"/></div>
	    		   <ul class="order_sty">
	    		   <li><a href="javascript:void(0);" onclick="asyloadmodel(<%=sm.getId()%>,1);">
	    		   <span id="xiaoliangw" style="  margin-right: 10px; margin-left: 12px;">销量</span><img id="xiaoliang" src="http://images.d1.com.cn/zt2014/0110/downarrow-grey.gif" alt="" />
	    		   </a></li>
	    		   <li><img src="http://images.d1.com.cn/zt2014/0110/dotline1.gif" alt="" /></li>
	    		   <li><a href="javascript:void(0);" onclick="asyloadmodel(<%=sm.getId()%>,2);"><span id="zhekouw" style="margin-right: 10px;">折扣</span><img id="zhekou"  src="http://images.d1.com.cn/zt2014/0110/downarrow1-grey.gif" alt="" /></a></li>
	    		   <li><img src="http://images.d1.com.cn/zt2014/0110/dotline1.gif" alt="" /></li>
	    		   <li><a href="javascript:void(0);" onclick="asyloadmodel(<%=sm.getId()%>,3);"><span style="margin-right: 10px;" id="jiagew">价格</span><img id="jiage" src="http://images.d1.com.cn/zt2014/0110/prizearrow-grey2.gif" alt="" /></a></li>
	    		   <!--  <li><img src="http://images.d1.com.cn/zt2014/0110/dotline1.gif" alt="" /></li>-->
	    		   <!-- <li><a href="javascript:void(0);" onclick="asyloadmodel(<%=sm.getId()%>,4);">评论（先不做）</li> -->
	    		   <!-- <li><input style="vertical-align: middle;" name="have_gds" type="checkbox" value="有货" onclick="asyloadmodel(<%=sm.getId()%>,5);"/><span style="font-size: 14px;">&nbsp;仅显示有货&nbsp;</span></li>
	    		   <li></li> -->
	    		   </ul>
	    		   <div style="text-align: center; padding-bottom: 8px; padding-top: 15px;"><img src="http://images.d1.com.cn/zt2014/0110/dotline2.gif"/></div>
	    		   <%}} %>
	    		   <div id="asy_load<%=sm.getId()%>">
	    			 <div class="modelist" <% if(sm.getShopmodel_type()!=null&&sm.getShopmodel_type().toString().equals("2")&&sm.getShopmodel_title()!=null&&sm.getShopmodel_title().length()>0) out.print("style=\"background:#"+sm.getShopmodel_title()+";\""); %>>
	                   <% if(sm!=null && !Tools.isNull(sm.getShopmodel_txt())&&sm.getShopmodel_type().toString().equals("2")){%>
	                    <div style="height: 90px; ">
	                    <a name="<%=sm.getShopmodel_txt()%>"></a>
                	    	 <div class="sm_font" style="color: #<%=sm.getShopmodel_txtcolor()%>;position: relative;"><%= sm.getShopmodel_txt() %>
                	    	 <% if(!Tools.isNull(sm.getShopmodel_txtmore())){
                	    	 %>
                	    	 <span class="sm_font_a" ><a id="css_a" href="<% 
                	    	 String txtmore = sm.getShopmodel_txtmore(); 
                	    	 if(txtmore.indexOf("http://") == -1){
                	    		 out.print("http://"+sm.getShopmodel_txtmore());
                	    	 }else{
                	    		 out.print(sm.getShopmodel_txtmore());
                	    	 }
                	    	 %>" target="_blank;" style="color: #<%=sm.getShopmodel_txtcolor()%>;">更多商品&nbsp;<span style="font-family: '方正仿宋'; font-size: 13px;">></span></a></span>
                	    	 <%}%>
                	    	 </div>
                	    </div>
                	    <%}%>
	                    <% if(sm.getShopmodel_type()==1){//图文编辑模块，解释${}这种格式的推荐位
	                    
	                    %>
	                    	     <div class="mode_content">
	                    	        <%
	                    	        String[] splList=sm.getShopmodel_list().split(",");
	                    	        String realContent="";
	                    	        realContent=sm.getShopmodel_content();
	                    	        for(int i=0;i<splList.length;i++){
	                    	        	String[] tmp={splList[i]+""};
	                    	        	List<Promotion> splmstList=PromotionHelper.getBrandList(tmp);
	                    	       	 	String content_tmp="";
	                    	       	 	for(Promotion prmt:splmstList){
		                    	        	
	                    	       	 		content_tmp+="<div><a href="+prmt.getSplmst_url()+"><img src="+prmt.getSplmst_picstr()+"></img></a></div>";
		                    	        	
		                    	       	 }
	                    	       	 	
	                    	       	 realContent= realContent.replace("${"+splList[i]+"}", content_tmp);
	                    	       	
	                    	        }
	                    	        out.print(realContent);
	                    	       	out.flush();
	                    	        %>
	                    	         
	                    	     </div> 
	                         <%}
	                         else
	                         {%>
	                        	<div class="mode_content" style="<%if(sm.getShopmodel_size()<10){%>padding-top:10px;padding-bottom:10px;<%}else if(sm.getShopmodel_size()>=10 && sm.getShopmodel_size()<=13){%>padding-top:4px;<%}%>">
	                        	   <% String gdsidlist=sm.getShopmodel_list();
	                        	      if(gdsidlist.length()>0)
	                        	      {
	                        	    	  
	                        	     
	                        	    	  int c=0;
	                        	    	  String[] gdsidarr=gdsidlist.split(",");
	                        	    	  if(gdsidarr.length>0){
	                        	    	    	for(int m = 0;m<gdsidarr.length;m++){
	                        	    	        if(gdsidarr.length>0)
	                        	    	        {
	                        	    	        
	                        	    	        	if(gdsidarr[m].length() == 8){//商户编号
	                        	    	        	Product p=ProductHelper.getById(gdsidarr[m]);
	                        	    	        	if(p!=null&&p.getGdsmst_ifhavegds()==0&&p.getGdsmst_validflag()==1){
	                        	    	        	c++;
	                        	    	        	if(sm.getShopmodel_size()==2){%>
	                        	    	        	<%@include file="/html/zhuanti/modelsize/shopmodel2.jsp"%>	
	                        	    	        	<%}
	                        	    	        	else if(sm.getShopmodel_size()==1){%>
	                        	    	        		<%@include file="/html/zhuanti/modelsize/shopmodel1.jsp"%>
	                        	    	        	<%}
	                        	    	        	else if(sm.getShopmodel_size()==3){%>
	                        	    	        	   <%@include file="/html/zhuanti/modelsize/shopmodel3.jsp"%>
	                        	    	        	<%}
	                        	    	        	else if(sm.getShopmodel_size()==4){%>
	                        	    	        		<%@include file="/html/zhuanti/modelsize/shopmodel4.jsp"%>
	                        	    	        	<%}
	                        	    	        	else if(sm.getShopmodel_size()==5){%>
	                        	    	        		<%@include file="/html/zhuanti/modelsize/shopmodel5.jsp"%>
	                        	    	        	<%}
	                        	    	        	else if(sm.getShopmodel_size()==7){//240*300*4/行春节模板%>
	                        	    	        		<%@include file="/html/zhuanti/modelsize/shopmodel7.jsp"%>	
	                        	    	        	<%}
	                        	    	        	else if(sm.getShopmodel_size()==8){//200*250*4/行春节模板%>
	                        	    	        		<%@include file="/html/zhuanti/modelsize/shopmodel8.jsp"%>	
	                        	    	        	<%}else if(sm.getShopmodel_size()==9){//200*200*4/行春节模板%>
	                        	    	        		<%@include file="/html/zhuanti/modelsize/shopmodel9.jsp"%>
	                        	    	        	<%}
	                        	    	        		else if(sm.getShopmodel_size()==10 || sm.getShopmodel_size()==11 || sm.getShopmodel_size()==12 || sm.getShopmodel_size()==13){%>
	                        	    	        		<dl style="width:240px;
	                        	    	        		<%if(sm.getShopmodel_size()==10){%>height:420px;<%}//10 200*200*4/行默认模板 
	                        	    	        		else if(sm.getShopmodel_size()==11){%>height:430px;<%}//11 200*250*4 
	                        	    	        		else if(sm.getShopmodel_size()==12){%>height:490px;<%}//12 240*300*4
	                        	    	        		else if(sm.getShopmodel_size()==13){%>height:410px;<%}//13 160*160*4
	                        	    	        		%> 
	                        	    	        		
	                        	    	        		padding-left: 4px; margin-bottom: 4px;">
	                        	    	        			<dd>
	                        	    	        			<table width="240" 
	                        	    	        			<%if(sm.getShopmodel_size()==10){%>height="410"<%} 
	                        	    	        			else if(sm.getShopmodel_size()==11){%>height="430"<%}
	                        	    	        			else if(sm.getShopmodel_size()==12){%>height="490"<%}
	                        	    	        			else if(sm.getShopmodel_size()==13){%>height="280"<%}
	                        	    	        			%>
	                        	    	        			border="0" cellspacing="0" cellpadding="0" style=" background-color: #FFFFFF;">
															  <tr>
															    <td <%if(sm.getShopmodel_size()==10){%>height="200"<%} 
															    else if(sm.getShopmodel_size()==11){%>height="250"<%}
															    else if(sm.getShopmodel_size()==12){%>height="300"<%}
															    else if(sm.getShopmodel_size()==13){%>height="160"<%}
															    %>
															    colspan="3" align="center" style="position:relative">
															   	<a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank" title="<%= p.getGdsmst_gdsname()%>">
															    <%if(sm.getShopmodel_size()==10){%>
															    <img src="<%= !Tools.isNull(p.getGdsmst_imgurl())&&p.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn"%><%= Tools.isNull(p.getGdsmst_imgurl())?"":p.getGdsmst_imgurl().trim()%>" width="200" height="200" style="padding: 18px;"/>
															    <%}else if(sm.getShopmodel_size()==11){
															    if(!Tools.isNull(p.getGdsmst_img200250())){
															    %>
															    <img src="<%= !Tools.isNull(p.getGdsmst_img200250())&&p.getGdsmst_img200250().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_img200250())?"":p.getGdsmst_img200250().trim()%>" width="200" height="250">
															    <%}else{ %>
															    <img src="<%= !Tools.isNull(p.getGdsmst_imgurl())&&p.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn"%><%= Tools.isNull(p.getGdsmst_imgurl())?"":p.getGdsmst_imgurl().trim()%>" width="200" height="200" style="padding: 18px;"/>
															    <%}
															    }else if(sm.getShopmodel_size()==12){%>
															    <img src="<%= !Tools.isNull(p.getGdsmst_img240300())&&p.getGdsmst_img240300().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_img240300())?"":p.getGdsmst_img240300().trim()%>" width="240" height="300">
															    <%}else if(sm.getShopmodel_size()==13){%>
															    <img src="<%= !Tools.isNull(p.getGdsmst_recimg())&&p.getGdsmst_recimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_recimg())?"":p.getGdsmst_recimg().trim()%>" width="160" height="160" style="padding: 40px;">
															    <%}%>
															    </a>
															    <!-- <i class="hottxt" style="display: inline;">限时抢购</i> -->
															    <!-- 左上角的爆炸图 spgdsrcm_layertype 0红 1 绿 2橙 -->
														      	<%if(!Tools.isNull(sm.getShopmodel_balname())){%>
																    <i class="hottxt" style="display: inline;
																    <% if(sm.getShopmodel_balloon() == 0){%> 
																    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -0px;
																    <%}else if(sm.getShopmodel_balloon() == 1){%>
																    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -144px;
																    <%}else if(sm.getShopmodel_balloon() == 2){%>
																    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -71px;
																    <%}%>"><%=sm.getShopmodel_balname()!=null?sm.getShopmodel_balname():"" %></i>
															    <%}%>
															    </td>
															  </tr>
															  <tr>
															    <td width="20" <%if(sm.getShopmodel_size()==12){%>height="43"<%}else{%> height="30"<%}%> >&nbsp;</td>
															     <% String memprice=format_two(p.getGdsmst_memberprice());//会员价
															if(CartHelper.getmsflag(p)){
																memprice=format_two(p.getGdsmst_msprice());//秒杀价
																}
																double dl= Tools.getDouble(Tools.parseDouble(memprice)*10/p.getGdsmst_saleprice().doubleValue(),1);
														 		String fl=ProductGroupHelper.getRoundPrice((float)dl);
																%>
															    <td width="206" class="mebprice" align="left"><b><%= memprice %></b>
															    <span class="pbox_off"><%=fl%>折</span>
															    </td>
															    <td width="20">&nbsp;</td>
															  </tr>
															  <tr>
															    <td height="19">&nbsp;</td>
															    <td height="19" class="saleprice" align="left">市场价：<del><%= format_two(p.getGdsmst_saleprice().floatValue())%></del></td>
															    <td height="19">&nbsp;</td>
															  </tr>
															  <tr>
															    <td height="20">&nbsp;</td>
															    <td height="40" align="left" class="td_overfl">
															    	<a class="title" href="http://www.d1.com.cn/Product/<%= p.getId()%>" target="_blank" title="<% out.print(p.getGdsmst_gdsname());%>">
															    	<span><% out.print(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),50));  %></span>
															    	</a>
															    </td>
															    <td height="20">&nbsp;</td>
															  </tr>
															  <tr>
															    <td height="20">&nbsp;</td>
															    <td height="20" class="title2"  align="left"><!-- 商户显示商品副标题	-->
															    <a href="http://www.d1.com.cn/Product/<%= p.getId()%>" target="_blank" title="<% out.print(p.getGdsmst_title());%>">
															    <span><% String intrduce="";
															     if(!Tools.isNull(p.getGdsmst_title())){
															    	 intrduce = Tools.substring(Tools.clearHTML(p.getGdsmst_title()),60);
															     }
															     out.print(intrduce);
																%></span>
																</a>
															    </td>
															    <td height="20">&nbsp;</td>
															  </tr>
															  <tr>
															   <td>&nbsp;</td>
															    <td align="center"  <%if(sm.getShopmodel_size()==13){%>height="50px;"<%}else{%>height="55px;"<%}%>> 
																    <a id="theLink" href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank"></a>
															    </td>
															    <td>&nbsp;</td>
															  </tr>
															  <tr>
																 <td height="10">&nbsp;</td>
																 <td height="10">&nbsp;</td>
																 <td height="10">&nbsp;</td>
															 </tr>
															</table>
															</dd>
															</dl>
	                        	    	        		<%}else if(sm.getShopmodel_size()==14 || sm.getShopmodel_size()==15 || sm.getShopmodel_size()==16){%>
                        	    	        			<% long memprice=p.getGdsmst_memberprice().longValue();
												    	if(CartHelper.getmsflag(p)){
												    		memprice=p.getGdsmst_msprice().longValue();
												    	}
												    
												    	double dl= Tools.getDouble(Tools.parseDouble(memprice+"")*10/p.getGdsmst_saleprice().doubleValue(),1);
												    	String fl=ProductGroupHelper.getRoundPrice((float)dl);
												    	String intrduce="";
													    if(!Tools.isNull(p.getGdsmst_title())){
													    	intrduce = Tools.substring(Tools.clearHTML(p.getGdsmst_title()),60);
													    }
													    String req_gdsname = "";
												    	if(!Tools.isNull(p.getGdsmst_gdsname())){
												    		req_gdsname = p.getGdsmst_gdsname();
												    	}
												    	
														%>
														<%//out.print(getFenseFQModel(p,intrduce,req_gdsname,sm)) %>
														<dl class="fenfq" style="margin-bottom:15px; background-color: #FFFFFF;border:1px solid rgb(200,200,200);
                        	    	        			<%if(sm.getShopmodel_size()==14){%>margin-left:15px; width:224px; height:385px;<%}//14粉色疯抢：200*200*4
                        	    	        			else if(sm.getShopmodel_size()==15){%>margin-left:15px; width:224px; height:430px;<%}//15粉色疯抢：200*250*4
                        	    	        			else if(sm.getShopmodel_size()==16){%>margin-left:44px; width:264px; height:480px;<%}//16粉色疯抢：240*300*3
                        	    	        			%> 
                        	    	        			">
                        	    	        			 <dd>
                        	    	        			 <table border="0" cellpadding="0" cellspacing="0" style="position: relative;"
                        	    	        			 <%if(sm.getShopmodel_size()==14){%>width="224"  height="385"<%}//14粉色疯抢：200*200*4
                        	    	        			 else if(sm.getShopmodel_size()==15){%>width="224"  height="430"<%}//15粉色疯抢：200*250*4
                        	    	        			 else if(sm.getShopmodel_size()==16){%>width="264"  height="480"<%}//16粉色疯抢：240*300*3
                        	    	        			 %> 
                        	    	        			 >
                        	    	        			   <tr>
                        	    	        			   
                        	    	        			   <%if(sm.getShopmodel_size()==14){%>
                        	    	        			    <td style="padding:12px; height:200px;">
                        	    	        			    <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank" title="<%= p.getGdsmst_gdsname()%>">
                        	    	        			    <img src="<%= !Tools.isNull(p.getGdsmst_imgurl())&&p.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_imgurl())?"":p.getGdsmst_imgurl().trim()%>"/>
                        	    	        			   	</a>
                        	    	        			    </td>
                        	    	        			    <%}
                        	    	        				else if(sm.getShopmodel_size()==15){%>
															<td style="padding:12px; height:250px;">
															<a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank" title="<%= p.getGdsmst_gdsname()%>">
                        	    	        			    <% if(!Tools.isNull(p.getGdsmst_img200250())){
															    %>
                        	    	        			    <img src="<%= !Tools.isNull(p.getGdsmst_img200250())&&p.getGdsmst_img200250().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_img200250())?"":p.getGdsmst_img200250().trim()%>" width="200" height="250">
															    <%}else{ %>
															    <img src="<%= !Tools.isNull(p.getGdsmst_imgurl())&&p.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn"%><%= Tools.isNull(p.getGdsmst_imgurl())?"":p.getGdsmst_imgurl().trim()%>" width="200" height="200" style="padding: 18px;"/>
															    <%}%>
                        	    	        			    </a>
                        	    	        			    </td>		
															<%}
                        	    	        				else if(sm.getShopmodel_size()==16){%>
                        	    	        				<td style="padding:12px; height:300px;">
                        	    	        				<a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank" title="<%= p.getGdsmst_gdsname()%>">
                        	    	        			    <img src="<%= !Tools.isNull(p.getGdsmst_img240300())&&p.getGdsmst_img240300().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_img240300())?"":p.getGdsmst_img240300().trim()%>" width="240" height="300">
                        	    	        			    </a>
                        	    	        			    </td>
                        	    	        				<%}%> 
                        	    	        				</a>
                        	    	        			  </tr> 
                        	    	        			  <tr>
                        	    	        			    <td height="42" style="text-align: left; padding-left: 12px; padding-right: 12px;">
                        	    	        			  
                        	    	        			    <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank"  title="<%= p.getGdsmst_gdsname()%>">
                        	    	        			    <span style=" font-family: '微软雅黑'; font-size: 14px; line-height: 21px; padding-left: 36px;width:173px;display:block;">
                        	    	        			    	  <span class="zhekou_t" style="  color: #FFFFFF;"><%=fl%>折</span><% 
														    	out.print(Tools.substring(Tools.clearHTML(req_gdsname),42));
														    	%>
														    	</span></a>
                        	    	        			    </td>
                        	    	        			  </tr>
                        	    	        			  <tr>
                        	    	        			  <%if(sm.getShopmodel_size()!=16){%>
                        	    	         			    <td height="20" class="temaif">
                        	    	        			   <%}else{%>
                        	    	        			    <td height="20" class="temaif2">
                        	    	        			   <%}%>
                        	    	         			    <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank" title="<%= intrduce%>">
                        	    	        			    <span><%out.print(intrduce);%></span>
                        	    	        			    </td>
                        	    	        			  </tr>
                        	    	        			  <tr align="left" style="line-height: 50px;">
                        	    	        			  <%if(sm.getShopmodel_size()==16){%>
                        	    	        			   <td height="60" style="background: url('http://images.d1.com.cn/zt2014/0304/pricebg.gif')" >
                        	    	        			   <%}else{%> 
                        	    	        			   <td height="60" style="background: url('http://images.d1.com.cn/zt2014/0304/pricebg.gif') no-repeat;" >
                        	    	        			   <%}%>
                        	    	        			   <span style="color: #FFFFFF;font-size: 20px; padding-left: 6px;">￥<span style="font-size: 42px;"><%=memprice%></span></span>
                        	    	        			   <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank" title="<%= intrduce%>">
                        	    	        			   <span class="lijiqiang"></span>
                        	    	        			   </a>
                        	    	        			     </td>
                        	    	        			  </tr>
                        	    	        			  <tr>
                        	    	        			    <td height="33" align="left" style="padding-left: 12px; text-align: left;">市场价:￥<%= p.getGdsmst_saleprice().longValue() %><span style="color:#f0424e;padding-left:30px;">会员价:￥<%= p.getGdsmst_memberprice().longValue() %></span></td>
                        	    	        			  </tr>
                        	    	        			</table>
                        	    	        			</dd>
                        	    	        			</dl>
                        	    	        	<%}else{%>
		                        	    	        	<%@include file="/html/zhuanti/modelsize/shopmodelother.jsp"%>	
	                        	    	        	<%}
	                        	    	        	}
	                        	    	        	}else if(gdsidarr[m].length() == 4 || (gdsidarr[m].length()==11 && gdsidarr[m].indexOf("all")>0)
	                        	    	        			||gdsidarr[m].indexOf("$rack")>=0||gdsidarr[m].indexOf("$brand")>=0||gdsidarr[m].indexOf("$shop")>=0){//推荐位
	                        	    	        		boolean showmsflag=false;
	                                                    ArrayList<PromotionProduct> list=null; 
	                        	    	        		ArrayList<Product> pro_list=null;
	                        	    	        		int gdsnum=sm.getShopmodel_gdsnum().longValue()==0?100:sm.getShopmodel_gdsnum().intValue();
	                        	    	        		int for_num = 0;
	                        	    	        		int rckflag=0;
	                        	    	        		if(gdsidarr[m].indexOf("all")>0){//all代表读取所有的商品
	                        	    	        			pro_list=getProductList(gdsidarr[m].substring(0, 8),gdsnum);
	                        	    	        			for_num = pro_list.size();
	                        	    	        		}else if(gdsidarr[m].indexOf("$rack")>=0||gdsidarr[m].indexOf("$brand")>=0||gdsidarr[m].indexOf("$shop")>=0){//all代表读取所有的商品
	                        	    	        			
	                        	    	        			pro_list=getProductListnum(gdsidarr[m]);
	                        	    	        			for_num = pro_list.size();
	                        	    	        			rckflag=1;
	                        	    	        		}else{
	                        	    	        			list = PromotionProductHelper.getPProductByCode(gdsidarr[m],gdsnum);//取出推荐位表中的值
	                        	    	        			for_num =list==null?0:list.size();
	                        	    	        		}
	                        	              			    if((list!=null || pro_list!=null) && for_num>0){
	                        	              			    	int v = 0;
	                        	              			    	if(gdsidarr[m].indexOf("all")==-1&&rckflag==0){
				                        	    	        		SpecialProduct sp = (SpecialProduct)Tools.getManager(SpecialProduct.class).get(gdsidarr[m]);
				                        	    	        		if(sp!= null && !Tools.isNull(sp.getSprckmst_explain()) && Tools.isNumber(sp.getSprckmst_explain().trim())){	
		                        	              			    		v = Integer.valueOf(sp.getSprckmst_explain());
		                        	              			    	}
	                        	              			    	}
	                        	              			    	%><!-- 主推模板开始 -->
		                        	    	        		<%
		                        	    	        		if(v > 0){
		                        	    	        		for(int i = 0;i<v;i++){
		                        	    	        		if(list.size()==1){
		                        	    	        			i=0;
		                        	    	        		}
		                        	              			Product p=ProductHelper.getById(list.get(i).getSpgdsrcm_gdsid());//根据推荐位表得出商品表
		                        	    	        		if(p!=null&&p.getGdsmst_ifhavegds()==0&&p.getGdsmst_validflag()==1){
	                        	    	        			String rck = "";
	                        	    	        			if(!Tools.isNull(p.getGdsmst_rackcode())){
	                        	    	        				rck = p.getGdsmst_rackcode().substring(0, 3);
	                        	    	        			}
	                        	    	        			 //System.out.println("===="+rck);
		                        	    	        		
		                        	    	        		%>
		                        	    	        		<dl style="<%if(sm.getShopmodel_size()==3 || sm.getShopmodel_size()==8 || sm.getShopmodel_size()==11|| rck.equals("020")|| rck.equals("030")){%>height:290px;<%}else{%>height:270px;<%}%>width:482px;padding-left:5px;">
		                        	    	        			<dd>
		                        	    	        			<table width="484" border="0" cellpadding="0" cellspacing="0" style=" background-color: #ffffff;"
		                        	    	        			 <%//主推模板中，当类型为200*250或者分类为020，030时，调用200*250的图，否则一律调用200*200的图  
		                        	    	        			 if(sm.getShopmodel_size()==3 || sm.getShopmodel_size()==8 || sm.getShopmodel_size()==11 || rck.equals("020")|| rck.equals("030")){%>
		                        	    	        			 height="290"
		                        	    	        			 <%}else{%>height="270"<%}%>>
																  <tr valign="middle">
																    <td height="35" colspan="4">
																    <%if(CartHelper.getmsflag(p)){
																    	if(!showmsflag){
																    	showmsflag=true;
																    	}
		 												            String id =gdsidarr[m]+ p.getId();
		 												           long endt=0;
		 												    		if(p.getGdsmst_promotionend()!=null)endt=p.getGdsmst_promotionend().getTime();
		 												            %>
																	<img src="http://images.d1.com.cn/zt2014/0110/clock.gif" style="vertical-align: middle;" width="21" height="21"/>&nbsp;<span style="vertical-align: middle;font-size: 11pt;font-family: '微软雅黑'; color: #606060;"><span id="pmstime<%=id%>" /></span></span>
																	 <script type="text/javascript">
     
			                                                         setInterval("vms_time(<%=endt%>,<%=id%>)",1000);	
			                                                         </script>
																	<%}%>
																    </td>
																  </tr>
																  <tr>
																    <td width="20">&nbsp;</td>
																    <td width="222" style="position:relative">
																    <a title="<%=p.getGdsmst_gdsname()%>" href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank">
																    <%//主推模板中，当类型为200*250时，调用200*250的图，否则一律调用200*200的图
		                        	    	        			 	if(sm.getShopmodel_size()==3 || sm.getShopmodel_size()==8 || sm.getShopmodel_size()==11 || rck.equals("020")|| rck.equals("030")){%>
		                        	    	        			 		 <% if(!Tools.isNull(p.getGdsmst_img200250())){
															    %>
		                        	    	        			 		<img src="<%= !Tools.isNull(p.getGdsmst_img200250())&&p.getGdsmst_img200250().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_img200250())?"":p.getGdsmst_img200250().trim()%>" width="200" height="250" alt="<%=p.getGdsmst_gdsname().trim()%>" style="padding-right:22px;padding-bottom:4px;"/>
															    <%}else{ %>
																    	<img src="<%= !Tools.isNull(p.getGdsmst_imgurl())&&p.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_imgurl())?"":p.getGdsmst_imgurl().trim() %>" width="200" height="200" alt="<%=p.getGdsmst_gdsname().trim()%>" style="padding-right:22px; padding-bottom:27px;"/>
															    <%}%>
		                        	    	        			 	<%}else{%>
																    	<img src="<%= !Tools.isNull(p.getGdsmst_imgurl())&&p.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_imgurl())?"":p.getGdsmst_imgurl().trim() %>" width="200" height="200" alt="<%=p.getGdsmst_gdsname().trim()%>" style="padding-right:22px; padding-bottom:27px;"/>
																    <%}%>
																    </a>
																     <!-- 左上角的爆炸图 spgdsrcm_layertype 0红 1 绿 2橙 -->
															        <%if(!Tools.isNull(list.get(i).getSpgdsrcm_layertitle())){%>
																	    <i class="zhutuitxt" style="display: inline; z-index:100;
																	    <% if(list.get(i).getSpgdsrcm_layertype().indexOf("red") > -1){%> 
																	    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0; -0px;
																	    <%}else if(list.get(i).getSpgdsrcm_layertype().indexOf("green") > -1){%>
																	    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -146px;
																	    <%}else if(list.get(i).getSpgdsrcm_layertype().indexOf("orange") > -1){%>
																	    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -71px;
																	    <%}else{%>
																	    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -0px;
																	    <%}%>"><%=list.get(i).getSpgdsrcm_layertitle()!=null?list.get(i).getSpgdsrcm_layertitle():"" %></i>
																    <%}%> 
																    </td>
																    <td><table width="222" height="235" border="0" cellpadding="0" cellspacing="0">
																      <tr>
																        <td width="222" height="42" align="left"><span style=" color:#e4393c; font-size:16px; font-family:'微软雅黑';"><b>￥</b></span>&nbsp;
																        <% Long memprice1=p.getGdsmst_memberprice().longValue();
																			if(CartHelper.getmsflag(p)){
																				memprice1=p.getGdsmst_msprice().longValue();
																		}
																			double dl= Tools.getDouble(memprice1.doubleValue()*10/p.getGdsmst_saleprice().doubleValue(),1);
																		 	String fl=ProductGroupHelper.getRoundPrice((float)dl);
																		%>
																        <span style="color: #e4393c;font-size: 36px;line-height: 32px;font-family: '微软雅黑';"><b><%= memprice1%></b></span>
																        <span class="pbox_off"><%=fl%>折</span>
																        </td>
																      </tr>
																      <tr>
																        <td height="20" align="left"><span style="color: #999; font-size: 14px; font-family:'微软雅黑';">参考价：<s>￥<%=p.getGdsmst_saleprice().longValue()%></s></span></td>
																      </tr>
																      <tr>
																        <td width="222" height="50" align="left">
																        <span class="shname_text">
																		<a href="http://www.d1.com.cn/Product/<%= p.getId()%>" target="_blank" title="<% out.print(p.getGdsmst_gdsname());%>">
																    	<% //out.print(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),34));  
																    	String req_gdsname = "";
																    	if(!Tools.isNull(list.get(i).getSpgdsrcm_gdsname())){
																    		req_gdsname = list.get(i).getSpgdsrcm_gdsname();
																    	}
																    	out.print(Tools.substring(Tools.clearHTML(req_gdsname),60));
																    	%>
																    	</a>
																		</span>
																		</td>
																      </tr>
																      <tr>
																        <td width="222" height="25" align="left">
																        <a href="http://www.d1.com.cn/Product/<%= p.getId()%>" target="_blank" title="<% out.print(list.get(i).getSpgdsrcm_briefintrduce());%>">
																        	<span class="ld_intro">
																        		<% String intrduce1=list.get(i).getSpgdsrcm_briefintrduce();
																        		if(Tools.isNull(intrduce1))
																	             {
																        			intrduce1=p.getGdsmst_title();
																	             }
																    			 if(!Tools.isNull(intrduce1)){
																    	 		 intrduce1 = stringformat(intrduce1,30);
																     			}
																     			out.print(intrduce1);
																				%>
																        	</span>
																        </a>
																        </td>
																      </tr>
																       <tr><!-- 星星 -->
																       <%
																	     //评论
																	   	int contentcount =0;
																	   	ArrayList<Comment> commentlists=getCommentList(p.getId());
																	   	contentcount=commentlists.size();
																	   	//显示星级
																	   	int score = 0;
																	   	score=getLevelView1019(p.getId());
																	   	if(score==0){
																	   		score=10;
																	   	}
																       
																       %>
																        <td width="222" height="25" align="left">
																        	<!-- <div style="float:left; padding-top:6px;">顾客评分：</div> -->
																	     	<div class="sa<%=score %>" style="float:left;" ></div>
																		    <div style="float:left;padding-top:6px;">
																		    <a href="http://www.d1.com.cn/Product/<%= p.getId()%>#cmt2" rel="nofollow" target="_blank">
																		    <span style="color: #999; font-size: 12px; font-family:'微软雅黑';"><%if(contentcount>0) {%>(<%=contentcount %>条)<%} %></span>
																		    </a>
																		     &nbsp; &nbsp; &nbsp; &nbsp;
																		    
																		    </div>
																        </td>
																      </tr>
																      <tr>
																        <td height="53"><a id="now_buy" href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank"></a></td>
																      </tr>
																    </table></td>
																	<td width="20">&nbsp;</td>
																  </tr>
																</table>
		                        	    	        			</dd>
		                        	    	        			</dl>
		                        	    	        		<%}
		                        	              			}
		                        	    	        		
		                        	    	        		}%>
		                        	    	        		<!-- 主推模板结束 -->
	                        	              			    	 <%
	                        	              			    	 for(int i = v;i<for_num;i++){
	                        	              			    	 
	                        	              			    	 Product p = null;	 
	                        	              			    	 if(gdsidarr[m].indexOf("all")>0||rckflag==1){
	                        	              			    		p=ProductHelper.getById(pro_list.get(i).getId());
	                        	              			    		//System.out.println("===pro_list.get(i).getId()==="+pro_list.get(i).getId());
	                        	              			    	 }else{
	                        	              			    		p=ProductHelper.getById(list.get(i).getSpgdsrcm_gdsid());
	                        	              			    		//System.out.println("===list.get(i).getSpgdsrcm_gdsid()==="+list.get(i).getSpgdsrcm_gdsid());
	                        	              			    	 }
		                        	    	        	if(p!=null&&p.getGdsmst_ifhavegds()==0&&p.getGdsmst_validflag()==1){
		                        	    	        	c++;
		                        	    	        	if(sm.getShopmodel_size()==2){%>
		                        	    	        	<%@include file="/html/zhuanti/modelsize/shopmodel2.jsp"%>	
		                        	    	        	<%}
		                        	    	        	else if(sm.getShopmodel_size()==1){%>
		                        	    	        		<%@include file="/html/zhuanti/modelsize/shopmodel1.jsp"%>
		                        	    	        	<%}
		                        	    	        	else if(sm.getShopmodel_size()==3){%>
		                        	    	        		<%@include file="/html/zhuanti/modelsize/shopmodel3.jsp"%>
		                        	    	        	<%}
		                        	    	        	else if(sm.getShopmodel_size()==4){%>
		                        	    	        		<%@include file="/html/zhuanti/modelsize/shopmodel4.jsp"%>
		                        	    	        	<%}
		                        	    	        	else if(sm.getShopmodel_size()==5){%>
		                        	    	        		<%@include file="/html/zhuanti/modelsize/shopmodel5.jsp"%>
		                        	    	        	<%}else if(sm.getShopmodel_size()==7){//240*300*4/行春节模板%>
		                        	    	        		<%@include file="/html/zhuanti/modelsize/shopmodel7.jsp"%>	
		                        	    	        	<%}else if(sm.getShopmodel_size()==8){//200*250*4/行春节模板%>
		                        	    	        		<%@include file="/html/zhuanti/modelsize/shopmodel8.jsp"%>
		                        	    	        	<%}else if(sm.getShopmodel_size()==9){//200*200*4/行春节模板%>
		                        	    	        		<%@include file="/html/zhuanti/modelsize/shopmodel9.jsp"%>
		                        	    	        	<%}else if(sm.getShopmodel_size()==10 || sm.getShopmodel_size()==11 || sm.getShopmodel_size()==12 || sm.getShopmodel_size()==13){%>
		                        	    	        		<%
		                        	    	        		String intrduce="";
															String req_gdsname = "";
															if(gdsidarr[m].indexOf("all")==-1&&rckflag==0){
																  intrduce=list.get(i).getSpgdsrcm_briefintrduce();
													        		if(Tools.isNull(intrduce))
														             {
													        			intrduce=p.getGdsmst_title();
														             }
													    			 if(!Tools.isNull(intrduce)){
													    				 intrduce = Tools.substring(Tools.clearHTML(intrduce),60);
													     			}
															 
														    	if(!Tools.isNull(list.get(i).getSpgdsrcm_gdsname())){
														    		req_gdsname = list.get(i).getSpgdsrcm_gdsname();
																}
	                        	    	        			}else{
	                        	    	        				intrduce = pro_list.get(i).getGdsmst_title();
	                        	    	        				req_gdsname = pro_list.get(i).getGdsmst_gdsname();
	                        	    	        			}
		                        	    	        		%>
		                        	    	        		<dl style="width:240px;
		                        	    	        		<%if(sm.getShopmodel_size()==10){%>height:420px;<%}//10 200*200*4/行默认模板 
		                        	    	        		else if(sm.getShopmodel_size()==11){%>height:430px;<%}//11 200*250*4 
		                        	    	        		else if(sm.getShopmodel_size()==12){%>height:490px;<%}//12 240*300*4
		                        	    	        		else if(sm.getShopmodel_size()==13){%>height:410px;<%}//13 160*160*4
		                        	    	        		%> 
		                        	    	        	
	                        	    	        		padding-left: 4px;margin-bottom: 4px;">
		                        	    	        			<dd>
		                        	    	        			<table width="240" 
		                        	    	        			<%if(sm.getShopmodel_size()==10){%>height="410"<%} 
		                        	    	        			else if(sm.getShopmodel_size()==11){%>height="440"<%}
		                        	    	        			else if(sm.getShopmodel_size()==12){%>height="490"<%}
		                        	    	        			else if(sm.getShopmodel_size()==13){%>height="280"<%}
		                        	    	        			%>
		                        	    	        			border="0" cellspacing="0" cellpadding="0" style=" background-color: #FFFFFF;">
																  <tr>
																    <td <%if(sm.getShopmodel_size()==10){%>height="200"<%} 
																    else if(sm.getShopmodel_size()==11){%>height="250"<%}
																    else if(sm.getShopmodel_size()==12){%>height="300"<%}
																    else if(sm.getShopmodel_size()==13){%>height="160"<%}
																    %>
																    colspan="3" align="center" style="position:relative">
																   	<a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank" title="<%= p.getGdsmst_gdsname()%>">
																    <%if(sm.getShopmodel_size()==10){%>
																    <img src="<%= !Tools.isNull(p.getGdsmst_imgurl())&&p.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_imgurl())?"":p.getGdsmst_imgurl().trim()%>" width="200" height="200" style="padding: 18px;"/>
																    <%}else if(sm.getShopmodel_size()==11){
																    if(!Tools.isNull(p.getGdsmst_img200250())){
															    %>
																    <img src="<%= !Tools.isNull(p.getGdsmst_img200250())&&p.getGdsmst_img200250().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_img200250())?"":p.getGdsmst_img200250().trim()%>" width="200" height="250">
															    <%}else{ %>
																    <img src="<%= !Tools.isNull(p.getGdsmst_imgurl())&&p.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_imgurl())?"":p.getGdsmst_imgurl().trim()%>" width="200" height="200" style="padding: 18px;"/>
															    <%} 
																    }else if(sm.getShopmodel_size()==12){%>
																    <img src="<%= !Tools.isNull(p.getGdsmst_img240300())&&p.getGdsmst_img240300().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_img240300())?"":p.getGdsmst_img240300().trim()%>" width="240" height="300">
																    <%}else if(sm.getShopmodel_size()==13){%>
																    <img src="<%= !Tools.isNull(p.getGdsmst_recimg())&&p.getGdsmst_recimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_recimg())?"":p.getGdsmst_recimg().trim()%>" width="160" height="160" style="padding: 40px;">
																    <%}%>
																    </a>
																    <!-- 左上角的爆炸图 spgdsrcm_layertype 0红 1 绿 2橙 -->
																    <!-- 推荐位的商品有单设的气球和文字，优先显示，其余的一律显示shopmodel表的气球文字。 -->
															        <%if(gdsidarr[m].indexOf("all")==-1){
															        if(!Tools.isNull(list.get(i).getSpgdsrcm_layertitle())){%>
																	    <i class="hottxt" style="display: inline;
																	    <% if(list.get(i).getSpgdsrcm_layertype().indexOf("red") > -1){%> 
																	    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -0px;
																	    <%}else if(list.get(i).getSpgdsrcm_layertype().indexOf("green") > -1){%>
																	    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -144px;
																	    <%}else if(list.get(i).getSpgdsrcm_layertype().indexOf("orange") > -1){%>
																	    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -71px;
																	    <%}else{%>
																	    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -0px;
																	    <%}%>"><%=list.get(i).getSpgdsrcm_layertitle()!=null?list.get(i).getSpgdsrcm_layertitle():"" %></i>
																    <%}else if(!Tools.isNull(sm.getShopmodel_balname())){%>
																	    <i class="hottxt" style="display: inline;
																	    <% if(sm.getShopmodel_balloon() == 0){%> 
																	    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -0px;
																	    <%}else if(sm.getShopmodel_balloon() == 1){%>
																	    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -144px;
																	    <%}else if(sm.getShopmodel_balloon() == 2){%>
																	    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -71px;
																	    <%}%>"><%=sm.getShopmodel_balname()!=null?sm.getShopmodel_balname():"" %></i>
																    	<%}
															        }else{
																    	if(!Tools.isNull(sm.getShopmodel_balname())){%>
																	    <i class="hottxt" style="display: inline;
																	    <% if(sm.getShopmodel_balloon() == 0){%> 
																	    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -0px;
																	    <%}else if(sm.getShopmodel_balloon() == 1){%>
																	    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -144px;
																	    <%}else if(sm.getShopmodel_balloon() == 2){%>
																	    background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -71px;
																	    <%}%>"><%=sm.getShopmodel_balname()!=null?sm.getShopmodel_balname():"" %></i>
																    	<%}
																    	}
																    	%>
																    </td>
																  </tr>
																  <tr>
																    <td width="20" <%if(sm.getShopmodel_size()==12){%>height="43"<%}else{%> height="30"<%}%> >&nbsp;</td>
																     <% String memprice=format_two(p.getGdsmst_memberprice());
																if(CartHelper.getmsflag(p)){
																	memprice=format_two(p.getGdsmst_msprice());
																	}
																	double dl= Tools.getDouble(Tools.parseDouble(memprice) *10/p.getGdsmst_saleprice().doubleValue(),1);
																 	String fl=ProductGroupHelper.getRoundPrice((float)dl);
																	%>
																    <td width="206" class="mebprice" align="left"><b><%= memprice %></b>
																    <span class="pbox_off"><%=fl%>折</span>
																    </td>
																    <td width="20">&nbsp;</td>
																  </tr>
																  <tr>
																    <td height="19">&nbsp;</td>
																    <td height="19" class="saleprice" align="left">市场价：<del><%= format_two(p.getGdsmst_saleprice().floatValue())%></del></td>
																    <td height="19">&nbsp;</td>
																  </tr>
																  <tr>
																    <td height="20">&nbsp;</td>
																    <td height="40" align="left" class="td_overfl">
																    	<a class="title" href="http://www.d1.com.cn/Product/<%= p.getId()%>" target="_blank" title="<% out.print(p.getGdsmst_gdsname());%>">
																    	<span><%   
																    	out.print(Tools.substring(Tools.clearHTML(req_gdsname),50));
																    	%>
																    	</span>
																    	</a>
																    </td>
																    <td height="20">&nbsp;</td>
																  </tr>
																  <tr>
																    <td height="20">&nbsp;</td>
																    <td height="20" class="title2"  align="left"><!-- 商品卖点（读取spgdsrcm表中的值）  -->
																    <a href="http://www.d1.com.cn/Product/<%= p.getId()%>" target="_blank" title="<% out.print(intrduce);%>">
																    <span><% 
																     out.print(intrduce);
																	%></span>
																	</a>
																    </td>
																    <td height="20">&nbsp;</td>
																  </tr>
																  <tr>
																   <td>&nbsp;</td>
																    <td align="center"  <%if(sm.getShopmodel_size()==13){%>height="50px;"<%}else{%>height="55px;"<%}%>> 
																	    <a id="theLink" href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank"></a>
																    </td>
																    <td>&nbsp;</td>
																  </tr>
																  <tr>
																   <td height="10">&nbsp;</td>
																   <td height="10">&nbsp;</td>
																   <td height="10">&nbsp;</td>
																  </tr>
																</table>
																</dd>
																</dl>
																
		                        	    	        		<%}else if(sm.getShopmodel_size()==14 || sm.getShopmodel_size()==15 || sm.getShopmodel_size()==16){%>
		                        	    	        			<% float memprice=p.getGdsmst_memberprice();
														    	if(CartHelper.getmsflag(p)){
														    		//memprice=p.getGdsmst_msprice().longValue();
														    		memprice = p.getGdsmst_msprice();
														    	}
														    	boolean booldx=false;
														    	float dxprice=0f;
														    	if(ztid!=null&&ztid.equals("305")){
														    		
				
														    		ProductExpPrice rcmdusr=(ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_rcmid", new Long(309));
																	  //System.out.print(rcmdusr.getRcmdusr_startdate().getTime());  
																	  if(rcmdusr!=null 
																	    	&& System.currentTimeMillis()>rcmdusr.getRcmdusr_startdate().getTime() 
																	    	&& System.currentTimeMillis()<rcmdusr.getRcmdusr_enddate().getTime()
																	    	){
																	    	
																	    	ProductExpPriceItem rcmdgds=(ProductExpPriceItem)ProductExpPriceHelper.getExpPrice(p.getId(), "309");
																	    	if(rcmdgds!=null){
																	    		booldx=true;
																	    		dxprice=rcmdgds.getRcmdgds_memberprice().floatValue();
																	    	}
																	    	}														    	
														    	}
														    	
														    	
														    	double dl= Tools.getDouble(Tools.parseDouble(memprice+"")*10/p.getGdsmst_saleprice().doubleValue(),1);
														    	String fl=ProductGroupHelper.getRoundPrice((float)dl);
																String intrduce="";
																String req_gdsname = "";
																if(gdsidarr[m].indexOf("all")==-1&&rckflag==0){
																	intrduce=list.get(i).getSpgdsrcm_briefintrduce();
													        		if(Tools.isNull(intrduce))
														             {
													        			intrduce=p.getGdsmst_title();
														             }
													    			 if(!Tools.isNull(intrduce)){
													    				 intrduce = Tools.substring(Tools.clearHTML(intrduce),60);
													     			}
															    	if(!Tools.isNull(list.get(i).getSpgdsrcm_gdsname())){
															    		req_gdsname = list.get(i).getSpgdsrcm_gdsname();
																	}
		                        	    	        			}else{
		                        	    	        				intrduce = pro_list.get(i).getGdsmst_title();
		                        	    	        				req_gdsname = pro_list.get(i).getGdsmst_gdsname();
		                        	    	        			}
																%>
																<%//out.print(getFenseFQModel(p,intrduce,req_gdsname,sm)) %>
																<dl class="fenfq" style="margin-bottom:15px; background-color: #FFFFFF;border:1px solid rgb(200,200,200);
		                        	    	        			<%if(sm.getShopmodel_size()==14){%>margin-left:15px; width:224px; height:385px;<%}//14粉色疯抢：200*200*4
		                        	    	        			else if(sm.getShopmodel_size()==15){%>margin-left:15px; width:224px; height:430px;<%}//15粉色疯抢：200*250*4
		                        	    	        			else if(sm.getShopmodel_size()==16){%>margin-left:44px; width:264px; height:480px;<%}//16粉色疯抢：240*300*3
		                        	    	        			%> 
		                        	    	        			">
		                        	    	        			 <dd>
		                        	    	        			 <table border="0" cellpadding="0" cellspacing="0" style="position: relative;"
		                        	    	        			 <%if(sm.getShopmodel_size()==14){%>width="224"  height="385"<%}//14粉色疯抢：200*200*4
		                        	    	        			 else if(sm.getShopmodel_size()==15){%>width="224"  height="430"<%}//15粉色疯抢：200*250*4
		                        	    	        			 else if(sm.getShopmodel_size()==16){%>width="264"  height="480"<%}//16粉色疯抢：240*300*3
		                        	    	        			 %> 
		                        	    	        			 >
		                        	    	        			   <tr>
		                        	    	        			   <%if(sm.getShopmodel_size()==14){%>
		                        	    	        			    <td style="padding:12px; height:200px;">
		                        	    	        			    <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank" title="<%= req_gdsname%>">
		                        	    	        			    <img src="<%= !Tools.isNull(p.getGdsmst_imgurl())&&p.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_imgurl())?"":p.getGdsmst_imgurl().trim()%>" width="200" height="200"/>
		                        	    	        			    </a>
		                        	    	        			    </td>
		                        	    	        			    <%}
		                        	    	        				else if(sm.getShopmodel_size()==15){%>
																	<td style="padding:12px; height:250px;">
																	<a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank" title="<%= req_gdsname%>">
		                        	    	        			    <% if(!Tools.isNull(p.getGdsmst_img200250())){%>
		                        	    	        			    <img src="<%= !Tools.isNull(p.getGdsmst_img200250())&&p.getGdsmst_img200250().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_img200250())?"":p.getGdsmst_img200250().trim()%>" width="200" height="250">
		                        	    	        			    <%}else{ %>
		                        	    	        			    <img src="<%= !Tools.isNull(p.getGdsmst_imgurl())&&p.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_imgurl())?"":p.getGdsmst_imgurl().trim()%>" width="200" height="200"/>
																	<%} %>
		                        	    	        			    </a>
		                        	    	        			    </td>		
																	<%}
		                        	    	        				else if(sm.getShopmodel_size()==16){%>
		                        	    	        				<td style="padding:12px; height:300px;">
		                        	    	        				<a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank" title="<%= req_gdsname%>">
		                        	    	        			    <img src="<%= !Tools.isNull(p.getGdsmst_img240300())&&p.getGdsmst_img240300().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_img240300())?"":p.getGdsmst_img240300().trim()%>" width="240" height="300">
		                        	    	        			    </a>
		                        	    	        			    </td>
		                        	    	        				<%}
		                        	    	        				%> 
		                        	    	        			  </tr> 
		                        	    	        			  <tr>
		                        	    	        			    <td height="42" style="text-align: left; padding-left: 12px; padding-right: 12px;">
		                        	    	        			 <%
		                        	    	        			 Date nowday=new Date();
		                        	    	        			 int msflag=0;
		                        	    	        			 SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		                        	    	        				SimpleDateFormat gdsdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		                        	    	        			 Date sdate=null;
		                        	    	        			 	Date edate=null;	
		                        	    	        			 if(p.getGdsmst_promotionstart()!=null&&p.getGdsmst_promotionend()!=null&&p.getGdsmst_msprice()!=null){
		                        	    	        				   sdate=p.getGdsmst_promotionstart();
			                        	    	        			 	  edate=p.getGdsmst_promotionend();

		                        	    	        			 	if(Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
		                        	    	        			 			&&p.getGdsmst_msprice().floatValue()>=0f&&Tools.getDateDiff(ft.format(edate),ft.format(nowday))<2){
		                        	    	        			 		 
		                        	    	        			 	 
		                        	    	        			 	if(nowday.getTime()<sdate.getTime()){
		                        	    	        			 		msflag=1;
		                        	    	        			 	}else if(nowday.getTime()>=sdate.getTime()&&edate.getTime()>= nowday.getTime()){
		                        	    	        			 		msflag=2;	
		                        	    	        			 	}else if(nowday.getTime()>edate.getTime()||p.getGdsmst_virtualstock().longValue()<=0){
		                        	    	        			 		msflag=3;
		                        	    	        			 	}
		                        	    	        			 }
		                        	    	        			 }
		                        	    	        			
		                        	    	        			 %>
		                        	    	        			    <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank"  title="<%= req_gdsname%>">
		                        	    	        			    <span style=" font-family: '微软雅黑'; font-size: 14px; line-height: 21px; padding-left: 36px;width:173px;display:block;">
		                        	    	        			    	   <span class="zhekou_t" style="  color: #FFFFFF;">
		                        	    	        			    	   
		                        	    	        			    	   <%if(msflag==0){
                                                                             out.print(fl+"折");
		                        	    	        		                 }else{
		                        	    	        		                	 out.print("秒杀"); 
		                        	    	        		                 }
                                                                             %>
		                        	    	        			    	   </span><% 
																    	out.print(Tools.substring(Tools.clearHTML(req_gdsname),42));
																    	%>
																    	</span>
																    	</a>
		                        	    	        			    </td>
		                        	    	        			  </tr>
		                        	    	        			  <tr>
		                        	    	        			  <%if(sm.getShopmodel_size()!=16&&msflag==0){%>
		                        	    	         			    <td height="20" class="temaif">
		                        	    	        			   <%}else if(msflag==0){%>
		                        	    	        			    <td height="20" class="temaif2">
		                        	    	        			    <%}else{ %>
		                        	    	        			    <td height="20" style="color:#f0424e;">
		                        	    	        			   <%}%>
		                        	    	        			   <%//if (msflag==0){ %>
		                        	    	        			   <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank" title="<%= intrduce%>">
		                        	    	        			    <span><%out.print(intrduce);%></span>
		                        	    	        			    </a>
		                        	    	        			    <!--<%//} else if(msflag==1){%>
		                        	    	        			    <span>秒杀开始时间<%//=gdsdf.format(sdate)%></span>
		                        	    	        			    <%//} else if(msflag==2){%>
																	<span>
                                                                    <span style="vertical-align: middle;font-size: 11pt;font-family: '微软雅黑'; color: #606060;"><span id="pmstime<%//=gdsidarr[m]+p.getId()%>" /></span></span>
																	 <script type="text/javascript">
     
			                                                         //setInterval("vms_time(<%//=edate.getTime()%>,<%//=gdsidarr[m]+p.getId()%>)",1000);	
			                                                         </script></span>
			                                                          <%//} else if(msflag==3){%>
			                                                           <span>秒杀已结束</span> -->
																	<%//}%>
		                        	    	        			    </td>
		                        	    	        			  </tr>
		                        	    	        			  <tr align="left" style="line-height: 50px;">
		                        	    	        			  <%if(sm.getShopmodel_size()==16){%>
		                        	    	        			   <td height="60" style="background: url('http://images.d1.com.cn/zt2014/0304/pricebg.gif')" >
		                        	    	        			   <%}else{%> 
		                        	    	        			   <td height="60" style="background: url('http://images.d1.com.cn/zt2014/0304/pricebg.gif') no-repeat;" >
		                        	    	        			   <%}%>
		                        	    	        			   <span style="color: #FFFFFF;font-size: 20px; padding-left: 6px;">￥<span style="font-size: 42px;">
		                        	    	        			   <%//if (msflag==1){ %>
		                        	    	        			   <%//="???"%>
		                        	    	        			   <%//}else{ %>
		                        	    	        			   <!-- display price -->
		                        	    	        			   
		                        	    	        			   <%=booldx?dxprice:memprice%>
		                        	    	        			   <%//} %>
		                        	    	        			   </span></span>
		                        	    	        			   <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank">
		                        	    	        			   <% /*String jgbj="";
		                        	    	        			     if(msflag==1){ 
		                        	    	        				    	jgbj="style=\" background-image: url(http://images.d1.com.cn/images2015/act/jgstart2.jpg);\"";
		                        	    	        				    } else if(msflag==2){ 
		                        	    	        				    	jgbj="style=\" background-image: url(http://images.d1.com.cn/images2015/act/jgmid2.gif);\"";
		                        	    	        					} else if(msflag==3){ 
		                        	    	        						jgbj="style=\" background-image: url(http://images.d1.com.cn/images2015/act/jgend2.jpg);\"";
		                        	    	        					}*/
		                        	    	        					%>
		                        	    	        			       
		                        	    	        			   <span class="lijiqiang" <%//=jgbj %>></span>
		                        	    	        			    
		                        	    	        			   </a>
		                        	    	        			     </td>
		                        	    	        			  </tr>
		                        	    	        			  <tr>
		                        	    	        			    <td height="33" align="left" style="padding-left: 12px; text-align: left;">市场价:￥<%= p.getGdsmst_saleprice().longValue() %><span style="color:#f0424e;padding-left:30px;">会员价:￥<%= p.getGdsmst_memberprice().longValue() %></span></td>
		                        	    	        			  </tr>
		                        	    	        			</table>
		                        	    	        			</dd>
		                        	    	        			</dl>
		                        	    	        	<%}else{%>
			                        	    	        <%@include file="/html/zhuanti/modelsize/shopmodelother.jsp"%>	
		                        	    	        	<%}
		                        	    	        	}
	                        	    	        		
	                        	              			    }
	                        	    	        			}
	                        	    	        		
	                        	    	        	}	
	                        	    	        }//>0
	                        	    	    	}
	                        	    	  }
	                        	      }
	                        	   %>
	                        	</div> 
	                         <%}%>
	                 </div> 
	                 </div>  
	    		  <% }
	    	   }
	       }
	   %>
   <div class="clear"></div>
   <%if(si.getShopinfo_ztimglist()!=null){
       String sigdsidlist_top=si.getShopinfo_ztimglist();
       if(sigdsidlist_top.length()>0){%>
	  <div class="bottom">
	      <div class="b_left">	
	      <div class="mbllistt">店内分类</div>
	      <div class="classList">
	       <%
	          List<ShopRck> shoprcklist=getShopRckList(shopcode,0);
		      if(shoprcklist!=null){%>
		    	  <div class="water"></div>
		    	  <ul class="foldheader1">
	    	   	   <li class="parent">
						<a href="http://www.d1.com.cn/shopresult.jsp?productsort=20130113&sc=<%=shopcode%>" target="_blank">▼全部商品</a>
				   </li>
				  
		    	    <%for(ShopRck sprck:shoprcklist){
		    	   	String shoprck_id= sprck.getId();
		    	   	%>		    	   	
		    	   	   
		    	   	   <li class="parent"><a id="nocolor">▼<%= sprck.getShoprck_name() %></a></li>
		    	   	<%
		    	   	    List<ShopRck> shoprcklist2=getShopRckList(shopcode,Tools.parseInt(sprck.getId()));
		    	   	    int parentnum=0;
		    	  	    if(shoprcklist2!=null){
		    	  	         parentnum=shoprcklist2.size();  
		    	  	    }
		                if(shoprcklist2!=null){
		    	   		    int inum=0;
		    	         for(ShopRck sprck2:shoprcklist2){
		    	       	     shoprck_id= sprck2.getId();
		    	       	     
                             %><li><a href="http://www.d1.com.cn/shopresult.jsp?productsort=<%=shoprck_id %>&sc=<%=shopcode %>"  target="_blank">>&nbsp;<%=sprck2.getShoprck_name() %></a></li>
                           
							<%
							   inum++;
						 }
					     }
		                %>
						<%}%>
		                </ul>
						<%  
							   }
							%>
      </div>
	              
<br/>
<br/>
</div>
	       <div class="b_right">
	          <div class="b_title">
	               &nbsp;&nbsp;店铺主推
	          </div>
	          <div class="imglist">
	             <%if(si.getShopinfo_ztimglist()!=null){
	             String sigdsidlist=si.getShopinfo_ztimglist();
	               if(sigdsidlist.length()>0){
	            	   String[] gdsidarr=sigdsidlist.split(",");
	                   if(gdsidarr.length>0){
	                	   int count=0;
	                	   for(int z=0;z<gdsidarr.length;z++){
	                	   if(gdsidarr[z].length() == 8){
		                       if(gdsidarr[z].length()>0){
		                    	   count++;
	                                 Product p=ProductHelper.getById(gdsidarr[z]);
		                        	 if(p!=null&&p.getGdsmst_ifhavegds()==0&&p.getGdsmst_validflag()==1){
		                        	 if(count%4!=0){
		                        	 %>
		                        	    <dl style="margin-right:5px;"> 
		                        	<%}else
		                        		{%>
		                        		 <dl style="margin-right:0px;"> 
		                        		<%}%>
		                        	     <dt style="background:#fff;">
										  <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank">
										  <img src="<%= !Tools.isNull(p.getGdsmst_imgurl())&&p.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_imgurl())?"":p.getGdsmst_imgurl().trim()%>" width="200" height="200"></a>
										 </dt>
										 <dd style="width:200px;margin:0px;">
										 <span style="color:#8b8b8b;">
										 <font style="display:block; width:85%;font-size:12px; margin:0px auto;">
									       <%=Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),50)%>
		                                 </font>
										 <% 
										 float hyprice = 0;
										 float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
											if(CartHelper.getmsflag(p)){
												memprice=Tools.getFloat(p.getGdsmst_msprice(),1);%>	
										 <font style="color:#7c7c7c;">促销价：</font>									 
										 <%}
										 %>	<font style="font-family:'微软雅黑'; color:#b80024; font-size:14px;"><b>￥<%= memprice %></b></font></span>
										 </dd>		         
										</dl>
		                        	 <%	}
		                        	    	        	
		                        }
	                   }else if(gdsidarr[z].length() == 4){
	                	   ArrayList<PromotionProduct> list=PromotionProductHelper.getPProductByCode(gdsidarr[z],300);
               			   ArrayList gdsidlist=new ArrayList();
              			    if(list!=null && list.size()>0){
              			 	for(PromotionProduct pProduct:list){
              			 		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
              			 	}
              			 	if(gdsidlist!=null && gdsidlist.size()>0){
	                	    ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
	           		 	    if(productlist!=null){
	           		 		for(Product p:productlist){
	                    	    count++;
	                        	 if(p!=null){
	                        	 if(count%4!=0){
	                        	 %>
	                        	    <dl style="margin-right:5px;"> 
	                        	<%}else
	                        		{%>
	                        		 <dl style="margin-right:0px;"> 
	                        		<%}%>
	                        	     <dt style="background:#fff;">
									  <a href="http://www.d1.com.cn/Product/<%=p.getId()%>" target="_blank">
									 <img src="<%= !Tools.isNull(p.getGdsmst_imgurl())&&p.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_imgurl())?"":p.getGdsmst_imgurl().trim()%>" width="200" height="200"></a>
										 </dt>
										 <dd style="width:200px;margin:0px;">
										 <span style="color:#8b8b8b;">
										 <font style="display:block; width:85%;font-size:12px; margin:0px auto;">
									       <%=Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),50)%>
		                                 </font>
										 <% 
										 float hyprice = 0;
										 float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
											if(CartHelper.getmsflag(p)){
												memprice=Tools.getFloat(p.getGdsmst_msprice(),1);%>	
										 <font style="color:#7c7c7c;">促销价：</font>									 
										 <%}
										 %>	<font style="font-family:'微软雅黑'; color:#b80024; font-size:14px;"><b>￥<%= memprice %></b></font></span>
										 </dd>		         
										</dl>
	                        	 <%	}
	           		 		}
	           		 	   }
	                    }
	           		 }
	    
	                   }	    	     
	                }
	            }
	         }
  }
	      %>
	          </div>
	          
	          
	          <div class="clear"></div>
	          <div class="b_title">
	               &nbsp;&nbsp;新品上架
	          </div>
	          <div class="imglist">
	             <% ArrayList<Product> plist=new ArrayList<Product>();
	                plist=getProductList(shopcode,12);  
	             if(plist.size()>0)
	               {
	                	   int count=0;
	                       for(Product p:plist){
		                       if(p!=null)
		                       {
		                    	   count++;                                 
		                        	 if(count%4!=0){
		                        	 %>
		                        	    <dl style="margin-right:5px;"> 
		                        	<%}else
		                        		{%>
		                        		 <dl style="margin-right:0px;"> 
		                        		<%}%>
		                        	     <dt style="background:#fff;">
										  <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank">
										  <img src="<%= !Tools.isNull(p.getGdsmst_imgurl())&&p.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_imgurl())?"":p.getGdsmst_imgurl().trim()%>" width="200" height="200"></a>
										 </dt>
										 <dd style="width:200px;margin:0px;">
										 <span style="color:#8b8b8b;">
										 <font style="display:block; width:85%;font-size:12px; margin:0px auto;">
									       <%=Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),50)%>
		                                 </font>
										 <% 
										 float hyprice = 0;
										 float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
											if(CartHelper.getmsflag(p)){
												memprice=Tools.getFloat(p.getGdsmst_msprice(),1);%>	
									 <font style="color:#7c7c7c;">促销价：</font>									 
									 <%}
									 %><font style="font-family:'微软雅黑'; color:#b80024; font-size:14px;"><b>￥<%= memprice %></b></font></span>
										 </dd>		         
										</dl>
		                       <%	}
		                       
	                         }  
	            }
	      %>
	          </div>
	      
	      </div>
	     
	      </div>
	
  <%}
    }
  }
  }
%>
<br/><br/>
</div>
</div>
<%@include file="/inc/foot.jsp"%>

</body>
</html>

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js") %>"></script>

<script type="text/javascript" language="javascript">
  $(document).ready(function() {
        $(".imglist").find("img").lazyload({ effect: "show", placeholder: "http://images.d1.com.cn/Index/images/grey.gif",threshold : 200 });
	    $(".zblist").find("img").lazyload({ effect: "show", placeholder: "http://images.d1.com.cn/Index/images/grey.gif",threshold : 200 });
	    
	});
  

  
</script>
