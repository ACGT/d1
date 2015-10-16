<%@ page contentType="text/html; charset=UTF-8" import="jxl.*"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkrgt.jsp"%>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern"%>
<%!
/**读取Excel文件的内容   
 * @param file  待读取的文件   
 * @return   
 */    
public static String readExcel(File file){     
    StringBuffer sb = new StringBuffer();     
         
    Workbook wb = null;     
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
                    //对每个单元格进行循环     
                    for(int k=0;k<cells.length;k++){  
                        //读取当前单元格的值     
                        String cellValue = cells[k].getContents();     
                        sb.append(cellValue+"\t");     
                    }     
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