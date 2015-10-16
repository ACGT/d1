<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern,java.awt.Rectangle;"%>
<%!
static int getshowgdslength(String orderid,String gdsid,String mbrid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("myshow_odrid", orderid));
	listRes.add(Restrictions.eq("myshow_gdsid", gdsid));
	listRes.add(Restrictions.eq("myshow_mbrid", new Long(mbrid)));
	return Tools.getManager(MyShow.class).getLength(listRes);
}
%>
<%

//if(lUser==null) {
	//response.setHeader("_d1-Ajax","2");
	%><%
	//return;
//}
/*
String orderid=request.getParameter("orderid");
String productid=request.getParameter("gdsid");

if(Tools.isNull(orderid) || Tools.isNull(productid)){
	 out.print("{\"succ\":false,\"message\":\"参数错误！\"}"); 
		return;
}
OrderBase obase=OrderHelper.getById(orderid);
if(obase==null){
	  out.print("{\"succ\":false,\"message\":\"该订单不存在！\"}"); 
		return;
}
boolean bl=false;
if(obase!=null){
	  if(!lUser.getId().equals(String.valueOf(obase.getOdrmst_mbrid()))){
		  out.print("{\"succ\":false,\"message\":\"您没有权限进行操作！\"}"); 
			return;
	  }
	  ArrayList<OrderItemBase> orderitemlist=OrderItemHelper.getOdrdtlListByOrderId(obase.getId());  
	  if(orderitemlist!=null && orderitemlist.size()>0){
		  for(OrderItemBase item :orderitemlist){
			  if(productid.equals(item.getOdrdtl_gdsid().trim())){
				  bl=true;
			  }
		  }
	  }
}
if(!bl){
	 out.print("{\"succ\":false,\"message\":\"您的订单中没有购买此商品！\"}"); 
	return;
}

int showcount=getshowgdslength(orderid,productid,lUser.getId());
if(showcount>=5){
	 out.print("{\"succ\":false,\"message\":\"每件宝贝最多可上传5张！\"}"); 
	return;
}
*/


     	  String imgurl=request.getParameter("imgurl");
    	  String x=request.getParameter("x");
    	  String y=request.getParameter("y");
    	  String x1=request.getParameter("x1");
    	  String y1=request.getParameter("y1");
    	//System.out.print(imgurl+"aaaa");
    	//System.out.print(x+"bbbb");
    	//System.out.print(y+"ccc");
    	//System.out.print(x1+"ddd");
    	//System.out.print(y1+"ww");
    	  if(imgurl.length()==0||x.length()==0||y.length()==0||x1.length()==0||y1.length()==0)
    	  {
    		 out.print("{\"succ\":false,\"message\":\"参数不正确，不能上传图片！\"}");
    		  return;
    	  }
    	  
    	  try{
    		/*  //创建文件
    		  String savePath = this.getServletConfig().getServletContext().getRealPath("");
    		  if(imgurl.startsWith("http:")){
    			  imgurl=imgurl.substring(21,imgurl.length());
    		  }
    		  
    		  File oldfile=new File(savePath+imgurl);
    		  String pre="."+imgurl.substring(imgurl.lastIndexOf(".")+1,imgurl.length());
    		  File newfile=new File(savePath+"/uploads/SD/");
    		  if(!newfile.exists())
    		  {
    			  newfile.mkdirs();
    		  }
    		  if(!oldfile.exists())
    		  {
    			 System. out.print(oldfile);
    			  out.print("{\"succ\":false,\"message\":\"原始图片不存在，不能上传图片！\"}");
        		  return;
    		  }*/
    		/*
    		  String imgname="/"+productid+"_"+System.currentTimeMillis()+pre;
    			  ImageHelper.cut(oldfile.getPath(), newfile.getPath()+imgname, 605, 405, new Rectangle(Tools.parseInt(x),Tools.parseInt(y),Tools.parseInt(x1),Tools.parseInt(y1)));
    			  File f=new File(newfile.getPath()+imgname);
    			  String img80100="/uploads/SD"+imgname;
    			  String img120150="/uploads/SD"+imgname;
    			  String img240300="/uploads/SD"+imgname;
    			  String img400500="/uploads/SD"+imgname;
    			 if(ImageUtil.resizeImage1(newfile.getPath()+imgname, "_s", 80, 100)){
    			    img80100=img80100.substring(0,img80100.indexOf("."))+"_s"+pre;
    		      }
    			 if(ImageUtil.resizeImage1(newfile.getPath()+imgname, "_120", 120, 150)){
     			    img80100=img80100.substring(0,img80100.indexOf("."))+"_120"+pre;
     		      }
    			 if(ImageUtil.resizeImage1(newfile.getPath()+imgname, "_240", 240, 300)){
     			    img80100=img80100.substring(0,img80100.indexOf("."))+"_240"+pre;
     		      }
    			 if(ImageUtil.resizeImage1(newfile.getPath()+imgname, "_400", 400, 500)){
     			    img80100=img80100.substring(0,img80100.indexOf("."))+"_400"+pre;
     		      }
    			 MyShow show=new MyShow();
    			show.setMyshow_gdsid(productid);
    			show.setMyshow_mbrid(new Long(lUser.getId()));
    			show.setMyshow_odrid(orderid);
    			show.setMyshow_show(new Long(0));
    			show.setMyshow_status(new Long(0));
    			show.setMyshow_createdate(new Date());
    			show.setMyshow_img80100(img80100);
    			show.setMyshow_img120150(img120150);
    			show.setMyshow_img240320(img240300);
    			show.setMyshow_img400500(img400500);
    			show.setMyshow_content("");
    			show=(MyShow)Tools.getManager(MyShow.class).create(show);
    	    	*/  
    	  }
    	  catch(Exception ex)
    	  {
    		  out.print("{\"succ\":false,\"message\":\"上传失败！"+ex.getMessage() +"\"}");
    		  return;
    	  }
    	  
    	  out.print("{\"succ\":true,\"message\":\"上传成功！\"}");
    	  





%>