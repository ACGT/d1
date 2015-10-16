<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp"%>
<%@page	import=" java.awt.image.BufferedImage,javax.imageio.ImageIO,org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern"%>
<%@include file="/admin/chkshop.jsp"%>
<%

String gdsid=request.getParameter("gdsid");
String imgurl=request.getParameter("imgurl");
int oldwidth=0;
int oldheight=0;
if(!Tools.isNull(request.getParameter("w"))){
	oldwidth=Tools.parseInt(request.getParameter("w"));// 图片宽度  
}
if(!Tools.isNull(request.getParameter("h"))){
	oldheight=Tools.parseInt(request.getParameter("h"));// 图片高度
}

if(Tools.isNull(gdsid)){
	out.print("{\"success\":false,message:\"商品id不存在！\"}");
	return;
}
if(Tools.isNull(imgurl)){
	out.print("{\"success\":false,message:\"商品图片不存在！\"}");
	return;	
}
//String fname=imgurl.replace("http://images1.d1.com.cn", "/opt");
String fname=imgurl.replace("http://images1.d1.com.cn", "");
fname="/opt"+fname;
if(oldheight==0 || oldwidth==0){
	
	 File saveFile = new File(fname);
	  BufferedImage image = ImageIO.read(saveFile);  
       oldwidth = image.getWidth();// 图片宽度  
       oldheight = image.getHeight();// 图片高度
     
}
int width=oldwidth;
int height=oldheight;
int width200=oldwidth;
int height250=height;
int width160=oldwidth;
int height200=height;
int width240=oldwidth;
int height300=height;


imgurl=fname.replace("/opt", "");

String imgbig=imgurl;

String img200=imgurl;
String img160=imgurl;
String img240=imgurl;
String extName = "";
if (imgurl.lastIndexOf(".") >= 0) {
    extName = imgurl.substring(imgurl.lastIndexOf("."));
}

//保存宽度为200的图
if(oldwidth>240){
if(ImageUtil.resizeImage(fname, "_s300", 240, 300)){
	img240=imgurl.substring(0,imgurl.indexOf("."))+"_s300"+extName;
	}
}
if(oldwidth>200){
if(ImageUtil.resizeImage(fname, "_s250", 200, 250)){
	img200=imgurl.substring(0,imgurl.indexOf("."))+"_s250"+extName;
	}
}
if(oldwidth>160){
if(ImageUtil.resizeImage(fname,"_s200",160,200)){
	img160=imgurl.substring(0,imgurl.indexOf("."))+"_s200"+extName;
	}
}


//写入数据库
Product product=ProductHelper.getById(gdsid);
if(product!=null)
{
  product.setGdsmst_img200250(img200);
  product.setGdsmst_img240300(img240);
  product.setGdsmst_fzimg(img160);
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