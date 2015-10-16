<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp"%>
<%@page	import=" java.awt.image.BufferedImage,javax.imageio.ImageIO,org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern"%>
<%@include file="/admin/chkshop.jsp"%>
<%

String gdsid=request.getParameter("gdsid");
String imgurl=request.getParameter("imgurl");
int oldwidth=0;
int oldheight=0;
if(!Tools.isNull(request.getParameter("hw"))){
	oldwidth=Tools.parseInt(request.getParameter("hw"));// 图片宽度  
}
if(!Tools.isNull(request.getParameter("hh"))){
	oldheight=Tools.parseInt(request.getParameter("hh"));// 图片高度
}
Product product=ProductHelper.getById(gdsid);
if(product==null){
	out.print("{\"success\":false,message:\"商品id不存在！\"}");
	return;
}
if(Tools.isNull(gdsid)){
	out.print("{\"success\":false,message:\"商品id不存在！\"}");
	return;
}
if(Tools.isNull(imgurl)){
	out.print("{\"success\":false,message:\"商品图片不存在！\"}");
	return;	
}
String fname=imgurl.replace("http://images1.d1.com.cn", "");
fname="/opt"+fname;
//=imgurl.replace("http://images1.d1.com.cn", "/opt");

//System.out.println("========test1=========="+fname);

if(oldheight==0 || oldwidth==0){
	
	 File saveFile = new File(fname);
	  BufferedImage image = ImageIO.read(saveFile);  
       oldwidth = image.getWidth();// 图片宽度  
       oldheight = image.getHeight();// 图片高度
     
}
int width=oldwidth;
int height=oldheight;
int width400=oldwidth;
int height400=height;
int width310=oldwidth;
int height310=height;
int width200=oldwidth;
int height200=height;
int width160=oldwidth;
int height160=height;
int width120=oldwidth;
int height120=height;
int width80=oldwidth;
int height80=height;

//允许图片最大宽度1200px
if(oldwidth>800){
	height=oldheight*800/oldwidth;
	width=800;
}
if(oldwidth>400){
	 height400=oldheight*400/oldwidth;
	 width400=400;
}
if(oldwidth>310){
	 height310=oldheight*310/oldwidth;
	 width310=310;
}
if(oldwidth>200){
	 height200=oldheight*200/oldwidth;
	 width200=200;
}
if(oldwidth>160){
	 height160=oldheight*160/oldwidth;
	 width160=160;
}
if(oldwidth>120){
	 height120=oldheight*120/oldwidth;
	 width120=120;
}
if(oldwidth>80){
	 height80=oldheight*80/oldwidth;
	 width80=80;
}
imgurl=fname.replace("/opt", "");
String imgbig=imgurl;

String img200=imgurl;
String img400=imgurl;
String img240300="";
String img200250="";
String img160=imgurl;
String img120=imgurl;
String img80=imgurl;
String img310=imgurl;
String extName = "";
if (imgurl.lastIndexOf(".") >= 0) {
    extName = imgurl.substring(imgurl.lastIndexOf("."));
}
//保存一张原图,当图片宽度大于1200px时，保存进行缩放后宽为1200px的t图
//System.out.println("========test=========="+oldwidth);
if(oldwidth>800){
   if(ImageUtil.resizeImage_sd(fname,"_big",width,height)){
   	imgbig=imgurl.substring(0,imgurl.indexOf("."))+"_big"+extName;
		}
}
//保存宽度为200的图
if(oldwidth>200){
if(ImageUtil.resizeImage_sd(fname,"_200",width200,height200)){
	img200=imgurl.substring(0,imgurl.indexOf("."))+"_200"+extName;
	}
}
if(oldwidth>400){
if(ImageUtil.resizeImage_sd(fname,"_400",width400,height400)){
	img400=imgurl.substring(0,imgurl.indexOf("."))+"_400"+extName;
	}
}
if(oldwidth>310){
if(ImageUtil.resizeImage_sd(fname,"_310",width310,height310)){
	img310=imgurl.substring(0,imgurl.indexOf("."))+"_310"+extName;
	}
}
if(!Tools.isNull(img400)){
	if(ImageUtil.resizeImagecut("/opt"+img400,"_240300",240,300)){
		img240300=imgurl.substring(0,imgurl.indexOf("."))+"_400_240300"+extName;
		}
	if(ImageUtil.resizeImagecut("/opt"+img400,"_200250",200,250)){
		img200250=imgurl.substring(0,imgurl.indexOf("."))+"_400_200250"+extName;
		}
}

if(oldwidth>160){
if(ImageUtil.resizeImage_sd(fname,"_160",width160,height160)){
	img160=imgurl.substring(0,imgurl.indexOf("."))+"_160"+extName;
	}
}
if(oldwidth>120){
if(ImageUtil.resizeImage_sd(fname,"_120",width120,height120)){
	img120=imgurl.substring(0,imgurl.indexOf("."))+"_120"+extName;
	}
}
if(oldwidth>80){
if(ImageUtil.resizeImage_sd(fname,"_80",width80,height80)){
	img80=imgurl.substring(0,imgurl.indexOf("."))+"_80"+extName;
	}
}

//写入数据库

if(product!=null)
{
    product.setGdsmst_midimg(img400);
    product.setGdsmst_img240300(img240300);
    product.setGdsmst_img200250(img200250);
    product.setGdsmst_recimg(img160);
    product.setGdsmst_otherimg3(img120);
    product.setGdsmst_imgurl(img200);
    product.setGdsmst_smallimg(img80);
    product.setGdsmst_img310(img310);
    product.setGdsmst_bigimg(imgurl);
    if(Tools.getManager(Product.class).update(product, true))
	{
    	out.print("{\"success\":true,\"message\":\"上传图片成功！\"}");
					return;
	
	}else{
		out.print("{\"success\":false,\"message\":\"上传图片失败！\"}");
		return;
	
	}
}
else
{
	out.print("{\"success\":false,\"message\":\"商品不存在！\"}");
	return;	
}
%>