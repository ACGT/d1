<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%!
public static String gettxth(String code,int len)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , len);
	if(recommendList != null && !recommendList.isEmpty()){
		for(Promotion p:recommendList)
		{
			String url=p.getSplmst_url();
		
			sb.append("<a href=\""+url);
			sb.append("\" target=\"_blank\" title=\"").append(p.getSplmst_name()).append("\">");
			sb.append(p.getSplmst_name());
			sb.append("</a>");
		}
	}
	return sb.toString();
}
%>
 document.write('<div class=\"hmenu2015\">');
	 document.write('<div class=\"hml\">');
		 document.write('<div class=\"item\">');
			 document.write('<h3><i class=\"pt1\"></i>面部护理</h3>');
			 document.write('<div class=\"list\">');
				 document.write('<%=gettxth("3832",20) %>');
			 document.write('</div>');
		 document.write('</div>');
		 document.write('<div class=\"item\">');
			 document.write('<h3><i class=\"pt2\"></i>彩妆</h3>');
			 document.write('<div class=\"list\">');
				document.write('<%=gettxth("3833",20) %>');
			 document.write('</div>');
		 document.write('</div>');
		 document.write('<div class=\"item\">');
			 document.write('<h3><i class=\"pt3\"></i>香水香氛</h3>');
			 document.write('<div class=\"list\">');
				document.write('<%=gettxth("3839",20) %>');
			 document.write('</div>');
		 document.write('</div>');
				 document.write('<div class=\"item\">');
			 document.write('<h3><i class=\"pt4\"></i>身体护理</h3>');
			 document.write('<div class=\"list\">');
				document.write('<%=gettxth("3840",20) %>');
			 document.write('</div>');
		 document.write('</div>');
				 document.write('<div class=\"item\">');
			 document.write('<h3><i class=\"pt5\"></i>男士专区</h3>');
			 document.write('<div class=\"list\">');
				document.write('<%=gettxth("3841",20) %>');
			 document.write('</div>');
		 document.write('</div>');
				 document.write('<div class=\"item\">');
			 document.write('<h3><i class=\"pt6\"></i>热门搜索</h3>');
			 document.write('<div class=\"list\">');
				document.write('<%=gettxth("3842",20) %>');
			 document.write('</div>');
		 document.write('</div>');
				 document.write('<div class=\"item\">');
			 document.write('<h3><i class=\"pt7\"></i>男人馆</h3>');
			 document.write('<div class=\"list\">');
				document.write('<%=gettxth("3843",20) %>');
			 document.write('</div>');
		 document.write('</div>');
				 document.write('<div class=\"item\">');
			 document.write('<h3><i class=\"pt8\"></i>女人街</h3>');
			 document.write('<div class=\"list\">');
				document.write('<%=gettxth("3844",20) %>');
			 document.write('</div>');
		 document.write('</div>');
	 document.write('</div>');
	 document.write('<div class=\"hmr\">');
		 document.write('<div class=\"item\">');
		 document.write('<h3><i class=\"pt9\"></i>热卖品牌</h3>');
		 document.write('<div class=\"list\">');
		        document.write('<%=gettxth("3883",60) %>');
		 document.write('</div>');
		 document.write('</div>');
	 document.write('</div>');
 document.write('</div>');