<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%@include file="/html/header.jsp"%><%!
//获取头部分类的文字推荐
private static String getHotKey(String code,int length)
{
	if(code==null||code.length()==0||!Tools.isNumber(code))
	{
		return "";
	}
	StringBuilder sb = new StringBuilder();
	  List<Promotion> listh1=PromotionHelper.getBrandListByCode(code,length);
	  if(listh1!=null&&listh1.size()>0)
	  {
		  for(int i=0;i<listh1.size();i++)
		  {
			  Promotion p=listh1.get(i);
		    		if(p!=null&&p.getSplmst_name()!=null&&p.getSplmst_name().length()>0&&p.getSplmst_url()!=null&&p.getSplmst_url().length()>0)
		    		{
		    			if(i==0)
		    			{
		    				sb.append("<div style=\"height:223px;\"><span style=\"height:23px;\" ></span>");
		    				sb.append("<span style=\"font-size:13px; font-weight:bold;line-height:30px;\"><a href=\""+p.getSplmst_url()+"\" target=\"_blank\" style=\"color:#000;\">"+p.getSplmst_name()+"</a></span>");
		    				sb.append("<ul>");
		    					
	                    }
		    			else
		    			{
		    			   sb.append("<li><a href=\""+p.getSplmst_url()+"\" target=\"_blank\"><font style=\"font-size:16px;\">▪&nbsp;</font>"+p.getSplmst_name()+"</a></li>");
		    			}
		    			if(i==listh1.size()-1)
		    			{
		    				 sb.append("</ul>");
		    				 sb.append("</div>");
		    			}
		    		}
	    	}
		 
	  }

return sb.toString();

}

//获取头部上新活动的文字推荐
private static String getHotKeys(String code,int length)
{
	if(code==null||code.length()==0||!Tools.isNumber(code))
	{
		return "";
	}
	StringBuilder sb = new StringBuilder();
	  List<Promotion> listh1219=PromotionHelper.getBrandListByCode(code,length);
	  if(listh1219!=null&&listh1219.size()>0)
	  {
		  sb.append("<ul>");
		  for(int i=0;i<listh1219.size();i++)
		  {
			  Promotion p=listh1219.get(i);
		    		if(p!=null&&p.getSplmst_name()!=null&&p.getSplmst_name().length()>0&&p.getSplmst_url()!=null&&p.getSplmst_url().length()>0)
		    		{
		    				 sb.append("<li><a href=\""+p.getSplmst_url()+"\" target=\"_blank\" >"+p.getSplmst_name()+"</a></li>");
		    		}
	    	}
		  sb.append("</ul>");
		 
	  } 
return sb.toString();

}


