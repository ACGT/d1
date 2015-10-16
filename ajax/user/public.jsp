<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.*,java.util.*,org.hibernate.criterion.*,com.d1.dbcache.core.BaseEntity,com.d1.util.Tools"%><%!
public static  ArrayList<BuyLimitDtl> getbuylimit(String mbrid,Date starttime, Date endtime)
{
     ArrayList<BuyLimitDtl> bldlist=new ArrayList<BuyLimitDtl>();
     List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
     clist.add(Restrictions.ge("gdsbuyonedtl_mstid",new Long(62)));
     clist.add(Restrictions.le("gdsbuyonedtl_mstid",new Long(65)));
     clist.add(Restrictions.eq("gdsbuyonedtl_mbrid",new Long(mbrid)));
     clist.add(Restrictions.ge("gdsbuyonedtl_createtime", starttime));
	 clist.add(Restrictions.le("gdsbuyonedtl_createtime", endtime));
	List<BaseEntity> blist=Tools.getManager(BuyLimitDtl.class).getList(clist, null, 0, 10);
     if(blist==null || blist.size()==0) return null;
    // System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAA");
     for(BaseEntity be:blist) {
    	 BuyLimitDtl bld=(BuyLimitDtl)be;
		    if(bld.getGdsbuyonedtl_gdsid()!=null&&(bld.getGdsbuyonedtl_gdsid().equals("02103005")||bld.getGdsbuyonedtl_gdsid().equals("02103004")||bld.getGdsbuyonedtl_gdsid().equals("02103003")||bld.getGdsbuyonedtl_gdsid().equals("02103002") )){
		    	bldlist.add(bld);
		    	
		    }
    		
    	 }

     return bldlist;
}
public static  ArrayList<BuyLimitDtl> getbuylimitByOrder(String mbrid,String odrid)
{
     ArrayList<BuyLimitDtl> bldlist=new ArrayList<BuyLimitDtl>();
     List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
     clist.add(Restrictions.eq("gdsbuyonedtl_mbrid",new Long(mbrid)));
     clist.add(Restrictions.eq("gdsbuyonedtl_odrid",odrid));
	List<BaseEntity> blist=Tools.getManager(BuyLimitDtl.class).getList(clist, null, 0, 10);
     if(blist==null || blist.size()==0) return null;
     for(BaseEntity be:blist) {
    	 BuyLimitDtl bld=(BuyLimitDtl)be;
		  bldlist.add(bld);
    	 }

     return bldlist;
}
%>