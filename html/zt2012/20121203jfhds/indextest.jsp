<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
 <%!	/**
	 * 获取有效地积分换购信息
	 */
	public static ArrayList<Award> getAwardList(){
		
		ArrayList<Award> rlist = new ArrayList<Award>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("award_validflag", new Long(1)));
		//clist.add(Restrictions.eq("award_vipflag", new Long(0)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("award_seq"));
		olist.add(Order.asc("award_price"));
		List<BaseEntity> list = Tools.getManager(Award.class).getList(clist, olist, 0, 200);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((Award)be);
		}
		//System.out.print(rlist.size());
		return rlist ;
	}
	 %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http:/www.w3.org/1999/xhtml">
<head>
<title>积分大换购-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">

function op(obj){
	if (window.confirm("确定要兑换此商品吗?一经兑换,不能恢复.")){
		addCart(obj);
	}
}
function addCart(obj){	
	var gdsid=$(obj).attr("attr");
	var flags='';
	if($(obj).attr("flags")!=null&&$(obj).attr("flags").length>0)
		{
		flags=$(obj).attr("flags");
		}
	if(gdsid.indexOf(",")>0){
		var mid=$.trim($("#hmid").val());
		if(mid.length==0){
			Login_Dialog();
		}else{
		$.close(); 
		var s="";if((typeof c)!="undefined"){s="?c="+encodeURIComponent(c);}else{s=""+document.location;s=s.replace("http://","");s=s.substring(s.indexOf("/"));s="?c="+encodeURIComponent(s);}$.load("选择商品颜色和尺码",450,"/jifen/choosesku.jsp?flags="+flags);
		}
	}
	else{
	   $.inCart(obj,{ajaxUrl:'/ajax/flow/listAwardInCart.jsp'});
	}
}

