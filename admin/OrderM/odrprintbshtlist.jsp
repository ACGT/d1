<%@ page  language="java"   %><%@page 
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
java.util.HashMap,
java.util.Map,
net.sf.json.JSONArray,
com.itextpdf.text.*,
com.itextpdf.text.pdf.*,
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
public static String gettogbk(String str){
	if(str.length()==0)return null;
	try{
	byte[] temp=str.getBytes("ISO-8859-1");//这里写原编码方式
    String newStr=new String(temp,"GDK");//这里写转换后的编码方式
    return newStr;
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
	 cell.setBorderColor(new BaseColor(255, 255, 255));
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
<%
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "odr_printyt");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}
String pcnos=request.getParameter("pcnos");
List<OrderMain> odrlist=getOrderlist(pcnos);
response.setContentType("application/pdf;");
int odrnum=odrlist.size();

Rectangle pageSize = new Rectangle(283,482*odrnum);
Document document = new Document(pageSize, 0,0,0,0);//左 右 上下
ByteArrayOutputStream buffer = new ByteArrayOutputStream();
PdfWriter writer=PdfWriter.getInstance( document, buffer );
document.open();
//设置中文字体
BaseFont bfChinese =BaseFont.createFont( "STSong-Light","UniGB-UCS2-H",BaseFont.NOT_EMBEDDED);


PdfPTable tablem = new PdfPTable(1);
tablem.setWidthPercentage(100);
PdfPCell cellm = new PdfPCell();

for(OrderMain odrm:odrlist){
String bigPen=odrm.getOdrmst_ads1();
String shipcode=odrm.getOdrmst_goodsodrid();
if(Tools.isNull(shipcode))continue;
String rname=odrm.getOdrmst_rname().trim();
String rphone=odrm.getOdrmst_rphone().trim();
String rzipcode=odrm.getOdrmst_rzipcode();
String rprv=odrm.getOdrmst_rprovince();
String rcity=odrm.getOdrmst_rcity();
String raddr=odrm.getOdrmst_raddress();

rphone=rphone.length()>11?rphone.substring(0, 11):rphone;
 

//=========添加条形码begin===================
PdfContentByte cd = writer.getDirectContent();

Barcode128 code128 = new Barcode128();

code128.setCode(shipcode);
String fullCode = code128.getRawText(shipcode,false);
int len = fullCode.length();
code128.setX(130/((len+2)*11 + 2f));
Image image128 = code128.createImageWithBarcode(cd, null, null);

//=========添加条形码end===================
 
//document.add(new Phrase(new Chunk(image128, 20, -50)));

Font f9 = new Font(bfChinese, 9, Font.BOLD);
Font f12 = new Font(bfChinese, 10, Font.BOLD);
Font f26 = new Font(bfChinese, 26, Font.BOLD);
Font f20 = new Font(bfChinese, 20, Font.BOLD);
Font f18 = new Font(bfChinese, 18, Font.BOLD);
Font f14 = new Font(bfChinese, 12, Font.BOLD);

cellm = new PdfPCell();
// 添加table实例
PdfPTable tables = new PdfPTable(1);
tables.setWidthPercentage(100);
PdfPCell cells = new PdfPCell();
cells.setFixedHeight(255);
cells.setBorderWidth(0);
cells.setPadding(0);
PdfPTable iTable= new PdfPTable(1); 
PdfPTable table = new PdfPTable(3);
table.setWidthPercentage(100);
table.setHorizontalAlignment(PdfPTable.ALIGN_LEFT);
table.setWidths(new float[]{0.08f,0.46f,0.46f});
PdfPCell cell = new PdfPCell();
PdfPCell icell = new PdfPCell();
cell = new PdfPCell();
cell.setFixedHeight(39);
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,0,0);
table.addCell(cell);
cell = new PdfPCell();
cell.setFixedHeight(35);
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_TOP,0,2);
cell.setPhrase(getpar("标准快递\n成就商业   精彩生活  ",f12));
/*iTable= new PdfPTable(1); 
iTable.setWidthPercentage(100);
icell = new PdfPCell();
icell.setFixedHeight(18);
icell=celltype(icell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,0,0);
icell.setPhrase(getpar("            标准快递",f14));
iTable.addCell(icell);
icell = new PdfPCell();
icell=celltype(icell,Element.ALIGN_RIGHT,Element.ALIGN_MIDDLE,0,0);
icell.setFixedHeight(15);
icell.setPhrase(getpar("成就商业   精彩生活                       ",f12));
iTable.addCell(icell);
cell.addElement(iTable);
table.addCell(cell);
*/
table.addCell(cell);
cell = new PdfPCell(image128);
cell.setFixedHeight(40);
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,0,0);

table.addCell(cell);
//收件人开始
cell = new PdfPCell();
cell.setFixedHeight(53);
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,0,0);
//cell.setPhrase(getpar("收件人",f12));
table.addCell(cell);
cell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_LEFT,Element.ALIGN_TOP,2,0);

iTable= new PdfPTable(1); 
iTable.setWidthPercentage(100);
icell = new PdfPCell();
icell.setFixedHeight(15);
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,0,0);
icell.setPhrase(getpar2(rname,f12));
iTable.addCell(icell);
icell = new PdfPCell();
icell.setFixedHeight(15);
icell = new PdfPCell(getpar("电话："+rphone,f12));
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,0,0);
iTable.addCell(icell);

