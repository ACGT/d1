<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%
	String type=request.getParameter("type");
	if(type.equals("1"))
	{
		String ss = request.getParameter("sku");
	%>
	      <tr><td height="36" style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;" attr="0"><%=ss %></td>
          <td style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;">
          <input type="text" id="kc1" name="kc1" style="border:solid 1px #d4d4d4;background:#f8f8f8;width:140px;height:22px;"></input></td>
          <td style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;"><select id="zt1" name="zt1">
             <option value="1">上架</option>
             <option value="0">下架</option>
          </select></td>
          <td style="border-bottom:solid 1px #72dbff;border-right:solid 1px #72dbff;">
          <input type="text" id="kctb1" name="kctb1" style="border:solid 1px #d4d4d4;background:#f8f8f8;width:140px;height:22px;"></input></td>
          <td style="border-bottom:solid 1px #72dbff;"><a href="javascript:void(0)" onclick="deleteSku(this)" style="color:#333; text-decoration:none;">删除</a></td>
          </tr>
	<%}
	else
	{
		String rack = request.getParameter("code");
		if(rack.substring(0,2).equals("02")||rack.substring(0,2).equals("03"))
		{%>
			<OPTION VALUE="尺寸">尺寸</OPTION>
			<OPTION VALUE="颜色">颜色</OPTION>

		<%}
		else
		{
			Directory dir=DirectoryHelper.getById(rack);
			String stdid="";
			if(dir!=null)
			{
				if(dir.getRakmst_stdid()!=null&&dir.getRakmst_stdid().toString().length()>0)
				{			
					stdid=dir.getRakmst_stdid().toString();			
				}
				else
				{
					Directory dir1=DirectoryHelper.getById(dir.getRakmst_parentrackcode());
					if(dir1!=null&&dir1.getRakmst_stdid().length()>0)
					{				
						stdid=dir1.getRakmst_stdid();
					}
				}
			}
			if(dir!=null)
			{
				if(stdid.length()>0)
				{		
					Standard sta=StandardHelper.GetStandarBysid(stdid);
					if(sta!=null)
					{
						if(sta.getStdmst_atrname1()!="")
						{%>
							<OPTION VALUE="<%= sta.getStdmst_atrname1()%>"><%=sta.getStdmst_atrname1() %></OPTION>
						<%}
						if(sta.getStdmst_atrname2()!="")
						{%>
							<OPTION VALUE="<%= sta.getStdmst_atrname2()%>"><%=sta.getStdmst_atrname2() %></OPTION>
						<%}
						if(sta.getStdmst_atrname3()!="")
						{%>
							<OPTION VALUE="<%= sta.getStdmst_atrname3()%>"><%=sta.getStdmst_atrname3() %></OPTION>
						<%}
						if(sta.getStdmst_atrname4()!="")
						{%>
							<OPTION VALUE="<%= sta.getStdmst_atrname4()%>"><%=sta.getStdmst_atrname4() %></OPTION>
						<%}
						if(sta.getStdmst_atrname5()!="")
						{%>
							<OPTION VALUE="<%= sta.getStdmst_atrname5()%>"><%=sta.getStdmst_atrname5() %></OPTION>
						<%}
						if(sta.getStdmst_atrname6()!="")
						{%>
							<OPTION VALUE="<%= sta.getStdmst_atrname6()%>"><%=sta.getStdmst_atrname6() %></OPTION>
						<%}
						if(sta.getStdmst_atrname7()!="")
						{%>
							<OPTION VALUE="<%= sta.getStdmst_atrname7()%>"><%=sta.getStdmst_atrname7() %></OPTION>
						<%}
						if(sta.getStdmst_atrname8()!="")
						{%>
							<OPTION VALUE="<%= sta.getStdmst_atrname8()%>"><%=sta.getStdmst_atrname8() %></OPTION>
						<%}
						
					}
					
				}
			}
		}
	}
	%>