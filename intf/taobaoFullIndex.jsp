<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!

static List getAllProduct(){
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
	//clist.add(Restrictions.eq("id", "02003160"));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("gdsmst_createdate"));
	return ProductHelper.manager.getList(clist, listOrder, 0, 22);
}

static String getSkuName(String productid,String strSkuName,int skuid){
	StringBuffer sb=new StringBuffer();
	ArrayList<Sku> list=SkuHelper.getSkuListViaProductId(productid);
	if(!Tools.isNull(strSkuName) && ! "null".equals(strSkuName.toLowerCase())){
		sb.append(strSkuName);
         sb.append(":");
		if(list!=null && list.size()>0){
			
	         for(int i=0;i<list.size();i++){
	        	 Sku sku=list.get(i);
	        	 if(i==1){
	        		 if(skuid==1){
	        			 sb.append(sku.getSkumst_sku1()) ;
	        		 }else{
	        			 sb.append(sku.getSkumst_sku2()) ;
	        		 }
	        		
	        	 }else{
	        		 sb.append(",");
	        		 if(skuid==1){
	        			 sb.append(sku.getSkumst_sku1()) ;
	        		 }else{
	        			 sb.append(sku.getSkumst_sku2()) ;
	        		 }
	        	 }
	         }
	         sb.append(";");
		}
	}
	return sb.toString();
}
private static String getkeylen(String key,String sp){
	if(!Tools.isNull(key)){
		String[]  keys=key.split(sp);
		
	    String keystr="";
	    String keystrold="";
	    if(keys!=null&&keys.length>0){
	    for(int i=0;i<keys.length;i++ ){
	    	if(!Tools.isNull(keys[i]))keystr=keystr+" "+keys[i].trim();
	 	   if(keystr.length()-1>=20)
	 		   {
	 		   keystr=keystrold;
	 		   break;
	 		   }
	 		   keystrold=keystr;
	    }
		return keystr.substring(1);
	    }else{
	    	return "";
	    }
		}
	return "";
}
private static void getwgitem(Product p,BufferedWriter  wgitembw,int outid,int comlen,int comlevel){
	try { 
	String gdsid=p.getId();
	wgitembw.write("<item>");
	//商品信息文件示例
	 wgitembw.write("<seller_id>D1优尚官网</seller_id>");
	//<!--商家名称-->
	 wgitembw.write("<outer_id>"+outid+"</outer_id>");
	//<!--商家商品索引号-->
	 wgitembw.write("<title>"+Tools.clearHTML(p.getGdsmst_gdsname()).replace("&", "")+"</title>");
	//<!--商品标题-->
	 wgitembw.write("<product_id>"+p.getId()+"</product_id>");
	//<!--货号-->
	 wgitembw.write("<available>1</available>");
	//<!--0 代表缺货，1 代表有货-->
	 DecimalFormat df = new DecimalFormat("0.00");
	 float mprice=p.getGdsmst_memberprice().floatValue();
	  boolean isms=CartHelper.getmsflag(p);
	 wgitembw.write("<price>"+df.format(mprice)+"</price>");
	//<!--商品价格，格式：5.00；单位：元；精确到：分；取值范围：0-1 千万-->
	  if(isms){
		  mprice=p.getGdsmst_msprice().floatValue();
	 wgitembw.write("<discount>");
	 wgitembw.write("<dprice>"+df.format(mprice)+"</dprice>");
	//<!--折后价, 商品打折后的价格。-->
	 wgitembw.write("<ddesc>本次闪购特价仅几天,机不可失，失不再来");
	 wgitembw.write("</ddesc>");
	//<!--打折信息描述-->
	 wgitembw.write("</discount>");
	  }
	  String strBriefIntroduce = Tools.clearHTML(p.getGdsmst_briefintrduce().trim()).replace("&", "");
      if(strBriefIntroduce.length()>500){
      	 strBriefIntroduce = Tools.substring(strBriefIntroduce, 500);
      }
	 wgitembw.write("<desc>"+strBriefIntroduce+"</desc>");
	//<!--商品简单描述 -->
	if(p.getGdsmst_shopcode().equals("00000000")){
		 wgitembw.write("<selforopen>0</selforopen>");
	}else{
		ShpMst sh=(ShpMst)Tools.getManager(ShpMst.class).get(p.getGdsmst_shopcode());
	 wgitembw.write("<selforopen>1</selforopen>");
	 wgitembw.write("<business_name>"+sh.getShpmst_shopname()+"</business_name>");
	}
	//注：此字段只提供平台商家填写（平台商家必填），该商品所属具体第三方商家名称；
	 wgitembw.write("<brand>"+p.getGdsmst_brandname()+"</brand>");
	//<!--商品品牌-->
	String rackcode=p.getGdsmst_rackcode();
	Directory dir = DirectoryHelper.getById(rackcode);
	String rackname=dir.getRakmst_rackname();
	String tags=rackname;
	tags=tags+"/正品 官网";
	String key=p.getGdsmst_keyword();
	key=getkeylen(key," ");
	if(!Tools.isNull(key))tags=tags+"/"+key;
	String stdstr=p.getGdsmst_stdvalue1()+","+p.getGdsmst_stdvalue2()+","+p.getGdsmst_stdvalue3()+","+p.getGdsmst_stdvalue4();
	 stdstr=getkeylen(stdstr,",");
	if(!Tools.isNull(stdstr))tags=tags+"/"+stdstr;
	stdstr=p.getGdsmst_stdvalue5()+","+p.getGdsmst_stdvalue6()+","+p.getGdsmst_stdvalue7();
	stdstr=getkeylen(stdstr,",");
	if(!Tools.isNull(stdstr))tags=tags+"/"+stdstr;
	 wgitembw.write("<tags>"+tags+"</tags>");
	//<!--商品 Tag 标签，有利于搜索，不超过 5 个标签,每个之间用/隔开-->
	 String img = (p != null ? p.getGdsmst_bigimg() : null);
		if(!Tools.isNull(img)){
		if(img.startsWith("/shopimg/gdsimg")){
			img = "http://images1.d1.com.cn"+img.trim();
		}else{
			img = "http://images.d1.com.cn"+img.trim();
		}
		}
	 wgitembw.write("<image>"+img+"</image>");
	//<!--商品主图地址，图片类型：jpg、jpeg、png，不支持 gif；尽量是高清近景大	图-->
	 //wgitembw.write("<detail_images>");
	// wgitembw.write("<img>http://www.yhd.com/pic/0001.jpg</img>");
	//wgitembw.write("</detail_images>");
	//<!--详情页商品细节图片绝对地址，图片类型：jpg、jpeg、png，不支持 gif；	-->
	 wgitembw.write("<href>http://www.d1.com.cn/product/"+gdsid+"</href>");
	//<!--商品链接绝对地址-->
	 String wapurl="http://m.d1.cn/wap/product.html?id="+gdsid;
	 wgitembw.write("<wireless_link>"+wapurl+"</wireless_link>");
	 wgitembw.write("<hd_wireless_link>"+wapurl+"</hd_wireless_link>");
	 wgitembw.write("<sale_volume>"+p.getGdsmst_salecount()+"</sale_volume>");
	//<!--销量数字，精确到整数-->
	 wgitembw.write("<comment_count>"+comlen+"</comment_count>");
	//<!--评论数量，该商品的总评论数-->
	 wgitembw.write("<saled_score>"+Tools.getDouble(comlevel*1.0/2, 1)+"</saled_score>");
	 
	 String brumb="";
	 int size = rackcode.length();
		if(size >= 3){
			for (int i = 3; i <= size; i = i + 3){
				Directory directory = DirectoryHelper.getById(rackcode.substring(0,i));
				if(directory == null) continue;
				brumb +="/"+ directory.getRakmst_rackname();
			}
		}
		brumb=brumb.substring(1);
	wgitembw.write("<bread_crumb>"+brumb+"</bread_crumb>");
	//<!--面包屑。格式：生鲜食品/新鲜水果，用/符号隔开。即：此商品通过你网站访
	//问的最深路径。此事例指此商品是生鲜食品>新鲜水果下的一个产品。除首页网站的“你的位
	//置”中相关信息-->
	 wgitembw.write("</item>");
	}catch (Exception e) {  
            e.printStackTrace();   
        } 
}
%><%
String filepath = Const.PROJECT_PATH + "taobao/FullIndex.xml";
String SellerCatsFile="http://www.d1.com.cn/taobao/SellerCats.xml";
String FullIndexItem="http://www.d1.com.cn/taobao/Item_1/";
String filepath2 = Const.PROJECT_PATH + "taobao/Item_1/";
File file=new File(filepath);
if (file.exists()) {//判断文件目录的存在

//如果存在，先删除，再创建 
boolean d = file.delete();
     if(d){
    	 file.createNewFile();//创建文件  
     }

}
 else {
  File file2=new File(file.getParent());

    file2.mkdirs();
    if(file.isDirectory()){      

    	 if( file.delete()){
        	 file.createNewFile();//创建文件  
         } 

      }else{      

       file.createNewFile();//创建文件   
      }

}
File file2=new File(filepath2);
if (file2.exists()) {
	  String[] tempList = file2.list();
      File temp = null;
      for (int i = 0; i < tempList.length; i++) {
         if (filepath2.endsWith(File.separator)) {
            temp = new File(filepath2 + tempList[i]);
         } else {
             temp = new File(filepath2 + File.separator + tempList[i]);
         }
         if (temp.isFile()) {
            temp.delete();
         }
         if (temp.isDirectory()) {
            //delAllFile(filepath2 + "/" + tempList[i]);//先删除文件夹里面的文件
            //delFolder(filepath2 + "/" + tempList[i]);//再删除空文件夹
           
         }
      }
      file2.delete();
      file2.mkdirs();
}else{
	//System.out.print("目录不存在");
	 file2.mkdirs();
}

