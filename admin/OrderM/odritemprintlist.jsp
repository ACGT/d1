<%@ page  language="java"  charset=UTF-8"   import="com.lowagie.text.Table,java.io.*,java.awt.Color,com.lowagie.text.*,com.lowagie.text.pdf.*"%><%@page 
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
java.text.*,
java.util.List,
java.io.*"%>
<%!public static Paragraph getpar(String str,Font fn){
	if(str.length()==0)return null;
	try{
	byte[] temp=str.getBytes("ISO-8859-1");//这里写原编码方式
    String newStr=new String(temp,"utf-8");//这里写转换后的编码方式
Paragraph par = new Paragraph(str,fn);
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
public static String getutf(String str){
	if(str.length()==0)return null;
	try{
	//byte[] temp=str.getBytes("ISO-8859-1");//这里写原编码方式
  //String newStr=new String(temp,"utf-8");//这里写转换后的编码方式

    return str;
	}catch(Exception ex){
		return null;
	}
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

response.setContentType("application/pdf;"); 
String odrids=request.getParameter("odrids");
if(odrids.endsWith(","))odrids=odrids.substring(0,odrids.length());
String[] odrs=odrids.split(",");
int odrlen=odrs.length;



Rectangle pageSize = new Rectangle(582,420*odrlen);//A5 宽582 高420 
Document document = new Document(pageSize, 0,0,0,0);//左 右 上下
ByteArrayOutputStream buffer = new ByteArrayOutputStream();
PdfWriter writer=PdfWriter.getInstance( document, buffer );
document.open();
//设置中文字体
BaseFont bfChinese =BaseFont.createFont( "STSong-Light","UniGB-UCS2-H",BaseFont.NOT_EMBEDDED);

PdfPTable tables = new PdfPTable(1);
tables.setWidthPercentage(100);


for(int i=0;i<odrlen;i++)
{
	String odrid=odrs[i];
	OrderMain odrm = (OrderMain)Tools.getManager(OrderMain.class).get(odrid);
	String rname=getutf(odrm.getOdrmst_rname().trim());
	String rphone=getutf(odrm.getOdrmst_rphone().trim());
	String rzipcode=getutf(odrm.getOdrmst_rzipcode());
	String rprv=getutf(odrm.getOdrmst_rprovince());
	String rcity=getutf(odrm.getOdrmst_rcity());
	String raddr=getutf(odrm.getOdrmst_raddress());
	rphone=rphone.length()>11?rphone.substring(0, 11):rphone;
PdfContentByte cb = writer.getDirectContent();

Barcode128 code128 = new Barcode128(); 
code128.setCode(odrid);   
String fullCode = code128.getRawText(odrid,false);
int len = fullCode.length();
code128.setX(130/((len+2)*11 + 2f));
Image image128 = code128.createImageWithBarcode(cb, null, null);   
//document.add(new Phrase(new Chunk(image128, 20, -50)));


Font f12 = new Font(bfChinese, 10, Font.BOLD, Color.BLACK);
Font f25 = new Font(bfChinese, 28, Font.BOLD, Color.BLACK);
Font f18 = new Font(bfChinese, 18, Font.BOLD, Color.BLACK);
// 添加table实例

PdfPCell cells = new PdfPCell();
cells.setFixedHeight(400);
cells.setBorderWidth(0);
cells.setPadding(10);
PdfPTable iTable= new PdfPTable(2); 
PdfPTable table = new PdfPTable(2);
PdfPTable iiTable= new PdfPTable(4); 
table.setWidthPercentage(100);
table.setHorizontalAlignment(PdfPTable.ALIGN_LEFT);
table.setWidths(new float[]{0.07f,0.93f});
PdfPCell cell = new PdfPCell();
PdfPCell icell = new PdfPCell();
PdfPCell iicell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,3,0);
cell.setBorderColor(new Color(255, 255, 255));
cell.setFixedHeight(20);
cell.setPhrase(getpar("D1优尚    发货单",f18));
table.addCell(cell);
/*cell = new PdfPCell(image128);
cell.setFixedHeight(40);
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_MIDDLE,1,2);
table.addCell(cell);
cells.addElement(table);
tables.addCell(cells);
 */
cell = new PdfPCell();
cell.setFixedHeight(60);
table.addCell(cell);
 
cell = new PdfPCell();
iTable.setWidthPercentage(100);
iTable.setWidths(new float[]{0.65f,0.35f});
icell = new PdfPCell();
icell.setFixedHeight(60);
icell.setBorderColor(new Color(255, 255, 255));
icell=celltype(icell,Element.ALIGN_LEFT,Element.ALIGN_TOP,0,0);
iiTable= new PdfPTable(2); 
iiTable.setWidthPercentage(100);
iiTable.setWidths(new float[]{0.45f,0.55f});

iicell = new PdfPCell(getpar("收货人："+rname,f12));
iicell.setFixedHeight(30);
iicell=celltype(iicell,Element.ALIGN_RIGHT,Element.ALIGN_TOP,0,2);
iicell.setBorderColor(new Color(255, 255, 255));
iiTable.addCell(iicell);
iicell = new PdfPCell(getpar("收货人电话："+rphone,f12));
iicell.setFixedHeight(30);
iicell=celltype(iicell,Element.ALIGN_RIGHT,Element.ALIGN_TOP,0,2);
iicell.setBorderColor(new Color(255, 255, 255));
iiTable.addCell(iicell);
iicell = new PdfPCell(getpar("收货人地址："+rprv+rcity+raddr,f12));
iicell.setFixedHeight(30);
iicell=celltype(iicell,Element.ALIGN_RIGHT,Element.ALIGN_TOP,2,2);
iicell.setBorderColor(new Color(255, 255, 255));
iiTable.addCell(iicell);

icell.addElement(iiTable);
iTable.addCell(icell);
icell = new PdfPCell(image128);
icell=celltype(icell,Element.ALIGN_CENTER,Element.ALIGN_TOP,0,0);
icell.setBorderColor(new Color(255, 255, 255));
iTable.addCell(icell);
cell.addElement(iTable);
table.addCell(cell);
cell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_TOP,2,0);
cell.setBorderColor(new Color(255, 255, 255));
iTable= new PdfPTable(7);
iTable.setWidthPercentage(100);
iTable.setWidths(new float[]{0.08f,0.14f,0.16f,0.16f,0.08f,0.12f,0.26f});
icell = new PdfPCell(getpar("序号",f12));
icell.setFixedHeight(30);
iTable.addCell(icell);
icell = new PdfPCell(getpar("编号",f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar("商品条码",f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar("货位",f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar("数据",f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar("单价",f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar("商品名称",f12));
iTable.addCell(icell);
List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
listRes.add(Restrictions.eq("odrdtl_odrid", odrid));
List<BaseEntity> list2 = Tools.getManager(OrderItemMain.class).getList(listRes, null, 0, 20);
int j=1;
long ogdscount=0;
for(BaseEntity be:list2){
	OrderItemBase oi= (OrderItemBase)be;
	String gdsname=getutf(oi.getOdrdtl_gdsname());
	gdsname=gdsname.replace("%", "");
	String gdsid=oi.getOdrdtl_gdsid();
	Product p=ProductHelper.getById(gdsid);
	if(p==null)continue;
	ogdscount=ogdscount+oi.getOdrdtl_gdscount().longValue();
icell = new PdfPCell(getpar(j+"",f12));
icell.setFixedHeight(30);
iTable.addCell(icell);
icell = new PdfPCell(getpar(gdsid,f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar(p.getGdsmst_barcode(),f12));
iTable.addCell(icell);
String siteno=p.getGdsmst_gdssite();
/*
if(odrm.getOdrmst_wareh() =="广州仓"){
	siteno=p.getGdsmst_gzgdssite();
}else if (odrm.getOdrmst_wareh()=="化验店仓"){
	siteno=p.getGdsmst_tydgdssite();
}*/
icell = new PdfPCell(getpar(siteno,f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar(oi.getOdrdtl_gdscount()+"",f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar(oi.getOdrdtl_finalprice()+"",f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar(gdsname,f12));
iTable.addCell(icell);
j++;
}
cell.addElement(iTable);
table.addCell(cell);

cell = new PdfPCell();
cell=celltype(cell,Element.ALIGN_CENTER,Element.ALIGN_TOP,2,0);
cell.setBorderColor(new Color(255, 255, 255));
iTable= new PdfPTable(5);
iTable.setWidthPercentage(100);
iTable.setWidths(new float[]{0.20f,0.20f,0.20f,0.20f,0.20f});
icell = new PdfPCell(getpar("配送费："+odrm.getOdrmst_shipfee()+"元",f12));
icell.setFixedHeight(30);
iTable.addCell(icell);
icell = new PdfPCell(getpar("商品金额："+odrm.getOdrmst_gdsmoney()+"元",f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar("商品数量："+ogdscount,f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar("优惠金额："+odrm.getOdrmst_tktvalue()+"元",f12));
iTable.addCell(icell);
icell = new PdfPCell(getpar("应付金额："+odrm.getOdrmst_acturepaymoney()+"元",f12));
iTable.addCell(icell);

cell.addElement(iTable);
table.addCell(cell);

cells.addElement(table);
tables.addCell(cells);
}
document.add(tables);
document.close();

DataOutput output = new DataOutputStream(response.getOutputStream());
byte[] bytes = buffer.toByteArray();
response.setContentLength(bytes.length+4);
//直接发送到客户端
for( int i = 0; i < bytes.length; i++ ) {
 output.writeByte( bytes[i] );
 }
%>