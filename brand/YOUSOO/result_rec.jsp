<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/html/public.jsp"%>
<%@include file="/html/getComment.jsp"%>
<%!
    private static String  getCZlog(String code,int length)
    {
		StringBuilder sb = new StringBuilder();
		if(!Tools.isMath(code) || length<=0) return "";
		ArrayList<Promotion> list=new ArrayList<Promotion>();
		list=PromotionHelper.getBrandListByCode(code,length);
		if(list!=null&&list.size()>0&&list.get(0)!=null)
		{
			Promotion p=list.get(0);
			StringBuilder map=new StringBuilder();
			ArrayList<PromotionImagePos> piplist=new ArrayList<PromotionImagePos>();
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("promotionId", p.getId()));
			List<BaseEntity> b_list = Tools.getManager(PromotionImagePos.class).getList(clist, null, 0, 100);
			if(b_list!=null){
				for(BaseEntity be:b_list){
					piplist.add((PromotionImagePos)be);
				}
			}
			
			sb.append("<div class=\"gdscsne_logo\"><img src=\""+p.getSplmst_picstr()+"\" width=\"740\" height=\"478\"  usemap=\"#pimg_1\"/><div class=\"clear\"></div>");
			map.append("<map name=\"pimg_1\" id=\"").append("pimg_1\">");
			
			for(PromotionImagePos pip:piplist)
			{
				
				if(pip!=null)
				{
					
					int left=0;
					int top=0;
					//left=(((i-1)*980)+pip.getPos_x()-24+(Tools.parseInt(pip.getExt1())-pip.getPos_x())/2);
					left=pip.getPos_x()+10;
					if(left>400)
					{
						left=pip.getPos_x()-25;
					}
					top=pip.getPos_y()-35;
					int divtop=0;
					if(top+40>350)
					{
						divtop=350;
					}
					else
						divtop=top+40;
					
						
					map.append("<area shape=\"rect\" coords=\"").append(pip.getPos_x()+",").append(pip.getPos_y()+",").append(pip.getExt1()+",").append(pip.getExt2()).append("\""); 
					Product product=ProductHelper.getById(pip.getProductId());
					if(product!=null)
					{
						map.append("href=\"").append("/product/"+product.getId()).append("\" target=\"_blank\"");
					}
					map.append(">");
					
				}
			}
			sb.append("</div>");
			map.append("</map>");
			
			sb.append(map.toString());
		}
		return sb.toString();
		
}
private static String getResourse(String code,int count,int flag)
{
    StringBuilder sb=new StringBuilder();
    if(code==null||!Tools.isNumber(code)){ return "";}
    ArrayList<Promotion> plist=new ArrayList<Promotion>();
    plist=PromotionHelper.getBrandListByCode(code, count);
    if(plist!=null&&plist.size()>0)
    {
    	sb.append("<ul>");
    	int sum=0;
    	for(Promotion p:plist)
    	{
    		if(p!=null)
    		{
    			sum++;
    			if(flag==1&&sum%3==0){
    			  sb.append("<li style=\"margin-right:0px\">");
    			}
    			else
    			{
    				sb.append("<li>");
    			}
    			sb.append("<a href=\"").append(p.getSplmst_url().replace("http://www.d1.com.cn/brand/YOUSOO/result.jsp", "http://yousoo.d1.com.cn/ysresult.htm").replace("http://www.d1.com.cn/brand/YOUSOO/result_rec.jsp", "http://yousoo.d1.com.cn/ysresult_rec.htm")).append("\" target=\"_blank\">");
    			sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\"/></a></li>");
    		}
    	}
    	sb.append("</ul>");
    }
    return sb.toString();
}


