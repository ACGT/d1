<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkrgt.jsp"%><%!
static ArrayList<GdsCutImg> getByGdsid(String gdsid){
	ArrayList<GdsCutImg> list=new ArrayList<GdsCutImg>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_gdsid", gdsid));
	List<BaseEntity> b_list = Tools.getManager(GdsCutImg.class).getList(clist, null, 0,1);
	if(b_list==null || b_list.size()==0) return null;		
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((GdsCutImg)be);
		}
	}	
	
     return list;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品信息修改/录入</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="js.js"></script>
<style type="text/css">

</style>
<script type="text/javascript">
function checkgdsname(){
	var gdsname=$.trim($("#txtgdsname").val());
	if(gdsname.length==0){
		alert("商品名称不能为空！");
		return false;
	}
	return true;
}
function checkbrand(){
	var brandcode=$.trim($("#brand").val());
	if(brandcode.length==0){
		alert("请选择品牌");
	}else{
		$("#brandcode").val(brandcode);
		return true;
	}
}
function checkgg(){
	var gg=$.trim($("#standid").val());
	if(gg.length==0){
		alert("请选择规格");
		return false;
	}else{
		return true;
	}
}
function checksex(){
	var sex=$.trim($("#gdssex").val());
	if(sex.length==0){
		alert("请选择商品男女分类");
		return false;	
	}
	return true;
	
}
function getrackcode(){
	var rackcode="";
	if($("#rackcode5").val()!=null){
		rackcode=$("#rackcode5").val();
	}else{
		if($("#rackcode4").val()!=null){
			rackcode=$("#rackcode4").val();
		}else{
			if($("#rackcode3").val()!=null){
				rackcode=$("#rackcode3").val();
			}else{
				if($("#rackcode2").val()!=null){
					rackcode=$("#rackcode2").val();
				}
			}
		}
	}
	if(rackcode.length==0){
		alert("请选择分类");
		return false;
	}
	$("#rackcode").val(rackcode);
	return true;
}

function check(){
	if(checkgdsname() && checkbrand() && getrackcode() ){
		
		var editor = FCKeditorAPI.GetInstance("FCKeditor1");
		var memo=editor.EditorDocument.body.innerHTML;//获得文本编辑器内容
		$("#newmemo").val(memo);
		
		$("#form1").submit();
	}
	
}

</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form id="form1" name="form1" action="addgds.jsp"  method="post" enctype="multipart/form-data" >
<input type="hidden" id="newmemo" name="newmemo" />
<input type="hidden" id="brandcode" name="brandcode" />
<table>
		<tr><td valign="top">
		<table>
<%
String shopcode="03050801";
String gdsname="";//商品名称
String rackcode="";//商品分类编号
String brandcode="";//品牌编号
String brandname="";//品牌名称
String ggid="";//规格编号
String stdothervalues="";//其他规格
String jj="";//简介
String shopgdscode="";//商户商品编码
String buylimit="";//最大购买数量
String stock="";//商品库存
String vituralstock="";//虚拟库存
String tm="";//商品条码
String skuname1="";//商品SKU名称1
String yxq="";//有效期
String sex="";//商品男女分类，0男，1女，2中性

String hitcount="";//点击数
String sendcount="";//发货数
String createtime="";//生成时间
String updatetime="";//更新时间
String begindate="";//上架时间
String enddate="";//下架时间
float saleprice=0f;
float memberprice=0f;
float vipprice=0f;
float oldmemberprice=0f;
float oldvipprice=0f;
String tjdate="";
String detail="";

String flag="";//上下架标志
String gift="";//单品赠品
String cd="";//产地
String shsm="";//生产商/售后服务说明
String key="";//关键字
String havegds="";//是否缺货
String dhsj="";//到货时间
String txtcxsjs="";//促销开始时间
String txtcxsje="";//促销结束时间
String gdscx="";//促销语
String req_stdvalue1="";
String req_stdvalue2="";
String req_stdvalue3="";
String req_stdvalue4="";
String req_stdvalue5="";
String req_stdvalue6="";
String req_stdvalue7="";
String req_stdvalue8=""; 
String img="";
String img2="";

