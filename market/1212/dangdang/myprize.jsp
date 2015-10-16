<%@ page contentType="text/html; charset=GBK"%><%@page 
import="com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*"%><%!

private ArrayList<LotCon> getLotCon(){
	ArrayList<LotCon> list=new ArrayList<LotCon>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("lotcon_flag", new Long(0)));
	clist.add(Restrictions.lt("lotcon_starttime", new Date()));
	clist.add(Restrictions.gt("lotcon_endtime", new Date()));
	List<BaseEntity> mxlist= Tools.getManager(LotCon.class).getList(clist, null, 0, 1);
	if(mxlist==null || mxlist.size()==0) return null;
	for(BaseEntity be:mxlist){
		list.add((LotCon)be);
	}
	return list;
}

private boolean getLotAct(String mbrid){
	ArrayList<LotAct> list=new ArrayList<LotAct>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("lot8zn_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("lot8zn_status", new Long(2)));
	List<BaseEntity> mxlist= Tools.getManager(LotAct.class).getList(clist, null, 0, 1);
	if(mxlist==null || mxlist.size()==0) return false;
	for(BaseEntity be:mxlist){
		list.add((LotAct)be);
	}
	LotAct lotact=list.get(0);
	lotact.setLot8zn_status(new Long(1));
	Tools.getManager(LotAct.class).update(lotact, false);
	return true;
}
/** 
* ������� 
* @param d ������ 
* @param day ��ӵ����� 
* @return ��Ӻ������ 
* @throws ParseException 
*/ 
public static Date addDate(Date d,long day) throws ParseException { 

long time = d.getTime(); 
day = day*24*60*60*1000; 
time+=day; 
return new Date(time); 

} 
private static boolean addcard(String gdsid,float ftuanprice,HttpServletRequest request,HttpServletResponse response){
	Product product = ProductHelper.getById(gdsid);
	if(product == null){
		return false;
	}
	//��Ʒ�Ƿ��ڼ���
	if(Tools.longValue(product.getGdsmst_validflag()) != 1&&Tools.longValue(product.getGdsmst_validflag()) != 4){
		return false;
	}
	Cart cart = new Cart();
	cart.setAmount(new Long(1));
	cart.setCookie(CartHelper.getCartCookieValue(request, response));
	cart.setCreateDate(new Date());
	cart.setHasChild(new Long(0));
	cart.setHasFather(new Long(0));
	cart.setIp(request.getRemoteHost());
	cart.setMoney(Tools.getFloat(new Float(ftuanprice),2));
	cart.setOldPrice(Tools.getFloat(new Float(ftuanprice),2));
	cart.setPoint(new Long(0));
	cart.setPrice(Tools.getFloat(new Float(ftuanprice),2));
	cart.setSkuId("");//?
	cart.setTuanCode("");//ע��parentIdֵ
	cart.setProductId(gdsid);
	cart.setType(new Long(15));
	cart.setUserId(CartHelper.getCartUserId(request, response));
	cart.setVipPrice(Tools.getFloat(new Float(ftuanprice),2));
	cart.setTitle("��������齱��"+Tools.clearHTML(product.getGdsmst_gdsname()));
	
	Tools.getManager(Cart.class).create(cart);
	return true;
}

private static int addtkt(int tkttype,String mbrid,String mbruid,int flag,HttpServletRequest request,HttpServletResponse response){
	long cardvalue=0;
	long gdsvalue=0;
	int ret=0;
	String memotxt="";
	String winname="";
	String gdsid="";
	float gdsprice=0;
	/*
1-----100Ԫ��15����ȯ		�һ��۸�	20%                        801-1000
2-----��ʥ����ѡ���������á���ɫ�������������װ������õ�壩  20%     601-800
3-----20-20�Ż�ȯ  10%                                           501-600
4-----��YOUSOO���¿�è��ʯʱ��ˮ�δ�����׹     20%                   301-500
5-----5Ԫ�Ż�ȯ          5%                                            251-300
6-----��FEEL MIND����ʿ����ѹ���Ƹ߼�ţƤ�࿨λǮ��Ƥ�У���ɫ��           51-250
7 200Ԫȯ
8   ̨��                                                                                                                                                         1-50


5Ԫ�Ż�ȯ			5%
20-20�Ż�ȯ			10%
100Ԫ��15����ȯ		�һ��۸�	20%
200Ԫֱ��ȯ			0%
��FEEL MIND����ʿ����ѹ���Ƹ߼�ţƤ�࿨λǮ��Ƥ�У���ɫ�� 	http://www.d1.com.cn/product/03300070	ֱ��60 39Ԫ	20%
 ̨��	http://www.d1.com.cn/product/01205279	���	5%
��YOUSOO���¿�è��ʯʱ��ˮ�δ�����׹	http://www.d1.com.cn/product/01516804	ֱ��50 49Ԫ	20%
��ʥ����ѡ���������á���ɫ�������������װ������õ�壩 	http://www.d1.com.cn/product/01517474	ֱ��60 39Ԫ	20%

							

*/
System.out.println("d1gjl-------"+tkttype);
	 switch (tkttype)
	    {
	        case 1:
	        	cardvalue=100;
	        	gdsvalue=100;
	        	memotxt="100Ԫ�Ż�ȯ";
	        	winname="��ϲ�����100Ԫ�����Ż�ȯ��ȫ����װ��Ʒ��Ʒ��15�����⣬30������Ч,������ҵ��ʻ��в�ѯ!";
                break;
	        case 2:
	        	gdsid="01517474";
	        	gdsprice=39;
	        	memotxt="��ɫ����������õ��)60Ԫ����ȯ";
	        	winname="��ϲ��������ԭ��99Ԫ��С���᳤������60Ԫ����ȯ����Ʒ�Ѽ������Ĺ��ﳵ������39Ԫ!";
	            break;
	        case 3:
	        	cardvalue=20;
	        	gdsvalue=20;
	        	memotxt="20Ԫ�Ż�ȯ";
	        	winname="��ϲ�����20Ԫ�Ż�ȯ��ȫ��ͨ�ã�30������Ч!";
                break;
	        case 4:
	        	gdsid="01516804";
	        	gdsprice=49;
	        	memotxt="è��ʯˮ�ε�׹50Ԫ����ȯ";
	        	winname="��ϲ��������ԭ��99Ԫ��è��ʯˮ�ε�׹50Ԫ����ȯ������Ʒ�Ѽ������Ĺ��ﳵ�����ﳵֱ�Ӽ��⣬����49Ԫ��";
	            break;
	        case 5:
	        	cardvalue=5;
	        	gdsvalue=5;
	        	memotxt="5Ԫ�Ż�ȯ";
	        	winname="��ϲ�����5Ԫ�Ż�ȯ��ȫ��ͨ�ã�30������Ч!";
	            break;
	        case 6:
	        	gdsid="03300070";
	        	gdsprice=39;
	        	memotxt="���Ƹ߼�ţƤǮ��60Ԫ����ȯ";
	        	winname="��ϲ��������ԭ��99Ԫ��FEEL MIND���Ƹ߼�ţƤǮ��60Ԫ����ȯ������Ʒ�Ѽ������Ĺ��ﳵ�����ﳵֱ�Ӽ��⣬����39Ԫ��";
	            break;
	        case 7:
	        	memotxt="200Ԫ��װ�Ż�ȯ";
	        	winname="��ϲ�����200Ԫ��װ�Ż�ȯ��ȫ��ͨ�ã�30������Ч!";
	            break;
	        case 8:
	        	gdsid="01205279";
	        	gdsprice=0;
	        	memotxt="D1���о���̨��";
	        	winname="��ϲ��������D1���о���̨��������Ʒ�Ѽ������Ĺ��ﳵ��";
	            break;
	    }
	
	 Random rndcard = new Random();
	 String cardno="mddcj1212"+mbrid+rndcard.nextInt(20000);
	 PingAnUser pauser=(PingAnUser)Tools.getManager(PingAnUser.class).findByProperty("mbrmstpingan_mbrid", Tools.parseLong(mbrid));
	 if(pauser!=null){
		 cardno="pa"+cardno;
	 }
	 Date startdate=new Date();Date enddate=null;
	 try{
	 enddate=addDate(new Date(),30);
	 }
	 catch(Exception ex){
		 ex.printStackTrace();
	 }
	 if (flag==2){
	 if (tkttype==1){
		 TicketCrd tktcrd=new TicketCrd();
		 tktcrd.setTktcrd_cardno(cardno);
		 tktcrd.setTktcrd_mbrid(Tools.parseLong(mbrid));
		 tktcrd.setTktcrd_value(new Long(gdsvalue));
		 tktcrd.setTktcrd_realvalue(new Long(cardvalue));
		 tktcrd.setTktcrd_discount(new Float(0.15));
		 tktcrd.setTktcrd_type("004001");
		 tktcrd.setTktcrd_rackcode("017");
		 tktcrd.setTktcrd_createdate(new Date());
		 tktcrd.setTktcrd_validflag(new Long(1));
		 tktcrd.setTktcrd_enddate(enddate);
		 tktcrd.setTktcrd_validates(startdate);
		 tktcrd.setTktcrd_validatee(enddate);
		 tktcrd.setTktcrd_memo("������齱��");
		 tktcrd.setTktcrd_payid(new Long(-1));
		 Tools.getManager(TicketCrd.class).create(tktcrd);
	 }
	 else{
		 Ticket tktmst=new Ticket();
		 tktmst.setTktmst_value(new Float(cardvalue));
		 tktmst.setTktmst_type("004001");
		 tktmst.setTktmst_mbrid(Tools.parseLong(mbrid));
		 tktmst.setTktmst_validflag(new Long(0));
		 tktmst.setTktmst_createdate(startdate);
		 tktmst.setTktmst_validates(startdate);
    	 tktmst.setTktmst_validatee(enddate);
		 tktmst.setTktmst_rackcode("000");
         tktmst.setTktmst_gdsvalue(new Float(gdsvalue));
         tktmst.setTktmst_payid(new Long(-1));
         tktmst.setTktmst_cardno(cardno);
         tktmst.setTktmst_ifcrd(new Long(0));
         tktmst.setTktmst_memo("������齱��");
         Tools.getManager(Ticket.class).create(tktmst);
	 }
	 }else{
		 
		 boolean addcardret=false;
		 addcardret=addcard(gdsid,gdsprice,request,response);
		 if(!addcardret){
			    cardvalue=100;
	        	gdsvalue=100;
	        	memotxt="100Ԫ�����Ż�ȯ";
	        	winname="��ϲ�����100Ԫ�����Ż�ȯ��ȫ�����ﰴ��Ʒ����15%���⣬30������Ч!";
	        	TicketCrd tktcrd=new TicketCrd();
	   		 tktcrd.setTktcrd_cardno(cardno);
	   		 tktcrd.setTktcrd_mbrid(Tools.parseLong(mbrid));
	   		 tktcrd.setTktcrd_value(new Long(gdsvalue));
	   		 tktcrd.setTktcrd_realvalue(new Long(cardvalue));
	   		 tktcrd.setTktcrd_discount(new Float(0.15));
	   		 tktcrd.setTktcrd_type("004001");
	   		 tktcrd.setTktcrd_rackcode("017");
	   		 tktcrd.setTktcrd_createdate(new Date());
	   		 tktcrd.setTktcrd_validflag(new Long(1));
	   		 tktcrd.setTktcrd_enddate(enddate);
	   		 tktcrd.setTktcrd_validates(startdate);
	   		 tktcrd.setTktcrd_validatee(enddate);
	   		 tktcrd.setTktcrd_brandname("");
	   		 tktcrd.setTktcrd_memo("������齱��");
	   		 tktcrd.setTktcrd_payid(new Long(-1));
	   		 Tools.getManager(TicketCrd.class).create(tktcrd);
	   		 ret=1;
		 }
	 }
	 LotWinAct lotwinact=new LotWinAct();
	 lotwinact.setLotwin8zn_mbrid(new Long(mbrid));
	 lotwinact.setLotwin8zn_uid(mbruid);
	 lotwinact.setLotwin8zn_winid(new Long(tkttype));
	 lotwinact.setLotwin8zn_memo(memotxt);
	 lotwinact.setLotwin8zn_winname(winname);
	 lotwinact.setLotwin8zn_flag(new Long(0));
	 lotwinact.setLotwin8zn_createtime(new Date());
	 Tools.getManager(LotWinAct.class).create(lotwinact);
	 return ret;
}
%><%
User lUser = UserHelper.getLoginUser(request, response);

SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
Date dStartDate=null;
try{
	 dStartDate =fmt.parse("2013-1-1");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("&roulette=999&rouletteStr=�齱��Ѿ�����");
	return;
}
if(lUser==null) {
	out.print("&roulette=998&rouletteStr=���ȵ�¼��ע�ᣡ");
	return;
}

SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd");
String stime=df3.format(new Date())+" 00:00:00";
String etime =df3.format(new Date())+" 23:59:59";
java.util.Date   starttime=df2.parse(stime); 
java.util.Date   endtime=df2.parse(etime);

String mbrid=lUser.getId();
String mbruid=lUser.getMbrmst_uid();


List<SimpleExpression> clistcount = new ArrayList<SimpleExpression>();
clistcount.add(Restrictions.ge("lotwin8zn_createtime", starttime));
clistcount.add(Restrictions.le("lotwin8zn_createtime", endtime));
clistcount.add(Restrictions.eq("lotwin8zn_mbrid", new Long(lUser.getId())));

int count=Tools.getManager(LotWinAct.class).getLength(clistcount);
if (count>=3){
	out.print("&roulette=999&rouletteStr=һ���û�һ��ֻ�ܳ����Σ���������������");
	return;
}

long rndround=2;
int ret=0;
boolean lotactret=false;
lotactret=getLotAct(lUser.getId());
if(!lotactret){
	out.print("&roulette=999&rouletteStr=����û�г齱���ᣬ��������齱���ȡ�齱����ɣ�");
	return;
}
/*
ArrayList<LotCon> list=getLotCon();
if(list!=null && list.size()>0){
	LotCon lotcon=list.get(0);
	int lotcode=(int)lotcon.getLotcon_winid().longValue();
	long lotcodevalue=0;
	 if(lotcode==7){
		 rndround=312;
		 ret=addtkt(7,mbrid,mbruid,1,request, response);
		   if(ret==1){
			   System.out.println("d1gjl-------typid=7����");
			   out.print("&roulette=42&rouletteStr=��ϲ�����100Ԫ�����Ż�ȯ��ȫ����װ��Ʒ��Ʒ��15�����⣬30������Ч,������ҵ��ʻ��в�ѯ!");
			   return; }
	 }else if(lotcode==8){
		 rndround=270;
		 ret=addtkt(8,mbrid,mbruid,2,request, response);
		 if(ret==1){
			   System.out.println("d1gjl-------typid=8����");
		   out.print("&roulette=42&rouletteStr=��ϲ�����100Ԫ�����Ż�ȯ��ȫ����װ��Ʒ��Ʒ��15�����⣬30������Ч,������ҵ��ʻ��в�ѯ!");
		   return;   }
	 }else{
		   rndround=42;
		   addtkt(1,mbrid,mbruid,2,request, response);
		   out.print("&roulette="+rndround+"&rouletteStr=��ϲ�����100Ԫ�����Ż�ȯ��ȫ����װ��Ʒ��Ʒ��15�����⣬30������Ч,������ҵ��ʻ��в�ѯ!");
		   return;
	 }
	 lotcon.setLotcon_flag(new Long(1));
	 Tools.getManager(LotCon.class).update(lotcon, false);
	 System.out.println("&roulette="+rndround+"&rouletteStr="+lotcon.getLotcon_winname()+"");
	 out.print("&roulette="+rndround+"&rouletteStr="+lotcon.getLotcon_winname()+"");
	 return;
}
else{*/
	Random rnd = new Random();
   long rndvalue=(long)rnd.nextInt(1000);
 
   /*

1-----100Ԫ��15����ȯ		�һ��۸�	20%                        801-1000
2-----��ʥ����ѡ���������á���ɫ�������������װ������õ�壩  20%     601-800
3-----20-20�Ż�ȯ  10%                                           501-600
4-----��YOUSOO���¿�è��ʯʱ��ˮ�δ�����׹     20%                   301-500
5-----5Ԫ�Ż�ȯ          5%                                            251-300
6-----��FEEL MIND����ʿ����ѹ���Ƹ߼�ţƤ�࿨λǮ��Ƥ�У���ɫ��           51-250
7 200Ԫȯ
8   ̨��                                                                                                                                                         1-50
312
270
case 2:
	lotcodevalue=224;
case 3:
	lotcodevalue=180;
	134
case 4:
	lotcodevalue=90;
case 5:
	lotcodevalue=42;
case 6:
	lotcodevalue=2;
    */
   if (rndvalue>800){
	   rndround=2;
	   ret=addtkt(1,mbrid,mbruid,2,request, response);
	   
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ�����100Ԫ�����Ż�ȯ��ȫ����װ��Ʒ��Ʒ��15�����⣬30������Ч,������ҵ��ʻ��в�ѯ!");
	   return;
   }
    else if(rndvalue>600 && rndvalue<=800){
    	rndround=42;
	   ret=addtkt(2,mbrid,mbruid,1,request, response);
	   if(ret==0){
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ��������ԭ��99Ԫ��С���᳤������60Ԫ����ȯ����Ʒ�Ѽ������Ĺ��ﳵ������39Ԫ!");
	   }else{
		   System.out.println("d1gjl-------typid=2����");
		   out.print("&roulette=2&rouletteStr=��ϲ�����100Ԫ�����Ż�ȯ��ȫ����װ��Ʒ��Ʒ��15�����⣬30������Ч,������ҵ��ʻ��в�ѯ!");
		   }
	   return;
   }
   else if(rndvalue>500 && rndvalue<=600){
	   rndround=90;
	   ret=addtkt(3,mbrid,mbruid,2,request, response);
	   if(ret==0){
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ�����20Ԫ�Ż�ȯ��ȫ��ͨ�ã�30������Ч,������ҵ��ʻ��в�ѯ!");
        }else{
        	  System.out.println("d1gjl-------typid=6����");
 		   out.print("&roulette=2&rouletteStr=��ϲ�����100Ԫ�����Ż�ȯ��ȫ����װ��Ʒ��Ʒ��15�����⣬30������Ч,������ҵ��ʻ��в�ѯ!");
	   }return;
   }
   else if(rndvalue>300 && rndvalue<=500){
	   rndround=134;
	   ret=addtkt(4,mbrid,mbruid,1,request, response);
	   if(ret==0){
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ��������ԭ��99Ԫ��è��ʯˮ�ε�׹50Ԫ����ȯ������Ʒ�Ѽ������Ĺ��ﳵ�����ﳵֱ�Ӽ��⣬����49Ԫ��");
        }else{
        	System.out.println("d1gjl-------typid=4����");
 		   out.print("&roulette=2&rouletteStr=��ϲ�����100Ԫ�����Ż�ȯ��ȫ����װ��Ʒ��Ʒ��15�����⣬30������Ч,������ҵ��ʻ��в�ѯ!");
	   }
      return;
   }
   else if(rndvalue>250 && rndvalue<=300){
	   rndround=180;
	   ret=addtkt(5,mbrid,mbruid,2,request, response);
	   if(ret==0){
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ�����5Ԫ�Ż�ȯ��ȫ��ͨ�ã�30������Ч,������ҵ��ʻ��в�ѯ!");
        }else{
        	  System.out.println("d1gjl-------typid=6����");
 		   out.print("&roulette=2&rouletteStr=��ϲ�����100Ԫ�����Ż�ȯ��ȫ����װ��Ʒ��Ʒ��15�����⣬30������Ч,������ҵ��ʻ��в�ѯ!");
	   }
   }
   else if(rndvalue>50 && rndvalue<=250){
	   rndround=224;
	   ret=addtkt(6,mbrid,mbruid,1,request, response);
	   if(ret==0){
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ��������ԭ��99Ԫ��FEEL MIND���Ƹ߼�ţƤǮ��60Ԫ����ȯ������Ʒ�Ѽ������Ĺ��ﳵ�����ﳵֱ�Ӽ��⣬����39Ԫ��");
        }else{
        	  System.out.println("d1gjl-------typid=6����");
 		   out.print("&roulette=2&rouletteStr=��ϲ�����100Ԫ�����Ż�ȯ��ȫ����װ��Ʒ��Ʒ��15�����⣬30������Ч,������ҵ��ʻ��в�ѯ!");
	   }
	   return;
   }
   else if(rndvalue>=0 && rndvalue<=50){
	   rndround=312;
	   ret=addtkt(8,mbrid,mbruid,1,request, response);
	   if(ret==0){
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ��������D1���о���̨��������Ʒ�Ѽ������Ĺ��ﳵ��");
        }else{
        	  System.out.println("d1gjl-------typid=6����");
 		   out.print("&roulette=2&rouletteStr=��ϲ�����100Ԫ�����Ż�ȯ��ȫ����װ��Ʒ��Ʒ��15�����⣬30������Ч,������ҵ��ʻ��в�ѯ!");
	   }
	   return;
   }

//}

%>