<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
    private ArrayList<PromotionProduct> getTuanlist(String code)
	{
	    if(Tools.isNull(code)||!Tools.isNumber(code)){ return null;}
		StringBuilder sb=new StringBuilder();
		List<PromotionProduct> list=new ArrayList<PromotionProduct>();
		ArrayList<PromotionProduct> rlist=new ArrayList<PromotionProduct>();
		list=getPProductByCode(code);
		if(list!=null&&list.size()>0)
		{
			for(PromotionProduct pp:list)
			{
				if(pp.getSpgdsrcm_gdsid()!=null&&pp.getSpgdsrcm_gdsid().length()>0&&pp.getSpgdsrcm_enddate()!=null&&pp.getSpgdsrcm_begindate()!=null)
				{
			        Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
			        if(product!=null)
			        {
			        	 long discountendDate = Tools.dateValue(pp.getSpgdsrcm_enddate());//应该是秒杀结束的时间。
			        	 long begindate=Tools.dateValue(pp.getSpgdsrcm_begindate());
			        	 long nowtime=System.currentTimeMillis();
			        	if(discountendDate>=nowtime&&begindate<=nowtime)
			        	{
			        		rlist.add(pp);
			        	}
			        }
			        
				}
			}
		}
		return rlist;
	}
private static ArrayList<PromotionProduct> getPProductByCode(String code){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.asc("spgdsrcm_seq"));
			olist.add(Order.asc("spgdsrcm_gdsid"));
			List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 100);
			
			if(list!=null){
				for(BaseEntity be:list){
					PromotionProduct pp = (PromotionProduct)be;
					Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
					if(product == null) continue;
					rlist.add(pp);
				}
			}
		
	//System.out.println("rlist:"+rlist.size());
	return rlist ;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>D1-优尚网，优尚团，每日超值团购不断更新！</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">
