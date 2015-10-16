<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>

<%!



//获取商品
private String getProduct(String gdsid,int w,String price1,int flags,String tf)
{
	StringBuilder sb=new StringBuilder();
  if(gdsid.length()<=0) return "";
  int width=0;
  float price=0;
  width=w;
  price=Tools.parseFloat(price1);
  int flag=1;
  flag=flags;
  Product product=ProductHelper.getById(gdsid);
  if(product!=null)
  {
	 //获取背景图片
		String bg="";
		String namec="";
		String mpc="";
		String sc="";
		String bgc="";
		String border="#545454";
		String tbimg="";
	
		if(flag==1||flag==2||flag==3||flag==4||flag==11)
		{
			namec=" color:#7f7f7f";
			mpc=" color:#b80024";
			sc=" color:#333";
			bgc="#d8d8d8";
			border="#545454";
			if(width<=784){
			   tbimg="http://images.d1.com.cn/images2012/index2012/JULY/fl1.png";
			}
			else
			{
				 tbimg="http://images.d1.com.cn/images2012/index2012/JULY/fr1.png";
			}
		}

		if(flag==8||flag==9||flag==10)
		{
			namec=" color:#858178";
			mpc=" color:#b80024";
			sc=" color:#ca0000";
			bgc="#dbd5c7";
			border="#a99c94";
			if(width<=784){
				   tbimg="http://images.d1.com.cn/images2012/index2012/JULY/sl1.png";
				}
				else
				{
					 tbimg="http://images.d1.com.cn/images2012/index2012/JULY/sr1.png";
				}
		}
		if(flag==5||flag==6||flag==7)
		{
			namec=" color:#cf85a8";
			mpc=" color:#fff";
			sc=" color:#fff";
			bgc="#b2366c";
			border="#722245";
			if(width<=784){
				   tbimg="http://images.d1.com.cn/images2012/index2012/JULY/al1.png";
				}
				else
				{
					 tbimg="http://images.d1.com.cn/images2012/index2012/JULY/ar1.png";
				}
		}
	    String imgurl="";
		 ArrayList<GdsCutImg> gcilist=getByGdsid(product.getId());
		 if(gcilist!=null&&gcilist.size()>0)
		 {
			 if(gcilist.get(0)!=null&&gcilist.get(0).getGdscutimg_160()!=null&&gcilist.get(0).getGdscutimg_160().length()>0)
			 {
				 imgurl="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_160();
			 }
			 else
			 {
				 imgurl=ProductHelper.getImageTo160(product);
			 }
		 }
		 else
		 {
			 imgurl=ProductHelper.getImageTo160(product);
		 }
		 String floats="";
		 if(width>784)
		 {
			 floats="left";
		 }
		 else
		 {
			 floats="right";
		 }
		 
		 long endTime = Tools.dateValue(product.getGdsmst_discountenddate());
		 long currentTime = System.currentTimeMillis();
		  String tbtop="";
		  if(tf.equals("1"))
		  {
			  tbtop="60px;";
		  }
		  else if(tf.equals("2"))
		  {
			  tbtop="130px;";
		  }
		  else
		  {
			  tbtop="210px;";
		  }
		
		  if(width<=784){
         sb.append("<img src=\""+tbimg+"\" style=\"position:absolute; top:"+tbtop+"\"/>");
		  } 
		  sb.append("<span style=\"display:block;padding-bottom:5px; width:176px; overflow:hidden;border:solid 2px "+border+"; background:"+bgc+";float:"+ floats+"\">");
		  sb.append("<table style=\" width:176px; overflow:hidden;\" cellspcing=\"0\" cellpadding=\"0\">");
	     if(width>784){
	    	 sb.append("<tr><td width=\"8\"></td><td height=\"8\"></td><td width=\"8\"></td></tr>");
	    	 sb.append("<tr><td></td><td>");
			 sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id="+product.getId()+"&sp_id=1212236301\" target=\"_blank\" ><img src=\""+ imgurl +"\"  style=\"background:#fff;\"/></a></td>");
			 sb.append("<td></td></tr>");
			 sb.append("<tr><td coslpan=\"3\" height=\"3\"></td></tr>");
			 sb.append("<tr><td width=\"8\"></td>");
			 sb.append("<td><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id="+ product.getId()+"&sp_id=1212236301\" target=\"_blank\" style=\"font-size:13px;"+ namec+"\">");
			 sb.append(Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),40)+"</a></td><td></td></tr>");
			 sb.append("<tr><td coslpan=\"3\" height=\"4\"></td></tr>");
			 sb.append("<tr><td width=\"8\"></td><td style=\" text-align:center;\">");
			 if(price==0)
			 {
				sb.append("<font style=\" font-family:微软雅黑;font-size:13px;"+ mpc+"\">聚惠价：<b>￥"+ Tools.getFormatMoney(product.getGdsmst_memberprice())+"</b></font>");
			 }
			 else{
				sb.append("<font style=\" font-family:微软雅黑;font-size:13px;"+ mpc+"\">聚惠价：<b>￥"+price+"</b></font>");
			 }
			 sb.append("</td><td></td></tr>");
		 
		}
	    else
		{
			sb.append("<tr><td width=\"8\"></td><td width=\"8\"></td><td height=\"8\"></td></tr>");
	    	 sb.append("<tr><td></td><td>");
			 sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id="+product.getId()+"&sp_id=1212236301\" target=\"_blank\" ><img src=\""+ imgurl +"\"  style=\"background:#fff;\"/></a></td>");
			 sb.append("<td width=\"8\"></td></tr>");
			 sb.append("<tr><td coslpan=\"3\" height=\"3\"></td></tr>");
			 sb.append("<tr><td width=\"8\"></td>");
			 sb.append("<td><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id="+ product.getId()+"&sp_id=1212236301\" target=\"_blank\" style=\"font-size:13px;"+ namec+"\">");
			 sb.append(Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),40)+"</a></td><td></td></tr>");
			 sb.append("<tr><td coslpan=\"3\" height=\"4\"></td></tr>");
			 sb.append("<tr><td width=\"8\"></td><td style=\" text-align:center;\">");
			 if(price==0)
			 {
				sb.append("<font style=\" font-family:微软雅黑;font-size:13px;"+ mpc+"\">聚惠价：<b>￥"+ Tools.getFormatMoney(product.getGdsmst_memberprice())+"</b></font>");
			 }
			 else{
				sb.append("<font style=\" font-family:微软雅黑;font-size:13px;"+ mpc+"\">聚惠价：<b>￥"+price+"</b></font>");
			 }
			 sb.append("</td><td width=\"8\"></td></tr>");
			
     }
	     sb.append("</table>");
       sb.append("</span>");
       if(width>784){
  		  sb.append("<img src=\""+ tbimg +"\"  style=\"position:absolute; right:0px; top:"+ tbtop+"\"/>"); 		  
  	 } 
   }
  else
  {
  	return "";
  }

  return sb.toString();
  
}

