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
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/gdsscene.css")%>" rel="stylesheet" type="text/css" media="screen" />

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
        	    	  <a href="/gdscene/indexother.htm?id=<%=gt.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=imgurl %>" width="80" height="80" style="margin-top:15px;" id="fimg<%=count %>"/></a>
        	       
        	      <%  }
        	          else
        	          {%>
        	        	  <a href="/gdscene/index.htm?id=<%=gt.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=imgurl %>" width="80" height="80" style="margin-top:15px;" id="fimg<%=count %>"/></a>
        	       
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
          <a href="/gdscoll/index.jsp?id=<%= tg.getId() %>&sf=<%=id %>" target="_blank">
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
			        float zk=0.95f;
			      %>
	                <div id="scoll0" class="newgdscoll">
	                <div  id="scolllist0" style="position:relative; height:140px; width:448px; overflow:hidden; margin-left:40px;">
	                <ul>
	                   <%
	                   for(Gdscolldetail gd:gdlist1)
		    	       {
		    	    	   Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
		    	    	   if(p!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1&&ProductStockHelper.canBuy(p))
		    	    	   {
		    	    		   counts++;
		    	    		   sum+=p.getGdsmst_memberprice().floatValue();
		    	    		   zhprice+=Tools.getFloat((int)(p.getGdsmst_memberprice().floatValue()*zk), 2);
		    	    		   String imgurl="";
		    	    		   ArrayList<GdsCutImg> gcilist=getByGdsid(p.getId());
		    	    		   if(gcilist!=null&&gcilist.size()>0&&gcilist.get(0)!=null)
		    	    		   {
		    	    			   if(gcilist.get(0).getGdscutimg_100()!=null&&gcilist.get(0).getGdscutimg_100().length()>0)
		    	    			   {
		    	    				   imgurl="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_100();
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
		    	                  <a href="/product/<%= p.getId() %>" target="_blank"><img src="<%= imgurl%>" width="100" height="100" style="border:solid 1px #000;"/></a><br/>
		    	                 <input type="checkbox" name="chk_0" checked value="<%= gd.getGdscolldetail_gdsid() %>"  onClick="selectInitdp1211('<%=Tools.getFormatMoney(p.getGdsmst_memberprice())%>',this.checked,0,'<%= p.getId() %>')" >&nbsp;<%= gd.getGdscolldetail_title() %></input>
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
	        					    		    		   imgurl=ProductHelper.getImageTo120(pro);
	        					    		    	   }
	        					    		       }
	        					    		       else
	        					    		       {
	        					    		    	   imgurl=ProductHelper.getImageTo120(pro);
	        					    		       }%>
	        					    		       
	        					    		       <li style="position:relative;">
		    	                                   <a href="/product/<%= pro.getId() %>" target="_blank"><img src="<%= imgurl%>" width="100" height="100" style="border:solid 1px #000; background:#fff;"/></a><br/>
		    	                                   <input type="checkbox" name="chk_0"  value="<%= pro.getId() %>" onClick="selectInitdp1211('<%=Tools.getFormatMoney(pro.getGdsmst_memberprice())%>',this.checked,0,'<%= pro.getId() %>')" >&nbsp;<%= gdetail.getGdscolldetail_title() %>
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
	                       if(gdlist1.size()+nogdlist.size()>4)
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
	                       <tr><td width="100"></td><td width="100">共<em id="amount0"><%= counts%></em>件</td><td>组合价：<font color="#bc0000" face="微软雅黑">￥</font><font id="pktP0" color="#bc0000" face="微软雅黑"><%= (int)zhprice %></font></td><td width="40"></td><td rowspan="2"><font style="font-size:16px; color:#f00;">搭配购买立享95折！</font><br/><a href="javascript:void(0)" code="<%= tg.getId() %>" onclick="check_gdscoll20120710(this,'0')" style="color:#fff; font-size:14px;"><img src="http://images.d1.com.cn/Index/images/ljgmzh.png"/></a></td></tr>
	                       <tr><td></td><td><strike>总价：￥<font id="memberP0"><%=(int)sum %></font></strike></td><td>共优惠：￥<font id="cheap0"><%= (int)(sum-zhprice) %></font></td><td></td></tr>
	                    </table>
	                   </span>
	                  
	                </div>
	           

	        			    	   
	       
	      <%
	          }
	        			  %>
	  
	   </div>
	   <div class="clear"></div>
	   <%       
	      }
	      }
	 
      %>     
       <div style="width:980px; margin:0px auto;">
       <%= getGdscollInGdsscene20120713(gdsscene) %>
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
$(document).ready(function() {
	g_productscoll("#scoll0","#scolllist0");
});
</script>
