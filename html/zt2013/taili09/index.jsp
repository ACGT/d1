<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!

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
<title>D1-优尚网，9月台历0利团</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">
.txtput {
 width:100px; height:21px;
	border: 1px solid #ff1e9a;
	background-color: #ffc5fd;
}

.center{ width:980px; margin:0px auto; background-color:#f5f5f5; padding-top:10px;}
ul{ padding:0px; margin:0px; list-style:none;}
.wul{ overflow:hidden;}
.wul li{ width:326px; border-right:dashed 1px #c4c4c4; float:left; margin-bottom:25px; height:400px; overflow:hidden;}
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
<script type="text/javascript">
function getcard(obj){
	var cardno=$('#cardno').val();
	$.ajax({
		type: "get",
		dataType: "json",
		url: 'gettaili.jsp',
		cache: false,
		data: {cardno:cardno},
		error: function(XmlHttpRequest){
			$.alert("激活台历出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			$.alert(json.message);
			if(json.success){
				window.location='/html/zt2013/taili09/index.jsp';
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
</script>
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
	<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/taili09/taili09_01.jpg" width="980" height="158" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/taili09/taili09_02.jpg" width="980" height="203" alt=""></td>
	</tr>
	<tr>
		<td height="76" background="http://images.d1.com.cn/zt2013/taili09/taili09_03.jpg"><table width="100%" height="70" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="19%" height="30">&nbsp;</td>
            <td width="11%"><input type="text" name="cardno" id="cardno" class="txtput"></td>
            <td width="10%"><input type="image" name="imageField" onClick="getcard(this);" src="http://images.d1.com.cn/zt2013/taili09/anniu.gif" style="margin-top:2px;"></td>
            <td width="60%">&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
	</tr>
	<tr>
		<td>
	
	<!--<img src="http://images.d1.com.cn/images2013/0yt_01_2.jpg" border="0" style="padding-bottom:10px;"/> -->
	<%
	     ArrayList<PromotionProduct> list=getPProductByCode("8778");
	    
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
	    			 float tprice=p.getGdsmst_memberprice().floatValue() ;
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
					    		
	
					    		 String dxcode = Tools.getCookie(request,"rcmdusr_rcmid");
                                 if(!Tools.isNull(dxcode)){
                               
					    		  ProductExpPrice rcmdusr=(ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_rcmid", new Long(dxcode));
								  //System.out.print(rcmdusr.getRcmdusr_startdate().getTime());  
								  if(rcmdusr!=null 
								    	&& System.currentTimeMillis()>rcmdusr.getRcmdusr_startdate().getTime() 
								    	&& System.currentTimeMillis()<rcmdusr.getRcmdusr_enddate().getTime()
								    	){
								    	ProductExpPriceItem rcmdgds=(ProductExpPriceItem)ProductExpPriceHelper.getExpPrice(p.getId(), dxcode);
								    	if(rcmdgds!=null){tprice=rcmdgds.getRcmdgds_memberprice();
								    	}
					                    }
                                 }
					    		 %>
					    		<div><a href="/product/<%= pp.getSpgdsrcm_gdsid() %>" target="_blank"  title="<%= Tools.clearHTML(pp.getSpgdsrcm_gdsname()) %>">
					    		<img src="<%= ProductHelper.getImageTo400(p)%>" width="250" height="250" style=" margin-top:12px; margin-bottom:12px;"/></a>
					    		<div class="pricedisplay">
					    		<table class="newtable">
			 				  <tr><td colspan="2" height="55"><%if (p.getGdsmst_validflag().longValue()!=1 || (p.getGdsmst_virtualstock()<=0&&
						  p.getGdsmst_stocklinkty()!=null&&p.getGdsmst_stocklinkty().longValue()!=0&&p.getGdsmst_stocklinkty().longValue()!=3)){ %><img src="http://images.d1.com.cn/zt2013/taili09/but02.gif"/>
				  <%}else{ %><a  href="###" attr="<%=p.getId() %>" onclick="$.inCart(this);" class="posa"><img src="http://images.d1.com.cn/zt2013/taili09/but01.gif" width="281" height="55" /></a> <%} %><span><font>￥</font><%= tprice %></span></td>
				 </tr>
				 <tr>
				     <td class="td1">市场价：￥<%=p.getGdsmst_saleprice().floatValue() %>
				     &nbsp;&nbsp;&nbsp;&nbsp;折&nbsp;扣：<%= Tools.getFloat((pp.getSpgdsrcm_tjprice().floatValue()/p.getGdsmst_saleprice

().floatValue())*10,1) %>折</td><td></td>
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
	</td>
	</tr>
</table>
	<!-- 中间内容结束 -->
	
	
	<!-- 尾部开始 -->
	<%@include file="/inc/foot.jsp" %>
	<!-- 尾部结束 -->
   </div>

</body>
</html>
