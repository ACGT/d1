<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%@include file="/admin/public.jsp"%>
<%
if(session.getAttribute("type_flag")!=null){
	String userid = "";
	if(session.getAttribute("admin_mng") != null){
		userid = session.getAttribute("admin_mng").toString();
	}
	boolean is_edit = chk_admpower(userid,"d1shop_gdsedit");
	if(is_edit==false){
		out.print("对不起，您没有操作权限！");
		return;	
	}
}
%>
<%!
public static List<ShopRck> getShopRckList(String shopcode,int parentid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("shoprck_shopcode", shopcode));
	listRes.add(Restrictions.eq("shoprck_parentid", new Long(parentid)));
	List<Order> olist= new ArrayList<Order>();
	olist.add(Order.asc("shoprck_seq"));

	List list = Tools.getManager(ShopRck.class).getList(listRes, olist, 0, 200);	
	if(list == null || list.isEmpty()) return null;	
	return list;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/admin/odradmin/images/odrlist.css" rel="stylesheet" type="text/css"  />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>

<title>无标题文档</title>
<script type="text/javascript">
function addshoprck(parentid,flag){
	var seq='#req_seq'+flag+parentid+'';
	var name='#req_name'+flag+parentid+'';
	var req_seq=$(seq).val();
	var req_name=$(name).val();
	$.ajax({
		type: "post",
		dataType: "json",
		url: '/admin/ajax/addShopRck.jsp',
		cache: false,
		data: {req_seq:req_seq,req_name:req_name,flag:flag,parentid:parentid},
		error: function(XmlHttpRequest){
			$.alert("添加商户分类出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.success){
				$.alert(json.message);
				
			$("#rcklist").html(json.content);
			}else{
				$.alert(json.message);
			}
			
		},beforeSend: function(){
		},complete: function(){
		}
	});
}

