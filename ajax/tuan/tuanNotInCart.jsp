<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
    private ArrayList<TuanDraw> getAllTuanDraw()
    {
	    ArrayList<TuanDraw> list=new ArrayList<TuanDraw>();
	    List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
        List<BaseEntity> rlist=Tools.getManager(TuanDraw.class).getList(clist, null, 0, 100000);
	    if(rlist!=null&&rlist.size()>0)
	    {
	    	for(BaseEntity be:rlist)
	    	{
	    		if(be!=null)
	    		{
	    			list.add((TuanDraw)be);
	    		}
	    	}
	    }
	    return list;
    }

%>
<%

	if(lUser==null) {
		response.setHeader("_d1-Ajax","2");
		%>Login_Dialog();<%
		return;
	}
		
        ArrayList<TuanDraw> lists=new ArrayList<TuanDraw>();
		lists=getAllTuanDraw();
		if(lists!=null&&lists.size()>0)
		{
			for(TuanDraw td:lists)
			{
				if(td.getUserId().equals(lUser.getId()))
				{
					out.print("对不起，您已经参加过团购，请查看其他团购！");
					return;
				}
				
			}
		}
		TuanDraw tdend=new TuanDraw();
		tdend.setUserId(lUser.getId());
		//获取随机数
		String random="";
		int num = new Random().nextInt(100);
		 if (num <10) {
			  random="0"+String.valueOf(num);
		  }
		 else
		 {
			 random=String.valueOf(num);
		 }
		  

		
		tdend.setCode(new SimpleDateFormat("yyMMddhhmmss").format(new Date())+random);
		tdend.setCreatedate(new Date());
		tdend.setExt1("");
		tdend.setExt2("");
		tdend=(TuanDraw)Tools.getManager(TuanDraw.class).create(tdend);
		if(tdend!=null)
		{
			out.print("恭喜您，您已成功参与0元抽奖活动，您的订单号是<font color='red'>"+tdend.getCode()+"</font>！");
		}
		else
		{
			out.print("对不起，生成订单失败！");
		}

%>