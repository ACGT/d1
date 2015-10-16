<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkdfmng.jsp"%>
<%!
public static ArrayList<GdsDf> getsgList(HttpServletRequest request,HttpServletResponse response,String shopcode){
ArrayList<GdsDf> list=new ArrayList<GdsDf>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	  String req_gdsid= request.getParameter("req_gdsid");
	   String req_gdsname= request.getParameter("req_gdsname");
	   String req_brand= request.getParameter("req_brand");
	   String req_brandname= request.getParameter("req_brandname");
	   String req_cls= request.getParameter("req_cls");
	   String req_valid= request.getParameter("req_valid");
	  
	   if(!Tools.isNull(req_gdsname)){
		   listRes.add(Restrictions.like("gdsdf_gdsname", "%"+req_gdsname+"%"));
	   }
	   if(!Tools.isNull(req_gdsid)){
		   listRes.add(Restrictions.eq("id", req_gdsid));
	   }

	   if(!Tools.isNull(req_brand)){		
			   listRes.add(Restrictions.eq("gdsdf_brand", req_brand));

	   }
	   if(!Tools.isNull(req_brandname)){		
		   listRes.add(Restrictions.like("gdsdf_brandname", "%"+req_brandname+"%"));

   }
	   if(!Tools.isNull(req_cls)){		
		   listRes.add(Restrictions.like("gdsdf_rackcode", ""+req_cls+"%"));

   }
	
	   if(!Tools.isNull(req_valid)){		
		   listRes.add(Restrictions.eq("gdsdf_validflag", new Long(req_valid)));

   }
	
	   listRes.add(Restrictions.eq("gdsdf_shopcode", shopcode));
    //List<Order> olist=new ArrayList<Order>();
    //olist.add(Order.asc("sggdsdtl_sort"));
 
	List<BaseEntity> list2 = Tools.getManager(GdsDf.class).getList(listRes, null, 0, 1000);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((GdsDf)be);
	}
	return list;
}