.center{ width:980px; margin:0px auto; background-color:#f5f5f5; padding-top:10px;}
ul{ padding:0px; margin:0px; list-style:none;}
.wul{ overflow:hidden;}
.wul li{ width:326px; border-right:dashed 1px #c4c4c4; float:left; margin-bottom:25px; height:430px; overflow:hidden;}
.wul .oli{ width:324px; border:none;  float:left; padding-bottom:5px;}
.wul li div{ border:solid 1px #c4c4c4; width:278px; margin:0px auto; text-align:center; background-color:#fff; z-index:80;}
img{ border:none;}
.wul .pricedisplay{ background-color:#f5f5f5;border:none;}
.nul{ padding-top:3px;}
.newtable{ width:278px; font-size:12px; color:#000;}
.wul li a { color:#626262; font-size:15px; font-weight:bold; font-family:'微软雅黑'; text-decoration:none; line-height:18px;}
.wul li a:hover{ text-decoration:underline;} 
.newtable td em{ text-decoration:none; color:#ce0000; font-weight:bold;}
.newtable td img{vertical-align:text-bottom; }
.posa{ margin-left:-26px;  margin-left:-23px\0; _position:absolute ; _margin-left:-154px;  +position:absolute ; +margin-left:-152px; }
.posa img{ display: inline-block;}
.td1{text-align:left; line-height:18px; padding-left:3px; }
.td2{ text-align:right; padding-right:2px;}
.newtable td span{ font-size:45px; line-height:55px; color:#fff;  position:absolute;  font-family:'微软雅黑'; margin-left:-270px; _margin-left:-140px; +margin-left:-140px; margin-top:-5px;}
.newtable td span font{  font-size:35px;}
.wul li .tdiv{  width:280px; margin:0px auto; text-align:left; border:none; background-color:#f5f5f5; padding-top:3px; }
table .font{ color:#ce0000; font-weight:bold; font-size:19px; font-family:'微软雅黑'}
</style>
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
	        html = "<img src=\"http://images.d1.com.cn/images2012/timer.jpg\"/> 剩余时间：";
	        if(the_D!=0) html += '<em>'+the_D+"</em>天";
	        if(the_D!=0 || the_H!=0) html += '<em>'+(the_H)+"</em>小时";
	        if(the_D!=0 || the_H!=0 || the_M!=0) html += '<em>'+the_M+"</em>分";
	        html += '<em>'+the_S+"</em>秒";
	        $getid(objid).innerHTML = html;
	        the_s[the_s_index]--;
	    }else{
	        $getid(objid).innerHTML = "已结束";
	    }
	}
	
	function addCart(obj){
		$.inCart(obj,{ajaxUrl:'/ajax/flow/listTuanInCartNew.jsp'});
	}
</script>
</head>
<body>
   <div id="wrapper">
	<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
	<div class="clear"></div>
	<!-- 中间内容 -->
	<div class="center"	>
	<!--<img src="http://images.d1.com.cn/images2013/0yt_01_2.jpg" border="0" style="padding-bottom:10px;"/> -->
	<%
	     ArrayList<PromotionProduct> list=getTuanlist("7523");
	    
	     if(list!=null&&list.size()>0)
	     {
             StringBuilder sb=new StringBuilder();
	    	 int count=0;
	    	 out.print(" <ul class=\"wul\">");
	    	 for(int i=0;i<list.size();i++)
	    	 {
	    		 count++;
	    		 PromotionProduct pp=list.get(i);
	    		 if(pp!=null)
	    		 {
	    			 SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	    			 Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
	    			 float tprice=0f;
	    					 if(p!=null)
	    					 {
					    		 if(count%3!=0)
					    		 {
					    			 out.print("<li>");
					    		 }
					    		 else
					    		 {
					    			 out.print("<li class=\"oli\">");
					    		 }
					    		 tprice=Tools.getFloat(pp.getSpgdsrcm_tjprice().floatValue(),1);
					    		 %>
					    		<div><a href="/product/<%= pp.getSpgdsrcm_gdsid() %>" target="_blank"  title="<%= Tools.clearHTML(pp.getSpgdsrcm_gdsname()) %>">
					    		<img src="<%= ProductHelper.getImageTo400(p)%>" width="250" height="250" style=" margin-top:12px; margin-bottom:12px;"/></a>
					    		<div class="pricedisplay">
					    		<table class="newtable">
			     <tr><td colspan="2" height="30" id="tjjs_<%=i%>"><img src="http://images.d1.com.cn/images2012/timer.jpg"/>&nbsp;剩余时间:<em>00</em>天<em>00</em>小时<em>00</em>分<em>00</em>秒
			      <%
						       
						       String	nowtime= DateFormat.format( new Date());
						       String endtime= DateFormat.format(pp.getSpgdsrcm_enddate());
						    %>
						     <SCRIPT language="javascript">
                             var startDate= new Date("<%=nowtime%>");
                             var endDate= new Date("<%=endtime%>");
                             the_s[<%=i%>]=(endDate.getTime()-startDate.getTime())/1000;
                             setInterval("view_time(<%=i%>,'tjjs_<%=i%>')",1000);
                             </SCRIPT></td></tr>
				  <tr><td colspan="2" height="55"><%if (p.getGdsmst_validflag().longValue()!=1 || (p.getGdsmst_virtualstock()<=0&&
						  p.getGdsmst_stocklinkty()!=null&&p.getGdsmst_stocklinkty().longValue()!=0&&p.getGdsmst_stocklinkty().longValue()!=3)){ %><img src="http://images.d1.com.cn/images2013/tuan/buyend.png"/>
				  <%}else{ %><a  href="###" attr="<%=pp.getId() %>" onclick="addCart(this);" class="posa"><img src="http://images.d1.com.cn/images2012/tuanbutton.gif" width="281" height="55" /></a> <%} %><span><font>￥</font><%= tprice %></span></td>
				 </tr>
				 <tr>
				     <td class="td1">市场价：￥<%=p.getGdsmst_saleprice().floatValue() %>
				     <br/>折&nbsp;扣：<%= Tools.getFloat((pp.getSpgdsrcm_tjprice().floatValue()/p.getGdsmst_saleprice

().floatValue())*10,1) %>折</td><td><img src="http://images.d1.com.cn/images2012/person.jpg" style=" vertical-align:baseline"/><font class="font"><%= pp.getSpgdsrcm_tghit() %></font>人购买</td>
				 </tr>
			  </table>
					    	    </div>
					    	    </div>
					    	   <div class="tdiv">
					    	   <a href="/product/<%= pp.getSpgdsrcm_gdsid() %>" target="_blank" title="<%= Tools.clearHTML(pp.getSpgdsrcm_gdsname()) %>"  ><%= Tools.substring(pp.getSpgdsrcm_gdsname(),58)+"..." %></a>
					    	   </div>	  
					    	 
					      </li>
					      
				    		<% }
	    		 }
	    	 }
	    	%>
	    	</ul>
	     <%}
	    
	%>
	</div>
	
	<div class="clear"></div>
	
	<!-- 中间内容结束 -->
	
	
	<!-- 尾部开始 -->
	<%@include file="/inc/foot.jsp" %>
	<!-- 尾部结束 -->
   </div>

</body>
</html>
