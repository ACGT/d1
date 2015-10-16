<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%!
    private static String  getCZlog(String code,int length)
    {
		StringBuilder sb = new StringBuilder();
		if(!Tools.isMath(code) || length<=0) return "";
		ArrayList<Promotion> list=new ArrayList<Promotion>();
		list=PromotionHelper.getBrandListByCode(code,length);
		if(list!=null&&list.size()>0&&list.get(0)!=null)
		{
			Promotion p=list.get(0);
			StringBuilder map=new StringBuilder();
			ArrayList<PromotionImagePos> piplist=new ArrayList<PromotionImagePos>();
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("promotionId", p.getId()));
			List<BaseEntity> b_list = Tools.getManager(PromotionImagePos.class).getList(clist, null, 0, 100);
			if(b_list!=null){
				for(BaseEntity be:b_list){
					piplist.add((PromotionImagePos)be);
				}
			}
			
			sb.append("<div class=\"gdscsne_logo\"><img src=\""+p.getSplmst_picstr()+"\" width=\"980\" height=\"505\"  usemap=\"#pimg_1\"/><div class=\"clear\"></div>");
			map.append("<map name=\"pimg_1\" id=\"").append("pimg_1\">");
			sb.append("<div class=\"logofloat\" ><ul>");
			for(PromotionImagePos pip:piplist)
			{
				
				if(pip!=null)
				{
					
					int left=0;
					int top=0;
					//left=(((i-1)*980)+pip.getPos_x()-24+(Tools.parseInt(pip.getExt1())-pip.getPos_x())/2);
					left=pip.getPos_x()+10;
					if(left>400)
					{
						left=pip.getPos_x()-25;
					}
					top=pip.getPos_y()-35;
					int divtop=0;
					if(top+40>350)
					{
						divtop=350;
					}
					else
						divtop=top+40;
					
						
					map.append("<area shape=\"rect\" coords=\"").append(pip.getPos_x()+",").append(pip.getPos_y()+",").append(pip.getExt1()+",").append(pip.getExt2()).append("\"").append(" onmouseover=\"mdm_over('"+ pip.getId()+"')\" onmouseout=\"mdm_out('"+pip.getId()+"')\""); 
					Product product=ProductHelper.getById(pip.getProductId());
					if(product!=null)
					{
						sb.append("<li><a href=\"/product/"+pip.getProductId()+"\" target=\"_blank\">"+Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),44)+"</a>");
						sb.append("<br/><font class=\"font1\">￥"+Tools.getRoundPrice(product.getGdsmst_memberprice().floatValue())+"</font>&nbsp;&nbsp;<font class=\"font2\"><strike>￥"+Tools.getRoundPrice(product.getGdsmst_saleprice().floatValue())+"</strike></font>");
					    sb.append("</li>");
						map.append("href=\"").append("/product/"+product.getId()).append("\" target=\"_blank\"");
					}
					map.append(">");
					
				}
			}
			sb.append("</ul></div>");
			map.append("</map>");
			
			sb.append(map.toString());
		}
		return sb.toString();
		
}


private String getimglist(String code,int length)
{
	StringBuilder sb = new StringBuilder();
	if(!Tools.isMath(code) || length<=0) return "";
	ArrayList<Promotion> list=new ArrayList<Promotion>();
	list=PromotionHelper.getBrandListByCode(code,length);
	if(list!=null&&list.size()>0)
	{
		//sb.append("<UL id=\"sec_list\">");
		int i=0;
		for(Promotion p:list)
		{
			
			if(p!=null)
			{
				
				StringBuilder map=new StringBuilder();
				i++;
				ArrayList<PromotionImagePos> piplist=new ArrayList<PromotionImagePos>();
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("promotionId", p.getId()));
				List<BaseEntity> b_list = Tools.getManager(PromotionImagePos.class).getList(clist, null, 0, 100);
				if(b_list!=null){
					for(BaseEntity be:b_list){
						piplist.add((PromotionImagePos)be);
					}
				}
				if(i%2==0)
				{
					sb.append("<li style=\"margin-right:0px;\">");
				}
				else
				{
					sb.append("<li>");
				}
				sb.append("<img src=\""+p.getSplmst_picstr()+"\" width=\"480\" height=\"413\"  usemap=\"#img_"+i+"\"/>");
				map.append("<map name=\"img_").append(i).append("\" id=\"").append("img_").append(i).append("\">");
				sb.append("<div>");
				for(PromotionImagePos pip:piplist)
				{
					
					if(pip!=null)
					{
						int left=0;
						int top=0;
						//left=(((i-1)*980)+pip.getPos_x()-24+(Tools.parseInt(pip.getExt1())-pip.getPos_x())/2);
						left=pip.getPos_x()+10;
						if(left>400)
						{
							left=pip.getPos_x()-25;
						}
						top=pip.getPos_y()-35;
						int divtop=0;
						if(top+40>350)
						{
							divtop=350;
						}
						else
							divtop=top+40;
						
							
						//sb.append("<a href=\"javascript:void(0)\" onmouseover=\"mdm_over('"+pip.getId()+"')\" onmouseout=\"mdm_out('"+pip.getId()+"')\"><img src=\"http://images.d1.com.cn/Index/MaoDian.gif\" style=\" position:absolute; left:"+ left+"px; top:"+top+"px; z-index:1400;\" width=\"55\" height=\"79\" /></a>");
						
						map.append("<area shape=\"rect\" coords=\"").append(pip.getPos_x()+",").append(pip.getPos_y()+",").append(pip.getExt1()+",").append(pip.getExt2()).append("\"").append(" onmouseover=\"mdm_over('"+ pip.getId()+"')\" onmouseout=\"mdm_out('"+pip.getId()+"')\""); 
						Product product=ProductHelper.getById(pip.getProductId());
						if(product!=null)
						{
							 sb.append("<a href=\"/product/"+pip.getProductId()+"\" target=\"_blank\">"+Tools.clearHTML(product.getGdsmst_gdsname())+"</a>&nbsp;&nbsp;");
							 sb.append("<font class=\"font1\">￥"+Tools.getRoundPrice(product.getGdsmst_memberprice().floatValue())+"</font>&nbsp;&nbsp;<font class=\"font2\"><strike>￥"+Tools.getRoundPrice(product.getGdsmst_saleprice().floatValue())+"</strike></font><br/>");
							 map.append("href=\"").append("/product/"+product.getId()).append("\" target=\"_blank\"");
						}
						map.append(">");
						
							
					}
				}
				sb.append("</div>");
				map.append("</map>");
				sb.append(map.toString());
				sb.append("</li>");
				
			}
		}
		return sb.toString();
	}
	
	return "";
			
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>D1优尚网-场景页</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/index2012h.css")%>" rel="stylesheet" type="text/css" media="screen" />

