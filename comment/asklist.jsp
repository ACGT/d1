<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/comment.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script language="javascript" type="text/javascript">
        function SerchType(obj) {       //判断用户点击了搜索框
            if (obj.value == "请输入查询关键字") {
                obj.value ="";
                obj.style.color = "black";    //设置字体颜色成黑色
            }
        }
        function returnvalue(obj)   //判断如果用户没有输入关键词，则框内恢复原状态
        {
            if (obj.value =="") {
                obj.value = "请输入查询关键字";     //输入框恢复原值
                obj.style.color = "Gray";   //还原输入框中的字体颜色为灰色
            }
        }
        function getkey(key){
        	$("#key").val(key);
        }
       
    </script>
</head>
<body>
<center>

 

<%

 if(!Tools.isNull(request.getParameter("goodsid"))){
	 String productId=request.getParameter("goodsid");
	 String key="请输入查询关键字";
	 if(!Tools.isNull(request.getParameter("key"))){
			key=request.getParameter("key");
		 }
	%>
	
<div style="padding-top:15px;">
	 <form name=formpage method=post action="asklist.jsp?goodsid=<%=productId%>">
         <div style="font-size:12px; background-color:#FAEAED; height: 80px; float:left; width:100%">
 <div style="float:left; padding-left:10px; padding-top:10px"> <span style="font-weight:bold;">咨询前请搜索，方便又快捷：</span><br />
    <input type="text" id="txtKey"  value="<%=key %>" style="color:Gray" onkeyup="getkey(this.value);" onfocus="SerchType(this)" onblur="returnvalue(this)"/>
    <input type="submit" value="搜索"/>
 </div>
 <div style="float:right; margin:5px; border:1px  solid lightgray; background-color:White">
     <div style="padding:5px">
      <span style="font-weight:bold;">温馨提示：</span>
     <span  style=" line-height:20px">因厂家更改商品包装、产地或者更换随机附件等没有任何提前通知，<br />且每位咨询者购买情况、提问时间等不同，为此以下回复仅对提问者3天内有效，<br />其他网友仅供参考！若由此给您带来不便请多多谅解，谢谢！</span>
     </div>
 
 </div>
</div>
          <input type=hidden name=pageno id="pageno"/>
          <input type=hidden name=key id="key"/>
        </form>
	<% 
	 int currentPageIndex=1;
	 int pagesize=5;
	 int totalcount=0;
	
	 if(!Tools.isNull(request.getParameter("pageno"))){
		// out.print("<script>alert('"+request.getParameter("pageno")+"')</script>");
			currentPageIndex=Integer.valueOf(request.getParameter("pageno")).intValue();
		}
	 
	 List<GoodsAsk> asklist=GoodsAskHelper.getlistByProductId(productId, 0, 5000);
	if(!Tools.isNull(request.getParameter("key"))){
		// out.print("<script>alert('"+request.getParameter("key")+"')</script>");
		asklist=GoodsAskHelper.getGoodsAskByKey(productId, request.getParameter("key"));
	 }
	 if(asklist!=null && asklist.size()>0){
		 totalcount=asklist.size();
		 int pagecount=totalcount/pagesize;
		 if(totalcount%pagesize!=0){
			 pagecount=totalcount/pagesize+1;
		 }
		 PageBean pBean = new PageBean(totalcount,pagesize,currentPageIndex);
		 int end = pBean.getStart()+pagesize;
	 	    if(end > totalcount) end = totalcount;
	 	   List<GoodsAsk> asklist2 = asklist.subList(pBean.getStart(),end);
		 int avgscore=CommentHelper.getLevelView(productId);
		 %>
		<table cellpadding="0" cellspacing="0" width="98%" style="font-size:12px">
		<tr><td height="15px">&nbsp;</td></tr>
	 <%
	 for(GoodsAsk ask:asklist2){
		
			String hfusername="";
			if(Tools.isNull(ask.getGdsask_uid())){
				hfusername="游客";
			}else{
				hfusername= CommentHelper.GetCommentUid(ask.getGdsask_uid());
			}
			
			String level ="";
			 if(ask.getGdsask_mbrid()==null || ask.getGdsask_mbrid().intValue()==0){
				 level="游客";
			 }
			 User user = UserHelper.getById(String.valueOf(ask.getGdsask_mbrid()));
				if(user == null) level="游客";
				else{
					level= UserHelper.getLevelText(user);
				}
			
		 %>
		  <tr style="color:Gray" align="right"><td><p>网友：<span><%=hfusername %></span>
        &nbsp; &nbsp; <span><%=level %></span>
        &nbsp; &nbsp; <%=Tools.stockFormatDate(ask.getGdsask_createdate()) %></p></td>
     </tr>
     <tr><td >
        <div style=" float:left; padding-top:5px"> <img src="http://www.d1.com.cn/images/commentimg/ask.jpg"/></div> 
        <div style=" float:left; padding-top:10px; padding-left:5px; padding-bottom:10px;word-wrap:break-word;">
       <span style="word-wrap:break-word;"> 咨询内容：<%=Tools.clearHTML(ask.getGdsask_content()) %></span>
        </div> 
        </td>
     </tr>
     <tr><td>
          <div style=" float:left; padding-top:5px">
            <img src="http://www.d1.com.cn/images/commentimg/replay.jpg" />
          </div>
          <div style=" float:left; padding-top:10px; padding-left:5px; padding-bottom:10px">
            <span style="color:#892D3D">D1回复：</span>
            <span style="word-wrap:break-word;"><%=ask.getGdsask_replyContent() %></span>
          </div>
          </td>
     </tr><%
	} %>
	</table>
	
	  <div class="Pager">  
            共&nbsp;<b class="eng"><font color="#FF0000"><%=totalcount%></font></b>&nbsp;条记录 &nbsp;&nbsp;共 <b class="eng"><font color="#FF0000"><%=pagecount%></font></b> 页,当前第 <b class="eng"><font color="#FF0000"><%=currentPageIndex%></font></b> 页&nbsp;&nbsp;&nbsp;&nbsp;
              <%if (currentPageIndex!=0) {%>
                  <a class="curr" href="javascript:gopage(1)" >1</a> 
                  <%}
              if (pagecount>1 ){
            	  int count=4;
            	  if( pagecount<=5){
            		  count= pagecount-1;
            	  }
              for(int i=2;i<count+2;i++){
            	  if(i==currentPageIndex){ %>  
            		   
                       <a class="curr" href="javascript:gopage(<%=i%>)" ><%=i %></a> 
                      
            	 <%  }else{
            	  %>  
            	  
              	<a href="javascript:gopage(<%=i%>)" ><%=i %></a> 
             	
              <%  }
              }
              
		  }
          if (currentPageIndex<pagecount ){
		%>
		
              <a href="javascript:gopage(<%=currentPageIndex+1%>)">下一页</a>
             
              <%}
		  if (currentPageIndex!=pagecount){
		%> 
              <a href="javascript:gopage(<%=pagecount%>)">末页</a>
            
              <%}%>
                <input name="gotonum" type="text" id="gotonum" value="<%=currentPageIndex%>" style="border:1px solid #CCC;width:25px; height:20px;text-align:center;"/>
                   <input type="button"  class="btngo" name="gobtn" value="Go" onclick="javascript:gotopage(document.getElementById('gotonum').value);"/>
          </div>  
</div>
<script language="javascript">
			  var gotonum;
			  gotonum=<%=pagecount%>;
			  function gotopage(args) {
				if(isNumber(args) && args>gotonum) gopage(gotonum); //输入数字大于最大页数
				if(isNumber(args) && args<=gotonum && args>0) gopage(args); //输入正确范围
				if(isNumber(args) && args<1) gopage(1); //输入数字小于0
			  }
function gopage(i)
{
	 if(window.document.formpage==undefined)
	  {
	    $.alert("没有设置pageListForm，无法提交");
	    return;
	  }
  $("#pageno").val(i);
 document.formpage.submit();
}
//判断是否为数字
function jumpTo() {
  var topage = document.getElementById("gotonum").value;
  if(topage)
	  var pattern=/^[0-9]+$/; 
  var result=pattern.exec(topage);
	if(result==null){
		$.alert("页码只能是数字");
		return;
	}else if(topage == 0){
		$.alert("页码必须大于0");
		return;
	}else{
		gopage(topage);
	}
}
</script>
	<% }else{ %>
		<div style="background-color:#F4F4F4;">
			 <span style="font-size:12px">暂时还没有顾客咨询 </span>                   		
		</div>
	 <%}%>
	 <div align="left">
 <div style=" background-color:#F4F4F4; padding-bottom:10px; padding-top:10px;">
 <div style="font-size:13px; font-weight:bold; padding-left:20px;">
  发表咨询
 </div>
 
</div>
<div style="font-size:12px; padding-top:15px; padding-left:20px;">
 <span>声明：您可在购买前对产品包装、颜色、运输、库存等方面进行咨询，我们有专人进行回复！因厂家随时会更改一些产品的包装、颜色、<br />
 产地等参数，所以该回复仅在当时对提问者有效，其他网友仅供参考！咨询回复的工作时间为：周一至周五：9:00至18:00，请耐心等待<br />
 工作人员的回复。 </span><p>
 <b> 咨询类型：</b><input id="Radio1" name="asktype" type="radio" checked="checked"  value="1"/>商品咨询<input id="Radio2" name="asktype" type="radio"  value="2"/>库存及配送
 <input id="Radio3" name="asktype" type="radio"  value="3"/>支付问题 <input id="Radio4" name="asktype" type="radio"  value="4"/>发票及保修  <input id="Radio5" name="asktype" type="radio"  value="5"/>促销及赠品
 </p>
<b>咨询内容：</b><p>
<textarea  id="txtcontent" name="txtcontent"></textarea>
    </p>
<a href="javascript:void(0)" onclick="AddAsk()"><img src="http://www.d1.com.cn/images/commentimg/gdsAsk_btnOK.png" /></a>
</div>
</div>
 <%}
%>


   </center> 
</body>
</html>