<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%>
<%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%@include file="/admin/public.jsp"%>
<%
if(session.getAttribute("type_flag")!=null){
	String userid = "";
	if(session.getAttribute("admin_mng") != null){
		userid = session.getAttribute("admin_mng").toString();
	}
	String powername = "d1shop_gdsadd";
	boolean is_power = chk_admpower(userid,powername);
	if(!is_power){
		out.print("对不起，您没有操作权限！");
		return;	
	}
}
%>
<%!
 static String getPid(String rackcode){
	String gdsid="";
	ArrayList<Product> list=ProductHelper. getMaxgdsid(rackcode);
	if(list!=null && list.size()>0){
		Product p=list.get(0);
		int maxid=Tools.parseInt(p.getId().substring(3, p.getId().length()));
		gdsid=p.getId().substring(0,3)+new DecimalFormat("00000").format(maxid+1);
		
	} 
	else
	{
		gdsid=rackcode.substring(0,3)+"00001";
	}
	return gdsid;
} 

//获取商家信息
private ArrayList<ShpMst> getShopM(String shopcode)
	{
		ArrayList<ShpMst> rlist = new ArrayList<ShpMst>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("id", shopcode));
		List<BaseEntity> list = Tools.getManager(ShpMst.class).getList(clist, null, 0, 1);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ShpMst)be);
		}
		
		return rlist ;
		
	}

%>


