<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
       
<%
int iAwardValue1=0;
int iAwardValue2=500;
String JiFengTitle="";
if(request.getAttribute("AwardValue1")!=null && request.getAttribute("AwardValue2")!=null && request.getAttribute("JiFengTitle")!=null ){
	iAwardValue1=(Integer.valueOf(request.getAttribute("AwardValue1").toString())).intValue();
	iAwardValue2=(Integer.valueOf(request.getAttribute("AwardValue2").toString())).intValue();
	JiFengTitle= request.getAttribute("JiFengTitle").toString();
	ArrayList<Award> list=AwardHelper. getAwardInfoByScore(iAwardValue1, iAwardValue2);
	//out.print(list.size());
	if(list!=null){
		
		%>
		 <div class="c3a"><div class="c3b"><%= JiFengTitle %></div></div>
        <div class="c3c">
			<ul>
		<%
		for(Award award1:list){
			String price="0";
			String img=award1.getAward_bigimg();
    		Product p=ProductHelper.getById(award1.getAward_gdsid());
    		if("00000000".equals(award1.getAward_gdsid().toString())){
    			 if(award1.getAward_value().intValue()==200){
    				 price="10";
    			 }else if(award1.getAward_value().intValue()==800){
    				 price="50";
    			 }
    		}else{
    			
    			if(p!=null){
    				if(p.getGdsmst_saleprice()!=null && (!Tools.isNull(p.getGdsmst_saleprice().toString()))){
    					price=ProductGroupHelper.getRoundPrice(p.getGdsmst_saleprice().floatValue());
    				}
    				
    			}
    		}
    		
    		if(p!=null){
    			img="http://images.d1.com.cn"+p.getGdsmst_imgurl();
    		}
    		%>
    		

   
        <li>
            <div class="s1">
                  <%
				      if(!award1.getAward_gdsid().toString().equals("00000000")){
				    %>
				  <a href='/product/<%=award1.getAward_gdsid()%>' target="_blank" title="<%= Tools.clearHTML(award1.getAward_gdsname())%>">
					 <img src='<%=img %>' width="200" height="200" alt="" />
				 </a>
				 <%}else{ %>
				    <img src='<%=img %>' width="200" height="200" alt="" />
				  <%} %>
            </div>
            <div class="s2">
                <%=Tools.substring(award1.getAward_gdsname(), 40) %><br />
                市场价：<%=price%>元<br />
                <span class="jf1">
                  <%=award1.getAward_value().intValue() %>积分
                  <% if(Tools.floatCompare(award1.getAward_price().doubleValue(),0.0)==1){
                	  %>
                	  + <%=award1.getAward_price() %>元
                  <%} %>
				 
                </span>
            </div>
            <div class="s3">
            <%
            	if("00000000".equals(award1.getAward_gdsid())){
            %>
              <img attr="<%=award1.getId() %>" onclick="op(this);" src="http://images.d1.com.cn/images2012/New/jifen/b4.gif" style="cursor:pointer" alt="" />
			<%
            	}else{
            		%>
            	<img attr="<%=award1.getId() %>" onclick="addCart(this);" src="http://images.d1.com.cn/images2012/New/jifen/b4.gif" style="cursor:pointer" alt="" />
            		<%
            	}
			%>
            </div>
        </li>

			

		<%}
	}%>
	</ul>
			<div class="clear"></div>
		</div>
<%}
%>