<%@ page contentType="text/html; charset=UTF-8"  import="net.sf.json.*,java.io.File,
java.io.FileOutputStream,
java.io.InputStream,
java.io.OutputStream,
java.net.URL,
java.net.URLConnection,java.awt.image.BufferedImage,javax.imageio.ImageIO,org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern" %><%@include file="/html/header.jsp"%><%!
private static String baseURLDir = "/opt/shopimg/gdsimg/no5/";//上传文件目录URL
private static String fileExt = "jpg,jpeg,bmp,gif,png";
public  synchronized void getgoodlist(long i,boolean pgflag){
	System.out.println("=======no5全量接口同步=========");
	String gourl="http://www.no5.com.cn/api/product_feed/d1com/full-"+i+".html";
String reqmst="";
try{
	reqmst= HttpUtil.getUrlContentByGet(gourl,"utf-8");
}catch(Exception ex){
   
}
//System.out.print(reqmst);
 JSONObject  jsonob = JSONObject.fromObject(reqmst); 
 JSONArray jsongoodsArray = (JSONArray) jsonob.get("products"); 
 if(pgflag){
     int gnum=jsongoodsArray.size();
	for (int j = 0; j < gnum; j++) {
		 JSONObject goods = (JSONObject) jsongoodsArray.get(j);
		 //System.out.println(goods.toString());
		// createproduct(goods);
		 }
 }else{
	String pagetotal= jsonob.getString("pagetotal");
	long pageall=Tools.parseLong(pagetotal);
	long pageno=pageall/100;
	if(pageall%100>0){
		pageno++;
	}
	//System.out.println("总页数：=================="+pageno);
	for(int l=1;l<=pageno;l++){
		getgoodlist(l,true);
	}
			
 }
}

public static synchronized void getincrement(long i,boolean pgflag){
	System.out.println("=======no5增量接口同步=========");
	String gourl="http://www.no5.com.cn/api/product_feed/d1com/increment-"+i+".html";
String reqmst="";
try{
	reqmst= HttpUtil.getUrlContentByGet(gourl,"utf-8");
}catch(Exception ex){
   
}
//System.out.print(reqmst);
 JSONObject  jsonob = JSONObject.fromObject(reqmst); 
 String  pagetotal =jsonob.getString("pagetotal");
 
 JSONArray jsongoodsArray = (JSONArray) jsonob.get("products");
 if(pgflag){
     int gnum=jsongoodsArray.size();
	for (int j = 0; j < gnum; j++) {
		 JSONObject goods = (JSONObject) jsongoodsArray.get(j);
		 //System.out.println(goods.toString());
		// createproduct(goods);
		 }
 }else{
		long pageall=Tools.parseLong(pagetotal);
		long pageno=pageall/100;
		if(pageall%100>0){
			pageno++;
		}
		for(int l=1;l<=pageno;l++){
			getincrement(l,true);
		}
		
	 }
 
}

