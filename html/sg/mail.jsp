<%@ page contentType="text/html; charset=GBK"%><%@include file="/html/headerg.jsp" %>
<%@include file="../public_email.jsp"%>
<%!
public static ArrayList<SgGdsDtl> getsghot(){
	ArrayList<SgGdsDtl> list = new ArrayList<SgGdsDtl>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));//1ÉÏ¼Ü
	clist.add(Restrictions.eq("sggdsdtl_mailflag", new Long(1)));//Ö»ÓÐÔÚÓÊ¼þÏÔÊ¾
	clist.add(Restrictions.le("sggdsdtl_cls", new Long(4)));
	clist.add(Restrictions.le("sggdsdtl_sdate", new Date()));
	clist.add(Restrictions.ge("sggdsdtl_edate",  new Date()));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("sggdsdtl_mailsort"));
	olist.add(Order.desc("sggdsdtl_sdate"));
	List<BaseEntity> b_list = Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 40);
	//System.out.println("=b_list.size()==33===="+b_list.size());
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((SgGdsDtl)be);
		}
	}
	return list ;
}	
public static ArrayList<Promotion> getPromotion(String code){
	ArrayList<Promotion> list = new ArrayList<Promotion>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("splmst_code", new Long(code)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("splmst_createdate"));
	olist.add(Order.asc("splmst_seqview"));
	List<BaseEntity> p_list = Tools.getManager(Promotion.class).getList(clist, olist, 0, 50);
	if(p_list!=null){
		for(BaseEntity be:p_list){
			list.add((Promotion)be);
		}
	}
	return list ;
}
public static String getClassifyList(String code ,String subad){
	if(Tools.isNull(code)){
		return "";
	}
	String str = "";
	ArrayList<Promotion> index_plist=new ArrayList<Promotion>();//¶ÁÈ¡ÎÄ×ÖºÍÍ¼Æ¬ÍÆ¼öÎ»
	index_plist=getPromotion(code);
	StringBuilder sb=new StringBuilder();
	if(index_plist!=null&&index_plist.size()>0){
		for(int i = 0;i < index_plist.size();i++){
			sb.append("<a href=\""+index_plist.get(i).getSplmst_url()+"\" title=\""+index_plist.get(i).getSplmst_name()+"\" target=\"_blank\">");
			sb.append("<img border=\"0\" src="+index_plist.get(i).getSplmst_picstr()+" alt="+index_plist.get(i).getSplmst_name()+" style=\" margin-bottom:3px;\"  width=\"750px;\" />");
			sb.append("</a>");
		}
		
	}
	if(sb.toString() != null){
		 str = GetSubadContent(sb.toString(),subad);
	}
	return str;
}
public static String getmslist(String subad){
	//String subad = "shangou";
    SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	StringBuilder sb=new StringBuilder();
	  List<SgGdsDtl> sglist1=getsghot(); 
      if(sglist1!=null&&sglist1.size()>0){
      	String gdsid="";
      	for(SgGdsDtl sg:sglist1){
      		gdsid=sg.getSggdsdtl_gdsid();
              Product product=ProductHelper.getById(gdsid);
             // boolean ismiaoshao=false;
             // ismiaoshao = CartHelper.getmsflag(product);
              //if(product==null)continue;
         	Date edate=product.getGdsmst_promotionend();
         	Date ndate=new Date();
              
             if(edate.getTime()<ndate.getTime())continue;
             long gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
             long gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum().longValue();
             if (gdsnum<=0||gdsnum2<=0 ||product.getGdsmst_validflag().longValue()==2){
             	  gdsnum=0;
             }
             String gdstitle=sg.getSggdsdtl_gdsname();
             if (gdstitle!=null&&gdstitle.length()>38){
            	 gdstitle=gdstitle.substring(0,38);
             }
             String gdsmemo=sg.getSggdsdtl_memo();
             if(Tools.isNull(gdsmemo))
             {
            	 gdsmemo=product.getGdsmst_title();
             }
             if (gdsmemo!=null&&gdsmemo.length()>25){
            	 gdsmemo=gdsmemo.substring(0,25);
             }
             
            sb.append("<li style=\"float:left; padding-left:20px; list-style:none\">");
	        sb.append("<table width=\"340\" height=\"530\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#ffffff\" style=\"margin:10px 0px;border:1px solid #D9dee1;\">");
	        sb.append("<tr>");
	        sb.append("<td width=\"310\" height=\"310\">");
	        sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\"><img src=\"http://images1.d1.com.cn").append(product.getGdsmst_img310()).append("\" width=\"310\" height=\"310\" style=\"padding:12px 15px;\" border=\"0\">");
	        sb.append("</a></td>");
	        sb.append("</tr>");
	        sb.append("<tr>");
	        sb.append("<td height=\"50\" style=\"font-family:'Î¢ÈíÑÅºÚ'; font-size:16px; color:#333333;padding: 0px 20px;\">");
	        sb.append("<a style=\"color: #333;\" href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\" title=\"").append(sg.getSggdsdtl_gdsname()).append("\">");
	        sb.append("<span style=\"line-height:25px;\">");
	        sb.append(gdstitle);
	        sb.append("</span>");
			sb.append("</a>");
	        sb.append("</td>");
	        sb.append("</tr>");
	        sb.append("<tr>");
	        sb.append("<td height=\"25\"><span style=\"font-family:'Î¢ÈíÑÅºÚ';padding-left:23px; font-size:12px;color:#ff3366;padding: 0px 20px;\">");
	        sb.append(gdsmemo);
	        sb.append("</span></td>");
	        sb.append("</tr>");
	        sb.append("<tr>");
	        sb.append("<td height=\"95\">");
	        sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\" title=\"").append(sg.getSggdsdtl_gdsname()).append("\">");
	        if(gdsnum > 0){
	        	sb.append("<div style=\"width:320px; height:90px;background: url('http://images.d1.com.cn/zt2014/0110/flashbar.png') no-repeat;margin-left:10px;\">");
	        }else{
	        	sb.append("<div style=\"width:320px; height:90px;background: url('http://images.d1.com.cn/zt2014/0110/saleout.jpg') no-repeat;margin-left:10px;\">");	
	        }
	        sb.append("<table width=\"320\" height=\"90px\"  border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
	        sb.append("<tr>");
	        sb.append("<td width=\"140\">");
	        sb.append("<br/><span style=\"font-family:'Î¢ÈíÑÅºÚ'; font-size:20px;color:#ffffff;vertical-align: top; \">&nbsp;&nbsp;ÏÞÁ¿").append(sg.getSggdsdtl_vallnum()).append("¼þ</span>"); 
	        sb.append("</td>");
	        sb.append("<td width=\"180\" height=\"60\" style=\"vertical-align: bottom;padding-right:10px;text-align:right;\">");
	        sb.append("<span style=\"font-family:'Î¢ÈíÑÅºÚ'; font-size:22pt;color:#ff0D26; vertical-align: middle;line-height:20px;\">£¤<span style=\" font-family:'arial'; font-size:34pt;color:#ff0D26; line-height:50px;\">");
	        if(product.getGdsmst_msprice() != null && product.getGdsmst_msprice() < 10){
	        	sb.append(Tools.getDouble(product.getGdsmst_msprice(), 1));
	        }else{
	        	sb.append(product.getGdsmst_msprice().longValue());
	        }
	        sb.append("</span></span>");
	        sb.append("</td>");
	        sb.append("</tr>");
	        sb.append("<tr height=\"30\"><td style=\"vertical-align: top;\">");
	        sb.append("<span style=\"font-family:'Î¢ÈíÑÅºÚ'; font-size:20px;color:#ffffff; line-height:20px;\">&nbsp;&nbsp;");
	        if(gdsnum > 0){
	        	sb.append("½öÊ£<span style=\"color:#fdbb4a;\">").append(gdsnum).append("</span>¼þ");
	        }else{
	        	sb.append("<span style=\"color:#D9Dee1;font-size:22px;\">ÇÀ¹âÀ²£¡</span>");
	        }
	        sb.append("</span>");
	        sb.append("</td><td style=\"padding-right:10px;text-align:right;\">");
	        sb.append("<span style=\"font-family:'Î¢ÈíÑÅºÚ'; font-size:14px;color:#ffffff;vertical-align: top;line-height:15px;\">ÊÐ³¡¼Û£º<del>").append(product.getGdsmst_saleprice()).append("</del></span>");
	        sb.append("</td></tr>");
	        sb.append("</table>");
	        sb.append("</div>");
	        sb.append("</a>");
	        sb.append("</td>");
	        sb.append("</tr>");
			sb.append("<tr>");
			sb.append("<td height=\"20\">&nbsp;</td>");
			sb.append("</tr>");
			sb.append("</table>");
      		sb.append("</li>");
     }
      	}
      return sb.toString();
}
public static List<SgGdsDtl> getSgHotList2(){
	
	List<SgGdsDtl> list=new ArrayList<SgGdsDtl>();
	SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));
	clist.add(Restrictions.eq("sggdsdtl_cls", new Long(7)));

	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("sggdsdtl_sort"));
	olist.add(Order.desc("sggdsdtl_sdate"));
	
	List<BaseEntity> blist=Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 6);
	if(blist!=null){
		for(BaseEntity be:blist){
			SgGdsDtl sg=(SgGdsDtl)be ;
			list.add(sg);

		}
	}
	return list;
}

