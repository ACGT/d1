<%@ page contentType="text/html; charset=UTF-8"  import="cn.b2m.eucp.sdkhttp.*"%>
<%@include file="/html/header.jsp"%>
<%!
public static  ArrayList<SmsSndDtl>  getSendSmsList(){
	ArrayList<SmsSndDtl> list=new ArrayList<SmsSndDtl>();
   
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("ifsend", new Long(0)));

			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.asc("id"));
			List<BaseEntity> b_list = Tools.getManager(SmsSndDtl.class).getList(clist, olist, 0, 100);

			if(b_list!=null&&b_list.size()>0)
			{
				for(BaseEntity b:b_list)
				{
					if(b!=null)
					{
						list.add((SmsSndDtl)b);
					}
				}
			}
			return list;

}
public static boolean SendSms(String phone,String smstxt){
	String[]  phones=phone.split("@@@@");
	int ret=SendSms.SendSMS(phones, "【d1优尚】"+smstxt);
	if(ret==0){
		return true;
	}else{
		return false;
	}
}
%>
<%
//if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){
	Date dd=new Date();
	if (dd.getHours()>=8&&dd.getHours()<22){
	List<SmsSndDtl> list =getSendSmsList();
	if(list != null && !list.isEmpty()){
    	for(SmsSndDtl sms : list){
    		boolean ret=SendSms(sms.getPhone().trim(),sms.getSmstxt());
    		if(ret){
    		sms.setTemp1("营销短信");
    		sms.setIfsend(new Long(1));
    		sms.setSenddate(new Date());
    		Tools.getManager(SmsSndDtl.class).update(sms, true);
    		}else{
    			sms.setTemp1("营销短信");
    			sms.setIfsend(new Long(-1));
        		sms.setSenddate(new Date());
        		Tools.getManager(SmsSndDtl.class).update(sms, true);
    		}
    	}
	}
	}
	//}
%>