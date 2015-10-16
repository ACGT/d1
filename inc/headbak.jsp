<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%!
//缓存头部推荐位的Map，key是推荐位，value是推荐位的值
private static Map<String,String> HEAD_PROMOTION_MAP_1999 = Collections.synchronizedMap(new HashMap<String,String>());
//头部菜单推荐位显示方法
public static String getHeadPromotionMemu(String pcode,int length,boolean isNewWindow){
	return getHeadPromotionMemu(pcode,length,isNewWindow,null);
}

public static String getHeadPromotionMemu(String pcode,int length,boolean isNewWindow,String split){
	if(HEAD_PROMOTION_MAP_1999.containsKey(pcode)){
		Long pcode_time = new Long(HEAD_PROMOTION_MAP_1999.get(pcode+"_time"));
		if(System.currentTimeMillis()-pcode_time.longValue()<=60*1000l){//缓存时间小于60秒就走缓存
			return HEAD_PROMOTION_MAP_1999.get(pcode);
		}
	}
	java.util.List<com.d1.bean.Promotion> rack_head_1k = com.d1.helper.PromotionHelper.getBrandListByCode(pcode , length);
	StringBuffer sb = new StringBuffer();
	if(rack_head_1k!=null && !rack_head_1k.isEmpty()){
		int i = 0;
		int size = rack_head_1k.size();
		for(com.d1.bean.Promotion p_1384k:rack_head_1k){
			String url_7 = p_1384k.getSplmst_url();
			if(url_7!=null)url_7=url_7.replaceAll(" ", "+");
			sb.append("<a href='").append(StringUtils.encodeUrl(url_7))
			.append("' title='").append(StringUtils.replaceHtml(p_1384k.getSplmst_name()))
			.append("'"+(isNewWindow?" target='_blank'":"")+">")
			.append(StringUtils.replaceHtml(p_1384k.getSplmst_name()))
			.append("</a>");
			if(split != null && i<size-1) sb.append(split);
			i++;
		}
	}
	HEAD_PROMOTION_MAP_1999.put(pcode,sb.toString());
	HEAD_PROMOTION_MAP_1999.put(pcode+"_time",System.currentTimeMillis()+"");
	return sb.toString();
}
%><%
String chePingAn = Tools.getCookie(request,"PINGAN");
String url_file = request.getServletPath();

String headsearchkey_in_head = request.getParameter("headsearchkey");
if(headsearchkey_in_head==null||headsearchkey_in_head.trim().length()==0||headsearchkey_in_head.equals("null")){
	String keyWords_123 = request.getParameter("key_wds");
	if(keyWords_123==null||keyWords_123.trim().length()==0){
		headsearchkey_in_head="请输入您要搜索的商品名称";
	}else{
		keyWords_123 = keyWords_123.replaceAll(" ", "+");
		headsearchkey_in_head = Base64.decode(keyWords_123);
	}
}
if(url_file != null && url_file.length()>0) url_file = url_file.substring(1).replace(".jsp","");

