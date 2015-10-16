<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%!

//获取567分类
public static ArrayList<Gdscoll_rackcode> getGdsAttByGdsid(String category)
	{
	    if(category==null||!Tools.isNumber(category)) return null;	
		ArrayList<Gdscoll_rackcode> list=new ArrayList<Gdscoll_rackcode>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		clist.add(Restrictions.ge("gr_box",new Long(5)));
		clist.add(Restrictions.le("gr_box",new Long(7)));
		clist.add(Restrictions.eq("gr_category", new Long(category)));
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gr_order"));
		List<BaseEntity> blist=Tools.getManager(Gdscoll_rackcode.class).getList(clist, olist, 0, 100);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscoll_rackcode)b);
				}
			}
		}
		return list;
		
	}

   //获取平铺图
   private static ArrayList<GdsCutImg> getGdsImg(String id){
	 if(id==null||id.length()==0||!Tools.isNumber(id)) return null;
	 ArrayList<GdsCutImg> gcilist=new ArrayList<GdsCutImg>();
	 List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	 clist.add(Restrictions.eq("gdsmst_gdsid",id));
	 List<BaseEntity> blist=Tools.getManager(GdsCutImg.class).getList(clist, null,0,10);
	 if(blist!=null&&blist.size()>0&&blist.get(0)!=null){
         for(BaseEntity be:blist){
        	 if(be!=null)
        	 {
        		 gcilist.add((GdsCutImg)be);
        	 }
         }
	 }
	 return gcilist;
}
%>
<%
     String id="";
     if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
     {
        id=request.getParameter("id");
     }
     if(id.length()<=0){ return;}
     Product ps=new Product();
     String rcode="";
     if(id!=null&&id.length()>0){
    	 ps=ProductHelper.getById(id);
    	 if(ps!=null&&ps.getGdsmst_rackcode()!=null&&ps.getGdsmst_rackcode().length()>0){
    		 rcode=ps.getGdsmst_rackcode();
    		 if(!rcode.startsWith("020")&&!rcode.startsWith("030")){
    			 return;
    		 }
    	 }
    	 else return;
     }
     //获取300*300的平铺图
     String img300300="";
     ArrayList<GdsCutImg> gcilist=getGdsImg(id);
     if(gcilist!=null&&gcilist.size()>0&&gcilist.get(0)!=null&&gcilist.get(0).getGdscutimg_300()!=null&&gcilist.get(0).getGdscutimg_300().length()>0)
     {
     	img300300="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_300();
     }
     else
     {
    	 img300300=ProductHelper.getImageTo400(ps);
     }
     //判断上装下装标记
     int flag=0;
     ArrayList<Gdscoll_rackcode> grlist=new ArrayList<Gdscoll_rackcode>();
     if(rcode.startsWith("020")){
    		grlist=getGdsAttByGdsid("1");
            for(Gdscoll_rackcode gr:grlist){
            	if(gr.getGr_code().startsWith(rcode.substring(0,6))){
            		flag=Tools.parseInt(gr.getGr_box().toString());
            		break;
            	}
            }
           
     }
     else{
    	 grlist=getGdsAttByGdsid("2");
         for(Gdscoll_rackcode gr:grlist){
         	if(gr.getGr_code().startsWith(rcode.substring(0,6))){
         		flag=Tools.parseInt(gr.getGr_box().toString());
         		break;
         	}
         }
     }
     
     
     
     
    
   //判断类别 1代表女装 2代表男装 以后有再加
     int category=1;
     if(ps.getGdsmst_rackcode()!=null&&ps.getGdsmst_rackcode().startsWith("03")){ category=2;}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>D1优尚网-DIY</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/freegdscoll.js")%>"></script>

