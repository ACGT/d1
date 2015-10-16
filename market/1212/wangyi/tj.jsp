<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%!
public static ArrayList<PromotionProduct> getPProductByCode(String code,int num){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
	clist.add(Restrictions.le("spgdsrcm_begindate",new Date()));
	clist.add(Restrictions.ge("spgdsrcm_enddate",new Date()));

	//加入排序条件
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.asc("spgdsrcm_seq"));
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, num);
	if(list==null||list.size()==0)return null;	
	for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			rlist.add(pp);
		}
	return rlist ;
}

%>
<%
ArrayList<PromotionProduct> pproductlist=getPProductByCode("8265",100);

if(pproductlist!=null && pproductlist.size()>0){
	
	for(PromotionProduct pproduct:pproductlist){
		SimpleDateFormat sf1 = new SimpleDateFormat("MM月dd日");
		SimpleDateFormat sf2 = new SimpleDateFormat("yyyy年MM月dd日");
		long hit=1;
		if(pproduct.getSpgdsrcm_tghit()!=null && pproduct.getSpgdsrcm_tghit()>0){
			hit=pproduct.getSpgdsrcm_tghit();	
		}
		long lcount=((new Date().getTime()-pproduct.getSpgdsrcm_begindate().getTime())/1000/60/30)*hit;//每3分钟**个
		
		%>
	<div class="mod-lucky">	
		<div class="hd">
		<div class="g-status">			<!-- 标题 -->			
			<h3 class="title">进行中</h3>	
				<div class="remark"><div class="date"><%=sf1.format(pproduct.getSpgdsrcm_begindate()) %></div>
				<div class="date">至</div><div class="date"><%=sf1.format(pproduct.getSpgdsrcm_enddate()) %></div>	
				</div>									<!-- 说明 -->						<!-- 卷边 -->			
				<b class="ico ico-scroll"></b>	
		</div>
		<h2><a target="_blank" href="<%=pproduct.getSpgdsrcm_otherlink()%>"><%=pproduct.getSpgdsrcm_gdsname() %></a></h2>
		</div>	
		<div class="bd">		<!-- 抽奖区 -->		
		<div class="g-lucky-zone">			<!-- 图片展示 -->		
			<a target="_blank" href="<%=pproduct.getSpgdsrcm_otherlink()%>"><img src="<%=pproduct.getSpgdsrcm_otherimg() %>" class="picShow" />	</a>
			<div class="lucky-info">				<!-- 信息一 -->	
          <div class="item">
         <%=pproduct.getSpgdsrcm_layertitle() %>
	      </div>				<!-- 信息二 -->	
	    <div class="item">	
			<p></p>				
		</div>	
		</div>
		<!-- 抽奖按钮 -->			
		<div class="luckyBtn">	
		<span id = "lucky<%=pproduct.getId()%>">	
		<a href="<%=pproduct.getSpgdsrcm_otherlink()%>" title="马上兑换" class="btn-exchange"  target="_blank" ></a>	</span>	
		<p class="joinNum">	已有 <span class="txt-impt" id="attendance4295"><%=lcount %></span> 人参加				</p>	
			</div>			
			<!-- 剩余时间 -->		
				<div class="timeRest">	兑换在<%=sf2.format(pproduct.getSpgdsrcm_enddate()) %>结束	</div>		</div>		
				<!-- 活动说明 -->		
				<div class="remark"><%=pproduct.getSpgdsrcm_briefintrduce() %></div>
				<div class="ft"></div>	
		</div>	 
		</div>		
	<%}
	%>
	
	<%
}

%>

