<%@ page  language="java"   import="com.lowagie.text.Table,java.io.*,java.awt.Color,com.lowagie.text.*,com.lowagie.text.pdf.*"%><%@page 
import="com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.util.List,
java.text.*,
java.io.*"%>
<%!public static Paragraph getpar(String str,Font fn){
	if(str.length()==0)return null;
	try{
	byte[] temp=str.getBytes("ISO-8859-1");//这里写原编码方式
    String newStr=new String(temp,"utf-8");//这里写转换后的编码方式
Paragraph par = new Paragraph(newStr,fn);
    return par;
	}catch(Exception ex){
		return null;
	}
}
public static Paragraph getpar2(String str,Font fn){
	if(str.length()==0)return null;
	try{
Paragraph par = new Paragraph(str,fn);
    return par;
	}catch(Exception ex){
		return null;
	}
}
public static PdfPCell celltype(PdfPCell cell,int horali,int verali,int cols,int padd){
	 cell.setHorizontalAlignment(horali);
	 cell.setVerticalAlignment(verali);
	 cell.setColspan(cols);
	 cell.setPadding(padd);
	return cell;
}

public static  ArrayList<OrderMain> getOrderlist(String pcnos){
	ArrayList<OrderMain> list=new ArrayList<OrderMain>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("odrmst_ads2", pcnos));
	listRes.add(Restrictions.ne("odrmst_goodsodrid", ""));
	List<BaseEntity> list2 = Tools.getManager(OrderMain.class).getList(listRes, null, 0, 10);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((OrderMain)be);
	}
	return list;
}
%>
<%/*
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "odr_printyt");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}*/

String pcnos=request.getParameter("pcnos");
List<OrderMain> odrlist=getOrderlist(pcnos);
response.setContentType("application/pdf;");
int odrnum=odrlist.size();

Rectangle pageSize = new Rectangle(278,425*odrnum);
Document document = new Document(pageSize, 0,0,0,0);//左 右 上下
ByteArrayOutputStream buffer = new ByteArrayOutputStream();
PdfWriter writer=PdfWriter.getInstance( document, buffer );
document.open();
//设置中文字体
BaseFont bfChinese =BaseFont.createFont( "STSong-Light","UniGB-UCS2-H",BaseFont.NOT_EMBEDDED);

 

Font f12 = new Font(bfChinese, 10, Font.BOLD, Color.BLACK);
Font f25 = new Font(bfChinese, 28, Font.BOLD, Color.BLACK);
Font f18 = new Font(bfChinese, 18, Font.BOLD, Color.BLACK);


PdfPTable tablem = new PdfPTable(1);
tablem.setWidthPercentage(100);
PdfPCell cellm = new PdfPCell();

for(OrderMain odrm:odrlist){

String shipcode=odrm.getOdrmst_goodsodrid();
if(Tools.isNull(shipcode))return;
String rname=odrm.getOdrmst_rname().trim();
String rphone=odrm.getOdrmst_rphone().trim();
String rzipcode=odrm.getOdrmst_rzipcode();
String rprv=odrm.getOdrmst_rprovince();
String rcity=odrm.getOdrmst_rcity();
String raddr=odrm.getOdrmst_raddress(); 
String odrid=odrm.getId();
String bigPen=odrm.getOdrmst_ads1();

rphone=rphone.length()>11?rphone.substring(0, 11):rphone;
PdfContentByte cb = writer.getDirectContent();

Barcode128 code128 = new Barcode128(); 
code128.setCode(shipcode);   
String fullCode = code128.getRawText(shipcode,false);
int len = fullCode.length();
code128.setX(130/((len+2)*11 + 2f));
Image image128 = code128.createImageWithBarcode(cb, null, null);   
//document.add(new Phrase(new Chunk(image128, 20, -50)));

// 添加table实例
PdfPTable tables = new PdfPTable(1);
tables.setWidthPercentage(100);
PdfPCell cells = new PdfPCell();
cells.setFixedHeight(230);
cells.setBorderWidth(0);
cells.setPadding(0);
PdfPTable iTable= new PdfPTable(1); 
PdfPTable table = new PdfPTable(3);
table.setWidthPercentage(100);
table.setHorizontalAlignment(PdfPTable.ALIGN_LEFT);
table.setWidths(new float[]{0.07f,0.53f,0.40f});
PdfPCell cell = new PdfPCell();
PdfPCell icell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_RIGHT,Element.ALIGN_RIGHT,3,2);
cell.setFixedHeight(20);
cell.setPhrase(getpar("上联：此联由圆通速递留存",f12));
table.addCell(cell);
cell = new PdfPCell(image128);
cell.setFixedHeight(40);
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,2,2);
table.addCell(cell);
cell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,0,0);
cell.setPhrase(getpar2(bigPen,f25));
table.addCell(cell);
cell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,0,0);
cell.setPhrase(getpar("收货人",f12));
table.addCell(cell);
cell = new PdfPCell();
cell.setFixedHeight(60);
cell.setColspan(2);
cell.setPadding(1);
iTable= new PdfPTable(2); 
iTable.setWidthPercentage(100);
iTable.setWidths(new float[]{0.65f,0.35f});
icell = new PdfPCell();
icell.setFixedHeight(43);
icell.setBorderColor(new Color(255, 255, 255));
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_TOP,0,2);
icell.setPhrase(getpar2(rprv+rcity+raddr,f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar("邮编："+rzipcode,f12));
icell=celltype(icell,Element.ALIGN_RIGHT,Element.ALIGN_TOP,0,2);
icell.setBorderColor(new Color(255, 255, 255));
iTable.addCell(icell);
icell = new PdfPCell();
icell.setBorderColor(new Color(255, 255, 255));
icell.setFixedHeight(15);
icell=celltype(icell,Element.ALIGN_RIGHT,Element.ALIGN_MIDDLE,0,2);
icell.setPhrase(getpar2(rname,f12));
//System.out.println(rname+"==="+rphone);
iTable.addCell(icell);
icell = new PdfPCell(getpar("电话："+rphone,f12));
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,0,2);
icell.setBorderColor(new Color(255, 255, 255));
iTable.addCell(icell);
cell.addElement(iTable);

