<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/ajax/flow/function.jsp" %>
<%
String act=request.getParameter("act");
StringBuilder sb=new StringBuilder();

String type=request.getParameter("type");
String rec_key=request.getParameter("rec_key");


String ischild=request.getParameter("is_child");
if("post".equals(request.getMethod().toLowerCase())&&"del".equals(act)){
	if(rec_key == null){
		sb.append("参数错误！");
	}
	else
	{
		String[] keyArr = rec_key.split("_");
		if(keyArr == null || keyArr.length!=3){
			sb.append("参数错误");
		}
		else
		{
			Cart cart = CartHelper.getById(keyArr[0]);
		
			if(cart == null){
				sb.append("该信息不存在！");
			}
			else
			{
				//有父类的都不许删除，不能删除
				if(Tools.longValue(cart.getHasFather() , 0) == 1){
					sb.append("不能删除！");
				}
				else
				{
					//主商品相关联的子类
					List<String> child_list = new ArrayList<String>();
					//获取子cart列表
					ArrayList<Cart> childCart = CartHelper.getCartItemsViaParentId(cart.getId());
					//记录所有的子节点，需要删除的。
					if(childCart!=null&&!childCart.isEmpty()){
						for(Cart c : childCart){
							String c_rec_key = c.getId()+"_0_"+(Tools.isNull(c.getSkuId())?"0":c.getSkuId());
							child_list.add(c_rec_key);
						}
					}
					//删除购物车
					ArrayList<Cart> deleteCartList = CartHelper.deleteCart(request,response,keyArr[0]);
				
					response.sendRedirect("/wap/flow.jsp");
				}
			}
		}
	}
}

else
{


if(type.equals("0")){
	sb.append("您确定要删除该赠品吗？");
	sb.append("<input type=\"submit\" value=\"确定删除\"/></form>");
	sb.append("<a href=\"/wap/flow.jsp\">返回购物车</a>");
}else{
		//需要判断要不要涉及到删除赠品的需求上。
		if(ischild.equals("1")){//主商品包含子类或者购物车中包含有赠品
			
			//检查删除主物品的时候是否需要删除关联的物品。
			
			if(rec_key == null){
				sb.append("参数不正确！");
			}
			String[] keyArr = rec_key.split("_");
			if(sb.toString().length()==0)
			{
				if(keyArr == null || keyArr.length!=3){
					sb.append("参数不正确！");
				}
				if(sb.toString().length()==0)
				{
					Cart c = CartHelper.getById(keyArr[0]);
			
					if(c == null){
						sb.append("该商品不存在！");
					}
					if(!sb.toString().equals("该商品不存在！"))
					{
						//赠品和套餐类物品，不能删除
						long types = Tools.longValue(c.getType());
						if(Tools.longValue(c.getHasFather() , 0) == 1 || types==0){
							sb.append("赠品不能删除！");
						}
						if(!sb.toString().equals("赠品不能删除！"))
						{
							//物品
							Product pro = ProductHelper.getById(c.getProductId());
					
							//查看该物品是否有子类
							if(Tools.longValue(c.getHasChild())==1){//有
								
								List<Cart> list = CartHelper.getCartItemsViaParentId(c.getId());
								if(list != null && !list.isEmpty()){
									for(Cart cart : list){
										Product product = ProductHelper.getById(cart.getProductId());
										if(product != null){
											sb.append("<br/><font>“</font>").append(product.getGdsmst_gdsname()).append("<font>”</font>");
										}
									}
								}
								//查看是否有全局赠品
								if(sb.length() > 0){
									sb.insert(0,"<font color='#CA0809'>您确定要删除该"+(types==-1?"组合":"商品")+"吗？以下物品也会随之删除！</font>");
									sb.append("<input type=\"submit\" value=\"确定删除\"/>");
									sb.append("<a href=\"/wap/flow.jsp\">返回购物车</a>");
								}else{
									sb.append("<font color='#CA0809'>您确定要删除该商品吗？以下物品也会随之删除！</font>");
									sb.append("<input type=\"submit\" value=\"确定删除\"/>");
									sb.append("<a href=\"/wap/flow.jsp\">返回购物车</a>");
								}
						}
					}
				}
			}
			}
			
		}else{
				//没有子类查看是否有全局的赠品
			sb.append("<font color='#CA0809'>您确定要删除该商品吗？</font>");
			sb.append("<br/><input type=\"submit\" value=\"确定删除\"/><br/>");
			sb.append("<a href=\"/wap/flow.jsp\">返回购物车</a>");
			}
	}
}
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-删除购物车中的商品</title>
<style type="text/css">
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,hr,pre,form,fieldset,input,textarea,p,label,blockquote,th,td,button,span{padding:0;margin:0;}
body{ background:#fff;color:#4b4b4b; padding-bottom:15px; line-height:21px;  padding-left:5px; }
img{border:none;}
ul{list-style:none; padding:0px;}
a {text-decoration:none;color:#4169E1}
a:hover {color:#aa2e44}
.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}

.top{ margin-top:3px; }
.top ul li{float:left;border-bottom:solid 1px #000;  }
.top ul li a{ color:#000;}
.top ul li a:hover{ color:#aa2e44;}
#search{ width:160px; height:19px; float:left}
#search1{ width:160px; height:19px; float:left}


.tip_box { height:auto; line-height:28px; border:1px solid #ffe2a6; background-color:#fffadc; color:#ffa00e; text-align:center; margin-bottom:15px;}

.sa0,.sa1,.sa2,.sa3,.sa4,.sa5,.sa6,.sa7,.sa8,.sa9,.sa10{width:100px;height:18px;background-image:url(http://images.d1.com.cn/images2011/commentimg/star.gif);background-repeat:no-repeat;overflow:hidden;  }
.sa0{background-position:0px 0px;}
.sa1{background-position:0px -119px;}/*半颗*/
.sa2{background-position:0px -21px;}
.sa3{background-position:0px -139px;}
.sa4{background-position:0px -40px;}
.sa5{background-position:0px -160px;}
.sa6{background-position:0px -58px;}
.sa7{background-position:0px -182px;}
.sa8{background-position:0px -77px;}
.sa9{background-position:0 -204px;}
.sa10{background-position:0px -97px;}
.old{ border:solid 1px #ccc; padding:2px;}
.current{ border:solid 2px #f00; padding:2px;}
</style>
</head>
<body>
<!-- 头部 -->
<%@ include file="inc/head.jsp" %>
<!-- 头部结束 -->
<form action="updateflow.jsp?act=del" method="post" id="delzh">
 <input id="rec_key" name="rec_key" type="hidden" value="<%= rec_key%>"/>
<%= sb.toString() %>

</form>
<div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/wap/user/index.jsp">我的优尚</a>&nbsp;&nbsp;
<a href="">购物车</a>&nbsp;&nbsp;<a href="/wap/user/favorite.jsp">我的收藏</a><br/>
<a href="mindex.jsp">首页</a>&nbsp;&nbsp;<a href="/wap/html/help.jsp">帮助</a> <br/>
	切换到<a href="http://www.d1.com.cn">电脑版</a>
	<br/>京ICP证030072号

    <br/>
    </div>
</body>
</html>