function delshoprck(parentid){
	var flag=-1;
	$.ajax({
		type: "post",
		dataType: "json",
		url: '/admin/ajax/addShopRck.jsp',
		cache: false,
		data: {flag:flag,parentid:parentid},
		error: function(XmlHttpRequest){
			$.alert("添加商户分类出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.success){
				$.alert(json.message);
				
			$("#rcklist").html(json.content);
			}else{
				$.alert(json.message);
			}
			
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
</script>
</head>
<style>
<!-- 
body{ font-size:12px; background:#FFFFFF; color:#666666; margin:0px; padding:0px;}
.text{ height:26px; line-height:26px; background-color:#f8f8f8; border:1px solid #d4d4d4;}
ul,li{ margin:0px; padding:0px; list-style:none;}
/*.menuodon{font-size: 14px;
	font-weight: bold;
	text-align: center;
	vertical-align: middle;
	height:30px;
	width:98px;color: #ffffff;	background-image: url(images/menubg2.jpg);}
.menuodoff{font-size: 14px;
	font-weight: bold;
	text-align: center;
	vertical-align: middle;
	height:30px;
	width:98px;color: #464646;	background-image: url(images/menubg1.jpg);}
	*/
.menuodr{ width:800px; height:30px;}

.menuodrtd{
	font-size: 14px;
	font-weight: bold;
	text-align: left;
	padding-left:15px;
	vertical-align: middle;
	height:30px;
	list-style:none;
	line-height:30px;
	width:98px;
	color: #ffffff;
	background-image: url(images/menubg2.jpg);
	background-repeat: no-repeat;
	background-position: left;
}

.lin {
	border: 1px solid #449ae7;
}
.linon {
	border-top-width: 1px;
	border-top-style: solid;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
	border-top-color: #449ae7;
}
.odrt{ font-size:14px; font-weight:800; color:#454547; text-align:center; background:#deefff}

.odrlistt{ background:#f7f7f7;}
.spantxt{ color:#1566b8}
.pdl8{ padding-left:8px;}
-->
</style>
<body>
<%@include file="/admin/inc/shhead.jsp" %>
<div>
<br/>
<br/>
<table style="width:1000px; margin:0px auto;" border="0" cellpadding="0" cellspacing="0">
   <tr><td width="174" style="text-align:center;" valign="top">
     <%@include file="/admin/inc/shleftwh.jsp" %>
   </td>
   <td width="926" valign="top">
<table width="806" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td width="806" height="30" colspan="7">&nbsp;</td>
  </tr>
  
    <tr>
      <td colspan="7">&nbsp;</td>
    </tr>
    <tr>
    <td colspan="7"><table width="800" border="0" cellpadding="0" cellspacing="0" class="lin">
      <tr class="odrt">
        <td width="180" height="40">分类名称</td>
        <td width="250">添加子分类</td>
        <td width="90">保存</td>
        <td width="90">删除</td>
        </tr>
      <tr>
        <td colspan="4">
		<div id="rcklist">
		<%
		String shopCode=session.getAttribute("shopcodelog").toString();
		List<ShopRck> shoprcklist=getShopRckList(shopCode,0);
		int num=0;
	 	 if(shoprcklist!=null){
	 		num=shoprcklist.size();
	 	
	 	 } %>
		<table width="800" border="0" cellpadding="0" cellspacing="0" class="linon">
		 
         <tr>
           <td width="180" height="25"  class="spantxt  pdl8"><input type="text" id="req_seq" name="req_seq" value=<%=num+1 %> style="width:20px;" />
           <input type="text" id="req_name" name="req_name" style="width:100px;" /></td>
           <td width="190" align="center"><input type="submit" name="Submit2" value="添加一级分类"  onClick="addshoprck('','');" /></td>
           <td width="90" align="center">&nbsp;</td>
           <td width="90" align="center">&nbsp;</td>
           <td width="90" align="center">&nbsp;</td>
         </tr>
         <%if(shoprcklist!=null){
         for(ShopRck sprck:shoprcklist){
        	String shoprck_id= sprck.getId();
        	//System.out.println(sprck.getShoprck_seq()+"================="+sprck.getShoprck_name());
        	List<ShopRck> shoprcklist2=getShopRckList(shopCode,Tools.parseInt(sprck.getId()));
        	int parentnum=0;
       	 if(shoprcklist2!=null){
       	  parentnum=shoprcklist2.size();
       	
       	 }
        	 %>
        	  <tr>
           <td height="25"  class="spantxt  pdl8">
              <input name="req_seq0<%=shoprck_id %>" id="req_seq0<%=shoprck_id %>" style="width:20px;" type="text" value="<%=sprck.getShoprck_seq() %>"  />
             <input name="req_name0<%=shoprck_id %>" id="req_name0<%=shoprck_id %>" style="width:100px;"  type="text"  value="<%=sprck.getShoprck_name() %>" /></td>
           <td align="center"><span class="spantxt  pdl8">
           <input name="req_seq1<%=shoprck_id %>" id="req_seq1<%=shoprck_id %>" value="<%=parentnum+1 %>" style="width:20px;" type="text"/>
             <input type="text" name="req_name1<%=shoprck_id %>" id="req_name1<%=shoprck_id %>" style="width:100px;"  />
           </span></td>
           <td align="center"><span class="spantxt  pdl8">
             <input type="submit" name="Submit3" onClick="addshoprck('<%=shoprck_id %>','1');" value="添加子分类" />
           </span></td>
           <td align="center"><span class="spantxt  pdl8">
             <input type="submit" name="Submit32" onClick="addshoprck('<%=shoprck_id %>','0');" value="修改" />
           </span></td>
           <td align="center"><span class="spantxt  pdl8">
             <input type="submit" name="Submit3210" onClick="delshoprck('<%=shoprck_id %>');" value="删除" />
           </span></td>
         </tr>
        	 <%
        	 if(shoprcklist2!=null){
        		 int inum=0;
             for(ShopRck sprck2:shoprcklist2){
            	 shoprck_id= sprck2.getId();
         %>
        
         <tr>
           <td height="25"  class="spantxt  pdl8"> 
           <%if (inum+1!=parentnum){
            	 out.println("├");
             }else{
            	 out.println("└");
             }
            	 %>
           <input name="req_seq0<%=shoprck_id %>" id="req_seq0<%=shoprck_id %>" type="text" style="width:20px;" value="<%=sprck2.getShoprck_seq() %>"  />                 
             <input name="req_name0<%=shoprck_id %>" id="req_name0<%=shoprck_id %>"  type="text" style="width:100px;" value="<%=sprck2.getShoprck_name() %>"  /></td>
           <td align="center">&nbsp;</td>
           <td align="center">&nbsp;</td>
           <td align="center"><span class="spantxt  pdl8">
             <input type="submit" name="Submit322" onClick="addshoprck('<%=shoprck_id %>','0');" value="修改" />
           </span></td>
           <td align="center"><span class="spantxt  pdl8">
             <input type="submit" name="Submit" onClick="delshoprck('<%=shoprck_id %>');" value="删除" />
           </span></td>
         </tr>
         <%inum++;
            }
             }
        	 }
         } %>
         <tr>
          
         <tr>
           <td height="25"  class="spantxt  pdl8">&nbsp;</td>
           <td colspan="2" align="center">&nbsp;</td>
           <td align="center">&nbsp;</td>
           <td align="center">&nbsp;</td>
         </tr>
    </table>		
	</div>
		</td>
        </tr>
    </table></td>
  </tr>
</table>
</td>
   </tr>
</table>

</div>
</form>
</body>
</html>