<%
	String shopgoodscode=request.getParameter("sc");
    String gdsbarcode=request.getParameter("gdsbarcode");
	String g_name=request.getParameter("name");
	String ename=request.getParameter("ename");
	String code=request.getParameter("code");
	String bname=request.getParameter("bname");
	String shoprck=request.getParameter("shoprck");
	String provider=request.getParameter("provider");
	String othercost=request.getParameter("othercost");
	if(!Tools.isNull(shoprck)){
		shoprck=","+shoprck;
	}
	String scj=request.getParameter("scj");
	float scjn=Tools.parseFloat(scj);
	String m=request.getParameter("m");
	String inp=request.getParameter("inp");
	float mn=Tools.parseFloat(m);
	String cxj=request.getParameter("cxj");
	float cxjn=Tools.parseFloat(cxj);
	String zk=request.getParameter("zk");
	String cd=request.getParameter("cd");
	String begin=request.getParameter("begin");
	String end=request.getParameter("end");
	String des=request.getParameter("des");
	String ddes=request.getParameter("ddes");
	String a1=request.getParameter("a1");
	String specialflag=request.getParameter("specialflag");
	
	if(a1.indexOf(",")>0) { a1=a1.substring(0, a1.length()-1);}
	String a2=request.getParameter("a2");
	if(a2.indexOf(",")>0) { a2=a2.substring(0, a2.length()-1);}
	String a3=request.getParameter("a3");
	if(a3.indexOf(",")>0) { a3=a3.substring(0, a3.length()-1);}
	String a4=request.getParameter("a4");
	if(a4.indexOf(",")>0) { a4=a4.substring(0, a4.length()-1);}
	String a5=request.getParameter("a5");
	if(a5.indexOf(",")>0) { a5=a5.substring(0, a5.length()-1);}
	String a6=request.getParameter("a6");
	if(a6.indexOf(",")>0) { a6=a6.substring(0, a6.length()-1);}
	String a7=request.getParameter("a7");
	if(a7.indexOf(",")>0) { a7=a7.substring(0, a7.length()-1);}
	String a8=request.getParameter("a8");
	if(a8.indexOf(",")>0) { a8=a8.substring(0, a8.length()-1);}
	String a9=request.getParameter("a9");
	if(a9.indexOf(",")>0) { a9=a9.substring(0, a9.length()-1);}
	String a10=request.getParameter("a10");
	if(a10.indexOf(",")>0) { a10=a10.substring(0, a10.length()-1);}
	String a11=request.getParameter("a11");
	if(a11.indexOf(",")>0) { a11=a11.substring(0, a11.length()-1);}
	String a12=request.getParameter("a12");
	if(a12.indexOf(",")>0) { a12=a12.substring(0, a12.length()-1);}
	String sku=request.getParameter("skuname");
	String bcode=request.getParameter("bcode");
	String gdsgrep=request.getParameter("gdsgrep");
	if(sku.equals("无")){
		sku="";
	}
	if(Tools.isNull(othercost)||othercost.equals("null")){
		othercost="0";
	}
	String kc1=request.getParameter("kc1");
	String if_sku=request.getParameter("skuname");
	String buylimit="0";//最大购买数量
	String stock="0";//商品库存
	String vituralstock="";//虚拟库存
	String tm=gdsbarcode;//商品条码
	String yxq="";//有效期
	String sex="2";
	String gdsmst_ifhavegds="";
	String flag="";//上下架标志
	String gift="";//单品赠品
	String shsm="";//生产商/售后服务说明
	String key="";//关键字
	float vipprice=mn;
	//图片
	String gdsmst_bigimg="";//超大图地址，尺寸不定
	String gdsmst_imgurl="";//200*200图片地址
	String gdsmst_smallimg="";//80*80图片地址
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
	
	String unique_code = "";
	if(session.getAttribute("unique_code")!=null){
		unique_code = session.getAttribute("unique_code").toString();//添加人
	}
	
	String provide=request.getParameter("provide");
	String gdsmst_provideStr=request.getParameter("gdsmst_provideStr");
	
	 
	//判断金钱
	if(!Tools.isMoney(scj))
	{
		out.print("{\"success\":false,\"message\":\"市场价不是有效的金钱格式！\"}");
		return;
	}
	if(!Tools.isMoney(m))
	{
		out.print("{\"success\":false,\"message\":\"D1价不是有效的金钱格式！\"}");
		return;
	}
	if(!Tools.isNull(cxj)&&!Tools.isMoney(cxj))
	{
		out.print("{\"success\":false,\"message\":\"促销价不是有效的金钱格式！\"}");
		return;
	}
	if(Tools.parseFloat(cxj)==0f){
		begin=null;
		end=null;
	}
	SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	if(!Tools.isNull(begin)&&!Tools.isNull(end))
	{
	    Date dabegin=new Date();
	   long b=Tools.parseJsDate(begin);
	    long e=Tools.parseJsDate(end);
	    if(sf.parse(begin).getTime()>= sf.parse(end).getTime())
	    {
	    	out.print("{\"success\":false,\"message\":\"促销开始时间不得大于等于促销结束时间！\"}");
	    	return;
	    }	    
	    if(Tools.getDateDiff(ft.format(ft.parse(begin)),ft.format(ft.parse(end)))>=31){
	    	out.print("{\"success\":false,\"message\":\"促销时间范围在30天内！\"}");
	    	return;
	    }
	}
	
	if(!Tools.isMoney(inp))
	{
		inp="0";
	}
	
	//获取规格id
	String stdid="";
	Directory dir=DirectoryHelper.getById(code);
	if(dir!=null)
	{
		if(dir.getRakmst_stdid()!=null&&dir.getRakmst_stdid().toString().length()>0)
		{			
			stdid=dir.getRakmst_stdid().toString();			
		}
		else
		{
			Directory dir1=DirectoryHelper.getById(dir.getRakmst_parentrackcode());
			if(dir1!=null&&dir1.getRakmst_stdid().length()>0)
			{				
				stdid=dir1.getRakmst_stdid();
			}
		}
	}
	if(bname.equals("无品牌")){
		bname="";
	}
	
	//向表里添加数据
	 SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
	
	 
	
	//新建商品
	String[] arrgdslist=null;
	String strgdsid="";
	String shopCode=session.getAttribute("shopcodelog").toString();
	 ShpMst  shpm=(ShpMst)Tools.getManager(ShpMst.class).get(shopCode);
	if(gdsgrep!=null&&gdsgrep.length()>0){
		gdsgrep=gdsgrep.replace("，", ",");
	 if(gdsgrep.indexOf(",")>=0){
		 arrgdslist=gdsgrep.split(",");
	 }
	}
	 if(arrgdslist!=null&&arrgdslist.length>=2){
		 GoodsGroup ggroup=new GoodsGroup();
		 ggroup.setGdsgrpmst_title(g_name);
		 ggroup.setGdsgrpmst_stdname("规格");
		 ggroup.setGdsgrpmst_shopcode(shopCode);
		 ggroup.setGdsgrpmst_createtime(new Date());
		 ggroup=(GoodsGroup)Tools.getManager(GoodsGroup.class).create(ggroup);
		 String gmstid=ggroup.getId();
		 String gdsone="";
		 String gdsnameone="";
	 for(int i=0;i<arrgdslist.length;i++){
		
		 String gdsid=ProductHelper.getPid(code.substring(0,3));
		 if(i==0){
			 gdsone=gdsid;
			 gdsnameone=arrgdslist[i];
			 strgdsid=gdsid;
		 }else{
			 strgdsid+=","+gdsid;
		 }
		 GoodsGroupDetail ggroupd=new GoodsGroupDetail();
		 ggroupd.setGdsgrpdtl_gdsid(gdsid);
		 ggroupd.setGdsgrpdtl_mstid(new Long(gmstid));
		 ggroupd.setGdsgrpdtl_stdvalue(arrgdslist[i]);
		 ggroupd.setGdsgrpdtl_createtime(new Date());
		 Tools.getManager(GoodsGroupDetail.class).create(ggroupd);
		 
		Product product=new Product();	
		
		product.setGdsmst_shopgoodscode(shopgoodscode);
		product.setGdsmst_shopcode(shopCode);//商户编码
		product.setGdsmst_provide(provide);//主要供应商
		product.setGdsmst_provideStr(gdsmst_provideStr);//其他供应商
		product.setId(gdsid);//商品编码
		product.setGdsmst_inputmngid(unique_code);
		product.setGdsmst_createdate(new Date());
		product.setGdsmst_autoupdatedate(new Date());
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
		product.setGdsmst_downflag(new Long(1));
		product.setGdsmst_sendcount(new Long(0));
		product.setGdsmst_salecount(new Long(0));
		product.setGdsmst_discounflag(new Long(1));
		product.setGdsmst_enddateend(format.parse("2999-01-01"));
		product.setGdsmst_beginstart(new Date());
		product.setGdsmst_presellflag(new Long(0));
		product.setGdsmst_validflag(new Long(0));
		product.setGdsmst_refcount(new Long(0));
		product.setGdsmst_hitcount(new Long(0));
		product.setGdsmst_title(ename);
		product.setGdsmst_gdsename("");
		product.setGdsmst_paymethod("-1");
		product.setGdsmst_sndmethod("");
		//product.setGdsmst_provide("");	
		product.setGdsmst_othercost(new Float(othercost));
		product.setGdsmst_provider(provider);
		if(!Tools.isNull(bname)){
		product.setGdsmst_gdsname("【"+bname.trim()+"】"+g_name+"("+arrgdslist[i]+")");
		}else{
		product.setGdsmst_gdsname(g_name+"("+arrgdslist[i]+")");
		}
		if(begin!=null&&begin.length()>0)
		{
		    product.setGdsmst_promotionstart(sf.parse(begin));
		}else{
			product.setGdsmst_promotionstart(null);
		}
		if(end!=null&&end.length()>0)
		{
			 product.setGdsmst_promotionend(sf.parse(end));
		   // product.setGdsmst_discountenddate(format.parse(end));
		}else{
			product.setGdsmst_promotionend(null);
		}

		/*if(!Tools.isNull(cxj)){
			
			product.setGdsmst_oldmemberprice(new Float(m));
			product.setGdsmst_memberprice(new Float(cxj));
			product.setGdsmst_vipprice(new Float(cxj));	
			product.setGdsmst_oldvipprice(new Float(m));	
		}
		else
		{*/
			if(!Tools.isNull(cxj)){
				product.setGdsmst_msprice(new Float(cxj));
				}else{
					product.setGdsmst_msprice(new Float(0));
				}
			product.setGdsmst_oldmemberprice(0f);
			product.setGdsmst_memberprice(new Float(m));
			product.setGdsmst_vipprice(new Float(m));	
			product.setGdsmst_oldvipprice(0f);
		//}
		
		if(specialflag.equals("1")){		
		    product.setGdsmst_specialflag(new Long(1));
		}
		else
		{                     
			product.setGdsmst_specialflag(new Long(0));	
		}
		product.setGdsmst_giftselecttype(new Long(0));
		if(Tools.isNull(stdid)){
			stdid="0";
		}
		product.setGdsmst_stdid(stdid);	
		product.setGdsmst_ifhavegds(new Long(0));
		product.setGdsmst_manufacture("");
		product.setGdsmst_keyword("");
		product.setGdsmst_brand(bcode);	
		product.setGdsmst_brandname(bname);
		product.setGdsmst_briefintrduce(des);
		product.setGdsmst_barcode(tm);
		product.setGdsmst_buylimit(new Long(0));
		product.setGdsmst_detailintruduce(ddes);
		product.setGdsmst_inprice(new Float(inp));
		product.setGdsmst_saleprice(new Float(scj));
		product.setGdsmst_rackcode(code);
		product.setGdsmst_skuname1(sku);
		
		if(!if_sku.equals("无")){
			if(Tools.isNull(stock)){
				stock="0";
			}
			product.setGdsmst_stock(new Long(stock));//库存
			if(Tools.isNull(vituralstock)){
				vituralstock="5";
			}
			product.setGdsmst_virtualstock(new Long(stock));
		}else{//选择无SKU时，写入库存和虚拟库存
			product.setGdsmst_stock(new Long(kc1));//库存
			product.setGdsmst_virtualstock(new Long(kc1));
		}
		
		product.setGdsmst_stdvalue1(a1);
		product.setGdsmst_stdvalue2(a2);
		product.setGdsmst_stdvalue3(a3);
		product.setGdsmst_stdvalue4(a4);
		product.setGdsmst_stdvalue5(a5);
		product.setGdsmst_stdvalue6(a6);
		product.setGdsmst_stdvalue7(a7);
		product.setGdsmst_stdvalue8(a8);
		product.setGdsmst_stdvalue9(a9);
		product.setGdsmst_stdvalue10(a10);
		product.setGdsmst_stdvalue11(a11);

		product.setGdsmst_stdvalue12(a12);
		product.setGdsmst_wsalecount(new Long(0));
		product.setGdsmst_updatedate(new Date());
		if(Tools.isNull(sex)){
			sex="2";
		}
		product.setGdsmst_sex(new Long(sex));
		product.setGdsmst_bigimg(gdsmst_bigimg);
		product.setGdsmst_fzimg(gdsmst_fzimg);
		product.setGdsmst_imgurl(gdsmst_imgurl);
		product.setGdsmst_smallimg(gdsmst_smallimg);
		product.setGdsmst_bigimg(gdsmst_bigimg);
		product.setGdsmst_midimg(gdsmst_midimg);
		product.setGdsmst_recimg(gdsmst_recimg);
		product.setGdsmst_img200250(gdsmst_img200250);
		product.setGdsmst_img240300(gdsmst_img240300);		
	    product.setGdsmst_provenance(cd);    
	    product.setGdsmst_shoprck(shoprck);
	    if(shpm.getShpmst_sendtype().longValue()!=2){
	    product.setGdsmst_stocklinkty(new Long(0));
	    }else{
	    	product.setGdsmst_stocklinkty(new Long(1));
	    }
	    product=(Product)Tools.getManager(Product.class).create(product);
		
	   
	 }
	 if(!Tools.isNull(gdsone))
	    {
	    	out.print("{\"success\":true,\"message\":\"录入商品成功！\",\"gdsid\":\""+gdsone+"\",\"strgdsid\":\""+strgdsid+"\",\"gdsstd\":\""+gdsnameone+"\"}");
	    }
	    else
	    {
	    	out.print("{\"success\":false,\"message\":\"录入商品失败，请联系客服！\"}");
	    }
	}else{
		 String gdsid=getPid(code.substring(0,3));
	Product product=new Product();	
	product.setGdsmst_shopgoodscode(shopgoodscode);
	product.setGdsmst_shopcode(shopCode);//商户编码
	product.setGdsmst_provide(provide);//主要供应商
	product.setGdsmst_provideStr(gdsmst_provideStr);//其他供应商
	product.setId(gdsid);//商品编码
	product.setGdsmst_inputmngid(unique_code);
	product.setGdsmst_createdate(new Date());
	product.setGdsmst_autoupdatedate(new Date());
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
	product.setGdsmst_enddateend(format.parse("2999-01-01"));
	product.setGdsmst_srcstatus(new Long(0));
	product.setGdsmst_downflag(new Long(1));
	product.setGdsmst_sendcount(new Long(0));
	product.setGdsmst_salecount(new Long(0));
	product.setGdsmst_discounflag(new Long(1));

	product.setGdsmst_beginstart(new Date());
	product.setGdsmst_presellflag(new Long(0));
	product.setGdsmst_validflag(new Long(0));
	product.setGdsmst_refcount(new Long(0));
	product.setGdsmst_hitcount(new Long(0));
	product.setGdsmst_title(ename);
	product.setGdsmst_gdsename("");
	product.setGdsmst_paymethod("-1");
	product.setGdsmst_sndmethod("");
	//product.setGdsmst_provide("");	
	product.setGdsmst_othercost(new Float(othercost));
	product.setGdsmst_provider(provider);

	if(!Tools.isNull(bname)){
	product.setGdsmst_gdsname("【"+bname.trim()+"】"+g_name);
	}else{
	product.setGdsmst_gdsname(g_name);
	}

	if(begin!=null&&begin.length()>0)
	{
	    product.setGdsmst_promotionstart(format.parse(begin));
	}else{
		product.setGdsmst_promotionstart(null);
	}
	if(end!=null&&end.length()>0)
	{
		 product.setGdsmst_promotionend(format.parse(end));
	   // product.setGdsmst_discountenddate(format.parse(end));
	}else{
		product.setGdsmst_promotionend(null);
	}

	/*if(!Tools.isNull(cxj)){
		
		product.setGdsmst_oldmemberprice(new Float(m));
		product.setGdsmst_memberprice(new Float(cxj));
		product.setGdsmst_vipprice(new Float(cxj));	
		product.setGdsmst_oldvipprice(new Float(m));	
	}
	else
	{*/
		if(!Tools.isNull(cxj)){
		product.setGdsmst_msprice(new Float(cxj));
		}else{
			product.setGdsmst_msprice(new Float(0f));
		}
		product.setGdsmst_oldmemberprice(0f);
		product.setGdsmst_memberprice(new Float(m));
		product.setGdsmst_vipprice(new Float(m));	
		product.setGdsmst_oldvipprice(0f);
	//}
		if(specialflag.equals("1")){	
	    product.setGdsmst_specialflag(new Long(1));
	}
	else
	{
		product.setGdsmst_specialflag(new Long(0));	
	}
	product.setGdsmst_giftselecttype(new Long(0));
	if(Tools.isNull(stdid)){
		stdid="0";
	}

	product.setGdsmst_stdid(stdid);	
	product.setGdsmst_ifhavegds(new Long(0));
	product.setGdsmst_manufacture("");
	product.setGdsmst_keyword("");
	product.setGdsmst_brand(bcode);	
	product.setGdsmst_brandname(bname);
	product.setGdsmst_briefintrduce(des);
	product.setGdsmst_barcode(tm);
	product.setGdsmst_buylimit(new Long(0));
	product.setGdsmst_detailintruduce(ddes);
	product.setGdsmst_inprice(new Float(inp));
	product.setGdsmst_saleprice(new Float(scj));
	product.setGdsmst_rackcode(code);
	product.setGdsmst_skuname1(sku);
	if(!if_sku.equals("无")){
		if(Tools.isNull(stock)){
			stock="0";
		}
		product.setGdsmst_stock(new Long(stock));//库存
		if(Tools.isNull(vituralstock)){
			vituralstock="5";
		}
		product.setGdsmst_virtualstock(new Long(stock));
	}else{//选择无SKU时，写入库存和虚拟库存
		product.setGdsmst_stock(new Long(kc1));//库存
		product.setGdsmst_virtualstock(new Long(kc1));
	}
	product.setGdsmst_stdvalue1(a1);
	product.setGdsmst_stdvalue2(a2);
	product.setGdsmst_stdvalue3(a3);
	product.setGdsmst_stdvalue4(a4);
	product.setGdsmst_stdvalue5(a5);
	product.setGdsmst_stdvalue6(a6);
	product.setGdsmst_stdvalue7(a7);
	product.setGdsmst_stdvalue8(a8);
	product.setGdsmst_stdvalue9(a9);
	product.setGdsmst_stdvalue10(a10);
	product.setGdsmst_stdvalue11(a11);
	
	product.setGdsmst_stdvalue12(a12);
	product.setGdsmst_wsalecount(new Long(0));
	product.setGdsmst_updatedate(new Date());
	if(Tools.isNull(sex)){
		sex="2";
	}
	product.setGdsmst_sex(new Long(sex));
	product.setGdsmst_bigimg(gdsmst_bigimg);
	product.setGdsmst_fzimg(gdsmst_fzimg);
	product.setGdsmst_imgurl(gdsmst_imgurl);
	product.setGdsmst_smallimg(gdsmst_smallimg);
	product.setGdsmst_bigimg(gdsmst_bigimg);
	product.setGdsmst_midimg(gdsmst_midimg);
	product.setGdsmst_recimg(gdsmst_recimg);
	product.setGdsmst_img200250(gdsmst_img200250);
	product.setGdsmst_img240300(gdsmst_img240300);		
    product.setGdsmst_provenance(cd);    
    product.setGdsmst_shoprck(shoprck);
    if(shpm.getShpmst_sendtype().longValue()!=2){
	    product.setGdsmst_stocklinkty(new Long(0));
	    }else{
	    	product.setGdsmst_stocklinkty(new Long(1));
	    }
    product=(Product)Tools.getManager(Product.class).create(product);
	
    if(!Tools.isNull(product.getId()))
    {
    	out.print("{\"success\":true,\"message\":\"录入商品成功！\",\"gdsid\":\""+product.getId()+"\",\"strgdsid\":\""+strgdsid+"\",\"gdsstd\":\"\"}");
    }
    else
    {
    	out.print("{\"success\":false,\"message\":\"录入商品失败，请联系客服！\"}");
    }
	}
	
	
%>