</script>
<style>
a img{border:none;}
.newlist1 {margin:0px;padding:0px; list-style:none; background:#fff7d2}
.newlist1 li{ float:left; width:230px;height:353px; overflow:hidden; margin-left:5px; position:relative; margin-bottom:10px; background:#ffd200; text-align:center;}
</style>
</head>
<body>
 <!-- 头部开始 -->
   <%@ include file="/inc/head.jsp" %>
   <!-- 头部结束 -->    
<%
    ArrayList<Award> alist=getAwardList();
    ArrayList<Award> alistx=new ArrayList<Award>();
    ArrayList<Award> alistf=new ArrayList<Award>();
    ArrayList<Award> alisth=new ArrayList<Award>();
    ArrayList<Award> alistt=new ArrayList<Award>();
    ArrayList<Award> alistth=new ArrayList<Award>();
    ArrayList<Award> alistx1=new ArrayList<Award>();
    ArrayList<Award> alistf1=new ArrayList<Award>();
    ArrayList<Award> alisth1=new ArrayList<Award>();
    ArrayList<Award> alistt1=new ArrayList<Award>();
    ArrayList<Award> alistth1=new ArrayList<Award>();
    if(alist!=null&&alist.size()>0)
    {
    	for(Award award:alist)
    	{
    		if(award!=null&&Tools.parseInt(award.getId())>1059&&!award.getAward_gdsid().equals("00000000"))
    		{
    			if(award.getAward_value().longValue()>=500&&award.getAward_value().longValue()<1000)
    			{
    				if(award.getAward_gdsid()!=null&&Tools.isNumber(award.getAward_gdsid()))
    				{
    					Product p=ProductHelper.getById(award.getAward_gdsid());
    					if(p!=null)
    					{
    						if((p.getGdsmst_ifhavegds().longValue()!=0&&p.getGdsmst_ifhavegds().longValue()!=3)||p.getGdsmst_validflag().longValue()==2){
    							alistf1.add(award);
    						}
    						else
    						{
    							alistf.add(award);
    						}
    					}
    				}
    			}
    			else if(award.getAward_value().longValue()>=1000&&award.getAward_value().longValue()<2000)
    			{
    				if(award.getAward_gdsid()!=null&&Tools.isNumber(award.getAward_gdsid()))
    				{
    					Product p=ProductHelper.getById(award.getAward_gdsid());
    					if(p!=null)
    					{
    						if((p.getGdsmst_ifhavegds().longValue()!=0&&p.getGdsmst_ifhavegds().longValue()!=3)||p.getGdsmst_validflag().longValue()==2){
    							alisth1.add(award);
    						}
    						else
    						{
    							alisth.add(award);
    						}
    					}
    				}
    				
    			}
    			else if(award.getAward_value().longValue()>=2000&&award.getAward_value().longValue()<3000)
    			{
    				if(award.getAward_gdsid()!=null&&Tools.isNumber(award.getAward_gdsid()))
    				{
    					Product p=ProductHelper.getById(award.getAward_gdsid());
    					if(p!=null)
    					{
    						if((p.getGdsmst_ifhavegds().longValue()!=0&&p.getGdsmst_ifhavegds().longValue()!=3)||p.getGdsmst_validflag().longValue()==2){
    							alistt1.add(award);
    						}
    						else
    						{
    							alistt.add(award);
    						}
    					}
    				}
    			}
    			else if(award.getAward_value().longValue()>=3000&&award.getAward_value().longValue()<=5000)
    			{
    				if(award.getAward_gdsid()!=null&&Tools.isNumber(award.getAward_gdsid()))
    				{
    					Product p=ProductHelper.getById(award.getAward_gdsid());
    					if(p!=null)
    					{
    						if((p.getGdsmst_ifhavegds().longValue()!=0&&p.getGdsmst_ifhavegds().longValue()!=3)||p.getGdsmst_validflag().longValue()==2){
    							alistth1.add(award);
    						}
    						else
    						{
    							alistth.add(award);
    						}
    					}
    				}
    				
    			}
    			else
    			{
    				if(award.getAward_gdsid()!=null&&Tools.isNumber(award.getAward_gdsid()))
    				{
    					Product p=ProductHelper.getById(award.getAward_gdsid());
    					if(p!=null)
    					{
    						if((p.getGdsmst_ifhavegds().longValue()!=0&&p.getGdsmst_ifhavegds().longValue()!=3)||p.getGdsmst_validflag().longValue()==2){
    							alistx1.add(award);
    						}
    						else
    						{
    							alistx.add(award);
    						}
    					}
    				}
    			}
    		}
    	}
    }


%>
<%
String mid="";
if(lUser!=null){
	mid=lUser.getId();
}
%>
<table id="__01" width="980"   border="0" cellpadding="0" cellspacing="0" style="margin:0px auto;">
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2013/jifen0826/jfhhl980_01.jpg" width="980" height="161" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2013/jifen0826/jfhhl980_02.jpg" width="980" height="264" alt=""></td>
	</tr>
	<tr>
		<td width="762" height="57" bgcolor="#FFD200">
			<input type="hidden"  id="hmid" value="<%=mid%>"/>
			
			<%  if(lUser==null)
				{%>
				   欢迎您进入积分兑换页面，请<a href="http://www.d1.com.cn/login.jsp" style="color:#f00;">登录</a>查看积分！
				<%}
				else
				{%>
				<%= Tools.substring(lUser.getMbrmst_uid(), 6) %>***您好，欢迎进入积分兑换页面，您当前的积分是：<span style="color: #EC5658;font-size: 16px;"><%=(int)(UserScoreHelper.getRealScore(lUser.getId())+0.5) %></span>
				<%}%>       
				
				</td>
	    <td width="218" bgcolor="#FFD200"><a href="/html/zt2012/20121203jfhds/memo.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2013/jifen0826/jfhhl980_03_2.jpg" width="184" height="44" alt="" border="0"></a></td>
	</tr>

<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2013/jifen0826/jfhhl980_04.jpg" width="980" height="60" alt=""></td>
	</tr>
	<tr>
		<td height="27" colspan="2" align="right" bgcolor="#FFF7D2"><font style="color:#f00;font-size:14px;">注：现金券有效期为一个月&nbsp;&nbsp;&nbsp;&nbsp;</font> </td>
	</tr>
	
	
	<tr>
	  <td colspan="2">
 
	  <table width="100%" height="0%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="50%" height="100%"><a href="#" attr="67" onclick="op(this);"><img src="http://images.d1.com.cn/zt2013/jifen0826/jfhhl980_06_01.jpg" width="491" height="196" alt=""></a></td>
          <td width="50%"><a href="#" attr="1359" onclick="op(this);"><img src="http://images.d1.com.cn/zt2013/jifen0826/jfhhl980_06_02.jpg" width="489" height="196" alt=""></a></td>
        </tr>
      </table></td>
  </tr>
	<tr><td colspan="2"><a name="a1"></a></td></tr>
	
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2013/jifen0826/jfhhl980_07.jpg" width="980" height="64" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" style="background:#FFF7D2">
		   	<%
		   	    if(alistx!=null&&alistx.size()>0)
		   	    {
		   	    	out.print("<ul class=\"newlist1\">");
		   	    	for(Award a:alistx)
		   	    	{
		   	    		if(a!=null)
		   	    		{
		   	    		    if(a.getAward_gdsid()!=null&&a.getAward_gdsid().length()>0)
		   	    		    {
		   	    		    	Product p=ProductHelper.getById(a.getAward_gdsid());
		   	    		    	if(p!=null)
		   	    		    	{%>
		   	    		    		  	<li>
		   	    		               <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank">
		   	    		                   <img src="<%= ProductHelper.getImageTo200(p) %>" width="230" height="230"/>		   	    		               </a>
		   	    		               <p style="position:absolute; +position:relative;margin-top:-22px;">
		   	    		                  <a href="#" attr="<%= a.getId() %>" onclick="addCart(this);">
		   	    		                      <img src="http://images.d1.com.cn/zt2013/jifen0826/dh2.png" />		   	    		                  </a>		   	    		               </p>
		   	    		               <p style=" margin-top:22px;+margin-top:0px; width:230px;font-size:14px; color:#000000">
		   	    		                   <span style="font-family:'方正大黑简体';display:block; font-size:26px; text-align:center; color:#e53b2e; height:50px; +height:40px; line-height:60px;+line-height:40px; font-weight:800">
		   	    		                   <%= a.getAward_value().longValue() %>积分+<%=  Tools.getFloat(a.getAward_price().floatValue(),1) %>元		   	    		                   </span>
		   	    		                   <%= Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),55) %>		   	    		               </p>
		   	    		          </li>
		   	    		    	   <%
		   	    		    	}
		   	    		    }
		   	    		}
		   	    	}
		   	    	if(alistx1!=null&&alistx1.size()>0)
		   	    	{
		   	    		for(Award a:alistx1)
			   	    	{
			   	    		if(a!=null)
			   	    		{
			   	    		    if(a.getAward_gdsid()!=null&&a.getAward_gdsid().length()>0)
			   	    		    {
			   	    		    	Product p=ProductHelper.getById(a.getAward_gdsid());
			   	    		    	if(p!=null)
			   	    		    	{%>
		   	    		
		   	    	
		   	    	<li>
		               <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank">
		                   <img src="<%= ProductHelper.getImageTo200(p) %>" width="230" height="230"/>		               </a>
		               <p style="position:absolute; +position:relative;margin-top:-22px;">
		                  <a href="javascript:void(0)" >
		                      <img src="http://images.d1.com.cn/zt2012/20121203jfhd/hw.png" />		                  </a>		               </p>
		               <p style=" margin-top:22px;+margin-top:0px; width:230px;font-size:14px; color:#595757">
		                   <span style="font-family:'方正大黑简体';display:block; font-size:26px; text-align:center; color:#e72756; height:50px; +height:40px; line-height:60px;+line-height:40px;">
		                   <%= a.getAward_value().longValue() %>积分+<%= Tools.getFloat(a.getAward_price().floatValue(),1) %>元		                   </span>
		                   <%= Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),55) %>		               </p>
		          </li>
		   	    	
		   	    	<%}
			   	    		    }
			   	    		}
			   	    	}
		   	    	}
		   	    	out.print("</ul>");
		   	    }
		   	
		   	%>        </td>
	</tr>
		<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2013/jifen0826/jfhhl980_09.jpg" width="980" height="62" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" style="background:#FFF7D2">
		   	<%
		   	    if(alistf!=null&&alistf.size()>0)
		   	    {
		   	    	out.print("<ul class=\"newlist1\">");
		   	    	for(Award a:alistf)
		   	    	{
		   	    		if(a!=null)
		   	    		{
		   	    		    if(a.getAward_gdsid()!=null&&a.getAward_gdsid().length()>0)
		   	    		    {
		   	    		    	Product p=ProductHelper.getById(a.getAward_gdsid());
		   	    		    	if(p!=null)
		   	    		    	{%>
		   	    		    		  	<li>
		   	    		               <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank">
		   	    		                   <img src="<%= ProductHelper.getImageTo200(p) %>" width="230" height="230"/>		   	    		               </a>
		   	    		               <p style="position:absolute; +position:relative;margin-top:-22px;">
		   	    		                  <a href="#" attr="<%= a.getId() %>" onclick="addCart(this);">
		   	    		                      <img src="http://images.d1.com.cn/zt2013/jifen0826/dh2.png" />		   	    		                  </a>		   	    		               </p>
		   	    		               <p style=" margin-top:22px;+margin-top:0px; width:230px;font-size:14px; color:#000000">
		   	    		                   <span style="font-family:'方正大黑简体';display:block; font-size:26px; text-align:center; color:#e53b2e; height:50px; +height:40px; line-height:60px;+line-height:40px; font-weight:800">
		   	    		                   <%= a.getAward_value().longValue() %>积分+<%= Tools.getFloat(a.getAward_price().floatValue(),1) %>元		   	    		                   </span>
		   	    		                   <%= Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),55) %>		   	    		               </p>
		   	    		          </li>
		   	    		    	   <%
		   	    		    	}
		   	    		    }
		   	    		}
		   	    	}
		   	    	if(alistf1!=null&&alistf1.size()>0)
		   	    	{
		   	    		for(Award a:alistf1)
			   	    	{
			   	    		if(a!=null)
			   	    		{
			   	    		    if(a.getAward_gdsid()!=null&&a.getAward_gdsid().length()>0)
			   	    		    {
			   	    		    	Product p=ProductHelper.getById(a.getAward_gdsid());
			   	    		    	if(p!=null)
			   	    		    	{%>
		   	    		
		   	    	
		   	    	<li>
		               <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank">
		                   <img src="<%= ProductHelper.getImageTo200(p) %>" width="230" height="230"/>		               </a>
		               <p style="position:absolute; +position:relative;margin-top:-22px;">
		                  <a href="javascript:void(0)" >
		                      <img src="http://images.d1.com.cn/zt2012/20121203jfhd/hw.png" />		                  </a>		               </p>
		               <p style=" margin-top:22px;+margin-top:0px; width:230px;font-size:14px; color:#595757">
		                   <span style="font-family:'方正大黑简体';display:block; font-size:26px; text-align:center; color:#e72756; height:50px; +height:40px; line-height:60px;+line-height:40px;">
		                   <%= a.getAward_value().longValue() %>积分+<%= (int)a.getAward_price().floatValue() %>元		                   </span>
		                   <%= Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),55) %>		               </p>
		          </li>
		   	    	
		   	    	<%}
			   	    		    }
			   	    		}
			   	    	}
		   	    	}
		   	    	out.print("</ul>");
		   	    }
		   	
		   	%>        </td>
	</tr>
		<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2013/jifen0826/jfhhl980_11.jpg" width="980" height="64" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" style="background:#FFF7D2">
		   	  	<%
		   	    if(alisth!=null&&alisth.size()>0)
		   	    {
		   	    	out.print("<ul class=\"newlist1\">");
		   	    	for(Award a:alisth)
		   	    	{
		   	    		if(a!=null)
		   	    		{
		   	    		    if(a.getAward_gdsid()!=null&&a.getAward_gdsid().length()>0)
		   	    		    {
		   	    		    	Product p=ProductHelper.getById(a.getAward_gdsid());
		   	    		    	if(p!=null)
		   	    		    	{%>
		   	    		    		  	<li>
		   	    		               <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank">
		   	    		                   <img src="<%= ProductHelper.getImageTo200(p) %>" width="230" height="230"/>		   	    		               </a>
		   	    		               <p style="position:absolute; +position:relative;margin-top:-22px;">
		   	    		                  <a href="#" attr="<%= a.getId() %>" onclick="addCart(this);">
		   	    		                      <img src="http://images.d1.com.cn/zt2013/jifen0826/dh2.png" />		   	    		                  </a>		   	    		               </p>
		   	    		               <p style=" margin-top:22px;+margin-top:0px; width:230px;font-size:14px; color:#000000">
		   	    		                   <span style="font-family:'方正大黑简体';display:block; font-size:26px; text-align:center; color:#e53b2e; height:50px; +height:40px; line-height:60px;+line-height:40px; font-weight:800">
		   	    		                   <%= a.getAward_value().longValue() %>积分+<%= Tools.getFloat(a.getAward_price().floatValue(),1) %>元		   	    		                   </span>
		   	    		                   <%= Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),55) %>		   	    		               </p>
		   	    		          </li>
		   	    		    	   <%
		   	    		    	}
		   	    		    }
		   	    		}
		   	    	}
		   	    	if(alisth1!=null&&alisth1.size()>0)
		   	    	{
		   	    		for(Award a:alisth1)
			   	    	{
			   	    		if(a!=null)
			   	    		{
			   	    		    if(a.getAward_gdsid()!=null&&a.getAward_gdsid().length()>0)
			   	    		    {
			   	    		    	Product p=ProductHelper.getById(a.getAward_gdsid());
			   	    		    	if(p!=null)
			   	    		    	{%>
		   	    		
		   	    	
		   	    	<li>
		               <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank">
		                   <img src="<%= ProductHelper.getImageTo200(p) %>" width="230" height="230"/>		               </a>
		               <p style="position:absolute; +position:relative;margin-top:-22px;">
		                  <a href="javascript:void(0)" >
		                      <img src="http://images.d1.com.cn/zt2012/20121203jfhd/hw.png" />		                  </a>		               </p>
		               <p style=" margin-top:22px;+margin-top:0px; width:230px;font-size:14px; color:#595757">
		                   <span style="font-family:'方正大黑简体';display:block; font-size:26x; text-align:center; color:#e72756; height:50px; +height:40px; line-height:60px;+line-height:40px;">
		                   <%= a.getAward_value().longValue() %>积分+<%= Tools.getFloat(a.getAward_price().floatValue(),1) %>元		                   </span>
		                   <%= Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),55) %>		               </p>
		          </li>
		   	    	
		   	    	<%}
			   	    		    }
			   	    		}
			   	    	}
		   	    	}
		   	    	out.print("</ul>");
		   	    }
		   	
		   	%>        </td>
	</tr>
