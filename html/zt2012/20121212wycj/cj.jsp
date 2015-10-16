<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%

		 java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		 String	nowtime= df.format(new Date());
		 String tttime ="2013/01/01 00:00:00";
		
		long lcount1=1300+((new Date().getTime()-df.parse("2012/12/14 14:00:00").getTime())/1000/60)*3;//每分钟**个
		long lcount2=1190+((new Date().getTime()-df.parse("2012/12/14 14:00:00").getTime())/1000/60)*2;//每分钟**个
		%>
	<div class="mod-lucky">	
		<div class="hd">
		<div class="g-status">			<!-- 标题 -->			
			<h3 class="title">进行中</h3>	
				<div class="remark"><div class="date">12月17日</div>
				<div class="date">至</div><div class="date">12月31日</div>	
				</div>									<!-- 说明 -->						<!-- 卷边 -->			
				<b class="ico ico-scroll"></b>	
		</div>
		<h2><a target="_blank" href="http://www.d1.com.cn/product/01511168">	D1优尚网圣诞真情回馈，0元（包邮）赢取市场价999元泰国进口3朵永不凋谢真玫瑰花——“我爱你”，																																
	每人可参加抽奖1次！未中奖的会员，有机会获得D1优尚网“特惠商品兑换码”1张，																																
	多款超值特惠商品任选！																																
</a></h2>
		</div>	
		<div class="bd">		<!-- 抽奖区 -->		
		<div class="g-lucky-zone">			<!-- 图片展示 -->		
			<a target="_blank" href="http://www.d1.com.cn/product/01511168"><img src="http://images.d1.com.cn/images2012/market/wangyi1212/980-1.jpg" class="picShow" />	</a>
			<div class="lucky-info">				<!-- 信息一 -->	
			<div class="item" style="padding-top:15px;padding-bottom:20px;">	
			<span style="font-size:20px;">每个ID只能选择一项抽奖机会</span>				
		</div>	
          <div class="item" >
         <p><strong>每天中奖名额：</strong><strong class="txt-striking">10</strong>名</p>
	      </div>				<!-- 信息二 -->	
	    
		</div>
		<!-- 抽奖按钮 -->			
		<div class="luckyBtn">	
		<span id = "lucky1">	
		<a href="javascript:void(0);" title="马上抽奖" class="btn-lucky"  onclick="getcj('01511168')" ></a>	</span>	
		<p class="joinNum">	已有 <span class="txt-impt"><%=lcount1 %></span> 人参加				</p>	
			</div>			
			<!-- 剩余时间 -->		
				<div class="timeRest">	
				<span  class="name">剩余时间：</span>
				<span  class="Cont"><span  id="sdjs" style="color:#B90000;"></span></span>
					</div>		</div>		
				<!-- 活动说明 -->		
				<div class="remark">																									
				1、网易会员均可参加“0元（包邮）赢取市场价999元泰国进口3朵永不凋谢真玫瑰花”抽奖1次。<br>													
2、该赢取码仅能赢取该泰国进口3朵永不凋谢真玫瑰花，其他商品不能使用。		<br>													
3、其他商品可以和该赢取商品一起订购，同享包邮礼遇。			<br>												
4、仅赢取该商品不需要支付任何费用。		<br>													
5、赢取码有效期截止至：2012年12月31日，逾期作废。	<br>															
6、<a target="_blank" href="http://www.d1.com.cn/html/zt2012/20121212wycj/dhindex.jsp">未中奖会员兑换专区>>		</a>												

</div>
				<div class="ft"></div>	
		</div>	 
		</div>	
		<div class="mod-lucky">	
		<div class="hd">
		<div class="g-status">			<!-- 标题 -->			
			<h3 class="title">进行中</h3>	
				<div class="remark"><div class="date">12月17日</div>
				<div class="date">至</div><div class="date">12月31日</div>	
				</div>									<!-- 说明 -->						<!-- 卷边 -->			
				<b class="ico ico-scroll"></b>	
		</div>
		<h2><a target="_blank" href="http://www.d1.com.cn/product/03300077">D1优尚网圣诞真情回馈，0元（包邮）赢取市场价458元【FEEL MIND】经典商务休闲真皮钱包+腰带2件套，																																
每人可参加抽奖1次！未中奖的会员，有机会获得D1优尚网“特惠商品兑换码”1张，																																
多款超值特惠商品任选！																																																		
</a></h2>
		</div>	
		<div class="bd">		<!-- 抽奖区 -->		
		<div class="g-lucky-zone">			<!-- 图片展示 -->		
			<a target="_blank" href="http://www.d1.com.cn/product/03300077"><img src="http://images.d1.com.cn/images2012/market/wangyi1212/980-2.jpg" class="picShow" />	</a>
			<div class="lucky-info">				<!-- 信息一 -->	
			<div class="item" style="padding-top:15px;padding-bottom:20px;">	
			<span style="font-size:20px;">每个ID只能选择一项抽奖机会</span>						
		</div>	
          <div class="item">
         <p><strong>每天中奖名额：</strong><strong class="txt-striking">20</strong>名</p>
	      </div>				<!-- 信息二 -->	
	    
		</div>
		<!-- 抽奖按钮 -->			
		<div class="luckyBtn">	
		<span id = "lucky1">	
		<a href="javascript:void(0);" title="马上抽奖" class="btn-lucky"  onclick="getcj('03300077')" ></a>	</span>	
		<p class="joinNum">	已有 <span class="txt-impt"><%=lcount2 %></span> 人参加				</p>	
			</div>			
			<!-- 剩余时间 -->		
				<div class="timeRest">	
				<span  class="name">剩余时间：</span>
				<span  class="Cont"><span  id="sdjs2" style="color:#B90000;"></span></span>
					</div>		</div>		
				<!-- 活动说明 -->		
				<div class="remark">																									
				1、网易会员均可参加“0元（包邮）赢取市场价458元【FEEL MIND】经典商务休闲真皮钱包+腰带2件套”抽奖1次。<br>													
2、该赢取码仅能赢取该【FEEL MIND】经典商务休闲真皮钱包+腰带2件套，其他商品不能使用。		<br>													
3、其他商品可以和该赢取商品一起订购，同享包邮礼遇。			<br>												
4、仅赢取该商品不需要支付任何费用。		<br>													
5、赢取码有效期截止至：2012年12月31日，逾期作废。	<br>															
6、<a target="_blank" href="http://www.d1.com.cn/html/zt2012/20121212wycj/dhindex.jsp">未中奖会员兑换专区>>		</a>												

</div>
				<div class="ft"></div>	
		</div>	 
		</div>			
 <script language=javascript>
		var startDate= new Date("<%=nowtime%>");var endDate= new Date("<%=tttime%>");
		 lasttime=(endDate.getTime()-startDate.getTime())/1000;
		if(lasttime>0){
			setInterval(view_time2,1000);
		}
		</script>