public static  synchronized void getgoodsvalid(){
	System.out.println("=======no5上下架接口同步=========");
	String gourl="http://www.no5.com.cn/api/product_feed/d1com/valid-1.html";
String reqmst="";
try{
	reqmst= HttpUtil.getUrlContentByGet(gourl,"utf-8");
}catch(Exception ex){
   
}
System.out.print(reqmst);
 JSONObject  jsonob = JSONObject.fromObject(reqmst); 
 JSONArray jsongoodsArray = (JSONArray) jsonob.get("products");
    
     int gnum=jsongoodsArray.size();
	for (int j = 0; j < gnum; j++) {
		 JSONObject goods = (JSONObject) jsongoodsArray.get(j);
		 //System.out.println(goods.toString());
		 upproductvalid(goods);
		 }
}
/** 
 * 根据路径 下载图片 然后 保存到对应的目录下 
 * @param urlString 
 * @param filename 
 * @param savePath 
 * @return 
 * @throws Exception 
 */
 public static void download(String urlString, String filename,String savePath) throws Exception {  
        // 构造URL  
        URL url = new URL(urlString);  
        // 打开连接  
        URLConnection con = url.openConnection();  
        //设置请求的路径  
        con.setConnectTimeout(5*1000);  
        // 输入流  
        InputStream is = con.getInputStream();  
      
        // 1K的数据缓冲  
        byte[] bs = new byte[1024];  
        // 读取到的数据长度  
        int len;  
        // 输出的文件流  
       File sf=new File(savePath);  
       if(!sf.exists()){  
           sf.mkdirs();  
       }  
       OutputStream os = new FileOutputStream(sf.getPath()+"/"+filename);  
        // 开始读取  
        while ((len = is.read(bs)) != -1) {  
          os.write(bs, 0, len);  
        }  
        // 完毕，关闭所有链接  
        os.close();  
          
        is.close();  
    }   

 public static  Product  getProductByshoppcode(String shopcode,String shoppcode){
		ArrayList<Product> list=new ArrayList<Product>();
       
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("gdsmst_shopcode", shopcode));
				clist.add(Restrictions.eq("gdsmst_shopgoodscode", shoppcode));

				List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, null, 0, 1);
				SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
				if(b_list!=null){
					for(BaseEntity be:b_list){
						Product goods= (Product)be;
						// Date sdate=goods.getGdsmst_promotionstart();
					    //	Date edate=goods.getGdsmst_promotionend();	
						//if(goods!=null
						//		&&((edate.getTime()>(new Date()).getTime())&&(sdate.getTime()<(new Date()).getTime()&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31))){
						//	return null;
						//}
							
						return (Product)be;
					}
				}	
			
		
		return null;
	}
 public static void upproductvalid( JSONObject goods ){
	 String  pshoppcode =goods.getString("pshoppcode");
	 String  validflag  =goods.getString("validflag");
	 Product product =getProductByshoppcode("14051306",pshoppcode);
	 
	 if(product!=null){
		 if(product.getGdsmst_brand()!=null&&("000430".equals(product.getGdsmst_brand())
				 ||"001308".equals(product.getGdsmst_brand())||"001169".equals(product.getGdsmst_brand())
				 ||"000284".equals(product.getGdsmst_brand())))return;
		 if(validflag.equals("1")){
			 product.setGdsmst_validflag(new Long(1));
		 }else{
			 product.setGdsmst_validflag(new Long(2));
		 }
		 Tools.getManager(Product.class).update(product, true);
	 }
	 
 }
