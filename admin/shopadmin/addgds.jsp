<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkrgt.jsp"%>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern"%>
<%!
static ArrayList<GdsCutImg> getByGdsid(String gdsid){
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
static String getPid(String rackcode){
	String gdsid="";
	ArrayList<Product> list=ProductHelper. getMaxgdsid(rackcode);
	if(list!=null && list.size()>0){
		Product p=list.get(0);
		int maxid=Tools.parseInt(p.getId().substring(3, p.getId().length()));
		gdsid=p.getId().substring(0,3)+new DecimalFormat("00000").format(maxid+1);
		
	}
	return gdsid;
}
%>
<%
String shopcode="03050801";
String gdsid="";
if ("post".equals(request.getMethod().toLowerCase())) {
	String gdsname="";//商品名称
	String rackcode="";//商品分类编号
	String brandcode="";//品牌编号
	String brandname="";//品牌名称
	String ggid="";//规格编号
	String stdothervalues="";//其他规格
	String jj="";//简介
	String shopgdscode="";//商户商品编码
	String buylimit="0";//最大购买数量
	String stock="0";//商品库存
	String vituralstock="";//虚拟库存
	String tm="";//商品条码
	String skuname1="";//商品SKU名称1
	String yxq="";//有效期
	String sex="2";
	
	float saleprice=0f;
	float memberprice=0f;
	float vipprice=0f;

	String tjdate="";
	String detail="";

	String gdsmst_ifhavegds="";
	String flag="";//上下架标志
	String gift="";//单品赠品
	String shsm="";//生产商/售后服务说明
	String key="";//关键字
	String gdsmst_stdid="";
	String req_stdvalue1="";
	String req_stdvalue2="";
	String req_stdvalue3="";
	String req_stdvalue4="";
	String req_stdvalue5="";
	String req_stdvalue6="";
	String req_stdvalue7="";
	String req_stdvalue8=""; 
	
	String gdsmst_imgurl="";//200*200图片地址
	String gdsmst_smallimg="";//80*80图片地址
	String gdsmst_bigimg="";//超大图地址，尺寸不定
	String gdsmst_midimg="";//400*400商品图片
	String gdsmst_fzimg="";//160*200商品图片
	String gdsmst_img200250="";
	String gdsmst_img240300="";
	String gdsmst_recimg="";//160*160商品图
	boolean isimg=false;//是否上传新图片
	boolean isimg2=false;//是否上传新图片
	String gdscutimg_160="";
	String gdscutimg_300="";	
	String gdscutimg_bigimg="";	
	
	 SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
	DiskFileItemFactory  factory = new DiskFileItemFactory();
	factory.setSizeThreshold(1024 * 4);
	   ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(1024 * 1024 * 10);
		String uploadFileName="";
		String fimgname="";
	   try {
		   List items = upload.parseRequest(request);
		    Iterator it = items.iterator();
		    String ext = ".jpg";
		    while(it.hasNext()){
     FileItem fitem = (FileItem)it.next();
     if(!fitem.isFormField()){
    	 String uploadname=fitem.getFieldName();
      if(!Tools.isNull(uploadname)){
    	 
    		  String fn = fitem.getName();
				if (fn == null || fn.equals(""))
					continue;//如果文件框未选中文件
					if("loadFile".equals(uploadname)){
						if (fn.indexOf(".") > -1) {
							ext = fn.substring(fn.lastIndexOf(".")).toLowerCase();
							isimg=true;
						}
					}
					if("loadFile2".equals(uploadname)){
						if (fn.indexOf(".") > -1) {
							ext = fn.substring(fn.lastIndexOf(".")).toLowerCase();
							isimg2=true;
						}
					}
				if((!ext.equals(".jpg")) && (!ext.equals(".jepg")) && (!ext.equals(".gif")) && (!ext.equals(".png")) && (!ext.equals(".bmp")) ){
					Tools.outJs(out,"请上传图片格式的文件","back");
					return;
				}
				Calendar ca = Calendar.getInstance();
			    int year = ca.get(Calendar.YEAR);//获取年份
			    int month=ca.get(Calendar.MONTH)+1;//获取月份
				String uploadPath = Const.PROJECT_PATH + "upload/shopadmin/gdsimg/"+year+"/"+month+"/";
				String fileName = Tools.getDBDate()+ext;//文件名
				//String photoName = "http://d1.com.cn/upload/"+ fileName;
				 fimgname="/upload/shopadmin/gdsimg/"+year+"/"+month+"/"+fileName;
				
				 uploadFileName = uploadPath + fileName.substring(fileName.lastIndexOf("/") + 1);
				 File file=new File(uploadPath);
				 if (!file.exists()) {//判断路径是否存在
					// File file2=new File(file.getParent());
					 file.mkdirs();
				 }
				 //创建一个待写文件 
				File uploadedFile = new File(uploadFileName);
				//写入 
				//out.print(uploadFileName);
				fitem.write(uploadedFile);
				//out.print("<script>alert('上传成功！')</script>");
				gdsmst_bigimg=fimgname;
      }
     }
     if(fitem.isFormField()){//如果是表单域
    	 String fname=fitem.getFieldName();
	
     if("txtgdsname".equals(fname)){
    	 gdsname=fitem.getString("utf-8");
     }
  
     if("sgdsflag".equals(fname)){
    	 flag=fitem.getString("utf-8");
     }
     if("gdsmst_giftselecttype".equals(fname)){
    	 gift=fitem.getString("utf-8");
     }
     if("txtshhm".equals(fname)){
    	 shsm=fitem.getString("utf-8");
     }
     if("rackcode".equals(fname))  rackcode=fitem.getString("utf-8");
     if("gdsmst_ifhavegds".equals(fname))  gdsmst_ifhavegds=fitem.getString("utf-8");
    
     if("gdsid".equals(fname))  gdsid=fitem.getString("utf-8");
     if("txtkey".equals(fname))  key=fitem.getString("utf-8");
     if("req_stdvalue1".equals(fname))  req_stdvalue1=fitem.getString("utf-8");
     if("req_stdvalue2".equals(fname))  req_stdvalue2=fitem.getString("utf-8");
     if("req_stdvalue3".equals(fname))  req_stdvalue3=fitem.getString("utf-8");
     if("req_stdvalue4".equals(fname))  req_stdvalue4=fitem.getString("utf-8");
     if("req_stdvalue5".equals(fname))  req_stdvalue5=fitem.getString("utf-8");
     if("req_stdvalue6".equals(fname))  req_stdvalue6=fitem.getString("utf-8");
     if("req_stdvalue7".equals(fname))  req_stdvalue7=fitem.getString("utf-8");
     if("req_stdvalue8".equals(fname))  req_stdvalue8=fitem.getString("utf-8");
     
     if("brandname".equals(fname))  brandcode=fitem.getString("utf-8");
     if("ggid".equals(fname))  ggid=fitem.getString("utf-8");
     //if("brandname".equals(fname))  brandname=fitem.getString("utf-8");
     if("stdothervalues".equals(fname))  stdothervalues=fitem.getString("utf-8");
     if("jj".equals(fname))  jj=fitem.getString("utf-8");
     if("shopgdscode".equals(fname))  shopgdscode=fitem.getString("utf-8");
     if("buylimit".equals(fname))  buylimit=fitem.getString("utf-8");
     if("stock".equals(fname))  stock=fitem.getString("utf-8");
     if("vituralstock".equals(fname))  vituralstock=fitem.getString("utf-8");
     if("tm".equals(fname))  tm=fitem.getString("utf-8");
     if("skuname1".equals(fname))  skuname1=fitem.getString("utf-8");
     if("yxq".equals(fname))  yxq=fitem.getString("utf-8");
     if("tjdate".equals(fname))  tjdate=fitem.getString("utf-8");
     if("newmemo".equals(fname))  detail=fitem.getString("utf-8");
     if("saleprice".equals(fname))  saleprice=Float.parseFloat(fitem.getString("utf-8"));
     if("memberprice".equals(fname))  memberprice=Float.parseFloat(fitem.getString("utf-8"));
     if("vipprice".equals(fname))  vipprice=Float.parseFloat(fitem.getString("utf-8"));
     if("gdssex".equals(fname))  sex=fitem.getString("utf-8");
     if("standid".equals(fname))  gdsmst_stdid=fitem.getString("utf-8");
     
     }

	if(isimg){
		if(ImageUtil.resizeImage(uploadFileName,"_200",200,200)){
			gdsmst_imgurl=fimgname.substring(0,fimgname.indexOf("."))+"_200"+ext;
		}
		if(ImageUtil.resizeImage(uploadFileName,"_400",400,400)){
			gdsmst_midimg=fimgname.substring(0,fimgname.indexOf("."))+"_400"+ext;
		}
		if(ImageUtil.resizeImage(uploadFileName,"_80",80,80)){
			gdsmst_smallimg=fimgname.substring(0,fimgname.indexOf("."))+"_80"+ext;
		}
		if(ImageUtil.resizeImage(uploadFileName,"_160",160,160)){
			gdsmst_recimg=fimgname.substring(0,fimgname.indexOf("."))+"_160"+ext;
		}
		if(ImageUtil.resizeImage(uploadFileName,"_160200",160,200)){
			gdsmst_fzimg=fimgname.substring(0,fimgname.indexOf("."))+"_160200"+ext;
		}
		if(ImageUtil.resizeImage(uploadFileName,"_200250",200,250)){
			gdsmst_img200250=fimgname.substring(0,fimgname.indexOf("."))+"_200250"+ext;
		}
		if(ImageUtil.resizeImage(uploadFileName,"_240300",240,300)){
			gdsmst_img240300=fimgname.substring(0,fimgname.indexOf("."))+"_240300"+ext;
		}
	}
	if(isimg2){
		if(ImageUtil.resizeImage(uploadFileName,"_160",160,160)){
			gdsmst_recimg=fimgname.substring(0,fimgname.indexOf("."))+"_160"+ext;
		}
		if(ImageUtil.resizeImage(uploadFileName,"_300",300,300)){
			gdscutimg_300=fimgname.substring(0,fimgname.indexOf("."))+"_300"+ext;
		}
	}

	
			//out.print(detail);
	   }
	   }
    catch (Exception e) {
		   out.print("fail");
	    e.printStackTrace();
	    return;
	   }


if(!Tools.isNull(gdsname)){
	Brand brand=BrandHelper.getBrandByCode(brandcode);
	if(brand!=null){
		brandname=brand.getBrand_name().trim();
	}
	Product product=null;
	boolean isadd=false;
	if(!Tools.isNull(gdsid)){
		product=ProductHelper.getById(gdsid);
	}
	if(product==null){
		isadd=true;
		product=new Product();
		product.setGdsmst_shopcode(shopcode);//商户编码
		gdsid=getPid(rackcode.substring(0,3));
		//out.print(rackcode+">>>"+gdsid);
		
		product.setId(gdsid);//商品编码
		System.out.println(gdsid);
		product.setGdsmst_createdate(new Date());
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
		product.setGdsmst_srcstatus(new Long(0));
		product.setGdsmst_oldvipprice(0f);
		product.setGdsmst_oldmemberprice(0f);
		product.setGdsmst_downflag(new Long(1));
		product.setGdsmst_sendcount(new Long(0));
		product.setGdsmst_salecount(new Long(0));
		product.setGdsmst_discounflag(new Long(1));
		product.setGdsmst_enddateend(format.parse("2999-01-01"));
		product.setGdsmst_beginstart(new Date());
		product.setGdsmst_presellflag(new Long(0));
		product.setGdsmst_specialflag(new Long(0));
		product.setGdsmst_validflag(new Long(0));
		product.setGdsmst_refcount(new Long(0));
		product.setGdsmst_hitcount(new Long(0));
		product.setGdsmst_gdsename("");
		product.setGdsmst_paymethod("-1");
		product.setGdsmst_sndmethod("");
		product.setGdsmst_provide("");
	}
	System.out.println(gdsname);
	product.setGdsmst_gdsname(gdsname);
	
	if(Tools.isNull(flag)){
		
		flag="0";
	}
	product.setGdsmst_specialflag(new Long(flag));
	if(Tools.isNull(gift)){
		gift="0";
	}
	product.setGdsmst_giftselecttype(new Long(gift));
	if(Tools.isNull(gdsmst_stdid)){
		gdsmst_stdid="0";
	}
	product.setGdsmst_stdid(gdsmst_stdid);
	if(Tools.isNull(gdsmst_ifhavegds)){
		gdsmst_ifhavegds="1";
	}
	product.setGdsmst_ifhavegds(new Long(gdsmst_ifhavegds));
	product.setGdsmst_manufacture(shsm);
	System.out.println(shsm);	
	product.setGdsmst_keyword(key);
	System.out.println(key);	
	product.setGdsmst_brand(brandcode);
	System.out.println(brandcode);	
	product.setGdsmst_brandname(brandname);
	System.out.println(brandname);	
	product.setGdsmst_briefintrduce(jj);
	System.out.println(jj);	
	product.setGdsmst_barcode(tm);
	System.out.println(tm);	
	if(Tools.isNull(buylimit)){
		buylimit="0";
	}
	product.setGdsmst_buylimit(new Long(buylimit));
	product.setGdsmst_detailintruduce(detail);	
	product.setGdsmst_memberprice(memberprice);
	product.setGdsmst_saleprice(saleprice);
	product.setGdsmst_vipprice(vipprice);
	
	product.setGdsmst_rackcode(rackcode);
	product.setGdsmst_shopgoodscode(shopgdscode);
	System.out.println(shopgdscode);	
	product.setGdsmst_skuname1(skuname1);
	System.out.println(skuname1);	
	if(Tools.isNull(stock)){
		stock="0";
	}
	product.setGdsmst_stock(new Long(stock));
	if(Tools.isNull(vituralstock)){
		vituralstock="5";
	}
	product.setGdsmst_virtualstock(new Long(vituralstock));
	product.setGdsmst_stdvalue1(req_stdvalue1);
	product.setGdsmst_stdvalue2(req_stdvalue2);
	product.setGdsmst_stdvalue3(req_stdvalue3);
	product.setGdsmst_stdvalue4(req_stdvalue4);
	product.setGdsmst_stdvalue5(req_stdvalue5);
	product.setGdsmst_stdvalue6(req_stdvalue6);
	product.setGdsmst_stdvalue7(req_stdvalue7);
	product.setGdsmst_stdvalue8(req_stdvalue8);
	product.setGdsmst_updatedate(new Date());
	if(Tools.isNull(sex)){
		sex="2";
	}
	product.setGdsmst_sex(new Long(sex));	
	if(isimg){
		
		product.setGdsmst_bigimg(gdsmst_bigimg);
		product.setGdsmst_fzimg(gdsmst_fzimg);
		product.setGdsmst_imgurl(gdsmst_imgurl);
		product.setGdsmst_smallimg(gdsmst_smallimg);
		product.setGdsmst_bigimg(gdsmst_bigimg);
		product.setGdsmst_midimg(gdsmst_midimg);
		product.setGdsmst_recimg(gdsmst_recimg);
		product.setGdsmst_img200250(gdsmst_img200250);
		product.setGdsmst_img240300(gdsmst_img240300);
		
	}
	
	if(isadd){
		product=(Product)Tools.getManager(Product.class).create(product);
	}else{
		 Tools.getManager(Product.class).clearListCache(product);
			if(Tools.getManager(Product.class).update(product, true)){
				
			}
	}
	if(isadd){
		product=(Product)Tools.getManager(Product.class).create(product);
	}else{
		 Tools.getManager(Product.class).clearListCache(product);
			if(Tools.getManager(Product.class).update(product, true)){
				
			}
	}
	if(product!=null && isimg2){
		ArrayList<GdsCutImg> list=getByGdsid(product.getId());
		GdsCutImg cutimg=null;
		if(list!=null && list.size()>0){
			cutimg=list.get(0);
			cutimg.setGdscutimg_160(gdsmst_recimg);
			cutimg.setGdscutimg_300(gdscutimg_300);
			cutimg.setGdscutimg_bigimg(gdsmst_bigimg);
			
			Tools.getManager(GdsCutImg.class).clearOmCache(cutimg.getId());
			Tools.getManager(GdsCutImg.class).update(cutimg, true);
			
		}else{
			cutimg=new GdsCutImg();
			cutimg.setGdscutimg_160(gdsmst_recimg);
			cutimg.setGdscutimg_300(gdscutimg_300);
			cutimg.setGdscutimg_bigimg(gdsmst_bigimg);
			cutimg.setGdsmst_gdsid(product.getId());
			cutimg=(GdsCutImg)Tools.getManager(GdsCutImg.class).create(cutimg);
		}
	}
		out.print("成功");
}else{
//	Tools.outJs(out, "商品名称不能为空！", "back");
}
}
%>