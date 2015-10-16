<%@ page contentType="text/html; charset=UTF-8" %><%@include file="/html/header.jsp" %><%!
//得到在此段时间内抽奖的物品
private ArrayList<LotCon> getLotCon(String gdsid){
	ArrayList<LotCon> list=new ArrayList<LotCon>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("lotcon_flag", new Long(0)));
	clist.add(Restrictions.eq("lotcon_gdsid", gdsid));
	clist.add(Restrictions.lt("lotcon_starttime", new Date()));
	clist.add(Restrictions.gt("lotcon_endtime", new Date()));
	List<BaseEntity> mxlist= Tools.getManager(LotCon.class).getList(clist, null, 0, 1);
	if(mxlist==null || mxlist.size()==0) return null;
	for(BaseEntity be:mxlist){
		list.add((LotCon)be);
	}
	return list;
}
//判断用户在活动期间是否参加过抽奖活动
boolean getCjInfo(String mbrid,String gdsid){
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("wycjinfo_mbrid", mbrid));
	//clist.add(Restrictions.eq("wycjinfo_gdsid", gdsid));
	List<BaseEntity> mxlist= Tools.getManager(Wyhfcj.class).getList(clist, null, 0, 1);
	if(mxlist==null || mxlist.size()==0) return false;
	
	return true;
}
//判断当天是否有抽中实物奖品
int isgetprize(String gdsid){
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("wycjinfo_gdsid", gdsid));
	clist.add(Restrictions.eq("wycjinfo_flag", new Long(1)));
	SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd");
    String stime=df3.format(new Date())+" 00:00:00";
    String etime =df3.format(new Date())+" 23:59:59";
    try {
   	 Date starttime=df2.parse(stime); 
	     Date endtime=df2.parse(etime);
	     clist.add(Restrictions.ge("wycjinfo_date", starttime));
	     clist.add(Restrictions.le("wycjinfo_date", endtime));

    } catch (ParseException e) {
   	   e.printStackTrace();
    }
	return Tools.getManager(Wyhfcj.class).getLength(clist);
}
//生成券
boolean getTkt(String cardno,String gdsid,String title,String memo,String mbrid,Long flag){
	int mid=4;
	if(flag==1){
		mid=8;
	}
	SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	try{
	Tuandh t=new Tuandh();
	t.setTuandh_cardno(cardno);
	t.setTuandh_createtime(new Date());
	t.setTuandh_endtime(df.parse("2012-12-31 23:59:59"));
	t.setTuandh_gdsid(gdsid);
	t.setTuandh_memo(memo);
	t.setTuandh_title(title);
	t.setTuandh_status(new Long(1));
	t.setTuandh_yztime(new Date());
	t.setTuandh_mbrid(new Long(mbrid));
	t.setTuandh_mid(new Long(mid));
	
		t=(Tuandh)Tools.getManager(Tuandh.class).create(t);
		//中奖信息表添加数据
		Wyhfcj w=new Wyhfcj();
		w.setWycjinfo_cardno(cardno);
		w.setWycjinfo_date(new Date());
		w.setWycjinfo_flag(flag);
		w.setWycjinfo_gdsid(gdsid);
		w.setWycjinfo_mbrid(mbrid);
		Tools.getManager(Wyhfcj.class).create(w);
		if(!Tools.isNull(t.getId())){
			return true;
		}
		}catch(Exception e){
			
		}
	return false;
}
 String getcard(int length) {	
	char[] ss = new char[length];		
	int[] flag = {0,0,0}; //A-Z, a-z, 0-9	
	int i=0;		
	while(flag[0]==0 || flag[1]==0 || flag[2]==0 || i<length) {	
		i = i%length;		  
		int f = (int) (Math.random()*3%3);		
		if(f==0) ss[i] = (char) ('A'+Math.random()*26);	
		else if(f==1) ss[i] = (char) ('a'+Math.random()*26);	
		else ss[i] = (char) ('0'+Math.random()*10);    	
		flag[f]=1;		 
		i++;		
		}	
	return new String(ss);	
	}
 
 void sendmail(String cardno,String email){
	 String  msg="<center><table id=\"__01\" width=\"750\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"text-align:left;\">";
	 msg+="<tr><td colspan=\"3\"><img src=\"http://images.d1.com.cn/zt2012/20121213wycj750/wyyj750_01.jpg\"  name=\"wyyj750_01\" width=\"750\" height=\"77\" border=\"0\" usemap=\"#wyyj750_01Map\" id=\"wyyj750_01\" /></td></tr>";
	 msg+="<tr><td align=\"center\"><table  width=\"650\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td  style=\"word-break:break-all;word-wrap:break-word;line-height:26px;\"><p style=\"margin:0;padding-top:10px;font-weight:bold;font-size:14px\">";  
	 msg+="<p style=\"margin:0;padding:0;font-size:14px;text-indent:2em;padding:10px 0\">尊敬的"+email+"</p>您好，感谢您参与<a href=\"http://www.d1.com.cn/\" target=\"_blank\" style=\"color:#074977;font-weight:bold;text-decoration:underline\">D1优尚网</a>0元（包邮）赢取市场价999元“泰国进口3朵永不凋谢真玫瑰花——我爱你”、0元（包邮）赢取市场价458元“【FEEL MIND】经典商务休闲真皮钱包+腰带2件套”的抽奖活动（二者任选一项参与）。很遗憾，您没有中奖，为感谢您支持,D1优尚网特送上此次活动特惠商品<b>兑换码</b>1张。</p>";

	 msg+="  <p style=\"margin:0;padding:0;font-weight:bold;font-size:14px;padding-top:30px\">凭以下<strong style=\"color:#FF6600;margin:0 5px\">兑换码</strong>去D1优尚网，即可以享受众多特惠商品！</p>";
	 msg+="   <div style=\"border:#E1E1BF 1px solid;background-color:#FFFFE1;text-align:center;padding:10px 0;font-weight:bold;font-size:14px;margin:10px 0\">"+cardno+"</div>";
	 msg+="<div style=\"padding-top:15px; font-weight:bold; text-align:center; color:#FF0000;\"><a href=\"http://www.d1.com.cn/html/zt2012/20121212wycj/dhindex.jsp\" target=\"_blank\" style=\"color:#CC0000;\">立即兑换>></a></div>";
	 msg+=" <p style=\"margin:0;padding:0;font-size:12px;padding-top:30px;color:#7D7D7D;white-space:normal;word-wrap:break-word;word-break:break-all;\">优惠券使用规则：<br/>一、有效期<br/>兑换码有效期截止至：2012年12月31日，逾期作废。<br/>二、如何使用 <br/>1、该兑换码仅能购买此次特惠活动商品，其他商品不能使用。 <br/><a href=\"http://www.d1.com.cn/html/zt2012/20121212wycj/dhindex.jsp\" target=\"_blank\">进入换购专区，请点击>></a><br/>三、注意事项<br/>1、该兑换码仅能购买此次活动特惠商品，其他商品不能使用。 <br/>2、兑换码有效截止日期为2012年12月31日，逾期不予兑换。<br/>3、该活动商品可以和D1优尚网其他商品一起下单订购。<br/>4、含有此活动商品的订单支付方式为<b>在线付款</b>。</p>";
	 msg+=" <p style=\"margin:0;padding:0;font-size:14px;padding-top:30px\">更多优惠活动，请登录<a href=\"http://www.d1.com.cn/\" target=\"_blank\" >D1优尚网</a><br/>D1优尚网全国统一客服电话：400-680-8666（9:00-21:00）。<br/>再次感谢您的参与和支持，您的支持是我们前进的动力！</p>";
	 msg+="<p style=\"font-size:12px;text-align:right;color:#999\">（注：此信为系统通知邮件，请勿直接回复）</p></td><td width=\"40\">&nbsp;</td></tr><tr><td height=\"20\" colspan=\"3\">&nbsp;</td></tr></td></tr></table></td></tr></table>";
	 msg+="<map name=\"wyyj750_01Map\"><area shape=\"rect\" coords=\"7,5,172,73\" href=\"http://www.d1.com.cn/buy/lianmeng.asp?id=d1_1111&amp;subad=wangyicj1217&amp;url=http://www.d1.com.cn/\" target=\"_blank\"><area shape=\"rect\" coords=\"176,10,321,70\" href=\"http://mail.163.com/ \" target=\"_blank\"><area shape=\"rect\" coords=\"325,12,477,69\" href=\"http://www.126.com/\" target=\"_blank\"><area shape=\"rect\" coords=\"480,14,636,66\" href=\"http://www.yeah.net/\" target=\"_blank\"></map>";
	 msg+="</center>";
	 String mailSubject = "恭喜您获得D1优尚特惠商品码一张";
		String mailFromemail = "service@d1.com.cn";
		Email pwEmail = new Email();
		pwEmail.setBody(msg);
		pwEmail.setOdrid("");
		pwEmail.setIfsend(new Long(0));
		pwEmail.setCreatetime(new Date());
		pwEmail.setSendname("");
		pwEmail.setFromemail(mailFromemail);
		pwEmail.setSendemail(email);
		pwEmail.setSubject(mailSubject);

		Tools.getManager(Email.class).create(pwEmail); 
	 
 }
 void sendmail2(String cardno,String email,String msg){
	 String  mailbody="<center><table id=\"__01\" width=\"750\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"text-align:left;\">";
	 mailbody+="<tr><td colspan=\"3\"><img src=\"http://images.d1.com.cn/zt2012/20121213wycj750/wyyj750_01.jpg\"  name=\"wyyj750_01\" width=\"750\" height=\"77\" border=\"0\" usemap=\"#wyyj750_01Map\" id=\"wyyj750_01\" /></td></tr>";
	 mailbody+="<tr><td align=\"center\"><table  width=\"650\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td  style=\"word-break:break-all;word-wrap:break-word;line-height:26px;\"><p style=\"margin:0;padding-top:10px;font-weight:bold;font-size:14px\">";  
	 mailbody+="<p style=\"margin:0;padding:0;font-size:14px;text-indent:2em;padding:10px 0\">尊敬的"+email+"</p>您好，恭喜您抽中"+msg+"一件。感谢您的参与！</p>";

	 mailbody+="  <p style=\"margin:0;padding:0;font-weight:bold;font-size:14px;padding-top:30px\">凭以下<strong style=\"color:#FF6600;margin:0 5px\">兑换码</strong>去D1优尚网，即可领取中奖礼品！</p>";
	 mailbody+="   <div style=\"border:#E1E1BF 1px solid;background-color:#FFFFE1;text-align:center;padding:10px 0;font-weight:bold;font-size:14px;margin:10px 0\">"+cardno+"</div>";
	 mailbody+="<div style=\"padding-top:15px; font-weight:bold; text-align:center; color:#FF0000;\"><a href=\"http://www.d1.com.cn/market/1201/wangyi/\" target=\"_blank\" style=\"color:#CC0000;\">立即领取>></a></div>";
	 mailbody+="  <p style=\"margin:0;padding:0;font-size:12px;padding-top:30px;color:#7D7D7D;white-space:normal;word-wrap:break-word;word-break:break-all;\">注意事项：<br/>1、仅赢取该商品不需要支付任何费用。<br/>2、	其他商品可以和该赢取商品一起订购，同享包邮礼遇<br/>3、	赢取码有效期截止至：2012年12月31日，逾期作废。</p>";
	 mailbody+=" <p style=\"margin:0;padding:0;font-size:14px;padding-top:30px\">更多优惠活动，请登录<a href=\"http://www.d1.com.cn/\" target=\"_blank\" >D1优尚网</a><br/>D1优尚网全国统一客服电话：400-680-8666（9:00-21:00）。<br/>再次感谢您的参与和支持，您的支持是我们前进的动力！</p>";
	 mailbody+="<p style=\"font-size:12px;text-align:right;color:#999\">（注：此信为系统通知邮件，请勿直接回复）</p></td><td width=\"40\">&nbsp;</td></tr><tr><td height=\"20\" colspan=\"3\">&nbsp;</td></tr></td></tr></table></td></tr></table>";
	 mailbody+="<map name=\"wyyj750_01Map\"><area shape=\"rect\" coords=\"7,5,172,73\" href=\"http://www.d1.com.cn/buy/lianmeng.asp?id=d1_1111&amp;subad=wangyicj1217&amp;url=http://www.d1.com.cn/\" target=\"_blank\"><area shape=\"rect\" coords=\"176,10,321,70\" href=\"http://mail.163.com/ \" target=\"_blank\"><area shape=\"rect\" coords=\"325,12,477,69\" href=\"http://www.126.com/\" target=\"_blank\"><area shape=\"rect\" coords=\"480,14,636,66\" href=\"http://www.yeah.net/\" target=\"_blank\"></map>";
	 mailbody+="</center>";
		String mailSubject = "网易会员中奖信息";
		String mailFromemail = "service@d1.com.cn";
		Email pwEmail = new Email();
		pwEmail.setBody(mailbody);
		pwEmail.setOdrid("");
		pwEmail.setIfsend(new Long(0));
		pwEmail.setCreatetime(new Date());
		pwEmail.setSendname("");
		pwEmail.setFromemail(mailFromemail);
		pwEmail.setSendemail(email);
		pwEmail.setSubject(mailSubject);

		Tools.getManager(Email.class).create(pwEmail); 
 }