%>
document.write('<div id=\"submenu\">');
document.write('<div id=\"html_women_index\" style=\"position:absolute;left:0px; border:solid 2px #960e0e;top:37px;\" onmouseover=\"head1218over(\'html/women/index\',this)\" onmouseout=\"head1218out(\'html/women/index\',this)\">');
document.write('<table width=\"640\">');
document.write('<tr>');
document.write('<td style=\"background:#fff7f8;\">');
document.write('<table width=\"100%\" height=\"90%\" valign=\"center\">');
document.write('<tr><td colspan=\"5\" height=\"8\" style=\"border:none;\"></td></tr>');
document.write('<tr><td colspan=\"5\" class=\"hzhead\" style=\"border:none;\"> <span class=\"rmflheadspantitle\" >查看所有女装：</span>');
document.write('<a href=\"http://www.d1.com.cn/result.jsp?productsort=020\" target=\"_blank\">按新品</a>&nbsp;&nbsp;&nbsp;');
document.write('<a href=\"http://www.d1.com.cn/result.jsp?productsort=020&order=3\" target=\"_blank\">按销量</a>&nbsp;&nbsp;&nbsp;');
document.write('<a href=\"http://www.d1.com.cn/result.jsp?productsort=020&order=2\" target=\"_blank\">按价格</a>&nbsp;&nbsp;&nbsp;');
document.write('</td></tr>');
document.write('<tr><td colspan=\"5\" height=\"5\" style=\"border:none;\"></td></tr>');
document.write('<tr>');
document.write('<td width=\"140\" style=\"padding-left:20px;\">');
document.write('<span style=\"font-size:13px; font-weight:bold;color:#208400;display:block; width:110px;background:url(\"http://images.d1.com.cn/images2012/index2012/des/new.png\") no-repeat right;\">夏装上新</span>');
document.write('<%=getHotKeys("3304",3) %>');
document.write('</ul>');
document.write('<span style=\"display:block;height:15px;\"></span>');
document.write('<span style=\"font-size:13px; font-weight:bold;color:#ca0000; display:block;width:110px;background:url(\"http://images.d1.com.cn/images2012/index2012/des/hot.png\") no-repeat right;\">超值活动</span>');
document.write('<%=getHotKeys("3305",3) %>');
document.write('<span style=\"display:block;height:30px;\"></span>');
document.write('</td>');
document.write('<td width=\"89\">');
document.write('<%=getHotKey("3309",9) %>');
document.write('</td>');
document.write('<td width=\"89\">');
document.write('<%=getHotKey("3307",9) %>');
document.write('</td>');
document.write('<td width=\"89\">');
document.write('<%=getHotKey("3308",9) %>');
document.write('</td>');
document.write('<td width=\"89\">');
document.write('<%=getHotKey("3306",9) %>');
document.write('</td>');
document.write('<td width=\"89\" style=\"border:none;\">');
document.write('<%=getHotKey("3310",9) %>');
document.write('</td>');
document.write('</tr>');
document.write('</table>');
document.write('</td>');
document.write('</tr>');         
document.write('</table>');
document.write('</td>');
document.write('</tr>');
document.write('</table>');
document.write('</div>');
	   
	   
document.write('<div id=\"html_men_index\" style=\"position:absolute;left:20px; border:solid 2px #960e0e;top:37px;" onmouseover=\"head1218over(\'html/men/index\',this)\" onmouseout=\"head1218out(\'html/men/index\',this)\">');
document.write('<table width=\"545\">');
document.write('<tr>');
document.write('<td style=\"background:#fff7f8;\">');
document.write('<table width=\"100%\" height=\"90%\" valign=\"center\">');
document.write('<tr><td colspan=\"5\" height=\"8\" style=\"border:none;\"></td></tr>');
document.write('<tr><td colspan=\"5\" class=\"hzhead\" style=\"border:none;\"> <span class=\"rmflheadspantitle\" >查看所有男装：</span>');
document.write('<a href=\"http://www.d1.com.cn/result.jsp?productsort=030\" target=\"_blank\">按新品</a>&nbsp;&nbsp;&nbsp;');
document.write('<a href=\"http://www.d1.com.cn/result.jsp?productsort=030&order=3\" target=\"_blank\">按销量</a>&nbsp;&nbsp;&nbsp;');
document.write('<a href=\"http://www.d1.com.cn/result.jsp?productsort=030&order=2\" target=\"_blank\">按价格</a>&nbsp;&nbsp;&nbsp;');
document.write('</td></tr>');
document.write('<tr><td colspan=\"5\" height=\"5\" style=\"border:none;\"></td></tr>');
document.write('<tr>');
document.write('<td width=\"140\" style=\"padding-left:20px;\">');
document.write('<span style=\"font-size:13px; font-weight:bold;color:#208400;display:block; width:110px;background:url(\"http://images.d1.com.cn/images2012/index2012/des/new.png\") no-repeat right;\">夏装上新</span>');
document.write('<%=getHotKeys("3311",3) %>');
document.write('<span style=\"display:block;height:15px;\"></span>');
document.write('<span style=\"font-size:13px; font-weight:bold;color:#ca0000; display:block;width:110px;background:url(\"http://images.d1.com.cn/images2012/index2012/des/hot.png\") no-repeat right;\">超值活动</span>');
document.write('<%=getHotKeys("3312",3) %>');
document.write('<span style=\"display:block;height:30px;\"></span>');
document.write('</td>');
document.write('<td width=\"89\">');
document.write('<%=getHotKey("3314",9) %>');
document.write('</td>');
document.write('<td width=\"89\">');
document.write('<%=getHotKey("3315",9) %>');
document.write('</td>');
document.write('<td width=\"89\">');
document.write('<%=getHotKey("3313",9) %>');
document.write('</td>');
document.write('<td width=\"89\" style=\"border:none;\">');
document.write('<%=getHotKey("3316",9) %>');
document.write('</td>');
document.write('</tr>');
document.write('</table>');
document.write('</td>');
document.write('</tr>');         
document.write('</table>');
document.write('</td>');
document.write('</tr>');
document.write('</table>');
document.write('</div>');
	   
	   
document.write('<div id=\"html_self_ps\" style=\"position:absolute;left:50px; border:solid 2px #960e0e;top:37px;\" onmouseover=\"head1218over(\'html/self/ps\',this)\" onmouseout=\"head1218out(\'html/self/ps\',this)\">');
document.write('<table width=\"545\">');
document.write('<tr>');
document.write('<td style=\"background:#fff7f8;\">');
document.write('<table width=\"100%\" height=\"90%\" valign=\"center\">');
document.write('<tr><td colspan=\"5\" height=\"8\" style=\"border:none;\"></td></tr>');
document.write('<tr><td colspan=\"5\" class=\"hzhead\" style=\"border:none;\"> <span class=\"rmflheadspantitle\" >查看所有配饰：</span>');
document.write('<a href=\"http://www.d1.com.cn/result.jsp?productsort=021,022,023,031,032,033,015009\" target=\"_blank\">按新品</a>&nbsp;&nbsp;&nbsp;');
document.write('<a href=\"http://www.d1.com.cn/result.jsp?productsort=021,022,023,031,032,033,015009&order=3\" target=\"_blank\">按销量</a>&nbsp;&nbsp;&nbsp;');
document.write('<a href=\"http://www.d1.com.cn/result.jsp?productsort=021,022,023,031,032,033,015009&order=2\" target=\"_blank\">按价格</a>&nbsp;&nbsp;&nbsp;');
document.write('</td></tr>');
document.write('<tr><td colspan=\"5\" height=\"5\" style=\"border:none;\"></td></tr>');
document.write('<tr>');
document.write('<td width="140" style=\"padding-left:20px;\">');
document.write('<span style=\"font-size:13px; font-weight:bold;color:#208400;display:block; width:110px;background:url(\"http://images.d1.com.cn/images2012/index2012/des/new.png\") no-repeat right;\">配饰上新</span>');
document.write('<%=getHotKeys("3317",3) %>');
document.write('<span style=\"display:block;height:15px;\"></span>');
document.write('<span style=\"font-size:13px; font-weight:bold;color:#ca0000; display:block;width:110px;background:url(\"http://images.d1.com.cn/images2012/index2012/des/hot.png\") no-repeat right;\">超值活动</span>');
document.write('<%=getHotKeys("3318",3) %>');
document.write('<span style=\"display:block;height:30px;\"></span>');
document.write('</td>');
document.write('<td width=\"89\">');
document.write('<%=getHotKey("3319",9) %>');
document.write('</td>');
document.write('<td width=\"89\">');
document.write('<%=getHotKey("3320",9) %>');
document.write('</td>');
//document.write('<td width=\"89\">');
//document.write('<%//=getHotKey("3321",9) %>');
//document.write('</td>');
document.write('<td width=\"89\" style=\"border:none;\">');
document.write('<%=getHotKey("3321",9) %>');
document.write('</td>');
document.write('</tr>');
document.write('</table>');
document.write('</td>');
document.write('</tr>');         
document.write('</table>');
document.write('</td>');
document.write('</tr>');
document.write('</table>');
document.write('</div>');


