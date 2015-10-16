<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>D1-优尚网，优尚团----团购详细</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/tuannew.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/comment.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<style type="text/css">
/*comment*/
#comment .mt{height:28px;line-height:28px;padding:0 10px 8px;background:url(http://images.d1.com.cn/images2011/commentimg/bg_hotsale.gif) repeat-x 0 -552px;border-top:2px solid #BE0000;}
#comment .mt h2{float:left;color:#C30;}
#comment .mt span{color:#999;}
#comment .item{position:relative;padding:0 0 2px 130px;margin-bottom:10px;zoom:1;}
#comment .user{position:absolute;top:10px;left:0;width:130px;text-align:center;color:#999;}
#comment .user a{color:#005aa0;}
#comment .u-icon img{border:2px solid #EAEAEA;}
#comment .i-item{padding:10px 15px 5px;border:1px solid #C07782;}
#comment .o-topic{padding:0 0 2px;margin-bottom:10px; border-bottom:1px dotted Gray;overflow:hidden;zoom:1;}
#comment .topic{float:left; padding-top:2px;}
#comment .star{float:left;margin:2px 0 0 5px;}
</style>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script language="javascript" type="text/javascript">
	//限时抢购
	var the_s=new Array();
	
	function $getid(id)
	{
	    return document.getElementById(id);
	}

	function view_time1(the_s_index,objid){
		 if(the_s[the_s_index]>=0){
	        var the_D=Math.floor((the_s[the_s_index]/3600)/24)
	        var the_H=Math.floor((the_s[the_s_index]-the_D*24*3600)/3600);
	        var the_M=Math.floor((the_s[the_s_index]-the_D*24*3600-the_H*3600)/60);
	        var the_S=(the_s[the_s_index]-the_H*3600)%60;
	        html = "倒计时:";
	         if(the_D!=0) html += '<font color="#b51014" style="font-size:19px; font-weight:bold; padding-left:2px; padding-right:2px; ">'+the_D+"</font>天";
	        if(the_D!=0 || the_H!=0) html += '<font color="#b51014" style="font-size:19px; font-weight:bold; padding-left:2px; padding-right:2px; ">'+(the_H)+"</font>小时";
	        if(the_D!=0 || the_H!=0 || the_M!=0) html += '<font color="#b51014" style="font-size:19px; font-weight:bold; padding-left:2px; padding-right:2px; ">'+the_M+"</font>分";
	        html += '<font color="#b51014" style="font-size:19px; font-weight:bold; padding-left:2px; padding-right:2px; ">'+the_S+"</font>秒";
	        $getid(objid).innerHTML = html;
	        the_s[the_s_index]--;
	    }else{
	        $getid(objid).innerHTML = "已结束";
	    }
	}
	function pro_comment(id,pg){
		$('#commentContent').html("<div align='center'><img src='http://images.d1.com.cn/images2012/New/Loading.gif' /></div>");
		$.post("/ajax/product/commentList.jsp",{"id":id,"pg":pg,"m":new Date().getTime()},function(data){
			$('#commentContent').html(data);
		});
	}
	function addCart(obj){
		$.inCart(obj,{ajaxUrl:'/ajax/flow/listTuanInCart.jsp'});
	}
	
	
	function addNotCart()
	{
		$.ajax({
	        type: "post",
	        dataType: "html",
	        url: "/ajax/tuan/tuanNotInCart.jsp",
	        cache: false,
	        data:{},
	        error: function(XmlHttpRequest){
	            alert("对不起，抢购失败！");
	        },
	        success: function(strHtml){
	        		$.alert(strHtml,'提示',function(){
	        		this.location.reload();

	        		});
	        },beforeSend: function(){
	        }
	    });	
	}
	