public static synchronized void createproduct(JSONObject goods){
	try{
     String pname =goods.getString("pname");
     String ptitle =goods.getString("ptitle");
     String  prackcode =goods.getString("prackcode");
     String  pbrandcode =goods.getString("pbrandcode");
     float  psaleprice =Tools.parseFloat(goods.getString("psaleprice"));
     float pmemberprice =Tools.parseFloat(goods.getString("pmemberprice"));
	 String  pshoppcode =goods.getString("pshoppcode");
	 String  pimages =goods.getString("pimages");
	 String  pimgdetails =goods.getString("pimgdetails");
	 String  pbriefintrduce =goods.getString("pbriefintrduce");
	 String  pdetail =goods.getString("pdetail");
	 String  pbarcode =goods.getString("pbarcode");
	 String  pstdvs =goods.getString("pstdvs");
	 String  pkeywords =goods.getString("pkeywords");
	 if("000430".equals(pbrandcode)
			 ||"001308".equals(pbrandcode)||"001169".equals(pbrandcode)
			 ||"000284".equals(pbrandcode))return;
	 SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
	 Directory dir=DirectoryHelper.getById(prackcode);
	  if(dir==null){
		  FileWriter fw = new FileWriter(new File("/var/no5error.txt"),true);
			fw.write("商品分类对应错误="+pshoppcode+"====="+prackcode+System.getProperty("line.separator"));
			fw.flush();
			fw.close();
		  return;
	  }
	  
	  Brand brand=BrandHelper.getBrandByCode(pbrandcode);
	  String brandname="";
	  if(brand!=null)brandname=brand.getBrand_name();
	    boolean newflag=false;
		String gdsid ="";
		Product  product=getProductByshoppcode("14051306",pshoppcode);

		if(product==null){
			newflag=true;
			product=new Product();
			 gdsid=ProductHelper.getPid(prackcode.substring(0,3));
			product.setId(gdsid);//商品编码
			product.setGdsmst_createdate(new Date());
			product.setGdsmst_autoupdatedate(new Date());
		}
		
		product.setGdsmst_shopgoodscode(pshoppcode);
		product.setGdsmst_shopcode("14051306");//商户编码
		product.setGdsmst_provide("");//主要供应商
		product.setGdsmst_provideStr("");//其他供应商
		product.setGdsmst_inputmngid("接口同步导入");
		product.setGdsmst_keyword(pkeywords);
		product.setGdsmst_addshipfee(0f);
		product.setGdsmst_incometype(new Long(0));
		product.setGdsmst_incomeprice(0f);
		product.setGdsmst_srctype1(new Long(0));
		product.setGdsmst_srctype2(new Long(0));
		product.setGdsmst_srctype3(new Long(0));
		product.setGdsmst_srcprice1(0f);
		product.setGdsmst_srcprice2(0f);
		product.setGdsmst_srcprice3(0f);
		product.setGdsmst_spendcount(0f);
		
		product.setGdsmst_discountenddate(format.parse("2999-01-01"));
		product.setGdsmst_enddateend(format.parse("2999-01-01"));
		
		product.setGdsmst_srcstatus(new Long(0));
		product.setGdsmst_downflag(new Long(1));
		product.setGdsmst_sendcount(new Long(0));
		product.setGdsmst_salecount(new Long(0));
		product.setGdsmst_discounflag(new Long(1));

		product.setGdsmst_beginstart(new Date());
		product.setGdsmst_presellflag(new Long(0));
		if(newflag){
		product.setGdsmst_validflag(new Long(1));
		}
		product.setGdsmst_refcount(new Long(0));
		product.setGdsmst_hitcount(new Long(0));
		product.setGdsmst_title(ptitle);
		product.setGdsmst_gdsename("");
		product.setGdsmst_paymethod("-1");
		product.setGdsmst_sndmethod("");
		//product.setGdsmst_provide("");	
		product.setGdsmst_othercost(new Float(0));
		product.setGdsmst_provider("");

		//if(!Tools.isNull(brandname)){
		//product.setGdsmst_gdsname("【"+brandname.trim()+"】"+pname);
		//}else{
		product.setGdsmst_gdsname(pname);
		//}

		product.setGdsmst_promotionstart(null);

		product.setGdsmst_promotionend(null);
        product.setGdsmst_weight(new Float(0f));
			product.setGdsmst_msprice(new Float(0f));
			product.setGdsmst_oldmemberprice(0f);
			product.setGdsmst_memberprice(new Float(pmemberprice));
			product.setGdsmst_vipprice(new Float(pmemberprice));	
			product.setGdsmst_oldvipprice(0f);
			product.setGdsmst_specialflag(new Long(0));	
		product.setGdsmst_giftselecttype(new Long(0));
		product.setGdsmst_stdid(dir.getRakmst_stdid());	
		product.setGdsmst_ifhavegds(new Long(0));
		product.setGdsmst_manufacture("");
		product.setGdsmst_brand(pbrandcode);	
		product.setGdsmst_brandname(brandname);
		product.setGdsmst_briefintrduce(pbriefintrduce);
		product.setGdsmst_barcode(pbarcode);
		product.setGdsmst_buylimit(new Long(0));
		product.setGdsmst_detailintruduce(pdetail);
		product.setGdsmst_inprice(new Float(pmemberprice));
		product.setGdsmst_saleprice(new Float(psaleprice));
		product.setGdsmst_rackcode(prackcode);
		JSONArray jsonskusArray = (JSONArray) goods.get("gdssku");
		  // if(jsonskusArray.size()>0){
		  // product.setGdsmst_skuname1("规格");
		  // }else{
			   product.setGdsmst_skuname1("");
		  // }
			product.setGdsmst_stock(new Long(0));//库存
			product.setGdsmst_virtualstock(new Long(0));
			String[] pstdvsarr=pstdvs.split("\\|");
			//014001 、014010  、 014002
			String stdv1="";
			String stdv2="";
			String stdv6="";
			
			if(prackcode.startsWith("014001")|| prackcode.startsWith("014002")||prackcode.startsWith("014010")){
				stdv1=pstdvsarr[0];
			}
          if(prackcode.startsWith("014001")|| prackcode.startsWith("014010")){
        	  if(pstdvsarr.length>=2){
        	  stdv6=pstdvsarr[1];     
        	  }
        	  if(pstdvsarr.length>=3){
            	  stdv2=pstdvsarr[2];
            	  }
			}
         // System.out.println(gdsid+prackcode+"========no5测试=="+pstdvs+"="+stdv1+"="+stdv2+"="+stdv6);
        /*
    		  FileWriter fwttt = new FileWriter(new File("/var/no5error.txt"),true);
    			fwttt.write("商品分类对应错误="+gdsid+prackcode+"========no5测试=="+pstdvs+"="+stdv1+"="+stdv2+"="+stdv6+System.getProperty("line.separator"));
    			fwttt.flush();
    			fwttt.close();*/
    		  //return;
    	 
    	product.setGdsmst_stdvalue1(stdv1);
		product.setGdsmst_stdvalue2(stdv2);
		product.setGdsmst_stdvalue3("");
		product.setGdsmst_stdvalue4("");
		product.setGdsmst_stdvalue5("");
		product.setGdsmst_stdvalue6(stdv6);
		product.setGdsmst_stdvalue7("");
		product.setGdsmst_stdvalue8("");
		product.setGdsmst_stdvalue9("");
		product.setGdsmst_stdvalue10("");
		product.setGdsmst_stdvalue11("");
		
		product.setGdsmst_stdvalue12("");
		product.setGdsmst_wsalecount(new Long(0));
		product.setGdsmst_updatedate(new Date());
		product.setGdsmst_sex(new Long(2));
		
      if(newflag){
		String extName = "";
		if (pimages.lastIndexOf(".") >= 0) {
		    extName = pimages.substring(pimages.lastIndexOf("."));
		
		/*检查文件类型*/
		if (("," + fileExt.toLowerCase() + ",").indexOf("," + extName.substring(1).toLowerCase() + ",")>=0){
			
		
		String fname="";
		int oldwidth = 0;
		int oldheight=0;
		try{

		download(pimages,gdsid+extName,baseURLDir+prackcode);
		
		
		
		 fname=baseURLDir+prackcode+"/"+gdsid+extName;
		
		
			 File saveFile = new File(fname);
			  BufferedImage image = ImageIO.read(saveFile);  
		       oldwidth = image.getWidth();// 图片宽度  
		       oldheight = image.getHeight();// 图片高度
          }catch(Exception ex){
        	  FileWriter fw = new FileWriter(new File("/var/no5error.txt"),true);
  			fw.write("图片获取错误="+pshoppcode+System.getProperty("line.separator"));
  			fw.flush();
  			fw.close();
        	  ex.printStackTrace();
		}
		String imgurl=fname.replace("/opt", "");
		String imgbig=imgurl;

		String img200="";
		String img400="";
		String img240300="";
		String img200250="";
		String img160="";
		String img120="";
		String img80="";
		String img310="";
		


		//保存宽度为200的图
		if(oldwidth>200){
		if(ImageUtil.resizeImage_sd(fname,"_200",200,200)){
			img200=imgurl.substring(0,imgurl.indexOf("."))+"_200"+extName;
			}
		}
		if(oldwidth>400){
		if(ImageUtil.resizeImage_sd(fname,"_400",400,400)){
			img400=imgurl.substring(0,imgurl.indexOf("."))+"_400"+extName;
			}
		}
		if(oldwidth>310){
		if(ImageUtil.resizeImage_sd(fname,"_310",310,310)){
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
		if(ImageUtil.resizeImage_sd(fname,"_160",160,160)){
			img160=imgurl.substring(0,imgurl.indexOf("."))+"_160"+extName;
			}
		}
		if(oldwidth>120){
		if(ImageUtil.resizeImage_sd(fname,"_120",120,120)){
			img120=imgurl.substring(0,imgurl.indexOf("."))+"_120"+extName;
			}
		}
		if(oldwidth>80){
		if(ImageUtil.resizeImage_sd(fname,"_80",80,80)){
			img80=imgurl.substring(0,imgurl.indexOf("."))+"_80"+extName;
			}
		}
		product.setGdsmst_bigimg(imgbig);
		product.setGdsmst_fzimg("");
		product.setGdsmst_imgurl(img200);
		product.setGdsmst_smallimg(img80);
		product.setGdsmst_midimg(img400);
		product.setGdsmst_recimg(img160);
		product.setGdsmst_img310(img310);
		product.setGdsmst_otherimg3(img120);
		product.setGdsmst_img200250(img200250);
		product.setGdsmst_img240300(img240300);	
		}
		}
      }
	    product.setGdsmst_provenance("");    
	    product.setGdsmst_shoprck("");
		product.setGdsmst_stocklinkty(new Long(0));
		if(newflag){
	    product=(Product)Tools.getManager(Product.class).create(product);
		}else{
			Tools.getManager(Product.class).update(product, true);
		}
	    if(newflag&&!Tools.isNull(product.getId()))
	    {
	    	addimgdetail(pimgdetails,prackcode,gdsid);
	    	
		   
	    }
	    if(!Tools.isNull(product.getId())){
	    	//createsku(jsonskusArray,gdsid);
	    }
	 }catch(Exception ex){
		 try{
		    FileWriter fw = new FileWriter(new File("/var/no5error.txt"),true);
			fw.write("创建商品错误="+goods.getString("pshoppcode")+System.getProperty("line.separator"));
			fw.flush();
			fw.close();
		 } catch(Exception ex2){
			 
		 }
		 ex.printStackTrace();
		}
}
public static synchronized void createsku(JSONArray jsonskusArray,String gdsid){
	if(jsonskusArray.size()>0){
		   for (int k= 0; k < jsonskusArray.size(); k++) {
			   JSONObject jsonsku = (JSONObject) jsonskusArray.get(k);
			   
	Sku sku=new Sku();
	sku.setSkumst_createdate(new Date());
    sku.setSkumst_gdsid(gdsid);
    sku.setSkumst_sku1(jsonsku.getString("skuname"));
    sku.setSkumst_stock(new Long(0));
	sku.setSkumst_vstock(new Long(0));
	sku.setSkumst_validflag(new Long(1));
	sku.setSkumst_outid(new Long(jsonsku.getString("skuid")));
	sku.setSkumst_sku2("");
    sku=(Sku)Tools.getManager(Sku.class).create(sku);
		 }
	 }
}
public static synchronized void addimgdetail(String pimgdtails,String prackcode,String gdsid){
	if(Tools.isNull(pimgdtails))return;
		
		pimgdtails=pimgdtails.replace("，", ",");
	   if(pimgdtails.indexOf(",")>=0){
		String[] pimgarr= pimgdtails.split(",");
	 
		for(int i=0;i<pimgarr.length;i++){
			
		 String pimages= pimgarr[i];
		 String extName = "";
			if (pimages.lastIndexOf(".") >= 0) {
			    extName = pimages.substring(pimages.lastIndexOf("."));
			
			/*检查文件类型*/
			if (("," + fileExt.toLowerCase() + ",").indexOf("," + extName.substring(1).toLowerCase() + ",")>=0){
		String fname="";
		int oldwidth = 0;
		int oldheight=0;
		try{
			download(pimages,gdsid+"_dt"+i+extName,baseURLDir+prackcode+"/detail");
			 fname=baseURLDir+prackcode+"/detail/"+gdsid+"_dt"+i+extName;
	 	
			 File saveFile = new File(fname);
			  BufferedImage image = ImageIO.read(saveFile);  
		       oldwidth = image.getWidth();// 图片宽度  
		       oldheight = image.getHeight();// 图片高度
          }catch(Exception ex){
        	  ex.printStackTrace();
		}

		String imgurl=fname.replace("/opt", "");
		
	String img400="";
	String img60="";
	//保存宽度为400的图
	if(oldwidth>400){
	if(ImageUtil.resizeImage(fname,"_400",400,400)){
		img400=imgurl.substring(0,imgurl.indexOf("."))+"_400"+extName;
		}
	}

	if(oldwidth>60){
	if(ImageUtil.resizeImage(fname,"_60",60,60)){
		img60=imgurl.substring(0,imgurl.indexOf("."))+"_60"+extName;
		}
	}

	//写入数据库
	    GdsImgDtl gds=new GdsImgDtl();
		gds.setGdsimgdtl_gdsid(gdsid);
		gds.setGdsimgdtl_bigimg(imgurl);
		gds.setGdsimgdtl_midimg(img400);
		gds.setGdsimgdtl_smallimg(img60);
		gds.setGdsimgdtl_sort(new Long(i));
		gds.setGdsimgdtl_createdate(new Date());
	   Tools.getManager(GdsImgDtl.class).create(gds);
	
  }
}
 }
}else{
	 String pimages= pimgdtails;
	 String extName = "";
		if (pimages.lastIndexOf(".") >= 0) {
		    extName = pimages.substring(pimages.lastIndexOf("."));
		
		/*检查文件类型*/
		if (("," + fileExt.toLowerCase() + ",").indexOf("," + extName.substring(1).toLowerCase() + ",")>=0){
	String fname="";
	int oldwidth = 0;
	int oldheight=0;
	try{
	download(pimages,gdsid+"_dt0"+extName,baseURLDir+prackcode+"/detail/");
	 fname=baseURLDir+prackcode+"/detail/"+gdsid+"_dt0"+extName;
 	
		 File saveFile = new File(fname);
		  BufferedImage image = ImageIO.read(saveFile);  
	       oldwidth = image.getWidth();// 图片宽度  
	       oldheight = image.getHeight();// 图片高度
      }catch(Exception ex){
		ex.printStackTrace();
	}

	String imgurl=fname.replace("/opt", "");
	
String img400="";
String img60="";
//保存宽度为400的图
if(oldwidth>400){
if(ImageUtil.resizeImage(fname,"_400",400,400)){
	img400=imgurl.substring(0,imgurl.indexOf("."))+"_400"+extName;
	}
}

if(oldwidth>60){
if(ImageUtil.resizeImage(fname,"_60",60,60)){
	img60=imgurl.substring(0,imgurl.indexOf("."))+"_60"+extName;
	}
}

//写入数据库
    GdsImgDtl gds=new GdsImgDtl();
	gds.setGdsimgdtl_gdsid(gdsid);
	gds.setGdsimgdtl_bigimg(imgurl);
	gds.setGdsimgdtl_midimg(img400);
	gds.setGdsimgdtl_smallimg(img60);
	gds.setGdsimgdtl_sort(new Long(0));
	gds.setGdsimgdtl_createdate(new Date());
   Tools.getManager(GdsImgDtl.class).create(gds);

}
}
	
}
}
%>
<%/*
if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){
String all=request.getParameter("all");
if(!Tools.isNull(all)){
	getgoodlist(1,false);
	getgoodsvalid();
}
if(Tools.isNull(all)){
getincrement(1,false);

}
}*/
%>