%><%
/*
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "sg_admin");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<link href="/admin/odradmin/images/odrlist.css" rel="stylesheet" type="text/css"  />
<title>商品列表</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;

}
td{	font-size: 12px;}
.STYLE1 {font-size: 12px}
.STYLE3 {font-size: 12px; font-weight: bold; }
.STYLE4 {
	color: #03515d;
	font-size: 12px;
}
.GPager{overflow:hidden;_zoom:1;color: #4B4B4B;text-align:center;}
.GPager .span{margin-right:30px;}
.GPager .rd{color:#CC0000;}
.GPager a{font-size:12px;text-decoration: none;color: #8B8B8B;line-height: 28px;padding: 3px 8px 3px 8px;border: 1px solid #A4A4A4;background-image: url(http://images.d1.com.cn/images2010/pgbg.gif);margin:0 5px;}
.GPager a:hover{color:#AA2E44;}
.GPager .curr{font-size: 12px;text-decoration: none;color: #8B8B8B;line-height: 28px;padding: 3px 8px 3px 8px;border: 1px solid #A4A4A4;background-color: #CDCDCD;}

-->
</style>
<script>
var  highlightcolor='#c1ebff';
//此处clickcolor只能用win系统颜色代码才能成功,如果用#xxxxxx的代码就不行,还没搞清楚为什么:(
var  clickcolor='#51b2f6';
function  changeto(){
source=event.srcElement;
if  (source.tagName=="TR"||source.tagName=="TABLE")
return;
while(source.tagName!="TD")
source=source.parentElement;
source=source.parentElement;
cs  =  source.children;
//alert(cs.length);
if  (cs[1].style.backgroundColor!=highlightcolor&&source.id!="nc"&&cs[1].style.backgroundColor!=clickcolor)
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor=highlightcolor;
}
}

function  changeback(){
if  (event.fromElement.contains(event.toElement)||source.contains(event.toElement)||source.id=="nc")
return
if  (event.toElement!=source&&cs[1].style.backgroundColor!=clickcolor)
//source.style.backgroundColor=originalcolor
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor="";
}
}


function  clickto(){
source=event.srcElement;
if  (source.tagName=="TR"||source.tagName=="TABLE")
return;
while(source.tagName!="TD")
source=source.parentElement;
source=source.parentElement;
cs  =  source.children;
//alert(cs.length);
if  (cs[1].style.backgroundColor!=clickcolor&&source.id!="nc")
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor=clickcolor;
}
else
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor="";
}
}

function priceup(t,id){
	var price=$(t).val();
    $.ajax({
            type: "POST",
            dataType: "json",
            url: "/admin/ajax/dfupprice.jsp",
            data:{price:price,id:id},
            success: function(json) {
            	$.alert(json.message)
            }

            });
    
}
function dfvalid(id,flag)
{
	
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/admin/ajax/dfvalidup.jsp",
		        cache: false,
		        data:{id:id,valid:flag},
		        error: function(XmlHttpRequest){
		            alert("操作失败！");
		        },
		        success: function(json){
		        	if(parseInt(json.code)==1){
		        		alert(json.message);
		        		if(flag=="1"){
		        		$('#showbut'+id).html("<input type='submit' name='button2"+id+"'  onclick=dfvalid('"+id+"','0'); id='button2"+id+"' value='设为无货' />");
		        		}else{
		        			$('#showbut'+id).html("<input type='submit' name='button2"+id+"' onclick=dfvalid('"+id+"','1'); id='button2"+id+"' value='设为有货'  />");
		        		}
					}else{
						alert(json.message);
					}
		        },beforeSend: function(){
		        }
		    });	

}
</script>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30" background="http://images.d1.com.cn/manage/tab_05.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="12" height="30"><img src="http://images.d1.com.cn/manage/tab_03.gif" width="12" height="30" /></td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="46%" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="5%"><div align="center"><img src="http://images.d1.com.cn/manage/tb.gif" width="16" height="16" /></div></td>
                          <td width="95%" class="STYLE1"><span class="STYLE3">你当前的位置</span>：[商品管理]</td>
              </tr>
            </table></td>
            <td width="54%"><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td width="60"><table width="87%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"></td>
                    <td class="STYLE1"></td>
                  </tr>
                </table></td>
                <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"><div align="center"></div></td>
                    <td class="STYLE1"><div align="center"></div></td>
                  </tr>
                </table></td>
                <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"><!--<div align="center"><img src="http://images.d1.com.cn/manage/33.gif" width="14" height="14" /></div>--></td>
                    <td class="STYLE1"><!--<div align="center">修改</div>--></td>
                  </tr>
                </table></td>
                <td width="52"><table width="88%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"></td>
                    <td class="STYLE1"></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table>
          </td>
        <td width="16"><img src="http://images.d1.com.cn/manage/tab_07.gif" width="16" height="30" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="8" background="http://images.d1.com.cn/manage/tab_12.gif">&nbsp;</td>
        <td>
          <form id="form1" name="form1" method="post" action="?act=list">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="90">
            <tr>
              <%  String req_gdsid= request.getParameter("req_gdsid");
	   String req_gdsname= request.getParameter("req_gdsname");
	   String req_brandname= request.getParameter("req_brandname");
	   String req_valid= request.getParameter("req_valid");
	   %>
              <td width="10%">商品ID</td>
              <td width="16%"><input type="text" name="req_gdsid" id="req_gdsid" value="<%=!Tools.isNull(req_gdsid)?req_gdsid:""%>" /></td>
              <td width="9%">商品名称 </td>
              <td width="26%"><input name="req_gdsname" type="text" id="req_gdsname" size="40" value="<%=!Tools.isNull(req_gdsname)?req_gdsname:""%>" /></td>
              <td width="19%">品牌</td>
              <td width="20%"><input name="req_brandname" type="text" id="req_brandname" size="40" value="<%=!Tools.isNull(req_brandname)?req_brandname:""%>" /></td>
            </tr>
            <tr>
              <td>是否有货：</td>
              <td><select name="req_valid" id="req_valid">
                <option value="" selected>全部</option>
                <option value="0">无货</option>
                <option value="1">有货</option>
                </select></td>
              <td></td>
              <td></td>
              <td><input type="submit" name="button" id="button" value="查询"  /></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
          </table>
          </form>
        <div id="sglist">
   
 <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="b5d6e6" onmouseover="changeto()"  onmouseout="changeback()">
          <tr>
            <!-- <td width="3%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">
              <input type="checkbox" name="checkbox" value="checkbox" />
            </div></td>-->
            <td width="3%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">序号</span></div></td>
             <td width="14%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">图片 </span></div></td>
            <td width="12%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">商品ID</span></div></td>
            <td width="14%" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">(品牌)商品名称</div></td>
            <td width="18%" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">条形码</div></td>
            <td width="10%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">进货价（不含运费）</div></td>
            <td width="28%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF" class="STYLE1"><div align="center">基本操作</div></td>
          </tr>

    
 <%
String act=request.getParameter("act");
   SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   String[] arrvalid = new String[]{"有货","无货"};  
   String ggURL = Tools.addOrUpdateParameter(request,null,null);
   ggURL=ggURL.replace("&button=查询", "");
   String shopcode =session.getAttribute("dfshopcode").toString();
      ArrayList<GdsDf> list=new ArrayList<GdsDf>();
      if(act!=null&&act.equals("list")){
      list=getsgList(request,response,shopcode);
      }
      //分页
      int pageno1=1;
      
      if(ggURL != null) 
      	   {
      	     ggURL.replaceAll("pageno1=[0-9]*","");
      	   }
      //翻页
        int totalLength1 = (list != null ?list.size() : 0);
        int PAGE_SIZE = 30;
        int currentPage1 = 1 ;
        String pg1 ="1";
        if(request.getParameter("pageno1")!=null)
        {
        	pg1= request.getParameter("pageno1");
        }
      
        if(StringUtils.isDigits(pg1))currentPage1 = Integer.parseInt(pg1);
        PageBean pBean1 = new PageBean(totalLength1,PAGE_SIZE,currentPage1);
        int end1 = pBean1.getStart()+PAGE_SIZE;
        if(end1 > totalLength1) end1 = totalLength1;
        
      	String pageURL1 = ggURL.replaceAll("pageno1=[^&]*","");
      	if(!pageURL1.endsWith("&")) pageURL1 = pageURL1 + "&";
      if(list!=null&&list.size()>0)
      {
     	 if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
 		   {

 			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
 		   }
     	 String	strname ="";
     	long validfalg=0;
     	String gdsid="";
     	String img="";
     	String brand="";
     	 int j=0;
     	DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 	      for(int i=(pageno1-1)*30;i<list.size()&&i<pageno1*30;i++)
     	  {
 	    	 GdsDf df=list.get(i);
 	    	strname=df.getGdsdf_gdsname();
 	    	gdsid=df.getId();
 	    	validfalg=df.getGdsdf_validflag().longValue();
 	    	brand=df.getGdsdf_brandname();
           Product p=ProductHelper.getById(gdsid);
           if(p==null)continue;
           img=ProductHelper.getImageTo80(p);
           String barcode=p.getGdsmst_barcode();
           if(!Tools.isNull(barcode))barcode=barcode.replace("null", "");
 
      %>      
		   <tr id="sel_del_<%= gdsid%>">
           <!--  <td height="24" bgcolor="#FFFFFF"><div align="center">
              <input type="checkbox" name="checkbox2" value="checkbox" />
            </div></td> -->
            <td height="24" bgcolor="#FFFFFF"><div align="center" class="STYLE1">
              <div align="center"><%=i %></div>
            </div></td>
            <td height="24" bgcolor="#FFFFFF"><div align="center"><img src="<%=img %>" /></div></td>
            <td height="24" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1"><%=gdsid %></span></div></td>

            <td bgcolor="#FFFFFF">（<%=brand %>）<%=strname%></td>
        
            <td bgcolor="#FFFFFF"><div align="center"><span class="STYLE1"><%=barcode %></span></div></td>
            <td height="24" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">
            <input type="text" name="req_price" id="req_price" style="width:50px"  value="<%=df.getGdsdf_price() %>" onblur="priceup(this,'<%= gdsid%>')" />
            </span></div></td>
            <td height="24" bgcolor="#FFFFFF"><div align="center"><span class="STYLE4">
            <span id="showbut<%=gdsid %>">
            <%if (validfalg==0) {%>
              <input type="submit" name="button2<%=gdsid %>" id="button2<%=gdsid %>" value="设为有货" onclick="dfvalid('<%=gdsid %>','1');" />
              <%} else{%>
              <input type="submit" name="button2<%=gdsid %>" id="button2<%=gdsid%>" value="设为无货" onclick="sgshow('<%=gdsid %>','0');" />
              <%} %>
              </span>
             <!--  <input type="image" name="imageField" id="imageField" src="http://images.d1.com.cn/manage/del.gif" onclick="sgdel('<%//=gdsid %>');" /> -->
             </span></div></td>
          </tr>
 

	 <%j=j++;
	   }
      }
%>
  </table>	
           	  <!-- 分页 -->
           	   <%
					           if(pBean1.getTotalPages()>=1){
					           %>
           	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
           <tr>
                    <td class="STYLE1" height="32"></td>
                    <td class="STYLE1"></td>
    
          </tr>
          <tr>
            <td class="STYLE4" height="28">&nbsp;&nbsp;共有 <%=totalLength1 %> 条记录，当前第 <%=pBean1.getCurrentPage() %>/<%=pBean1.getTotalPages() %> 页</td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
                <tr>
                  <td colspan="4" >
                 
 <span class="GPager" style="margin:0px auto; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean1.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean1.getCurrentPage() %></font>页</span>
					           	&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=1">首页</a><%if(pBean1.hasPreviousPage()){%>&nbsp;&nbsp;<a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
					           	for(int i=pBean1.getStartPage();i<=pBean1.getEndPage()&&i<=pBean1.getTotalPages();i++){
					           		if(i==currentPage1){
					           		%>&nbsp;&nbsp;<span class="curr"><%=i %></span><%
					           		}else{
					           		%>&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=<%=i %>"><%=i %></a><%
					           		}
					           	}%>
					           	<%if(pBean1.hasNextPage()){%>&nbsp;&nbsp;<a href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下一页</a><%}%>
					           	&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>	
			           	  </span>
</td>
                 
                  <td width="40"></td>
                </tr>
            </table></td>
          </tr>
        </table>
           	  <%}%>

        
        </div>
        </td>
        <td width="8" background="http://images.d1.com.cn/manage/tab_15.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="35" background="http://images.d1.com.cn/manage/tab_19.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="12" height="35"><img src="http://images.d1.com.cn/manage/tab_18.gif" width="12" height="35" /></td>
        <td>&nbsp;</td>
        <td width="16"><img src="http://images.d1.com.cn/manage/tab_20.gif" width="19" height="35" /></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
