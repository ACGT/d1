<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%
	String rack = request.getParameter("code");
	String gdsid=request.getParameter("gdsid");
	Directory dir=DirectoryHelper.getById(rack); 
	Product p=ProductHelper.getById(gdsid);
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
	if(stdid.length()>0)
	{		
		Standard sta=StandardHelper.GetStandarBysid(stdid);
		if(sta!=null)
		{	
	      String spestr=sta.getStdmst_spestr();
		  if(sta.getStdmst_atrdtl1().length()>0)
		  {%>
		  <div id="req_div1" style="border-bottom:dashed 1px #d4d4d4; width:770px;  line-height:45px;">
			  <input type="hidden" id="req_stdchar1" name="req_stdchar1" value="1">
			 <font id="fgg1" style="color:#f00" >*</font><b><%= sta.getStdmst_atrname1() %>：</b>
		  <%
		      String[] req1=sta.getStdmst_atrdtl1().split(";");
		      String gstr1=p.getGdsmst_stdvalue1();
		      for(String str:req1)
		      {
		    	  if(str.length()>0)
		    	  {%>
		    		  <input type="checkbox" name="req_stdvalue1" value="<%= str%>" <% if(gstr1.indexOf(str)>=0){ %>checked="true"<%} %> ><%=str%>&nbsp;&nbsp;
		    	  <%}
		    	  
		      }
		      %>
		      </div>
		      <%
		  }
		  if(sta.getStdmst_atrdtl2().length()>0)
		  {%>
		   <div id="req_div2" style="border-bottom:dashed 1px #d4d4d4;width:770px;  line-height:45px;">
			  <input type="hidden" id="req_stdchar2" name="req_stdchar2" value="2">
			  <font id="fgg2" style="color:#f00" >*</font><b><%= sta.getStdmst_atrname2() %>：</b>
		  <%
		      String gstr2=p.getGdsmst_stdvalue2();
		      String[] req2=sta.getStdmst_atrdtl2().split(";");
		      for(String str:req2)
		      {
		    	  if(str.length()>0)
		    	  {%>
		    		  <input type="checkbox" name="req_stdvalue2" value="<%= str%>" <% if(gstr2.indexOf(str)>=0){ %>checked="true"<%} %>><%=str%>&nbsp;
		    	  <%}
		    	  
		      }%>
		    </div>  
		  <%}
		  if(sta.getStdmst_atrdtl3().length()>0)
		  {%>
		   <div id="req_div3" style="border-bottom:dashed 1px #d4d4d4;width:770px; line-height:45px;">
			  <input type="hidden" id="req_stdchar3" name="req_stdchar3" value="3">
			  <font id="fgg3" style="color:#f00" >*</font><b><%= sta.getStdmst_atrname3() %>：</b>
		  <%
		  String gstr3=p.getGdsmst_stdvalue3();
		      String[] req3=sta.getStdmst_atrdtl3().split(";");
		      for(String str:req3)
		      {
		    	  if(str.length()>0)
		    	  {%>
		    		  <input type="checkbox" name="req_stdvalue3" value="<%= str%>" <% if(gstr3.indexOf(str)>=0){ %>checked="true"<%} %>><%=str%>&nbsp;
		    	  <%}
		    	  
		      }%>
		      </div>
		  <%}
		  if(sta.getStdmst_atrdtl4().length()>0)
		  {%>
		   <div id="req_div4" style="border-bottom:dashed 1px #d4d4d4;width:770px;  line-height:45px;">
			  <input type="hidden" id="req_stdchar4" name="req_stdchar4" value="4">
			  <font id="fgg4" style="color:#f00" >*</font><b><%= sta.getStdmst_atrname4() %>：</b>
		  <%
		  String gstr4=p.getGdsmst_stdvalue4();
		      String[] req4=sta.getStdmst_atrdtl4().split(";");
		      for(String str:req4)
		      {
		    	  if(str.length()>0)
		    	  {%>
		    		  <input type="checkbox" name="req_stdvalue4" value="<%= str%>" <% if(gstr4.indexOf(str)>=0){ %>checked="true"<%} %>><%=str%>&nbsp;
		    	  <%}
		    	  
		      }%>
		      </div>
		  <%}
		  if(sta.getStdmst_atrdtl5().length()>0)
		  {%>
		  <div id="req_div5" style="border-bottom:dashed 1px #d4d4d4;width:770px;  line-height:45px;">
			  <input type="hidden" id="req_stdchar5" name="req_stdchar5" value="5">
			  <font id="fgg5" style="color:#f00" >*</font><b><%= sta.getStdmst_atrname5() %>：</b>
		  <%
		  String gstr5=p.getGdsmst_stdvalue5();
		      String[] req5=sta.getStdmst_atrdtl5().split(";");
		      for(String str:req5)
		      {
		    	  if(str.length()>0)
		    	  {%>
		    		  <input type="checkbox" name="req_stdvalue5" value="<%= str%>" <% if(gstr5.indexOf(str)>=0){ %>checked="true"<%} %>><%=str%>&nbsp;
		    	  <%}
		    	  
		      }%>
		      </div>
		  <%}
		  if(sta.getStdmst_atrdtl6().length()>0)
		  {%>
		  <div id="req_div6" style="border-bottom:dashed 1px #d4d4d4;width:770px;  line-height:45px;">
			  <input type="hidden" id="req_stdchar6" name="req_stdchar6" value="6">
			  <font id="fgg6" style="color:#f00" >*</font><b><%= sta.getStdmst_atrname6() %>：</b>
		  <%
		  String gstr6=p.getGdsmst_stdvalue6();
		      String[] req6=sta.getStdmst_atrdtl6().split(";");
		      for(String str:req6)
		      {
		    	  if(str.length()>0)
		    	  {%>
		    		  <input type="checkbox" name="req_stdvalue6" value="<%= str%>" <% if(gstr6.indexOf(str)>=0){ %>checked="true"<%} %>><%=str%>&nbsp;
		    	  <%}
		    	  
		      }%>
		      </div>
		  <%}
		  if(sta.getStdmst_atrdtl7().length()>0)
		  {%>
		  <div id="req_div7" style="border-bottom:dashed 1px #d4d4d4;width:770px;  line-height:45px;">
			  <input type="hidden" id="req_stdchar7" name="req_stdchar7" value="7">
			  <font id="fgg7" style="color:#f00" >*</font><b><%= sta.getStdmst_atrname7() %>：</b>
		  <%
		  String gstr7=p.getGdsmst_stdvalue7();
		      String[] req7=sta.getStdmst_atrdtl7().split(";");
		      for(String str:req7)
		      {
		    	  if(str.length()>0)
		    	  {%>
		    		  <input type="checkbox" name="req_stdvalue7" value="<%= str%>" <% if(gstr7.indexOf(str)>=0){ %>checked="true"<%} %>><%=str%>&nbsp;
		    	  <%}
		    	  
		      }%>
		      </div>
		  <%}
		  if(Tools.parseInt(stdid)<200||Tools.parseInt(stdid)==211||Tools.parseInt(stdid)==230
				  ||Tools.parseInt(stdid)==241||Tools.parseInt(stdid)==242||Tools.parseInt(stdid)==252)
			{
		  if(sta.getStdmst_atrdtl8().length()>0)
		  {%>
		  <div id="req_div8" style="border-bottom:dashed 1px #d4d4d4;width:770px;  line-height:45px;">
			  <input type="hidden" id="req_stdchar8" name="req_stdchar8" value="8">
			  <font id="fgg8" style="color:#f00" >*</font><b><%= sta.getStdmst_atrname8() %>：</b>
		  <%
		  String gstr8=p.getGdsmst_stdvalue8();
		      String[] req8=sta.getStdmst_atrdtl8().split(";");
		      for(String str:req8)
		      {
		    	  if(str.length()>0)
		    	  {%>
		    		  <input type="checkbox" name="req_stdvalue8" value="<%= str%>" <% if(gstr8.indexOf(str)>=0){ %>checked="true"<%} %>><%=str%>&nbsp;
		    	  <%}
		    	  
		      }%>
		      </div>
		  <%}
			}else{
		  %>
				<div id="req_div8" style="border-bottom:dashed 1px #d4d4d4; width:770px;  line-height:45px;">
			    <font id="fgg8" style="color:#f00" >*</font><b>
<%if(Tools.parseInt(stdid)==218||Tools.parseInt(stdid)==238){  
    out.print("尺寸：");
}else if(Tools.parseInt(stdid)==235){  
    out.print("长度：");
 }else{ 
 	 out.print("成分：");
 } %>
</b><input type="text" id="req_stdvalue8"  style=" line-height:25px;width:200px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%= p.getGdsmst_stdvalue8() %>">&nbsp;&nbsp;
		       </div>
				
			<%}
		  
		  if(sta.getStdmst_atrdtl9().length()>0)
		  {%>
		  <div id="req_div9" style="border-bottom:dashed 1px #d4d4d4;width:770px;  line-height:45px;">
			  <input type="hidden" id="req_stdchar9" name="req_stdchar9" value="9">
			  <font id="fgg9" style="color:#f00" >*</font><b><%= sta.getStdmst_atrname9() %>：</b>
		  <%
		  String gstr9=p.getGdsmst_stdvalue9();
		      String[] req9=sta.getStdmst_atrdtl9().split(";");
		      for(String str:req9)
		      {
		    	  if(str.length()>0)
		    	  {%>
		    		  <input type="checkbox" name="req_stdvalue9" value="<%= str%>" <% if(gstr9.indexOf(str)>=0){ %>checked="true"<%} %>><%=str%>&nbsp;
		    	  <%}
		    	  
		      }%>
		      </div>
		  <%}
		  
		  if(sta.getStdmst_atrdtl10().length()>0)
		  {%>
		  <div id="req_div10" style="border-bottom:dashed 1px #d4d4d4;width:770px;  line-height:45px;">
			  <input type="hidden" id="req_stdchar10" name="req_stdchar10" value="10">
			  <font id="fgg10" style="color:#f00" >*</font><b><%= sta.getStdmst_atrname10() %>：</b>
		  <%
		  String gstr10=p.getGdsmst_stdvalue10();
		      String[] req10=sta.getStdmst_atrdtl10().split(";");
		      for(String str:req10)
		      {
		    	  if(str.length()>0)
		    	  {%>
		    		  <input type="checkbox" name="req_stdvalue10" value="<%= str%>" <% if(gstr10.indexOf(str)>=0){ %>checked="true"<%} %>><%=str%>&nbsp;
		    	  <%}
		    	  
		      }%>
		      </div>
		  <%}
		  
		  if(sta.getStdmst_atrdtl11().length()>0)
		  {%>
		  <div id="req_div11" style="border-bottom:dashed 1px #d4d4d4;width:770px;  line-height:45px;">
			  <input type="hidden" id="req_stdchar11" name="req_stdchar11" value="11">
			  <font id="fgg11" style="color:#f00" >*</font><b><%= sta.getStdmst_atrname11() %>：</b>
		  <%
		  String gstr11=p.getGdsmst_stdvalue11();
		      String[] req11=sta.getStdmst_atrdtl11().split(";");
		      for(String str:req11)
		      {
		    	  if(str.length()>0)
		    	  {%>
		    		  <input type="checkbox" name="req_stdvalue11" value="<%= str%>" <% if(gstr11.indexOf(str)>=0){ %>checked="true"<%} %>><%=str%>&nbsp;
		    	  <%}
		    	  
		      }%>
		      </div>
		  <%}
		  
		  if(sta.getStdmst_atrdtl12().length()>0)
		  {%>
		  <div id="req_div12" style="border-bottom:dashed 1px #d4d4d4;width:770px;  line-height:45px;">
			  <input type="hidden" id="req_stdchar12" name="req_stdchar12" value="12">
			  <font id="fgg12" style="color:#f00" >*</font><b><%= sta.getStdmst_atrname12() %>：</b>
		  <%
		  String gstr12=p.getGdsmst_stdvalue12();
		      String[] req12=sta.getStdmst_atrdtl12().split(";");
		      for(String str:req12)
		      {
		    	  if(str.length()>0)
		    	  {%>
		    		  <input type="checkbox" name="req_stdvalue12" value="<%= str%>" <% if(gstr12.indexOf(str)>=0){ %>checked="true"<%} %>><%=str%>&nbsp;
		    	  <%}
		    	  
		      }%>
		      </div>
		  <%}
		  %> 
		
		
		<%}
		
	}
		%>
		