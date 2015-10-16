<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/inc/islogin.jsp"%>
<%!
//获取购物积分
private static ArrayList<UserScore> getUserScore(String mbrid){
	ArrayList<UserScore> rlist = new ArrayList<UserScore>();
	Calendar ca = Calendar.getInstance();
    int year = ca.get(Calendar.YEAR);//获取年份
    int month=ca.get(Calendar.MONTH)+1;//获取月份
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("usrscore_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("usrscore_type", new Long(0)));
	clist.add(Restrictions.eq("usrscore_year", year+""));
	clist.add(Restrictions.eq("usrscore_month", month+""));
	List<BaseEntity> list = Tools.getManager(UserScore.class).getList(clist, null, 0, 10);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((UserScore)be);
	}
	return rlist ;
}
//获取联盟数据
private static ArrayList<LmMbrspe> getUserbyLM(String mbrid){
	ArrayList<LmMbrspe> rlist = new ArrayList<LmMbrspe>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("id", mbrid));
	List<BaseEntity> list = Tools.getManager(LmMbrspe.class).getList(clist, null, 0, 10);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((LmMbrspe)be);
	}
	return rlist ;
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品评价 - D1优尚</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/comment.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($.trim($(".txtcontent").val()).length==0){
		$(".txtcontent").text("您还没有填写评价内容哦！");
	}else{
		$(".txtcontent").attr("color","black");
	}
});
	 $(function() {
					        $(".star_5 small").hover(
					function() {
					    var v = $(this).text();
					    $(this).parent().attr("class", "star_" + v);
					    $(this).parent().parent().children('big').text(v);
					    $(this).parent().parent().children('em').text($(this).attr("v"));
					},
					function() {
					    var v = $(this).parent().attr("v");
					    $(this).parent().attr("class", "star_" + v);
					    $(this).parent().parent().children('big').text(v);
					    $(this).parent().parent().children('em').text($("#domark small").eq(v - 1).attr("v"));

					}
				);
					        $(".star_5 small").click(function() {
					            var v = $(this).text();
					            $(this).parent().parent().parent().parent().children("input[name='mark.markValue']").val(v);
					            $(this).parent().attr("v", v);
					            $(this).parent().attr("class", "star_" + v);
					        });
					    });
					    function SerchType(obj) {       
					        if (obj.value == "您还没有填写评价内容哦！") {
					            obj.value = "";
					            obj.style.color = "black";    //设置字体颜色成黑色
					        }
					    }
					    function SerchType2(obj) {       
					        if (obj.value.length==0) {
					            obj.value = "您还没有填写评价内容哦！";
					            obj.style.color = "gray";    //设置字体颜色成黑色
					        }
					    }
		
					    function checkh(i,v){
					    	var t=/^\d{2,3}$/;
			           		var t2=/^\d{2,3}\.\d{1,2}$/;
			           		var sheight="#sheight"+i;
							if(v.length==0 || v=='undefined'){
								//alert(v);
			           			$(sheight).html('');
			           			return true;
			           		}else{
			           			if (t.test(v)==true || t2.test(v)==true){
			           			//	alert(222);
			           				$(sheight).html('');
			           				return true;
			           			}else{
			           				$(sheight).html('格式错误！');
			           				return false;
			           			}
			           		}
					     }
					    
					    function checkw(i,v){
					    	var t=/^\d{2,3}$/;
			           		var t2=/^\d{2,3}\.\d{1,2}$/;
			           		var sheight="#sweight"+i;
							if(v.length==0 || v=='undefined'){
								//alert(v);
			           			$(sheight).html('');
			           			return true;
			           		}else{
			           			if (t.test(v)==true || t2.test(v)==true){
			           			//	alert(222);
			           				$(sheight).html('');
			           				return true;
			           			}else{
			           				$(sheight).html('格式错误！');
			           				return false;
			           			}
			           		}
					     }
					    
	function add(){
		 var productidlist = $("input[name='productid']");
		 var productnamelist = $("input[name='productname']");
		 var scores = $("input[name='mark.markValue']");
		 var contents=$(".txtcontent").text();
		 var base=$(":radio[name='buygoods']:checked").val();
	     var service=$(":radio[name='service']:checked").val();
	     var speed=  $(":radio[name='speed']:checked").val();
	     var msn= $(":radio[name='msn']:checked").val() ;
	     if(base==null){base="未评价";}
	     if(service==null){service="未评价";}
	     if(speed==null){speed="未评价";}
	     if(msn==null){msn="未评价";}
	     $("#hfbase").val(base);
	     $("#hfservice").val(service);
	     $("#hfspeed").val(speed);
	     $("#hfmsn").val(msn);
		 var j=0;
		var h=0;var w=0;
		 //判断身高是否填写正确
		 for(var i=1;i<=scores.length;i++){
				var theight="#theight"+i;
						if($(theight)!=null ){
							var value= $(theight).val();
						
							if(value!=null && value!="undefined"){
						
								if(checkh(i,value)==false){
									 h++;
								}
							}
						}
						
				var tweight="#tweight"+i;
				if($(tweight)!=null ){
							var value= $(tweight).val();
						if(value!=null && value!="undefined"){
							if(checkw(i,value)==false){
									 w++;
								}
					}
				}
			 }
		 if(h>0){
			 $.alert("身高数据填写错误！");
			 
		 }else if(w>0){
			 $.alert("体重数据填写错误！");
		 }else{
			 for(var i=0;i<scores.length;i++){
					var tcontent="#tcomment"+(i+1);
					 if($.trim($(tcontent).val()).length==0  || "您还没有填写评价内容哦！"==$.trim($(tcontent).val())){
						 j++;
					 }
				 }
				 
				 if(j>0){
					 $.confirm('您还有未填写评论的商品哦，确定现在就提交吗？ 点击【取消】，可返回继续填写评论，您的评论对其他顾客很有帮助！点击【确定】将立刻提交。','提示',function(){
						 $("#form1").submit();
				    	});
					 }
				 else{
					 if((scores.length==productidlist.length) && (scores.length==productnamelist.length)){
						 //document.form1.submit();
						 $("#form1").submit();
					 } 
				 }
		 }
		
		
		
		
	}

					    
					</script>	
