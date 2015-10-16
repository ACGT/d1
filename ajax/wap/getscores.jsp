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
		clist.add(Restrictions.eq("award_shopcode", "00000000"));
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
String cls=request.getParameter("cls");
long s=0;
long e=500;
if(cls.equals("1")){
	 s=501;
	 e=1000;
}
if(cls.equals("2")){
	 s=1001;
	 e=50000;
}
List<Award> awardlist=getAwardList(s,e);

if(awardlist==null&&awardlist.size()<=0){

	json.put("status", "0");
	out.print(json);
	return;
}
 DecimalFormat df2 = new DecimalFormat("0.00");
 String gdsid="";
 json.put("status", "1");
 JSONArray jsonarr=new JSONArray();
	   String awardid="";
	   String title ="";
for(Award award:awardlist )
{
	awardid=award.getId();
	   gdsid = award.getAward_gdsid();
	   
	 Product p=ProductHelper.getById(gdsid);
	 if(!gdsid.equals("00000000")&&p==null)continue;
	  JSONObject jsonitem = new JSONObject();
		
	  title=Tools.clearHTML(award.getAward_gdsname()).trim();
	
	        	   jsonitem.put("score_id",awardid);
	        		jsonitem.put("score_gdsid",gdsid);
	        		jsonitem.put("score_gdsname",title);
	        		jsonitem.put("score_jifen",award.getAward_value());
	        		if(!gdsid.equals("00000000")){
	        		jsonitem.put("score_img",ProductHelper.getImageTo200(p));
	        		jsonitem.put("score_mprice",df2.format(p.getGdsmst_memberprice()) );
	        		}else{
	        			jsonitem.put("score_img",award.getAward_smallimg());
		        		jsonitem.put("score_mprice",df2.format(0f) );
	        		}
	        		jsonitem.put("score_dhprice",df2.format(award.getAward_price()));
	        		jsonarr.add(jsonitem);
	        		
}
json.put("scores", jsonarr);
out.print(json);
%>