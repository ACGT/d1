<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%@include file="/admin/chkrgt.jsp"%>
<%!
//根据商品编号获得身高体重信息
static ArrayList<HWeightManDtl> getHeightDtl(String gdsid){
	ArrayList<HWeightManDtl> list=new ArrayList<HWeightManDtl>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	if(!Tools.isNull(gdsid)){
		clist.add(Restrictions.eq("wheightman_gdsid", gdsid));
	}
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("wheightman_dtlweight"));

	List<BaseEntity> list2=	Tools.getManager(HWeightManDtl.class).getList(clist, olist, 0, 12);
	if(list2==null||list2.size()==0)return null;
	for(BaseEntity be:list2){
		list.add((HWeightManDtl)be);
	}
	return list;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>-D1优尚网</title>

<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
function check(t,size,gdsid){
	 var str1="";var str2="";var str3="";var str4="";var str5="";var str6="";var str7="";var str8="";var str9="";var str10="";
	var ischecked=false;
	 if(t==1){
		     $("input[name='cb_45']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str1+=v+"|";
	    })
	     $("input[name='cb_50']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str2+=v+"|";
	    })
	     $("input[name='cb_55']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str3+=v+"|";
	    })
	     $("input[name='cb_60']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str4+=v+"|";
	    })
	     $("input[name='cb_65']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str5+=v+"|";
	    })
	     $("input[name='cb_70']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str6+=v+"|";
	    })
	     $("input[name='cb_75']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str7+=v+"|";
	    })
	     $("input[name='cb_80']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str8+=v+"|";
	    })
	    $("input[name='cb_85']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str9+=v+"|";
	    })
	     $("input[name='cb_90']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str10+=v+"|";
	    })
	 }else{
		     $("input[name='cb_40']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str1+=v+"|";
	    })
	     $("input[name='cb_45']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str2+=v+"|";
	    })
	     $("input[name='cb_50']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str3+=v+"|";
	    })
	     $("input[name='cb_55']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str4+=v+"|";
	    })
	     $("input[name='cb_60']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str5+=v+"|";
	    })
	     $("input[name='cb_65']:checkbox").each(function(){ 
		 var v="1";
		 if($(this).attr("checked")){  
			 v=size;ischecked=true;
		 }
	     str6+=v+"|";
	    })
	 }
	 if(!ischecked){
		 alert("请选择您要勾选的单元格");
		 return;
	 }
	 $.ajax({
	        type: "GET",
	        url: "op.jsp",
	        data:{gdsid:gdsid,str1:str1,str2:str2,str3:str3,str4:str4,str5:str5,str6:str6,str7:str7,str8:str8,str9:str9,str10:str10},
	        success: function(data){
	        	if(data==1){
	        		location.href="index.jsp?gdsid="+gdsid;
	        	}
	          //alert(data);
	        },error: function(XmlHttpRequest){
	        	
	        }
	    });
}

function change(obj,gdsid){
	var v=$(obj).val();
	var sid=$(obj).attr("id");
	sid=sid.replace("s_","");
	 $.ajax({
	        type: "GET",
	        url: "op.jsp",
	        data:{gdsid:gdsid,sid:sid,sku:v},
	        success: function(data){
	        	if(data==1){
	        		alert("修改成功");
	        	}
	          //alert(data);
	        },error: function(XmlHttpRequest){
	        	
	        }
	    });
}

function copy(fromid){
	var manid=$.trim($("#txtgdsid2").val())
	if(manid.length==0){
		alert("您要复制到哪个商品？");
	}else{
		$.ajax({
	        type: "GET",
	        url: "checkCopy.jsp",
	        data:{tomanid:manid},
	        success: function(data){
	            if (data ==-1){
		           if(confirm("该商品中已存在数据确定要覆盖吗？")){
		        	   c(manid,fromid);
		           }
	            }else if(data == 1){
	            	 c(manid,fromid);
	            }else{
	            	alert(data);
	            }
	        },error: function(XmlHttpRequest){
	        	
	        }
	    });
	}


	}
	function c(manid,fromid){
		$.ajax({
	        type: "GET",
	        url: "copy.jsp",
	        data:{tomanid:manid,fromid:fromid},
	        success: function(data){
	        	if(data == 1){
	        		alert('复制成功');
	            
	        	}else{
	        		alert('复制失败');
	        	}
	            
	        },error: function(XmlHttpRequest){
	        	
	        }
	    });
	}
	
	
	