</script>
</head>
<body>
   <div id="wrapper">
	<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
	<!-- 中间内容 -->
	<div class="center">
       <div  class="left">
    
    <%
      String tgrpmst_id="";
      if(!Tools.isNull(request.getParameter("ID"))){
		 tgrpmst_id=request.getParameter("ID");
      }
      ArrayList<ProductGroup> list=new ArrayList<ProductGroup>();
      if(tgrpmst_id.trim().length()!=0){
    	 //list=ProductGroupHelper.getProductGroupsById(tgrpmst_id);
    	 //额外
    	
 		
 		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
 		clist.add(Restrictions.lt("tgrpmst_starttime", new Date()));
 		clist.add(Restrictions.ge("tgrpmst_endtime", new Date()));
 		clist.add(Restrictions.eq("id", tgrpmst_id));

 		
 		//加入排序条件，按加入购物车时间排序
 		List<Order> olist = new ArrayList<Order>();
 		olist.add(Order.desc("tgrpmst_priority"));
 		olist.add(Order.desc("id"));
 		List<BaseEntity> lists = Tools.getManager(ProductGroup.class).getList(clist, olist, 0, 100);
 		
 		if(lists!=null||lists.size()>0){
	 		for(BaseEntity be:lists){
	 			list.add((ProductGroup)be);
	 		}
 		}
    	 //额外
  		
    	 if(list!=null&&list.size()>0)
    	 {
    		 ProductGroup product=list.get(0);
			 String ProductName=product.getTgrpmst_gdname();
			 if(ProductName.length()>300){
				 ProductName=ProductName.substring(0,300);
			 }
			 Long lastcount=product.getTgrpmst_supreme().longValue()-product.getTgrpmst_relcount().longValue();
			 String sprice=ProductGroupHelper.getRoundPrice(product.getTgrpmst_sprice().floatValue());
			 String nprice=ProductGroupHelper.getRoundPrice(product.getTgrpmst_nprice().floatValue());
			 String pprice=ProductGroupHelper.getRoundPrice(product.getTgrpmst_nprice().floatValue()-product.getTgrpmst_sprice().floatValue());
			 double dl= Tools.getDouble(product.getTgrpmst_sprice().doubleValue()*10/product.getTgrpmst_nprice().doubleValue(),1);
			 String fl=ProductGroupHelper.getRoundPrice((float)dl);
		     SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    	 %>
    	 <div class="left_sub1">
	        <h2><span style=" color:#892d46; ">今日团购：</span><%= ProductName %></h2><br/>
			<div class="left_content">
			
			   <div class="left_content1">
     <% //if (product.getTgrpmst_endtime().before(new Date()) || product.getTgrpmst_state().intValue()!=1)
         if(1==0)
     {%>
		     <a href="tuandetail.jsp?ID=<%= product.getId() %>" target="_blank"><img src="http://images.d1.com.cn/Index/over.gif" /><span>￥<%=sprice %></span></a>
			 
			  <%}
		    else if (lastcount.intValue()<=10){
		    	%>
		    	 <a href="tuandetail.jsp?ID=<%= product.getId() %>" target="_blank"><img src="http://images.d1.com.cn/Index/end.gif" /><span>￥<%=sprice %></span></a>
			
		    <%}
		    else
		    {
		        if(product.getTgrpmst_gdsid().equals("01205254"))
		        {%>
		         <a href="###" attr="<%=product.getId() %>" onclick="addNotCart();"><img src="http://images.d1.com.cn/Index/buy.gif" /><span><font style=" font-family:'微软雅黑';">￥</font><%=sprice %></span></a>
				
		       <% }
		        else
		        {
		    %>
		    	 <a href="###" attr="<%=product.getId() %>" onclick="addCart(this);"><img src="http://images.d1.com.cn/Index/buy.gif" /><span><font style=" font-family:'微软雅黑';">￥</font><%=sprice %></span></a>
			
		    <%  }
		    }
			  %>
			
		       
			  <br/>
			   <table cellspacing="0" cellpadding="0" border="0">
			   <tr><td height="32" style="border-right:dashed 1px #c0a886;"></td><td style="border-right:dashed 1px #c0a886;"></td><td></td>
			   </tr>
			       <tr>
				       <td width="69" style="border-right:dashed 1px #c0a886; font-size:12px; font-weight:bold; text-align:center; color:#030200;">市场价</td>
					   <td width="69" style="border-right:dashed 1px #c0a886; font-size:12px; font-weight:bold; text-align:center; color:#030200;">折扣</td>
					   <td width="70" style="font-size:12px; font-weight:bold; text-align:center; color:#030200;"><font color="#b51014">节省</font></td>
				   </tr>
				   <tr>
				      <td height="35" style="border-right:dashed 1px #c0a886; font-size:12px; font-weight:bold; text-align:center; color:#030200;">￥<%=nprice   %></td>
					  <td style="border-right:dashed 1px #c0a886; font-size:12px; font-weight:bold; text-align:center; color:#030200;"><%=fl%>折</td>
					  <td style="font-size:12px; font-weight:bold; text-align:center; color:#030200;"><font color="#b51014">￥<%= pprice %></font></td>
				   </tr>
				   
			   </table>
		   </div>
		   <div class="left_content2">
		       <table>
			     <tr><td width="10"></td><td height="20" ></td></tr>
                 <tr><td></td>
				    <td style=" font-size:13px;">距离团购结束还有：</td>
				</tr>
				<tr><td></td><td height="2" ></td></tr>
                 <tr><td></td>
				 <td> <span id="tjjs_<%=0%>"></span>
						    <%
						       
						       String	nowtime= DateFormat.format( new Date());
						       String endtime= DateFormat.format(product.getTgrpmst_endtime());
						    %>
						     <SCRIPT language="javascript">
                             var startDate= new Date("<%=nowtime%>");
                             var endDate= new Date("<%=endtime%>");
                             the_s[<%=0%>]=(endDate.getTime()-startDate.getTime())/1000;
                             setInterval("view_time1(<%=0%>,'tjjs_<%=0%>')",1000);
                             </SCRIPT></td>
				 </tr>
			   </table>
		   </div>
		   <div class="left_content3">
		       <table>
			     <tr><td width="10"></td><td height="20" ></td></tr>
                 <tr><td></td>
				    <td style=" font-size:15px;">已经有<font color="#b51014" style="font-size:25px; padding-left:2px; padding-right:2px;"><%= product.getTgrpmst_hotmodulus()%> </font>人购买</td>
				</tr>
				<tr><td></td><td height="2" ></td></tr>
                 <tr><td></td>
				 <td style=" font-size:13px;">数量有限，赶快下单哦。。。</td>
				 </tr>
			   </table>
		   </div>
			
			</div>
			<div style="float:left;width:460px; margin-left:16px; _margin-left:10px; margin-top:-20px; _margin-top:-20px; "  >
			   <img src="<%=product.getTgrpmst_pic()%>" alt="<%=ProductName%>" width="460" height="418" />
			</div>
		</div>
		<div class="left_subdetail" style=" font-weight:normal;">
		 <%= product.getTgrpmst_info()  %>

		</div>
		
		                   <div  style=" border:solid 1px #c2c2c2; margin-top:10px;">
					    	<%
					    	int commentLength = CommentHelper.getCommentLength(product.getTgrpmst_gdsid());
					    	int PAGE_SIZE = 10 ;
					    	PageBean pBean = new PageBean(commentLength,PAGE_SIZE,1);
					    	
					    	List<Comment> commentlist = CommentHelper.getCommentList(product.getTgrpmst_gdsid(),pBean.getStart(),PAGE_SIZE);
					    	if(commentlist != null && !commentlist.isEmpty()){
					    		//int size = commentlist.size();
					    		int avgscore=CommentHelper.getLevelView(product.getTgrpmst_gdsid());
					    	%>
					    	<div style="background-color:#F4F4F4;">
								<table cellpadding="0" cellspacing="0" style="margin-left:10px; margin-right:20px;  margin-bottom:10px; width:95%; line-height:28px;">
									<tr>
					                  <td><div style="float:left">
					                        <div style="float:left;font-size:12px">购买过的顾客评分 |</div>
					                         <div class="sa<%=avgscore %>" style="float:left;" ></div>
					                       </div></td>
					                     <td  align="right"></td>
					                 </tr>
								</table>
							</div>
							<div style="padding-top:10px; width:100%; padding-bottom:20px;" id="commentContent">
							
							  <table cellpadding="0" cellspacing="0" style="font-size:12px; width:100%">
							   
							   
							          <%
						 for(Comment comment:commentlist){
							    User user = UserHelper.getById(String.valueOf(comment.getGdscom_mbrid()));
								if(user == null) continue;
								String hfusername = CommentHelper.GetCommentUid(comment.getGdscom_uid());
								String level = UserHelper.getLevelText(user);
							 %>
							  <tr>
								 <td width="120" style=" text-align:center; line-height:15px;"">
								    <img src="<%=UserHelper.getLevelImage(level) %>" width="70" height="70" />  
								    <br/>
								    <%=hfusername %>
								    <br/>
								    <%=level %>
								 </td>
								 <td>
								     <table style=" border:solid 1px #c07782; ">
								         <tr><td width="10"></td><td width="400" height="30" style=" border-bottom:dashed 1px #c2c2c2; padding-left:10px;">评分： <img src="/http://images.d1.com.cn/images2012/New/user/gds_star<%=comment.getGdscom_level() %>.jpg" /> </td><td style=" border-bottom:dashed 1px #c2c2c2; padding-right:10px;"><%=Tools.stockFormatDate(comment.getGdscom_createdate()) %></td><td width="10"></td></tr>
								         <tr><td width="10"><img src="http://images.d1.com.cn/images2012/New/tuan/jian.jpg" style="position:absolute; margin-left:-18px; margin-top:-16px;"></td><td colspan="2" style=" border-bottom:dashed 1px #c2c2c2; padding:10px"><%=comment.getGdscom_content() %></td><td width="10"></td></tr>
								         <tr><td width="10"></td><td colspan="2" style="padding:10px;"><%
							                            if(!Tools.isNull(comment.getGdscom_replyContent())){
							                            	 %>	
							                            	 <p style="color:#892D3D;line-height:26px;" >D1优尚回复：<%=comment.getGdscom_replyContent() %></p>
							                          <%  }
							                           %></td><td width="10"></td></tr>
							                           <tr><td colspan="4" height="20"></td></tr>
								     </table>
								 </td>
							    <td width="10"></td>
							  </tr>
							  <tr><td colspan="4" height="10"></td></tr>
							   <% }
							          %>
							          <tr><td colspan="4" heihgt="10"></td></tr>
							          <%
							          
							if(pBean.getTotalPages()>1){ %>
							<tr>
								<td colspan="4"><div class="GPager">
						           	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
						           	<%if(pBean.getCurrentPage()>1){ %><a href="#cmtCnt" onclick="pro_comment('<%=product.getTgrpmst_gdsid() %>',1);">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="#cmtCnt" onclick="pro_comment('<%=product.getTgrpmst_gdsid() %>',<%=pBean.getPreviousPage() %>);">上一页</a><%}%><%
						           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
						           		if(i==1){
						           		%><span class="curr"><%=i %></span><%
						           		}else{
						           		%><a href="#cmtCnt" onclick="pro_comment('<%=product.getTgrpmst_gdsid() %>',<%=i %>);"><%=i %></a><%
						           		}
						           	}%>
						           	<%if(pBean.hasNextPage()){%><a href="#cmtCnt" onclick="pro_comment('<%=product.getTgrpmst_gdsid() %>',<%=pBean.getNextPage() %>);">下一页</a><%}%>
						           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="#cmtCnt" onclick="pro_comment('<%=product.getTgrpmst_gdsid() %>',<%=pBean.getTotalPages() %>);">尾页</a><%} %>
						           </div></td>
							</tr><%
							   }
							          %>
							           </table>
							</div>
							          <%
							         
					    	}
					    	
							          else
							          {
							        	  out.print("还没有会员进行评论");
							          }
							   %>
							  
						
					</div>
							
    	 <%}
      
      else
      {
      %>
      <div class="left_sub1"><h2><span style=" color:#7b3442;">该团购信息不存在<a href="index.jsp">&nbsp;&nbsp;&nbsp;<font color='red'>查看今日团购</font></a></h2><br/></div>
		<%}
    
      }
      else
      {
    	  out.print("<font color='red' style=\"font-size:14px;\">没有满足条件的团购商品详细信息！！！</font>");
      }
    	 
    	 %>
      
      
      
      
      
	 
	 </div>
     <div class="right">
	     
	     <% 
	        ArrayList<ProductGroup> lists=null;
	       lists=ProductGroupHelper.getTodayOtherProductGroups();
	        if(lists!=null&&lists.size()>1)
	        {%>
	        <div style="border:solid 1px #c2c2c2; text-align:center; padding-bottom:10px;margin-bottom:10px;">
	           <div style="width:256px; height:30px; background-color:#ebebeb; margin-bottom:10px;line-height:30px; color:#892d46; font-size:15px; font-weight:bold; text-align:left;">
			    &nbsp;&nbsp;其他团购
			  </div>
	        <%
	           for(int i=0;i<lists.size();i++)
	           {
	        	 ProductGroup product=lists.get(i);
	  			 if(!product.getId().equals(tgrpmst_id)) 
	  			 {
	  			 String sprice=ProductGroupHelper.getRoundPrice(product.getTgrpmst_sprice().floatValue());
	  			
	        %>
	        <div style="text-align:center; margin:0px auto; width:236px; margin-bottom:10px; border:solid 1px #c2c2c2;">
		    <a href="tuandetail.jsp?ID=<%= product.getId() %>" target="_blank" style=" z-index:111"><img src="<%= product.getTgrpmst_oldpic() %>" width="236" height="236"/></a>
			<table width="236">
			   <tr><td height="55">
			    <a href="tuandetail.jsp?ID=<%= product.getId() %>" target="_blank" style="position:absolute; margin-left:-5px; +margin-left:-123px; _margin-left:-123px;margin-top:-35px; z-index:9999 "><img src="http://images.d1.com.cn/Index/look.gif" /><span style="font-size:30px; color:#fff; font-family:'微软雅黑'; position:absolute; margin-left:-230px; margin-top:10px; margin-left:-230px;font-weight:normal;">￥<%= sprice %></span></a>
			
			   </td></tr>
			</table>
			
		   </div>
	        	
	        <%}
	           }
	        %>
	        </div>
	        <%
	        }
 
	       
	     %>
	     
	     
	  
	 
	    <div id="ques" style="border:solid 1px #c2c2c2; margin-bottom:15px; padding-bottom:15px;">
		    <div class="ques_title" style="width:256px; height:30px; background-color:#ebebeb; line-height:30px; color:#892d46; font-size:15px; font-weight:bold;">
			    &nbsp;&nbsp;常见问题解答
			</div>
			<br/>
			<a href="help.jsp" target='_blank'>&nbsp;&nbsp;&nbsp;&nbsp;<b>查看全部</b></a>
           
			 <ul>
			     <li style="border-bottom:dashed 1px #ccc; width:210px; height:18px; padding-top:5px;"><a href="help.jsp" target="_blank" style=" color:#04569f; font-size:12px; cursor:hand;"><font color="#000">&nbsp;&nbsp;1.</font>团购商品什么时候发货？</a></li>
				 <li style="border-bottom:dashed 1px #ccc; width:210px; height:18px; padding-top:5px;"><a href="help.jsp" target="_blank" style=" color:#04569f; font-size:12px; cursor:hand;"><font color="#000">&nbsp;&nbsp;2.</font>团购商品怎么算运费呢？</a></li>
				 <li style="border-bottom:dashed 1px #ccc; width:210px; height:18px; padding-top:5px;"><a href="help.jsp" target="_blank" style=" color:#04569f; font-size:12px; cursor:hand;"><font color="#000">&nbsp;&nbsp;3.</font>团购商品可以使用E券吗？</a></li>
			 </ul>
		</div>
		
		<div id="work" style="border:solid 1px #c2c2c2; padding-bottom:15px;">
		    <div class="ques_title" style="width:256px; height:30px; background-color:#ebebeb; line-height:30px; color:#892d46; font-size:15px; font-weight:bold;">
			    &nbsp;&nbsp;商务合作
			</div>
			<table><tr><td height="5"></td></tr></table>
			&nbsp;&nbsp;希望在优尚团组织团购？
			<br/>
			&nbsp;&nbsp;请提交团购信息（要确保价格优势和库存量）<br/>
			&nbsp;&nbsp;<font style=" text-decoration:underline;">ycli@staff.d1.com.cn</font>
			<br/>
			&nbsp;&nbsp;邮件标题是：团购商品提供
		</div>
	 </div>

  </div>
	
	<!-- 中间内容结束 -->
	<div class="clear"></div>
	<!-- 尾部开始 -->
	<%@include file="/inc/foot.jsp" %>
	<!-- 尾部结束 -->
   </div>

</body>
</html>