icell = new PdfPCell();
icell.setFixedHeight(23);

icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_TOP,0,0);
icell.setPhrase(getpar2(rprv+rcity+raddr,f12));
iTable.addCell(icell);
cell.addElement(iTable);
table.addCell(cell);

//收件人结束
//寄件人开始
cell = new PdfPCell();
cell.setFixedHeight(46);
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,0,0);
//cell.setPhrase(getpar("寄件人",f12));
table.addCell(cell);
cell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,2,0);

iTable= new PdfPTable(2); 
iTable.setWidthPercentage(100);
iTable.setWidths(new float[]{0.65f,0.35f});
icell = new PdfPCell();

icell.setFixedHeight(48);
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_TOP,0,0);
icell.setPhrase(getpar("D1优尚\n电话：400-680-8666\n地址：广州市 白云区",f9));
iTable.addCell(icell);
icell = new PdfPCell();
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_TOP,0,0);

icell.setPhrase(getpar("代收/到付：\n保价金额\n保价费用\n其它说明",f9));
iTable.addCell(icell);
cell.addElement(iTable);
table.addCell(cell);
//寄件人结束
cell = new PdfPCell();
cell.setFixedHeight(40);
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,0,0);
//cell.setPhrase(getpar("目的地",f12));
table.addCell(cell);
cell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_LEFT,Element.ALIGN_TOP,2,0);
cell.setPhrase(getpar2(bigPen,f26));
table.addCell(cell);


com.itextpdf.text.Image qrCodeImage=createQrcode.generateQR(shipcode);
qrCodeImage.scaleToFit(55,55);  
SimpleDateFormat format=new SimpleDateFormat("yyyy/MM/dd");
cell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,3,0);
iTable= new PdfPTable(2); 
iTable.setWidthPercentage(100);
iTable.setWidths(new float[]{0.30f,0.70f});
icell = new PdfPCell(qrCodeImage);
icell.setFixedHeight(55);
icell=celltype(icell,Element.ALIGN_CENTER,Element.ALIGN_TOP,0,0);
iTable.addCell(icell);
icell = new PdfPCell();
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_TOP,0,0);
icell.setPhrase(getpar("收件人签收\n\n\n运单编号"+shipcode+"\n打印日期"+format.format(new Date()),f9));
iTable.addCell(icell);
cell.addElement(iTable);
table.addCell(cell);
 

//上联结束
cells.addElement(table);
tables.addCell(cells);

//**********************************************************
cells = new PdfPCell();
cells.setFixedHeight(227);
cells.setBorderWidth(0);
cells.setPadding(0);
iTable= new PdfPTable(1); 
 table = new PdfPTable(3);
table.setWidthPercentage(100);
table.setHorizontalAlignment(PdfPTable.ALIGN_LEFT);
table.setWidths(new float[]{0.07f,0.53f,0.40f});

//下联开始
cell = new PdfPCell();
cell.setFixedHeight(39);
cell.setPaddingLeft(6);
cell = new PdfPCell(image128);
cell=celltype(cell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,3,2);
table.addCell(cell);
//收件人开始
cell = new PdfPCell();
cell.setFixedHeight(43);
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,0,0);
//cell.setPhrase(getpar("收货人",f12));
table.addCell(cell);
cell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_LEFT,Element.ALIGN_TOP,0,2);
cell.setPhrase(getpar2("      "+rname+"\n"+rprv+rcity+raddr,f12));
table.addCell(cell);
cell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_LEFT,Element.ALIGN_TOP,0,0);
cell.setPhrase(getpar("电话："+rphone,f12));
table.addCell(cell);
//收件人结束
//寄件人开始
cell = new PdfPCell();
cell.setFixedHeight(43);
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,0,0);
//cell.setPhrase(getpar("寄件人",f12));
table.addCell(cell);
cell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,2,0);

iTable= new PdfPTable(2); 
iTable.setWidthPercentage(100);
iTable.setWidths(new float[]{0.65f,0.35f});
icell = new PdfPCell();
icell.setFixedHeight(43);
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,0,0);
icell.setPhrase(getpar("      D1优尚\n电话：400-680-8666\n地址：广州市 白云区",f9));
iTable.addCell(icell);
icell = new PdfPCell();
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_MIDDLE,0,0);
icell.setPhrase(getpar("代收/到付：\n保价金额\n保价费用\n其它说明",f9));
iTable.addCell(icell);
cell.addElement(iTable);
table.addCell(cell);
//寄件人结束
cell = new PdfPCell();
cell.setFixedHeight(25);
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,0,0);
//cell.setPhrase(getpar("目的地",f12));
table.addCell(cell);
cell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,2,0);
cell.setPhrase(getpar2(bigPen,f20));
table.addCell(cell);

cell = new PdfPCell(qrCodeImage);
cell.setFixedHeight(99);
cell=celltype(cell,Element.ALIGN_RIGHT,Element.ALIGN_TOP,3,0);
table.addCell(cell);



cells.addElement(table);
tables.addCell(cells);


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