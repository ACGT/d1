<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
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
    		        String imgurl=ProductHelper.getImageTo200(p);
	                sb.append(" <div class=\"lf\">");
	                sb.append("<p style=\"z-index:999;text-align:center;\"><a href=\"http://www.d1.com.cn/product/").append(p.getId()).append("\" target=\"_blank\">");
    		        sb.append("<img src=\"").append(imgurl).append("\" width=\"200\" height=\"200\" onmouseover=\"mdm_over('"+p.getId()+"')\" onmouseout=\"mdm_out('"+p.getId()+"')\"/>");
    		        sb.append("</a></p>");
    		        sb.append("<p class=\"retime\" id=\"black_"+p.getId()+"\" onmouseover=\"mdm_over('"+p.getId()+"')\" onmouseout=\"mdm_out('"+p.getId()+"')\" style=\"display:none;\">");
    		        sb.append("<a href=\"http://www.d1.com.cn/product/"+p.getId()+"\" target=\"_blank\" style=\"font-size:12px; color:#fff; \">");
    		        sb.append(Tools.substring(p.getGdsmst_gdsname(), 54));
    		        sb.append("</a></p>");
    		        sb.append(" <p style=\"height:35px; font-size:13px; color:#999999; \">");
    		        sb.append(" <span class=\"newspan\"><font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>￥"+Tools.getFormatMoney(p.getGdsmst_memberprice().floatValue())+"</b></font>&nbsp;&nbsp;");
    		        sb.append("<font style=\"text-decoration:line-through;\">￥"+Tools.getFormatMoney(p.getGdsmst_saleprice().floatValue())+"</font></span>");
    		        sb.append("<span class=\"newspan1\"><a href=\"http://www.d1.com.cn/product/"+p.getId()+"#cmt2\" target=\"_blank\">");
    		        sb.append("评论("+CommentHelper.getCommentLength(p.getId())+")</a></span> </p>");
    		        sb.append("</div><div class=\"clear\"></div>");
    		        Comment com=null;
                    List<Comment> list= CommentHelper.getCommentList(p.getId(),0,1000);
                    if(list!=null&&list.size()>0)
                    {
                    	for(Comment c:list)
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
                    		for(Comment c:list)
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
                    			for(Comment c:list)
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
                 
                      if(com!=null)
                      {
                    	sb.append("<div class=\"lb\" title=\""+ com.getGdscom_content() +"\"><b>"+ CommentHelper.GetCommentUid(com.getGdscom_uid())+"：</b>"+ StringUtils.getCnSubstring(com.getGdscom_content(),0,45)+"</div>");
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>畅销商品-YOUSOO</title>
<meta name="description" content="D1优尚网是国内唯一在线销售YOUSOO商品，提供YOUSOO畅销商品产品的最新报价、评论、导购、图片等相关信息" />
<meta name="keywords" content="YOUSOO,畅销商品, YOUSOO畅销商品" />
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
    .mleft{ float:left; width:220px; background:#36333e; padding-bottom:45px; height:5725px;+height:5723px;}
    .mleft ul{margin:0px; padding:0px; }
    .mleft ul li{ margin-top:10px;}
    .mright{ width:750px;_width:745px; _overflow:hidden; padding-left:10px; float:left; padding-top:10px; float:left; background:#fff;}
    .newlist {width:740px;overflow:hidden; padding:0px; margin:0px; }
	.newlist ul {width:740px;padding:0px; margin:0px;  margin-top:10px;}
	.newlist li {float:left; margin-right:52px; _margin-right:51px; border:solid 1px #ccc;overflow:hidden; width:210px; overflow:hidden; margin-bottom:10px;  }
	.newlist p {text-align:left; }
	.newlist p strong {font-weight:bold; font-size:15px; color:#a63c4f;margin-right:10px;}
	.newlist .retime {background:rgba(0,0,0,0.5);font-size:12px;text-align:left;line-height:16px;overflow:hidden; bottom:0px; margin-top:-41px; position:relative; width:210px; padding-top:3px; padding-bottom:2px;
	*background:transparent;filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#b3000000,endColorstr=#b3000000); z-index:1111; height:36px; display:none;  }
	.retime a{text-decoration:none; }
	.lf{background-color:#fff; over-flow:hidden; }
	.newlist p .newspan{ display:block; width:120px; height:35px; margin-top:5px; text-align:center; line-height:35px; border-right:solid 1px #f3f3f3; float:left;}
	.newlist p .newspan1{ display:block; width:79px; height:35px; margin-top:5px; text-align:center; line-height:35px; color:#333;float:left;}
	.newlist .lf .di{position:absolute;z-index:999;width:79px;height:79px;border:none;}
	.yslist{ margin-top:10px;}
	.lb{background-color:#f7f7f7;  padding:5px;  width:200px; height:42px; line-height:20px; font-size:12px;color:#7b7b7b; overflow:hidden;
	
</style>
 <script language=javascript>
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

<body>
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
                 <span style=" width:120px;"><a href="http://yousoo.d1.com.cn/"  >商品分类</a></span>
                <span style=" width:125px;"><a href="http://yousoo.d1.com.cn/yscxsp.htm"  style="background:#6e6a78; color:#fff;">畅销商品</a></span>
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
	             
	             <div> <%= getResourse("3097",1,0) %></div>
	             <div class="yslist">
	                <img src="http://images.d1.com.cn/images2012/YOUSOO/images/ysrx1.jpg"/>
	                 <div class="newlist">
	               <%= getProduct("7809",6) %>
	                  </div>
	              </div>
	              <div class="yslist">
	                <img src="http://images.d1.com.cn/images2012/YOUSOO/images/ysrx_10.jpg"/>
	                <div class="newlist">
	                <%= getProduct("7811",6) %>
	                </div>
	              </div>
	              <div class="yslist">
	                <img src="http://images.d1.com.cn/images2012/YOUSOO/images/ysrx_05.jpg"/>
	                 <div class="newlist">
	                <%= getProduct("7810",6) %>
	                </div>
	              </div>
	              <div class="yslist">
	                <img src="http://images.d1.com.cn/images2012/YOUSOO/images/ysrx_14.jpg"/>
	                 <div class="newlist">
	                <%= getProduct("7812",6) %>
	                </div>
	              </div>
	              <div class="yslist">
	                <img src="http://images.d1.com.cn/images2012/YOUSOO/images/ysrx_16.jpg"/>
	                 <div class="newlist">
	                <%= getProduct("7813",6) %>
	                </div>
	              </div>
	              <div class="yslist">
	                <img src="http://images.d1.com.cn/images2012/YOUSOO/images/ysrx_18.jpg"/>
	                 <div class="newlist">
	                <%= getProduct("7814",6) %>
	                </div>
	              </div>
	              <div class="yslist">
	                <img src="http://images.d1.com.cn/images2012/YOUSOO/images/ysrx_20.jpg"/>
	                 <div class="newlist">
	                <%= getProduct("7815",6) %>
	                </div>
	              </div>
	              
	              <div class="yslist">
	                <img src="http://images.d1.com.cn/images2012/YOUSOO/images/ysrx_22.jpg"/>
	                 <div class="newlist">
	                <%= getProduct("7816",3) %>
	                </div>
	              </div>
	              <div class="yslist">
	                <img src="http://images.d1.com.cn/images2012/YOUSOO/images/ysrx_24.jpg"/>
	                 <div class="newlist">
	                <%= getProduct("7817",3) %>
	                </div>
	              </div>
	              
	             </div> 
	              
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
function mdm_over(obj)
{
    document.getElementById("black_"+obj).style.display="block";
}


 function mdm_out(obj)
{
    document.getElementById("black_"+obj).style.display="none";
	
}

$(document).ready(function() {
   // $(".middle_center").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
});

</script>
