<%@ page contentType="text/html;charset=UTF-8"%><%@page import="java.io.*,java.util.zip.*,java.text.*,com.d1.dbcache.core.*,com.d1.*,org.hibernate.criterion.*,org.hibernate.*,com.d1.bean.*,com.d1.helper.*,com.d1.manager.*,java.util.zip.*,java.util.Iterator,java.util.HashMap,java.util.Map,com.d1.bean.*,com.d1.helper.*,java.util.regex.Matcher,java.util.regex.Pattern,com.d1.util.*,java.util.ArrayList,java.util.List;"%>
<%!

  
public static class CompressFileGZIP {   
private static void doCompressFile(String inFileName) {   
    
        try {   
          
            System.out.println("Creating the GZIP output stream.");   
            String outFileName = inFileName + ".gz";   
            GZIPOutputStream out = null;   
            try {   
                out = new GZIPOutputStream(new FileOutputStream(outFileName));   
            } catch(FileNotFoundException e) {   
                System.err.println("Could not create file: " + outFileName);   
                System.exit(1);   
            }   
                      
    
            System.out.println("Opening the input file.");   
            FileInputStream in = null;   
            try {   
                in = new FileInputStream(inFileName);   
            } catch (FileNotFoundException e) {   
            System.err.println("File not found. " + inFileName);   
                System.exit(1);   
            }   
  
            System.out.println("Transfering bytes from input file to GZIP Format.");   
            byte[] buf = new byte[1024];   
            int len;   
            while((len = in.read(buf)) > 0) {   
                out.write(buf, 0, len);   
            }   
            in.close();   
  
            System.out.println("Completing the GZIP file");   
            out.finish();   
            out.close();   
          
        } catch (IOException e) {   
            e.printStackTrace();   
            System.exit(1);   
        }   
  
    }   
  
  
}   
public static File compress(File source) {
	  File target = new File(source.getName() + ".gz");
	  FileInputStream in = null;
	  GZIPOutputStream out = null;
	  try {
	   in = new FileInputStream(source);
	   out = new GZIPOutputStream(new FileOutputStream(target));
	   byte[] array = new byte[1024];
	   int number = -1;
	   while((number = in.read(array, 0, array.length)) != -1) {
	    out.write(array, 0, number);
	   }
	  } catch (FileNotFoundException e) {
	   e.printStackTrace();
	   return null;
	  } catch (IOException e) {
	   e.printStackTrace();
	   return null;
	  } finally {
	   if(in != null) {
	    try {
	     in.close();
	    } catch (IOException e) {
	     e.printStackTrace();
	     return null;
	    }
	   }
	   
	   if(out != null) {
	    try {
	     out.close();
	    } catch (IOException e) {
	     e.printStackTrace();
	     return null;
	    }
	   }
	  }
	  return target;
	 }
static List getAllProduct(){
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
	//clist.add(Restrictions.eq("id", "02012598"));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("gdsmst_createdate"));
	return ProductHelper.manager.getList(clist, listOrder, 0, 100);
}
public static void compressFile(String inFileName) {
    String outFileName = inFileName + ".gz";
    FileInputStream in = null;
    try {
        in = new FileInputStream(new File(inFileName));
    }catch (FileNotFoundException e) {
       
    }
    
    GZIPOutputStream out = null;
    try {
        out = new GZIPOutputStream(new FileOutputStream(outFileName));
    }catch (IOException e) {
      
    }
    byte[] buf = new byte[1024];
    int len = 0;
    try {
        while ((len = in.read()) > 0) {
            out.write(buf, 0, len);
        }
        in.close();
       
        out.flush();
        out.close();
    }catch (IOException e) {
    
    }
}
%>
<%
//response.reset();
//response.setContentType("application/octet-stream");
//response.setHeader("Content-Disposition", "attachment;filename=d12345.gz");
//GZIPOutputStream  zos = new GZIPOutputStream(response.getOutputStream());
if(!"127.0.0.1".equals(request.getRemoteHost())&&!"localhost".equals(request.getRemoteHost())){
	return;
}
	


