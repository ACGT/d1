<%@ page contentType="text/html; charset=UTF-8" import="jxl.*"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkrgt.jsp"%>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern"%>
<%!
//获取商品编号
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
/**读取Excel文件的内容   
 * @param file  待读取的文件   
 * @return   
 */    
public static String readExcel(File file){     
    StringBuffer sb = new StringBuffer();     
    String shopcode="03050801";     
    SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
    Workbook wb = null;     
    Date d=new Date();
    try{
    	d=format.parse("2999-01-01")	;
    }catch(Exception e){
    	
    }
    try {     
        //构造Workbook（工作薄）对象     
        wb=Workbook.getWorkbook(file);     
    } catch (Exception e) {     
        e.printStackTrace();     
    }  
         
    if(wb==null){     
    	System.out.print("文件不存在！！！！！！！！！！！1");
        return null;     
    }
    //获得了Workbook对象之后，就可以通过它得到Sheet（工作表）对象了     
    Sheet[] sheet = wb.getSheets();     
         
    if(sheet!=null&&sheet.length>0){     
        //对每个工作表进行循环     
        for(int i=0;i<sheet.length;i++){  
            //得到当前工作表的行数     
            int rowNum = sheet[i].getRows();     
            for(int j=0;j<rowNum;j++){
            
                //得到当前行的所有单元格     
                Cell[] cells = sheet[i].getRow(j);     
                if(cells!=null&&cells.length>0){  
                	String gdsid="";
                	String gdsname=cells[0].getContents();//商品名称
                	String gdsename=cells[2].getContents();//商品英文名称
                	String rackcode=cells[3].getContents();//商品分类编号
                	String brandcode=cells[4].getContents();//品牌编号
                	String brandname="";//品牌名称
                	String jj=cells[6].getContents();//简介
                	String shopgdscode=cells[2].getContents();//商户商品编码
                	String buylimit="0";//最大购买数量
                	String stock="0";//商品库存
                	String vituralstock="";//虚拟库存
                	String tm=cells[10].getContents();//商品条码
                	String skuname1=cells[11].getContents();;//商品SKU名称1
                	String sex="2";
                	
                	float saleprice=Tools.parseFloat(cells[7].getContents());
                	float memberprice=Tools.parseFloat(cells[8].getContents());
                	float vipprice=Tools.parseFloat(cells[9].getContents());
					String detail="";

                	String gdsmst_ifhavegds="0";
                	String flag="0";//上下架标志
                	String gift="0";//单品赠品
                	
                	String key=cells[5].getContents();//关键字
                	
                	Brand brand=BrandHelper.getBrandByCode(brandcode);
                	if(brand!=null){
                		brandname=brand.getBrand_name().trim();
                	}
                	Product product=new Product();
                	product.setGdsmst_shopcode(shopcode);//商户编码
            		gdsid=getPid(rackcode.substring(0,3));
            		//out.print(rackcode+">>>"+gdsid);
            		
            		product.setId(gdsid);//商品编码

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
            		product.setGdsmst_discountenddate(d);
            		product.setGdsmst_srcstatus(new Long(0));
            		product.setGdsmst_oldvipprice(0f);
            		product.setGdsmst_oldmemberprice(0f);
            		product.setGdsmst_downflag(new Long(1));
            		product.setGdsmst_sendcount(new Long(0));
            		product.setGdsmst_salecount(new Long(0));
            		product.setGdsmst_discounflag(new Long(1));
            		product.setGdsmst_enddateend(d);
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
                    //对每个单元格进行循环     
                   // for(int k=0;k<cells.length;k++){  
                        //读取当前单元格的值     
                     //   String cellValue = cells[k].getContents();     
                      //  sb.append(cellValue+"\t");     
                    //}    
            		product=(Product)Tools.getManager(Product.class).create(product); 
                    
                }     
                sb.append("\r\n");     
            }     
            sb.append("\r\n");     
        }     
    }  
    //最后关闭资源，释放内存     
    wb.close();     
    return sb.toString();     
}    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品信息导入</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<style type="text/css">

</style>
<script type="text/javascript">

</script>
</head>
<%
if ("post".equals(request.getMethod().toLowerCase())) {
	DiskFileItemFactory  factory = new DiskFileItemFactory();
	factory.setSizeThreshold(1024 * 4);
	   ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(1024 * 1024 * 10);
	   try {
	    List items2 = upload.parseRequest(request);
	    Iterator it2 = items2.iterator();
	
    while(it2.hasNext()){
     FileItem fitem = (FileItem)it2.next();
     if(!fitem.isFormField()){
      if(fitem.getName() != null && !"".equals(fitem.getName())){
    	 
    		  String fn = fitem.getName();
				if (fn == null || fn.equals(""))
					continue;//如果文件框未选中文件
				
				String ext = ".xls";
				if (fn.indexOf(".") > -1) {
					ext = fn.substring(fn.lastIndexOf(".")).toLowerCase();
					
				}
				if((!ext.equals(".xls")) && (!ext.equals(".xlsx")) ){
					Tools.outJs(out,"请上传Excel文件","back");
					return;
				}
				String uploadPath = Const.PROJECT_PATH + "upload/shopadmin/gdsinfo/";
				String fileName = Tools.getDBDate()+ext;//文件名
				//String photoName = "http://d1.com.cn/upload/"+ fileName;
				 File file=new File(uploadPath);
				 if (!file.exists()) {//判断路径是否存在
					 file.mkdirs();
				 }
				
				String uploadFileName = uploadPath + fileName.substring(fileName.lastIndexOf("/") + 1);
				//创建一个待写文件 
				File uploadedFile = new File(uploadFileName);
				//写入 
				//out.print(uploadFileName);
				fitem.write(uploadedFile);
				//out.print("<script>alert('上传成功！')</script>");
				
				String str=readExcel(uploadedFile);
				out.print(str);
    	  }
      
      }
    }
	   }
    catch (Exception e) {
		   out.print("fail");
	    e.printStackTrace();
	    return;
	   }
     }
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="form1" action="importexcel.jsp" method="post" enctype="multipart/form-data"  method="post"  >
请选择您要导入的数据： <input name="upload" type="file" id="f1" /> &nbsp;&nbsp;
<input type="submit" value="确定导入"></input>
</form>			 
</body>
</html>