<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static ArrayList<ProductSearchBoxUpdate> getAllCategory(int pageindex,int pagesize){
	ArrayList<ProductSearchBoxUpdate> list =new ArrayList<ProductSearchBoxUpdate>();
	//List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	//clist.add(Restrictions.le("id", "115500"));
	//clist.add(Restrictions.ge("id", "115400"));
	List<BaseEntity> b_list =Tools.getManager(ProductSearchBoxUpdate.class).getList(null, null, (pageindex-1)*pagesize, pagesize);
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((ProductSearchBoxUpdate)be);
		}
	}
	
	return list;
}
static int getTotalPage(){
	//List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	//clist.add(Restrictions.le("id", "115500"));
	//clist.add(Restrictions.ge("id", "115400"));
 return Tools.getManager(ProductSearchBoxUpdate.class).getLength(null);
}
static String getSkuName(String productid,String strSkuName,int skuid){
	StringBuffer sb=new StringBuffer();
	ArrayList<Sku> list=SkuHelper.getSkuListViaProductId(productid);
	if(!Tools.isNull(strSkuName)&& ! "null".equals(strSkuName.toLowerCase())){
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
//生成完后，删除表中数据
static void delEntity(){
	String sql="delete  from gdsbox_update";
	Session session123=null;
	session123 = MyHibernateUtil.currentSession(Const.HIBERNATE_CON_FILE) ;
	Transaction tx1 = null ;
	try{
		tx1 = session123.beginTransaction() ;
		session123.createSQLQuery(sql).executeUpdate();
		tx1.commit();
	}catch(Exception ex){
		if(tx1!=null)tx1.rollback();
		ex.printStackTrace();
	}finally{
		MyHibernateUtil.closeSession(Const.HIBERNATE_CON_FILE);
	}
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
String filepath = Const.PROJECT_PATH + "taobao/IncrementIndex.xml";
String SellerCatsFile="http://www.d1.com.cn/taobao/SellerCats.xml";
String IncrementIndexItem="http://www.d1.com.cn/taobao/Item_2/";
String filepath2 = Const.PROJECT_PATH + "taobao/Item_2/";
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
}else{
	 file2.mkdirs();
}
int pagesize=300;
int total=getTotalPage();
int pagecount=total/pagesize;
if(total%pagesize!=0){
	pagecount=total/pagesize+1;
}


/*微购*/
String wgfilepath = Const.PROJECT_PATH + "WeiGou/IncrementIndex.xml";
String wgFullIndexItem="http://www.d1.com.cn/WeiGou/item2/";
String wgfilepathitem = Const.PROJECT_PATH + "WeiGou/item2/";
/*微购end*/




//System.out.println(total+">>>>>>>>>>>>");
ArrayList<ProductSearchBoxUpdate> list=null;
SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
BufferedWriter bWriter = null;   
BufferedWriter  bw=null;
StringBuffer sb=new StringBuffer();
String ret="1";


int num=0;
int wgitem=1;
int allcount=total;
BufferedWriter  wgitembw=null;
int comlen=0;
int comlevel=5;
for(int i=1;i<=pagecount;i++){
	list=getAllCategory(i,pagesize);
	try{
	if(i==1){
		if(list!=null && list.size()>0){
			sb.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
			sb.append("\n");
			sb.append("<root>");
			sb.append("\n");
			sb.append("<version>1.0</version>");
			sb.append("\n");
			sb.append("<modified>");
			sb.append(format.format(new Date()));
			sb.append("</modified>");
			sb.append("\n");
			sb.append("<seller_id>d1优尚网官网</seller_id>");
			sb.append("\n");
			sb.append("<cat_url>");
			sb.append(SellerCatsFile);
			sb.append("</cat_url>");
			sb.append("\n");
			sb.append("<dir>");
			sb.append(IncrementIndexItem);
			sb.append("</dir>");
			sb.append("\n");
			sb.append("<item_ids>");
			sb.append("\n");
			 /**  bWriter.write("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
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
		            bWriter.write(IncrementIndexItem);
		            bWriter.write("</dir>");
		            bWriter.newLine();
		            bWriter.write("<item_ids>");
		            bWriter.newLine(); */
		}
	}
	if(list!=null && list.size()>0){

		 for(ProductSearchBoxUpdate r:list){
        	Product p=ProductHelper.getById(r.getGdsmst_gdsid().trim());
        	if(p!=null){
        		
        		
        		 /*微购*/
           	 comlen=CommentHelper.getCommentLength(r.getId());
           	 comlevel=CommentHelper.getLevelView(r.getId());
           	 if(comlevel==0)comlevel=5;
           //	 if(p.getGdsmst_rackcode().startsWith("014")||p.getGdsmst_rackcode().startsWith("015")){
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
		        	     getwgitem(p,wgitembw,wgitem,comlen,comlevel);
		             	
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
        		
        		
        	
        	int siAction=r.getGdsmst_action().intValue();
        	
        	if (siAction == 0){//商品下架
        		sb.append("<outer_id action=\"delete\">");
            }
            else{//1商品更新或上架
            	sb.append("<outer_id action=\"upload\">");
               
            }
        	sb.append(r.getGdsmst_gdsid().trim());
        	sb.append("</outer_id>");
        	sb.append("\n");
		         
		         String itempath=filepath2+p.getId().trim()+".xml";
		         File itemfile=new File(itempath);
		         if(itemfile.exists()){
		        	 itemfile.delete(); 
		        	 itemfile.createNewFile();
		         }else{
		        	 itemfile.createNewFile();
		         }
		         
		         try {   
		        	 StringBuffer str=new StringBuffer();
		           bw= new BufferedWriter(new OutputStreamWriter(new FileOutputStream(itemfile), "UTF-8"));
			        str.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
			        str.append("\n");
			        str.append("<item>");
			        str.append("\n");
			        str.append("<seller_id>d1优尚网官网</seller_id>");
			        str.append("\n");
					str.append("<outer_id>");
					System.out.println("一淘更新商品==="+r.getGdsmst_gdsid());
					str.append(r.getGdsmst_gdsid().trim());
					str.append("</outer_id>");
					str.append("\n");
					str.append("<title>");
					str.append(Tools.clearHTML(p.getGdsmst_gdsname()).replace("&", ""));
					str.append("</title>");
					str.append("\n");
		           DateFormat format2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		            Date DiscountEndDate=p.getGdsmst_discountenddate();
		          long endtime=Tools. parseJsDate(format2.format(DiscountEndDate));
		          double fltOldMemberPrice=Tools.getDouble(p.getGdsmst_oldmemberprice().doubleValue(), 2);
		        	double fltDRate=0d;//打折率
		        	double fltPrice=Tools.getDouble(p.getGdsmst_memberprice().doubleValue(), 2);;
		        	double price=0;
		        	String enumPriceType="0";
		          if(endtime>System.currentTimeMillis() && endtime<(System.currentTimeMillis()+30*24*3600*1000l)){
		        	
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
		        		str.append("<type>fixed</type>");
						
		        	}else if(enumPriceType.equals("1")){
		        		price=fltOldMemberPrice;
		        		str.append("<type>discount</type>");
		        	}
		        	str.append("\n");
		        	 if(p.getGdsmst_ifhavegds().intValue()==0){
		        		 str.append("<available>1</available >");
		        	 }else{
		        		 str.append("<available>0</available >");
		        	 }
		        	str.append("\n");
		        	   str.append("<price>");
			            str.append(Tools.getDouble(price, 2)+"");
			            str.append("</price>");
			            str.append("\n");
			            if(enumPriceType.equals("1")){//折扣
			            	 str.append("<discount>");
				            Date s=new Date(endtime-29*24*3600*1000l);
				            DateFormat f=new SimpleDateFormat("yyyy-MM-dd HH:mm");
				            str.append("<start>");
				            str.append(f.format(s));
				            str.append("</start>");
				            str.append("\n");
				            str.append("<end>");
				            str.append(f.format(DiscountEndDate));
				            str.append("</end>");
				            str.append("\n");
				            str.append("<dprice>");
				            str.append(fltOldMemberPrice+"");
				            str.append("</dprice>");
				            str.append("\n");
				            str.append("<drate>");
				            str.append(fltDRate+"");
				            str.append("</drate>");
				            str.append("\n");
				            str.append("<ddesc></ddesc>");
				            str.append("\n");
				            str.append("</discount>");
			            }
			            String strBriefIntroduce = Tools.clearHTML(p.getGdsmst_briefintrduce().trim()).replace("<", "").replace("&", "");
			            if(strBriefIntroduce.length()>1000){
			            	 strBriefIntroduce = Tools.substring(strBriefIntroduce, 1000);
			            }
			            str.append("<desc>");
			            str.append(strBriefIntroduce);
			            str.append("</desc>");
			            str.append("\n");
			            
			            String strBrandName =p.getGdsmst_brandname().trim().replace("&", "");
			            if (strBrandName.length() > 30)
			            {
			                strBrandName = strBrandName.substring(0, 30);
			            }
			            str.append("<brand>");
			            str.append(strBrandName);
			            str.append("</brand>");
			            str.append("\n");
			            
			            String strGdsKeyWord =!Tools.isNull(p.getGdsmst_keyword())?Tools.clearHTML(p.getGdsmst_keyword().trim()).replace("&", ""):"";
			            str.append("<tags>");
			            str.append(strGdsKeyWord);
			            str.append("</tags>");
			            str.append("\n");
			            
			            String strGdsImg=!Tools.isNull(p.getGdsmst_imgurl())?p.getGdsmst_imgurl().trim():"";
			            String strImgExt="";
			            if (!Tools.isNull(strGdsImg)&&strGdsImg.indexOf(".") > -1) {
			            	strImgExt = strGdsImg.substring(strGdsImg.lastIndexOf(".")).toLowerCase();
							if(!strImgExt.equals(".jpg") && !strImgExt.equals(".jpeg") && !strImgExt.equals(".png")){
								str.append("<image></image>");
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
								 str.append("<image>");
								 str.append(strGdsImg);
						         str.append("</image>");  
							}
							 str.append("\n");
						}
			            str.append("<more_images>");
			            str.append("\n");
			            String strBigImg=p.getGdsmst_imgurl().trim();
			            if (strBigImg.indexOf(".") > -1) {
			            	strImgExt = strGdsImg.substring(strGdsImg.lastIndexOf(".")).toLowerCase();
							if(!strImgExt.equals(".jpg") && !strImgExt.equals(".jpeg") && !strImgExt.equals(".png")){
								str.append("<image></image>");
							}else{
								if(!(strBigImg.indexOf("http:")==0)){
									if(!(strGdsImg.indexOf("\\/")==0)){
										strBigImg = "/" + strBigImg;
									}
									if(strBigImg!=null&&strGdsImg.startsWith("/shopimg/gdsimg")){
										 strGdsImg = "http://images1.d1.com.cn"+strBigImg;
											}else{
												strBigImg = "http://images.d1.com.cn"+strBigImg;
											}									}
								 str.append("<image>");
								 str.append(strBigImg);
						         str.append("</image>");  
							}
							 str.append("\n");
						}
			            str.append("</more_images>");
			            str.append("\n");
			            str.append("<scids>");
						str.append(p.getGdsmst_rackcode().trim());
				        str.append("</scids>");  
			            str.append("\n");
			            str.append("<post_fee>10.00</post_fee>");
			            str.append("\n");
			            StringBuffer sb2=new StringBuffer();
			            String strSkuName1=p.getGdsmst_skuname1();
			            sb2.append(getSkuName(r.getGdsmst_gdsid(), strSkuName1, 1));
			            sb2.append(getSkuName(r.getGdsmst_gdsid(), p.getGdsmst_skuname2(), 2));
			            str.append("<props>");
						str.append(sb2.toString());
				        str.append("</props>");  
			            str.append("\n");
			            //服装
			            if(p.getGdsmst_rackcode().startsWith("02") || p.getGdsmst_rackcode().startsWith("03")){
			            	 str.append("<clothing>");
			            	  //鞋。衣服
				            if(p.getGdsmst_rackcode().startsWith("020") || p.getGdsmst_rackcode().startsWith("030") ||p.getGdsmst_rackcode().startsWith("021") || p.getGdsmst_rackcode().startsWith("031")){
				            	 str.append("<size>");
				            	 ArrayList<Sku> skulist=SkuHelper.getSkuListViaProductId(r.getId());
				            	 String s="";
				            	 if(skulist!=null && skulist.size()>0){
				            		 for(Sku sku:skulist){
				            			 s+="/"+sku.getSkumst_sku1().trim();
				            		 }
				            		 s=s.substring(1,s.length());
				            	 }
				            	 str.append(s);
				            	 str.append("</size>");
				            	 bw.newLine();
				            	 if(p.getGdsmst_rackcode().startsWith("020") || p.getGdsmst_rackcode().startsWith("030")){
				            		 str.append("<color>");
				            		 str.append(p.getGdsmst_stdvalue2());
				            		 str.append("</color>");
					            	 bw.newLine();
				            	 }
				            	
				            	 str.append("<material>");
				            	 String m="";
				            	 if(!Tools.isNull(p.getGdsmst_stdvalue1())){
				            		 m+=p.getGdsmst_stdvalue1();
				            	 } if(!Tools.isNull(p.getGdsmst_stdvalue8())){
				            		 m=m+"/"+p.getGdsmst_stdvalue8();
				            	 }
				            	 str.append(m);
				            	 str.append("</material>");
				            	 str.append("\n");
				            	 if(p.getGdsmst_rackcode().startsWith("020") || p.getGdsmst_rackcode().startsWith("030")){
				            		 str.append("<style></style>");
				            		 str.append("\n");
					            	 str.append("<sort>");
					            	 if(DirectoryHelper.getById( p.getGdsmst_rackcode())!=null){
					            	 str.append(DirectoryHelper.getById( p.getGdsmst_rackcode()).getRakmst_rackname());
					            	 }
					            	 str.append("</sort>");
					            	 str.append("\n");
				            	 }else{
				            		 str.append("<pattern>");
				            		 str.append(p.getGdsmst_stdvalue4());
				            		 str.append("</pattern>");
				            		 str.append("\n");
				            	 }
				            	
				            	
				            }
				            str.append("</clothing>");
				            str.append("\n");
			            }
			           
			            str.append("<weight>");
			            if(p.getGdsmst_weight()!=null){
							bw.write(p.getGdsmst_weight().toString());
				            }else{
				            	bw.write("0");
				            }
			            str.append("</weight>");  
			            
				        //化妆品 过期日期
				        if(p.getGdsmst_rackcode().startsWith("014") && p.getGdsmst_validdate()!=null){
				        	 str.append("<exp>");
				        	  SimpleDateFormat dbFormat = new SimpleDateFormat("yyyyMMdd");
				        	  str.append(dbFormat.format(p.getGdsmst_validdate()));
				        	  str.append("</exp>");  	
				        }
				         str.append("<showcase>0</showcase>");  
			            
			            
			            
			            
			            
			            
			            str.append("<showcase>0</showcase>");  
			            str.append("\n");
			            str.append("<barcode>");
			            str.append(p.getGdsmst_barcode());
			            str.append("</barcode>");
			            str.append("\n");
			            str.append("<is_mobile>1</is_mobile>");
			            str.append("\n");
			            String url="http://www.d1.com.cn/product/"+r.getGdsmst_gdsid();
			            str.append("<href>");
						str.append(url);
				        str.append("</href>");  
			            str.append("\n");
			            String wapurl="http://m.d1.cn/wap/product.html?id="+r.getId();
			            str.append("<wireless_link>");
						str.append(wapurl);
				        str.append("</wireless_link>"); 
				        str.append("\n");
				        str.append("<hd_wireless_link>");
						str.append(wapurl);
				        str.append("</hd_wireless_link>"); 
				        str.append("\n");
			            str.append("</item>");
			            
			            bw.write(str.toString());
			           
	} 
	         catch (Exception e) {  
	        	  ret="-1";
		            e.printStackTrace();   
		        }   finally {   
		        	 bw.flush();
					 bw.close();
		        }
	        
	}
		 }
	}
	 if(i==pagecount){
		 if(file.exists()){
			 bWriter= new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF-8"));
		}
		 bWriter.write(sb.toString());
		 bWriter.write("</item_ids>");
         bWriter.newLine();
         bWriter.write("</root>");

	 }
	} catch (Exception e) {   
		 ret="-2";
	            e.printStackTrace();   
	        }   
	        finally {   
	            try {   
	            	// bWriter.flush();
	                 bWriter.close();  
	                 out.clear();
	                 out = pageContext.pushBody();
	            } catch (Exception e) {   
	                e.printStackTrace();   
	            }   
	        }  
	 if(i==pagecount){
		 delEntity();
	 // response.sendRedirect("/admin/taobaoxml.jsp?inindex="+ret);
	 }
}
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
	  wgfullbw.write("<dir>http://www.d1.com.cn/WeiGou/item2/</dir>");
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
%>