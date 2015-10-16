<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%>
  <!--左侧-->
    <div class="mbr_left">
	   <a href="/user" target="_blank"><img src="http://images.d1.com.cn/images2012/New/user/hyzx_ys.jpg" width="202" height="37" /></a>
	   <div class="mbr_left_sub">
			   <div class="ltitle">
				<img src="http://images.d1.com.cn/images2012/New/user/ddgl_logo.jpg" />订单管理
				</div>
				<ul>
				   <li><a href="/user/selforder.jsp">近期订单</a></li>
				   <li><a href="/user/selforderhistory.jsp">四个月之前订单</a></li>
				</ul>
				<div class="ltitle">
				<img src="http://images.d1.com.cn/images2012/New/user/zhzx_logo.jpg" style=" margin-left:1px;" />账户中心
				</div>
				<ul>
				   <li><a href="/user/ticket.jsp">我的优惠券</a></li>
				   <%//String chePingAn = Tools.getCookie(request,"PINGAN");
				   if (Tools.isNull(chePingAn)){%>
				   <li><a href="/user/points.jsp">我的积分</a></li>
				   <li><a href="/jifen/" target=_blank>积分换礼</a></li>
				   <%} %>
				   <li><a href="/user/balance.jsp">我的预存款</a></li>
				   
				</ul>
				<div class="ltitle">
				<img src="http://images.d1.com.cn/images2012/New/user/grxx_logo.jpg" style=" margin-left:1px;" />个人应用管理
				</div>
				<ul>
				 	<li><a href="/user/comment.jsp">我的评论</a></li>
				 	 <li><a href="/user/myshoworder.jsp">我的晒单</a></li>
				   <li><a href="/flow.jsp" target=_blank>我的购物车</a></li>
				   <li><a href="/user/favorite.jsp">我的收藏夹</a></li>
				
				   <li><a href="/user/consult.jsp">购买咨询</a></li>
				  <!--  <li><a href="/feedback/feedback.jsp" target=_blank>意见反馈</a></li> -->
				</ul>
				<div class="ltitle">
				<img src="http://images.d1.com.cn/images2012/New/user/gryy_logo.jpg" style=" margin-left:1px;" />个人信息管理
				</div>
				<ul>
				   <li><a href="/user/address.jsp">收货地址</a></li>
				   <li><a href="/user/profile.jsp">修改个人资料</a></li>
				   <li><a href="/user/changepassword.jsp">修改密码</a></li>
				</ul>
				<div class="ltitle">
				<img src="http://images.d1.com.cn/images2012/New/user/gwjl_logo.jpg" style=" margin-left:1px;" />购物交流
				</div>
				<!--<ul>
				   <li><a href="/user/comment.jsp">商品评价</a></li>
				   <li><a href="/user/message.jsp">站内消息</a></li
				   <li><a href="/user/invest.jsp">身材调查</a></li
				   <li><a href="/tuan/" target=_blank>优尚团</a></li>
				  
				   
				</ul>-->
				<div class="ltitle">
				<a href="/logout.jsp">退出登录</a>
				</div>
				<div class=" left_bottom">
				  客服电话：400 680 8666<br/>
				  工作时间：9:00-18:00
				</div>
		</div>
   </div>
       <!-- 左侧内容结束 -->