</head>
<body>

<%@include file="/inc/head.jsp" %>

  <div class="center">
 <%@include file="/user/left.jsp" %>

         <div class="mbr_right">
		<div class="myyhq">

		  &nbsp;&nbsp;<span>商品评价</span>

		</div>

		
	  <form id="form1" name="form1" action="operation.jsp?orderid=<%=request.getParameter("orderid") %>" method="post"  >
		
    
     <%
      if(!Tools.isNull(request.getParameter("orderid"))){
    	  OrderBase base=OrderHelper.getById2(request.getParameter("orderid"));
    	  if(base!=null){
    		  if(!lUser.getId().equals(String.valueOf(base.getOdrmst_mbrid()))){
    			  Tools.outJs(out,"你没有权限进行操作！","back");
					return;
    		 }
    		 
    			 int status= base.getOdrmst_orderstatus().intValue();
    			
    			 if(status == 3 || status == 31){
    			  if(status==3){
    				  status=5;
    				  //out.print(">>>>>>>>>>>>>>>>>>>>>>>>");
    			  }else if(status==31){
    				  status=51;
    			  }
    			 base.setOdrmst_orderstatus(new Long(status));
    			 base.setOdrmst_finishdate(new Date());
    			 Tools.getManager(base.getClass()).clearListCache(base);
    			 if(!Tools.getManager(base.getClass()).update(base, true)){
    				  Tools.outJs(out,"设置交易完成失败！","back");
    					return;
  					}
    			 else
    			 {
   	    		     
    				 ArrayList<LmMbrspe> lmlist=new ArrayList<LmMbrspe>();
    				 lmlist=getUserbyLM(lUser.getId());
    				 boolean palist=UserHelper.isPingAnUser(request,response);
    				 if(!palist&&(lmlist==null||lmlist.size()==0)){
    					 Date currentdate=new Date();
    					 Calendar ca1 = Calendar.getInstance();
    					 ca1.set(Calendar.YEAR, 2013);//获取年份
    					 ca1.set(Calendar.MONTH, 1);//获取年份
    					 ca1.set(Calendar.DAY_OF_MONTH,1);//获取日
    					 ca1.set(Calendar.HOUR_OF_DAY,0);
    					 ca1.set(Calendar.MINUTE,0);
    					 ca1.set(Calendar.SECOND,0);
    					 //System.out.print(ca1.getTime());
    					 if(currentdate.after(ca1.getTime())){    				 
    				 
    				 //积分操作
   	    		     ArrayList<UserScore> scorelist=getUserScore(lUser.getId()) ;
   	    		     //如果当月有购物积分，修改当月数据
   	     	    		  if(scorelist!=null && scorelist.size()>0){
   	     	    			  float endmoney1=Tools.parseFloat(base.getOdrmst_acturepaymoney().toString())+Tools.parseFloat(base.getOdrmst_prepayvalue().toString());
  	     	    			  UserScore userscore= scorelist.get(0);   	     	    			 
   	     	    			  userscore.setUsrscore_allscr(userscore.getUsrscore_allscr().floatValue()+endmoney1);
   	     	    			  userscore.setUsrscore_createdate(new Date());
   	     	    			  userscore.setUsrscore_buymoney(userscore.getUsrscore_buymoney().floatValue()+endmoney1);
   	     	    			  userscore.setUsrscore_realscr(userscore.getUsrscore_realscr().floatValue()+endmoney1);
   	     	    			  userscore.setUsrscore_scr(userscore.getUsrscore_scr().floatValue()+endmoney1);
   	     	    			  userscore.setUsrscore_tktvalue(userscore.getUsrscore_tktvalue().floatValue()+new Float(base.getOdrmst_tktvalue()));
   	     	    			  Tools.getManager(userscore.getClass()).clearListCache(userscore);
   	     	    			  if(Tools.getManager(userscore.getClass()).update(userscore, true)){
   	     	    			      
   	     	    			  }
   	     	    		  }
   	    		         //没有，添加新积分记录
   	     	    		  else{
   	     	    			  float endmoney=Tools.parseFloat(base.getOdrmst_acturepaymoney().toString())+Tools.parseFloat(base.getOdrmst_prepayvalue().toString());
   	     	    			  Calendar ca = Calendar.getInstance();
   	     	    		      int year = ca.get(Calendar.YEAR);//获取年份
   	     	    		      int month=ca.get(Calendar.MONTH)+1;//获取月份
   	     	    		      UserScore userscore= new UserScore();
	   	  	    			  userscore.setUsrscore_allscr(endmoney);
	   	  	    			  userscore.setUsrscore_buymoney(endmoney);
	   	  	    			  userscore.setUsrscore_createdate(new Date());
	   	  	    			  userscore.setUsrscore_jlper("0");
	   	  	    			  userscore.setUsrscore_lxmonth(new Long(0));
	   	  	    			  userscore.setUsrscore_mbrid(new Long(lUser.getId()));
	   	  	    			  userscore.setUsrscore_month(month+"");
	   	  	    			  userscore.setUsrscore_rcmscr(new Float(0));
	   	  	    			  userscore.setUsrscore_realscr(endmoney);
	   	  	    			  userscore.setUsrscore_scr(endmoney);
	   	  	    			  userscore.setUsrscore_tktvalue(new Float(base.getOdrmst_tktvalue()));
	   	  	    			  userscore.setUsrscore_type(new Long(0));
	   	  	    			  userscore.setUsrscore_year(year+"");
   	  	    			      userscore=(UserScore)Tools.getManager(UserScore.class).create(userscore);
		   	  	    		  if(userscore!=null){
		   	  	    			
		   	  	    		  }
   	     	    		  }

   	     			    }
    				 }
    		   	    		     
    				 
	    				//积分操作
	    				UsrPoint usrpoint = new UsrPoint();
	    		     	usrpoint.setUsrpoint_odrid(base.getId());
	    		     	usrpoint.setUsrpoint_mbrid(new Long(lUser.getId()));
	    		     	usrpoint.setUsrpoint_score(new Long((base.getOdrmst_acturepaymoney().longValue()+base.getOdrmst_prepayvalue().longValue())));
	    		     	usrpoint.setUsrpoint_usescore(new Long(base.getOdrmst_acturepaymoney().longValue()+base.getOdrmst_prepayvalue().longValue()));
	    		     	usrpoint.setUsrpoint_type(new Long(1));
	    		     	usrpoint.setUsrpoint_createdate(new Date());
	    		     	UsrPointHelper.insertUsrPoint(usrpoint);
    			 }
    			  
    		}
    		
    			 ArrayList<OrderItemBase> itemlist=OrderItemHelper.getMyOrderDetail2(base.getId());
  				
    		 
    	  %>
    	  <table border="0" width="769" >
    	  <tr><td  height="10">&nbsp;</td></tr>
			<tr> <td  class="peisong_body" align="left"  style=" padding-left:15px; padding-top:15px;  padding-bottom:15px">
          <span style="font-size:13px; font-weight:bold">交易已经完成，感谢您惠顾D1优尚，欢迎您对本次交易及所购商品进行评价。</span>
         </td>
			</tr>
			
			 <tr>
         <td  class="peisong_body" align="left" valign="middle" style="padding-left:4px; padding-right:4px">
          <div style="line-height:20px; background-color:#FEEEF1;padding-top:12px;padding-left:15px;padding-bottom:12px; color:#A93F52;">
          <p>小提示：（<span style=" color:red; ">平安万里通用户不享用评论积分</span><span>）</span></p>
          <p>1、给商品评分：获得5个积分。</p>
          <p>2、填写使用心得：获得5个积分。</p>
          <p>给“商品评分”并填写“使用心得”为一个完整的商品评价：总计获得10个积分。</p>
  </div>
         </td>
        </tr>
       
		</table>
    	 <%
    	 if(itemlist!=null && itemlist.size()>0){
    		 %>
    		 <table>
    		 <% int i=1;
    		 for(OrderItemBase item:itemlist){
    			
    		 
    			 Product product= ProductHelper.getById(item.getOdrdtl_gdsid());
				 String imgurl="http://images.d1.com.cn/images2012/New/user/imgtext.jpg";
				 String linkurl="";
				 if(product!=null){
					 imgurl=product.getGdsmst_otherimg3();
					 if(imgurl!=null&&imgurl.startsWith("/shopimg/gdsimg")){
						 imgurl = "http://images1.d1.com.cn"+imgurl;
							}else{
								imgurl = "http://images.d1.com.cn"+imgurl;
							}
					 linkurl=product.getGdsmst_autopageurl();
				 } %>
				  <tr><td colspan="2" height="10">&nbsp;</td></tr>
				           <tr style="border-collapse:collapse;">
            <td align="left">
            <a href="<%=linkurl%>"><img src="<%=imgurl%>" height="80" width="80"/> </a>
               </td>
                     <td align="left" style="padding-left:10px">
                     <input type="hidden" name="productid" value="<%=item.getOdrdtl_gdsid() %>" />
                     <input type="hidden" name="productname" value="<%=item.getOdrdtl_gdsname() %>" />
                     <span style="font-weight:bold">商品名称</span><br /><br />
                <a  href='<%=linkurl %>'><%=item.getOdrdtl_gdsname()%></a>
                <%
                if(!Tools.isNull(item.getOdrdtl_sku1())){
                	%>
                	 <br/>
                <span style="color:black;">我订购了<%=item.getOdrdtl_sku1() %></span>
                <% }
                %>
               
                </td>
               
          </tr>
          <tr >
           <td align="right" style="font-weight:bold; padding-top:15px; padding-bottom:10px">
           <span style="color:Red">*</span>
           商品评分： </td><td style="padding-top:15px; padding-bottom:10px" align="left">
           <div style="padding-left:0px; margin-left:0px; float:left">
              
                <input name="mark.markValue" type="hidden" value="5" />
		     <div id="mark" style="padding-left:0px; margin-left:0px; float:left">
					<div id="domark" style="padding-left:0px; margin-left:0px; float:left">
					  <div class="star_5" v="5" style="padding-left:0px; margin-left:0px; float:left"><small v="不喜欢" >1</small> <small v="一般">2</small> <small v="还不错">3</small> <small v="很喜欢">4</small> <small v="非常喜欢">5</small></div>
					   <big>5</big><span style="color:Red; font-size:12px">分</span><span>--</span> <em>非常喜欢</em></div>
					     
				   </div>
					   
			</div>
           </td>
          </tr>
          <%
          if(item.getOdrdtl_rackcode().startsWith("020") || item.getOdrdtl_rackcode().startsWith("030")){
        	  %>  
        	   <tr >
           <td align="right" style="font-weight:bold; padding-bottom:5px">
        	 身高：
        	</td><td style="padding-bottom:5px" align="left">
            <input  type="text" id="theight<%=i %>" name="theight" onblur="checkheight<%=i%>(this.value);" />&nbsp;&nbsp;cm &nbsp;&nbsp;<span style="color:Red" id="sheight<%=i%>"></span>
           </td>
          </tr>
          <tr >
           <td align="right" style="font-weight:bold; padding-top:5px; padding-bottom:5px">
        	 体重：
        	</td><td style="padding-top:5px; padding-bottom:5px" align="left">
           <input  type="text" id="tweight<%=i %>" name="tweight" onblur="checkweight<%=i%>(this.value);" />&nbsp;&nbsp;kg &nbsp;&nbsp;<span style="color:Red" id="sweight<%=i%>"></span>
           </td>
          </tr>
          
            <tr >
           <td align="right" style="font-weight:bold; padding-top:5px; padding-bottom:10px">
           <span style="color:Red">*</span>
       合适度： </td><td style="padding-top:5px; padding-bottom:10px" align="left">
           <input name="comp<%=i%>" type="radio" value="1" checked="checked" onclick="getcomp<%=i%>(1)"/>&nbsp;&nbsp;合适&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="comp<%=i%>" type="radio" value="2"  onclick="getcomp<%=i%>(2)"/>&nbsp;&nbsp;偏大&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="comp<%=i%>" type="radio" value="3"  onclick="getcomp<%=i%>(3)"/>&nbsp;&nbsp;偏小
           <input type="hidden"  id="hcomp<%=i%>" name="hcomp" value="1"></input>
           </td>
          </tr>
           <script type="text/javascript">
               function checkweight<%=i%>(v){
           		var t=/^\d{2,3}$/;
           		var t2=/^\d{2,3}\.\d{1,2}$/;
           		if(v.length==0 || v=='undefined'){
           			$("#sweight<%=i%>").html('');
           			return true;
           		}else{
           			if (t.test(v)==true || t2.test(v)==true){
           				$("#sweight<%=i%>").html('');
           				return true;
           			}else{
           				$("#sweight<%=i%>").html('格式错误！');
           				return false;
           			}
           		}
           			
           	}
               function checkheight<%=i%>(v){
              		var t=/^\d{2,3}$/;
              		var t2=/^\d{2,3}\.\d{1,2}$/;
              		if(v.length==0 || v=='undefined'){
              			$("#sweight<%=i%>").html('');
              			return true;
              		}else{
              			if (t.test(v)==true || t2.test(v)==true){
              				$("#sheight<%=i%>").html('');
              				return true;
              			}else{
              				$("#sheight<%=i%>").html('格式错误！');
              				return false;
              			}
              		}
              			
              	}
             function  getcomp<%=i%>(v){
            	 $("#hcomp<%=i%>").val(v); 
             }
               
               
		    </script>  
           <%}else{
        	   %>
        	   <input type="hidden" name="tweight"></input>
        	    <input type="hidden" name="theight"></input>
        	    <input type="hidden"  id="hcomp<%=i%>" name="hcomp" value="1"></input>
        	   
            <% }
          
          %>
          
          
          
          <tr>
            <td align="right" valign="top" style="font-weight:bold">  <input type="hidden" name="hsku" value="<%=item.getOdrdtl_sku1()%>"></input>使用心得：</td> 
            <td align="left" style="padding-left:10px">
          
                <div style="float:left">
                     <textarea class="txtcontent" name="tcontent" id="tcomment<%=i %>" style="color:gray;font-size:12px;" onfocus="SerchType(this)" onblur="SerchType2(this)"  onkeydown='if (this.value.length>=500){event.returnValue=false}' onkeyup="keypress<%=i%>(this.value)"></textarea>
		         </div>
               <div style="float:left;padding-left:5px;">
                <span>500字以内</span><br></br>
                <span id="content<%=i%>" style="color:red"></span>
               </div>
               <script type="text/javascript">

		      function keypress<%=i%>(text1) {//textarea输入长度处理
		    	
		    	  var showmsg="";
					        var len; //记录剩余字符串的长度
					        if (text1.length >= 500)//textarea控件不能用maxlength属性，就通过这样显示输入字符数了
					        {
					            $.alert("超过字数限制，请您精简部分文字!");
					            text1 = text1.substr(0, 500);
					            len = 0;
					        }
					        else {
					        	//if($.trim(text1).length==0){
					        		//show="您还没有填写评价内容哦！";
					        	//}else{
					        		len = 500 - text1.length;
					        		showmsg = "您还可以输入" + len + "个字"; 
					        	//}  
					        }
					      // alert(show);
					      var t="#content"+<%=i%>;
					     //   $(t).html=showmsg;
					      document.getElementById("content<%=i%>").innerHTML=showmsg;
					    }
		      
		    </script>  
             </td>
          </tr>
           <tr>
           <td height="15px;">&nbsp;</td>
           </tr>
         
            	  <tr>
            <td colspan="2" align="left" style=" border-bottom:1px dotted #C7C7C7;">
          &nbsp;
           </td>
          </tr>
          <%  
           i++;
				 }%>

            </table>
    	 <table width="100%" border="0" cellspacing="0" cellpadding="0" style="line-height:22px;">
               <tr>
           <td colspan="3" height="10px;">&nbsp;</td>
           </tr>
              <tr>
                <td width="120" rowspan="6" valign="top"> <div align="center"><strong>D1购物评价：</strong></div></td>
                <td width="240">您对此次购物的基本满意度：</td>
                <td ><input name="buygoods" type="radio" value="非常满意" />&nbsp;&nbsp;非常满意&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="buygoods" type="radio" value="比较满意" />&nbsp;&nbsp;比较满意&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="buygoods" type="radio" value="不满意" />&nbsp;&nbsp;不满意</td>
              </tr>
              <tr>
              
                <td>您对发货速度的满意度：</td>
                <td><input name="speed" type="radio" value="非常满意" />&nbsp;&nbsp;非常满意&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="speed" type="radio" value="比较满意" />&nbsp;&nbsp;比较满意&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="speed" type="radio" value="不满意" />&nbsp;&nbsp;不满意</td>
              </tr>
              <tr>
               
                <td>您对客户服务的满意度：</td>
                <td><input name="service" type="radio" value="非常满意" />&nbsp;&nbsp;非常满意&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="service" type="radio" value="比较满意" />&nbsp;&nbsp;比较满意&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="service" type="radio" value="不满意" />&nbsp;&nbsp;不满意</td>
              </tr>
              <tr>
               
                <td> 您对快递的满意度：</td>
                <td><input name="msn" type="radio" value="非常满意" />&nbsp;&nbsp;非常满意&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="msn" type="radio" value="比较满意" />&nbsp;&nbsp;比较满意&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="msn" type="radio" value="不满意" />&nbsp;&nbsp;不满意</td>
              </tr>
               <tr>
                <td  colspan="3" height="10px" ></td>
              </tr>
              <tr>
              
                <td>其他建议和意见：</td>
                <td ><textarea name="txtother" style="width:280px; height:88px; border:solid 1px #acacac; background:#f4f4f4;" id="other"></textarea></td>
              </tr>
                 <tr>
           <td colspan="3" height="25px;">&nbsp;</td>
           </tr>
            <tr>
           <td colspan="3" align="center"><a href="javascript:add();" ><img src="http://images.d1.com.cn/images2012/New/user/subcomment.jpg"></img></a></td>
           </tr>
    	 </table>
    	  <%}else{
    			  Tools.outJs(out, "该订单不存在", "back");
    	    	  return;
    		  }
    	  
    		 }
      }else{
    	  Tools.outJs(out, "参数错误", "back");
    	  return;
      }
     %>
     <input type="hidden" id="hfscores"></input>
      <input type="hidden" id="hfspeed"  name="hfspeed"></input>
       <input type="hidden" id="hfbase"  name="hfbase"></input>
        <input type="hidden" id="hfservice"  name="hfservice"></input>
         <input type="hidden" id="hfmsn" name="hfmsn"></input>
        </form>
     </div>
     </div>
   
<div class="clear"></div>
   <%@include file="/inc/foot.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	if($.trim($(".txtcontent").val()).length==0){
		$(".txtcontent").text("您还没有填写评价内容哦！");
	}else{
		$(".txtcontent").attr("color","black");
	}
});
</script>
</body>
</html>