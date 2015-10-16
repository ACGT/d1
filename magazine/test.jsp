<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%!


//获取优尚推新
private String getUSTX(String code,int length)
{
	StringBuilder sb = new StringBuilder();
	if(!Tools.isMath(code) || length<=0) return "";
	ArrayList<Promotion> list=new ArrayList<Promotion>();
	list=PromotionHelper.getBrandListByCode(code,length);
	if(list!=null&&list.size()>0)
	{
		sb.append("<UL id=\"sec_list\">");
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
				sb.append("<LI><IMG alt=\"\" src=\""+p.getSplmst_picstr()+"\" width=\"980\" height=\"500\"  usemap=\"#pimg_"+i+"\"/>");
				map.append("<map name=\"pimg_").append(i).append("\" id=\"").append("pimg_").append(i).append("\">");
				for(PromotionImagePos pip:piplist)
				{
					
					if(pip!=null)
					{
						int left=0;
						int top=0;
						left=(((i-1)*980)+pip.getPos_x()-24+(Tools.parseInt(pip.getExt1())-pip.getPos_x())/2);
						top=pip.getPos_y()-35;
						int divtop=0;
						if(top+40>350)
						{
							divtop=350;
						}
						else
							divtop=top+40;
						
							
						//sb.append("<a href=\"javascript:void(0)\" onmouseover=\"mdm_over('"+pip.getId()+"')\" onmouseout=\"mdm_out('"+pip.getId()+"')\"><img src=\"http://images.d1.com.cn/Index/MaoDian.gif\" style=\" position:absolute; left:"+ left+"px; top:"+top+"px; z-index:1400;\" width=\"55\" height=\"79\" /></a>");
						sb.append("<div id=\"div_"+pip.getId()+"\" style=\"left:"+(left+25)+"px; top:"+divtop+"px; \" onmouseover=\"mdm_over('"+ pip.getId()+"')\" onmouseout=\"mdm_out('"+pip.getId()+"')\" >");
						map.append("<area shape=\"rect\" coords=\"").append(pip.getPos_x()+",").append(pip.getPos_y()+",").append(pip.getExt1()+",").append(pip.getExt2()).append("\"").append(" onmouseover=\"mdm_over('"+ pip.getId()+"')\" onmouseout=\"mdm_out('"+pip.getId()+"')\""); 
						Product product=ProductHelper.getById(pip.getProductId());
						if(product!=null)
						{
							sb.append("<a href=\"http://www.d1.com.cn/product/"+pip.getProductId()+"\" target=\"_blank\">"+Tools.clearHTML(product.getGdsmst_gdsname())+"</a><br/>");
							
							sb.append("<b>￥"+product.getGdsmst_memberprice().longValue()+"</b><br/><strike>￥"+product.getGdsmst_saleprice().longValue()+"</strike><br/><hr style=\" border:solid 1px #fff;\" />");
						    map.append("href=\"").append("http://www.d1.com.cn/product/"+product.getId()).append("\" target=\"_blank\"");
						}
						map.append(">");
						sb.append("</div>");
							
					}
				}
				sb.append("</LI>");
				sb.append(map.toString());
			}
		}
		
		
		sb.append("</UL>");
		return sb.toString();
	}
	
	return "";
			
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>D1优尚网-时尚网上购物商城,在线销售化妆品、名表、饰品、女装、男装等个人扮靓物品</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/indexnew.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript">
		var li_num;
		var currentPage = 1;
		var show_num = 1;
		var divWidth = 980;
		var totalPage;
		$(document).ready(function(e) {
			li_num = $("#sec_list li").length;
			totalPage = Math.ceil(li_num/show_num)
			$("#arrow_r").click(next);
			$("#arrow_l").click(prev);
        });
		
		function prev(){
			
			if(currentPage >=1){
				if(currentPage==1)
				{
				 currentPage=$("#sec_list li").length;
				}
				else
					{
				currentPage = currentPage - 1;
					}
				$("#sec_list").animate({left:-divWidth*(currentPage - 1)},"slow");
				//$("#arrow_r").attr("class","next_yes");
				
			}
			
			
		}
		
		function next(){	
			
			if(currentPage <= totalPage){
				if(currentPage==$("#sec_list li").length)
				{
				 currentPage=1;
				}
				else
					{
				currentPage = currentPage +1;
					}
				
				$("#sec_list").animate({left:-divWidth*(currentPage - 1)},"slow");
				//$("#arrow_l").attr("class","prev_yes");
			}
			
		}
		setInterval("next()",5000);
	
	</script>
</head>
<body>
<div id="wrapper">
  
   <!-- page开始 -->
	<div id="page">
	
	
        
        <!-- 时尚推新 -->
         <div class="blayout sstx">
         <h2 style=" border-bottom:none;"><img src="http://images.d1.com.cn/Index/ShiShangTuiXin.jpg" width="980" height="42"></img></h2>
         <br/>
   
         
         
         
         <div class="sec_box secwill">
                
                <div class="scroll_2012">
                   <div class="secWill_con">
                        <%= getUSTX("2780",100) %>
                    </div>
                   
					
					<DIV class=triggers>
				<A  id="arrow_l" class="prev1" href="javascript:void(0);" >
				<SPAN><img id="tprev1" src="http://images.d1.com.cn/Index/l_red1.jpg"  onmouseover="pn_over(this,this.src)" onmouseout="pn_out(this,this.src)" width="60" height="60"/></SPAN></A> 
				<A  id="arrow_r" class="next1" href="javascript:void(0);">
				<SPAN><img src="http://images.d1.com.cn/Index/r_red1.jpg"  onmouseover="pn_over(this,this.src)" onmouseout="pn_out(this,this.src)" width="60" height="60"/></SPAN></A>			            </DIV>
					</div>
                </div>
            </div>
        
        
        <!-- 时尚推新结束 -->
        
        <div class="clear"></div>
        
        
      
	   
   
</div>
</div>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/indexnew/retime.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script type="text/javascript">

function mdm_over(obj)
{
    document.getElementById("div_"+obj).style.display="block";
}


 function mdm_out(obj)
{
    document.getElementById("div_"+obj).style.display="none";
	
}
 function pn_over(obj,url)
 {
    obj.src=url.substring(0,url.indexOf(".jpg")-1)+ ".jpg";
   
 }


  function pn_out(obj,url)
 {
	  obj.src=url.substring(0,url.indexOf(".jpg"))+ "1.jpg";
	  
 }
 



	
</script>
</body>
</html>