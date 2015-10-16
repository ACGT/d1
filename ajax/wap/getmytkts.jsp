<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.comp.*,java.util.*,com.d1.manager.*,org.hibernate.*"%><%@include file="/html/header.jsp" %>
<%!	/**
	 * 获取有效地积分换购信息
	 */
	public static ArrayList<Award> getAwardList(long s,long e){
		
		ArrayList<Award> rlist = new ArrayList<Award>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("award_validflag", new Long(1)));
		clist.add(Restrictions.ge("award_value", new Long(s)));
		clist.add(Restrictions.le("award_value", new Long(e)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("award_seq"));
		olist.add(Order.asc("award_price"));
		List<BaseEntity> list = Tools.getManager(Award.class).getList(clist, olist, 0, 200);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((Award)be);
		}
		//System.out.print(rlist.size());
		return rlist ;
	}
	 %>
<%
JSONObject json = new JSONObject();
if(lUser==null){
	json.put("status", "0");
	out.print(json);
	return;
}
ArrayList<TicketHelper.TicketWrap> islist=new ArrayList<TicketHelper.TicketWrap>();
ArrayList<TicketHelper.TicketWrap> nolist=new ArrayList<TicketHelper.TicketWrap>();

	ArrayList<TicketHelper.TicketWrap> list=new ArrayList<TicketHelper.TicketWrap>();
	list=TicketHelper.getTotalLoginUserTickets(request,response);
	for(TicketHelper.TicketWrap tw:list)
	{
		if(tw.getType()==0)
		{
			Ticket t=tw.getTicket();
			if(t.getTktmst_validflag().longValue()==0&&t.getTktmst_validatee().after(new Date()))
			{
				islist.add(tw);
			}
			else
			{
				nolist.add(tw);
			}
		}
		else
		{
			TicketCrd tc=tw.getTicketCrd();
			if(tc.getTktcrd_validflag().longValue()==1&&tc.getTktcrd_validatee().after(new Date())&&tc.getTktcrd_realvalue()>0)
			{
				islist.add(tw);
			}
			else
			{
				nolist.add(tw);
			}
		}
	}


JSONArray jsonarr=new JSONArray();

String pg=request.getParameter("pg"),psize=request.getParameter("psize"),type=request.getParameter("type");
int sgcount=islist.size();
if(type.equals("0"))sgcount=nolist.size();
if(Tools.isNull(pg))pg="1";
if(Tools.isNull(psize))psize="15";
int ipg=Tools.parseInt(pg);
int ipsize=Tools.parseInt(psize);
PageBean pBean1 = new PageBean(sgcount,ipsize,ipg);
if(ipg>pBean1.getCurrentPage()){
	json.put("status", "0");
	out.print(json);
	return;
}

int pbegin = (pBean1.getCurrentPage()-1)*ipsize;
int pend = pbegin + ipsize;
json.put("status", "1");
json.put("page_total", sgcount);

String tkttxt="";
   
   SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
   
 for(int t=pbegin; t<sgcount&&t<pend;t++ )
 {
	 TicketHelper.TicketWrap tktw=null;
			 if(type.equals("0")){
				 tktw=nolist.get(t);
			 }else{
				 tktw=islist.get(t);
			 }
			 if(tktw==null)continue;
	 JSONObject jsonitem = new JSONObject();
	String range = "全场";

if(tktw.getType()==0)
{

	if(!Tools.isNull(tktw.getTicket().getTktmst_sprckcodeStr())){
		range="促销专区券";
	   }
	else if(tktw.getTicket().getTktmst_brandname()!=null&&tktw.getTicket().getTktmst_brandname().length()>0)
	{
		range=tktw.getTicket().getTktmst_brandname();
	}
	else
	{
		
		Directory dir = (Directory)Tools.getManager(Directory.class).get(tktw.getTicket().getTktmst_rackcode());
		
		if(dir!=null&&!"000".equals(dir.getId())){
			range = "<a href=\"http://m.d1.cn/wap/result.html?rackcode="+dir.getId()+"&shopd1=1\" style=\" text-decoration:underline;\" target=\"_blank\" >自营"+dir.getRakmst_rackname()+"</a>";
		}
	}
}
else
{
    //Directory dir = (Directory)Tools.getManager(Directory.class).get(tktw.getTicketCrd().get().getTktmst_rackcode());
	range="全场";
	if(tktw.getTicketCrd().getTktcrd_brandname()!=null&&tktw.getTicketCrd().getTktcrd_brandname().length()>0)
	{
		range=tktw.getTicketCrd().getTktcrd_brandname();
	}else if(tktw.getTicketCrd().getTktcrd_rackcode()!=null&&tktw.getTicketCrd().getTktcrd_rackcode().length()>0)
	{
         Directory dir = (Directory)Tools.getManager(Directory.class).get(tktw.getTicketCrd().getTktcrd_rackcode());

         if(dir!=null&&!"000".equals(dir.getId())){
				range = "<a href=\"http://m.d1.cn/wap/result.html?rackcode="+dir.getId()+"&shopd1=1\" style=\" text-decoration:underline;\" target=\"_blank\" >自营"+dir.getRakmst_rackname()+"</a>";
			}
	}

}


if(tktw.getType()==0)
{
	tkttxt="满"+Tools.getFloat(tktw.getTicket().getTktmst_gdsvalue(),2)+"-"+Tools.getFloat(tktw.getTicket().getTktmst_value(),2);
			

}
else
{
	tkttxt="所购的商品按照"+Tools.getFloat((tktw.getTicketCrd().getTktcrd_discount().floatValue()*100),2)+"%减免";

}

jsonitem.put("tkttype",tktw.getType());
jsonitem.put("tktid",tktw.getType()==0?tktw.getTicket().getId():tktw.getTicketCrd().getId());
jsonitem.put("tktvalue",tktw.getType()==0?tktw.getTicket().getTktmst_value():tktw.getTicketCrd().getTktcrd_realvalue());
jsonitem.put("tkttxt",tkttxt);
jsonitem.put("tktrange",range);
jsonitem.put("tktstime",tktw.getType()==0?df.format(tktw.getTicket().getTktmst_validates()):df.format(tktw.getTicketCrd().getTktcrd_validates()));
jsonitem.put("tktetime",tktw.getType()==0?df.format(tktw.getTicket().getTktmst_validatee()):df.format(tktw.getTicketCrd().getTktcrd_validatee()));

jsonarr.add(jsonitem);
}
json.put("tkts", jsonarr);

out.print(json);
%>