//获取新图
private static ArrayList<GdsCutImg> getByGdsid(String gdsid){
	ArrayList<GdsCutImg> list=new ArrayList<GdsCutImg>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_gdsid", gdsid));
	List<BaseEntity> b_list = Tools.getManager(GdsCutImg.class).getList(clist, null, 0,1);
	if(b_list==null || b_list.size()==0) return null;		
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((GdsCutImg)be);
		}
	}	
	
return list;
}



private String getimglist2(String code,int length,int flag)
{
	StringBuilder sb = new StringBuilder();
	if(!Tools.isNumber(code) || length<=0) return "";
	ArrayList<Promotion> list=new ArrayList<Promotion>();
	list=PromotionHelper.getBrandListByCode(code,length);
	if(list!=null&&list.size()>0)
	{
		sb.append("<ul>");
		//int i=0;
		for(Promotion p:list)
		{
			
			if(p!=null)
			{
				
				StringBuilder map=new StringBuilder();
				//i++;
				ArrayList<PromotionImagePos> piplist=new ArrayList<PromotionImagePos>();
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("promotionId", p.getId()));
				List<BaseEntity> b_list = Tools.getManager(PromotionImagePos.class).getList(clist, null, 0, 100);
				if(b_list!=null){
					for(BaseEntity be:b_list){
						piplist.add((PromotionImagePos)be);
					}
				}
				sb.append("<li>");
			
				sb.append("<img src=\""+p.getSplmst_picstr()+"\" width=\"980\"   usemap=\"#img_"+flag+"\"/>");
				map.append("<map name=\"img_").append(flag).append("\" id=\"").append("img_").append(flag).append("\">");
				//sb.append("<div>");
				StringBuilder sb1=new StringBuilder();
				for(PromotionImagePos pip:piplist)
				{
					
					if(pip!=null)
					{
						int left=0;
						int top=0;
						int top1=0;
						int left1=0;
						//left=(((i-1)*980)+pip.getPos_x()-24+(Tools.parseInt(pip.getExt1())-pip.getPos_x())/2);
						//left=pip.getPos_x()+40;
						//价格坐标
						left1=Tools.parseInt(pip.getExt1());
						left=left1-10;
						top1=(Tools.parseInt(pip.getExt2())-pip.getPos_y())/2+pip.getPos_y()-10;
						if(left>784)
						{
							left=pip.getPos_x()-166;
						}
						top=pip.getPos_y()+60;
						//int divtop=0;
						//if(top+40>350)
						//{
							//divtop=350;
						//}
						//else
							//divtop=top+10;
						
						String endtop="";
						String position="";
						String tf="1";
						if(top<160)
						{
							position="top";
							endtop="25px";
							tf="1";
						}
						else if(top>=160&&top<295)
						{
							position="top";
							endtop="60px";
							tf="2";
						}
						else
						{
							position="bottom";
							endtop="0px";
							tf="3";
						}			
						
						
						
						
						
						//获取背景图片
						String bg="";
						String namec="";
						String mpc="";
						String sc="";
						if(flag==1||flag==2||flag==3||flag==4||flag==11)
						{
							if((pip.getPos_x()+70)>784)
							{
								bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/Fm1.png);";
							}
							else
							{
							   bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/Fm.png);";
							}
							namec=" color:#7f7f7f";
							mpc=" color:#b80024";
							sc=" color:#333";
						}

						if(flag==8||flag==9||flag==10)
						{
							if((pip.getPos_x()+70)>784)
							{
								bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/sheromo1.png);";
							}
							else
							{
							   bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/sheromo.png);";
							}
							namec=" color:#858178";
							mpc=" color:#b80024";
							sc=" color:#ca0000";
						}
						if(flag==5||flag==6||flag==7)
						{
							if((pip.getPos_x()+70)>784)
							{
								bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/aleeishe1.png);";
							}
							else
							{
							    bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/aleeishe.png);";
							}
							namec=" color:#cf85a8";
							mpc=" color:#fff";
							sc=" color:#fff";
						}
						
						sb1.append("<div id=\"div_"+pip.getId()+"\" class=\"hh\" style=\"left:"+left+"px;"+position+":"+ endtop+";\" onmouseover=\"mdmoverf1105("+ pip.getId()+")\" onmouseout=\"mdmoutf1105("+pip.getId()+")\" >");
						
						//获取价格的背景图片
						String pricebg="";
						String pricecolor="";
						if(flag==1||flag==2||flag==3||flag==4||flag==11)
						{
							pricebg="http://images.d1.com.cn/images2012/index2012/JULY/fmprice1.png";
						
						}

						if(flag==8||flag==9||flag==10)
						{
							pricebg="http://images.d1.com.cn/images2012/index2012/JULY/srmprice1.png";
						}
						if(flag==5||flag==6||flag==7)
						{
							pricebg="http://images.d1.com.cn/images2012/index2012/JULY/aprice1.png";
						}
					    map.append("<area shape=\"rect\" coords=\"").append(pip.getPos_x()+",").append(pip.getPos_y()+",").append(pip.getExt1()+",").append(pip.getExt2()).append("\" onmouseover=\"mdmoverf11105(\\\'"+ pip.getProductId().toString()+"\\\',"+(pip.getPos_x()+70)+",\\\'"+pip.getId()+"\\\',\\\'"+left+"px\\\',\\\'"+position+"\\\',\\\'"+endtop+"\\\',\\\'"+tf+"\\\',\\\'"+Tools.getFloat(pip.getPprice(),1)+"\\\')\" onmouseout=\"mdmoutf(\\\'"+flag+"\\\')\" onblur=\"mdmoutf(\\\'"+flag+"\\\')\""); 
						
						//map.append("<area shape=\"rect\" coords=\"").append(pip.getPos_x()+",").append(pip.getPos_y()+",").append(pip.getExt1()+",").append(pip.getExt2()).append("\" onmouseover=\"mdmoverf11105(\\\'"+ pip.getProductId().toString()+"\\\',"+(pip.getPos_x()+70)+","+flag+",\\\'"+pip.getId()+"\\\')\" onmouseout=\"mdmoutf("+pip.getId()+")\""); 
						
						Product product=ProductHelper.getById(pip.getProductId());
						if(product!=null)
						{
							 String imgurl="";
							 ArrayList<GdsCutImg> gcilist=getByGdsid(product.getId());
							 if(gcilist!=null&&gcilist.size()>0)
							 {
								 if(gcilist.get(0)!=null&&gcilist.get(0).getGdscutimg_160()!=null&&gcilist.get(0).getGdscutimg_160().length()>0)
								 {
									 imgurl="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_160();
								 }
								 else
								 {
									 imgurl=ProductHelper.getImageTo160(product);
								 }
							 }
							 else
							 {
								 imgurl=ProductHelper.getImageTo160(product);
							 }
							 sb.append("<div style=\"display:block; width:34px; height:18px; line-height:18px;left:"+left1+"px; top:"+top1+"px; color:#fff; font-size:14px; padding-left:5px; background:url("+pricebg+") no-repeat;\">&nbsp;"+Tools.getFormatMoney(product.getGdsmst_memberprice().floatValue())+"</div>");
			     			 
							 long endTime = Tools.dateValue(product.getGdsmst_discountenddate());
			     			 long currentTime = System.currentTimeMillis();
			     			 sb1.append(getProduct(product.getId(),pip.getPos_x()+70 ,product.getGdsmst_memberprice().toString(),flag,tf));
			     			 map.append("href=\"").append("http://juhui.tenpay.com/commodity_detail.shtml?product_id="+product.getId()+"&sp_id=1212236301\" target=\"_blank\"");
						}
						map.append("/>");
						sb1.append("</div>");
							
					}
				}
				
				sb.append(sb1);
				map.append("</map>");
				sb.append(map.toString());
				sb.append("</li>");
				
			}
		}
		sb.append("</ul>");
		return sb.toString();
	}
	System.out.print(sb.toString());
	return "";
	
	
	
			
}




