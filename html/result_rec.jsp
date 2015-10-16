<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%!public static int getCommentListNew(String productId ,Date times){
	if(Tools.isNull(productId)) return 0;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdscom_gdsid", productId));
	listRes.add(Restrictions.eq("gdscom_status", new Long(1)));		
    Calendar c=Calendar.getInstance();
    c.setTime(times);
	c.add(Calendar.DATE,-20);
	listRes.add(Restrictions.ge("gdscom_createdate", c.getTime()));
	return Tools.getManager(Comment.class).getLength(listRes);
}
public static ArrayList<CommentGroup> getCommentGroupListBygdsid(String gdsid)
{
	   ArrayList<CommentGroupSub> rlist=new   ArrayList<CommentGroupSub>();
	   List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	   if(gdsid!=null&&gdsid.length()>0&&Tools.isNumber(gdsid))
	   {
		  clist.add(Restrictions.eq("commentgroupsub_gdsid",gdsid));
		  clist.add(Restrictions.eq("commentgroupsub_flag",new Long(1)));
	   }
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.desc("commentgroupsub_createtime"));
		List<BaseEntity> blist=Tools.getManager(CommentGroupSub.class).getList(clist, olist, 0, 10000);
	
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
				  rlist.add((CommentGroupSub)b); 
		         
				}
			}
		}
		else return null;
		ArrayList<CommentGroup> cglist1=new ArrayList<CommentGroup>();
		if(rlist!=null&&rlist.size()>0)
		{
			for(CommentGroupSub cgs:rlist)
			{
				if(cgs!=null)
				{
					CommentGroup cg=(CommentGroup)Tools.getManager(CommentGroup.class).get(cgs.getCommentgroupsub_cgid().toString());
					if(cg!=null&&cg.getCommentgroup_flag()!=null&&cg.getCommentgroup_flag().longValue()==1){
						cglist1.add(cg);
					}
					
				}
			}
			return cglist1;
		}
		else {
			return null;
		}
}
public static ArrayList<CommentGroupSub> getCommentGroupSubList(String subid)
{
	 ArrayList<CommentGroupSub> rlist=new   ArrayList<CommentGroupSub>();
	   List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	   if(subid!=null&&subid.length()>0&&Tools.isNumber(subid))
	   {
		  clist.add(Restrictions.eq("commentgroupsub_cgid",new Long(subid)));
		  clist.add(Restrictions.eq("commentgroupsub_flag",new Long(1)));
	   }
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.desc("commentgroupsub_createtime"));
		List<BaseEntity> blist=Tools.getManager(CommentGroupSub.class).getList(clist, olist, 0, 100);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
				rlist.add((CommentGroupSub)b); 
				}
			}
		}
		return rlist;
}
public static int getCommentcount(String gdsid)
{
	int count=0;
    if(gdsid==null||gdsid.length()<=0||!Tools.isNumber(gdsid))
    {
    	return count;
    }
    Product product=ProductHelper.getById(gdsid);

    ArrayList<CommentGroup> cglist=new ArrayList<CommentGroup>();
    cglist=getCommentGroupListBygdsid(gdsid);
  
    if(cglist!=null&&cglist.size()>0)
    {
    	for(CommentGroup cg:cglist)
    	{
    		if(cg!=null&&cg.getCommentgroup_flag()!=null&&cg.getCommentgroup_flag().longValue()==1)
    		{
    			ArrayList<CommentGroupSub> cgslist=getCommentGroupSubList(cg.getId());
    			if(cgslist!=null&&cgslist.size()>0)
    			{
    				for(CommentGroupSub cgs:cgslist)
    				{
    					if(cgs!=null&&cgs.getCommentgroupsub_flag()!=null&&cgs.getCommentgroupsub_flag().longValue()==1
    							&&cgs.getCommentgroupsub_gdsid()!=null&&cgs.getCommentgroupsub_gdsid().length()>0&&!cgs.getCommentgroupsub_gdsid().equals(gdsid))
    					{
    						Product p=ProductHelper.getById(cgs.getCommentgroupsub_gdsid().trim());
    						if(p!=null)
    						{
    							Date times=product.getGdsmst_createdate()!=null?product.getGdsmst_createdate():new Date();
    							count+=getCommentListNew(cgs.getCommentgroupsub_gdsid(),times);
    						}
    						
    					}
    				}
    			}
    		}
    	}
    }
    count+=CommentHelper.getCommentLength(gdsid);
    return count;
}
public static String getImageTo200250(Product product){
	String img = (product != null ? product.getGdsmst_img200250() : null);
	if(!Tools.isNull(img)) 
	{
		 if(img!=null&&img.startsWith("/shopimg/gdsimg")){
			 img = "http://images1.d1.com.cn"+img.trim();
			}else{
				img = "http://images.d1.com.cn"+img.trim();
			}
	}
	
	return img;
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
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css"  />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart2014.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/result.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/result2014.css")%>" rel="stylesheet" type="text/css"  />

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
    
<div class="listbody resultw">
<!--列表开始-->

  <div class="r_list m_t10" id="r_list">
  <ul class="m_t10">
<%SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
String	nowtime2= DateFormat.format( new Date());
         int count=0;
    	 for(PromotionProduct pp:list) {
    		 Product goods=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
    		 count++;
      	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
      	   String id = goods.getId();
      	   String shopcode=goods.getGdsmst_shopcode();
      	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
      	   long currentTime = System.currentTimeMillis();
      	   boolean ismiaoshao=false; 
      	   boolean issgflag=false; 
      	   String brandname=goods.getGdsmst_brandname();
      	String gname=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname().trim()),0,64) ;
      	String gtitle="";
      	if(gname.length()<32){
      	 gtitle=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_title()),0,(32-gname.length())*2) ;
      	}
      	
      			//ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(shopcode);
      			//String shopname="";
      			//if(shpmst!=null)shopname=shpmst.getShpmst_shopname();
      			ismiaoshao=CartHelper.getmsflag(goods);
      		boolean	clsflag=false;
      	
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
int comnum= getCommentcount(id);
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
             
     </div>
     </li>
      <%
         } %>
   </ul>
    <div class="clear"></div>
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
</script>
</body>
</html>