if(!Tools.isNull(request.getParameter("gdsid"))){
	ArrayList<GdsCutImg> list= getByGdsid(request.getParameter("gdsid"));
	if(list!=null && list.size()>0){
		GdsCutImg cutimg=list.get(0);
		img2=cutimg.getGdscutimg_160();
	}
	
	
	Product product=ProductHelper.getById(request.getParameter("gdsid"));
	if(product!=null && shopcode.equals(product.getGdsmst_shopcode())){
		gdsname=product.getGdsmst_gdsname() ;	
		rackcode=product.getGdsmst_rackcode();
		brandcode=product.getGdsmst_brand();
		brandname=product.getGdsmst_brandname();
		ggid=product.getGdsmst_stdid();
		shopgdscode=product.getGdsmst_shopgoodscode();
		stdothervalues=product.getGdsmst_stdothervalues();
		buylimit=product.getGdsmst_buylimit().toString();
		stock=product.getGdsmst_stock().toString();
		vituralstock=product.getGdsmst_virtualstock().toString();
		tm=product.getGdsmst_barcode();
		skuname1=product.getGdsmst_skuname1();
		yxq=Tools.getDate(product.getGdsmst_validdate()) ;
		flag=product.getGdsmst_ifhavegds().toString();
		gift=product.getGdsmst_giftselecttype().toString();
		cd=product.getGdsmst_provenance();
		shsm=product.getGdsmst_manufacture();
		key=product.getGdsmst_keyword();
		havegds=product.getGdsmst_ifhavegds().toString();
		dhsj=Tools.stockFormatDate( product.getGdsmst_ifhavedate());
		txtcxsjs=Tools.stockFormatDate( product.getGdsmst_promotionstart());
		txtcxsje=Tools.stockFormatDate( product.getGdsmst_promotionend());
		gdscx=product.getGdsmst_promotionword();
		req_stdvalue1=product.getGdsmst_stdvalue1();
		req_stdvalue2=product.getGdsmst_stdvalue2();
		req_stdvalue3=product.getGdsmst_stdvalue3();
		req_stdvalue4=product.getGdsmst_stdvalue4();
		req_stdvalue5=product.getGdsmst_stdvalue5();
		req_stdvalue6=product.getGdsmst_stdvalue6();
		req_stdvalue7=product.getGdsmst_stdvalue7();
		req_stdvalue8=product.getGdsmst_stdvalue8();
		 hitcount=product.getGdsmst_hitcount().toString();//点击数
		 sendcount=product.getGdsmst_sendcount().toString();//发货数
		 createtime=Tools.stockFormatDate(product.getGdsmst_createdate());//生成时间
		 updatetime=Tools.stockFormatDate(product.getGdsmst_updatedate());//更新时间
		 begindate=Tools.stockFormatDate(product.getGdsmst_beginstart());//上架时间
		 enddate=Tools.stockFormatDate(product.getGdsmst_enddateend());//下架时间
		  saleprice=product.getGdsmst_saleprice().floatValue();
		  memberprice=product.getGdsmst_memberprice().floatValue();
		  vipprice=product.getGdsmst_vipprice().floatValue();
		  oldmemberprice=product.getGdsmst_oldmemberprice().floatValue();
		  oldvipprice=product.getGdsmst_oldvipprice().floatValue();
		  tjdate=Tools.stockFormatDate(product.getGdsmst_discountenddate());
		  detail=product.getGdsmst_detailintruduce();
		  jj=product.getGdsmst_briefintrduce();
		img=product.getGdsmst_midimg().trim();
		%>
		
		<tr><td><input type="hidden" id="gdsid" name="gdsid"  value="<%=product.getId() %>"/>商品编号：<%=product.getId() %></td></tr>
		<%}} %>
		<tr><td><span style="color:red;">*</span>商品名称：<input type="text" id="txtgdsname" name="txtgdsname" style="width:200px;" value="<%=gdsname%>"/></td></tr>
		<tr><td>商户商品编码：<input type="text" name="shopgdscode" value="<%=shopgdscode %>"/></td></tr>
		<%
		ArrayList<Directory> list=DirectoryHelper. getParentrackcode();
		if(list!=null && list.size()>0){
			String pcode=list.get(0).getId().trim();
			int level=5;
			if(!Tools.isNull(rackcode)){
				pcode=rackcode.substring(0,3);
				Directory d=DirectoryHelper.getById(rackcode);
				if(d!=null){
					level=d.getRakmst_typeid().intValue();
				}
			}
			%>
			<tr><td><span style="color:red;">*</span>商品分类编号：
			<input type="hidden" id="rackcode" name="rackcode"  value="<%=rackcode.trim() %>"/>
			<input type="hidden" id="bcode" name="bcode"  value="<%=brandcode.trim() %>"/>
			<select id="rackcode1" name="rackcode1" onchange="changeRck(1);">
			<%
			for(Directory d:list){
				
				%>	
				<option value="<%=d.getId().trim()%>" <%if(pcode.equals(d.getId().trim())){ %>selected="selected"<%} %>><%=d.getRakmst_rackname() %></option>
			<%}
			%>
			
			</select> 
			<%if(level>=2){
				for(int i=2;i<=level;i++){
					%>	
					<select id="rackcode<%=i %>" name="rackcode<%=i %>" <%if(level!=i){%>onchange="changeRck(<%=i%>);"<%} %>>
					</select>
				<%}
			}
					%>
			</td></tr>
		<%}
		%>
		<tr><td><span style="color:red;">*</span>品牌：<select id="brand" name="brandname">
		<option value="">==请选择==</option>
		
		</select></td></tr>
		<tr><td>限订数量：<input type="text" name="buylimit" value="<%=buylimit %>"/><span style="color:red;">（0表示不限制）</span></td></tr>
		<tr><td>商品库存：<input type="text" name="stock" value="<%=stock %>"/></td></tr>
		<tr><td>商品虚拟库存：<input type="text" name="vituralstock" value="<%=vituralstock %>"/></td></tr>
		<tr><td>商品条码：<input type="text" name="tm" value="<%=tm %>"/></td></tr>
		<tr><td>商品男女分类：<select id="gdssex" name="gdssex">
		<option value="">==请选择==</option>
		<option value="0" <%if(sex.equals("0")){%>selected="selected"<%} %>>男</option>
		<option value="1" <%if(sex.equals("1")){%>selected="selected"<%} %>>女</option>
		<option value="2" <%if(sex.equals("2")){%>selected="selected"<%} %>>中性</option>
		</select></td></tr>
		<tr><td>商品SKU名称1：<input type="text" id="skuname1" name="skuname1" value="<%=skuname1 %>"/></td></tr>
		<tr><td><span style="color:red;">*</span>上下架标志：<select name="sgdsflag">
          <option value="0" <%if(flag.equals("0")){%>selected="selected"<%} %>>录入待上架</option>
          <option value="1"  <%if(flag.equals("1")){%>selected="selected"<%} %>>上架</option>
          <option value="2"  <%if(flag.equals("2")){%>selected="selected"<%} %>>下架</option>
          <option value="4"  <%if(flag.equals("4")){%>selected="selected"<%} %>>隐藏</option>
		</select></td></tr><tr><td>单品赠品：<select  name=gdsmst_giftselecttype>
		 
		  <option value="0" <%if(gift.equals("0")){%>selected="selected"<%} %>>无</option>
		  <option value="1" <%if(gift.equals("1")){%>selected="selected"<%} %>>赠品单选</option>
		  <option value="2" <%if(gift.equals("2")){%>selected="selected"<%} %>>赠品多选</option>
		  </select></td></tr>
		<tr><td>上架时间：<%=begindate%></td></tr>
		<tr><td>下架时间：<%=enddate%></td></tr>
		<tr><td>产地：<input type="text" name="txtcd"  value="<%=cd %>"/></td></tr>
		<tr><td>生产商/售后服务说明：<textarea rows="3" cols="20"  name="txtshhm" ><%=shsm %></textarea></td></tr>
		<tr><td>关键字：<input type="text" name="txtkey" value="<%=key%>"></input>&nbsp;&nbsp;&nbsp;<span style="color:red;">*多个关键词之间用空格隔开</span> </td></tr>
		<tr><td>商品点击数：<%=hitcount%></td></tr>
		<tr><td>商品发货数：<%=sendcount%></td></tr>
		<tr><td>商品生成时间：<%=createtime%></td></tr>
		<tr><td>商品更新时间：<%=updatetime%></td></tr>
		<tr><td>有效期（化妆品）：<input type="text" id="yxq" name="yxq" value="<%=yxq%>"/></td></tr>
		<tr><td>是否缺货：<select  name=gdsmst_ifhavegds>
		 
		  <option value="0"  <%if(havegds.equals("0")){%>selected="selected"<%} %>>不缺</option>
		  <option value="1"  <%if(havegds.equals("1")){%>selected="selected"<%} %>>很快就到</option>
		  <option value="2"  <%if(havegds.equals("2")){%>selected="selected"<%} %>>到货时间未定</option>
		  <option value="3" <%if(havegds.equals("3")){%>selected="selected"<%} %> >非卖品</option>
		  </select></td></tr>
		  <%if(havegds.equals("1")){%><tr><td>到货时间：<input type="text" id="dhsj" name="dhsj" value="<%=dhsj%>"/></td></tr><%} %>
		<tr><td>促销开始时间：<input type="text" name="txtcxsjs" style="width:120px;" value="<%=txtcxsjs%> " /></td></tr>
		<tr><td>促销结束时间：<input type="text" name="txtcxsje" style="width:120px;" value="<%=txtcxsje %>"/></td></tr>
		<tr><td>促销语：<textarea rows="5" cols="30" name="gdscx"><%=gdscx%></textarea>
		<input type="hidden" id="memo" value='<%=detail %>' />
		</td></tr>
		<tr><td><span style="color:red;">*</span>商品规格：
		
		<%
		ArrayList<ProductStandard> slist=ProductStandardHelper. getAllStandard();
		if(slist!=null && slist.size()>0){
			%>
			<select id="standid" name="standid" onchange="getgg();">
			<option value="">==请选择==</option>
			<%
			for(ProductStandard ps:slist){
				%>	
				<option value="<%=ps.getId().trim()%>" <%if(ggid.trim().equals(ps.getId().trim())){%>selected="selected"<%} %> ><%=ps.getStdmst_stdname() %></option>
			<%}
			%>
			</select>
			
		<%}
		%>
		</td></tr>
		<tr><td id="gg" style="display:none;">
		规格1:<span id="gg1" style="color:red;"></span>  商品规格名1: <select  id="req_stdvalue1" name="req_stdvalue1" ></select><br/>
		规格2:<span id="gg2" style="color:red;"></span>  商品规格名2: <select  id="req_stdvalue2" name="req_stdvalue2" ></select><br/>
		规格3:<span id="gg3" style="color:red;"></span>  商品规格名3: <select  id="req_stdvalue3" name="req_stdvalue3" ></select><br/>
		规格4:<span id="gg4" style="color:red;"></span>  商品规格名4: <select  id="req_stdvalue4" name="req_stdvalue4" ></select><br/>
		规格5:<span id="gg5" style="color:red;"></span>  商品规格名5: <select  id="req_stdvalue5" name="req_stdvalue5" ></select><br/>
		规格6:<span id="gg6" style="color:red;"></span>  商品规格名6: <select  id="req_stdvalue6" name="req_stdvalue6" ></select><br/>
		规格7:<span id="gg7" style="color:red;"></span>  商品规格名7: <select  id="req_stdvalue7" name="req_stdvalue7" ></select><br/>
		规格8:<span id="gg8" style="color:red;"></span>  商品规格名8: <select  id="req_stdvalue8" name="req_stdvalue8" ></select><br/>
		</td></tr>
		</table>
		</td>
		<td>
		<table>
		<tr><td><span style="color:red;">*</span>商品图片：</td><td><input type="file" name="loadFile" id="loadFile" />
		&nbsp;&nbsp;&nbsp; <input type="button" onclick="Upload.clear('loadFile');getimg();" value="取消"></input></td></tr>
		<tr><td colspan="2"><span style="color:red">*请上传大于或等于400*400，总大小小于1M，格式为jpg,jpeg,png,bmp,gif的图片</span></td></tr>
		<tr><td>图片预览：</td><td><input type="hidden" id="img" value='<%=img %>' /> <img id="stuPic" <%if(!Tools.isNull(img)){%>src="<%=img%>"<%} %>></img></td></tr>
		
		<tr><td><span style="color:red;">*</span>商品平铺图：</td><td><input type="file" name="loadFile2" id="loadFile2" />
		&nbsp;&nbsp;&nbsp; <input type="button" onclick="Upload.clear('loadFile2');getimg2();" value="取消"></input></td></tr>
		<tr><td colspan="2"><span style="color:red">*请上传大于或等于300*300，总大小小于1M，格式为jpg,jpeg,png,bmp,gif的图片</span></td></tr>
		<tr><td>图片预览：</td><td><input type="hidden" id="img2" value='<%=img2 %>' /> <img id="stuPic2" <%if(!Tools.isNull(img2)){%>src="<%=img2%>"<%} %>></img></td></tr>
		
		<tr><td><span style="color:red;">*</span>零售价：</td><td>
		<input type="text" id="saleprice" name="saleprice" value="<%=saleprice%>"/></td></tr>
		<tr><td><span style="color:red;">*</span>会员价：</td><td><input type="text" id="memberprice"  name="memberprice" value="<%=memberprice%>"/></td></tr>
		<tr><td><span style="color:red;">*</span>VIP价：</td><td><input type="text" id="vipprice" name="vipprice" value="<%=vipprice%>"/></td></tr>
		<tr><td>老会员价：</td><td><%=oldmemberprice%></td></tr>
		<tr><td>老VIP价：</td><td><%=oldvipprice%></td></tr>
		<tr><td>特价到期日：</td><td><input type="text" id="tjdate" name="tjdate" value="<%=tjdate%>"/></td></tr>
		<tr><td><span style="color:red;">*</span>简介：</td><td><textarea name="jj" rows="5" cols="50"><%=jj %></textarea></td></tr>
		<tr>
		<td><span style="color:red;">*</span>商品描述：</td>
		<td><script type="text/javascript">
				changeRck(1);
		
		var sBasePath = "/fckeditor/" ;
		
		var oFCKeditor = new FCKeditor('FCKeditor1') ;
		oFCKeditor.BasePath	= sBasePath ;
		oFCKeditor.Height	= 500 ;
		oFCKeditor.Width	= 600 ;
		//oFCKeditor.Value	= document.iconForm.description.value ;
		oFCKeditor.Value	= $("#memo").val();

		oFCKeditor.Create() ;
		</script>
		<p><font color="red">里面的图片不要宽度超过670像素，否则显示不全</font></p>
		</td>
		</tr>
		</table>
		</td>
		</tr>
		<tr>
		<td align="center" colspan="2"><input type="button" value="确定" onclick="check();"></input></td>
		</tr>
		</table>
	
</form>
</body>
</html>