//获取轮播
public static String getIndexLB(String code)
{
    StringBuilder sb=new StringBuilder();
    StringBuilder sb1=new StringBuilder();
    if(Tools.isNull(code)||!Tools.isMath(code)) return "";
    ArrayList<Promotion> plist=PromotionHelper.getBrandListByCode(code, 10);
    if(plist!=null&&plist.size()>0)
    {
    	sb.append(" <div id=\"tabAuto08\">");
    	sb.append("<div class=\"tgh-box08\">");
    	sb1.append(" <ul class=\"tabAuto08\">");
    	int i=0;
    	for(Promotion p:plist)
    	{
    		if(p!=null)
    		{
    			i++;
    			String url=p.getSplmst_url()!=null&&p.getSplmst_url().length()>0?p.getSplmst_url():"http://www.d1.com.cn";
    		    String mainimg=p.getSplmst_picstr()!=null&&p.getSplmst_picstr().length()>0?p.getSplmst_picstr():"";
    		    String smallimg=p.getSplmst_picstr2()!=null&&p.getSplmst_picstr2().length()>0?p.getSplmst_picstr2():"";
    		    sb.append("<div style=\"display: block; \"><a href=\""+url+"\" target=\"_blank\"><img src=\""+mainimg+"\" width=\"642\" height=\"300\"/></a></div>");
    		    sb1.append("<li>"+i+"</li>");
    		   
    		    if(i>=6)
    		    {
    		    	break;
    		    }
    		}
    	}
    	sb1.append("</ul>");
    	sb.append("</div><div class=\"clear\"></div>");
    	sb.append(sb1);
    	sb.append("</div>");
    }
    
    return sb.toString();
    
    
} %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/index201208.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/autotab.js")%>"></script>
<style type="text/css">
ul{ margin:0px; padding:0px; list-style:none; }
a{ text-decoration:none;}
a img{border:none;}
img{ border:none;}
#tabAuto08{ width:642px; height:300px; position:relative; }
.tgh-box08{ width:642px; height:300px; overflow:hidden; }
.tgh-box08 div{width:642px;  }
.tabAuto08{width:auto; right:10px; background:none; overflow:hidden; position:absolute; top:272px; height:30px;}
.tabAuto08 li{ margin:3px; padding:3px; background:#F3F3F5; width:10px; height:10px; overflow:hidden; font-size:12px; overflow:hidden; color:#333; font-family:'微软雅黑'; line-height:9px;}

.tabAuto08 li.current{ background:#8A2B3F; color:#fff;}
</style>
<script type="text/javascript" language="javascript">
function getindexp(gdsid,w,flag,left,position,endtop,tf,price)
{
	var obj=$("#div_"+flag);
	if(obj!=null)
	{       
		    $(obj).html("");
		    $(obj).css("left","");
		    $(obj).css("top","");
		    $(obj).css("bottom","");
		    $("#tbimg_"+flag).css("top","");
		    //$(obj).css("background-color","#fff");
			$(obj).html("<img src='http://images.d1.com.cn/images2012/New/Loading.gif' style=\"margin-left:100px; margin-top:100px; \"/>");
			$.post("getProduct.jsp",{"gdsid":gdsid,w:w,flag:flag,tf:tf,price:price},function(data){
			$(obj).html(data);
	
				if(flag==1||flag==2||flag==3||flag==4||flag==11)
					{
						if(w>784)
						{
							bg="http://images.d1.com.cn/images2012/index2012/JULY/Fm1.png";
						}
						else
						{
						   bg="http://images.d1.com.cn/images2012/index2012/JULY/Fm.png";
						}
						bgc="#d8d8d8";
						border="#545454";
					}

					if(flag==8||flag==9||flag==10)
					{
						if(w>784)
						{
							bg="http://images.d1.com.cn/images2012/index2012/JULY/sheromo1.png";
						}
						else
						{
						   bg="http://images.d1.com.cn/images2012/index2012/JULY/sheromo.png";
						}
						bgc="#dbd5c7";
						border="#a99c94";
					}
					if(flag==5||flag==6||flag==7)
					{
						if(w>784)
						{
							bg="http://images.d1.com.cn/images2012/index2012/JULY/aleeishe1.png";
						}
						else
						{
						    bg="http://images.d1.com.cn/images2012/index2012/JULY/aleeishe.png";
						}
						bgc="#b2366c";
						border="#722245";
					}
					for(var i=1;i<=11;i++)
					{
						var obj1=$("#div_"+i);
						if(obj1!=null&&i!=flag)
							{
							  obj1.css("display","none");
							}
					}
				
				$(obj).css("left",left);
				
				$(obj).css(position,endtop);
				//$(obj).css("background","url('"+bg+"')");
				//$(obj).css("border","solid 2px "+border);
				$(obj).css("display","block");
				//$(obj).css("background",bgc);
				$(obj).css("z-index","20000");
				//$(obj).removeClass("floatdp");
				//$(obj).addClass("floatdp1");
				//$(obj).css("top",$("#da"+count).offset().top+document.documentElement.scrollTop);
		
			});
	
    }
}


function mdmoverf(flag)
{
	var obj=$("#div_"+flag);
	obj.css("display","block");
}


 function mdmoutf(flag)
{
	 var obj=$("#div_"+flag);
		obj.css("display","none");
}
function mdmoverf1(gdsid,w,flag,left,position,endtop,tf,price)
{
	var obj=$("#div_"+flag);
	if(obj!=null)
		{
		   getindexp(gdsid,w,flag,left,position,endtop,tf,price);
		}
    
}



function mdmoverf1105(flag)
{
	$(".hh").css("display","none");
	var obj=$("#div_"+flag);
	obj.css("display","block");
}


 function mdmoutf1105(flag)
{
	 $(".hh").css("display","none");    
	 var obj=$("#div_"+flag);
     obj.css("display","none");
}
function mdmoverf11105(gdsid,w,flag,left,position,endtop,tf,price)
{
	$(".hh").css("display","none");
	var obj=$("#div_"+flag);
	obj.css("display","block");
	//if(obj!=null)
		//{
		   //getindexp(gdsid,w,flag,left,position,endtop,tf,price);
		//}
    
}

</script>
</head>
<body bgcolor="#FFFFFF" >
<div style="width:980px; margin:0px auto;">
<table border="0" cellspacing="0" cellpadding="0">
   <tr><td> <%= getIndexLB("3270") %></td>
   <td>
      <a href="#fm"><img src="http://images.d1.com.cn/images2012/market/121031/fm1.jpg"/></a>
      <a href="#as"><img src="http://images.d1.com.cn/images2012/market/121031/xls1.jpg"/></a>
      <a href="#srm"><img src="http://images.d1.com.cn/images2012/market/121031/srm1.jpg"/></a>
   </td>
   </tr>
   <tr><td colspan="2" height="10"></td></tr>
</table>
<a name="as" id="as"></a>
<div id="tabAuto1" style="background:none;height:80px;">
<img src="http://images.d1.com.cn/images2012/market/121031/xls.jpg" border="0"/>
</div>');
<div class="newgdscoll">
<%= getimglist2("3191",1,5) %>
</div>
<div class="newgdscoll">
<%= getimglist2("3192",1,6) %>
</div>
<div class="newgdscoll">
<%= getimglist2("3193",1,7) %>
</div>

<a name="srm" id="srm"></a>
<div id="tabAuto2" style="background:none; height:60px;">
<img src="http://images.d1.com.cn/images2012/market/121031/snm.jpg" border="0"/>
</div>
<div class="newgdscoll">

<%= getimglist2("3189",1,8) %>
</div>');
<div class="newgdscoll">
<%= getimglist2("3188",1,9) %>
</div>
<div class="newgdscoll">
<%= getimglist2("3190",1,10) %>
</div>

<a name="fm" id="fm"></a>');
<div id="tabAuto" style="margin-top:5px;background:none;height:60px;">
<img src="http://images.d1.com.cn/images2012/market/121031/fm.jpg" border="0"/>
</div>
<div class="newgdscoll">
<%= getimglist2("3196",1,1) %>
</div>
<div class="newgdscoll">
<%= getimglist2("3195",1,2) %>
<%= getimglist2("3253",1,4) %>
</div>
<div class="newgdscoll">
<%= getimglist2("3194",1,3) %>
<%= getimglist2("3252",1,11) %>
</div>
</div>
</body>

</html>