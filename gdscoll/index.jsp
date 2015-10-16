<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>

<%!
/**
	 * 根据物品对象获得物品所在的组
	 * @param product - 物品对象
	 * @return GoodsGroup
	 */
	public static GoodsGroup getGroup(Product product){
		if(product == null) return null;
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdsgrpdtl_gdsid", product.getId()));
		
		List list = Tools.getManager(GoodsGroupDetail.class).getList(listRes, null, 0, 1);
		
		if(list == null || list.isEmpty()) return null;
		
		GoodsGroupDetail gd = (GoodsGroupDetail)list.get(0);
		
		long ggId = Tools.longValue(gd.getGdsgrpdtl_mstid());
		if(ggId <= 0) return null;
		
		return (GoodsGroup)Tools.getManager(GoodsGroup.class).get(String.valueOf(ggId));
	}
/**
 * 根据分组对象获得此物品的所在分组的列表
 * @param GoodsGroup - 分组对象
 * @return List<GoodsGroupDetail>
 */
public static List<GoodsGroupDetail> getGroupDetail(GoodsGroup gg){
	if(gg == null) return null;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdsgrpdtl_mstid", new Long(gg.getId())));
	
	List list = Tools.getManager(GoodsGroupDetail.class).getList(listRes, null, 0, 100);
	
	if(list == null || list.isEmpty()) return null;
	
	int size = list.size();
	
	List<GoodsGroupDetail> ggdList = new ArrayList<GoodsGroupDetail>();
	for(int i=0;i<size;i++){
		GoodsGroupDetail ggd = (GoodsGroupDetail)list.get(i);
		Product goods = ProductHelper.getById(ggd.getGdsgrpdtl_gdsid());
		if(goods == null) continue;
		
		ggdList.add(ggd);
	}
	//只有一件物品了，也就没必要显示出来了。
	if(ggdList.size() <= 1) return null;
	
	return ggdList;
}


