<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加公告分类</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link type="text/css" rel="Stylesheet" href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/flowCheck.css")%>" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
   .center{ margin:0px auto; text-align:center; padding-top:25px;}
   table{ margin:0px auto; font-size:14px;  }
   a{ font-size:12px; color:#6495ED; text-decoration:underline;}
</style>
<script type="text/javascript" language="javascript">
   function check()
   {
	   var objtype=document.getElementById("ggtype");
	   var objttitle=document.getElementById("gg_title");
	   if(objtype.value=="0")
		   {
		   $.alert('您没有选择公告类型','提示');
		   }
	   if(objttitle.value=="")
		   {
		   $.alert('您没有填写公告标题','提示');
		   }
	  
   }
   
   function cleargg()
   {
	   var objtype=document.getElementById("ggtype");
	   var objtitle=document.getElementById("gg_title");
	   var objflag=document.getElementById("gg_flag");
	   objtype.value=0;
	   objflag.value=0;
	   objtitle.value="";
	   objtitle.focus();
   }
</script>
</head>
<body>
<%
    String ggType=request.getParameter("ggtype")==null?"0":request.getParameter("ggtype");
    String ggtitle=request.getParameter("gg_title")==null?"":request.getParameter("gg_title");
    String ggflag=request.getParameter("gg_flag")==null?"0":request.getParameter("gg_flag");
    String order=request.getParameter("order")==null?"0":request.getParameter("order");
    if(!ggType.equals("0")&&ggtitle.length()>0&&ggflag.length()>0)
    {
    	
    	ArrayList<NoticeDir> list=new ArrayList<NoticeDir>();
    	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
    	clist.add(Restrictions.eq("parentId", ggType));
    	List<BaseEntity> b_list = Tools.getManager(NoticeDir.class).getList(clist, null, 0, 1000);
    	if(b_list!=null)
    	{
    		for(BaseEntity b:b_list)
    		{
    			list.add((NoticeDir)b);
    		}
    	}
    	int fla=0;
    	if(list!=null)
    	{
    		for(NoticeDir nd:list)
    		{
    			if(nd.getTitle().equals(ggtitle))
    			{
    				fla++;
    			}
    		}
    	}
    	if(fla>0)
    	{
    		out.print("<script>alert('该公告标题已经存在，重新输入！');</script>");
    	}
    	else
    	{
	    	NoticeDir noticedir=new NoticeDir();
	    	noticedir.setParentId(ggType);
	    	noticedir.setTitle(ggtitle);
	    	noticedir.setFlag(Tools.parseLong(ggflag));
	    	noticedir.setCreatedate(new Date());
	    	noticedir.setPriority(Tools.parseLong(order));
	    	Tools.getManager(NoticeDir.class).create(noticedir);
	    	if(!Tools.isNull(noticedir.getId()))
	    	{
	    		out.print("<script>alert('添加公告成功');</script>");
	
	    	}
	    	else
	    	{
	    		out.print("<script>alert('添加公告失败');</script>");
    	    }
    	}
    	
    }
    
%>
<div class="center">
   <form id="form1" action="addNoticeDir.jsp" method="post">
        <table width="500" >
           <tr><td width="80">公告类型</td><td style=" text-align:left;"><select id="ggtype" name="ggtype">
                                      <option value="0">---请选择公告类型---</option>
                                      <option value="1">市场公告</option>
                                      <option value="2">服务公告</option>
                                      <option value="3">网站功能公告</option>
                                   </select></td></tr>
           <tr><td>公告标题</td><td style=" text-align:left;"><input type="text" id="gg_title" name="gg_title" style=" width:250px;"></input></td></tr>
           <tr><td>是否隐藏</td><td style=" text-align:left;"><select id="gg_flag" name="gg_flag">
                                      <option value="0">隐藏</option>
                                      <option value="1">不隐藏</option>
                                   </select><font color='red'>&nbsp;&nbsp;（注：选择隐藏，前台将不显示；反之，则显示。）</font></td></tr>
                                   <tr><td>排序值</td><td><input type="text" width="300" id="order" name="order"></input><font color='red'>&nbsp;&nbsp;请输入数字</font></td></tr> 
                                   <tr><td colspan="2" height="30"></td></tr>
                                   <tr><td colspan="2"><input type="submit" value="添加公告" onclick="return check()"></input>&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:void(0)' onclick="cleargg()">清空内容</a></td></tr>
        </table>
        
   </form>
</div>
</body>
</html>