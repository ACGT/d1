<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>D1-优尚网，优尚团，每日超值团购不断更新！</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/tuannew.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script language="javascript" type="text/javascript">
	//限时抢购
	var the_s=new Array();
	
	function $getid(id)
	{
	    return document.getElementById(id);
	}
	
	function view_time(the_s_index,objid){
		 if(the_s[the_s_index]>=0){
	        var the_D=Math.floor((the_s[the_s_index]/3600)/24)
	        var the_H=Math.floor((the_s[the_s_index]-the_D*24*3600)/3600);
	        var the_M=Math.floor((the_s[the_s_index]-the_D*24*3600-the_H*3600)/60);
	        var the_S=(the_s[the_s_index]-the_H*3600)%60;
	        html = "<img src=\"/res/images/tuan/clock.jpg\" style=\" vertical-align:text-bottom;\" />&nbsp;倒计时：";
	        //<font class="font">1</font>小时<font class="font">20</font>分<font class="font">20</font>秒&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        if(the_D!=0) html += '<font class="font">'+the_D+"</font>天";
	        if(the_D!=0 || the_H!=0) html += '<font class="font">'+(the_H)+"</font>小时";
	        if(the_D!=0 || the_H!=0 || the_M!=0) html += '<font class="font">'+the_M+"</font>分";
	        html += '<font class="font">'+the_S+"</font>秒";
	        $getid(objid).innerHTML = html;
	        the_s[the_s_index]--;
	    }else{
	        $getid(objid).innerHTML = "已结束";
	    }
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
	

	
	function mouseover(i,obj)
	{
		$(obj).css("background-image","url(/res/images/tuan/"+i+".gif)");
	}
	function mouseout(i,obj)
	{
		$(obj).css("background-image","url(/res/images/tuan/h"+i+".gif)");
	}
	
	function ShowTuanNew() {
	    $.ajax({
	        type: "get",
	        dataType: "html",
	        url: "/ajax/html/getTuan.jsp",
	        cache: false,
	        data: {},
	        success: function(strHtml) {
	            if (typeof strHtml != 'undefined') {
	            	$('#sc').empty();
	                $(strHtml).appendTo($('#sc'));
	            }
	        },beforeSend: function() {},
	        complete: function() {xsms2011_new('sc');}
	    });
	};
	
	
	function xsms2011_new(id) {
		$('#'+id+' .countdown').each(function(){
			var b = $(this).attr('time');
			if(b){
				var ttime = new retime(b, this);
	            ttime.sTime(ttime);
			}
		});
	};
	
	
	//document.writeln("<div id=\"sc\" class=\"oldstyle\"><\/div>");
	//setTimeout("closeSC()", 10000);
	function closeSC(){
		
		$("#sc").text("");
		$("#sc").append("<div style=\"width: 352px;text-align:center; height:42px;background: url('http://images.d1.com.cn/Index/tck.jpg')\"><span onclick=\"javascript:openSC()\" style=\"cursor:pointer; float:right; padding-right:5px; margin-top:12px;\"><img src=\"http://images.d1.com.cn/Index/Cha-1.gif\"/></span></div>");
		$("#sc").animate({width:"350"},500,function(){});$("#sc").animate({height:"42"},500,function(){});
		$("#sc").removeClass("oldstyle");
		$("#sc").addClass('newstyle');	
		//$("#sc").resize(function(){var f_top = $(window).scrollTop() + $(window).height() + $("#sc").outerHeight();$('#sc').css('top',f_top);});
	}
	

	function openSC()
	{
		ShowTuanNew();
		$("#sc").removeClass("newstyle");
		$("#sc").addClass('oldstyle');
		$("#sc").animate({width:"350"},500,function(){});$("#sc").animate({height:"232"},500,function(){});
		
		//$("#sc").resize(function(){var f_top = $(window).scrollTop() + $(window).height() - $("#sc").outerHeight();$('#sc').css('top',f_top);});

	}
	function sc5()
	{
		//document.getElementById("sc").style.top=$(window).scrollTop() + $(window).height() - $("#sc").outerHeight();
		document.getElementById("sc").style.top=(document.documentElement.scrollTop+document.documentElement.clientHeight-document.getElementById("sc").offsetHeight)+"px";
		document.getElementById("sc").style.left=(document.documentElement.scrollLeft+document.documentElement.clientWidth-document.getElementById("sc").offsetWidth)+"px";
	}

	function scall()
	{
		sc5();
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
	<div id="sc" class="oldstyle" ></div>
	 <div class="left">
	 <%
      
          ArrayList<ProductGroup> list=new ArrayList<ProductGroup>();;
    	  //list=ProductGroupHelper.getTodayOtherProductGroups();
    	    
    	  //额外
    	    List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	  		//clist.add(Restrictions.eq("tgrpmst_state", new Long(1)));
	  		
	  		clist.add(Restrictions.lt("tgrpmst_starttime", new Date()));
	  		clist.add(Restrictions.ge("tgrpmst_endtime", new Date()));
	  		
	  		//加入排序条件，按加入购物车时间排序
	  		List<Order> olist = new ArrayList<Order>();
	  		olist.add(Order.desc("tgrpmst_priority"));
	  		olist.add(Order.desc("id"));
	  		List<BaseEntity> lists = Tools.getManager(ProductGroup.class).getList(clist, olist, 0, 100);
	  		
	  		if(lists!=null&&lists.size()>0){
		  		for(BaseEntity be:lists){
		  			list.add((ProductGroup)be);
		  		}
	  		}
    	  //额外结束
    	 
      	  if(list!=null&&list.size()>0){
				 for(int i=0;i<list.size();i++){
					 
					 ProductGroup product=list.get(i);
					 String ProductName=product.getTgrpmst_gdname();
					 String AutoLink="tuandetail.jsp?ID="+product.getId();
					 if(ProductName.length()>300){
						 ProductName=ProductName.substring(0,300);
					 }
					
					 Long lastcount=product.getTgrpmst_supreme()-product.getTgrpmst_relcount();
					 String sprice=ProductGroupHelper.getRoundPrice(product.getTgrpmst_sprice().floatValue());
					 String nprice=ProductGroupHelper.getRoundPrice(product.getTgrpmst_nprice().floatValue());
					 String pprice=ProductGroupHelper.getRoundPrice(product.getTgrpmst_nprice().floatValue()-product.getTgrpmst_sprice().floatValue());
					 double dl= Tools.getDouble(product.getTgrpmst_sprice().doubleValue()*10/product.getTgrpmst_nprice().doubleValue(),1);
					 String fl=ProductGroupHelper.getRoundPrice((float)dl);
				     SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					 
					 if(Tools.longValue(product.getTgrpmst_priority())==5&&i==0){
						
         %>
   
   
	    <div class="left_sub1">
	    <h2><span style=" color:#892d46;">今日团购：</span><%= ProductName %></h2><br/>
		<div class="left_content">
		
		   <div class="left_content1">
		     <a href="tuandetail.jsp?ID=<%= product.getId() %>" target="_blank"><img src="http://images.d1.com.cn/Index/look.gif" /><span><font style="font-family:'微软雅黑'">￥</font><%=sprice %></span></a>
			 
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
				 <td> <span id="tjjs_<%=i%>"></span>
						    <%
						       
						       String	nowtime= DateFormat.format( new Date());
						       String endtime= DateFormat.format(product.getTgrpmst_endtime());
						    %>
						     <SCRIPT language="javascript">
                             var startDate= new Date("<%=nowtime%>");
                             var endDate= new Date("<%=endtime%>");
                             the_s[<%=i%>]=(endDate.getTime()-startDate.getTime())/1000;
                             setInterval("view_time1(<%=i%>,'tjjs_<%=i%>')",1000);
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
		<div style="float:left;width:460px; margin-left:16px; _margin-left:10px; margin-top:-20px; _margin-top:-20px; "  ><img src="<%=product.getTgrpmst_pic()%>" alt="<%=ProductName%>" width="460" height="418" />
		</div>
	  </div>	
	   <% }
					 else
					 {
						  if(list.size()>1)
						  {
						      if(i==1)
						      {
							  %>
			<div class="left_sub2">
			    <div  style="background-image:url(/res/images/tuan/<%=i %>.gif); width:700px;  height:204px; overflow:hidden; float:left; " class="ls_1" onmouseover="mouseover(<%=i%>,this)" onmouseout="mouseout(<%=i%>,this)">
				     <table width="490" style=" float:left; " >
					     
					     <tr><td></td><td width="450" height="70" style="padding:5px; overflow:hidden;"><a href="tuandetail.jsp?ID=<%=product.getId()  %>" target="_blank" class="newa">仅售<%= sprice %>元 <% Product p=ProductHelper.getById(product.getTgrpmst_gdsid()); if(p!=null) out.print(p.getGdsmst_gdsname()); %> </a></td></tr>
						 <tr><td colspan="2" height="5"></td></tr>
						 
						 
						 <tr>
						     <td colspan="2">
							     <a href="tuandetail.jsp?ID=<%=product.getId()  %>" target="_blank"><img src="http://images.d1.com.cn/Index/look.gif" /><span style="font-size:30px; color:#fff; font-family:'微软雅黑'; position:absolute; margin-left:-230px; margin-top:10px; margin-left:-230px;font-weight:normal;" >￥<%= sprice %></span></a>
								 <div  class="look_border" style=" _height:35px;">
								 <table cellspacing="0" cellpadding="0" border="0">
								       <tr><td colspan="4" height="10"></td></tr>
									   <tr>
									       <td width="75"></td>
										   <td width="69" >市场价</td>
										   <td width="69">折扣</td>
										   <td width="70"><font color="#b51014">节省</font></td>
									   </tr>
									   <tr>
									   <td></td>
										  <td height="28" >￥<%=nprice %></td>
										  <td ><%= fl %>折</td>
										  <td><font color="#b51014">￥<%= pprice %></font></td>
									   </tr>
						   
					                  </table>
								 
								 </div>
							 </td>
						 </tr>
						 <tr><td colspan="2" height="75"></td></tr>
						 <tr>
						     <td></td>
						    <td >
						    <font id="tjjs_<%=i%>"></font>
						    <%
						       
						       String	nowtime= DateFormat.format( new Date());
						       String endtime= DateFormat.format(product.getTgrpmst_endtime());
						    %>
						     <SCRIPT language="javascript">
                             var startDate= new Date("<%=nowtime%>");
                             var endDate= new Date("<%=endtime%>");
                             the_s[<%=i%>]=(endDate.getTime()-startDate.getTime())/1000;
                             setInterval("view_time(<%=i%>,'tjjs_<%=i%>')",1000);
                             </SCRIPT>
						   	 <img src="/res/images/tuan/person.jpg" /><font class="font" style=" font-size:22px;"><b><%= product.getTgrpmst_hotmodulus()%></b></font>人已购买</td>
							
						 </tr>
					 </table>
			  		<a href="tuandetail.jsp?ID=<%=product.getId()  %>" target="_blank"><img src="http://images.d1.com.cn/<%= p.getGdsmst_imgurl() %>" style=" float:right; margin-top:2px; margin-right:4px;"/></a>
		   			</div>
						    	 
							  <%}
						      else if(i==list.size()-1)
						      {%>
						        <div class="ls_1" style=" background-image:url(/res/images/tuan/h<%=i %>.gif); width:700px;  height:204px; overflow:hidden; float:left; " onmouseover="mouseover(<%=i%>,this)" onmouseout="mouseout(<%=i%>,this)">
				     <table width="490" style=" float:left;">
					      <tr><td></td><td width="450" height="70" style=" padding:5px; overflow:hidden;"><a href="tuandetail.jsp?ID=<%=product.getId()  %>" target="_blank" class="newa">仅售<%= sprice %>元 <% Product p=ProductHelper.getById(product.getTgrpmst_gdsid()); if(p!=null) out.print(p.getGdsmst_gdsname()); %> </a></td></tr>
						 <tr><td colspan="2" height="5"></td></tr>
						 <tr>
						     <td colspan="2">
							     <a href="tuandetail.jsp?ID=<%=product.getId()  %>" target="_blank"><img src="http://images.d1.com.cn/Index/look.gif" /><span style="font-size:30px; color:#fff; font-family:'微软雅黑'; position:absolute; margin-left:-230px; margin-top:10px; margin-left:-230px;font-weight:normal; ">￥<%= sprice %></span></a>
								 <div  class="look_border">
								 <table cellspacing="0" cellpadding="0" border="0" style=" _height:35px;">
								       <tr><td colspan="4" height="10"></td></tr>
									   <tr>
									       <td width="75"></td>
										   <td width="69" >市场价</td>
										   <td width="69">折扣</td>
										   <td width="70"><font color="#b51014">节省</font></td>
									   </tr>
									   <tr>
									   <td></td>
										  <td height="28" >￥<%=nprice %></td>
										  <td ><%= fl %>折</td>
										  <td><font color="#b51014">￥<%= pprice %></font></td>
									   </tr>
						   
					                  </table>
								 
								 </div>
							 </td>
						 </tr>
						 <tr><td colspan="2" height="75"></td></tr>
						 <tr>
						     <td></td>
						    <td> <font id="tjjs_<%=i%>"></font>
						    <%
						       
						       String	nowtime= DateFormat.format( new Date());
						       String endtime= DateFormat.format(product.getTgrpmst_endtime());
						    %>
						     <SCRIPT language="javascript">
                             var startDate= new Date("<%=nowtime%>");
                             var endDate= new Date("<%=endtime%>");
                             the_s[<%=i%>]=(endDate.getTime()-startDate.getTime())/1000;
                             setInterval("view_time(<%=i%>,'tjjs_<%=i%>')",1000);
                             </SCRIPT><img src="/res/images/tuan/person.jpg" /><font class="font" style=" font-size:22px;"><b><%= product.getTgrpmst_hotmodulus()%></b></font>人已购买</td>
							
						 </tr>
					 </table>
			  		<a href="tuandetail.jsp?ID=<%=product.getId()  %>" target="_blank"><img src="http://images.d1.com.cn/<%= p.getGdsmst_imgurl() %>" style=" float:right; margin-top:2px; margin-right:4px;"/></a>
		   			</div>
						         </div>
						      <%}
						      else
						      {%>
						    	    <div class="ls_1" style=" background-image:url(/res/images/tuan/h<%=i %>.gif); width:700px;  height:204px; overflow:hidden; float:left; margin-top:10px;" onmouseover="mouseover(<%=i%>,this)" onmouseout="mouseout(<%=i%>,this)">
				     <table width="490" style=" float:left;">
					     <tr><td></td><td width="450" height="70" style=" padding:5px; overflow:hidden;"><a href="tuandetail.jsp?ID=<%=product.getId()  %>" target="_blank" class="newa">仅售<%= sprice %>元 <% Product p=ProductHelper.getById(product.getTgrpmst_gdsid()); if(p!=null) out.print(p.getGdsmst_gdsname()); %> </a></td></tr>
						 <tr><td colspan="2" height="5"></td></tr>
						  <tr>
						     <td colspan="2">
							     <a href="tuandetail.jsp?ID=<%=product.getId()  %>" target="_blank"><img src="http://images.d1.com.cn/Index/look.gif" /><span style="font-size:30px; color:#fff; font-family:'微软雅黑'; position:absolute; margin-left:-230px; margin-top:10px; margin-left:-230px;font-weight:normal; ">￥<%= sprice %></span></a>
								 <div  class="look_border">
								 <table cellspacing="0" cellpadding="0" border="0" style=" _height:35px;">
								       <tr><td colspan="4" height="10"></td></tr>
									   <tr>
									       <td width="75"></td>
										   <td width="69" >市场价</td>
										   <td width="69">折扣</td>
										   <td width="70"><font color="#b51014">节省</font></td>
									   </tr>
									   <tr>
									   <td></td>
										  <td height="28" >￥<%=nprice %></td>
										  <td ><%= fl %>折</td>
										  <td><font color="#b51014">￥<%= pprice %></font></td>
									   </tr>
						   
					                  </table>
								 
								 </div>
							 </td>
						 </tr>
						 <tr><td colspan="2" height="75"></td></tr>
						 <tr>
						     <td></td>
						    <td> <font id="tjjs_<%=i%>"></font>
						    <%
						       
						       String	nowtime= DateFormat.format( new Date());
						       String endtime= DateFormat.format(product.getTgrpmst_endtime());
						    %>
						     <SCRIPT language="javascript">
                             var startDate= new Date("<%=nowtime%>");
                             var endDate= new Date("<%=endtime%>");
                             the_s[<%=i%>]=(endDate.getTime()-startDate.getTime())/1000;
                             setInterval("view_time(<%=i%>,'tjjs_<%=i%>')",1000);
                             </SCRIPT> <img src="/res/images/tuan/person.jpg" /><font class="font" style=" font-size:22px;"><b><%= product.getTgrpmst_hotmodulus()%></b></font>人已购买</td>
							
						 </tr>
					 </table>
			  		<a href="tuandetail.jsp?ID=<%=product.getId()  %>" target="_blank"><img src="http://images.d1.com.cn/<%= p.getGdsmst_imgurl() %>" style=" float:right; margin-top:2px; margin-right:4px;"/></a>
		   			</div>
						      <% }
						  }
					 }
					 
			} } %>
	  
	  
	
	</div>
	
	<div class="right">
	<%
	
		List<Promotion> pp=PromotionHelper.getBrandListByCode("2770", 100);
		
		if(pp!=null&&pp.size()>0)
		{%>
		<div  style="border:solid 1px #c2c2c2; margin-bottom:15px; padding-bottom:15px; text-align:center;">
		 <div style="width:256px; height:30px; background-color:#ebebeb; margin-bottom:10px; text-align:left;  line-height:30px; color:#892d46; font-size:15px; font-weight:bold;">
			    &nbsp;&nbsp;限时特卖
			</div>
			<%
			for(int i=0;i<pp.size();i++)
			{
				Promotion p=pp.get(i);
				String url=StringUtils.encodeUrl(p.getSplmst_url()).replace("aspx", "jsp");
				if(url.indexOf("brand/brandlist.asp")>0){
				url=url.replace("brandlist.asp", "index.jsp");
					}%>
                <a href="<%=url %>" target="_blank"><img src="<%= p.getSplmst_picstr() %>" width="240" height="326" /></a>
				
		<%	}
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
	
	<div class="clear"></div>
	
	<!-- 中间内容结束 -->
	
	
	<!-- 尾部开始 -->
	<%@include file="/inc/foot.jsp" %>
	<!-- 尾部结束 -->
   </div>

</body>
</html>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/retime.js")%>" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function() {
	ShowTuanNew();
	xsms2011_new('sc');
});
</script>