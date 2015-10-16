<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%!
   public String GetRack(String rackcode){
	if(rackcode.length()<=0)
	{
		return "";
	}
	StringBuilder sb=new StringBuilder();
	if(rackcode.equals("017005"))
	{
		sb.append("<span>").append("<a href=\"").append("/result.jsp?productsort=017005\" target=\"_blank\">").append("女士包包|皮具").append("</a>").append("</span>");
		ArrayList<Directory> flist=new ArrayList<Directory>();
		flist=DirectoryHelper.getByParentrackcode("017005");
		
		if(flist!=null&&flist.size()>0)
		{
			for(Directory d:flist)
			{
				if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(d.getId())>=5)
				{
					sb.append("<a href=\"").append("/result.jsp?productsort=").append(d.getId()).append("\" target=\"_blank\">").append(d.getRakmst_rackname()).append("</a>");
					
				}
			}
		}
	}
	else if(rackcode.equals("017"))
	{
		ArrayList<Directory> flist=new ArrayList<Directory>();
		flist=DirectoryHelper.getByParentrackcode(rackcode);
		if(flist!=null&&flist.size()>0)
		{
			for(Directory fd:flist)
			{
				if(fd!=null&&!fd.getId().equals("020")&&!fd.getId().equals("030")&&!fd.getId().equals("017005")&&((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(fd.getId())>=5)
				{
					sb.append("<span>").append("<a href=\"").append("/result.jsp?productsort=").append(fd.getId()).append("\" target=\"_blank\">").append(fd.getRakmst_rackname()).append("</a>").append("</span>");
					ArrayList<Directory> slist=new ArrayList<Directory>();
					slist=DirectoryHelper.getByParentrackcode(fd.getId());
					if(slist!=null&&slist.size()>0)
					{
						for(Directory sd:slist)
						{
							if(sd!=null)
							{
								if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(sd.getId())>=5);
								{
								    sb.append("<a href=\"").append("/result.jsp?productsort=").append(sd.getId()).append("\" target=\"_blank\">").append(sd.getRakmst_rackname()).append("</a>");
								}
							}
						}
					}
				}
			}
		}
	}
	else if(rackcode.equals("015"))
	{
		ArrayList<Directory> flist=new ArrayList<Directory>();
		flist=DirectoryHelper.getByParentrackcode(rackcode);
		if(flist!=null&&flist.size()>0)
		{
			for(Directory fd:flist)
			{
				if(fd!=null&&((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(fd.getId())>=5)
				{
					if(fd.getId().equals("015002"))
					{
						ArrayList<Directory> slist=new ArrayList<Directory>();
						slist=DirectoryHelper.getByParentrackcode(fd.getId());
						if(slist!=null&&slist.size()>0)
						{
							for(Directory sd:slist)
							{
								if(sd!=null&&((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(sd.getId())>=5)
								{
									sb.append("<span>").append("<a href=\"").append("/result.jsp?productsort=").append(sd.getId()).append("\" target=\"_blank\">").append(sd.getRakmst_rackname()).append("</a>").append("</span>");
									ArrayList<Directory> slist1=new ArrayList<Directory>();
									slist1=DirectoryHelper.getByParentrackcode(sd.getId());
									if(slist1!=null&&slist1.size()>0)
									{
										for(Directory ds:slist1)
										{
											if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(ds.getId())>=5);
											{
											    sb.append("<a href=\"").append("/result.jsp?productsort=").append(ds.getId()).append("\" target=\"_blank\">").append(ds.getRakmst_rackname()).append("</a>");
											    
											}
										}
									}
								}
						   }
						}
					}
					else
					{
						sb.append("<span>").append("<a href=\"").append("/result.jsp?productsort=").append(fd.getId()).append("\" target=\"_blank\">").append(fd.getRakmst_rackname()).append("</a>").append("</span>");
						ArrayList<Directory> slist=new ArrayList<Directory>();
						slist=DirectoryHelper.getByParentrackcode(fd.getId());
						if(slist!=null&&slist.size()>0)
						{
							for(Directory sd:slist)
							{
								if(sd!=null)
								{
									if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(sd.getId())>=5);
									{
									    sb.append("<a href=\"").append("/result.jsp?productsort=").append(sd.getId()).append("\" target=\"_blank\">").append(sd.getRakmst_rackname()).append("</a>");
									    
									}
								}
							}
						}
					}
				}
			}
		}
	}
	else
	{	
		ArrayList<Directory> flist=new ArrayList<Directory>();
		flist=DirectoryHelper.getByParentrackcode(rackcode);
		if(flist!=null&&flist.size()>0)
		{
			for(Directory fd:flist)
			{
				if(fd!=null&&((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(fd.getId())>=5)
				{
					sb.append("<span>").append("<a href=\"").append("/result.jsp?productsort=").append(fd.getId()).append("\" target=\"_blank\">").append(fd.getRakmst_rackname()).append("</a>").append("</span>");
					ArrayList<Directory> slist=new ArrayList<Directory>();
					slist=DirectoryHelper.getByParentrackcode(fd.getId());
					if(slist!=null&&slist.size()>0)
					{
						for(Directory sd:slist)
						{
							if(sd!=null)
							{
								if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(sd.getId())>=5);
								{
								    sb.append("<a href=\"").append("/result.jsp?productsort=").append(sd.getId()).append("\" target=\"_blank\">").append(sd.getRakmst_rackname()).append("</a>");
								    
								}
							}
						}
					}
				}
			}
		}
	}
	return sb.toString();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-网站地图</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
  .center{ width:870px; margin:0px auto; margin-top:20px; margin-bottom:20px;}
  .gwfl{ font-size:17px; font-family:'微软雅黑'; color:#aa2e44; font-weight:bold;}
  table th{ text-align:center; width:122px; background:#F0F8FF; height:30px; font-size:14px; border-bottom:solid 1px #c2c2c2;}
  .common{ width:820px; text-align:left; margin:0px auto;}
  .common span a{ border-bottom:dashed 1px #c2c2c2; display:block; padding-top:7px; padding-bottom:5px; font-size:13px; 
                font-weight:bold; color:#FF6347; margin-bottom:3px;}
  .common span a:hover{ text-decoration:underline;}
  .common a { line-height:20px; margin-right:12px; margin-top:3px;}
</style>
<script type="text/javascript" language="javascript">
function aclick(v)
{
     $('#htr').find('th').each(function(){
    	var flag = $(this).attr('att');
		if(v == flag){
			$(this).css('background','#FFF8DC');
		}
		else
			{
			$(this).css('background','#F0F8FF');
			}
    });
	$("#content").find('div').each(function(){
		var flag = $(this).attr('att');
		if(v == flag){
			$(this).css('display','block');
		}
		else
			{
			$(this).css('display','none');
			}
	});
}

</script>
</head>
<style type="text/css">
  .center{ width:978px; margin:0px auto; margin-top:10px; margin-bottom:10px; border:solid 1px #ccc; text-aling:center; padding-bottom:5px;}
  .center span{ color:#333;  font-size:14px;}
  .center table{ margin:0px auto;}
  .center table td a{ margin-right:5px; line-height:18px; font-size:13px;}
  .nt{ width:980px; margin:0px auto; background:#f6f6f6; text-align:center;}
  .nt a{ font-size:16px; line-height:30px; display:block; width:23px; float:left;  }
</style>
<body>
<%@include file="/inc/head2012.jsp" %>
<div class="center">
<table width="980" class="nt">
     <tr>
     <td><B>按字母索引关键词</B></td>
     <td height="35" style="padding-left:6px;"><a href="http://www.d1.com.cn/channel/list/A" target="_blank">A</a><a href="http://www.d1.com.cn/channel/list/B" target="_blank">B</a><a href="http://www.d1.com.cn/channel/list/C" target="_blank">C</a>
     <a href="http://www.d1.com.cn/channel/list/D" target="_blank">D</a><a href="http://www.d1.com.cn/channel/list/E" target="_blank">E</a><a href="http://www.d1.com.cn/channel/list/F" target="_blank">F</a>
     <a href="http://www.d1.com.cn/channel/list/G" target="_blank">G</a><a href="http://www.d1.com.cn/channel/list/H" target="_blank">H</a><a href="http://www.d1.com.cn/channel/list/I" target="_blank">I</a>
     <a href="http://www.d1.com.cn/channel/list/J" target="_blank">J</a><a href="http://www.d1.com.cn/channel/list/K" target="_blank">K</a><a href="http://www.d1.com.cn/channel/list/L" target="_blank">L</a>
     <a href="http://www.d1.com.cn/channel/list/M" target="_blank">M</a><a href="http://www.d1.com.cn/channel/list/N" target="_blank">N</a><a href="http://www.d1.com.cn/channel/list/O" target="_blank">O</a>
     <a href="http://www.d1.com.cn/channel/list/P" target="_blank">P</a><a href="http://www.d1.com.cn/channel/list/Q" target="_blank">Q</a><a href="http://www.d1.com.cn/channel/list/R" target="_blank">R</a>
     <a href="http://www.d1.com.cn/channel/list/S" target="_blank">S</a><a href="http://www.d1.com.cn/channel/list/T" target="_blank">T</a><a href="http://www.d1.com.cn/channel/list/U" target="_blank">U</a>
     <a href="http://www.d1.com.cn/channel/list/V" target="_blank">V</a><a href="http://www.d1.com.cn/channel/list/W" target="_blank">W</a><a href="http://www.d1.com.cn/channel/list/X" target="_blank">X</a>
     <a href="http://www.d1.com.cn/channel/list/Y" target="_blank">Y</a><a href="http://www.d1.com.cn/channel/list/Z" target="_blank">Z</a></td></tr>
 </table>
<span class='gwfl'>购物分类</span>
<table style=" border:solid 1px #c2c2c2" width="870">
   <tr id="htr"><th width="138"><b>商品目录</b></th><th att="017001"><a href="javascript:void(0)" onclick="aclick('017001')">女装</a></th><th att="017002"><a href="javascript:void(0)"  onclick="aclick('017002')">男装</a></th>
   <th att="014"><a href="javascript:void(0)" onclick="aclick('014')">化妆品</a></th><th att="015"><a href="javascript:void(0)" onclick="aclick('015')">奢侈品</a></th><th att="017005"><a href="javascript:void(0)" onclick="aclick('017005')">女包</a></th>
   <th att="017"><a href="javascript:void(0)" onclick="aclick('017')">服装配饰</a></th>
   </tr>
   <tr><td colspan="7" style="text-align:center" id="content">
     <div id="div_017001" class="common" att="017001">
      <%= GetRack("020") %>
      </div>
       <div id="div_017002" class="common" style="display:none;"  att="017002">
      <%= GetRack("030") %>
      </div>
       <div id="div_014" class="common" style="display:none;"  att="014">
      <%= GetRack("014") %>
      </div>
       <div id="div_015" class="common" style="display:none;"  att="015">
      <%= GetRack("015") %>
      </div>
      <div id="div_017005" class="common" style="display:none;"  att="017005">
      <%= GetRack("023") %>
      </div>
      <div id="div_017" class="common" style="display:none;"  att="017">
      <%= GetRack("017") %>
      </div>
      
   </td></tr>
</table>
</div>
<div style="margin:0px auto;width:980px;" ><img src="http://images.d1.com.cn/images2012/foot.jpg"/></div>
</body>
</html>