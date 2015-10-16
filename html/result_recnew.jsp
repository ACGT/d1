<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/html/getComment.jsp"%>
<%!
/**
 * 获取200-100活动商品列表
 * 
 */
private static ArrayList<PromotionProduct> gethdgoodslist(String gdsid)
{
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code", new Long("8409")));
	clist.add(Restrictions.eq("spgdsrcm_gdsid", gdsid));
	//clist.add(Restrictions.ge("spgdsrcm_enddate", new Date()));
	//clist.add(Restrictions.le("spgdsrcm_begindate", new Date()));
	List<Order> olist = new ArrayList<Order>();
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 1);
	if(clist==null||clist.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((PromotionProduct)be);
	}
	return rlist ;
}
//获取一张图
private static String getimg(String code)
{
if(!Tools.isMath(code)) return "";
StringBuilder sb=new StringBuilder();
List<Promotion> list=PromotionHelper.getBrandListByCode(code, 1);
if(list!=null&&list.size()>0)
{
	int size=0;
	
	for(Promotion p:list)
	{ 
		if(p!=null)
		{	
			
			sb.append("<a href=\"").append(StringUtils.encodeUrl(p.getSplmst_url())).append("\" target=\"_blank\">");
			sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\" />");
			sb.append("</a>");
		}
	}
	
}
return sb.toString();

}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网推荐专区</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css" >

