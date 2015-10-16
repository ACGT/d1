<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%!
//根据商品编号获得身高体重信息
static ArrayList<HWeightManDtl> getHeightDtl(String gdsid){
	ArrayList<HWeightManDtl> list=new ArrayList<HWeightManDtl>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	if(!Tools.isNull(gdsid)){
		clist.add(Restrictions.eq("wheightman_dtlsize8", gdsid));
	}
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("wheightman_dtlweight"));

	List<BaseEntity> list2=	Tools.getManager(HWeightManDtl.class).getList(clist, olist, 0, 10);
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
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/jquery-1.3.2.min.js")%>"></script>
<script type="text/javascript">
function check(t,size){
	 var str1="";var str2="";var str3="";var str4="";var str5="";var str6="";var str7="";var str8="";var str9="";var str10="";var str11="";
	 if(t==1){
		 $("input[name='cb_40']:checkbox").each(function(){ 
			 var v="";
			 if($(this).attr("checked")){  
				 v=size;
			 }
		     str1+=v+",";
		    })
		     $("input[name='cb_45']:checkbox").each(function(){ 
		 var v="";
		 if($(this).attr("checked")){  
			 v=size;
		 }
	     str2+=v+",";
	    })
	     $("input[name='cb_50']:checkbox").each(function(){ 
		 var v="";
		 if($(this).attr("checked")){  
			 v=size;
		 }
	     str3+=v+",";
	    })
	     $("input[name='cb_55']:checkbox").each(function(){ 
		 var v="";
		 if($(this).attr("checked")){  
			 v=size;
		 }
	     str4+=v+",";
	    })
	     $("input[name='cb_60']:checkbox").each(function(){ 
		 var v="";
		 if($(this).attr("checked")){  
			 v=size;
		 }
	     str5+=v+",";
	    })
	     $("input[name='cb_65']:checkbox").each(function(){ 
		 var v="";
		 if($(this).attr("checked")){  
			 v=size;
		 }
	     str6+=v+",";
	    })
	     $("input[name='cb_70']:checkbox").each(function(){ 
		 var v="";
		 if($(this).attr("checked")){  
			 v=size;
		 }
	     str7+=v+",";
	    })
	     $("input[name='cb_75']:checkbox").each(function(){ 
		 var v="";
		 if($(this).attr("checked")){  
			 v=size;
		 }
	     str8+=v+",";
	    })
	     $("input[name='cb_80']:checkbox").each(function(){ 
		 var v="";
		 if($(this).attr("checked")){  
			 v=size;
		 }
	     str9+=v+",";
	    })
	    $("input[name='cb_85']:checkbox").each(function(){ 
		 var v="";
		 if($(this).attr("checked")){  
			 v=size;
		 }
	     str10+=v+",";
	    })
	     $("input[name='cb_90']:checkbox").each(function(){ 
		 var v="";
		 if($(this).attr("checked")){  
			 v=size;
		 }
	     str11+=v+",";
	    })
	 }else{
		 
	 }
	
}

</script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
  <table  border="1" cellpadding="1" cellspacing="1" style="width:100%;font-size:12px; line-height:24px;">
	  <tr>
    <td width="105"><img src=" http://images.d1.com.cn/images2012/wheight.JPG"/></td>
    <td >160cm</td>
    <td >165cm</td>
    <td>170cm</td>
    <td >175cm</td>
    <td >180cm</td>
    <td>185cm</td>
	</tr>
<%
		String[] strlist=new String[]{"40","45","50","55","60","65","70","75","80","85","90"};
		for(int i=0;i<strlist.length;i++){
			 %>
		    	<tr>
		    	<td><%=strlist[i] %>kg</td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_160" value="1"/></td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_165" value="1"/></td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_170" value="1"/></td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_175" value="1"/></td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_180" value="1"/></td>
		    	<td><input type="checkbox" name="cb_<%=strlist[i]%>" id="cb_<%=strlist[i]%>_185" value="1"/></td>
		    	</tr>
			<%	
		}
		
	%>
	 </table>



<input type="button" value="设置" onclick="check(1,'S');" />
</body>
</html>