document.write('<div id=\"cosmetic_d1_com\" style=\"position:absolute;left:80px; border:solid 2px #960e0e;top:37px;\" onmouseover=\"head1218over(\'cosmetic/d1/com\',this)\" onmouseout=\"head1218out(\'cosmetic/d1/com\',this)\">');
document.write('<table width=\"545\">');
document.write('<tr>');
document.write('<td style=\"background:#fff7f8;\">');
document.write('<table width=\"100%\" height=\"90%\" valign=\"center\">');
document.write('<tr><td colspan=\"5\" height=\"8\" style=\"border:none;\"></td></tr>');
document.write('<tr><td colspan=\"5\" class=\"hzhead\" style=\"border:none;\"> <span class=\"rmflheadspantitle\" >查看所有化妆品：</span>');
document.write('<a href=\"http://www.d1.com.cn/result.jsp?productsort=014&order=4\" target=\"_blank\">按新品</a>&nbsp;&nbsp;&nbsp;');
document.write('<a href=\"http://www.d1.com.cn/result.jsp?productsort=014\" target=\"_blank\">按销量</a>&nbsp;&nbsp;&nbsp;');
document.write('<a href=\"http://www.d1.com.cn/result.jsp?productsort=014&order=2\" target=\"_blank\">按价格</a>&nbsp;&nbsp;&nbsp;');
document.write('</td></tr>');
document.write('<tr><td colspan=\"5\" height=\"5\" style=\"border:none;\"></td></tr>');
document.write('<tr>');
document.write('<td width="140" style=\"padding-left:20px;\">');
document.write('<span style=\"font-size:13px; font-weight:bold;color:#208400;display:block; width:110px;background:url(\"http://images.d1.com.cn/images2012/index2012/des/new.png\") no-repeat right;\">妆品上新</span>');
document.write('<%=getHotKeys("3353",3) %>');
document.write('<span style=\"display:block;height:15px;\"></span>');
document.write('<span style=\"font-size:13px; font-weight:bold;color:#ca0000; display:block;width:110px;background:url(\"http://images.d1.com.cn/images2012/index2012/des/hot.png\") no-repeat right;\">妆品活动</span>');
document.write('<%=getHotKeys("3354",3) %>');
document.write('<span style=\"display:block;height:30px;\"></span>');
document.write('</td>');
document.write('<td width=\"89\">');
document.write('<%=getHotKey("3355",9) %>');
document.write('</td>');
document.write('<td width=\"89\">');
document.write('<%=getHotKey("3356",9) %>');
document.write('</td>');
document.write('<td width=\"89\">');
document.write('<%=getHotKey("3357",9) %>');
document.write('</td>');
document.write('<td width=\"89\" style=\"border:none;\">');
document.write('<%=getHotKey("3358",9) %>');
document.write('</td>');
document.write('</tr>');
document.write('</table>');
document.write('</td>');
document.write('</tr>');         
document.write('</table>');
document.write('</td>');
document.write('</tr>');
document.write('</table>');
document.write('</div>');
document.write('</div>');

