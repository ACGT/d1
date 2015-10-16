<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,
java.io.File,
java.util.Hashtable,
com.google.zxing.BarcodeFormat,
com.google.zxing.EncodeHintType,
com.google.zxing.MultiFormatWriter,
com.google.zxing.WriterException,
com.google.zxing.common.BitMatrix
"%>
<%

String text = "http://www.baidu.com"; 
int width = 300; 
int height = 300; 
//二维码的图片格式 
String format = "gif"; 
Hashtable hints = new Hashtable(); 
//内容所使用编码 
hints.put(EncodeHintType.CHARACTER_SET, "utf-8"); 
BitMatrix bitMatrix = new MultiFormatWriter().encode(text,BarcodeFormat.QR_CODE, width, height, hints); 
//生成二维码 
File outputFile = new File("/opt/d1web/weixin/"+File.separator+"new2.gif"); 
RCode.writeToFile(bitMatrix, format, outputFile); 

%>222