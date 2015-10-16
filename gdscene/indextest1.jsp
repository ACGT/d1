<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/html/zt2012/public.jsp" %>
<%!
//根据场景表里的搭配编号，获取搭配列表
private static ArrayList<Gdscoll> getGdscolllist(String gdscollid)
{
	ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
	if(gdscollid==null||gdscollid.length()<=0)
	{
		return null;
	}
	gdscollid=gdscollid.replace('，', ',');
	String[] newstr=gdscollid.split(",");
	int j=0;
	for(int i=0;i<newstr.length;i++)
	{
		Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(newstr[i]);
		if(gdscoll!=null)
		{
			j++;
			if(j>15)
			{
				break;
			}
			list.add(gdscoll);
			
		}
	}
	
    return list;
	
}



//获取其他配件（就是搭配详细里不显示的商品）
private static ArrayList<Gdscolldetail> getOtherGdscoll(String gdscollid)
{
	ArrayList<Gdscolldetail> list=new ArrayList<Gdscolldetail>();
	if(Tools.isNull(gdscollid)||!Tools.isNumber(gdscollid))
	{
		return null;
	}
    ArrayList<Gdscolldetail> glist=GdscollHelper.getGdscollBycollid1(gdscollid);
    if(glist!=null&&glist.size()>0)
    {
    	for(Gdscolldetail gd:glist)
    	{
    		if(gd!=null&&gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==0)
    		{
    			if(gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
    			{
	    			Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
	    			if(p!=null&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0&&ProductStockHelper.canBuy(p))
	    			{
	    			  list.add(gd);
	    			}
    			}
    		}
    	}
    }
    return list;
}

//根据场景里的系列编号获取同意系列下的所有场景
private static ArrayList<Gdsscene> getAllGBySserid(String gdsserid)
{
    	if(Tools.isNull(gdsserid)||gdsserid.length()<=0||!Tools.isNumber(gdsserid))
    	{
    		return null;
    	}
    	ArrayList<Gdsscene> glist=new ArrayList<Gdsscene>();
        List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
        clist.add(Restrictions.eq("gdsscene_flag",new Long(1)));
        clist.add(Restrictions.eq("gdsscene_gdserid",new Long(gdsserid)));
    	clist.add(Restrictions.ge("gdsscene_status", new Long(1)));
    	
    	List<Order> olist=new ArrayList<Order>();
    	olist.add(Order.asc("gdsscene_status"));
    	olist.add(Order.desc("gdsscene_createdate"));
    	List<BaseEntity> blist=Tools.getManager(Gdsscene.class).getList(clist,olist,0,100);
    	if(blist!=null)
    	{
    		for(BaseEntity be:blist)
    		{
    			if(be!=null)
    			{
    				glist.add((Gdsscene)be);
    			}
    		}
    	}    	
    	return glist;
}
%>
<%

    String id="";
    if(request.getParameter("id")!=null&&request.getParameter("id").length()>0&&Tools.isNumber(request.getParameter("id")))
    {
    	id=request.getParameter("id");
    }
    Gdsscene gdsscene=new Gdsscene();
    if(id.length()>0){
	       gdsscene=(Gdsscene)Tools.getManager(Gdsscene.class).get(id);
    }
    else
    {
    	return;
    }
   
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>D1优尚网-<% if(gdsscene!=null) out.print(gdsscene.getGdsscene_title()); %></title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gdsmst.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/gdsscene.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />

<style type="text/css">
body{ background:#fff;}
.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}
    a img{ border:none;}
    .gdscene_center{ margin:0px auto; background:#fff;}
    .gdscene_top{ margin:0px auto; background-image:url(http://images.d1.com.cn/images2012/index2012/czdhbg.gif);height:37px;}
    #dh{ margin:0px auto; width:950px; padding-left:30px;background-image:url(http://images.d1.com.cn/images2012/index2012/zhbg.gif); height:37px; overflow:hidden; }
    #dh a{ color:#000000; margin-right:10px; margin-left:10px; font-size:12px; line-height:37px; text-decoration:none;}
    #dh a:hover{ color:#a22d48;}
    #dh img{ line-height:37px;}
    .gdscsne_logo{ margin:0px auto; width:980px; position:relative; height:547px; overflow:hidden;}
    .pricegd{background-color: #fff;width:160px; filter: alpha(opacity=80);-moz-opacity: 0.8;opacity: 0.8; height:240px;position:absolute; bottom:50px; left:120px;  z-index:99; border:solid 1px #ccc;   }
    .pricegd span{margin:0px auto; width:100%; display:block; height:20px;  font-size:12px; padding-left:5px; line-height:20px; _line-height:20px;   }
    .pricegd div span a{color:#000;}
    .pricegd span .font1{ color:#be0000; }
    .pricegd span .font2{ color:#000; }
    .pricegd .newspan{background:#be0000; color:#fff; font-family:'微软雅黑'; font-weight:bold; height:25px; line-height:25px;} 
    .gdscsne_dp{width:980px; margin:0px auto; overflow:hidden; padding-top:10px; padding-bottom:10px;}
    .gdscsne_dp ul{ margin:0px; padding:0px; list-style:none; padding-left:10px; padding-right:10px;}
    .gdscsne_dp ul li{float:left; width:316px; height:380px; margin-right:6px; overflow:hidden; margin-bottom:10px; z-index:1000;}
    .gdtj{width:980px; overflow:hidden; margin:0px auto;  margin-top:10px;  }
    .list{ margin:0px auto; width:980px; overflow:hidden;background-color:#CCCCCC; margin:0px; padding-bottom:15px; }
    .list ul{ width:950px; margin:0px auto; overflow:hidden; list-style:none; padding:0px;  }
    .list ul li{ width:230px; background:#fff; float:left; margin-right:10px; margin-top:10px; padding-top:10px; padding-bottom:10px;}
    .list ul li div{ width:200px; margin:0px auto;}
    
  
    .otherpjf{  background-color: #000; height:auto;position:absolute; border:solid 1px #ccc; margin-left:260px; margin-top:-257px; +margin-left:240px; z-index:10000;  display:none;padding-left:10px;}
    .otherpjf1{ background-color: #000;  height:auto;position:absolute;  border:solid 1px #ccc; margin-left:-40px; margin-top:-241px; z-index:10000; display:none; padding-left:10px; }
    
    .otherpjf a{ color:#000;}
    
    .pricegds{background-color: #fff; filter: alpha(opacity=90);-moz-opacity: 0.9;opacity: 0.9;width:160px; position:absolute; bottom:27px; left:450px;  z-index:99; border:solid 1px #fff;   }
    .pricegds span{margin:0px auto; width:100%; display:block; height:20px;  font-size:12px; padding-left:5px; line-height:20px; _line-height:20px;   }
    .pricegds div span a{color:#000;}
    .pricegds span .font1{ color:#be0000; }
    .pricegds span .font2{ color:#000; }
    .otherpjfs{  background-color: #000; height:auto;position:absolute; border:solid 1px #fff; margin-left:540px; margin-top:-225px; +margin-top:275px; +margin-left:200px; z-index:10000;  display:none;padding-left:10px;}
    .otherpjfs a{ color:#000;}
    .font1{ color:#be0000;}
    .font2{ color:#000;}
  
    #focus {width:493px; height:130px; overflow:hidden; position:relative; }
    #focus ul { width:530px; position:absolute; list-style:none; padding:0px;}
	#focus ul li {float:left; width:82px; overflow:hidden; position:relative;  margin-right:8px; text-align:center; padding-top:15px;}
	#focus ul li img { border:solid 1px #fff; margin:0px; padding:0px;}
	#focus ul li div {position:absolute; overflow:hidden;}
	#focus .preNext {width:18px; height:18px; position:absolute; top:65px;  cursor:pointer;}
	#focus .pre2012 {left:0;}
	#focus .next2012 {right:0;}
	
	#focus ul li div a{ text-decoration:none; color:#fff;}
	#focus ul li div a:hover{ text-decoration:underline;}

    .des{ background:#000; filter: alpha(opacity=80);-moz-opacity: 0.8;opacity: 0.8;   width:78px; left:2px; text-align:right; color:#fff; line-height:25px; font-size:12px;  top:85px;  }
  
  .detail_gdscoll{ width:980px; margin-top:1px;}
	.gdscollleft{ width:600px; margin:7px;  float:left; }
	.gdscollright{ width:360px; float:left; margin-top:7px; margin-bottom:7px;}
	.gdscollright1{ width:360px; float:left;  margin:7px; _margin:4px;}
	.gdscollleft1{ width:600px; float:left; margin-top:7px; margin-bottom:7px; }
	.gdscollleft ul{ list-style:none; width:600px; margin:0px; padding:0px;}
	.gdscollleft ul li{ height:108px; font-size:12px; color:#333; overflow:hidden; font-weight:none; text-align:left; }
	.gdscollleft ul li span{ display:block; height:128px; overflow:hidden;  padding-top:4px; padding-left:30px; float:left; color:#010004; }
	.gdscollleft ul li img{ border:solid 1px #000;}
	.gdscollleft ul li div{ float:left; width:220px; margin-left:18px; height:108px; line-height:18px;}
	.gdscollleft ul li div span{ display:block; height:auto; overflow:hidden; padding-left:0px; width:210px;}
	.gdscollleft ul li div .span1_1{ padding-top:2px;  width:250px;}
	.gdscollleft ul li div .span2_1{ padding-top:4px; width:250px;}
	.gdscollleft ul li div .span3_1{ padding-top:4px;  padding-left:0px;width:250px;}
	.span3_1 a{float:left; margin-right:6px; display:block;}
	
	.gdscollleft1 ul{ list-style:none; width:600px; margin:0px; padding:0px;}
	.gdscollleft1 ul li{ height:108px; font-size:13px; color:#333; overflow:hidden; text-align:left; }
	.gdscollleft1 ul li span{ display:block; height:128px; overflow:hidden;  padding-top:4px; padding-left:30px; float:left; color:#010004;}
	.gdscollleft1 ul li img{ border:solid 1px #000;}
	.gdscollleft1 ul li div{ float:left; width:220px; margin-left:18px; height:108px; line-height:18px;}
	.gdscollleft1 ul li div span{ display:block; height:auto; overflow:hidden; padding-left:0px; }
	.gdscollleft1 ul li div .span1_1{ padding-top:2px; width:250px; }
	.gdscollleft1 ul li div .span2_1{ padding-top:4px; width:250px;}
	.gdscollleft1 ul li div .span3_1{ padding-top:4px; padding-left:0px; width:250px;}
	.clear{ clear:both;font-size:1px;line-height:0;height:0px;*zoom:1; float:none;}
	.textdiv{ width:320px;height:8px; padding-left:25px; padding-right:15px; padding-top:22px; line-height:18px;text-align:left;}
	.textdiv font{ color:#333; }

    .gdscollleft1 ul li div .sq{position:absolute; margin-left:396px;margin-left:396px\0; _margin-left:-24px;+margin-left:146px; +margin-top:-92px;  _margin-top:-66px;display:none;}
    .gdscollleft ul li div .sq{position:absolute; margin-left:396px;margin-left:396px\0; _margin-left:-24px; +margin-left:146px; +margin-top:-92px;  _margin-top:-66px;display:none;}
  
</style>

</head>
<body>
<%@include file="/inc/head.jsp" %>
   <%  
	      if(gdsscene!=null)
	      {
	   %>
     <div class="gdscene_center">
      <%    
	      ArrayList<Gdscoll> gdscolllist=new ArrayList<Gdscoll>();
          ArrayList<Gdscolldetail> gdlist1=new ArrayList<Gdscolldetail>();
	      gdscolllist=getGdscolllist(gdsscene.getGdsscene_gdscollid());  
	      
	      if(gdsscene.getGdsscene_logo()!=null&&gdsscene.getGdsscene_logo().longValue()==0)
	      {%>
	    	 <div class="gdscsne_logo">
                <a href="<% if(gdsscene.getGdsscene_url()!=null&&gdsscene.getGdsscene_url().length()>0) { out.print(gdsscene.getGdsscene_url());} else { out.print("/gesscene/index.jsp?id="+gdsscene.getId()); }%>" target="_blank">
                <img src="http://images1.d1.com.cn<%= gdsscene.getGdsscene_imgurl() %>" width="980" height="547"/></a>
                     <%
	          //获取场景缩略图
	          if(gdsscene.getGdsscene_gdserid()!=null&&Tools.isNumber(gdsscene.getGdsscene_gdserid().toString()))
	          {
	        	  String serid=gdsscene.getGdsscene_gdserid().toString();
	        	  Gdsser g=(Gdsser)Tools.getManager(Gdsser.class).get(serid);
	        	  if(g!=null)
	        	  {
	        		  ArrayList<Gdsscene> glist=getAllGBySserid(serid);
	        		  int pos=815;
	        		  if(glist!=null&&glist.size()>1)
	        		  {
	        			  int count=0;
	        		       if(glist.size()<=5)
	        		       {
	        		    	   if(glist.size()>1)
	        		    	   {
	        		    		   pos=800-glist.size()*62;
	        		    	   }
	        		       }
	        		  %>
	        			       <div id="focus" style="bottom:130px;<% if(glist.size()<=5) out.print("right:-"+pos+"px;"); else out.print("left:420px;");%>">
         <div  id="focus1" style="position:relative; width:448px; overflow:hidden; height:130px; margin-left:25px;">
         <ul id="sec_list">
         <% 
             for(Gdsscene gt:glist)
        	 {
        	     count++;
        	     String imgurl="";
        	     if(gt.getGdsscene_scalimg()!=null&&gt.getGdsscene_scalimg().length()>0)
        	     {
        	    	 imgurl=gt.getGdsscene_scalimg();
        	     }
        	     if(gt.getId().equals(gdsscene.getId()))
        	     {%>
        	    	 <li ><div style="position:absolute; top:20px;+top:16px; left:36px;" id="floatdiv"><img src="http://images.d1.com.cn/images2012/index2012/three.png" style="border:none;" />
        	    	           	    	 </div>
        	     <%}
        	     else
        	     {%>
        	    	<li> 
        	     <%}
        	      if(gt.getGdsscene_status().longValue()==1&&!gt.getId().equals(gdsscene.getId()))
        	      {
        	          if(gt.getGdsscene_mode()!=null&&gt.getGdsscene_mode().longValue()==2){
        	      %>
        	    	  <a href="http://scene.d1.com.cn/sceneindexother.htm?id=<%=gt.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=imgurl %>" width="80" height="80" style="margin-top:15px;" id="fimg<%=count %>"/></a>
        	       
        	      <%  }
        	          else
        	          {%>
        	        	  <a href="http://scene.d1.com.cn/sceneindex.htm?id=<%=gt.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=imgurl %>" width="80" height="80" style="margin-top:15px;" id="fimg<%=count %>"/></a>
        	       
        	          <%}
        	      }
        	      else
        	      {%>
        	    	  <a href="javascript:void(0)"><img src="http://images1.d1.com.cn<%=imgurl %>" width="80" height="80" style="margin-top:15px;" id="fimg<%=count%>"/></a>
        	    	  
        	      <%}
        	     %>
        	         <div id="fdiv<%=count %>" style="top: 32px; left: 1px; width: 80px; height: 80px; position: absolute;  background-color: rgb(0, 0, 0); cursor: pointer;filter: alpha(opacity=30);-moz-opacity: 0.3; opacity: 0.3; display:none;  " ></div>
        	    	 <div class="des"><%= gt.getGdsscene_scaldes() %>&nbsp;&nbsp;</div>
                	 </li>
        	 <%}
         %>		 
         </ul>
		 </div>
		 <%  if(glist.size()>5){ %>
		 <div class='preNext pre2012'>
		 <img id="tprev1" src="http://images.d1.com.cn/images2012/index2012/jtl11.png" width="18" height="18"/>
		 </div>
		 <div class='preNext next2012' >
		 <img src="http://images.d1.com.cn/images2012/index2012/jtr11.png" height="18" width="18"/>
         </div>
         <%}  %>
	     </div>
	        		  <%}
	        	  }
	          }
	     %>  
             </div>  
	      <%}
	      else
	      {	      
	      if(gdscolllist!=null&&gdscolllist.size()>0&&gdscolllist.get(0)!=null)
	      {
	         Gdscoll tg=gdscolllist.get(0);
	      %>
	    <div class="gdscsne_logo" <% if(gdsscene.getGdsscene_imgurl()!=null&&gdsscene.getGdsscene_imgurl().length()>0) out.print("style=\"background:url('http://images1.d1.com.cn"+gdsscene.getGdsscene_imgurl()+"') no-repeat; margin-top:10px; height:505px; padding-left:60px; width:920px;\""); %>>
          <a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%= tg.getId() %>&sf=<%=id %>" target="_blank">
          <%  if(tg.getGdscoll_bigimgurl()!=null&&tg.getGdscoll_bigimgurl().length()>0)
        	  {%>
        	   <img src="http://images1.d1.com.cn<%= tg.getGdscoll_bigimgurl() %>"  />
        	  <%}%>
         </a>
        
        
	      <%
		      ArrayList<Gdscolldetail> nogdlist=getOtherGdscoll(tg.getId());
	          gdlist1=GdscollHelper.getGdscollBycollid(tg.getId());
	          if(gdlist1!=null&&gdlist1.size()>0)
	          {
	        	    float sum=0f;
			        float zhprice=0;
			        int counts=0;
			      %>
	           
		    	   <div class="pricegds">
		    	   <div style="width:95%;  margin:0px auto; height:80px; padding-top:4px;  overflow:hidden;">
		    	   <%
		    	       for(Gdscolldetail gd:gdlist1)
		    	       {
		    	    	   Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
		    	    	   if(p!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1&&ProductStockHelper.canBuy(p))
		    	    	   {
		    	    		   counts++;
		    	    		   sum+=p.getGdsmst_memberprice().floatValue();
		    	    		   zhprice+=Tools.getFloat((int)(p.getGdsmst_memberprice().floatValue()*0.95), 2);
		    	    		   %>
		    	    		   <span><a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank" style="color:#333"><%= gd.getGdscolldetail_title() %></a>:<font class="font1">￥<%= (int)Math.ceil(p.getGdsmst_memberprice().floatValue())%></font>&nbsp;&nbsp;&nbsp;&nbsp;
		    	    		      <input type='hidden' class="a0" value="<%= p.getId() %>"/>
		    	    		     <a href="javascript:void(0)" attr="<%= p.getId() %>" onclick="AddGdscollInCart(this);" ><img src="http://images.d1.com.cn/images2012/index2012/buy.gif" style="vertical-align:text-bottom;"/></a>
	        			    	 
		    	    		   </span>
		    	    	   <%}
		    	       }
		    	   %>
		    	   </div>
		    	   <%
	        			    	       if(nogdlist!=null&&nogdlist.size()>0)
	        			    	       {%>
	        			    	    	   <span style="height:28px; line-height:28px;background:#000; color:#fff; cursor:hand;  width:95%; padding-left:0px; margin-bottom:4px; filter: alpha(opacity=80);-moz-opacity: 0.8;opacity: 0.8;" onmouseover="gdscollover('<%= tg.getId() %>')" onmouseout="gdscollout('<%= tg.getId() %>')">&nbsp;&nbsp;&nbsp;&nbsp;+&nbsp;&nbsp;选择其他配件>></span>
	        			    	       <%}
	        			    	       
	        			    	   %>
	        			    	   
		    	    <div style="padding-top:0px; border-top:solid 1px #ccc;margin:0px auto;overflow:hidden; text-align:left; line-height:20px; padding-top:5px; padding-left:11px;color:#000;">
	        			    	       共<em id="amount1"><%= counts%></em>件 <br/>                                      			  
	                                <strike>总价：￥<font id="memberP1"><%=(int)sum %></font></strike><br/>组合价：<b>￥<font style='color:#be0000; font-size:14px;' id="pktP1"><%= (int)zhprice %></font></b><br/>共优惠：￥<font id="cheap1"><%= (int)(sum-zhprice) %></font>
	                              
	                                 <span style="margin-top:5px; padding-left:1px; margin-bottom:10px; height:26px; ">
	                <a href="javascript:void(0)" code="<%= tg.getId() %>" onclick="check_gdscoll1(this,'0')" style="color:#fff; font-size:14px;"><img src="http://images.d1.com.cn/images2012/index2012/zhgm.png"/></a></span>
	                               </div>
	        			    	   </div>
	        			    	   
	       
	      <%
		        			  if(nogdlist!=null&&nogdlist.size()>0)
		        			  {
		        			   %>
		        				  <div class="otherpjfs" id="other_<%= tg.getId() %>" onmouseover="gdscollover(<%= tg.getId() %>)" onmouseout="gdscollout(<%= tg.getId() %>)" >
	        			            <table  style="text-align:center; background:#fff;  padding-right:10px;">
		        				 <% for(Gdscolldetail gdetail:nogdlist)
		        				  {
		        					  if(gdetail!=null)
		        					  {
		        					      if(gdetail!=null&&gdetail.getGdscolldetail_gdsid()!=null&&gdetail.getGdscolldetail_gdsid().length()>0)
		        					      {
		        					    	  Product pro=ProductHelper.getById(gdetail.getGdscolldetail_gdsid());
		        					    	  {
		        					    		 if(pro!=null&&pro.getGdsmst_ifhavegds().longValue()==0&&pro.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(pro))
		        					    		 {
		        					    			 
		        					    			   String imgurl="";
		        					    		       ArrayList<GdsCutImg> gcilist=getByGdsid(pro.getId());
		        					    		       if(gcilist!=null&&gcilist.size()>0&&gcilist.get(0)!=null)
		        					    		       {
		        					    		    	   if(gcilist.get(0).getGdscutimg_100()!=null&&gcilist.get(0).getGdscutimg_100().length()>0)
		        					    		    	   {
		        					    		    		   imgurl="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_100();
		        					    		    	   }
		        					    		    	   else
		        					    		    	   {
		        					    		    		   imgurl=ProductHelper.getImageTo80(pro);
		        					    		    	   }
		        					    		       }
		        					    		       else
		        					    		       {
		        					    		    	   imgurl=ProductHelper.getImageTo80(pro);
		        					    		       }%>
		        					    		       
		        					    		           <tr><td  width="30" height="60">
		        					    		           <input type="checkbox" name="chk_0" value="<%= gdetail.getGdscolldetail_gdsid() %>" onClick="selectInitdp('<%=Tools.getFormatMoney(pro.getGdsmst_memberprice())%>',this.checked,1)" /></td><td width="60"><img src="<%= imgurl %>" width="50" height="50"/></td>
	        			                                   <td style="text-align:left;"><a href="http://www.d1.com.cn/product/<%= gdetail.getGdscolldetail_gdsid() %>" target="_blank"><%= gdetail.getGdscolldetail_title() %></a><br/>
	        			                                   <font class="font1">￥<%=  Tools.getFormatMoney(pro.getGdsmst_memberprice().floatValue()) %></font>&nbsp;&nbsp;&nbsp;&nbsp;
	        			                                   </td>
	        			                                   <td>  <a href="javascript:void(0)" attr="<%= pro.getId() %>" onclick="AddGdscollInCart(this);" ><img src="http://images.d1.com.cn/images2012/index2012/buy.gif" style="vertical-align:text-bottom;"/></a>
	        			    	</td>
	        			                                   <td width="10"></td>
	        			                                   </tr>
		        					    		 <%}
		        					         }
		        					      }
		        					  }
		        				  }
		        				 %>
		        				 </table>
		        				 </div>
		        				 <%
		        			  }
	          }
	        			  %>
	     <%
	          //获取场景缩略图
	          if(gdsscene.getGdsscene_gdserid()!=null&&Tools.isNumber(gdsscene.getGdsscene_gdserid().toString()))
	          {
	        	  String serid=gdsscene.getGdsscene_gdserid().toString();
	        	  Gdsser g=(Gdsser)Tools.getManager(Gdsser.class).get(serid);
	        	  if(g!=null)
	        	  {
	        		  ArrayList<Gdsscene> glist=getAllGBySserid(serid);
	        		  int pos=815;
	        		  if(glist!=null&&glist.size()>1)
	        		  {
	        		       if(glist.size()<=5)
	        		       {
	        		    	   if(glist.size()>1)
	        		    	   {
	        		    		   pos=800-glist.size()*62-30;
	        		    	   }
	        		       }
	        		       int count=0;
	        		  %>
	     <div id="focus" style="bottom:130px;<% if(glist.size()<=5) out.print("right:-"+pos+"px;"); else out.print("left:420px;");%>">
         <div  id="focus1" style="position:relative; width:448px; overflow:hidden; height:130px; margin-left:25px;">
         <ul id="sec_list">
         <%  for(Gdsscene gt:glist)
        	 {
        	    count++;
        	     String imgurl="";
        	     if(gt.getGdsscene_scalimg()!=null&&gt.getGdsscene_scalimg().length()>0)
        	     {
        	    	 imgurl=gt.getGdsscene_scalimg();
        	     }
        	     //System.out.print(gt.getId()+"nnnn"+gdsscene.getId());
        	     if(gt.getId().equals(gdsscene.getId()))
        	     {%>
        	    	  <li><div style="position:absolute; top:20px;+top:16px; left:36px;" id="floatdiv"><img src="http://images.d1.com.cn/images2012/index2012/three.png" style="border:none;" /></div>
        	     <%}
        	     else
        	     {%>
        	    	<li> 
        	     <%}
        	      if(gt.getGdsscene_status().longValue()==1)
        	      {
        	         if(!gt.getId().equals(gdsscene.getId())){
        	        	 if(gt.getGdsscene_mode()!=null&&gt.getGdsscene_mode().longValue()==2){
        	      %>
        	    	  <a href="http://scene.d1.com.cn/sceneindexother.htm?id=<%=gt.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=imgurl %>" width="80" height="80" style="margin-top:15px;" id="fimg<%=count%>"/></a>
        	       
        	      <%  }
        	        	 else{%>
        	        		  <a href="http://scene.d1.com.cn/sceneindex.htm?id=<%=gt.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=imgurl %>" width="80" height="80" style="margin-top:15px;" id="fimg<%=count%>"/></a>
        	       
        	        	 <%}
        	     }
        	      else
        	      {%>
        	    	  <a href="javascript:void(0)"> <img src="http://images1.d1.com.cn<%=imgurl %>" width="80" height="80" style="margin-top:15px;" id="fimg<%=count%>"/></a>
        	        	
        	      <%}
        	     }
        	      else
        	      {%>
        	    	  <a href="javascript:void(0)"> <img src="http://images1.d1.com.cn<%=imgurl %>" width="80" height="80" style="margin-top:15px;" id="fimg<%=count%>"/></a>
        	      <%}
        	     %>
        	       <div id="fdiv<%=count %>" style="top: 32px; left: 1px; width: 80px; height: 80px; position: absolute;  background-color: rgb(0, 0, 0); cursor: pointer;filter: alpha(opacity=30);-moz-opacity: 0.3; opacity: 0.3; display:none;  " ></div>
        	       <div class="des"><%= gt.getGdsscene_scaldes() %>&nbsp;&nbsp;</div>
                	 </li>
        	 <%}
         %>		 
         </ul>
         </div>
         <%  if(glist.size()>5){ %>
		 
		 <div class='preNext pre2012'>
		 <img id="tprev1" src="http://images.d1.com.cn/images2012/index2012/jtl11.png" width="18" height="18"/>
		 </div>
		 <div class='preNext next2012' >
		 <img src="http://images.d1.com.cn/images2012/index2012/jtr11.png" height="18" width="18"/>
         </div>
         <%} %>
	     </div>
	        		  <%}
	        	  }
	          }
	     %>  
	   </div>
	   <div class="clear"></div>
	   <%       
	      }
	      }
	 
      %>     
       <div style="width:980px; margin:0px auto;">
       <%= getGdscollInGdsscene(gdsscene) %>
       </div>
       
       <div class="clear"></div>
       <div class="gdtj">
          <div class="list">
          <img src="http://images.d1.com.cn/images2012/index2012/gdtj2012.jpg"/>
           <% request.setAttribute("code",gdsscene.getGdscene_gdscode().trim());
               request.setAttribute("length","60");%>
          <jsp:include   page= "/gdscene/public.jsp"   />
          </div>
       </div>
   </div>
   <%       }
	   %>
   <div class="clear"></div>
   <!-- 底部 -->
   <%@ include file="/inc/foot.jsp" %>
   <!-- 底部结束 -->
   
</body>
</html>

<script> 
$(function() { 
	count=0;
    $("#sec_list").find("li").each(function() { 
       $(this).hover(function() {
        	$("#sec_list").find("div").css("display","block");
        	var obj=$(this).find("a img").attr('id').replace("fimg","fdiv");        	
        	$("#"+obj).css("display","none");
       },
       function(){
    	   for(i=1;i<=$("#sec_list").find("li").length;i++)
    		   {
    		   $("#fdiv"+i).css("display","none");
    		   }
    	  
       }); 
    }); 

}) ;

</script> 