private static String getProduct(String code,int count)
{
	StringBuilder sb=new StringBuilder();
    if(code==null||!Tools.isNumber(code)){ return "";}
    ArrayList<PromotionProduct> pplist=new ArrayList<PromotionProduct>();
    pplist=PromotionProductHelper.getPProductByCode(code, count);
    if(pplist!=null&&pplist.size()>0)
    {
    	sb.append("<ul>");
    	int sum=0;
    	for(PromotionProduct pp:pplist)
    	{
    		if(pp!=null&&pp.getSpgdsrcm_gdsid()!=null&&pp.getSpgdsrcm_gdsid().length()>0)
    		{
    			Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
    			if(p!=null&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0){
    		        sum++;
    		        if(sum%3==0){
    				   sb.append("<li style=\"margin-right:0px;\">");
    		        }
    		        else
    		        {
    		        	 sb.append("<li>");
    		        }
    		        String imgurl="";
    		        if(p.getGdsmst_img240300()!=null)
    		        {
    		        	imgurl=p.getGdsmst_img240300();
    		        }
	                sb.append(" <div class=\"lf\">");
	                sb.append("<p style=\"z-index:999;\"><a href=\"http://www.d1.com.cn/product/").append(p.getId()).append("\" target=\"_blank\">");
    		        sb.append("<img src=\"http://images.d1.com.cn").append(imgurl).append("\" width=\"240\" height=\"300\" onmouseover=\"mdm_over('"+p.getId()+"')\" onmouseout=\"mdm_out('"+p.getId()+"')\"/>");
    		        sb.append("</a></p>");
    		        sb.append("<p class=\"retime\" id=\"black_"+p.getId()+"\" onmouseover=\"mdm_over('"+p.getId()+"')\" onmouseout=\"mdm_out('"+p.getId()+"')\" style=\"display:none;\">");
    		        sb.append("<a href=\"http://www.d1.com.cn/product/"+p.getId()+"\" target=\"_blank\" style=\"font-size:12px; color:#fff; \">");
    		        sb.append(Tools.substring(p.getGdsmst_gdsname(), 54));
    		        sb.append("</a></p>");
    		        sb.append(" <p style=\"height:35px; font-size:13px; color:#999999; \">");
    		        sb.append(" <span class=\"newspan\"><font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>￥"+Tools.getFormatMoney(p.getGdsmst_memberprice().floatValue())+"</b></font>&nbsp;&nbsp;");
    		        sb.append("<font style=\"text-decoration:line-through;\">￥"+Tools.getFormatMoney(p.getGdsmst_saleprice().floatValue())+"</font></span>");
    		        sb.append("<span class=\"newspan1\"><a href=\"http://www.d1.com.cn/product/"+p.getId()+"?st=com#cmt\" target=\"_blank\" rel=\"nofollow\">");
    		        sb.append("评论("+getCommentList(p.getId()).size()+")</a></span> </p>");
    		        sb.append("</div><div class=\"clear\"></div>");
    		        Comment com=null;
                    List<Comment> list= CommentHelper.getCommentListByLevel(p.getId(),0,1);
                    if(list!=null&&list.size()>0&&list.get(0)!=null)
                    {
                    	com=list.get(0);
                    }
                 
                      if(com!=null)
                      {
                    	sb.append("<div class=\"lb\" title=\""+ com.getGdscom_content() +"\"><b>"+ CommentHelper.GetCommentUid(com.getGdscom_uid())+"：</b><a href=\"http://www.d1.com.cn/product/"+p.getId()+"?st=com#cmt\" target=\"_blank\" rel=\"nofollow\">"+ StringUtils.getCnSubstring(com.getGdscom_content(),0,45)+"</a></div>");
                      }
                      else
                      {
                    	sb.append("<div class=\"lb\" ><b>暂无评论！！！</b></div>");  
                      }
            
    		        sb.append("</li>");
			       
    			}
    		}
    	}
    	sb.append("</ul>");
    }
    
    return sb.toString();
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
<title>YOUSOO推荐专区</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<style type="text/css" >
    .middle{background:#585252;+margin-top:10px;}
   .middle_top{ background:url('http://images.d1.com.cn/images2012/YOUSOO/images/ystest1.jpg') repeat-x; height:127px; overflow:hidden;}
    .ysdh{ background:url('http://images.d1.com.cn/images2012/YOUSOO/images/YStest_05_1.jpg'); height:46px; width:980px; line-height:48px; 
           font-size:16px;   margin:0px; padding:0px;}
    .ysdh span{ display:block; text-align:center; float:left;}
    .ysdh a{ color:#aaa8b3;padding:3px 6px; font-family:'微软雅黑';}
    .ysdh a:hover{color:#aaa8b3; text-decoration:underline; }
    .middle_center{ width:980px; margin:0px auto;}
    .mleft{ float:left; width:220px; background:#36333e; padding-bottom:45px;height:2355px;+height:2343px;}
    .mleft ul{margin:0px; padding:0px; }
    .mleft ul li{ margin-top:10px;}
    .mright{ background:#fff; width:730px;_width:725px; _overflow:hidden; padding-left:30px; float:left; padding-top:10px; float:left;}
    /*滚动图片样式*/
	.scrollimglist{ width:740px; height:365px; }
	.container{ overflow:hidden;  width:740px; height:365px; }
	#CenterImg{overflow:hidden;padding:1px;}
	#CenterImg img{ border:none;}
	#ImgTable{table-layout:auto;}
	#ImgTable tr td a img{margin:1px;margin-top:0px;padding:0px;}
	#idNum{float:right;position:absolute;top:342px;right:18px;}
	#idNum li{float:left;list-style:none;color: #000;text-align: center;line-height: 15px;width: 15px;height: 15px;	font-family:"微软雅黑";font-size: 13px; font-weight:bold; cursor: pointer;margin: 2px;background:#f3f3f5;}
	#idNum li.on{line-height: 15px;width: 17px;height: 16px;color:#fff;background:#8a2b3f;}
    
    .rxtj ul{ margin:0px; padding:0px; margin-top:5px;}
    .rxtj ul li{ width:240px; height:300px; float:left; margin-right:10px; margin-bottom:10px;}
    .gdscsne_logo{ margin:0px auto; width:980px;}
    .logofloat {width:970px; height:70px;  background:none;background-color: #fff;position:absolute; margin:0px auto;  margin-top:-85px; margin-left:5px;  -moz-border-radius: 10px; -webkit-border-radius: 10px;  border-radius: 10px;}
    .logofloat ul{ width:920px; height:70px; margin:0px auto; text-align:center; overflow:hidden; padding-left:20px;}
    .logofloat ul li{ width:150px; overflow:hidden; height:62px; padding-top:8px;line-height:18px; font-size:13px;  float:left; margin-right:50px; text-align:left;}
    
    .newlist {width:740px;overflow:hidden; padding:0px; margin:0px; }
	.newlist ul {width:740px;padding:0px; margin:0px;  margin-top:10px;}
	.newlist li {float:left; margin-right:30px; border:solid 1px #ccc;width:210px; height:305px; text-align:center; overflow:hidden; margin-bottom:10px;  }
	.newlist p {text-align:left; }
	.newlist p strong {font-weight:bold; font-size:15px; color:#a63c4f;margin-right:10px;}
	.newlist .retime {background:rgba(0,0,0,0.5);font-size:12px;text-align:left;line-height:16px;overflow:hidden; bottom:0px; margin-top:-41px; position:relative; width:210px; padding-top:3px; padding-bottom:2px;
	*background:transparent;filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#b3000000,endColorstr=#b3000000); z-index:1111; height:36px; display:none;  }
	.retime a{text-decoration:none; }
	.lf{background-color:#fff; over-flow:hidden; }
	.newlist p .newspan{ display:block; width:120px; height:35px; margin-top:5px; text-align:center; line-height:35px; border-right:solid 1px #f3f3f3; float:left;}
	.newlist p .newspan1{ display:block; width:79px; height:35px; margin-top:5px; text-align:center; line-height:35px; color:#333;float:left;}
	.lb{background-color:#f7f7f7;  padding:5px;  width:210px; height:42px; line-height:20px; font-size:12px;color:#7b7b7b; overflow:hidden;
	 text-align:left; vertical-align:middle; padding-top:8px;}
	.newlist .lf .di{position:absolute;z-index:999;width:79px;height:79px;border:none;}
</style>
<script type="text/javascript" language="javascript">
function mdm_over(obj)
{
    document.getElementById("black_"+obj).style.display="block";
}


 function mdm_out(obj)
{
    document.getElementById("black_"+obj).style.display="none";
	
}

 function view_time2(){
		var startDate= new Date();
		var endDate= new Date("2012/07/20 15:00:00");
		var lasttime=(endDate.getTime()-startDate.getTime())/1000;
	    if(lasttime>0){
	    	var the_D=Math.floor((lasttime/3600)/24)
	        var the_H=Math.floor((lasttime-the_D*24*3600)/3600);
	        var the_M=Math.floor((lasttime-the_D*24*3600-the_H*3600)/60);
	        var the_S=Math.floor((lasttime-the_H*3600)%60);
	       if(the_D!=0){$("#topd").text(the_D);}
	        if(the_D!=0 || the_H!=0) {$("#toph").text(the_H);}
	        if(the_D!=0 || the_H!=0 || the_M!=0) {$("#topm").text(the_M);}
	        $("#tops").text(the_S);
	       // $getid(objid).innerHTML = html+html2+html1;
	        lasttime--;
	    }
	}	
	$(document).ready(function() {
		var startDate= new Date();
		var endDate= new Date("2012/07/20 15:00:00");
		var lasttime=(endDate.getTime()-startDate.getTime())/1000;
	    if(lasttime>0){
	  setInterval(view_time2,1000);
	    }
	});
		</script>
</head>

<body >
<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<div class="clear"></div>
	<!-- 头部结束-->

    <!-- 中间位置 -->
    <div class="middle">
        <div class="middle_top">
           <div style="width:980px; margin:0px auto;">
              <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_03.jpg"/>
              <div class="ysdh">
                  <span style=" width:120px;"><a href="http://yousoo.d1.com.cn/"   style="background:#6e6a78; color:#fff;">商品分类</a></span>
                <span style=" width:125px;"><a href="http://yousoo.d1.com.cn/yscxsp.htm" >畅销商品</a></span>
                 <span style=" width:120px;"><a href="http://yousoo.d1.com.cn/ys/brandstory.htm"  >品牌故事</a></span>
               
                 <div class="clear"></div>
              </div>
           </div>
           </div>
           <div class="middle_center">
              <div class="mleft">
                  <table>
                      <tr>
                          <td  style="padding-left:24px;">
                              <div style=" margin-top:45px;">
                                  <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_08.jpg"/>
                                  <%=getResourse("3090",15,0) %>
                              </div>
                              <div style=" margin-top:45px;">
                                  <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_22.jpg"/>
                                 <%=getResourse("3091",15,0) %>
                              </div>
                               <div style=" margin-top:45px;">
                                  <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_28.jpg"/>
                                  <%=getResourse("3092",15,0) %>
                              </div>
                               <div style=" margin-top:45px;">
                                  <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_35.jpg"/>
                                  <%=getResourse("3093",15,0) %>
                              </div>
                          </td>
                      </tr>
                  </table>
              </div>
              
              
              <div class="mright">
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
     <div style="width:750px; text-align:center;">
        <div class="newlist" style="overflow:hidden;  padding-bottom:18px; ">
            <ul>
            <%
            int count=0;
    	 for(PromotionProduct pp:list) {
    		 Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
    		 if(product!=null&&product.getGdsmst_validflag()!=2&&product.getGdsmst_validflag()!=4){
    			 count++;
    			 String title = Tools.clearHTML(pp.getSpgdsrcm_gdsname());
     			 long endTime = Tools.dateValue(product.getGdsmst_discountenddate());
     			 long currentTime = System.currentTimeMillis();
     			 String theimgurl="";
    			 if(product.getGdsmst_rackcode().length()>=6&&(product.getGdsmst_rackcode().substring(0,3).equals("020")||product.getGdsmst_rackcode().substring(0,3).equals("030"))){
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
					if(count%3==0)
					{%>
						<li style="margin-right:0px;">
					<%}
					else
					{%>
						<li>
					<%}
				
					 %>
						
					 <div class="lf">
					 <% 
    		if(product.getGdsmst_rackcode().length()>=6&&(product.getGdsmst_rackcode().substring(0,3).equals("020")||product.getGdsmst_rackcode().substring(0,3).equals("030")))
           					{
           					%>
           					   <p style="z-index:999; padding-left:5px;"><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(product) %>" target="_blank" >
           				
           							<img src="<%=theimgurl  %>" width="200" height="250" onmouseover="mdm_over('<%= product.getId()%>')" onmouseout="mdm_out('<%= product.getId()%>')"/>
           	           
           				<%	}
           				    else
           				    {%>
           				    <p style="z-index:999; padding-top:5px; padding-bottom:5px; padding-left:5px;"><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(product) %>" target="_blank" >
           				
           				    	<img src="<%= ProductHelper.getImageTo200(product) %>" width="200" height="200" onmouseover="mdm_over('<%= product.getId()%>')" onmouseout="mdm_out('<%= product.getId()%>')"/>
           	           
           				    <%}%>
				
		</a>
	</p>	
		
		<p class="retime" id="black_<%= product.getId()%>" onmouseover="mdm_over('<%= product.getId()%>')" onmouseout="mdm_out('<%= product.getId()%>')"> <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(product) %>" target="_blank" style="font-size:12px; color:#fff; "><%=StringUtils.getCnSubstring(Tools.clearHTML(pp.getSpgdsrcm_gdsname()),0,60)%></a> </p>
			           <p style="height:35px; font-size:13px; color:#999999; ">
			               <span class="newspan"><font color="#b80024" style=" font-family:'微软雅黑'"><b>￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %></b></font>&nbsp;&nbsp;
			               <font style="text-decoration:line-through;">￥<%=Tools.getFormatMoney(product.getGdsmst_saleprice()) %></font></span>
			               
			               <span class="newspan1"><a href="http://www.d1.com.cn/product/<%= product.getId() %>#cmt2" target="_blank" rel="nofollow">评论(<%= CommentHelper.getCommentLength(product.getId()) %>)</a></span>
			           </p>
		

</div>  <div class="clear"></div>
		<%
		 Comment com=null;
        List<Comment> clist= CommentHelper.getCommentList(product.getId(),0,1000);
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
        if(com!=null){%>
      	  <div class="lb" title="<%= com.getGdscom_content() %>"><b><%= CommentHelper.GetCommentUid(com.getGdscom_uid())+"：" %></b><%= StringUtils.getCnSubstring(com.getGdscom_content(),0,45) %></div>
        <%  }else{%>
      	<div class="lb" ><b>暂无评论！！！</b></div>  
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
  </div>   

     <!-- 中间内容结束 -->
	              
	              
              </div>
              
           </div>
           
           <div class="clear">
                   
           </div>
    </div>
    <!-- 中间位置结束 -->
    <%@include file="/inc/foot.jsp" %>
</body>
</html>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script type="text/javascript">
$(document).ready(function() {
    $(".newlist").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
});


</script>