table.addCell(cell);
cell = new PdfPCell();
cell.setColspan(2);
iTable= new PdfPTable(1); 
iTable.setWidthPercentage(100);
icell = new PdfPCell();
icell.setFixedHeight(25);
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,0,2);
icell.setPhrase(getpar("订单号："+odrid,f12));
iTable.addCell(icell);
icell = new PdfPCell();
icell.setFixedHeight(25);
icell=celltype(icell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,0,2);
icell.setPhrase(getpar("汽运",f18));
iTable.addCell(icell);
icell = new PdfPCell();
icell.setFixedHeight(60);
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_TOP,0,2);
icell.setPhrase(getpar("圆通速递将快件送达收件人。地址：经收件人或收件人（寄件人）允许的代收人签字，视为送达",f12));
iTable.addCell(icell);

cell.setBorderWidth(0);
cell.setPadding(0);
cell.addElement(iTable);
table.addCell(cell);
cell = new PdfPCell();
cell.setBorderWidth(0);
cell.setPadding(0);
PdfPTable iTable2= new PdfPTable(1); 
iTable2.setWidthPercentage(100);
icell = new PdfPCell();
icell.setFixedHeight(55);
icell.setPhrase(getpar("收件人签名\n\n\n证件号：\n                      年      月      日",f12));
iTable2.addCell(icell);       
icell = new PdfPCell();
icell.setFixedHeight(55);
icell.setPhrase(getpar("代收人姓名(签字)\n\n\n证件号：\n                      年      月      日",f12));
iTable2.addCell(icell);
cell.addElement(iTable2);
table.addCell(cell);
cells.addElement(table);
tables.addCell(cells);
icell = new PdfPCell();
icell.setFixedHeight(10);
tables.addCell(icell);
//**********************************************************
cells = new PdfPCell();
cells.setFixedHeight(185);
cells.setBorderWidth(0);
cells.setPadding(0);
iTable= new PdfPTable(1); 
 table = new PdfPTable(3);
table.setWidthPercentage(100);
table.setHorizontalAlignment(PdfPTable.ALIGN_LEFT);
table.setWidths(new float[]{0.07f,0.53f,0.40f});
cell=celltype(cell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,3,2);
cell.setFixedHeight(16);
cell.setPhrase(getpar("运单号："+shipcode+"                                       下联：此联由收件人留存",f12));
table.addCell(cell);
cell = new PdfPCell();
cell.setFixedHeight(45);
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,3,2);
table.addCell(cell);

cell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,0,0);
cell.setPhrase(getpar("收件人",f12));
table.addCell(cell);
cell = new PdfPCell();
cell.setFixedHeight(55);
cell.setColspan(2);
cell.setPadding(1);
iTable= new PdfPTable(2); 
iTable.setWidthPercentage(100);
iTable.setWidths(new float[]{0.65f,0.35f});
icell = new PdfPCell();
icell.setFixedHeight(38);
icell.setBorderColor(new Color(255, 255, 255));
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_TOP,0,2);
icell.setPhrase(getpar2(rprv+rcity+raddr,f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar("邮编："+rzipcode,f12));
icell=celltype(icell,Element.ALIGN_RIGHT,Element.ALIGN_TOP,0,2);
icell.setBorderColor(new Color(255, 255, 255));
iTable.addCell(icell);
icell = new PdfPCell();
icell.setBorderColor(new Color(255, 255, 255));
icell.setFixedHeight(15);
icell=celltype(icell,Element.ALIGN_RIGHT,Element.ALIGN_MIDDLE,0,2);
icell.setPhrase(getpar2(rname,f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar("电话："+rphone+"  ",f12));
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,0,2);
icell.setBorderColor(new Color(255, 255, 255));
iTable.addCell(icell);
cell.addElement(iTable);
table.addCell(cell);
table.addCell(getpar("详细内容",f12));
cell = new PdfPCell();
iTable= new PdfPTable(1); 
iTable.setWidthPercentage(100);
icell = new PdfPCell();
icell.setFixedHeight(18);
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,0,2);
icell.setPhrase(getpar("订单号："+odrid,f12));
iTable.addCell(icell);
icell = new PdfPCell();
icell.setFixedHeight(18);
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,0,2);
icell.setPhrase(getpar("发件人：D1优尚网",f12));
iTable.addCell(icell);
icell = new PdfPCell();
icell.setFixedHeight(33);
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,0,2);

icell.setPhrase(getpar("D1优尚网("+odrid+")广东省广州市,白云区",f12));
iTable.addCell(icell);
cell.setBorderWidth(0);
cell.setPadding(0);
cell.addElement(iTable);
table.addCell(cell);
cell = new PdfPCell();
cell.setPhrase(getpar("此运单仅代圆通速递签约客户使用，相关责任义务以双方合作合同为准。",f12));
table.addCell(cell);
cells.addElement(table);
tables.addCell(cells);
document.add(tables);

cellm.addElement(tables);
tablem.addCell(cellm);
}
document.add(tablem);

document.close();

DataOutput output = new DataOutputStream(response.getOutputStream());
byte[] bytes = buffer.toByteArray();
response.setContentLength(bytes.length+4);
//直接发送到客户端
for( int i = 0; i < bytes.length; i++ ) {
 output.writeByte( bytes[i] );
 }
%>