<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/gdscoll.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/freegdscoll.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css"  />
<script type="text/javascript" language="javascript" >
$(document).ready(function() {  
	 
   	$(".option ul ").find('li').each(function(){
   		$(this).click(function(){
   			//$("#scoll").html($(this).html());
   		});
   		
   	});
   	$(".dpimglist span").find('img').each(function(i){
   		$(this).click(function(){
   			//$("#scoll").html('555');	
   			//$(this).css("border","solid 3px #aa2e44");
   			//getRack(i+1);
   			//addfun(i+1);
   		});
   	});
   	$(".gdetaillist li").find('a').each(function(){
   		$(this).click(function(){
   		  // $("#box1").css("background","none");
   		  // $("#box1").html($(this).html());
   		});
   	});
   	//初始化商品
   	var flag=<%=flag %>;
   	if(flag==5){
   	   getRack(6,'<%= category%>');
   	   $('.imgbox5 li:first').css('display','block');
   	}
    if(flag==6){
   
   	    getRack(5,'<%= category%>');
   		//getProductBycolde($('#type5').find('li:first-child'));
   	    $('.imgbox6 li:first').css('display','block');
   	}
   	if(flag==7){
   	    getRack(6,'<%= category%>');
 	   //getProductBycolde($('#type6').find('li:first-child'));
 	   $('.imgbox7 li:first').css('display','block');
   	}
   	
});
//获取商品
function getProductBycolde(obj)
{
   var id='<%=id %>';
   var code=$(obj).attr('code');
   var flag=$(obj).attr('attr');
   $(obj).parent().find('li').css('background','#6D6E72');
   $(obj).css('background','#a22e44');
   $.ajax({
	   type: "post",
        dataType: "json",
        url: "/gdscoll/getProduct1.jsp",
        cache: false,
        data:{'id':id,'rcode':code,'flag':flag},
        error: function(XmlHttpRequest){
           alert(XmlHttpRequest.status);
        },
        success: function(json){	
        	if(json.succ){
        	   $('#scoll').html(json.message);
        	}
        },beforeSend: function(){	
            $('#scoll').html('加载中,请稍等...');
        },complete: function(json){
        	
        }
   });
}

</script>
</head>