</script>
</head>
<%
String gdsid=request.getParameter("gdsid");
//gdsid="03000244";
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table  border="0" cellpadding="1" cellspacing="1" style="width:100%;font-size:12px; ">
<tr><td width="220" valign="top"><form id="search" name="search" method="post" action="index.jsp">
<br/><br/>
商品编码：<input type="text" name="gdsid" value="<%=gdsid%>"/><br/>

<input type="submit"  value="查询"/>
</form></td>
<td >
<p>将此数据复制到商品：<input type="text" name="txtgdsid2" id="txtgdsid2"/> <input type="button" value="开始复制" onclick="copy('<%=gdsid %>');"/></p>
<%
if(Tools.isNull(gdsid)){
	out.print("请输入商品编号");
	return;
}
Product p=ProductHelper.getById(gdsid);
int type=1;
if(p!=null){
	String rackcode=p.getGdsmst_rackcode();
	if(rackcode.startsWith("030")){
		type=1;
		%>
		  <table  border="1" cellpadding="1" cellspacing="1" style="width:100%;font-size:12px; line-height:26px;">
	  <tr>
    <td width="105"><img src=" http://images.d1.com.cn/images2012/wheight.JPG"/></td>
    <td >165cm</td>
    <td>170cm</td>
    <td >175cm</td>
    <td >180cm</td>
    <td>185cm</td>
	</tr>
		
	<%
	 ArrayList<HWeightManDtl> list= getHeightDtl(gdsid);
	 if(list!=null && list.size()>0){
    	 for(HWeightManDtl mandtl:list){
    	 %>
    	<tr>
    	<td><%=mandtl.getWheightman_dtlweight() %>kg</td>
    	<td><%
    	 String dtlsize2=mandtl.getWheightman_dtlsize2();
	    String dtlsize3=mandtl.getWheightman_dtlsize3();
	    String dtlsize4=mandtl.getWheightman_dtlsize4();
	    String dtlsize5=mandtl.getWheightman_dtlsize5();
	    String dtlsize6=mandtl.getWheightman_dtlsize6();
    	    		 if(!Tools.isNull(dtlsize2)){dtlsize2=dtlsize2.trim();}
    	    		 if(!Tools.isNull(dtlsize3)){dtlsize3=dtlsize3.trim();}
    	    		 if(!Tools.isNull(dtlsize4)){dtlsize4=dtlsize4.trim();}
    	    		 if(!Tools.isNull(dtlsize5)){dtlsize5=dtlsize5.trim();}
    	    		 if(!Tools.isNull(dtlsize6)){dtlsize6=dtlsize6.trim();}
		    	if(!Tools.isNull(dtlsize2)){
		    	%>	
		    	<select id="s_<%=mandtl.getWheightman_dtlweight()%>_165"  onchange="change(this,'<%=gdsid%>')">
		    	<option value="">无</option>
		    	<option value="XS" <%if("XS".equals(dtlsize2)){ %>selected="selected"<%} %>>XS</option>
		    	<option value="S" <%if("S".equals(dtlsize2)){ %>selected="selected"<%} %>>S</option>
		    	<option value="M" <%if("M".equals(dtlsize2)){ %>selected="selected"<%} %>>M</option>
		    	<option value="L" <%if("L".equals(dtlsize2)){ %>selected="selected"<%} %>>L</option>
		    	<option value="XL" <%if("XL".equals(dtlsize2)){ %>selected="selected"<%} %>>XL</option>
		    	<option value="XXL" <%if("XXL".equals(dtlsize2)){ %>selected="selected"<%} %>>XXL</option>
		    	</select>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_165" value="1" style="display:none;"/>
		    	<%}else{
		    	%>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_165" value="1"/>
		    	<%} %></td>
    	<td><%
		    	if(!Tools.isNull(dtlsize3)){
		    	%>	
		    	<select id="s_<%=mandtl.getWheightman_dtlweight()%>_170"  onchange="change(this,'<%=gdsid%>')">
		    	<option value="">无</option>
		    	<option value="XS" <%if("XS".equals(dtlsize3)){ %>selected="selected"<%} %>>XS</option>
		    	<option value="S" <%if("S".equals(dtlsize3)){ %>selected="selected"<%} %>>S</option>
		    	<option value="M" <%if("M".equals(dtlsize3)){ %>selected="selected"<%} %>>M</option>
		    	<option value="L" <%if("L".equals(dtlsize3)){ %>selected="selected"<%} %>>L</option>
		    	<option value="XL" <%if("XL".equals(dtlsize3)){ %>selected="selected"<%} %>>XL</option>
		    	<option value="XXL" <%if("XXL".equals(dtlsize3)){ %>selected="selected"<%} %>>XXL</option>
		    	</select>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_170" value="1" style="display:none;"/>
		    	<%}else{
		    	%>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_170" value="1"/>
		    	<%} %></td>
    	<td><%
		    	if(!Tools.isNull(dtlsize4)){
		    	%>	
		    	<select id="s_<%=mandtl.getWheightman_dtlweight()%>_175"  onchange="change(this,'<%=gdsid%>')">
		    	<option value="">无</option>
		    	<option value="XS" <%if("XS".equals(dtlsize4)){ %>selected="selected"<%} %>>XS</option>
		    	<option value="S" <%if("S".equals(dtlsize4)){ %>selected="selected"<%} %>>S</option>
		    	<option value="M" <%if("M".equals(dtlsize4)){ %>selected="selected"<%} %>>M</option>
		    	<option value="L" <%if("L".equals(dtlsize4)){ %>selected="selected"<%} %>>L</option>
		    	<option value="XL" <%if("XL".equals(dtlsize4)){ %>selected="selected"<%} %>>XL</option>
		    	<option value="XXL" <%if("XXL".equals(dtlsize4)){ %>selected="selected"<%} %>>XXL</option>
		    	</select>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_175" value="1" style="display:none;"/>
		    	<%}else{
		    	%>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_175" value="1"/>
		    	<%} %></td>
    	<td><%
		    	if(!Tools.isNull(dtlsize5)){
		    	%>	
		    	<select id="s_<%=mandtl.getWheightman_dtlweight()%>_180"  onchange="change(this,'<%=gdsid%>')">
		    	<option value="">无</option>
		    	<option value="XS" <%if("XS".equals(dtlsize5)){ %>selected="selected"<%} %>>XS</option>
		    	<option value="S" <%if("S".equals(dtlsize5)){ %>selected="selected"<%} %>>S</option>
		    	<option value="M" <%if("M".equals(dtlsize5)){ %>selected="selected"<%} %>>M</option>
		    	<option value="L" <%if("L".equals(dtlsize5)){ %>selected="selected"<%} %>>L</option>
		    	<option value="XL" <%if("XL".equals(dtlsize5)){ %>selected="selected"<%} %>>XL</option>
		    	<option value="XXL" <%if("XXL".equals(dtlsize5)){ %>selected="selected"<%} %>>XXL</option>
		    	</select>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_180" value="1" style="display:none;"/>
		    	<%}else{
		    	%>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_180" value="1"/>
		    	<%} %></td>
    	<td><%
		    	if(!Tools.isNull(dtlsize6)){
		    	%>	
		    	<select id="s_<%=mandtl.getWheightman_dtlweight()%>_185"  onchange="change(this,'<%=gdsid%>')">
		    	<option value="">无</option>
		    	<option value="XS" <%if("XS".equals(dtlsize6)){ %>selected="selected"<%} %>>XS</option>
		    	<option value="S" <%if("S".equals(dtlsize6)){ %>selected="selected"<%} %>>S</option>
		    	<option value="M" <%if("M".equals(dtlsize6)){ %>selected="selected"<%} %>>M</option>
		    	<option value="L" <%if("L".equals(dtlsize6)){ %>selected="selected"<%} %>>L</option>
		    	<option value="XL" <%if("XL".equals(dtlsize6)){ %>selected="selected"<%} %>>XL</option>
		    	<option value="XXL" <%if("XXL".equals(dtlsize6)){ %>selected="selected"<%} %>>XXL</option>
		    	</select>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_185" value="1" style="display:none;"/>
		    	<%}else{
		    	%>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_185" value="1"/>
		    	<%} %></td>
    	</tr>
	<%}}else{
		String[] strlist=new String[]{"45","50","55","60","65","70","75","80","85","90"};
		for(int i=0;i<strlist.length;i++){
			 %>
		    	<tr>
		    	<td><%=strlist[i] %>kg</td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_165" value="1"/></td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_170" value="1"/></td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_175" value="1"/></td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_180" value="1"/></td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_185" value="1"/></td>
		    	</tr>
			<%	
		}
		
	}%>
	 </table>
	<%}else if(rackcode.startsWith("020")){
		type=2;
		%>
		  <table  border="1" cellpadding="1" cellspacing="1" style="width:100%;font-size:12px; line-height:26px;">
	  <tr>
    <td width="105"><img src=" http://images.d1.com.cn/images2012/wheight.JPG"/></td>
    <td >150cm</td>
    <td >155cm</td>
    <td>160cm</td>
    <td >165cm</td>
    <td >170cm</td>
    <td>175cm</td>
	</tr>
		
	<%
	 ArrayList<HWeightManDtl> list= getHeightDtl(gdsid);
	 if(list!=null && list.size()>0){
    	 for(HWeightManDtl mandtl:list){
    	 %>
    	<tr>
    	<td><%=mandtl.getWheightman_dtlweight() %>kg</td>
    	<td>
    	<%String dtlsize1=mandtl.getWheightman_dtlsize1();
    	String dtlsize2=mandtl.getWheightman_dtlsize2();
	    String dtlsize3=mandtl.getWheightman_dtlsize3();
	    String dtlsize4=mandtl.getWheightman_dtlsize4();
	    String dtlsize5=mandtl.getWheightman_dtlsize5();
	    String dtlsize6=mandtl.getWheightman_dtlsize6();
	                 if(!Tools.isNull(dtlsize1)){dtlsize1=dtlsize1.trim();}
    	    		 if(!Tools.isNull(dtlsize2)){dtlsize2=dtlsize2.trim();}
    	    		 if(!Tools.isNull(dtlsize3)){dtlsize3=dtlsize3.trim();}
    	    		 if(!Tools.isNull(dtlsize4)){dtlsize4=dtlsize4.trim();}
    	    		 if(!Tools.isNull(dtlsize5)){dtlsize5=dtlsize5.trim();}
    	    		 if(!Tools.isNull(dtlsize6)){dtlsize6=dtlsize6.trim();}
		    	if(!Tools.isNull(dtlsize1)){
		    	%>	
		    	<select id="s_<%=mandtl.getWheightman_dtlweight()%>_150" onchange="change(this,'<%=gdsid%>')">
		    	<option value="">无</option>
		    	<option value="XS" <%if("XS".equals(dtlsize1)){ %>selected="selected"<%} %>>XS</option>
		    	<option value="S" <%if("S".equals(dtlsize1)){ %>selected="selected"<%} %>>S</option>
		    	<option value="M" <%if("M".equals(dtlsize1)){ %>selected="selected"<%} %>>M</option>
		    	<option value="L" <%if("L".equals(dtlsize1)){ %>selected="selected"<%} %>>L</option>
		    	<option value="XL" <%if("XL".equals(dtlsize1)){ %>selected="selected"<%} %>>XL</option>
		    	<option value="XXL" <%if("XXL".equals(dtlsize1)){ %>selected="selected"<%} %>>XXL</option>
		    	</select>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_150" value="1" style="display:none;"/>
		    	<%}else{
		    	%>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_150" value="1"/>
		    	<%} %>
    	</td>
    	<td><%
		    	if(!Tools.isNull(dtlsize2)){
		    	%>	
		    	<select id="s_<%=mandtl.getWheightman_dtlweight()%>_155"  onchange="change(this,'<%=gdsid%>')">
		    	<option value="">无</option>
		    	<option value="XS" <%if("XS".equals(dtlsize2)){ %>selected="selected"<%} %>>XS</option>
		    	<option value="S" <%if("S".equals(dtlsize2)){ %>selected="selected"<%} %>>S</option>
		    	<option value="M" <%if("M".equals(dtlsize2)){ %>selected="selected"<%} %>>M</option>
		    	<option value="L" <%if("L".equals(dtlsize2)){ %>selected="selected"<%} %>>L</option>
		    	<option value="XL" <%if("XL".equals(dtlsize2)){ %>selected="selected"<%} %>>XL</option>
		    	<option value="XXL" <%if("XXL".equals(dtlsize2)){ %>selected="selected"<%} %>>XXL</option>
		    	</select>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_155" value="1" style="display:none;"/>
		    	<%}else{
		    	%>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_155" value="1"/>
		    	<%} %></td>
    	<td><%
		    	if(!Tools.isNull(dtlsize3)){
		    	%>	
		    	<select id="s_<%=mandtl.getWheightman_dtlweight()%>_160"  onchange="change(this,'<%=gdsid%>')">
		    	<option value="">无</option>
		    	<option value="XS" <%if("XS".equals(dtlsize3)){ %>selected="selected"<%} %>>XS</option>
		    	<option value="S" <%if("S".equals(dtlsize3)){ %>selected="selected"<%} %>>S</option>
		    	<option value="M" <%if("M".equals(dtlsize3)){ %>selected="selected"<%} %>>M</option>
		    	<option value="L" <%if("L".equals(dtlsize3)){ %>selected="selected"<%} %>>L</option>
		    	<option value="XL" <%if("XL".equals(dtlsize3)){ %>selected="selected"<%} %>>XL</option>
		    	<option value="XXL" <%if("XXL".equals(dtlsize3)){ %>selected="selected"<%} %>>XXL</option>
		    	</select>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_160" value="1" style="display:none;"/>
		    	<%}else{
		    	%>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_160" value="1"/>
		    	<%} %></td>
    	<td><%
		    	if(!Tools.isNull(dtlsize4)){
		    	%>	
		    	<select id="s_<%=mandtl.getWheightman_dtlweight()%>_165"  onchange="change(this,'<%=gdsid%>')">
		    	<option value="">无</option>
		    	<option value="XS" <%if("XS".equals(dtlsize4)){ %>selected="selected"<%} %>>XS</option>
		    	<option value="S" <%if("S".equals(dtlsize4)){ %>selected="selected"<%} %>>S</option>
		    	<option value="M" <%if("M".equals(dtlsize4)){ %>selected="selected"<%} %>>M</option>
		    	<option value="L" <%if("L".equals(dtlsize4)){ %>selected="selected"<%} %>>L</option>
		    	<option value="XL" <%if("XL".equals(dtlsize4)){ %>selected="selected"<%} %>>XL</option>
		    	<option value="XXL" <%if("XXL".equals(dtlsize4)){ %>selected="selected"<%} %>>XXL</option>
		    	</select>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_165" value="1" style="display:none;"/>
		    	<%}else{
		    	%>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_165" value="1"/>
		    	<%} %></td>
    	<td><%
		    	if(!Tools.isNull(dtlsize5)){
		    	%>	
		    	<select id="s_<%=mandtl.getWheightman_dtlweight()%>_170"  onchange="change(this,'<%=gdsid%>')">
		    	<option value="">无</option>
		    	<option value="XS" <%if("XS".equals(dtlsize5)){ %>selected="selected"<%} %>>XS</option>
		    	<option value="S" <%if("S".equals(dtlsize5)){ %>selected="selected"<%} %>>S</option>
		    	<option value="M" <%if("M".equals(dtlsize5)){ %>selected="selected"<%} %>>M</option>
		    	<option value="L" <%if("L".equals(dtlsize5)){ %>selected="selected"<%} %>>L</option>
		    	<option value="XL" <%if("XL".equals(dtlsize5)){ %>selected="selected"<%} %>>XL</option>
		    	<option value="XXL" <%if("XXL".equals(dtlsize5)){ %>selected="selected"<%} %>>XXL</option>
		    	</select>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_170" value="1" style="display:none;"/>
		    	<%}else{
		    	%>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_170" value="1"/>
		    	<%} %></td>
    	<td><%
		    	if(!Tools.isNull(dtlsize6)){
		    	%>	
		    	<select id="s_<%=mandtl.getWheightman_dtlweight()%>_175"  onchange="change(this,'<%=gdsid%>')">
		    	<option value="">无</option>
		    	<option value="XS" <%if("XS".equals(dtlsize6)){ %>selected="selected"<%} %>>XS</option>
		    	<option value="S" <%if("S".equals(dtlsize6)){ %>selected="selected"<%} %>>S</option>
		    	<option value="M" <%if("M".equals(dtlsize6)){ %>selected="selected"<%} %>>M</option>
		    	<option value="L" <%if("L".equals(dtlsize6)){ %>selected="selected"<%} %>>L</option>
		    	<option value="XL" <%if("XL".equals(dtlsize6)){ %>selected="selected"<%} %>>XL</option>
		    	<option value="XXL" <%if("XXL".equals(dtlsize6)){ %>selected="selected"<%} %>>XXL</option>
		    	</select>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_175" value="1" style="display:none;"/>
		    	<%}else{
		    	%>
		    	<input type="checkbox" name="cb_<%=mandtl.getWheightman_dtlweight()%>" id="cb_<%=mandtl.getWheightman_dtlweight()%>_175" value="1"/>
		    	<%} %></td>
    	</tr>
	<%}}else{
		String[] strlist=new String[]{"40","45","50","55","60","65","70"};
		for(int i=0;i<strlist.length;i++){
			 %>
		    	<tr>
		    	<td><%=strlist[i] %>kg</td>
		    	<td>
		    	<input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_150" value="1"/></td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_155" value="1"/></td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_160" value="1"/></td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_165" value="1"/></td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_170" value="1"/></td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_175" value="1"/></td>
		    	</tr>
			<%	
		}
		
	}%>
	 </table>
	<%}else{
		out.print("该商品不属于服装类");
		return;
	}
}

%>

<br/><br/>
<input type="button" value="设为XS" onclick="check('<%=type %>','XS','<%=gdsid %>');" />&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="设为S" onclick="check('<%=type %>','S','<%=gdsid %>');" />&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="设为M" onclick="check('<%=type %>','M','<%=gdsid %>');" />&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="设为L" onclick="check('<%=type %>','L','<%=gdsid %>');" />&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="设为XL" onclick="check('<%=type %>','XL','<%=gdsid %>');" />&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="设为XXL" onclick="check('<%=type %>','XXL','<%=gdsid %>');" />&nbsp;&nbsp;&nbsp;&nbsp;
</td></tr>
</table>
</body>
</html>