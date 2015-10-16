<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.bean.*,com.d1.helper.*,java.util.Date,net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.bean.id.SequenceIdGenerator,org.hibernate.criterion.Restrictions,org.hibernate.criterion.SimpleExpression,org.hibernate.criterion.Order"%><%@include
	file="/inc/header.jsp"%><%
	//WeixinShopUser u = new WeixinShopUser();
	/*
	u.setOpen_id("abcdef");
	u.setOriginal_id("ghikj111");
	u.setD1_id(1234);
	u = (WeixinShopUser)WeixinShopUserHelper.manager.create(u);
	u.setOpen_id("abcdef");
	u.setOriginal_id("ghikj111333");
	u.setD1_id(1234);
	u = (WeixinShopUser)WeixinShopUserHelper.manager.create(u);
	*/
	/*
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("open_id","abcdef"));
	clist.add(Restrictions.eq("d1_id",1234));
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.asc("open_id"));
	List<BaseEntity> blist=Tools.getManager(WeixinShopUser.class).getListWithoutCache(clist, olist, 0, 10);
	u = (WeixinShopUser)blist.get(0);
	*/
	WeixinShopToken weixinShopToken = (WeixinShopToken)WeixinShopTokenHelper.CreateToken("aaa", "bbb");
	%>
	<%//=(new Date()).getTime() %>
	<%//u.getOpen_id()%>