/*微购*/
String wgfilepath = Const.PROJECT_PATH + "WeiGou/FullIndex.xml";
String wgFullIndexItem="http://www.d1.com.cn/WeiGou/item/";
String wgfilepathitem = Const.PROJECT_PATH + "WeiGou/item/";
/*微购end*/



ProductManager manager = (ProductManager)ProductHelper.manager;
List<Product> list = manager.getTotalProductList();
String ret="1";

if(list==null || list.size()==0){
	list=getAllProduct();
}
if(list!=null && list.size()>0){
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	  if(file.exists()){//判断文件的存在性        
		        BufferedWriter bWriter = null;   
		        try {     
		            bWriter= new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF-8"));   
		            bWriter.write("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
		            bWriter.newLine();
		            bWriter.write("<root>");
		            bWriter.newLine();
		            bWriter.write("<version>1.0</version>");
		            bWriter.newLine();
		            bWriter.write("<modified>");
		            bWriter.write(format.format(new Date()));
		            bWriter.write("</modified>");
		            bWriter.newLine();
		            bWriter.write("<seller_id>d1优尚网官网</seller_id>");
		            bWriter.newLine();
		            bWriter.write("<cat_url>");
		            bWriter.write(SellerCatsFile);
		            bWriter.write("</cat_url>");
		            bWriter.newLine();
		            bWriter.write("<dir>");
		            bWriter.write(FullIndexItem);
		            bWriter.write("</dir>");
		            bWriter.newLine();
		            bWriter.write("<item_ids>");
		            bWriter.newLine();
		            
		            
		            
		            
		            
		            
		             int num=0;
		             int wgitem=1;
		             int allcount=list.size();
		             BufferedWriter  wgitembw=null;
		             int comlen=0;
		             int comlevel=5;
		            for(Product r:list){
		            	 //System.out.println("---------------"+r.getId()+"---------------");
		            	  /*微购*/
		            	 comlen=CommentHelper.getCommentLength(r.getId());
		            	 comlevel=CommentHelper.getLevelView(r.getId());
		            	 if(comlevel==0)comlevel=5;
		            	// if(r.getGdsmst_rackcode().startsWith("014")||r.getGdsmst_rackcode().startsWith("015")){
				         try {   
				        	 if(num==0||num%1000==0){
				        	
				        		 String wgitempath=wgfilepathitem+wgitem+".xml";
				        		 
						         File itemfile=new File(wgitempath);
						         if(itemfile.exists()){
						        	 itemfile.delete(); 
						        	 itemfile.createNewFile();
						         }else{
						        	 itemfile.createNewFile();
						         }
						         wgitembw= new BufferedWriter(new OutputStreamWriter(new FileOutputStream(itemfile), "UTF-8"));
						         wgitembw.write("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
						         wgitembw.newLine();
						         wgitembw.write("<items>");
				        	 }
				        	     getwgitem(r,wgitembw,wgitem,comlen,comlevel);
				             	
				        	 if((num+1)%1000==0||(num+1==allcount)){
				        		 wgitembw.write("</items>");
				        		 wgitem++;
				        	 }
				        	 wgitembw.flush();
				         }
				         catch (Exception e) {  
				        	 ret="-1";
					            e.printStackTrace();   
					        }  finally {  
					        	if((num+1)%1000==0||(num+1==allcount)){
					
					        	wgitembw.close();
					        	}
						        }   
				         num++;
		            	 //}
				       
			            /*微购end*/

		            	 bWriter.write("<outer_id action=\"upload\">");
				         bWriter.write(r.getId().trim());
				         bWriter.write("</outer_id>");
				         bWriter.newLine();
				         
				         String itempath=filepath2+r.getId().trim()+".xml";
				         File itemfile=new File(itempath);
				         if(itemfile.exists()){
				        	 itemfile.delete(); 
				        	 itemfile.createNewFile();
				         }else{
				        	 itemfile.createNewFile();
				         }
				         BufferedWriter  bw=null;
				         try {   
				           bw= new BufferedWriter(new OutputStreamWriter(new FileOutputStream(itemfile), "UTF-8"));
					         bw.write("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
					         bw.newLine();
					         bw.write("<item>");
					         bw.newLine();
					         bw.write("<seller_id>d1优尚网官网</seller_id>");
				            bw.newLine();
				            bw.write("<outer_id>");
				            bw.write(r.getId().trim());
				            bw.write("</outer_id>");
				            bw.newLine();
				            bw.write("<title>");
				            bw.write(Tools.clearHTML(r.getGdsmst_gdsname()).replace("&", ""));
				            bw.write("</title>");
				            bw.newLine();
				            bw.write("<product_id>");
				            bw.write(r.getId().trim());
				            bw.write("</product_id>");
				            bw.newLine();
				           DateFormat format2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				            Date DiscountEndDate=r.getGdsmst_discountenddate();
				          long endtime=Tools. parseJsDate(format2.format(DiscountEndDate));
				          double fltOldMemberPrice=Tools.getDouble(r.getGdsmst_oldmemberprice().doubleValue(), 2);//折后价
				        	double fltDRate=0d;//打折率
				        	double fltPrice=Tools.getDouble(r.getGdsmst_memberprice().doubleValue(), 2);;
				        	double price=0;
				        	String enumPriceType="0";
				          if(endtime>System.currentTimeMillis() && endtime<(System.currentTimeMillis()+30*24*3600*1000l)){
				        	  //一口价（fixed 默认）、团购（group）、打折（discount）

				        	if (fltOldMemberPrice != 0) {
			                        fltDRate = fltPrice / fltOldMemberPrice;//打折率
			                        fltDRate= Tools.getDouble(fltDRate,2);
			                       
			                        if (fltDRate > 0 && fltDRate < 1)
			                        {
			                            enumPriceType = "1";
			                        }
			                    }
				          }
				        	if(enumPriceType.equals("0")){
				        		price=fltPrice;
				        		 bw.write("<type>fixed</type>");
				        	}else if(enumPriceType.equals("1")){
				        		price=fltOldMemberPrice;
				        		 bw.write("<type>discount</type>");
				        	}
				        	 bw.newLine();
				        	 if(r.getGdsmst_ifhavegds().intValue()==0){
				        		 bw.write("<available>1</available >");
				        	 }else{
				        		 bw.write("<available>0</available >");
				        	 }
				        	 bw.newLine();
				        	// bw.write("<price_unit>RMB</price_unit>");
				        	// bw.newLine();
				        	   bw.write("<price>");
				        	   DecimalFormat df = new DecimalFormat("0.00");
					            bw.write(df.format(price));
					            bw.write("</price>");
					            bw.newLine();
					            if(enumPriceType.equals("1")){//折扣
					            	 bw.write("<discount>");
						            Date s=new Date(endtime-29*24*3600*1000l);
						            DateFormat f=new SimpleDateFormat("yyyy-MM-dd HH:mm");
						            bw.write("<start>");
						            bw.write(f.format(s));
						            bw.write("</start>");
						            bw.newLine();
						            bw.write("<end>");
						            bw.write(f.format(DiscountEndDate));
						            bw.write("</end>");
						            bw.newLine();
						            bw.write("<dprice>");
						            bw.write(fltPrice+"");
						            bw.write("</dprice>");
						            bw.newLine();
						            bw.write("<drate>");
						            bw.write(fltDRate+"");
						            bw.write("</drate>");
						            bw.newLine();
						            bw.write("<ddesc></ddesc>");
						            bw.newLine();
						            bw.write("</discount>");
					            }
					            String strBriefIntroduce = Tools.clearHTML(r.getGdsmst_briefintrduce().trim()).replace("&", "");
					            if(strBriefIntroduce.length()>1000){
					            	 strBriefIntroduce = Tools.substring(strBriefIntroduce, 1000);
					            }
					            bw.write("<desc>");
					            bw.write(strBriefIntroduce);
					            bw.write("</desc>");
					            bw.newLine();
					            
					            String strBrandName =r.getGdsmst_brandname().trim().replace("&", "");
					            if (strBrandName.length() > 30)
					            {
					                strBrandName = strBrandName.substring(0, 30);
					            }
					            bw.write("<brand>");
					            bw.write(strBrandName);
					            bw.write("</brand>");
					            bw.newLine();
					            
					            String strGdsKeyWord =!Tools.isNull(r.getGdsmst_keyword())?Tools.clearHTML(r.getGdsmst_keyword().trim()).replace("&", ""):"";
					            bw.write("<tags>");
					            bw.write(strGdsKeyWord);
					            bw.write("</tags>");
					            bw.newLine();
					            
					            String strGdsImg=r.getGdsmst_midimg();
					            if(Tools.isNull(strGdsImg))strGdsImg=strGdsImg.trim();
					            if(Tools.isNull(strGdsImg) || "null".equals(strGdsImg.toLowerCase())){
					            	strGdsImg=r.getGdsmst_imgurl();
					            	 if(Tools.isNull(strGdsImg))strGdsImg=strGdsImg.trim();
					            }
					            String strImgExt="";
					            if (!Tools.isNull(strGdsImg)&&strGdsImg.indexOf(".") > -1) {
					            	strImgExt = strGdsImg.substring(strGdsImg.lastIndexOf(".")).toLowerCase();
									if(!strImgExt.equals(".jpg") && !strImgExt.equals(".jpeg") && !strImgExt.equals(".png")){
										String s="<image></image>";
										
										bw.write(s);
										 bw.newLine();
									}else{
										if(!(strGdsImg.indexOf("http:")==0)){
											if(!(strGdsImg.indexOf("\\/")==0)){
												strGdsImg = "/" + strGdsImg;
											}
									
											 if(strGdsImg!=null&&strGdsImg.startsWith("/shopimg/gdsimg")){
												 strGdsImg = "http://images1.d1.com.cn"+strGdsImg;
													}else{
														strGdsImg = "http://images.d1.com.cn"+strGdsImg;
													}
										}
										 bw.write("<image>");
										 bw.write(strGdsImg);
								         bw.write("</image>"); 
								         bw.newLine();
									}
									
								}
					            bw.write("<more_images>");
					            bw.newLine();
					            String strBigImg=r.getGdsmst_midimg();
					            if(!Tools.isNull(strBigImg))strBigImg=strBigImg.trim();
					           if(Tools.isNull(strBigImg) || "null".equals(strBigImg.toLowerCase())){
					            	strBigImg=r.getGdsmst_imgurl();
					            	 if(!Tools.isNull(strBigImg))strBigImg=strBigImg.trim();
					            }
					            if (!Tools.isNull(strBigImg)&&strBigImg.indexOf(".") > 0 ) {
					            	strImgExt = strGdsImg.substring(strGdsImg.lastIndexOf(".")).toLowerCase();
									if(!strImgExt.equals(".jpg") && !strImgExt.equals(".jpeg") && !strImgExt.equals(".png")){
										bw.write("<image></image>");
									}else{
										if(!(strBigImg.indexOf("http:")==0)){
											if(!(strGdsImg.indexOf("\\/")==0)){
												strBigImg = "/" + strBigImg;
											}
						
											 if(strBigImg!=null&&strGdsImg.startsWith("/shopimg/gdsimg")){
												 strGdsImg = "http://images1.d1.com.cn"+strBigImg;
													}else{
														strBigImg = "http://images.d1.com.cn"+strBigImg;
													}}
										 bw.write("<image>");
										 bw.write(strBigImg);
								         bw.write("</image>");  
									}
									 bw.newLine();
								}
					        
					            bw.write("</more_images>");
					            bw.newLine();
					            bw.write("<scids>");
								bw.write(r.getGdsmst_rackcode().trim());
						        bw.write("</scids>");  
					            bw.newLine();
					            bw.write("<post_fee>10.00</post_fee>");
					            bw.newLine();
					            StringBuffer sb=new StringBuffer();
					            
					            String strSkuName1=r.getGdsmst_skuname1();
					            String strSkuName2=r.getGdsmst_skuname2();
					            //System.out.println(getSkuName(r.getGdsmst_gdsid(), strSkuName1, 1));
					           
					            sb.append(getSkuName(r.getId(), strSkuName1, 1));
					            sb.append(getSkuName(r.getId(), strSkuName2, 2));
					            bw.write("<props>");
								bw.write(sb.toString());
						        bw.write("</props>");  
					            bw.newLine();
					            
					            bw.write("<gender>");
					            if(r.getGdsmst_sex()!=null){
									bw.write(r.getGdsmst_sex().toString());
						            }else{
						            	bw.write("1");
						            }
				
						        bw.write("</gender>");  
					            bw.newLine();
					            //服装
					            if(r.getGdsmst_rackcode().startsWith("02") || r.getGdsmst_rackcode().startsWith("03")){
					            	  bw.write("<clothing>");
					            	  //鞋。衣服
						            if(r.getGdsmst_rackcode().startsWith("020") || r.getGdsmst_rackcode().startsWith("030") ||r.getGdsmst_rackcode().startsWith("021") || r.getGdsmst_rackcode().startsWith("031")){
						            	 bw.write("<size>");
						            	 ArrayList<Sku> skulist=SkuHelper.getSkuListViaProductId(r.getId());
						            	 String s="";
						            	 if(skulist!=null && skulist.size()>0){
						            		 for(Sku sku:skulist){
						            			 s+="/"+sku.getSkumst_sku1().trim();
						            		 }
						            		 s=s.substring(1,s.length());
						            	 }
						            	 bw.write(s);
						            	 bw.write("</size>");
						            	 bw.newLine();
						            	 if(r.getGdsmst_rackcode().startsWith("020") || r.getGdsmst_rackcode().startsWith("030")){
						            		 bw.write("<color>");
							            	 bw.write(r.getGdsmst_stdvalue2());
							            	 bw.write("</color>");
							            	 bw.newLine();
						            	 }
						            	
						            	 bw.write("<material>");
						            	 String m="";
						            	 if(!Tools.isNull(r.getGdsmst_stdvalue1())){
						            		 m+=r.getGdsmst_stdvalue1();
						            	 } if(!Tools.isNull(r.getGdsmst_stdvalue8())){
						            		 m=m+"/"+r.getGdsmst_stdvalue8();
						            	 }
						            	 bw.write(m);
						            	 bw.write("</material>");
						            	 bw.newLine();
						            	 if(r.getGdsmst_rackcode().startsWith("020") || r.getGdsmst_rackcode().startsWith("030")){
						            		 bw.write("<style></style>");
							            	 bw.newLine();
							            	 bw.write("<sort>");
							            	 //System.out.println("d1gjltaobao:"+DirectoryHelper.getById( r.getGdsmst_rackcode()).getRakmst_rackname());
							            	 if(DirectoryHelper.getById( r.getGdsmst_rackcode())!=null){
							            	 bw.write(DirectoryHelper.getById( r.getGdsmst_rackcode()).getRakmst_rackname());
							            	 }
							            	 bw.write("</sort>");
							            	 bw.newLine(); 
						            	 }else{
						            		 bw.write("<pattern>");
							            	 bw.write(r.getGdsmst_stdvalue4());
							            	 bw.write("</pattern>");
							            	 bw.newLine(); 
						            	 }
						            	
						            	
						            }
						            bw.write("</clothing>");
					            	 bw.newLine();
					            }
					           
					            bw.write("<weight>");
					            if(r.getGdsmst_weight()!=null){
								bw.write(r.getGdsmst_weight().toString());
					            }else{
					            	bw.write("0");
					            }
						        bw.write("</weight>");  
					            
						        //化妆品 过期日期
						        if(r.getGdsmst_rackcode().startsWith("014")  && r.getGdsmst_validdate()!=null){
						        	  bw.write("<exp>");
						        	  SimpleDateFormat dbFormat = new SimpleDateFormat("yyyyMMdd");
										bw.write(dbFormat.format(r.getGdsmst_validdate()));
								        bw.write("</exp>");  	
						        }
						        
					            bw.write("<showcase>false</showcase>");  
					            bw.newLine();
					            bw.write("<barcode>");
					            bw.write(r.getGdsmst_barcode());
					            bw.write("</barcode>");
					            bw.newLine();
					            bw.write("<is_mobile>1</is_mobile>");
					            bw.newLine();
					            String url="http://www.d1.com.cn/product/"+r.getId();
					            bw.write("<href>");
								bw.write(url);
						        bw.write("</href>");  
					            bw.newLine();
					            String wapurl="http://m.d1.cn/wap/product.html?id="+r.getId();
					            bw.write("<wireless_link>");
								bw.write(wapurl);
						        bw.write("</wireless_link>"); 
						        bw.write("<hd_wireless_link>");
								bw.write(wapurl);
						        bw.write("</hd_wireless_link>"); 
					            bw.write("<comment_count>");
								bw.write(CommentHelper.getCommentLength(r.getId())+"");
						        bw.write("</comment_count>");  
					            bw.newLine();
					            
					            bw.write("<comments>");
					
					            List<Comment> commentlist=CommentHelper. getCommentList(r.getId() , 0 , 5);
						       if(commentlist!=null && commentlist.size()>0){
						    	   for(Comment c:commentlist){
						    		   bw.write("<comment>"); 
 									   bw.write("<auth>"); 
						    		   bw.write(c.getGdscom_uid().trim());
						    		   bw.write("</auth>");
						    		   bw.write("<content>"); 
						    		   String com_content=c.getGdscom_content();
						    		   if (com_content!=null){
						    			   com_content=com_content.replace("&", "");
						    		   }
						    		   bw.write(com_content);
						    		   bw.write("</content>");
						    		    bw.write("</comment>");
						    	   }
						       }
					            bw.write("</comments>");  
					            bw.newLine();
					            bw.write("<saled_score>");
					            bw.write(Tools.getDouble(comlevel*1.0/2, 1)+"");
					            bw.write("</saled_score>");
				          bw.write("</item>");
				         }
				         catch (Exception e) {  
				        	 ret="-1";
					            e.printStackTrace();   
					        }  finally {   
					        	  bw.flush();
						          bw.close();
						          out.clear();
						          out = pageContext.pushBody();
						        }      
				        
		        	}
		           
		            bWriter.write("</item_ids>");
		            bWriter.newLine();
		            bWriter.write("</root>");
		            
		            
		            
		            /*微购*/

			         File wgfile=new File(wgfilepath);
			         if(wgfile.exists()){
			        	 wgfile.delete(); 
			        	 wgfile.createNewFile();
			         }else{
			        	 wgfile.createNewFile();
			         }
		            BufferedWriter  wgfullbw=null;
			         try {   
			        	 wgfullbw= new BufferedWriter(new OutputStreamWriter(new FileOutputStream(wgfile), "UTF-8"));
			        	 wgfullbw.write("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
			        	 wgfullbw.write("<root>");
			        	 wgfullbw.write("<version>1.0</version>");
			        	 //<!--feed 数据格式的版本号-->
			        	  wgfullbw.write("<modified>"+format.format(new Date())+"</modified>");
			        	 //<!--feed 数据文件最近修改时间-->
			        	  wgfullbw.write("<seller_id>D1优尚官网</seller_id>");
			        	 //<!--商家名称-->
			        	  wgfullbw.write("<total>"+list.size()+"</total>");
			        	 //<!--商家全量推送过来的所有商品数量-->
			        	  wgfullbw.write("<dir>http://www.d1.com.cn/WeiGou/item/</dir>");
			        	 //<!--商家数据包所在的目录地址-->
			        	  wgfullbw.write("<item_ids>");
			        	  int countount=num/1000;
			        	   if(num%1000>0){
			        		   countount=countount+1;
			        	   }
			        	 for(int i=1;i<=countount;i++){  
			        	   wgfullbw.write("<outer_id action=\"upload\">"+i+"</outer_id>");
			        	 }
			        	 //<!--全量更新只允许 upload 上架商品，此处一个 outer_id 将对应 1000 个商品-->
			        	 wgfullbw.write("</item_ids>");
			        	 wgfullbw.write("</root>");
			        	  wgfullbw.flush();
			         }
			         catch (Exception e) {  
			        	 ret="-1";
				            e.printStackTrace();   
				        }  finally {   
				        	
				        	  wgfullbw.close();
					 }    
		            /*微购end*/
		       	   
		           
		        } catch (Exception e) {   
		        	ret="-2";
		            e.printStackTrace();   
		        }   
		        finally {   
		            try {   
		            	 bWriter.flush();
				         bWriter.close();  
		            } catch (Exception e) {   
		                e.printStackTrace();   
		            }   
		        }     

		      }
	// response.sendRedirect("/admin/taobaoxml.jsp?fullindex="+ret);
}
%>