<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />

<style type="text/css">
.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}
    a img{ border:none;}
    .gdscene_center{ margin:0px auto; background:#fff;}
    .gdscene_top{ margin:0px auto; background-image:url(http://images.d1.com.cn/images2012/index2012/czdhbg.gif);height:37px;}
    #dh{ margin:0px auto; width:950px; padding-left:30px;background-image:url(http://images.d1.com.cn/images2012/index2012/zhbg.gif); height:37px; overflow:hidden; }
    #dh a{ color:#000000; margin-right:10px; margin-left:10px; font-size:12px; line-height:37px; text-decoration:none;}
    #dh a:hover{ color:#a22d48;}
    #dh img{ line-height:37px;}
    .gdscsne_logo{ margin:0px auto; width:980px;}
    .logofloat {width:970px; height:70px;  background:none;background-color: #fff;position:absolute; margin:0px auto;  margin-top:-85px; margin-left:5px;  -moz-border-radius: 10px; -webkit-border-radius: 10px;  border-radius: 10px;}
    .logofloat ul{ width:920px; height:70px; margin:0px auto; text-align:center; overflow:hidden; padding-left:20px;}
    .logofloat ul li{ width:150px; overflow:hidden; height:62px; padding-top:8px;line-height:18px; font-size:13px;  float:left; margin-right:50px; text-align:left;}
    font{ font-family:'微软雅黑'; font-size:12px; font-weight:bold; color:#4e4e4e;}
    .font1{ color:#be0000; }
    .font2{ color:#4e4e4e; }
    .imglist{ width:980px; margin:0px auto; margin-top:10px;}
    .imglist ul{ width:980px;  overflow:hidden; margin:0px auto;  list-style:none; padding:0px;}
    .imglist ul li{ width:480px; margin-right:20px; float:left;}
    .imglist ul li div{ width:445px; height:95px; padding-left:15px; padding-top:10px; line-height:22px;  background:none;background-color: #fff;position:absolute; _position:relatice;  margin-top:-120px; margin-left:10px;filter: alpha(opacity=80);-moz-opacity: 0.8;opacity: 0.8;  -moz-border-radius: 10px; -webkit-border-radius: 10px;  border-radius: 10px;}
    .gdtj{width:980px; overflow:hidden; margin:0px auto;  margin-top:10px;  }
    .list{ margin:0px auto; width:980px; overflow:hidden;background-color:#CCCCCC; margin:0px; padding-bottom:15px; }
    .list ul{ width:950px; margin:0px auto; overflow:hidden; list-style:none; padding:0px;  }
    .list ul li{ width:230px; background:#fff; float:left; margin-right:10px; margin-top:10px; padding-top:10px; padding-bottom:10px;}
    .list ul li div{ width:200px; margin:0px auto;}
    
</style>
</head>
<body>
<%@include file="/inc/head.jsp" %>
   <div class="gdscene_center">
       <div class="gdscene_top">
            <div id="dh">
              <a href="" target="_blank">首页</a>><a href="">场景搭配</a>><a href="/html/cosmetic/">化妆品</a>><a href="">成本vcnb</a>
             </div>   
         </div>
         <%= getCZlog("2947",2) %>
      
       <div class="imglist"> 
          <ul>
             <%= getimglist("2948",10) %>
          </ul>
       </div>
  
       
       
       
       <div class="clear"></div>
       <div class="gdtj">
          <div class="list">
          <img src="http://images.d1.com.cn/images2012/index2012/gdtj2012.jpg"/>
           <% request.setAttribute("code","7601");
               request.setAttribute("length","100");%>
          <jsp:include   page= "/gdscene/public.jsp"   />
          </div>
       </div>
   </div>
  
   <div class="clear"></div>
   <!-- 底部 -->
   <%@ include file="/inc/foot.jsp" %>
   <!-- 底部结束 -->
   
</body>
</html>