private static ArrayList<GdsCutImg> getByGdsid(String gdsid){
	ArrayList<GdsCutImg> list=new ArrayList<GdsCutImg>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_gdsid", gdsid));
	List<BaseEntity> b_list = Tools.getManager(GdsCutImg.class).getList(clist, null, 0,1);
	if(b_list==null || b_list.size()==0) return null;		
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((GdsCutImg)be);
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
 %>
<%
String id="";
if(request.getParameter("id")!=null&&request.getParameter("id").length()>0&&Tools.isNumber(request.getParameter("id")))
{
	id=request.getParameter("id");
}
Gdscoll gdscoll=new Gdscoll();
if(id!=null&&id.length()>0&&Tools.isNumber(id))
{
	gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(id);  
}
else return;
Gdsser gdsser=new Gdsser();
ArrayList<Gdscolldetail> gdlist =new ArrayList<Gdscolldetail>();
if(gdscoll!=null)
{

	
	if(gdscoll.getGdscoll_serid()!=null&&gdscoll.getGdscoll_serid().toString().length()>0&&Tools.isMath(gdscoll.getGdscoll_serid().toString()))
	{
		gdsser=(Gdsser)Tools.getManager(Gdsser.class).get(gdscoll.getGdscoll_serid().toString());
	}
}
else return;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>D1优尚网-<%= gdscoll.getGdscoll_title() %></title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/gdscoll.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/gdscoll.css")%>" rel="stylesheet" type="text/css" media="screen" />

</head>
<body>
<%@include file="/inc/head.jsp" %>
   <div class="gdscoll_center">
   <%  if(id!=null&&id.length()>0&&Tools.isMath(id)&&gdscoll!=null)
	   {%>
	   <%
          String url="";
          String sex=gdscoll.getGdscoll_cate().toString();
          if(gdsser.getGdsser_brandid().toString().equals("987"))
          {
        	  if(sex.equals("1"))
        	  {
        	     url="http://www.d1.com.cn/brand/feelmind/series.jsp?sex=1&";
        	  }
        	  else
        	  {
        		  url="http://www.d1.com.cn/brand/feelmind/series.jsp?sex=2&";
        	  }
          }
          else if(gdsser.getGdsser_brandid().toString().equals("1690"))
          {
        	  url="http://www.d1.com.cn/brand/aleeishe/series.jsp?";
          }
          else if(gdsser.getGdsser_brandid().toString().equals("1969"))
          {
        	  url="http://www.d1.com.cn/brand/sheromo/series.jsp?";
          }
          else
          {
        	  if(sex.equals("1"))
        	  {
        	     url="http://www.d1.com.cn/brand/feelmind/series.jsp?sex=1&";
        	  }
        	  else
        	  {
        		  url="http://www.d1.com.cn/brand/feelmind/series.jsp?sex=2&";
        	  }
          }
          url+="serid="+gdsser.getId().toString();
        	  
       %>
       <div class="dh">
			<img src="http://images.d1.com.cn/images2012/New/product/green.gif" width="20" height="35" align="top" style="margin-top:-10px;_margin-top:-12px;" />
			<a href="http://www.d1.com.cn/" target="_blank">首页</a>
			<%
			   Gdscoll scoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(id) ;
			   if(scoll!=null){
				 Gdsser g=GdsserHelper.getById(scoll.getGdscoll_serid().toString());
				 if(g!=null){
				 String brand="";
				 String brandname="";
				 String ppurl="";
				
				 if("987".equals(g.getGdsser_brandid().trim())) 
					 {
					    brand="feelmind";
					    brandname="Feel Mind";
					    ppurl="/brand/feelmind/man.jsp";
					 }
		
				 else if("1690".equals(g.getGdsser_brandid().trim())){
					 brand="aleeishe";
					 brandname="小栗舍";
					 ppurl="/brand/aleeishe/";
				 }
				 else if("1969".equals(g.getGdsser_brandid().trim())){
					 brand="sheromo";
				     brandname="诗若漫";
				     ppurl="/brand/sheromo/";
				 }
				 
		
			%>
			&nbsp;&nbsp;>&nbsp;&nbsp;<a href="<%= ppurl %>" target="_blank"><%= brandname %></a>
			&nbsp;&nbsp;>&nbsp;&nbsp;<a href="<%= url %>" target="_blank"><%= g.getGdsser_title() %></a>
			&nbsp;&nbsp;>&nbsp;&nbsp;<a href="/gdscoll/index.jsp?id=<%= id %>" target="_blank"><%= gdscoll.getGdscoll_title() %></a>
			<%} 
			}
			%>
			
	 	</div>    
       <div class="left">
       <div style="position:relative; height:231px; z-index:999;">
       <a href="<%= url%>" target="_blank"><img src="<% 
       if(gdsser!=null&&gdsser.getGdsser_timg()!=null){
    	  String gdsser_timg=gdsser.getGdsser_timg();
		 if(gdsser_timg!=null&&gdsser_timg.startsWith("/shopimg/gdsimg")){
			 gdsser_timg = "http://images1.d1.com.cn"+gdsser_timg;
				}else{
					gdsser_timg = "http://images.d1.com.cn"+gdsser_timg;
				}
    	   out.print(gdsser_timg); 
       }
    	   %>" style="position:absolute;" width="286" height="231"/></a>
       </div>
       <div class="otherdp">
       <%  
           String sf="";
           if(request.getParameter("sf")!=null&&request.getParameter("sf").length()>0)
           {
        	   sf=request.getParameter("sf");
           }
       
       %>
       <span>同<% if(sf.length()>0){ out.print("场景");} else { out.print("系列");}%>搭配</span>
       <div class="dplist">
       
       <%
          if(sf.length()>0&&Tools.isMath(sf))
          {
        	 
        	  Gdsscene gdsscene=(Gdsscene)Tools.getManager(Gdsscene.class).get(sf);
        	  if(sf!=null)
        	  {
        		    String gdscollid=gdsscene.getGdsscene_gdscollid().replace('，', ',');
        			String[] newstr=gdscollid.split(",");
        			String psmallimgurl="";
        			for(int i=0;i<newstr.length;i++)
        			{
        				Gdscoll g=(Gdscoll)Tools.getManager(Gdscoll.class).get(newstr[i]);
        				if(g!=null&&!g.getId().equals(id)&&g.getGdscoll_flag().longValue()==1)
        				{
        					int count=0;
        					ArrayList<Gdscolldetail> gdetaillist=GdscollHelper.getGdscollBycollid1(g.getId());
							if(gdetaillist!=null)
							{
								for(Gdscolldetail gd:gdetaillist)
								{
									Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
									if(p!=null&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
										count++;
									}
								}
							}
							psmallimgurl=g.getGdscoll_smallimgurl();
							 if(psmallimgurl!=null&&psmallimgurl.startsWith("/shopimg/gdsimg")){
								 psmallimgurl = "http://images1.d1.com.cn"+psmallimgurl;
									}else{
										psmallimgurl = "http://images.d1.com.cn"+psmallimgurl;
									}
							
							if(count>1){
							
        				%>
        					<table height="188">
           	             <tr><td width="88"><a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%= g.getId() %>&sf=<%=sf %>" target="_blank">
           	             <img src="<%= psmallimgurl %>" width="88" height="127"/></a></td>
           	                 <td>
           	               <%
           	                 gdlist=GdscollHelper.getGdscollBycollid(g.getId());
   	         			      if(gdlist!=null&&gdlist.size()>0)
   	         			      {
   	         			    	  for(Gdscolldetail gd:gdlist)
   	         			    	  {
   	         			    		  if(gd!=null&&gd.getGdscolldetail_gdsflag().longValue()==1)
   	         			    		  {
   	         			    			  Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
   	         			    			  if(p!=null)
   	         			    			  {
   	         			    				  %>
   	         			    				  <% if(gd.getGdscolldetail_title()!=null) out.print(gd.getGdscolldetail_title()); %>:￥<%= (int)Math.ceil(p.getGdsmst_memberprice().floatValue()) %><br/>
   	         			    			  <%}
   	         			    		  }
   	         			    	  }
   	         			      }
           	               %>           
           	              <br/>
           	                     <a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%= g.getId() %>&sf=<%= sf %>" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/look.jpg" width="65" heihgt="25"/></a>
           	                 </td>
           	             </tr>
           	          </table>
        			<%	   }
        				}
        			}
        	  }
        	 
          }
          else
          {%>
        	   <%
           ArrayList<Gdscoll> list=GdscollHelper.getGdscollBysceneid(gdscoll.getGdscoll_serid().toString());
           if(list!=null&&list.size()>0)
           {
        	   int i=0;
        	   for(Gdscoll gds:list)
        	   {
        		   if(gds!=null&&!gds.getId().equals(id)&&gds.getGdscoll_flag().longValue()==1)
        		   {
        		      
        		       int count=0;
   					   ArrayList<Gdscolldetail> gdetaillist=GdscollHelper.getGdscollBycollid1(gds.getId());
						if(gdetaillist!=null)
						{
							for(Gdscolldetail gd:gdetaillist)
							{
								Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
								if(p!=null&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
									count++;
									
								}
							}
						}
						if(count>1){
							 i++;
        		   %>
        			   <table height="188">
        	             <tr><td width="88"><a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%= gds.getId() %>" target="_blank">
        	             <img src="http://images1.d1.com.cn<%= gds.getGdscoll_smallimgurl() %>" width="88" height="127"/></a></td>
        	                 <td>
        	               <%
        	                 gdlist=GdscollHelper.getGdscollBycollid(gds.getId());
	         			      if(gdlist!=null&&gdlist.size()>0)
	         			      {
	         			    	  for(Gdscolldetail gd:gdlist)
	         			    	  {
	         			    		  if(gd!=null&&gd.getGdscolldetail_gdsflag().longValue()==1)
	         			    		  {
	         			    			  Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
	         			    			  if(p!=null)
	         			    			  {
	         			    				  %>
	         			    				  <a href="http://www.d1.com.cn/product/<%= gd.getGdscolldetail_gdsid() %>" target="_blank"><%= gd.getGdscolldetail_title() %></a>:￥<%= (int)Math.ceil(p.getGdsmst_memberprice().floatValue()) %><br/>
	         			    			  <%}
	         			    		  }
	         			    	  }
	         			      }
        	               %>           
        	              <br/>
        	                     <a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%= gds.getId() %>" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/look.jpg" width="65" heihgt="25"/></a>
        	                 </td>
        	             </tr>
        	          </table>
        		   <%}
        		   }
        		   if(i>=10)
        		   {
        			   break;
        		   }
        	   }
           }
       %>
          <%}
          
       %>
       
       <br/>
       <a href="<%= url %>" target="_blank" style="color:#f00; float:right;">查看所有搭配>>&nbsp;&nbsp;&nbsp;&nbsp;</a>
       </div>
       </div>
      </div>
      
      <div class="right">
      
      
      <%
         
          gdlist=GdscollHelper.getGdscollBycollid(gdscoll.getId());
          if(gdsser!=null)
        	{
        	  if(gdsser.getGdsser_brandid().equals("1690"))
        	  {%>
        		  <div class="right_top" <% if(gdsser.getGdsser_img()!=null&&gdsser.getGdsser_img().length()>0){ %> style="background:url('http://images1.d1.com.cn<%= gdsser.getGdsser_img()%>') no-repeat bottom center;"<%} %>>
                  <img src="http://images1.d1.com.cn<%= gdscoll.getGdscoll_bigimgurl() %>" width="354" height="496" style="<% if(gdscoll.getGdscoll_imgposition().longValue()==1) out.print("float:right;"); else { out.print("float:left;");} %> "/>
                  <div style="height:496px; width:360px; <% if(gdscoll.getGdscoll_imgposition().longValue()==1) out.print("float:right;"); else { out.print("float:left;");} %> ">
                  <table style="margin-top:45px; <%if(gdscoll.getGdscoll_imgposition().longValue()==1) out.print("float:right; margin-right:-45px;"); else {out.print("float:left; margin-left:-45px;"); }%>"><tr><td style="<%if(gdscoll.getGdscoll_imgposition().longValue()==1) out.print("text-align:right;"); else {out.print("text-align:left;"); }%>">
                  <font style=" font-size:28px; font-family:'微软雅黑'; font-weight:bold; <% if(gdsser.getGdsser_brandid().equals("1969")) out.print("color:#959595;"); else {out.print("color:#fff;");} %>"> <%= gdscoll.getGdscoll_title() %></font><br/>
                  <font style=" font-size:14px;font-weight:bold; <% if(gdsser.getGdsser_brandid().equals("1969")) out.print("color:#959595;"); else {out.print("color:#fff;");} %> "><%= gdscoll.getGdscoll_tail() %></font> 
                  </td></tr></table>
                  </div>
                 </div>
        	  <%}
        	  else
        	  {
        	%>
        		 <div class="right_top" <% if(gdsser.getGdsser_img()!=null&&gdsser.getGdsser_img().length()>0){ %> style="background:url('http://images1.d1.com.cn<%= gdsser.getGdsser_img()%>') no-repeat bottom center;"<%} %>>
                  <img src="http://images1.d1.com.cn<%= gdscoll.getGdscoll_bigimgurl() %>" width="354" height="496" style="<% if(gdscoll.getGdscoll_imgposition().longValue()==1) out.print("float:right;"); else { out.print("float:left;");} %> "/>
                  <div style="height:496px; width:400px; <% if(gdscoll.getGdscoll_imgposition().longValue()==1) out.print("float:right;"); else { out.print("float:left;");} %> ">
                  <table style="margin-top:85px; width:320px;<%if(gdscoll.getGdscoll_imgposition().longValue()==1) out.print("float:right;"); else {out.print("float:left;"); }%>"><tr><td style="<%if(gdscoll.getGdscoll_imgposition().longValue()==1) out.print("text-align:left;"); else {out.print("text-align:right;"); }%>">
                  <font style=" font-size:28px; font-family:'微软雅黑'; font-weight:bold; <% if(gdsser.getGdsser_brandid().equals("1969")) out.print("color:#959595;"); else {out.print("color:#fff;");} %>"> <%= gdscoll.getGdscoll_title() %></font><br/>
                  <font style=" font-size:16px;font-weight:bold; <% if(gdsser.getGdsser_brandid().equals("1969")) out.print("color:#959595;"); else {out.print("color:#fff;");} %> "><%= gdscoll.getGdscoll_tail() %></font> 
                  </td></tr></table>
                  </div>
                 </div>
        	<%}
        	}

              ArrayList<Gdscolldetail> gdlist1=new ArrayList<Gdscolldetail>();
		      ArrayList<Gdscolldetail> nogdlist=getOtherGdscoll(gdscoll.getId());
	          gdlist1=GdscollHelper.getGdscollBycollid(gdscoll.getId());
	          if(gdlist1!=null&&gdlist1.size()>0)
	          {
	        	    float sum=0f;
			        float zhprice=0;
			        int counts=0;
			        float zk=0.95f;
			        int zzsum=0;
			      %>
	                <div id="scoll0" class="newgdscoll" <%if(gdscoll.getGdscoll_imgposition().longValue()==1) out.print("style=\"left:20px;\""); else {out.print("style=\"right:20px;\""); }%>">
	                <div  id="scolllist0" style="position:relative; height:140px; width:336px; overflow:hidden; margin-left:40px;">
	                <ul>
	                   <%
	                   for(Gdscolldetail gd:gdlist1)
		    	       {
		    	    	   Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
		    	    	   if(p!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1&&ProductStockHelper.canBuy(p))
		    	    	   {
		    	    		   counts++;
		    	    		   zzsum++;
		    	    		   sum+=p.getGdsmst_memberprice().floatValue();
		    	    		   zhprice+=Tools.getFloat((int)(p.getGdsmst_memberprice().floatValue()*zk), 2);
		    	    		   String imgurl="";
		    	    		   ArrayList<GdsCutImg> gcilist=getByGdsid(p.getId());
		    	    		   if(gcilist!=null&&gcilist.size()>0&&gcilist.get(0)!=null)
		    	    		   {
		    	    			   if(gcilist.get(0).getGdscutimg_100()!=null&&gcilist.get(0).getGdscutimg_100().length()>0)
		    	    			   {
		    	    				   imgurl=gcilist.get(0).getGdscutimg_100();
		  							 if(imgurl!=null&&imgurl.startsWith("/shopimg/gdsimg")){
		  								imgurl = "http://images1.d1.com.cn"+imgurl;
		  									}else{
		  										imgurl = "http://images.d1.com.cn"+imgurl;
		  									}
		    	    			   }
		    	    			   else
		    	    			   {
		    	    				   imgurl=ProductHelper.getImageTo120(p);
		    	    			   }
		    	    		   }
		    	    		   else
		    	    		   {
		    	    			   imgurl=ProductHelper.getImageTo120(p);
		    	    		   }
		    	    				   
		    	       %>
		    	              <li style="position:relative;">
		    	                  <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank"><img src="<%= imgurl%>" width="100" height="100" style="border:solid 1px #000;"/></a><br/>
		    	                 <input type="checkbox" name="chk_0" checked value="<%= gd.getGdscolldetail_gdsid() %>"  onClick="selectInitdp12091('<%=Tools.getFormatMoney(p.getGdsmst_memberprice())%>',this.checked,0,'<%= gd.getGdscolldetail_gdsid() %>')" >&nbsp;<%= gd.getGdscolldetail_title() %></input>
<font style="color:#be0000">￥<%= Tools.getFormatMoney(p.getGdsmst_memberprice().floatValue()) %></font>
		    	              <input type='hidden' class="a0" value="<%= p.getId() %>"/>
		    	              <span id="span<%= p.getId() %>0" style="position: absolute;top:1px;left:1px;width: 100px;height: 100px;background-color: #ccc;filter: alpha(opacity=40);-moz-opacity: 0.4;opacity: 0.4; display:none; "></span>
		    	              </li>
		    	    		   
		    	    	<%   }
		    	    }

	        			  if(nogdlist!=null&&nogdlist.size()>0)
	        			  {
	        			    for(Gdscolldetail gdetail:nogdlist)
	        				  {
	        					  if(gdetail!=null)
	        					  {
	        					      if(gdetail!=null&&gdetail.getGdscolldetail_gdsid()!=null&&gdetail.getGdscolldetail_gdsid().length()>0)
	        					      {
	        					    	  Product pro=ProductHelper.getById(gdetail.getGdscolldetail_gdsid());
	        					    	  {
	        					    		 if(pro!=null&&pro.getGdsmst_ifhavegds().longValue()==0&&pro.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(pro))
	        					    		 {
	        					    			 zzsum++;
	        					    			   String imgurl="";
	        					    		       ArrayList<GdsCutImg> gcilist=getByGdsid(pro.getId());
	        					    		       if(gcilist!=null&&gcilist.size()>0&&gcilist.get(0)!=null)
	        					    		       {
	        					    		    	   if(gcilist.get(0).getGdscutimg_100()!=null&&gcilist.get(0).getGdscutimg_100().length()>0)
	        					    		    	   {
	        					    		     		   imgurl=gcilist.get(0).getGdscutimg_100();
	        					  							 if(imgurl!=null&&imgurl.startsWith("/shopimg/gdsimg")){
	        					  								imgurl = "http://images1.d1.com.cn"+imgurl;
	        					  									}else{
	        					  										imgurl = "http://images.d1.com.cn"+imgurl;
	        					  									}
	        					    		    	   }
	        					    		    	   else
	        					    		    	   {
	        					    		    		   imgurl=ProductHelper.getImageTo120(pro);
	        					    		    	   }
	        					    		       }
	        					    		       else
	        					    		       {
	        					    		    	   imgurl=ProductHelper.getImageTo120(pro);
	        					    		       }%>
	        					    		       
	        					    		       <li style="position:relative;">
		    	                                   <a href="http://www.d1.com.cn/product/<%= pro.getId() %>" target="_blank"><img src="<%= imgurl%>" width="100" height="100" style="border:solid 1px #000; background:#fff;"/></a><br/>
		    	                                   <input type="checkbox" name="chk_0"  value="<%= pro.getId() %>" onClick="selectInitdp12091('<%=Tools.getFormatMoney(pro.getGdsmst_memberprice())%>',this.checked,0,'<%= pro.getId() %>')" >&nbsp;<%= gdetail.getGdscolldetail_title() %>
		    	                                   <font style="color:#be0000">￥<%= Tools.getFormatMoney(pro.getGdsmst_memberprice().floatValue()) %></font>
		    	                                  <input type='hidden' class="a0" value="<%= pro.getId() %>"/>
		    	                                     <span id="span<%= pro.getId() %>0" style="position: absolute;top:1px;left:1px;width: 100px;height: 100px;background-color: #ccc;filter: alpha(opacity=40);-moz-opacity: 0.4;opacity: 0.4; display:block; "></span>
		    	            
		    	                                   </li>
	        					    		 <%}
	        					         }
	        					      }
	        					  }
	        				  }
	        				
	        			  }
	                   %>
	                    </ul>
	                       
	                   </div>
	                   <%
	                       if(zzsum>3)
	                       {
	                   %>
	                      <div class='preNext pre2012'>
							 <img id="tprev1" src="http://images.d1.com.cn/images2012/index2012/JULY/jtz.png" width="23" height="67"/>
							 </div>
							 <div class='preNext next2012' >
							 <img src="http://images.d1.com.cn/images2012/index2012/JULY/jty.png" height="67" width="23"/>
					         </div>
					         <%} %>
	                    <div class="clear"></div>
	                    <br/>
	                   <span>
	                 
	                    <table style="color:#000;">
	                       <tr><td width="50"></td><td width="100">共<em id="amount0"><%= counts%></em>件</td><td>组合价：<font color="#bc0000" face="微软雅黑">￥</font><font id="pktP0" color="#bc0000" face="微软雅黑"><%= (int)zhprice %></font></td><td width="40"></td><td rowspan="2"><font style="font-size:16px; color:#f00;">搭配购买立享95折！</font><br/><a href="javascript:void(0)" code="<%= gdscoll.getId() %>" onclick="check_gdscoll201209(this,'0')" style="color:#fff; font-size:14px;"><img src="http://images.d1.com.cn/Index/images/ljgmzh.png"/></a></td></tr>
	                       <tr><td></td><td><strike>总价：￥<font id="memberP0"><%=(int)sum %></font></strike></td><td>共优惠：￥<font id="cheap0"><%= (int)(sum-zhprice) %></font></td><td></td></tr>
	                    </table>
	                   </span>
	                  
	                </div>
	           

	        			    	   
	       
	      <%
	          }
	        			  %>
          
          <div class="productlist">
          <%
             if(gdlist!=null&&gdlist.size()>0)
             {
              for(Gdscolldetail gdetail:gdlist)
              {
            	  if(gdetail!=null)
            	  {
            		  Product p=ProductHelper.getById(gdetail.getGdscolldetail_gdsid());
            		  if(p!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p))
            		  {
            			  ArrayList<GdsCutImg> list= getByGdsid(p.getId());
            			  GdsCutImg gci=new GdsCutImg();
            			  if(list!=null&&list.size()>0)
            			  {
            				  gci=list.get(0);
            			  }
            			  //GdsCutImg gci=(GdsCutImg)Tools.getManager(GdsCutImg.class).get(p.getId());
            			  String imgurl="";
            			  if(gci!=null&&gci.getGdscutimg_300()!=null&&gci.getGdscutimg_300().length()>0)
            			  {
            				  imgurl=gci.getGdscutimg_300();
            				  if(imgurl!=null&&imgurl.startsWith("/shopimg/gdsimg")){
	  								imgurl = "http://images1.d1.com.cn"+imgurl;
	  									}else{
	  										imgurl = "http://images.d1.com.cn"+imgurl;
	  									}
            			  }
            			  else
            			  {
            				  imgurl=ProductHelper.getImageTo400(p);
            			  }
            			  int score = CommentHelper.getLevelView(p.getId());
            			  int contentcount = CommentHelper.getCommentLength(p.getId());
            			  String skuname1 = p.getGdsmst_skuname1();//sku1
            			  //System.out.print(skuname1);
            			  String endprice = "";
            			  long buylimit = Tools.longValue(p.getGdsmst_buylimit());
            		  %>
            			 <table>
                 <tr><td width="333" style="text-align:center;">
                 <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank"><img src="<%= imgurl %>" width="300" height="300"/></a> </td>
                 <td width="434" style="padding-left:50px;">
                    <span class="title"><a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank"><%= p.getGdsmst_gdsname() %></a></span><br/>
                     <font class="font1"><b>会员价：￥<%=Tools.getRoundPrice(p.getGdsmst_memberprice().floatValue()) %></b></font><br/>
                     <font class="font2"><strike>市场价：￥<%= Tools.getRoundPrice(p.getGdsmst_saleprice().floatValue()) %></strike></font><br/>
                     <div style="float:left; height:18px; line-height:18px;">顾客评分：</div><div class="sa<%= score %>" style="float:left;"></div>
				     <div style="float:left;color:#204e99;"><a href="http://www.d1.com.cn/product/<%=p.getId()%>?st=com#cmt" target="_blank">(已有<%=contentcount %>人评价)</a></div>
				     <div class="clear"></div>
						 <div class="spgg">
						 <%          
									    
									    ///sku
									    if(!Tools.isNull(skuname1)){
									    	int showsku=1;
									    	if(p.getGdsmst_stocklinkty()!=null&&(p.getGdsmst_stocklinkty().longValue()==0||p.getGdsmst_stocklinkty().longValue()==3)){
									    		showsku=0;
									    	}
									    	//System.out.println(showsku);
									    	List<Sku> skuList=new ArrayList<Sku>();
										    skuList = SkuHelper.getSkuListViaProductIdO(p.getId(),showsku);
										  
										    if(skuList != null && !skuList.isEmpty()){
										    	int size = skuList.size();
										    	%><div id="skuname_<%= p.getId() %>" class="skuname">
										    		<p>选择<%=skuname1 %>：<font id="sizecount_<%= p.getId() %>"><%=size==1?skuList.get(0).getSkumst_sku1():"未选择" %></font>
										    		<% ArrayList<GdsAtt> list1=GdsAttHelper.getGdsAttByGdsid(p.getId());
										    		   if(list1!=null&&list1.size()>0)
										    		   {
										    			   if(list1.get(0).getGdsatt_content().length()>0)
										    			   {
										    		    %>
										    			   <font id="ccdzb" style=" color:#020399; cursor:hand;" onmouseover="ccdzb('<%= p.getId() %>')" onmouseout="ccdzb1('<%= p.getId() %>')">(尺寸对照表)</font></p>
										    		      <div id="ccdzb_img_<%= p.getId() %>" style="position:absolute;display:none;" onmouseover="ccdzb('<%= p.getId() %>')" onmouseout="ccdzb1('<%= p.getId() %>')">
										    		      <%= list1.get(0).getGdsatt_content() %>
										    		       </div>
										    		
										    		   <%  }
										    		   }
										    		   else
										    		   {%>
										    			   </p>
										    		   <%}
										    		%>
										    		
										    		<ul>
										    		<%
										    		for(int i=0;i<size;i++){
										    			Sku sku = skuList.get(i);
										    			String skuname = sku.getSkumst_sku1();
										    			if(p.getGdsmst_stocklinkty()!=null&&(p.getGdsmst_stocklinkty().longValue()==1||p.getGdsmst_stocklinkty().longValue()==2)){
										    				if(CartItemHelper.getProductOccupyStock(p.getId(), sku.getId())<ProductHelper.getVirtualStock(p.getId(), sku.getId())){
											    				%><li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this,'<%= p.getId() %>')" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a></li><%
										    				}
										    				else
										    				{
										    					if(sku.getSkumst_vstock().longValue()==0){ %>
										    						<li><a href="javascript:void(0);" title="售罄"   hidefocus="true"  style="height:21px;line-height:21px;padding:0 9px;border:1px solid #dcdddd;background:#fff;color:#dcdddd;text-decoration:none;"><span><%=skuname %></span></a></li>
										    					<%}
										    					else
										    					{%>
										    						<li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this,'<%= p.getId() %>')" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a></li>
										    					<%}
										    				}
										    			}else{
										    	
										    			%><li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this,'<%= p.getId() %>')" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a></li><%
										    			  
										    			}
										    		}
										    		%>
										    		</ul>
										    	</div><%
										    }
									    }
									    endprice =  Tools.getFormatMoney(p.getGdsmst_memberprice().doubleValue());
									    %>
										<div>
											<span>我要购买</span>
											<input type="hidden" id="count_<%= p.getId()%>" value='1'/>
											<a href="javascript:void(0)" title="减1" class="minus" onclick="addorminus('minus',<%=buylimit %>,'<%=endprice %>','<%= p.getId() %>')" ><img src="http://images.d1.com.cn/Index/images/j_a.gif"  /></a>
										    <input type="text" id="num_input_<%= p.getId() %>" objNum="1" value="1" onkeyup="keynum(this,<%=endprice %>);" maxlength='3' class="num" />
										    <a href="javascript:void(0)" title="加1" class="add" onclick="addorminus('add',<%=buylimit %>,'<%=endprice %>','<%= p.getId() %>')"><img src="http://images.d1.com.cn/Index/images/a_j.gif"  /></a><br />
										    <span>小计：</span><b><font color="#a22d48" id="pricecount_<%= p.getId() %>">￥<%=endprice %></font></b>
										</div>
										
								</div>
								 <div class="frgwc_div" id="frgwc_<%= p.getId() %>" style="display:none;">
							    <span style="position:relative;overflow:hidden;">
							    	<font id="countgdsmst1_<%= p.getId() %>">1</font>件商品加入购物车
							    	<a href="###" class="ui-dialog-titlebar-close ui-corner-all" onclick="$('#frgwc_<%= p.getId() %>').hide();"><span class="ui-icon ui-icon-closethick">close</span></a>
							    </span>
								<ul>
								<li>
								    <img src="http://images.d1.com.cn<%=p.getGdsmst_smallimg() %>" width="80" height="80" />
									<div style="height:80px;"> <font style="_font-size:12px; "><b>
                                        <%=p.getGdsmst_gdsname() %></b></font>
									<br/><br/>
									    加入数量：<font id="countgdsmst2_<%= p.getId() %>">1</font><br/>
									    总计金额:￥<font id="countgdsmst3_<%= p.getId() %>"><%=endprice %></font><br/>
									</div>
								
								</li>
								</ul>
								<div class="gwcbtn"><a href="/flow.jsp" target="_blank" onclick="display_hide('frgwc_'+<%= p.getId() %>);"><img src="http://images.d1.com.cn/images2012/New/viewcart.gif" alt="查看购物车" /></a><a href="javascript:void(0)" onclick="display_hide('frgwc_<%= p.getId() %>')"><img src="http://images.d1.com.cn/Index/images/jxgw.jpg" alt="继续购物" /></a>							</div>
							 </div>
								<div class="gwcbtn">
								<%
								     if(p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1)
								     {
								
								%>
								<a href="javascript:void(0)" onclick="ShowAJax('<%= p.getId()%>')"><img src="http://images.d1.com.cn/images2012/index2012/addcart.jpg" alt="查看购物车" />
								<%}
								else
								{%>
									<a href="javascript:void(0)" onclick="ShowAJax('<%= p.getId()%>')"><img src="http://images.d1.com.cn/images2012/index2012/zsqh.jpg" />
								<%}%>
								</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="addFavorite('<%= p.getId() %>');"><img src="http://images.d1.com.cn/images2012/index2012/addfavorite.jpg" /></a>							</div>
								
                 </td>
                 </tr>
              </table>  
            		<%}
            	  }
              }
             }
         %>
          
             
          </div>
      </div>
      <%}
	
      else
      {
    	  out.print("该搭配不存在！<a href=\"/index.jsp\" target=\"_blank\">去首页逛逛</a>");
      }%>
   </div>

   <div class="clear"></div>
   <!-- 底部 -->
   <%@ include file="/inc/foot.jsp" %>
   <!-- 底部结束 -->
   
</body>
</html>
<script>
$(document).ready(function() {
	g_productscoll("#scoll0","#scolllist0");
});
</script>