%>
<%
SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
String end="2012-12-31 23:59:59";
if(new Date().after(df.parse(end))){
	out.print("{\"code\":1,message:\"该活动已结束！\"}");
	return;
}
String gdsidlist="01511168,03300077";
String productid = request.getParameter("id");
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.close();Login_Dialog();<%
	return;
}
if(Tools.isNull(productid)){
	out.print("{\"code\":1,message:\"参数不正确！\"}");
	return;
}
if(gdsidlist.indexOf(productid)<0){
	out.print("{\"code\":1,message:\"参数不正确！\"}");
	return;
}
//一个用户只能参加一次
if(getCjInfo(lUser.getId(),productid)){
	out.print("{\"code\":1,message:\"您已参加过该活动！\"}");
	return;
}
//判断当天是否有抽中实物奖品
int prizecount=isgetprize(productid);
String cardno="";String title="";String memo="";
if(("01511168".equals(productid) && prizecount>=1) || ("03300077".equals(productid) && prizecount>=3)){//玫瑰每天抽中1次,腰带每天3次.已经被抽中
	title="网易兑换";memo="03100006,02001025,02001026,02001027,03000317,01720110";
	cardno="mqwydh1212d"+getcard(11);
	getTkt(cardno, "", title, memo, lUser.getId(), new Long(0));
	//String msg="很遗憾，您没有中奖，送您特惠商品兑换码"+cardno+"一张。可超值兑换<a href=\"\" target=\"_blank\">更多礼品》》</a>";
	sendmail(cardno,lUser.getMbrmst_email());
	out.print("{\"code\":0,message:\""+cardno+"\"}");
	return;
	
}else{
	ArrayList<LotCon> list=getLotCon(productid);//在能抽中的时间范围内
	title="网易抽奖";memo="网易抽奖";
	System.out.println("d1gjlwycj:"+productid);
	if(list!=null && list.size()>0){
		System.out.println("d1gjlwycj2:"+productid);
		String msg="";
		LotCon lotcon=list.get(0);
		if("01511168".equals(productid) ){
			cardno="mqwycj1212drose"+getcard(10);
			getTkt(cardno, productid, title, memo, lUser.getId(), new Long(1));
			 lotcon.setLotcon_flag(new Long(1));
			 Tools.getManager(LotCon.class).update(lotcon, false);
			  msg="市场价999元“泰国进口3朵永不凋谢真玫瑰花——我爱你”";
			out.print("{\"code\":2,message:\""+cardno+"\"}");
				
		}else if("03300077".equals(productid)){
			cardno="mqwycj1212dydzh"+getcard(10);
			getTkt(cardno, productid, title, memo, lUser.getId(), new Long(1));
			//if(prizecount==2){
				lotcon.setLotcon_flag(new Long(1));
				 Tools.getManager(LotCon.class).update(lotcon, false);
			//}
			 msg="市场价458元“【FEEL MIND】经典商务休闲真皮钱包+腰带2件套”";
				out.print("{\"code\":3,message:\""+cardno+"\"}");
		}
		//抽中给用户发邮件
		sendmail2(cardno,lUser.getMbrmst_email(),msg);
	}else{
		title="网易兑换";memo="03100006,02001025,02001026,02001027,03000317,01720110";
		cardno="mqwydh1212d"+getcard(11);
		getTkt(cardno, "", title, memo, lUser.getId(), new Long(0));
		//String msg="很遗憾，您没有中奖，送您特惠商品兑换码"+cardno+"一张。可超值兑换<a href=\"\" target=\"_blank\">更多礼品》》</a>";
		sendmail(cardno,lUser.getMbrmst_email());
		out.print("{\"code\":0,message:\""+cardno+"\"}");
		return;
	}
	
}


%>