<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2013/jifen0826/jfhhl980_13.jpg" width="980" height="65" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" style="background:#FFF7D2">
		  	<%
		   	    if(alistt!=null&&alistt.size()>0)
		   	    {
		   	    	out.print("<ul class=\"newlist1\">");
		   	    	for(Award a:alistt)
		   	    	{
		   	    		if(a!=null)
		   	    		{
		   	    		    if(a.getAward_gdsid()!=null&&a.getAward_gdsid().length()>0)
		   	    		    {
		   	    		    	Product p=ProductHelper.getById(a.getAward_gdsid());
		   	    		    	if(p!=null)
		   	    		    	{%>
		   	    		    		  	<li>
		   	    		               <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank">
		   	    		                   <img src="<%= ProductHelper.getImageTo200(p) %>" width="230" height="230"/>		   	    		               </a>
		   	    		               <p style="position:absolute; +position:relative;margin-top:-22px;">
		   	    		                  <a href="#" attr="<%= a.getId() %>" onclick="addCart(this);">
		   	    		                      <img src="http://images.d1.com.cn/zt2013/jifen0826/dh2.png" />		   	    		                  </a>		   	    		               </p>
		   	    		               <p style=" margin-top:22px;+margin-top:0px; width:230px;font-size:14px; color:#000000">
		   	    		                   <span style="font-family:'方正大黑简体';display:block; font-size:26px; text-align:center; color:#e53b2e; height:50px; +height:40px; line-height:60px;+line-height:40px; font-weight:800">
		   	    		                   <%= a.getAward_value().longValue() %>积分+<%= Tools.getFloat(a.getAward_price().floatValue(),1) %>元		   	    		                   </span>
		   	    		                   <%= Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),55) %>		   	    		               </p>
		   	    		          </li>
		   	    		    	   <%
		   	    		    	}
		   	    		    }
		   	    		}
		   	    	}
		   	    	if(alistt1!=null&&alistt1.size()>0)
		   	    	{
		   	    		for(Award a:alistt1)
			   	    	{
			   	    		if(a!=null)
			   	    		{
			   	    		    if(a.getAward_gdsid()!=null&&a.getAward_gdsid().length()>0)
			   	    		    {
			   	    		    	Product p=ProductHelper.getById(a.getAward_gdsid());
			   	    		    	if(p!=null)
			   	    		    	{%>
		   	    		
		   	    	
		   	    	<li>
		               <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank">
		                   <img src="<%= ProductHelper.getImageTo200(p) %>" width="230" height="230"/>		               </a>
		               <p style="position:absolute; +position:relative;margin-top:-22px;">
		                  <a href="javascript:void(0)" >
		                      <img src="http://images.d1.com.cn/zt2012/20121203jfhd/hw.png" />		                  </a>		               </p>
		               <p style=" margin-top:22px;+margin-top:0px; width:230px;font-size:14px; color:#595757">
		                   <span style="font-family:'方正大黑简体';display:block; font-size:26px; text-align:center; color:#e72756; height:50px; +height:40px; line-height:60px;+line-height:40px;">
		                   <%= a.getAward_value().longValue() %>积分+<%= Tools.getFloat(a.getAward_price().floatValue(),1) %>元		                   </span>
		                   <%= Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),55) %>		               </p>
		          </li>
		   	    	
		   	    	<%}
			   	    		    }
			   	    		}
			   	    	}
		   	    	}
		   	    	out.print("</ul>");
		   	    }
		   	
		   	%>        </td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2013/jifen0826/jfhhl980_15.jpg" width="980" height="63" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" style="background:#FFF7D2">
		   	  	<%
		   	    if(alistth!=null&&alistth.size()>0)
		   	    {
		   	    	out.print("<ul class=\"newlist1\">");
		   	    	for(Award a:alistth)
		   	    	{
		   	    		if(a!=null)
		   	    		{
		   	    		    if(a.getAward_gdsid()!=null&&a.getAward_gdsid().length()>0)
		   	    		    {
		   	    		    	Product p=ProductHelper.getById(a.getAward_gdsid());
		   	    		    	if(p!=null)
		   	    		    	{%>
		   	    		    		  	<li>
		   	    		               <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank">
		   	    		                   <img src="<%= ProductHelper.getImageTo200(p) %>" width="230" height="230"/>		   	    		               </a>
		   	    		               <p style="position:absolute; +position:relative;margin-top:-22px;">
		   	    		                  <a href="#" attr="<%= a.getId() %>" onclick="addCart(this);">
		   	    		                      <img src="http://images.d1.com.cn/zt2013/jifen0826/dh2.png" />		   	    		                  </a>		   	    		               </p>
		   	    		               <p style=" margin-top:22px;+margin-top:0px; width:230px;font-size:14px; color:#000000">
		   	    		                   <span style="font-family:'方正大黑简体';display:block; font-size:26px; text-align:center; color:#e53b2e; height:50px; +height:40px; line-height:60px;+line-height:40px; font-weight:800">
		   	    		                   <%= a.getAward_value().longValue() %>积分+<%= Tools.getFloat(a.getAward_price().floatValue(),1) %>元		   	    		                   </span>
		   	    		                   <%= Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),55) %>		   	    		               </p>
		   	    		          </li>
		   	    		    	   <%
		   	    		    	}
		   	    		    }
		   	    		}
		   	    	}
		   	    	if(alistth1!=null&&alistth1.size()>0)
		   	    	{
		   	    		for(Award a:alistth1)
			   	    	{
			   	    		if(a!=null)
			   	    		{
			   	    		    if(a.getAward_gdsid()!=null&&a.getAward_gdsid().length()>0)
			   	    		    {
			   	    		    	Product p=ProductHelper.getById(a.getAward_gdsid());
			   	    		    	if(p!=null)
			   	    		    	{%>
		   	    		
		   	    	
		   	    	<li>
		               <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank">
		                   <img src="<%= ProductHelper.getImageTo200(p) %>" width="230" height="230"/>		               </a>
		               <p style="position:absolute; +position:relative;margin-top:-22px;">
		                  <a href="javascript:void(0)" >
		                      <img src="http://images.d1.com.cn/zt2012/20121203jfhd/hw.png" />		                  </a>		               </p>
		               <p style=" margin-top:22px;+margin-top:0px; width:230px;font-size:14px; color:#595757">
		                   <span style="font-family:'方正大黑简体';display:block; font-size:26px; text-align:center; color:#e72756; height:50px; +height:40px; line-height:60px;+line-height:40px;">
		                   <%= a.getAward_value().longValue() %>积分+<%= Tools.getFloat(a.getAward_price().floatValue(),1) %>元		                   </span>
		                   <%= Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),55) %>		               </p>
		          </li>
		   	    	
		   	    	<%}
			   	    		    }
			   	    		}
			   	    	}
		   	    	}
		   	    	out.print("</ul>");
		   	    }
		   	
		   	%>        </td>
	</tr>
	
</table>
<!-- 尾部开始 -->
   <%@ include file="/inc/foot.jsp" %>
   <!-- 尾部结束 -->    
</body>
</html>