public static String getcjsglist(String subad){
	//String subad = "shangou";
    SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	StringBuilder sb=new StringBuilder();
	  List<SgGdsDtl> sglist1=getSgHotList2(); 
      if(sglist1!=null&&sglist1.size()>0){
      	String gdsid="";
      	for(SgGdsDtl sg:sglist1){
      		gdsid=sg.getSggdsdtl_gdsid();
              Product product=ProductHelper.getById(gdsid);
             	Date sdate=product.getGdsmst_promotionstart();
              	Date edate=product.getGdsmst_promotionend();	
    			if(product.getGdsmst_validflag().longValue()==1&&sdate!=null
    					&&((edate.getTime()>(new Date()).getTime())&&(sdate.getTime()<(new Date()).getTime()&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31))){
    			
         	Date ndate=new Date();
              

             long gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
             long gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum().longValue();
             if (gdsnum<=0||gdsnum2<=0 ||product.getGdsmst_validflag().longValue()==2){
             	  gdsnum=0;
             }
             String gdstitle=sg.getSggdsdtl_gdsname();
             if (gdstitle!=null&&gdstitle.length()>38){
            	 gdstitle=gdstitle.substring(0,38);
             }
             String gdsmemo=sg.getSggdsdtl_memo();
             if(Tools.isNull(gdsmemo))
             {
            	 gdsmemo=product.getGdsmst_title();
             }
             if (gdsmemo!=null&&gdsmemo.length()>25){
            	 gdsmemo=gdsmemo.substring(0,25);
             }
            sb.append("<li style=\"float:left; padding-left:20px; list-style:none\">");
	        sb.append("<table width=\"340\" height=\"530\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#ffffff\" style=\"margin:10px 0px;border:1px solid #D9dee1;\">");
	        sb.append("<tr>");
	        sb.append("<td width=\"310\" height=\"310\">");
	        sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\"><img src=\"http://images1.d1.com.cn").append(product.getGdsmst_img310()).append("\" width=\"310\" height=\"310\" style=\"padding:12px 15px;\" border=\"0\">");
	        sb.append("</a></td>");
	        sb.append("</tr>");
	        sb.append("<tr>");
	        sb.append("<td height=\"50\" style=\"font-family:'Î¢ÈíÑÅºÚ'; font-size:16px; color:#333333;padding: 0px 20px;\">");
	        sb.append("<a style=\"color: #333;\" href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\" title=\"").append(sg.getSggdsdtl_gdsname()).append("\">");
	        sb.append("<span style=\"line-height:25px;\">");
	        sb.append(gdstitle);
	        sb.append("</span>");
			sb.append("</a>");
	        sb.append("</td>");
	        sb.append("</tr>");
	        sb.append("<tr>");
	        sb.append("<td height=\"25\"><span style=\"font-family:'Î¢ÈíÑÅºÚ';padding-left:23px; font-size:12px;color:#ff3366;padding: 0px 20px;\">");
	        sb.append(gdsmemo);
	        sb.append("</span></td>");
	        sb.append("</tr>");
	        sb.append("<tr>");
	        sb.append("<td height=\"95\">");
	        sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\" title=\"").append(sg.getSggdsdtl_gdsname()).append("\">");
	        if(gdsnum > 0){
	        	sb.append("<div style=\"width:320px; height:90px;background: url('http://images.d1.com.cn/zt2014/0110/flashbar.png') no-repeat;margin-left:10px;\">");
	        }else{
	        	sb.append("<div style=\"width:320px; height:90px;background: url('http://images.d1.com.cn/zt2014/0110/saleout.jpg') no-repeat;margin-left:10px;\">");	
	        }
	        sb.append("<table width=\"320\" height=\"90px\"  border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
	        sb.append("<tr>");
	        sb.append("<td width=\"140\">");
	        sb.append("<br/><span style=\"font-family:'Î¢ÈíÑÅºÚ'; font-size:20px;color:#ffffff;vertical-align: top; \">&nbsp;&nbsp;ÏÞÁ¿").append(sg.getSggdsdtl_vallnum()).append("¼þ</span>"); 
	        sb.append("</td>");
	        sb.append("<td width=\"180\" height=\"60\" style=\"vertical-align: bottom;padding-right:10px;text-align:right;\">");
	        sb.append("<span style=\"font-family:'Î¢ÈíÑÅºÚ'; font-size:22pt;color:#ff0D26; vertical-align: middle;line-height:20px;\">£¤<span style=\" font-family:'arial'; font-size:34pt;color:#ff0D26; line-height:50px;\">");
	        if(product.getGdsmst_msprice() != null && product.getGdsmst_msprice() < 10){
	        	sb.append(Tools.getDouble(product.getGdsmst_msprice(), 1));
	        }else{
	        	sb.append(product.getGdsmst_msprice().longValue());
	        }
	        sb.append("</span></span>");
	        sb.append("</td>");
	        sb.append("</tr>");
	        sb.append("<tr height=\"30\"><td style=\"vertical-align: top;\">");
	        sb.append("<span style=\"font-family:'Î¢ÈíÑÅºÚ'; font-size:20px;color:#ffffff; line-height:20px;\">&nbsp;&nbsp;");
	        if(gdsnum > 0){
	        	sb.append("½öÊ£<span style=\"color:#fdbb4a;\">").append(gdsnum).append("</span>¼þ");
	        }else{
	        	sb.append("<span style=\"color:#D9Dee1;font-size:22px;\">ÇÀ¹âÀ²£¡</span>");
	        }
	        sb.append("</span>");
	        sb.append("</td><td style=\"padding-right:10px;text-align:right;\">");
	        sb.append("<span style=\"font-family:'Î¢ÈíÑÅºÚ'; font-size:14px;color:#ffffff;vertical-align: top;line-height:15px;\">ÊÐ³¡¼Û£º<del>").append(product.getGdsmst_saleprice()).append("</del></span>");
	        sb.append("</td></tr>");
	        sb.append("</table>");
	        sb.append("</div>");
	        sb.append("</a>");
	        sb.append("</td>");
	        sb.append("</tr>");
			sb.append("<tr>");
			sb.append("<td height=\"20\">&nbsp;</td>");
			sb.append("</tr>");
			sb.append("</table>");
      		sb.append("</li>");
     }
      	}
      }
      return sb.toString();
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>ÉÁ¹ºÆµµÀÂ¡ÖØµÇ³¡-D1ÓÅÉÐÍø</title>
</head>
<body bgcolor="#f6f6f6"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<% ActIndex act_list = null;
String subad = request.getParameter("subad");
String tj = request.getParameter("tj");
%>
<!-- Í·²¿¿ªÊ¼ -->
<%@include file="/html/mail_header.jsp"%>
<!-- Í·²¿½áÊø -->
<center>
<div style="width: 750px;overflow: hidden;">
<div>
<%=getClassifyList("3675",subad)%>	
</div>
<%if(!Tools.isNull(tj)){
List<Promotion> zt_plist=PromotionHelper.getBrandListByCode("3697", -1);
	if(zt_plist!=null&&zt_plist.size()>0){ 
		%>
		<div align="left" ><img src="http://images.d1.com.cn/images2014/sgmail/h1-1.png"></div>
		<table width="750" border="0" cellspacing="0" cellpadding="0">
		<%
			int i=1;
			for(Promotion p:zt_plist){
				if(p!=null){
					if(i%2!=0){
				%>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="40" > <img src="http://images.d1.com.cn/zt2014/m_left.jpg" width="5" height="24" /> <a href="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=<%= p.getSplmst_url()!=null?p.getSplmst_url():""  %>" target="_blank" style="font-size:18px;font-family: Î¢ÈíÑÅºÚ;color:#000;"><%=p.getSplmst_name() !=null?p.getSplmst_name():"" %></a></td>
      </tr>
      <tr>
        <td>
  <a href="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=<%= p.getSplmst_url()!=null?p.getSplmst_url():""  %>" target="_blank"><img src="<%= p.getSplmst_picstr() %>" width="370" height="227"  border="0"  />
		              </a>
</td>
      </tr>
    </table></td>
    <%}else{ %>
    <td style="padding-left:5px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="40" ><img src="http://images.d1.com.cn/zt2014/m_left.jpg" width="5" height="24" /> <a href="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=<%= p.getSplmst_url()!=null?p.getSplmst_url():""  %>" target="_blank" style="font-size:18px;font-family: Î¢ÈíÑÅºÚ;color:#000;"><%=p.getSplmst_name() !=null?p.getSplmst_name():"" %></a></td>
      </tr>
      <tr>
        <td> <a href="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=<%= p.getSplmst_url()!=null?p.getSplmst_url():""  %>" target="_blank"><img src="<%= p.getSplmst_picstr() %>" width="370" height="227" border="0" />
		              </a></td>
      </tr>
    </table></td>
  </tr>
  <%}
				i++;
				}
			}
		%>
</table>
		<%
	}
}
%>
<!-- <ul style="list-style-type: none;margin: 0;padding: 0;">
<div align="left" ><img src="http://images.d1.com.cn/images2014/sgmail/h2-1.png"></div>
     <//=getcjsglist(subad) %> 
</ul> -->
<ul style="list-style-type: none;margin: 0;padding: 0;">
<div align="left" ><a href="http://www.d1.com.cn/buy/lianmeng.asp?id=d1_1111&subad=sg0902&url=http://www.d1.com.cn/html/sg/" target="_blank"><img src="http://images.d1.com.cn/images2014/sgmail/h3-1.png" border="0"></a></div>
  <%=getmslist(subad) %>
</ul>
</div>
</center>
<%//String subad = "shangou"; %>
<%@include file="/html/mail_tail.jsp"%>
</body>
</html>
