<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
public static List<Product> getSgHotList(){
	
	List<Product> list=new ArrayList<Product>();
	SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));
	clist.add(Restrictions.eq("sggdsdtl_mailflag", new Long(1)));
	clist.add(Restrictions.le("sggdsdtl_cls", new Long(4)));
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.desc("sggdsdtl_sort"));
	olist.add(Order.desc("sggdsdtl_sdate"));
	
	List<BaseEntity> blist=Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 100);
	if(blist!=null){
		for(BaseEntity be:blist){
			SgGdsDtl sg=(SgGdsDtl)be ;
			Product p=ProductHelper.getById(sg.getSggdsdtl_gdsid());
		   	Date sdate=p.getGdsmst_promotionstart();
          	Date edate=p.getGdsmst_promotionend();	
			if(p.getGdsmst_validflag().longValue()==1&&sdate!=null
					&&((edate.getTime()>(new Date()).getTime())||(sdate.getTime()<(new Date()).getTime()&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31))){
				list.add(p);
			}
		}
	}
	return list;
}
public static List<Product> getSgHotList2(){
	
	List<Product> list=new ArrayList<Product>();
	SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));
	clist.add(Restrictions.eq("sggdsdtl_cls", new Long(7)));

	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("sggdsdtl_sort"));
	olist.add(Order.desc("sggdsdtl_sdate"));
	
	List<BaseEntity> blist=Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 6);
	if(blist!=null){
		for(BaseEntity be:blist){
			SgGdsDtl sg=(SgGdsDtl)be ;
			Product p=ProductHelper.getById(sg.getSggdsdtl_gdsid());
		   	Date sdate=p.getGdsmst_promotionstart();
          	Date edate=p.getGdsmst_promotionend();	
			if(p.getGdsmst_validflag().longValue()==1&&sdate!=null
					&&((edate.getTime()>(new Date()).getTime())&&(sdate.getTime()<(new Date()).getTime()&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31))){
				list.add(p);
			}
		}
	}
	return list;
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/jquery-1.3.2.min.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<title>优尚大促节 --D1优尚</title>
<style>
body{background:#f5ce1b}
.banner328{
	background-image: url(http://images.d1.com.cn/zt2014/07/0708/ysdqj_01.jpg);
	background-repeat: no-repeat;
	background-position: center;
	height:452px;
}


.sg_list {
	width: 980px; overflow:hidden;
}
.sg_list ul li{
	width: 318px;
	height:485px;
	border: 1px solid #ebebeb;
	background:#fff;
	margin-top:8px;
}
.sg_list ul li.l {
	float:left; margin-right:10px; 
}
.sg_list ul li.r {
	 float:right;
}
.sg_list ul li.l_soldout {
	float:left; margin-right:10px;
	filter: alpha(opacity=50);
	-moz-opacity: 0.5;
	opacity: 0.5;
	 
}
.sg_list ul li.r_soldout {
	 float:right;
	 filter: alpha(opacity=50);
	 -moz-opacity: 0.5;
	 opacity: 0.5;
}
.sg_list ul li .sgl_item .i_img {
	text-align: center; position:relative;
}
.sg_list ul li .sgl_item .i_img .ii_f{
	position:absolute;
	bottom:10px;
	right:15px;
	font-size:36px;
	background-image: url(http://images.d1.com.cn/images2014/index/index_iconnew.png);
	background-position: 0px 0px;
	width:47px;height:54px; color:#fff;
	text-align:left;
	padding-top:3px;padding-left:10px;
	
}
.li_nogds{
	position:absolute;
	bottom:70px;
	right:80px;
	background-image: url(http://images.d1.com.cn/zt2014/0220qc/end_sale.png);
	filter: alpha(opacity=100);
	-moz-opacity: 10;
	opacity: 10;
	background-position: 0px 0px;
	width:150px;height:135px; color:#fff;
	text-align:left;
	padding-top:3px;padding-left:10px;
	
}
.sg_list ul li .sgl_item .i_img .ii_f .z{ position:absolute; bottom:13px; right:6px; font-size:18px; width:21px; height:21px;}
.sg_list ul li .sgl_item .i_title {
	height: 67px; color:#333333; line-height:21px;padding:12px 14px 0px  14px;font-family:微软雅黑;
	text-align: left;
}
.sg_list ul li .sgl_item .i_title  .tt{font-size:16px;}
.sg_list ul li .sgl_item .i_title .gkey{ /*color:#f3a96e;*/ color:#f0424e; font-size:12px;width: 292px;display:block;overflow:hidden;white-space:nowrap;word-break:keep-all;}

.sg_list ul li .sgl_item .i_price {
	background-image: url(http://images.d1.com.cn/images2014/index/indexsg_bg.jpg);
	background-repeat: no-repeat;
	height:96px;
}
.sg_list ul li .sgl_item .i_price .num {
	float: left;
	width: 130px;
	padding-left:10px;
	padding-top: 30px;
	font-size: 20px;
	line-height: 28px;
	color: #fff;
	font-family:微软雅黑;
}
.sg_list ul li .sgl_item .i_price .pp{ float:right; width:125px; padding-right:5px;padding-top:18px;font-family:微软雅黑;}
.sg_list ul li .sgl_item .i_price .pp .s{ color:#f0424e; font-size:48px; line-height:46px; font-weight:800}
.sg_list ul li .sgl_item .i_price .pp .m{ color:#fff; font-size:14px; line-height:16px;}


.i_price_new {
background-image: url(http://images.d1.com.cn/zt2014/06/red.png);
background-repeat: repeat;
height: 70px;

}
.i_price_newbg {
background-image: url(http://images.d1.com.cn/zt2014/06/green.png);
background-repeat: repeat;
height: 70px;
}

.lijiqiang {
position: absolute;
width: 140px;
height: 65px;
right:0px;
bottom: 50px;
}

.shouqing{
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/shouqingbig.png);
background-repeat: no-repeat;
background-position: 0px 0px;
width: 126px;
height: 47px;
right:17px;
bottom: 60px;
}

.s2_1 {
color: #FFFFFF;
font-size: 43px;
line-height: 43px;
padding-left: 16px;
/*vertical-align: bottom;*/
font-family: 'arial';
display: block;
height: 38px;
padding-top: 5px;
}

.s3{
color: #f7949b;
font-size: 10px;
padding-left: 21px;
vertical-align: top;
font-family: '微软雅黑';
}
.s3new{
color: #fcbf9c;
font-size: 10px;
padding-left: 21px;
vertical-align: top;
font-family: '微软雅黑';
}
.zhekou_t {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/checknap.png);
background-position: 0px 0px;
width: 39px; height: 18px;
left:12px;
bottom: 165px;
}
.mj_list {
	width: 980px; overflow:hidden;
}
.mj_list ul li{
	width: 237px;
	height:385px;
	border: 1px solid #ebebeb;
	background:#fff;
	margin-top:8px;
}
.mj_list ul li {
	float:left; margin-right:8px; 
}
.mj_list ul li.r {
	 float:right;margin-right:0;
}
</style>
</head>
<body style="background:#ff9000;">
<!--头部-->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束-->
<div class="banner328">
</div>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="5"><img src="http://images.d1.com.cn/zt2014/07/0708/ysdqj_03.jpg" width="980" height="138" /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/zt2014/07/0708/ysdqj_05.jpg" width="195" height="127" /></td>
    <td><img src="http://images.d1.com.cn/zt2014/07/0708/ysdqj_06.jpg" width="196" height="127" /></td>
    <td><img src="http://images.d1.com.cn/zt2014/07/0708/ysdqj_07.jpg" width="197" height="127" /></td>
    <td><img src="http://images.d1.com.cn/zt2014/07/0708/ysdqj_08.jpg" width="196" height="127" /></td>
    <td><img src="http://images.d1.com.cn/zt2014/07/0708/ysdqj_09.jpg" width="196" height="127" /></td>
  </tr>
  <tr>
    <td colspan="5"><img src="http://images.d1.com.cn/zt2014/07/0708/ysdqj_10.jpg" width="980" height="73" /></td>
  </tr>
  <tr>
    <td colspan="5">
    <div class="sg_list" id="sg_list"> 
     <ul>
      <%
    List<Product> hotlist= getSgHotList2();
   
    if(hotlist!=null&&hotlist.size()>0){
    	 StringBuilder sb=new StringBuilder();
    	    SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
    	    int i=0;
    for(Product product:hotlist){
    	
    	
    	String gdsid = product.getId();
    	
    	SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", gdsid);

 		boolean ismiaoshao=false;
        if(product==null)continue;
        Date nowday=new Date();
        if(product.getGdsmst_promotionstart()!=null&&product.getGdsmst_promotionend()!=null&&product.getGdsmst_msprice()!=null){
        	Date sdate=product.getGdsmst_promotionstart();
        	Date edate=product.getGdsmst_promotionend();	
        	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
        			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
        			&&product.getGdsmst_msprice().floatValue()>=0f){
        		ismiaoshao = true;
        	}
        }
  
         if(!ismiaoshao)continue;
         long gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
         long gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum().longValue();
        long buynum= sg.getSggdsdtl_vbuynum().longValue()+sg.getSggdsdtl_vusrnum().longValue();

         if (gdsnum<=0||gdsnum2<=0 ||product.getGdsmst_validflag().longValue()==2){
         	  gdsnum=0;
         	 buynum= sg.getSggdsdtl_vallnum().longValue();
         }
         double dl= Tools.getDouble(product.getGdsmst_msprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
	 	 String fl=ProductGroupHelper.getRoundPrice((float)dl);
	 	 if(fl.length()==1){
	 		fl = fl+".0";
	 	 }
         i++;
         String gdstitle=sg.getSggdsdtl_gdsname();
         if (gdstitle!=null&&gdstitle.length()>32){
        	 gdstitle=gdstitle.substring(0,32);
         }
         String gdsmemo=sg.getSggdsdtl_memo();
         if (gdsmemo!=null&&gdsmemo.length()>25){
        	 gdsmemo=gdsmemo.substring(0,25);
         }
         String theimgurl=product.getGdsmst_img310();
         if(!Tools.isNull(theimgurl)){
 			if(theimgurl.startsWith("/shopimg/")){
 				theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
 			}else{
 				theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
 			}
 			}
         
         if(gdsnum > 0){
        		if(i%3==0){
            	 sb.append("<li class=\"r\" style=\"height:515px\">");
             }else{
            	 sb.append("<li class=\"l\" style=\"height:515px\">");
             }
	         }else{
	        	if(i%3==0){
               	 sb.append("<li class=\"r_soldout\" style=\"height:515px\">");
             }else{
               	 sb.append("<li class=\"l_soldout\" style=\"height:515px\">");
             }
	      }
         
      	 sb.append("<div class=\"sgl_item\" style=\"position: relative;\">");
     	 sb.append("<div class=\"i_img\">");
     	 sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+sg.getSggdsdtl_gdsname()+"\">");
     	 sb.append("<img style=\"padding-top:4px;padding-bottom:4px;\" src=\""+theimgurl+"\" width=\"310\" height=\"310\">");
     	 sb.append("</a>");
     	 /*sb.append("<div class=\"ii_f\">5<span class=\"z\">折</span></div>");*/
     	 if(gdsnum <= 0){
      	   sb.append("<div class=\"li_nogds\"></div>");
      	 }
     	 sb.append("</div>");
         sb.append("<div class=\"i_title\">");
         sb.append("<span class=\"zhekou_t\" style=\"  color: #FFFFFF;\">"+fl+"折</span>");
         sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+sg.getSggdsdtl_gdsname()+"\">");
         sb.append("<span  class=\"tt\" style=\"padding-left: 40px;\">"+gdstitle+"</span><br />");
         sb.append("</a>");
         sb.append("<span class=\"gkey\">"+gdsmemo+"</span>"); 
         sb.append("</div>");
		 sb.append("<div style=\"height:117px;\">");
		  
		 sb.append("<div class=\"i_price_new\">");
		 sb.append("<span class=\"s2_1\"><font style=\"font-size:22px; font-family: '微软雅黑';\">￥ </font>"+product.getGdsmst_msprice()+"</span>");
		 sb.append("<span class=\"s3\"><del>市场价：￥"+product.getGdsmst_saleprice().longValue()+"</del></span>");
		 sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\" \">");
		 sb.append("<span class=\"lijiqiang\"></span>");
		 sb.append("</a>");
		 sb.append("</div>");
		 sb.append("<div style=\"height:47px; vertical-align: middle;padding-top:10px;\">");
		 sb.append("<span style=\"padding-left:16px;padding-right:105px;\">已有&nbsp;"+(buynum)+"人购买</span>");
		 sb.append("<span style=\"font-family:'微软雅黑'; font-size:12pt;\">仅剩余&nbsp;<span style=\"color:#F0424E; font-size:14pt;\">"+gdsnum+"</span>件</span>");
		 sb.append("</div>");
		 
		 sb.append("</div>");
		 sb.append("</div>");
		 sb.append("</li>");
    }
    out.println(sb.toString());
    }
    
    %>
  </ul>
    </div>
    </td>
  </tr>
  <tr>
    <td colspan="5"><img src="http://images.d1.com.cn/zt2014/07/0708/ysdqj_12.jpg" width="980" height="60" /></td>
  </tr>
  <tr>
    <td colspan="5">
    <div class="sg_list" id="sg_list"> 
     <ul>
    <%
    List<Product> hotlist2= getSgHotList();
   
   
    if(hotlist2!=null&&hotlist2.size()>0){
    	 StringBuilder sb=new StringBuilder();
    	 SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
    	    int i=0;
    for(Product product:hotlist2){
    	
    	
    	String gdsid = product.getId();
    	
    	SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", gdsid);

 		boolean ismiaoshao=false;
        if(product==null)continue;
        Date nowday=new Date();
        if(product.getGdsmst_promotionstart()!=null&&product.getGdsmst_promotionend()!=null&&product.getGdsmst_msprice()!=null){
        	Date sdate=product.getGdsmst_promotionstart();
        	Date edate=product.getGdsmst_promotionend();	
        	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
        			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
        			&&product.getGdsmst_msprice().floatValue()>=0f){
        		ismiaoshao = true;
        	}
        }
  
         if(!ismiaoshao)continue;
         long gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
         long gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum().longValue();
        long buynum= sg.getSggdsdtl_vbuynum().longValue()+sg.getSggdsdtl_vusrnum().longValue();

         if (gdsnum<=0||gdsnum2<=0 ||product.getGdsmst_validflag().longValue()==2){
         	  gdsnum=0;
         	 buynum= sg.getSggdsdtl_vallnum().longValue();
         }
         double dl= Tools.getDouble(product.getGdsmst_msprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
	 	 String fl=ProductGroupHelper.getRoundPrice((float)dl);
	 	 if(fl.length()==1){
	 		fl = fl+".0";
	 	 }
         i++;
         String gdstitle=sg.getSggdsdtl_gdsname();
         if (gdstitle!=null&&gdstitle.length()>32){
        	 gdstitle=gdstitle.substring(0,32);
         }
         String gdsmemo=sg.getSggdsdtl_memo();
         if (gdsmemo!=null&&gdsmemo.length()>25){
        	 gdsmemo=gdsmemo.substring(0,25);
         }
         String theimgurl=product.getGdsmst_img310();
         if(!Tools.isNull(theimgurl)){
 			if(theimgurl.startsWith("/shopimg/")){
 				theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
 			}else{
 				theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
 			}
 			}
         
         if(gdsnum > 0){
        		if(i%3==0){
            	 sb.append("<li class=\"r\" style=\"height:515px\">");
             }else{
            	 sb.append("<li class=\"l\" style=\"height:515px\">");
             }
	         }else{
	        	if(i%3==0){
               	 sb.append("<li class=\"r_soldout\" style=\"height:515px\">");
             }else{
               	 sb.append("<li class=\"l_soldout\" style=\"height:515px\">");
             }
	      }
         
      	 sb.append("<div class=\"sgl_item\" style=\"position: relative;\">");
     	 sb.append("<div class=\"i_img\">");
     	 sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+sg.getSggdsdtl_gdsname()+"\">");
     	 sb.append("<img style=\"padding-top:4px;padding-bottom:4px;\" src=\""+theimgurl+"\" width=\"310\" height=\"310\">");
     	 sb.append("</a>");
     	 /*sb.append("<div class=\"ii_f\">5<span class=\"z\">折</span></div>");*/
     	 if(gdsnum <= 0){
      	   sb.append("<div class=\"li_nogds\"></div>");
      	 }
     	 sb.append("</div>");
         sb.append("<div class=\"i_title\">");
         sb.append("<span class=\"zhekou_t\" style=\"  color: #FFFFFF;\">"+fl+"折</span>");
         sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+sg.getSggdsdtl_gdsname()+"\">");
         sb.append("<span  class=\"tt\" style=\"padding-left: 40px;\">"+gdstitle+"</span><br />");
         sb.append("</a>");
         sb.append("<span class=\"gkey\">"+gdsmemo+"</span>"); 
         sb.append("</div>");
		 sb.append("<div style=\"height:117px;\">");
		  
		 sb.append("<div class=\"i_price_newbg\">");
		 sb.append("<span class=\"s2_1\"><font style=\"font-size:22px; font-family: '微软雅黑';\">￥ </font>"+product.getGdsmst_msprice()+"</span>");
		 sb.append("<span class=\"s3\"><del>市场价：￥"+product.getGdsmst_saleprice().longValue()+"</del></span>");
		 sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\" \">");
		 	sb.append("<span class=\"lijiqiang\"></span>");

		 sb.append("</a>");
		 sb.append("</div>");
		 sb.append("<div style=\"height:47px; vertical-align: middle;padding-top:10px;\">");
		 sb.append("<span style=\"padding-left:16px;padding-right:105px;\">已有&nbsp;"+(buynum)+"人购买</span>");
		 sb.append("<span style=\"font-family:'微软雅黑'; font-size:12pt;\">仅剩余&nbsp;<span style=\"color:#F0424E; font-size:14pt;\">"+gdsnum+"</span>件</span>");
		 sb.append("</div>");
		 
		 sb.append("</div>");
		 sb.append("</div>");
		 sb.append("</li>");
    }
    out.println(sb.toString());
    }
 
    %></ul>
    </div>
    </td>
  </tr>
  <tr>
    <td colspan="5"><img src="http://images.d1.com.cn/zt2014/07/0708/ysdqj_14.jpg" width="980" height="66" /></td>
  </tr>
  <tr>
    <td colspan="5">
    <div class="mj_list">
    	<ul>
    	<%
    	List<Promotion> plist= PromotionHelper.getBrandListByCode("3712",100);
    	if(plist!=null&&plist.size()>0){
    		String cli="";
    		int i=0;
    		for(Promotion pm:plist){
    			cli="";
    			 i++;
    			if(i%4==0){
    				cli="class=\"r\"";
    			}
    			
    			
    			%>
    			<li <%=cli %> >
    			<a href="<%=pm.getSplmst_url()%>" target="_blank">
    			<img src="<%=pm.getSplmst_picstr() %>" border="0" />
    			</a>
                </li>
    	
    	<%}
    	}%>
        	
        </ul>
    </div>
    </td>
  </tr>
</table>
<%@include file="/inc/foot.jsp"%>
</body>
</html>
