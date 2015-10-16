<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
public static ArrayList<Gdscoll> getGdscollBySerid(String sid,String sex)
{
	
	ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	if(sid!=null&&sid.length()>0&&Tools.isNumber(sid))
	{
	  clist.add(Restrictions.eq("gdscoll_serid",new Long(Tools.parseLong(sid))));
	}
	clist.add(Restrictions.eq("gdscoll_flag",new Long(1)));
	if(sex!=null&&sex.length()>0)
	{
		 clist.add(Restrictions.eq("gdscoll_cate",new Long(sex)));
	}	
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.desc("gdscoll_createdate"));
	List<BaseEntity> blist=Tools.getManager(Gdscoll.class).getList(clist, olist, 0, 15);
	if(blist!=null&&blist.size()>0)
	{
		for(BaseEntity b:blist)
		{
			if(b!=null)
			{
				list.add((Gdscoll)b);
			}
		}
	}
	return list;
	
}
%>


<%
String id="";
String gdsser="5";
String sex="";
String bg="";
String color="";
String img="";
if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
{
   	id=request.getParameter("id");
}
if(id.length()>0)
{
   if(id.equals("jztm"))
   {
	   gdsser="5";
	   bg="http://images.d1.com.cn/images2012/fmdpbg3_1.jpg";
	   color="#9F486A";
	   img="<img src=\"http://images.d1.com.cn/images2012/index2012/nov/dpy_34.jpg\"/>";
   }
   else if(id.equals("qpka"))
   {
	   gdsser="7";
	   bg="http://images.d1.com.cn/images2012/fmdpbg3_1.jpg";
	   color="#9F486A";
	   img="<img src=\"http://images.d1.com.cn/images2012/index2012/nov/dpy_36.jpg\"/>";
   }
   else if(id.equals("yysn"))
   {
	   gdsser="6";
	   bg="http://images.d1.com.cn/images2012/fmdpbg3_1.jpg";
	   color="#9F486A";
	   img="<img src=\"http://images.d1.com.cn/images2012/index2012/nov/dpy_38.jpg\"/>";
   }
   else if(id.equals("zcol"))
   {
	   gdsser="9";
	   bg="http://images.d1.com.cn/images2012/fmdpbg4_1.jpg";
	   color="#9F486A";
	   img="<img src=\"http://images.d1.com.cn/images2012/index2012/nov/dpy_40.jpg\"/>";
   }
   else if(id.equals("jtdn"))
   {
	   gdsser="10";
	   bg="http://images.d1.com.cn/images2012/fmdpbg4_1.jpg";
	   color="#9F486A";
	   img="<img src=\"http://images.d1.com.cn/images2012/index2012/nov/dpy_42.jpg\"/>";
   }
   else if(id.equals("gjjd"))
   {
	   gdsser="11";
	   bg="http://images.d1.com.cn/images2012/fmdpbg4_1.jpg";
	   color="#9F486A";
	   img="<img src=\"http://images.d1.com.cn/images2012/index2012/nov/dpy_44.jpg\"/>";
   }
   else if(id.equals("hlxx"))
   {
	   gdsser="1";
	   sex="2";
	   bg="http://images.d1.com.cn/images2012/fmdpbg2_1.jpg";
	   color="#919191";
	   img="<img src=\"http://images.d1.com.cn/images2012/index2012/nov/dpy_46.jpg\"/>";
   }
   else if(id.equals("hwxx"))
   {
	   gdsser="3";
	   sex="2";
	   bg="http://images.d1.com.cn/images2012/fmdpbg2_1.jpg";
	   color="#919191";
	   img="<img src=\"http://images.d1.com.cn/images2012/index2012/nov/dpy_48.jpg\"/>";
   }
   else if(id.equals("xbhw"))
   {
	   gdsser="3";
	   bg="http://images.d1.com.cn/images2012/fmdpbg2_1.jpg";
	   color="#919191";
	   img="<img src=\"http://images.d1.com.cn/images2012/index2012/nov/dpy_48.jpg\"/>";
   }
   else if(id.equals("bmjz"))
   {
	   gdsser="1";
	   bg="http://images.d1.com.cn/images2012/fmdpbg2_1.jpg";
	   color="#919191";
	   img="<img src=\"http://images.d1.com.cn/images2012/index2012/nov/dpy_46.jpg\"/>";
   }
   else if(id.equals("jjxy"))
   {
	   gdsser="4";
	   bg="http://images.d1.com.cn/images2012/fmdpbg2_1.jpg";
	   color="#919191";
	   img="<img src=\"http://images.d1.com.cn/images2012/index2012/nov/dpy_50.jpg\"/>";
   }
   else
   {
	   gdsser="5";
	   bg="http://images.d1.com.cn/images2012/fmdpbg3_1.jpg";
	   color="#9F486A";
	   img="<img src=\"http://images.d1.com.cn/images2012/index2012/nov/dpy_34.jpg\"/>";
   }
   ArrayList<Gdscoll> gdscolllist=getGdscollBySerid(gdsser,sex);
   if(gdscolllist!=null&&gdscolllist.size()>0)
   {%>
   <%=img %>
   <div class="fmlist" style="background:url('<%= bg%>') repeat-y; width:980px;overflow:hidden;">
   <table>
   <tr>
   <td>
   
	   <ul>
		<%		
		int count=0;
		for(int i=0;i<gdscolllist.size();i++){
			Gdscoll scoll=gdscolllist.get(i);			
				//查看搭配详细
				int counts=0;
				ArrayList<Gdscolldetail> gdetaillist=GdscollHelper.getGdscollBycollid1(scoll.getId());
				if(gdetaillist!=null)
				{
					for(Gdscolldetail gd:gdetaillist)
					{
						Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
						if(p!=null&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
							counts++;
							
						}
					}
				}
				
				if(counts>1){
				
				count++;
				if(count%5==1)
				{%>
					<li style="margin-left:0px;height:400px;">
				<%}
				else
				{%>
					<li>
				<%}
		%>
		<a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%=scoll.getId() %>" target="_blank" ><img src="http://images1.d1.com.cn<%=scoll.getGdscoll_brandimg() %>" border="0" /></a>
		<%  
		   ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid(scoll.getId());
		   if(gdlist!=null&&gdlist.size()>0)
		   {
			   int newsum=0;
			   out.print("<p>");
			   for(Gdscolldetail gd:gdlist)
			   {
				   if(gd!=null&&gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1&&gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
				   {
					   newsum++;
					   Product product=ProductHelper.getById(gd.getGdscolldetail_gdsid());
					   if(product!=null&&product.getGdsmst_ifhavegds().longValue()==0&&product.getGdsmst_validflag().longValue()==1)
					   {%>
						   <span style="color:<%= color%>"><a href="http://www.d1.com.cn/product/<%= product.getId()%>" target="_blank" style="color:<%= color%>"><%= gd.getGdscolldetail_title()%></a>&nbsp;<font><%= Tools.getFormatMoney(product.getGdsmst_memberprice().floatValue())%></font></span>
					  <% }
				   }
				   
			   }
			   out.print("</p>");	
		   }  
		   %>
		</li>
		<%
		}
		}
		%>
		</ul>
		</td>
   </tr>
   </table>
   </div>
		<%
   }
   
}

%>