Variable head_variable = (Variable)Tools.getManager(Variable.class).findByProperty("name", "HEAD_NOTICE");//头部通知
if(head_variable!=null&&!Tools.isNull(head_variable.getValue())){
	%><div class="top-head-notice"><%=head_variable.getValue()%></div><%
}
%>
<div id="header">
		<h1><a href="/" title="返回首页">优尚购物</a></h1>
		<p class="user_help">
			<span class="f_r"><a href="/user/" target="_blank">我的帐户</a>| <a href="/user/selforder.jsp" target="_blank">订单查询</a>| <a href="/user/ticket.jsp" target="_blank">我的优惠券</a>| <%if (Tools.isNull(chePingAn)) {%><a href="/jifen/index.jsp" target="_blank">积分换购</a><%} %>|<a href="/help/" target="_blank">帮助中心</a></span>	<span class="ShowWelcome" id="ShowWelcome">&nbsp;</span></p>
        <p class="<%="1".equals(chePingAn)?"pinganlogo":"" %>"></p>
        <p class="tel">联系电话：4006808666，09:00-21：00免长途费</p>
        <div class="clear"></div>
	</div>
	<div id="menu">
      <div class="wrapper">
		<ul class="nav" id="head_nav">
			<li pg="index" ><a href="/">首 页</a></li>
			<li pg="html/cloth/index"><a href="/html/cloth/">女 装</a></li>
			<li pg="html/man/index"><a href="/html/man/">男 装</a></li>
			<li pg="html/cosmetic/index"><a href="/html/cosmetic/">化妆品</a></li>
			<li pg="html/ornament/index"><a href="/html/ornament/">饰 品</a></li>
			<li pg="html/shoebag/index"><a href="/html/shoebag/">女 包</a></li>
			<li pg="html/watch/index"><a href="/html/watch/">名 表</a></li>
		</ul>
        <span class="menu_bgs"></span>
 		<ul class="theme">
			<li><a href="/tuan/" target="_blank">优尚团</a></li>
			<li><a href="/html/jbth2012" target="_blank">五折特惠</a></li>
            <li style="position:relative;"><img style="position:absolute;top:-8px;left:68px;" src="http://images.d1.com.cn/Index/images/hot.gif" /><a href="/html/zt2012/0214week/" target="_blank">主打星</a></li>
		</ul>
        <div class="search_box">
        	<span class="buy_list" id="headerbuy_list"><a href="/flow.jsp" target="_blank">购物车中有<em id="headcardnum"><%=CartHelper.getTotalProductCount(request,response)%></em>件商品</a></span>
        	<span class="search_layout">
        		<em><div id="ffb9"></div></em><a href="###" onclick="searchbut()" class="lgray_btn">搜 索</a>
        		<div class="clear"></div>
        	</span>

            <span class="hot_search">热门搜索：|<%=getHeadPromotionMemu("2715",4,true,"|") %></span>
            <div class="cart" id="Headcart">
            	正在加载购物车...<img src="/res/images/Loading.gif" alt="Loading" />
            </div>
            <div class="clear"></div>
            
            <div class="leftnav" id="leftnav">
        			<span class="btn" id="left_btn"></span>
					<div class="comsbox" id="comsbox">
						<div class="opts">
							<div class="item">
								<span><a href="/html/cloth/">女装</a></span>
								<div class="lsnav">
									<dl><dt>热门分类</dt>
										<dd>
										<%=getHeadPromotionMemu("2496",15,false)%>
										</dd>
									</dl>
									<dl class="bd_t"><dt>热门品牌</dt>
										<dd>
										<%=getHeadPromotionMemu("2497",15,true)%>
										</dd>
									</dl>
								<div class="t_r"><a href="/brand/#wcloth" class="more"><s>&gt;&gt;</s>查看全部</a></div></div>
							</div>
							<div class="ulx">
								<span><%=getHeadPromotionMemu("2810",10,false) %></span>
							</div>
						</div>
						<div class="opts">
							<div class="item">
								<span><a href="/html/man/">男装</a></span>
								<div class="lsnav" style="top:-88px;">
								<dl><dt>热门分类</dt>
									<dd>
									<%=getHeadPromotionMemu("2512",20,false)%>
									</dd>
								</dl>
								<dl class="bd_t"><dt>热门品牌</dt>
									<dd>
									<%=getHeadPromotionMemu("2513",20,true)%>
									</dd>
								</dl>
							<div class="t_r"><a href="/brand/#cloth" class="more"><s>&gt;&gt;</s>查看全部</a></div></div>
							</div>
							<div class="ulx">
								<span><%=getHeadPromotionMemu("2811",10,false) %></span>
							</div>
						</div>
						<div class="opts">
							<div class="item">
								<span><a href="/html/cosmetic/">化妆品</a></span>
								<div class="lsnav" style="top:-148px;">
								<dl><dt>热门分类</dt>
										<dd>
										<%=getHeadPromotionMemu("2500",20,false)%>
										</dd>
									</dl>
									<dl class="bd_t"><dt>热门品牌</dt>
										<dd>
										<%=getHeadPromotionMemu("2501",20,true)%>
										</dd>
									</dl>
								<div class="t_r"><a href="/brand/#hzp" class="more"><s>&gt;&gt;</s>查看全部</a></div></div>
							</div>
							<div class="ulx">
								<span><%=getHeadPromotionMemu("2812",10,false) %></span>
							</div>
						</div>
						<div class="opts">
							<div class="item">
								<span><a href="/html/ornament/">饰品</a></span>
								<div class="lsnav" style="top:-148px;">
								<dl><dt>热门分类</dt>
									<dd>
									<%=getHeadPromotionMemu("2504",10,false)%>
									</dd>
								</dl>
								<dl class="bd_t"><dt>热门品牌</dt>
									<dd>
									<%=getHeadPromotionMemu("2505",20,true)%>
									</dd>
								</dl>
							<div class="t_r"><a href="/brand/#clsp" class="more"><s>&gt;&gt;</s>查看全部</a></div></div>
							</div>
							<div class="ulx">
								<span><%=getHeadPromotionMemu("2813",10,false) %></span>
							</div>
						</div>
						<div class="opts">
							<div class="item">
								<span><a href="/html/shoebag/">女包</a></span>
								<div class="lsnav" style="top:-148px;">
								<dl><dt>热门分类</dt>
									<dd>
									<%=getHeadPromotionMemu("2508",10,false)%>
									</dd>
								</dl>
								<dl class="bd_t"><dt>热门品牌</dt>
									<dd>
									<%=getHeadPromotionMemu("2509",20,true)%>
									</dd>
								</dl>
							<div class="t_r"><a href="/brand/#clsp" class="more"><s>&gt;&gt;</s>查看全部</a></div></div>
							</div>
							<div class="ulx">
								<span><%=getHeadPromotionMemu("2814",10,false) %></span>
							</div>
						</div>
						
						<div class="opts">
							<div class="item">
								<span><a href="/html/watch/">名表</a></span>
								<div class="lsnav" style="top:-148px;">
								<dl><dt>热门分类</dt>
									<dd>
									<%=getHeadPromotionMemu("2516",20,false)%>
									</dd>
								</dl>
								<dl class="bd_t"><dt>热门品牌</dt>
									<dd>
									<%=getHeadPromotionMemu("2517",15,true)%>
									</dd>
								</dl>
							<div class="t_r"><a href="/brand/#watch" class="more"><s>&gt;&gt;</s>查看全部</a></div></div>
							</div>
							<div class="ulx">
								<span><%=getHeadPromotionMemu("2815",10,false) %></span>
							</div>
						</div>
						<div class="watchs"></div>
					</div>
        		</div>
        </div>
      </div>
	</div>
	<!-- end #menu -->
   	<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/head.js")%>"></script>
   	<script type="text/javascript">
   	stepNavAction('<%=url_file %>');
   	<%
	String keyWords_135 = request.getParameter("key_wds");
 	String sk_23847 = request.getParameter("headsearchkey");
  	if(!Tools.isNull(sk_23847)){//重新搜索了
   		keyWords_135 = sk_23847 ;
   	}else{
   		if(keyWords_135!=null)keyWords_135=keyWords_135.replaceAll(" ", "+");
   		keyWords_135 = Base64.decode(keyWords_135);//用base64编码传中文，免得出现乱码问题
   	}
  	if(!Tools.isNull(keyWords_135)){
	   	%>
	   	$(document).ready(function(){
	   		$('#ffb9_input').val("<%=Tools.repstr(keyWords_135)%>");
	   	});
	   	<%  
  	}
   	%>
   	</script>