String wgfilepath = Const.PROJECT_PATH + "taobao/goods.xml";
String wgfilepathgz = Const.PROJECT_PATH + "taobao/goods.xml.gz";
String wgfilepathitem = Const.PROJECT_PATH + "taobao/";

ProductManager manager = (ProductManager)ProductHelper.manager;
List<Product> list =manager.getTotalProductList();
String ret="1";

if(list==null || list.size()==0){
	list=getAllProduct();
}

if(list!=null && list.size()>0){
	
	String wgitempath=wgfilepath;

	File itemfile=new File(wgitempath);
	File itemfilegz=new File(wgfilepathgz);
	if(itemfilegz.exists()){
		itemfilegz.delete(); 
	}
	if(itemfile.exists()){
		 itemfile.delete(); 
		 itemfile.createNewFile();
	}else{
		 itemfile.createNewFile();
	}
	BufferedWriter  itembw= new BufferedWriter(new OutputStreamWriter(new FileOutputStream(itemfile), "UTF-8"));
	
itembw.write("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>");
itembw.write("<data>");
itembw.write("<site_name><![CDATA[D1优尚网]]></site_name>");
itembw.write("<site_domain>www.d1.com.cn</site_domain>");
itembw.write("<site_bid>2000459</site_bid>");
itembw.write("<goodsdata>");
String goodsid="";
String cls="";
String classlow="";
int order=1;
String title="";
String promotion="";
String brandname="";
String goods_url="";
String keys="";
DecimalFormat df = new DecimalFormat("0.00");
String gdetail="";
float mprice=0f;
boolean isms=false;
int sex=2;
SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String skustr="";
String rackcode="";
String rckname1="";
String rckname2="";
for(Product p:list){
	goodsid=p.getId();
	title=p.getGdsmst_gdsname();
	keys=p.getGdsmst_keyword();
	if(!Tools.isNull(keys))keys=keys.replace(" ", "，");
	keys="正品保证，"+keys;
	brandname=p.getGdsmst_brandname();
	rackcode=p.getGdsmst_rackcode();
	Rck2345 rck2345=(Rck2345)Tools.getManager(Rck2345.class).findByProperty("rck_code", rackcode);
	
	rckname1="";
	rckname2="";
	if(rck2345!=null){
		rckname1=rck2345.getRck_2345name1();
		rckname2=rck2345.getRck_2345name2();
	}
itembw.write("<goods id=\""+order+"\">");
itembw.write("<pid>"+goodsid+"</pid>");
itembw.write("<class><![CDATA["+rckname1+"]]></class>");
itembw.write("<classlow><![CDATA["+rckname1+"]]></classlow>");
itembw.write("<order>"+order+"</order>");
itembw.write("<shortTitle><![CDATA["+title+"]]></shortTitle>");
itembw.write("<title><![CDATA["+title+"]]></title>");
itembw.write("<promotion><![CDATA["+keys+"]]></promotion>");
itembw.write("<brand_name><![CDATA["+brandname+"]]></brand_name>");
itembw.write("<goods_url>http://www.d1.com.cn/product/"+goodsid+"</goods_url>");
itembw.write("<buygoods_url></buygoods_url>");
itembw.write("<wap_url>http://m.d1.cn/wap/product.html?id="+goodsid+"</wap_url>");
itembw.write("<img1_url>"+ProductHelper.getImageTo400(p)+"</img1_url>");
itembw.write("<img2_url>"+ProductHelper.getImageTo400(p)+"</img2_url>");
itembw.write("<market_price>"+df.format(p.getGdsmst_saleprice())+"</market_price>");
isms=CartHelper.getmsflag(p);
mprice=p.getGdsmst_memberprice();
if(isms){
	mprice=p.getGdsmst_msprice();
}
itembw.write("<sale_price>"+df.format(p.getGdsmst_memberprice())+"</sale_price>");
itembw.write("<sale_num>"+p.getGdsmst_sendcount()+"</sale_num>");
gdetail=p.getGdsmst_briefintrduce();
itembw.write("<item_des><![CDATA["+gdetail+"]]></item_des>");
itembw.write("<is_offergift>0</is_offergift>");
if(p.getGdsmst_sex()!=null){
sex=p.getGdsmst_sex().intValue();
}else{
	sex=99;
}
if(sex==2){
	sex=99;
}
if(sex==0){
	sex=2;
}
if(rck2345!=null&&rck2345.getRck_2345name1()!=null&&rck2345.getRck_2345name2()!=null&&(rck2345.getRck_2345name1().indexOf("男")>=0||rck2345.getRck_2345name2().indexOf("男")>=0)){
	sex=2;
}else if(rackcode.startsWith("014")||(rck2345!=null&&rck2345.getRck_2345name1()!=null&&rck2345.getRck_2345name2()!=null&&(rck2345.getRck_2345name1().indexOf("女")>=0||rck2345.getRck_2345name2().indexOf("女")>=0))){
	sex=1;
}

itembw.write("<peoplegroup>"+sex+"</peoplegroup>");
itembw.write("<is_new>1</is_new>");
itembw.write("<has_storage>1</has_storage>");
if(mprice>=100.0f){
itembw.write("<free_delivery>1</free_delivery>");
}else{
itembw.write("<free_delivery>0</free_delivery>");	
}
if(p.getGdsmst_shopcode().equals("00000000")){
itembw.write("<cash_on_delivery>1</cash_on_delivery>");
}else{
itembw.write("<cash_on_delivery>0</cash_on_delivery>");	
}
itembw.write("<after_service><![CDATA[D1保证所售出的商品都是通过正规渠道配货发货，您享有与其它途径购买的商品同样的服务。如果您所购买的产品存在质量问题，在未经使用的情况下，您可以享受 30 天退换货的服务。 ]]></after_service>");
itembw.write("<time_on_market></time_on_market>");
if(isms){
itembw.write("<time_on_sale>"+DateFormat.format(p.getGdsmst_promotionstart())+"</time_on_sale>");
itembw.write("<time_close_sale>"+DateFormat.format(p.getGdsmst_promotionend())+"</time_close_sale>");
}else{
	itembw.write("<time_on_sale></time_on_sale>");
	itembw.write("<time_close_sale></time_close_sale>");
}
if(!Tools.isNull(p.getGdsmst_skuname1())){
List<Sku> skulist=	SkuHelper.getSkuListViaProductId(goodsid);
skustr="规格#m#";
   int l=0;
	for(Sku sku:skulist){
		if(l==0){
		skustr=skustr+sku.getSkumst_sku1();
		}else{
			skustr=skustr+"||"+sku.getSkumst_sku1();	
		}
		l++;
	}
itembw.write("<main_props><![CDATA["+skustr+" ]]></main_props>");
}else{
	itembw.write("<main_props></main_props>");	
}
itembw.write("</goods>");
order++;
}
itembw.write("</goodsdata>");
itembw.write("</data>");
itembw.flush();
itembw.close();
CompressFileGZIP.doCompressFile(wgfilepath);
//compressFile(wgfilepath);
//File target = new File(wgfilepath);
//compress(target);
/*ZipEntry ze = new ZipEntry("d12345/goods.html");

byte[] bs = sb.toString().getBytes("UTF-8");
ze.setSize(bs.length);
ze.setTime(System.currentTimeMillis());
//将ZipEntry加到zos中，再写入实际的文件内容
zos.putNextEntry(ze);
zos.write(bs,0,bs.length);
zos.closeEntry();
zos.flush();
*/

}



%>
