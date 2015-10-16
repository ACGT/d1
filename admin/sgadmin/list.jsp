<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%!
public static ArrayList<SgGdsDtl> getsgList(HttpServletRequest request,HttpServletResponse response){
ArrayList<SgGdsDtl> list=new ArrayList<SgGdsDtl>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	  String req_gdsid= request.getParameter("req_gdsid");
	   String req_gdsname= request.getParameter("req_gdsname");
	   String req_mainflag= request.getParameter("req_mainflag");
	   String req_cls= request.getParameter("req_cls");
	   String req_sdate= request.getParameter("req_sdate");
	   String req_edate= request.getParameter("req_edate");
	   String req_status= request.getParameter("req_status");
	   String req_mailflag= request.getParameter("req_mailflag");
	   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
	   String req_seq= request.getParameter("req_seq");
	   String req_valid= request.getParameter("req_valid");
	   if(!Tools.isNull(req_gdsname)){
		   listRes.add(Restrictions.like("sggdsdtl_gdsname", "%"+req_gdsname+"%"));
	   }
	   if(!Tools.isNull(req_gdsid)){
		   listRes.add(Restrictions.eq("sggdsdtl_gdsid", req_gdsid));
	   }

	   if(!Tools.isNull(req_mainflag)){		
			   listRes.add(Restrictions.eq("sggdsdtl_mainflag", new Long(req_mainflag)));

	   }
	   if(!Tools.isNull(req_mailflag)){		
		   listRes.add(Restrictions.eq("sggdsdtl_mailflag", new Long(req_mailflag)));

   }
	   if(!Tools.isNull(req_cls)){		
		   //System.out.println("------------sgadmin------"+req_cls);
		   listRes.add(Restrictions.eq("sggdsdtl_cls", new Long(req_cls)));

   }
	   if(!Tools.isNull(req_status)){		
		   listRes.add(Restrictions.eq("sggdsdtl_status", new Long(req_status)));

   }
	   try{
	   if(!Tools.isNull(req_sdate)){		
		   listRes.add(Restrictions.ge("sggdsdtl_sdate", format.parse(req_sdate)));

   }
	   if(!Tools.isNull(req_edate)){		
		   listRes.add(Restrictions.le("sggdsdtl_edate", format.parse(req_edate)));

   }
	   }catch(Exception ex){
		   
	   }
	   if(req_valid.equals("0")){	
		  
		   listRes.add(Restrictions.lt("sggdsdtl_edate",  new Date()));	
	   }else if(req_valid.equals("1")){
		   listRes.add(Restrictions.le("sggdsdtl_sdate", new Date()));
		   listRes.add(Restrictions.ge("sggdsdtl_edate",  new Date()));	
	   }else if(req_valid.equals("2")){
		   listRes.add(Restrictions.gt("sggdsdtl_sdate", new Date()));
	   }

    List<Order> olist=new ArrayList<Order>();
    if(req_seq.equals("0")){
    olist.add(Order.asc("sggdsdtl_sort"));
    }else{
    	olist.add(Order.desc("sggdsdtl_sort"));
    }
	List<BaseEntity> list2 = Tools.getManager(SgGdsDtl.class).getList(listRes, olist, 0, 500);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((SgGdsDtl)be);
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
<script type="text/javascript" src="/res/js/manage/manage.js"></script>
<link href="/admin/odradmin/images/odrlist.css" rel="stylesheet" type="text/css"  />
<title>闪购列表</title>
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

function sortup(t,id){
	var sort=$(t).val();
    $.ajax({
            type: "POST",
            dataType: "json",
            url: "/admin/ajax/sgupsort.jsp",
            data:{sort:sort,id:id},
            success: function(json) {
            	$.alert(json.message)
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
                          <td width="95%" class="STYLE1"><span class="STYLE3">你当前的位置</span>：[闪购管理]-[添加新闪购]</td>
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
                    <td class="STYLE1"><div align="center"><img src="http://images.d1.com.cn/manage/22.gif" width="14" height="14" /></div></td>
                    <td class="STYLE1"><div align="center">新增</div></td>
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
	   String req_mainflag= request.getParameter("req_mainflag");
	   String req_cls= request.getParameter("req_cls");
	   String req_status= request.getParameter("req_status");
	   String req_mailflag= request.getParameter("req_mailflag");
	   String req_sdate= request.getParameter("req_sdate");
	   String req_edate= request.getParameter("req_edate");
	   String req_seq= request.getParameter("req_seq");
	   String req_valid= request.getParameter("req_valid");
	   %>
              <td width="10%">商品ID</td>
              <td width="16%"><input type="text" name="req_gdsid" id="req_gdsid" value="<%=!Tools.isNull(req_gdsid)?req_gdsid:""%>" /></td>
              <td width="9%">商品名称 </td>
              <td width="26%"><input name="req_gdsname" type="text" id="req_gdsname" size="40" value="<%=!Tools.isNull(req_gdsname)?req_gdsname:""%>" /></td>
              <td width="19%">邮件是否显示</td>
              <td width="20%"><select name="req_mailflag" id="req_mailflag">
               <option value=""  <%=Tools.isNull(req_mailflag)?"selected":""%>>全部</option>
                <option value="0" <%=!Tools.isNull(req_mailflag)&&req_mailflag.equals("0")?"selected":""%>>否</option>
                <option value="1" <%=!Tools.isNull(req_mailflag)&&req_mailflag.equals("1")?"selected":""%>>是</option>
              </select></td>
            </tr>
            <tr>
              <td width="10%">闪购开始时间</td>
              <td width="16%"><input type="text" name="req_sdate" id="req_sdate" value="<%=!Tools.isNull(req_sdate)?req_sdate:"" %>" /></td>
              <td width="9%">结束时间</td>
              <td width="26%"><input name="req_edate" type="text" id="req_edate" size="40" value="<%=!Tools.isNull(req_edate)?req_edate:"" %>" /></td>
              <td width="19%">是否结束</td>
              <td width="20%"><select name="req_valid" id="req_valid">
               <option value="" <%=Tools.isNull(req_valid)?"selected":""%>>全部</option>
                <option value="0" <%=!Tools.isNull(req_valid)&&req_valid.equals("0")?"selected":""%>>已经结束</option>
                <option value="1" <%=!Tools.isNull(req_valid)&&req_valid.equals("1")?"selected":""%>>正在进行</option>
                <option value="2" <%=!Tools.isNull(req_valid)&&req_valid.equals("2")?"selected":""%>>未开始</option>
                </select>排序
                <select name="req_seq" id="req_seq">
                <option value="0" <%=(Tools.isNull(req_seq)||(!Tools.isNull(req_seq)&&req_seq.equals("0")))?"selected":""%>>升序</option>
                <option value="1" <%=!Tools.isNull(req_seq)&&req_seq.equals("1")?"selected":""%>>降序</option>
                </select>
                </td>
            </tr>
            <tr>
              <td>闪购分类：</td>
              <td><select name="req_cls" id="req_cls">
               <option value="" selected>全部</option>
                <option value="1">美妆区</option>
                <option value="2">男人区</option>
                <option value="3">女人区</option>
                <option value="4">生活区</option>
                <option value="5">重磅推荐</option>
                <option value="6">整点秒杀</option>
               <option value="7">限购专区</option>
              </select></td>
              <td>是否显示：</td>
              <td><select name="req_status" id="req_status">
               <option value="" selected>全部</option>
                <option value="0">不显示</option>
                <option value="1">显示</option>
              </select></td>
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
            <td width="12%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">商品ID</span></div></td>
            <td width="14%" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">商品名称</div></td>
            <td width="14%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">开始结束时间 </span></div></td>
            <td width="18%" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">最大购买次数（真实数）</div></td>
            <td width="10%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">排序</div></td>
            <td width="28%" height="26" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF" class="STYLE1"><div align="center">基本操作</div></td>
          </tr>

    
 <%
String act=request.getParameter("act");
   SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   String[] arrcls = new String[]{"美妆区","男人区","女人区","生活区","重磅推荐","整点秒杀","限购专区"};
   String[] arrmainflag = new String[]{"否","是"};  
   String[] arrstatus = new String[]{"不显示","显示"};  
   String ggURL = Tools.addOrUpdateParameter(request,null,null);
   ggURL=ggURL.replace("&button=查询", "");
      ArrayList<SgGdsDtl> list=new ArrayList<SgGdsDtl>();
      if(act!=null&&act.equals("list")){
      list=getsgList(request,response);
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
     	int status=0;
     	int cls=0;
     	int mailflag=0;
     	String gdsid="";
     	String sdate="";
     	String edate="";
     	 int j=0;
     	DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 	      for(int i=(pageno1-1)*30;i<list.size()&&i<pageno1*30;i++)
     	  {
 	    	 SgGdsDtl sg=list.get(i);
 	    	 status=sg.getSggdsdtl_status().intValue();
 	    	cls=sg.getSggdsdtl_cls().intValue();
 	        mailflag=sg.getSggdsdtl_mailflag().intValue();
 	       gdsid=sg.getSggdsdtl_gdsid();
           Product p=ProductHelper.getById(gdsid);
           if(p==null)continue;
           if(p.getGdsmst_promotionstart()!=null &&p.getGdsmst_promotionend()!=null){
        	   sdate=format.format(p.getGdsmst_promotionstart());
        	   edate=format.format(p.getGdsmst_promotionend());
        	   }else{
        		  // continue;
        		   sdate="秒杀时间已结束";
        		   edate="";
        	   }

 
      %>      
		   <tr id="sel_del_<%= sg.getId()%>">
           <!--  <td height="24" bgcolor="#FFFFFF"><div align="center">
              <input type="checkbox" name="checkbox2" value="checkbox" />
            </div></td> -->
            <td height="24" bgcolor="#FFFFFF"><div align="center" class="STYLE1">
              <div align="center"><%=i %></div>
            </div></td>
            <td height="24" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1"><%=gdsid %></span></div></td>

            <td bgcolor="#FFFFFF"><%=sg.getSggdsdtl_gdsname() %>(<%=arrcls[cls-1] %>)</td>
            <td height="24" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1"><%=sdate+"<br>"+edate %></span></div></td>
            <td bgcolor="#FFFFFF"><div align="center"><span class="STYLE1"><%=sg.getSggdsdtl_maxnum() %>(<%=sg.getSggdsdtl_realbuynum() %>订单：<%=sg.getSggdsdtl_realnum() %>)</span></div></td>
            <td height="24" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">
            <input type="text" name="req_sort" id="req_sort" style="width:50px"  value="<%=sg.getSggdsdtl_sort() %>" onblur="sortup(this,'<%= sg.getId()%>')" />
            </span></div></td>
            <td height="24" bgcolor="#FFFFFF"><div align="center"><span class="STYLE4">
            <span id="showbut<%=sg.getId() %>">
            <%if (status==0) {%>
              <input type="submit" name="button2<%=sg.getId() %>" id="button2<%=sg.getId() %>" value="设为显示" onclick="sgshow('<%=sg.getId() %>','1');" />
              <%} else{%>
              <input type="submit" name="button2<%=sg.getId() %>" id="button2<%=sg.getId() %>" value="设为不显示" onclick="sgshow('<%=sg.getId() %>','0');" />
              <%} %>
              </span>
               <span id="mainbut<%=sg.getId() %>">
              <%if (mailflag==0) {%>
              <input type="submit" name="button3<%=sg.getId() %>" id="button3<%=sg.getId() %>" value="邮件显示" onclick="sgmain('<%=sg.getId() %>','1');" />
              <%} else{%>
              <input type="submit" name="button3<%=sg.getId() %>" id="button3<%=sg.getId() %>" value="邮件不显示" onclick="sgmain('<%=sg.getId() %>','0');" />
              <%} %>
             </span>
              <a href="edit.jsp?id=<%=sg.getId()%>" ><img src="http://images.d1.com.cn/manage/edt.gif" width="16" height="16" border="0" />编辑</a>&nbsp; &nbsp;
              <input type="image" name="imageField" id="imageField" src="http://images.d1.com.cn/manage/del.gif" onclick="sgdel('<%=sg.getId() %>');" />
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
