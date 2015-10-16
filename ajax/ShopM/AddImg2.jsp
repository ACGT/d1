<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp"%>
<%@page	import=" java.awt.image.BufferedImage,javax.imageio.ImageIO,org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern"%>
<%@include file="/admin/chkshop.jsp"%>
<%!public static void delGdsCutImg(String gdsid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdsmst_gdsid", gdsid));
	List<BaseEntity> list = Tools.getManager(GdsCutImg.class).getList(listRes, null, 0, 200);	
	ArrayList<GdsCutImg> gcilist=new ArrayList<GdsCutImg>();
	if(list.size()>0)
	{
		for(BaseEntity be:list)
		{
			if(be!=null)
			{ 
				gcilist.add((GdsCutImg)be);
			}
			
		}		
	}
	if(gcilist.size()>0)
	{
		for(GdsCutImg gci:gcilist)
		{
			if(gci!=null)
			{
				Tools.getManager(GdsCutImg.class).delete(gci);
			}
		}
	}
} %>
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
	out.print("{\"success\":false,\"message\":\"商品id不存在！\"}");
	return;
}
if(Tools.isNull(imgurl)){
	out.print("{\"success\":false,\"message\":\"商品图片不存在！\"}");
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
int height200=height;
int width160=oldwidth;
int height160=height;
int width100=oldwidth;
int height100=height;

//允许图片最大宽度1200px
if(oldwidth>800){
	height=oldheight*800/oldwidth;
	width=800;
}

if(oldwidth>200){
	 height200=oldheight*200/oldwidth;
	 width200=200;
}
if(oldwidth>160){
	 height160=oldheight*160/oldwidth;
	 width160=160;
}
if(oldwidth>100){
	 height100=oldheight*100/oldwidth;
	 width100=120;
}

imgurl=fname.replace("/opt", "");
String imgbig=imgurl;
String img200=imgurl;
String img300=imgurl;
String img400=imgurl;
String img160=imgurl;
String img100=imgurl;
String extName = "";
if (imgurl.lastIndexOf(".") >= 0) {
    extName = imgurl.substring(imgurl.lastIndexOf("."));
}
//保存一张300的图
if(oldwidth>300){
   if(ImageUtil.resizeImage(fname,"_300",width,height)){
   	img300=imgurl.substring(0,imgurl.indexOf("."))+"_300"+extName;
		}
}
//保存宽度为200的图
if(oldwidth>200){
if(ImageUtil.resizeImage(fname,"_200",width200,height200)){
	img200=imgurl.substring(0,imgurl.indexOf("."))+"_200"+extName;
	}
}
if(oldwidth>100){
if(ImageUtil.resizeImage(fname,"_100",width100,height100)){
	img100=imgurl.substring(0,imgurl.indexOf("."))+"_100"+extName;
	}
}
if(oldwidth>160){
if(ImageUtil.resizeImage(fname,"_160",width160,height160)){
	img160=imgurl.substring(0,imgurl.indexOf("."))+"_160"+extName;
	}
}

//写入数据库
//判断是否存在于数据库
delGdsCutImg(gdsid);
GdsCutImg gds=new GdsCutImg();
gds.setGdsmst_gdsid(gdsid);
gds.setGdscutimg_100(img100);
gds.setGdscutimg_160(img160);
gds.setGdscutimg_200(img200);
gds.setGdscutimg_300(img300);
gds.setGdscutimg_bigimg(imgbig);
gds=(GdsCutImg)Tools.getManager(GdsCutImg.class).create(gds);
    if(gds!=null)
	{
			out.print("{\"success\":true,\"message\":\"上传图片成功！\"}");
					return;
	
	}else{
		out.print("{\"success\":false,\"message\":\"上传图片失败！\"}");
		return;
	
	}

%>