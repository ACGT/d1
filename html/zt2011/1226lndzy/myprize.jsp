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
java.io.*,
com.d1.bean.LotCon"%><%
User lUser = UserHelper.getLoginUser(request, response);
%><%!

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

private void addtkt(int tkttype,String mbrid,String mbruid){
	long cardvalue=0;
	long gdsvalue=0;
	String memotxt="";
	String winname="";
	 switch (tkttype)
	    {
	        case 1:
	        	cardvalue=100;
	        	gdsvalue=300;
	        	memotxt="100Ԫ�Ż�ȯ";
	        	winname="��ϲ�����100Ԫ�Ż�ȯ��ȫ������300Ԫ���ã�15������Ч!";
                break;
	        case 2:
	        	cardvalue=10;
	        	gdsvalue=10;
	        	memotxt="10Ԫ�Ż�ȯ";
	        	winname="��ϲ�����10Ԫ�Ż�ȯ��ȫ��ͨ�ã�15������Ч!";
	            break;
	        case 3:
	        	cardvalue=20;
	        	gdsvalue=20;
	        	memotxt="20Ԫ�Ż�ȯ";
	        	winname="��ϲ�����20Ԫ�Ż�ȯ��ȫ��ͨ�ã�15������Ч!";
	            break;
	        case 4:
	        	cardvalue=20;
	        	gdsvalue=100;
	        	memotxt="20Ԫ�Ż�ȯ";
	        	winname="��ϲ�����20Ԫ�Ż�ȯ��ȫ������100Ԫ���ã�15������Ч!";
	            break;
	        case 5:
	        	cardvalue=100;
	        	gdsvalue=100;
	        	memotxt="100Ԫ�Ż�ȯ";
	        	winname="��ϲ�����100Ԫ�Ż�ȯ��ȫ�����ﰴ��Ʒ����15%���⣬15������Ч!";
	            break;
	        case 6:
	        	cardvalue=10;
	        	gdsvalue=50;
	        	memotxt="10Ԫ�Ż�ȯ";
	        	winname="��ϲ�����10Ԫ�Ż�ȯ��ȫ������50Ԫ���ã�15������Ч!";
	            break;
	        case 7:
	        	cardvalue=10;
	        	gdsvalue=10;
	        	memotxt="10Ԫ�Ż�ȯ";
	        	winname="��ϲ�����10Ԫ�Ż�ȯ��ȫ������100Ԫ���ã�15������Ч!";
	            break;
	        case 8:
	        	cardvalue=50;
	        	gdsvalue=200;
	        	memotxt="50Ԫ�Ż�ȯ";
	        	winname="��ϲ�����50Ԫ�Ż�ȯ��ȫ������200Ԫ���ã�15������Ч!";
	            break;
	    }
	 /*
	tktcrd_cardno,tktcrd_mbrid,tktcrd_value,tktcrd_realvalue,tktcrd_discount,
	tktcrd_type,tktcrd_validflag,tktcrd_enddate,tktcrd_validates,tktcrd_validatee,
	tktcrd_memo) values('"&cardnotitle&mbrid&randvalue&"',"&mbrid&","&gdsvalue&",
	"&cardvalue&",0.15,'004001',1,'"&now()+15&"','"&now()&"','"&now()+15&"','����齱�ȯ') ")

	
	 */
	 Random rndcard = new Random();
	 String cardno="ptaili1201"+mbrid+rndcard.nextInt(20000);
	 Date startdate=new Date();Date enddate=null;
	 try{
	 enddate=addDate(new Date(),15);
	 }
	 catch(Exception ex){
		 ex.printStackTrace();
	 }
	 if (tkttype==5){
		 TicketCrd tktcrd=new TicketCrd();
		 tktcrd.setTktcrd_cardno(cardno);
		 tktcrd.setTktcrd_mbrid(Tools.parseLong(mbrid));
		 tktcrd.setTktcrd_value(new Long(gdsvalue));
		 tktcrd.setTktcrd_realvalue(new Long(cardvalue));
		 tktcrd.setTktcrd_discount(new Float(0.15));
		 tktcrd.setTktcrd_type("004001");
		 tktcrd.setTktcrd_createdate(new Date());
		 tktcrd.setTktcrd_validflag(new Long(1));
		 tktcrd.setTktcrd_enddate(enddate);
		 tktcrd.setTktcrd_validates(startdate);
		 tktcrd.setTktcrd_validatee(enddate);
		 tktcrd.setTktcrd_memo("̨���齱���");
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
         tktmst.setTktmst_memo("̨���齱���");
         Tools.getManager(Ticket.class).create(tktmst);
	 }
	
	 LotWinAct lotwinact=new LotWinAct();
	 lotwinact.setLotwin8zn_mbrid(new Long(mbrid));
	 lotwinact.setLotwin8zn_uid(mbruid);
	 lotwinact.setLotwin8zn_winid(new Long(1));
	 lotwinact.setLotwin8zn_memo(memotxt);
	 lotwinact.setLotwin8zn_winname(winname);
	 lotwinact.setLotwin8zn_flag(new Long(0));
	 lotwinact.setLotwin8zn_createtime(new Date());
	 Tools.getManager(LotWinAct.class).create(lotwinact);
}
%>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
Date dStartDate=null;
try{
	 dStartDate =fmt.parse("2012-2-1");
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
LotAct lotact=(LotAct)Tools.getManager(LotAct.class).findByProperty("lot8zn_mbrid",Tools.parseLong(lUser.getId()));
if(lotact==null){
	out.print("&roulette=999&rouletteStr=����û�г齱���ᣬ��������̨��ȯ��ȡ�齱����ɣ�");
	return;
}
if (lotact.getLot8zn_count()<=0){
	out.print("&roulette=999&rouletteStr=����û�г齱���ᣬ��������̨��ȯ��ȡ�齱����ɣ�");
	return;
}
lotact.setLot8zn_count(new Long(lotact.getLot8zn_count().longValue()-1));
Tools.getManager(LotAct.class).update(lotact, false);

ArrayList<LotCon> list=getLotCon();
if(list!=null && list.size()>0){
	LotCon lotcon=list.get(0);
	int lotcode=(int)lotcon.getLotcon_winid().longValue();
	long lotcodevalue=0;
	 switch (lotcode)
	    {
	        case 2:
	        	lotcodevalue=224;
	            break;
	        case 3:
	        	lotcodevalue=180;
	            break;
	        case 4:
	        	lotcodevalue=90;
	            break;
	        case 5:
	        	lotcodevalue=42;
	            break;
	        case 6:
	        	lotcodevalue=1;
	            break;
	        case 7:
	        	lotcodevalue=312;
	            break;
	        case 8:
	        	lotcodevalue=270;
	            break;
	    }
	 lotcon.setLotcon_flag(new Long(1));
	 Tools.getManager(LotCon.class).update(lotcon, false);
	 LotWinAct lotwinact=new LotWinAct();
	 lotwinact.setLotwin8zn_mbrid(new Long(lUser.getId()));
	 lotwinact.setLotwin8zn_uid(lUser.getMbrmst_uid());
	 lotwinact.setLotwin8zn_winid(new Long(lotcode));
	 lotwinact.setLotwin8zn_gdsid(lotcon.getLotcon_gdsid());
	 lotwinact.setLotwin8zn_memo(lotcon.getLotcon_name());
	 lotwinact.setLotwin8zn_winname(lotcon.getLotcon_winname());
	 lotwinact.setLotwin8zn_flag(new Long(0));
	 lotwinact.setLotwin8zn_createtime(new Date());
	 Tools.getManager(LotWinAct.class).create(lotwinact);
	 out.print("&roulette="+lotcodevalue+"&rouletteStr="+lotcon.getLotcon_winname()+"");
	 return;
}
else{
	Random rnd = new Random();
   long rndvalue=(long)rnd.nextInt(1000);
   long rndround=134;
   String mbrid=lUser.getId();
   String mbruid=lUser.getMbrmst_uid();
   /*
100Ԫ����ȯ��300-100��5%			600��300��100Ԫȯ      1    ����950
10Ԫ����ȯ��10-10��  20%		2400��10Ԫ������ȯ               2    ����750  С�ڵ���950  
20Ԫ����ȯ��10-10��10%			1200��20Ԫ������ȯ     3     ����650  С�ڵ���750 3
20Ԫ����ȯ��100-20��20%			2400��100Ԫ��20Ԫȯ  4    ����450  С�ڵ���650 3
100Ԫ����ȯ��15Ԫ���⣩10%			1200��15Ԫ����    5    ����350  С�ڵ���450 3
10Ԫ����ȯ��50-10��10%			1200��50��10Ԫȯ         6   ����250  С�ڵ���350 3
10Ԫ����ȯ��100-10��15%			1800��100-10Ԫȯ         7    ����100  С�ڵ���250 3
50Ԫ����ȯ��200-50��10%			1200��200��50ȯ            8  0-100
   */
   if (rndvalue>950){
	   addtkt(1,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ�����100Ԫ�Ż�ȯ��ȫ������300Ԫ���ã�15������Ч!");
	   return;
   }
   else if(rndvalue>750 && rndvalue<=950){
	   addtkt(2,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ�����10Ԫ�Ż�ȯ��ȫ��ͨ�ã�15������Ч!");
	   return;
   }
   else if(rndvalue>650 && rndvalue<=750){
	   addtkt(3,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ�����20Ԫ�Ż�ȯ��ȫ��ͨ�ã�15������Ч!");
	   return;
   }
   else if(rndvalue>450 && rndvalue<=650){
	   addtkt(4,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ�����20Ԫ�Ż�ȯ��ȫ������100Ԫ���ã�15������Ч!");
	   return;
   }
   else if(rndvalue>350 && rndvalue<=450){
	   addtkt(5,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ�����100Ԫ�Ż�ȯ��ȫ��������Ʒ��15�����⣬15������Ч!");
	   return;
   }
   else if(rndvalue>250 && rndvalue<=350){
	   addtkt(6,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ�����10Ԫ�Ż�ȯ��ȫ������50Ԫ���ã�15������Ч!");
	   return;
   }
   else if(rndvalue>100 && rndvalue<=250){
	   addtkt(7,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ�����10Ԫ�Ż�ȯ��ȫ������100Ԫ���ã�15������Ч!");
	   return;
   }
   else if(rndvalue>=0 && rndvalue<=100){
	   addtkt(8,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=��ϲ�����50Ԫ�Ż�ȯ��ȫ������200Ԫ���ã�15������Ч!");
	   return;
   }

}

%>