.newlist {width:980px;overflow:hidden; margin:0px auto; background-color:#f0f0f0; }
.newlist ul {width:965px;padding:0 0 0px; padding-left:25px;  padding-top:15px; padding-bottom:15px;}
.newlist li {float:left; margin-right:30px;overflow:hidden; width:210px; overflow:hidden; margin-bottom:20px;  }
.newlist p {text-align:left; }
.newlist p strong {font-weight:bold; font-size:15px; color:#a63c4f;margin-right:10px;}
.newlist .retime {background:rgba(0,0,0,0.5);font-size:12px;text-align:left;line-height:16px;overflow:hidden; bottom:0px; margin-top:-41px; position:relative; width:200px; padding-top:3px; padding-bottom:2px;
*background:transparent;filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#b3000000,endColorstr=#b3000000); z-index:1111; height:36px; display:none;  }
.retime a{text-decoration:none; }
.lf{ padding:5px; background-color:#fff; over-flow:hidden;position:relative; }
.newlist p .newspan{ display:block; width:120px; height:35px; margin-top:5px; text-align:center; line-height:35px; border-right:solid 1px #f3f3f3; float:left;}
.newlist p .newspan1{ display:block; width:79px; height:35px; margin-top:5px; text-align:center; line-height:35px; color:#333;float:left;}
.lb{background-color:#f7f7f7;  padding:5px;  width:200px; height:42px; line-height:20px; font-size:12px;color:#7b7b7b; overflow:hidden;
 text-align:left; vertical-align:middle; padding-top:8px;}
.newlist .lf .di{position:absolute;z-index:999;width:79px;height:79px;border:none; float:left;}
.floatdp{ position:absolute; z-index:22222; background:#fff; width:278px; overflow:hidden;margin-top:-430px; margin-left:-265px; +margin-left:-365px;
}
.floatdpr{ position:absolute; z-index:22222; background:#fff; width:278px; overflow:hidden;margin-top:-430px; margin-left:15px; +margin-left:15px;
}
.floatdp1{ position:absolute; z-index:22222; background:url('http://images.d1.com.cn/images2012/index2012/xsj1.png') no-repeat;
          background-position:right 250px; width:278px; overflow:hidden;margin-top:-430px; margin-left:-265px;+margin-left:-365px;
}
.floatdp2{ position:absolute; z-index:22222; background:url('http://images.d1.com.cn/images2012/index2012/xsj.png') no-repeat;
          background-position:left 250px; width:278px; overflow:hidden;margin-top:-430px; margin-left:18px;+margin-left:-88px;
}
.dpdisplay{ width:246px;}
.dpdisplay ul { list-decoration:none; margin:0px; padding:0px; }
.dpdisplay ul li{  float:left; background:url('http://images.d1.com.cn/images2012/aleeishe/images/0031.jpg') no-repeat; margin:0px; padding:0px; position:none; width:246px;}
.pj{background:#ccc; padding:5px;padding-top:0px; padding-left:6px; padding-bottom:2px;overflow:hidden;}
.pj a{ float:left; margin-right:3px; margin-bottom:3px;}

.allb {width:246; overflow:hidden; position:relative; margin:0px; padding:0px; background:#808080;}
.allimglist{ overflow:hidden;}
.allimglist img {border:0px;}
.allb ul {position:absolute; display:block; list-style-type:none;z-index:10000;margin:0; padding:0; top:330px; right:10px; width:auto;}
.allb ul li { padding:0px 3px;float:left;display:block; margin:0px;background:url('http://images.d1.com.cn/images2012/index2012/c2.png') no-repeat;cursor:pointer; height:14px; width:14px; }
.allb ul li.on { background:url('http://images.d1.com.cn/images2012/index2012/c1.png') no-repeat; margin:0px; }

.allimglist span{ width:246px; display:block;}
.allimglist ul li{ float:left;}

.next{position:absolute; right:0px; top:310px; curson:hand;}
.pre{position:absolute; left:0px; top:310px; curson:hand;}
</style>
<script type="text/javascript" language="javascript">
function scrollresult(imglistobj,cicleobj,flag)
{
    var t = n = 0; 
    var count=$(imglistobj+" span").length;
	$(imglistobj+" span:not(:first-child)").hide();
	$("#pre2012"+flag).click(function(){
		var obj=$(imglistobj+" span").filter(":visible").attr("attr");
		if(obj-1<=0) obj=count+1;
		obj=obj-1;
		$(imglistobj+" span").filter(":visible").hide().parent().children().eq(obj-1).fadeIn(500);
		$("#commensapn"+flag).css("display","block");
	});
	$("#next2012"+flag).click(function(){
		var obj=$(imglistobj+" span").filter(":visible").attr("attr");
		if(obj>=count) obj=0;
		obj=obj-1;
		$(imglistobj+" span").filter(":visible").hide().parent().children().eq(obj+1).fadeIn(500);
		$("#commensapn"+flag).css("display","block");
	});
	}

function mdmover(flag)
{
	var obj=$("#floatdp"+flag);
	obj.css("display","block");
	}


 function mdm_out(flag)
{
	 $("#floatdp"+flag).css("display","none");
	
}

function getFloatdp(gdsid,count)
{
	var obj=$("#floatdp"+count);
	var obj1=$("#da"+count);
	if(obj!=null)
	{
		if(obj1.offset().left<200){
			$(obj).addClass("floatdpr");//css("background","#fff");
			$(obj).html("<img src='http://images.d1.com.cn/images2012/New/Loading.gif' style=\"margin-left:120px; margin-top:120px; margin-bottom:120px; \"/>");
			$.post("/html/resulthtml1.jsp",{"gdsid":gdsid,"count":count},function(data){
				$(obj).html(data);
				$(obj).removeClass("floatdpr");
				$(obj).addClass("floatdp2");
			});
			
		}
		else{
			$(obj).addClass("floatdp");//css("background","#fff");
			$(obj).html("<img src='http://images.d1.com.cn/images2012/New/Loading.gif' style=\"margin-left:120px; margin-top:120px; margin-bottom:120px; \"/>");
			$.post("/html/resulthtml.jsp",{"gdsid":gdsid,"count":count},function(data){
				$(obj).html(data);
				$(obj).removeClass("floatdp");
				$(obj).addClass("floatdp1");
			});
			
		}
		    
				//alert( obj1.offset().left);
			
    }
}

function mdm_over(gdsid,flag)
{
	var obj=$("#floatdp"+flag);
	if(obj!=null)
		{
		   getFloatdp(gdsid,flag);
		   obj.css("display","block");
		}
    
}


</script>
</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
     <%if(!Tools.isNull(request.getParameter("pcode"))){ %>
     <div align="center">
     <%=getimg(request.getParameter("pcode")) %>
     </div>
     <%  }
     if(!Tools.isNull(request.getParameter("img"))){
    	 %>
    	 <div>
    	 <table border="0" cellpadding="0" cellspacing="0">
    	 <tr><td><img src="<%=request.getParameter("img").trim() %>" /></td></tr>
    	 <tr><td height="10">&nbsp;</td></tr>
    	 </table>
    	 
    	
    	 </div>
    	 <div class="clear"></div>
    <%}
         String aid="";
         ArrayList<PromotionProduct> list=new ArrayList<PromotionProduct>();
         String[] aidstr=new String[100];
         if(request.getParameter("aid")!=null&&request.getParameter("aid").length()>0){
        	 aid=request.getParameter("aid");
        	 if(aid.indexOf(",")>0) {
            	 aidstr=aid.split(",");
            	 for(int i=0;i<aidstr.length;i++) {
            		// out.print(aidstr[i]+"111111111111");
            		 ArrayList<PromotionProduct> subl=PromotionProductHelper.getPProductByCode(aidstr[i]);
            	     if(subl!=null&&subl.size()>0){
		            	  list.addAll(subl);
		            
	            	}
	            }
            
             }
        	 else{
        		 list=PromotionProductHelper.getPProductByCode(aid);
        	 }
        	 
         }
         else{
        	 list=null;
         }
        
     %>
     
     <% 
     //显示商品
     if(list!=null&&list.size()>0) {%>
     <div style="width:980px; text-align:center;">
<div class="newlist" style="overflow:hidden;  padding-bottom:18px; ">
<ul>
<%
         int count=0;
    	 for(PromotionProduct pp:list) {
    		 count++;
    		 Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
    		 if(product!=null&&product.getGdsmst_validflag()!=2&&product.getGdsmst_validflag()!=4){
    			 String title = Tools.clearHTML(pp.getSpgdsrcm_gdsname());
     			 long endTime = Tools.dateValue(product.getGdsmst_discountenddate());
     			 long currentTime = System.currentTimeMillis();
     			 String theimgurl="";
    			 if(product.getGdsmst_rackcode().length()>=6&&(product.getGdsmst_rackcode().substring(0,3).equals("020")||product.getGdsmst_rackcode().substring(0,3).equals("030")||product.getGdsmst_rackcode().substring(0,3).equals("034"))){
    				 theimgurl=product.getGdsmst_img200250(); 
    				 if(Tools.isNull(theimgurl)){
    					 if(pp.getSpgdsrcm_otherimg().trim().length()!=0){
    						 theimgurl=pp.getSpgdsrcm_otherimg().trim();
    					 }else{
    						 theimgurl="http://images.d1.com.cn"+product.getGdsmst_imgurl();
    					 } 
    				 }else{
    					 theimgurl="http://images.d1.com.cn"+ theimgurl;
    				 }
    				
    			 }
    			 else{
    				 theimgurl=ProductHelper.getImageTo200(product);
    				}
    			  float memberprice=product.getGdsmst_memberprice().floatValue();
					String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
				   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice().floatValue());
				   double dl= Tools.getDouble(product.getGdsmst_memberprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
					 String fl=ProductGroupHelper.getRoundPrice((float)dl);
					 out.print("<li style=\"height:430px;\" id=\"testli_"+count+"\">");
					 %>
						
					 <div class="lf">
					 <%
                     //判断是否是200-100的商品
                       boolean flagbjcp=false;
                       ArrayList<PromotionProduct> bjpromotionlist=gethdgoodslist(product.getId());
                       if(bjpromotionlist!=null&&bjpromotionlist.size()>0)
                       {
                       	for(PromotionProduct ppbj:bjpromotionlist)
                       	{
                       		if(ppbj!=null)
                       		{
                       			if(ppbj.getSpgdsrcm_gdsid().equals(product.getId()))
                       			{
                       				flagbjcp=true;
                       				break;
                       			}
                       		}
                       	}
                       }
                       if(flagbjcp)
           				    {%>
           				    	<span style="position:absolute; width:47px; height:65px; dislay:block; background:url('http://images.d1.com.cn/zt2013/20120116hd/200-100.png'); left:5px;_left:-100px; top:0px; z-index:5000;"></span>
           				    <%}
           				%>
					<%
           			
           		
    		             if(product.getGdsmst_rackcode().length()>=6&&(product.getGdsmst_rackcode().substring(0,3).equals("020")||product.getGdsmst_rackcode().substring(0,3).equals("030")||product.getGdsmst_rackcode().substring(0,3).equals("034")))
           					{
           					%>
           					   <div style="z-index:999;"><a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank" >
           				
           							<img src="<%=theimgurl  %>" width="200" height="250" />
           	           
           				<%	}
           				    else
           				    {%>
           				    <div style="z-index:999; padding-top:25px; padding-bottom:25px;"><a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank" >
           				
           				    	<img src="<%= ProductHelper.getImageTo200(product) %>" width="200" height="200" />
           	           
           				    <%}%>
				
		</a>
		<%  //每个商品对应的搭配列表
                              ArrayList<Gdscoll> gdscolllist=GdscollHelper.getGdscollByGdsid(product.getId()); 
           				      if(gdscolllist!=null&&gdscolllist.size()>0)
           				      {  if(product.getGdsmst_rackcode().length()>=6&&(product.getGdsmst_rackcode().substring(0,3).equals("020")||product.getGdsmst_rackcode().substring(0,3).equals("030")||product.getGdsmst_rackcode().substring(0,3).equals("034")))
           					    {%>
           					 
           				    	  <div style="position:absolute; margin-top:-46px; +margin-top:204px; +margin-left:-205px; display:none; " onmouseover="mdm_over('<%= product.getId() %>','<%= count%>')" onmouseout="mdm_out('<%= count%>')" id="da<%= count%>"></div>
			  
           				      <%}
           				      else
           				      {%>
           				     
           				    	  <div style="position:absolute; margin-top:-46px; +margin-top:190px; +margin-left:-205px; display:none; " onmouseover="mdm_over('<%= product.getId() %>','<%= count%>')" onmouseout="mdm_out('<%= count%>')" id="da<%= count%>"></div>
			                      <%}
           				      }%>   
	</div>	
		
		 <p style="height:35px; font-size:13px; color:#999999; ">
			<span class="newspan">
			<% if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){%>
			   <font color="#b80024" style=" font-family:'微软雅黑'"><b>特价:￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %></b></font>&nbsp;&nbsp;
			    <font style="text-decoration:line-through;">￥<%=Tools.getFormatMoney(product.getGdsmst_oldmemberprice()) %></font>
	
			<%}else
			{%>
				<font color="#b80024" style=" font-family:'微软雅黑'"><b>￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %></b></font>&nbsp;&nbsp;
			   		<%}
			%>
			</span>
			<span class="newspan1"><a href="/product/<%= product.getId() %>?st=com#cmt" target="_blank" rel="nofollow">评论(<%= getCommentList(product.getId()).size() %>)</a></span>
		 </p>
		 </div>  
		 <p style="height:30px; background:#fff; line-height:30px; text-align:center;">
               <a href="javascript:void(0)" attr="<%= product.getId() %>" onclick="$.inCart(this);"><img src="http://images.d1.com.cn/images2012/index2012/SEP/ljgm.gif"/></a>&nbsp;&nbsp;&nbsp;
               <%if(gdscolllist!=null&&gdscolllist.size()>0)
           				      {%>
               <a href="javascript:void(0)" onclick="mdm_over('<%= product.getId() %>','<%= count%>')"><img src="http://images.d1.com.cn/images2012/index2012/SEP/dpgm.gif"/></a>&nbsp;&nbsp;&nbsp;
              <%}
               if((product.getGdsmst_rackcode().startsWith("020")||product.getGdsmst_rackcode().startsWith("030"))&&!product.getGdsmst_rackcode().startsWith("020011")&&!product.getGdsmst_rackcode().startsWith("020012")&&!product.getGdsmst_rackcode().startsWith("030011")){%>
					    	 <a href="/gdscoll/freegdscoll.jsp?id=<%= product.getId() %>" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/SEP/diydp.gif"/></a>
              <%} %>
                          </p>
         <p style="height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;" ><a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank" style="font-size:12px; color:#606060; "><%=StringUtils.getCnSubstring(Tools.clearHTML(product.getGdsmst_gdsname()),0,54)%></a></p>
             
        
<div class="clear"></div>
		<%
		  Comment com=null;
          List<Comment> lists= CommentHelper.getCommentListByLevel(product.getId(),0,1);
          if(lists!=null&&lists.size()>0&&lists.get(0)!=null)
          {
        	com=lists.get(0);
          }
        if(com!=null){%>
      	  <div class="lb" title="<%= com.getGdscom_content() %>"><b><%= CommentHelper.GetCommentUid(com.getGdscom_uid())+"：" %></b><a href="/product/<%= product.getId() %>?st=com#cmt" target="_blank" rel="nofollow"><%= StringUtils.getCnSubstring(com.getGdscom_content(),0,45) %></a></div>
        <%  }else{%>
      	<div class="lb" ><b>暂无评论！！！</b></div>  
        <%}
    %>
    <%
                  //获取搭配浮层
                  
                  if(gdscolllist!=null&&gdscolllist.size()>0)
                  {%>

                	  <div  id="floatdp<%= count %>" onmouseover="mdmover('<%= count %>')" onmouseout="mdm_out('<%= count%>')">

                      </div>
                  <%}
              %>
    </li>
    	<%	 }
    	 }%>
    	 </ul>
</div>
</div>
    	 
    <%
     }else{
    	 out.print("没有满足条件的推荐商品！");
     }
     %>
     

     <!-- 中间内容结束 -->
     <div class="clear"></div>
     <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
    <script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script type="text/javascript">
$(document).ready(function() {
    $(".newlist").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
});

</script>
</body>
</html>

