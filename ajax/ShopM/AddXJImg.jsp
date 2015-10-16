<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp"%>
<%@page	import=" java.awt.image.BufferedImage,javax.imageio.ImageIO,org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern"%>
<%@include file="/admin/chkshop.jsp"%>
<%!
//获取细节图   
private ArrayList<GdsImgDtl> getAllxj(String gdsid,String t)
{
   ArrayList<GdsImgDtl> gdslist=new ArrayList<GdsImgDtl>();
   List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
   clist.add(Restrictions.eq("gdsimgdtl_gdsid", gdsid));
   clist.add(Restrictions.eq("gdsimgdtl_sort", new Long(t)));
   List<BaseEntity> list = Tools.getManager(GdsImgDtl.class).getList(clist, null, 0, 1000);

   if(list==null||list.size()==0)return null;
		for(BaseEntity c:list){
			gdslist.add((GdsImgDtl)c);
		}
   return gdslist ;
}
%>
<%
String gdsid=request.getParameter("gdsid");
String imgurl=request.getParameter("imgurl");
String order="1";
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
if(!Tools.isNull(request.getParameter("order"))){
	order=request.getParameter("order").toString();
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
int width800=oldwidth;
int height800=height;
int width60=oldwidth;
int height60=height;
int width400=oldwidth;
int height400=height;


//允许图片最大宽度1200px
if(oldwidth>800){
	height=oldheight*800/oldwidth;
	width=800;
}

if(oldwidth>400){
	 height400=oldheight*400/oldwidth;
	 width400=400;
}
if(oldwidth>60){
	 height60=oldheight*60/oldwidth;
	 width60=60;
}

imgurl=fname.replace("/opt", "");
String imgbig=imgurl;
String img800=imgurl;
String img400=imgurl;
String img60=imgurl;
String extName = "";
if (imgurl.lastIndexOf(".") >= 0) {
    extName = imgurl.substring(imgurl.lastIndexOf("."));
}
//保存一张800的图
if(oldwidth>800){
   if(ImageUtil.resizeImage(fname,"_800",width800,height800)){
   	img800=imgurl.substring(0,imgurl.indexOf("."))+"_800"+extName;
		}
}
//保存宽度为400的图
if(oldwidth>400){
if(ImageUtil.resizeImage(fname,"_400",width400,height400)){
	img400=imgurl.substring(0,imgurl.indexOf("."))+"_400"+extName;
	}
}

if(oldwidth>60){
if(ImageUtil.resizeImage(fname,"_60",width60,height60)){
	img60=imgurl.substring(0,imgurl.indexOf("."))+"_60"+extName;
	}
}

//写入数据库
GdsImgDtl gds=new GdsImgDtl();
ArrayList<GdsImgDtl> gdilist=getAllxj(gdsid,order);
if(gdilist!=null&&gdilist.size()>0&&gdilist.get(0)!=null){
	gds=gdilist.get(0);
	gds.setGdsimgdtl_gdsid(gdsid);
	gds.setGdsimgdtl_bigimg(img800);
	gds.setGdsimgdtl_midimg(img400);
	gds.setGdsimgdtl_smallimg(img60);
	gds.setGdsimgdtl_sort(new Long(order));
	gds.setGdsimgdtl_createdate(new Date());
    if(Tools.getManager(GdsImgDtl.class).update(gds, true)){
    	out.print("{\"success\":true,\"message\":\"上传图片成功！\"}");
		return;	

	}
	else
	{
		out.print("{\"success\":false,\"message\":\"上传图片失败！\"}");
		return;	
	}
}
else{
	gds.setGdsimgdtl_gdsid(gdsid);
	gds.setGdsimgdtl_bigimg(img800);
	gds.setGdsimgdtl_midimg(img400);
	gds.setGdsimgdtl_smallimg(img60);
	gds.setGdsimgdtl_sort(new Long(order));
	gds.setGdsimgdtl_createdate(new Date());
	
	gds=(GdsImgDtl)Tools.getManager(GdsImgDtl.class).create(gds);
	if(gds!=null)
	{
		out.print("{\"success\":true,\"message\":\"上传图片成功！\"}");
		return;	

	}
	else
	{
		out.print("{\"success\":false,\"message\":\"上传图片失败！\"}");
		return;	
	}

}



%>