<body>
<%@include file="/inc/head.jsp" %>
  <!-- 中间内容 -->
   <div class="freecenter">
 
   <img src="http://images.d1.com.cn/images2012/index2012/AUGUST/diybanner.gif"/>
   <input type="hidden" id="category" value="<%= category%>"/>
      <div class="f_left">
          <div class="dpimglist">
              <span id="box1" style="width:150px; height:150px;">
                <img id="add1" src="http://images.d1.com.cn/images2012/index2012/AUGUST/add.png" style="position:absolute; top:10px; left:10px;" onclick="addfun(1);"/>
                  <p id="wz1" style="width:150px;top:100px; color:#333; font-size:13px; ">
                   <%
                     if(category==1){
                    	 out.print("点击添加头饰");
                     }
                     else
                     {
                    	 out.print("点击添加头饰");
                     }
                 %>
                 </p> 
                 <a id="cs1" href="javascript:void(0)" onclick="cx(1)" style="width:30px; color:#f00;display:none; right:10px; position:absolute;top:15px; font-size:13px;" >取消</a>
                 
                 <div class="dbox1">
                     <ul class="imgbox1">
                     
                     </ul>
                     <div class="clear"></div>
                     <ul class="cbox1"></ul>
                 </div>
                 
                 
                 
              </span>
              <span  id="box2"  style="width:150px; height:150px;">
                   <img id="add2" src="http://images.d1.com.cn/images2012/index2012/AUGUST/add.png" style="position:absolute; top:10px; left:10px;" onclick="addfun(2);"/>
                    <p id="wz2" style="width:150px;top:100px; color:#333; font-size:13px; ">
                     <%
                     if(category==1){
                    	 out.print("点击添加围巾");
                     }
                     else
                     {
                    	 out.print("点击添加手表");
                     }
                 %>
                 </p> 
                 <a id="cs2" href="javascript:void(0)" onclick="cx(2)" style="width:30px; color:#f00;display:none; right:10px; position:absolute;top:15px; font-size:13px;" >取消</a>
                   
                   <div class="dbox2">
                     <ul class="imgbox2">
                     
                     </ul>
                     <div class="clear"></div>
                     <ul class="cbox2"></ul>
                 </div>
              </span>
              <span  id="box3"  style="width:150px; height:150px;">
                   <img id="add3" src="http://images.d1.com.cn/images2012/index2012/AUGUST/add.png" style="position:absolute; top:10px; left:10px;" onclick="addfun(3);"/>
                    <p id="wz3" style="width:150px;top:100px; color:#333; font-size:13px; ">
                      <%
                     if(category==1){
                    	 out.print("点击添加腰带");
                     }
                     else
                     {
                    	 out.print("点击添加腰带");
                     }
                 %>
                 </p> 
                 <a id="cs3" href="javascript:void(0)" onclick="cx(3)" style="width:30px; color:#f00;display:none; right:10px; position:absolute;top:15px; font-size:13px;" >取消</a>
                  
                   <div class="dbox3">
                     <ul class="imgbox3">
                     
                     </ul>
                     <div class="clear"></div>
                     <ul class="cbox3"></ul>
                 </div>
              </span>
              <span id="box4" style="width:150px; height:150px;">
               <img id="add4" src="http://images.d1.com.cn/images2012/index2012/AUGUST/add.png" style="position:absolute; top:10px; left:10px;" onclick="addfun(4);"/>
                 <p id="wz4" style="width:150px;top:100px; color:#333; font-size:13px; ">
                  <%
                     if(category==1){
                    	 out.print("点击添加女鞋");
                     }
                     else
                     {
                    	 out.print("点击添加男鞋");
                     }
                 %>
                 </p>  
                 <a id="cs4" href="javascript:void(0)" onclick="cx(4)" style="width:30px; color:#f00;display:none; right:10px; position:absolute;top:15px; font-size:13px;" >取消</a>
                
                  <div class="dbox4">
                     <ul class="imgbox4">
                     
                     </ul>
                     <div class="clear"></div>
                     <ul class="cbox4"></ul>
                 </div>
              </span>
          </div>
          <div class="dpimglist" >
             <span id="box5" style="width:300px; height:301px;">
                
                 <img id="add5" src="http://images.d1.com.cn/images2012/index2012/AUGUST/add.png" style="position:absolute; top:80px; left:80px;  <% if(flag==5) out.print("display:none;"); if(flag!=7){out.print("border:solid 3px #aa2e44;");}%> " onclick="addfun(5);"/>
                
                 <p id="wz5" style="width:300px;top:170px; color:#333; font-size:13px;<% if(flag==5) out.print("display:none");%>  ">
               <%
	               if(category==1){
	              	 out.print("点击添加上装/连衣裙");
	               }
	               else
	               {
	              	 out.print("点击添加上装");
	               }
               %>
                 </p> 
                 <a id="cs5" href="javascript:void(0)" onclick="cx(5)" style="width:50px; color:#f00; right:85px; position:absolute;top:85px; font-size:13px; display:none">取消</a>
                 <div class="dbox5">
                     <ul class="imgbox5">
                <%
                    if(flag==5){                      %>                      
                     
                       <li >
                         <a href="javascript:void(0)" onclick="addfun1(5)" class="qba" attr="<%=id%>_5" m="<%= ps.getGdsmst_memberprice().floatValue() %>" title="<%= Tools.clearHTML(ps.getGdsmst_gdsname())+"&nbsp;&nbsp;&nbsp;单价："+ps.getGdsmst_memberprice().floatValue()+"元"  %>">
                    	   <img src="<%= img300300%>" width="300" height="300"/>
                    	</a>
                    	<p style="right:84px;"><a href="/product/<%=id %>" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/AUGUST/ck.png"></img></a></p>
                         <p onclick="addfun(5)" style="right:45px;" ><img src="http://images.d1.com.cn/images2012/index2012/AUGUST/adds.png"/></p>
                        <p onclick="deleteimg(this)" flag="5"><img src="http://images.d1.com.cn/images2012/index2012/AUGUST/deletes.png"/></p></li>
                    
                    	
                    <%}
                %>
               </ul>
                     <div class="clear"></div>
                     <ul class="cbox5">
                     <%
                    if(flag==5){
                       %>
                       <li class="current">●</li>
                     <%} %></ul>
                    </div>
              </span>
              <span id="box6" style="width:300px; height:301px;">
              
                <img id="add6" src="http://images.d1.com.cn/images2012/index2012/AUGUST/add.png" style="position:absolute; top:80px; left:80px; border:solid 3px #aa2e44;<% if(flag==6)out.print("display:none;"); %>" onclick="addfun(6);"/>
               <p id="wz6" style="width:300px;top:170px; color:#333; font-size:13px; <% if(flag==6) out.print("display:none");%> "> <%
                     if(category==1){
                    	 out.print("点击添加下装");
                     }
                     else
                     {
                    	 out.print("点击添加下装");
                     }
                 %>  </p> 
                <a id="cs6" href="javascript:void(0)" onclick="cx(6)" style="width:50px; display:block; right:85px; position:absolute;top:85px;  font-size:13px;color:#f00;  display:none " >取消</a>
                 
                   <div class="dbox6">
                     <ul class="imgbox6">
                  <%
                      if(flag==6){
                      %>
                     
                       <li><a href="javascript:void(0)" onclick="addfun1(6)" class="qba" attr="<%=id%>_6" m="<%= ps.getGdsmst_memberprice().floatValue() %>"  title="<%= Tools.clearHTML(ps.getGdsmst_gdsname())+"&nbsp;&nbsp;&nbsp;单价："+ps.getGdsmst_memberprice().floatValue()+"元"  %>">
                    	   <img src="<%= img300300%>" width="300" height="300"/>
                    	</a>
                    	<p style="right:84px;"><a href="/product/<%=id %>" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/AUGUST/ck.png"/></a></p>
                    	<p onclick="addfun(6);" style="right:45px;" ><img src="http://images.d1.com.cn/images2012/index2012/AUGUST/adds.png"/></p>
                        <p onclick="deleteimg(this)" flag="6"><img src="http://images.d1.com.cn/images2012/index2012/AUGUST/deletes.png"/></p></li>
                    
                  	
                  <%}
                  %>
                   </ul>
                     <div class="clear"></div>
                     <ul class="cbox6">
                      <%
                      if(flag==6){
                      %>
                      <li class="current">●</li>
                      <%} %>
                      </ul>
                    </div>
              </span>
          </div>
          <div class="dpimglist" style="position:relative; border-bottom:dashed 1px #ccc;">
              
              <span id="box7" style="width:300px; height:301px;">
                  <img id="add7" src="http://images.d1.com.cn/images2012/index2012/AUGUST/add.png" style="position:absolute; top:80px; left:80px; <% if(flag==7)out.print("display:none;"); if(flag!=5&&flag!=6){out.print("border:solid 3px #aa2e44;");}%>" " onclick="addfun(7);" />
                  <p id="wz7" style="width:300px;top:170px; color:#333; font-size:13px; <% if(flag==7)out.print("display:none;");%> ">点击添加外套 </p> 
                  <a id="cs7" href="javascript:void(0)" onclick="cx(7)" style="width:30px; color:#f00;display:none; right:85px; position:absolute;top:85px; font-size:13px;" >取消</a>
                  <div class="dbox7">
                     <ul class="imgbox7">
                     <%
                      if(flag==7){
                      %>
                     
                       <li><a href="javascript:void(0)" onclick="addfun1(7)" class="qba" attr="<%=id%>_7" m="<%= ps.getGdsmst_memberprice().floatValue() %>"  title="<%= Tools.clearHTML(ps.getGdsmst_gdsname())+"&nbsp;&nbsp;&nbsp;单价："+ps.getGdsmst_memberprice().floatValue()+"元"  %>">
                    	   <img src="<%= img300300%>" width="300" height="300"/>
                    	</a>
                    	<p style="right:84px;"><a href="/product/<%=id %>" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/AUGUST/ck.png"/></a></p>
                    	<p onclick="addfun(7);" style="right:45px;" ><img src="http://images.d1.com.cn/images2012/index2012/AUGUST/adds.png"/></p>
                        <p onclick="deleteimg(this)" flag="7"><img src="http://images.d1.com.cn/images2012/index2012/AUGUST/deletes.png"/></p></li>
                    
                  	
                  <%}
                  %>
                   </ul>
                     <div class="clear"></div>
                     <ul class="cbox7">
                      <%
                      if(flag==7){
                      %>
                      <li class="current">●</li>
                      <%} %>
                      </ul>
                     <div class="clear"></div>
                     
                 </div>
              </span>
               <span  id="box8"style="width:150px; height:150px;  ">
                  <img id="add8" src="http://images.d1.com.cn/images2012/index2012/AUGUST/add.png" style="position:absolute; top:10px; left:10px;" onclick="addfun(8);"/>
                  <p id="wz8" style="width:150px;top:100px; color:#333; font-size:13px; ">
                   <%
                     if(category==1){
                    	 out.print("点击添加包包");
                     }
                     else
                     {
                    	 out.print("点击添加男包");
                     }
                 %>
                 </p>  
                 <a id="cs8" href="javascript:void(0)" onclick="cx(8)" style="width:30px; color:#f00;display:none; right:10px; position:absolute;top:15px; font-size:13px;" >取消</a>
                 
                  <div class="dbox8">
                     <ul class="imgbox8">
                     
                     </ul>
                     <div class="clear"></div>
                     <ul class="cbox8"></ul>
                 </div>
              </span>
              <span id="box9" style="width:150px; height:150px; border-bottom:none; ">
                  <img id="add9" src="http://images.d1.com.cn/images2012/index2012/AUGUST/add.png" style="position:absolute; top:10px; left:10px;" onclick="addfun(9);"/>
                  <p id="wz9" style="width:150px;top:100px; color:#333; font-size:13px; ">
                  <%
                     if(category==1){
                    	 out.print("点击添加饰品");
                     }
                     else
                     {
                    	 out.print("点击添加名品");
                     }
                 %>
                 </p>  
                  <a id="cs9" href="javascript:void(0)" onclick="cx(9)" style="width:30px; color:#f00;display:none; right:10px; position:absolute;top:15px; font-size:13px;" >取消</a>
                 
                  <div class="dbox9">
                     <ul class="imgbox9">
                     
                     </ul>
                     <div class="clear"></div>
                     <ul class="cbox9"></ul>
                 </div>
              </span>
              <div class="goodsprice">
                 <table>
                    <tr>
                       <td>   
                        <font style="text-align:left; font-size:12px; color:#aa2e44;display:block; width:90%; margin:0px auto;">   说明：<br/>&nbsp;&nbsp;&nbsp;&nbsp;两件或两件以上95折</font>  <br/><br/>
                        <font style="color:#A73E4F; font-size:14px; font-weight:bold;">共&nbsp;<em id="count">1</em>&nbsp;件&nbsp;&nbsp;组合购买</font><br/>
                 <br>
                 <strike>总价：￥&nbsp;<em id="totalmoney"><%= ps.getGdsmst_memberprice().floatValue() %></em>&nbsp;元  </strike>
                 <br>组合价：<font color="#bc0000" face="微软雅黑">￥&nbsp;<em id="money"><%= ps.getGdsmst_memberprice().floatValue() %></em>&nbsp;</font>元<br>
                                                  共优惠：￥&nbsp;<em id="cheap"><%= 0.0 %></em>&nbsp;元  <br><br>
                  <a href="javascript:void(0)" onclick="AddInCart1(this)"><img src="http://images.d1.com.cn/Index/images/ljgmgzh.jpg" >                             
                     </a>   </td>
                    </tr>
                 </table>     
               </div>   
          </div>
      </div>
      <div class="f_right">
          <div class="choosetype">
            <div  class="option">
	            <table>
	            <tr><td>
	                <ul id="type1">
	                </ul> 
	                <ul id="type2" >
	                 </ul> 
	                <ul id="type3" >
	                </ul> 
	                 <ul id="type4" >
	                </ul> 
	                 <ul id="type5" <% if(flag==0) { out.print("style=\"display:block\";");} %> >
	                </ul> 
	                 <ul id="type6" <% if(flag==1) { out.print("style=\"display:block\";");} %>>
	                </ul> 
	                 <ul id="type7" >
	                </ul> 
	                 <ul id="type8" >
	                </ul> 
	                 <ul id="type9" >
	                </ul> 
	            </td></tr>
	            </table>
            </div>
            <!-- 商品轮播 -->
            <div>
            <div id="scoll" class="newsubgdscoll">
               
            </div>
            </div>
           
          </div>
      
      </div>
      <input id="caflag" type="hidden" value="0"/>
      <div class="clear"></div>
   </div>
  
  
  <!-- 中间内容结束 -->
  
<div class="clear"></div>
<!-- 底部 -->
<%@ include file="/inc/foot.jsp" %>
<!-- 底部结束 -->
   
</body>
</html>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script type="text/javascript" language="javascript">
$(document).ready(function() {
  $("#scolllist").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
});
</script>