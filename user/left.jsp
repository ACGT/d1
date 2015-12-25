<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%!//判断用户在活动期间是否参加过抽奖活动
boolean getCjInfo(String mbrid){
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("wycjinfo_mbrid", mbrid));
	//clist.add(Restrictions.eq("wycjinfo_gdsid", gdsid));
	List<BaseEntity> mxlist= Tools.getManager(Wyhfcj.class).getList(clist, null, 0, 1);
	if(mxlist==null || mxlist.size()==0) return false;
	
	return true;
} %>
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
				   <%UserVip bjbirth=(UserVip)Tools.getManager(UserVip.class).get(lUser.getId());
				   if(bjbirth!=null&&lUser.getMbrmst_birthday()!=null){
					   SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
					   Date nowday=new Date();
					   Date dStartDate=Tools.addDate(nowday, -10); 
					   Date endDate=Tools.addDate(nowday, 10); 
					   Date sDate=fmt.parse("2013-04-5");
					   SimpleDateFormat fmtmd = new SimpleDateFormat("MM-dd");
					   long histime=fmtmd.parse(fmtmd.format(sDate)).getTime();
					   long stime=fmtmd.parse(fmtmd.format(dStartDate)).getTime();
					   long etime=fmtmd.parse(fmtmd.format(endDate)).getTime();
					   long birtime=fmtmd.parse(fmtmd.format(lUser.getMbrmst_birthday())).getTime();
					   long sbirtime=fmtmd.parse(fmtmd.format(bjbirth.getBjvip_createtime())).getTime();
					   if(birtime>=stime&&birtime<=etime){
				   %>
				   <li><a href="/user/birth.jsp" style="color:red">白金生日礼物领取</a></li>
				   <%}
				   } %>
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
				 	 <!-- <li><a href="/user/myshoworder.jsp">我的晒单</a></li> -->
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
				   <li><a href="/newlogin/profile.jsp">修改个人资料</a></li>
				   <li><a href="/user/changepassword.jsp">修改密码</a></li>
				   <%if(lUser!=null && getCjInfo(lUser.getId())){ %><li><a href="/user/wycjinfo.jsp">我的兑换码</a></li><%} %>
				</ul>
				
				
				<div class="ltitle">
				<a href="/logout.jsp">退出登录</a>
				</div>
				<div class=" left_bottom">
				 
				</div>
		</div>
   </div>
       <!-- 左侧内容结束 -->