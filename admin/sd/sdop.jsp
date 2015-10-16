<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<%@page	import=" java.awt.image.BufferedImage,javax.imageio.ImageIO,org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern"%>

<%


String gdsid=request.getParameter("gdsid");
String dtime=request.getParameter("sddate");
String content= request.getParameter("content");
String uid=request.getParameter("uid");
String imgurl=request.getParameter("imgurl");
Date d=new Date();
SimpleDateFormat format=	new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
int oldwidth=0;
int oldheight=0;
if(!Tools.isNull(request.getParameter("w"))){
	oldwidth=Tools.parseInt(request.getParameter("w"));// 图片宽度  
}
if(!Tools.isNull(request.getParameter("h"))){
	oldheight=Tools.parseInt(request.getParameter("h"));// 图片高度
}
//if(Tools.isNull(dtime)){
//	out.print("{\"success\":false,message:\"请输入晒单时间！\"}");
//	return;
//}
if(!Tools.isNull(dtime)){
	try{
	d=format.parse(dtime);
	}catch(Exception e){
		out.print("{\"success\":false,message:\"时间格式错误！\"}");
		return;
	}
}
if(Tools.isNull(gdsid)){
	out.print("{\"success\":false,message:\"请输入商品编号！\"}");
	return;
}
if(Tools.isNull(imgurl)){
	out.print("{\"success\":false,message:\"请选择要晒单的商品图片！\"}");
	return;	
}
if(Tools.isNull(content)){
	out.print("{\"success\":false,message:\"请输入晒单内容！\"}");
	return;
}
 
	String fname=imgurl.replace("http://images1.d1.com.cn", "/opt");
if(oldheight==0 || oldwidth==0){
	
	 File saveFile = new File(fname);
	  BufferedImage image = ImageIO.read(saveFile);  
       oldwidth = image.getWidth();// 图片宽度  
       oldheight = image.getHeight();// 图片高度
     
}
int width=oldwidth;
int height=oldheight;
int width200=oldwidth;
int height200=height;
int width400=oldwidth;
int height400=height;
int width100=oldwidth;
int height100=height;
//允许图片最大宽度1200px
if(oldwidth>1200){
	height=oldheight*1200/oldwidth;
	width=1200;
}
if(oldwidth>200){
	 height200=oldheight*200/oldwidth;
	 width200=200;
}
if(oldwidth>400){
	 height400=oldheight*400/oldwidth;
	 width400=400;
}
if(oldwidth>100){
	 height100=oldheight*100/oldwidth;
	 width100=100;
}
imgurl=fname.replace("/opt", "");
String imgbig=imgurl;

String img200=imgurl;
String img400=imgurl;
String img100=imgurl;
String extName = "";
if (imgurl.lastIndexOf(".") >= 0) {
    extName = imgurl.substring(imgurl.lastIndexOf("."));
}
//保存一张原图,当图片宽度大于1200px时，保存进行缩放后宽为1200px的t图
if(oldwidth>1200){
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
if(oldwidth>100){
if(ImageUtil.resizeImage_sd(fname,"_100",width100,height100)){
	img100=imgurl.substring(0,imgurl.indexOf("."))+"_100"+extName;
	}
}
MyShow show=null;
boolean isadd=true;
 show=new MyShow();

show.setMyshow_mbruid(uid);
show.setMyshow_gdsid(gdsid);
show.setMyshow_mbrid(new Long(0));
show.setMyshow_odrid("");
show.setMyshow_show(new Long(1));//是否显示
show.setMyshow_status(new Long(1));
show.setMyshow_createdate(d);
show.setMyshow_subodrid("");
//show.setMyshow_img80100("");
show.setMyshow_img120150(img400);
show.setMyshow_img240300(img200);
show.setMyshow_img400500(imgbig);
show.setMyshow_img100(img100);
show.setMyshow_adddate(new Date());
show.setMyshow_adduser(session.getAttribute("admin_mng").toString());
Product p=ProductHelper.getById(gdsid);
if(p!=null){
	show.setMyshow_img80100(p.getGdsmst_rackcode());
}
//show.setMyshow_img240300(fname1);
//show.setMyshow_img400500(fname1);
show.setMyshow_content(content);

	show=(MyShow)Tools.getManager(MyShow.class).create(show);
	if(show!=null){
		out.print("{\"success\":true,type:1,message:\"晒单成功！\"}");
		return;
	}


%>