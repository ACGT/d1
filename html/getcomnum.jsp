<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.bean.*,java.util.*,com.d1.helper.*,org.hibernate.criterion.*, com.d1.dbcache.core.BaseEntity,org.hibernate.criterion.*,org.hibernate.*,java.text.*"%>
<%!
public static int getCommentListNew(String productId ,Date times){
	if(Tools.isNull(productId)) return 0;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdscom_gdsid", productId));
	listRes.add(Restrictions.eq("gdscom_status", new Long(1)));		
    Calendar c=Calendar.getInstance();
    c.setTime(times);
	c.add(Calendar.DATE,-20);
	listRes.add(Restrictions.ge("gdscom_createdate", c.getTime()));
	return Tools.getManager(Comment.class).getLength(listRes);
}
public static ArrayList<CommentGroup> getCommentGroupListBygdsid(String gdsid)
{
	   ArrayList<CommentGroupSub> rlist=new   ArrayList<CommentGroupSub>();
	   List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	   if(gdsid!=null&&gdsid.length()>0&&Tools.isNumber(gdsid))
	   {
		  clist.add(Restrictions.eq("commentgroupsub_gdsid",gdsid));
		  clist.add(Restrictions.eq("commentgroupsub_flag",new Long(1)));
	   }
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.desc("commentgroupsub_createtime"));
		List<BaseEntity> blist=Tools.getManager(CommentGroupSub.class).getList(clist, olist, 0, 10000);
	
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
				  rlist.add((CommentGroupSub)b); 
		         
				}
			}
		}
		else return null;
		ArrayList<CommentGroup> cglist1=new ArrayList<CommentGroup>();
		if(rlist!=null&&rlist.size()>0)
		{
			for(CommentGroupSub cgs:rlist)
			{
				if(cgs!=null)
				{
					CommentGroup cg=(CommentGroup)Tools.getManager(CommentGroup.class).get(cgs.getCommentgroupsub_cgid().toString());
					if(cg!=null&&cg.getCommentgroup_flag()!=null&&cg.getCommentgroup_flag().longValue()==1){
						cglist1.add(cg);
					}
					
				}
			}
			return cglist1;
		}
		else {
			return null;
		}
}
public static ArrayList<CommentGroupSub> getCommentGroupSubList(String subid)
{
	 ArrayList<CommentGroupSub> rlist=new   ArrayList<CommentGroupSub>();
	   List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	   if(subid!=null&&subid.length()>0&&Tools.isNumber(subid))
	   {
		  clist.add(Restrictions.eq("commentgroupsub_cgid",new Long(subid)));
		  clist.add(Restrictions.eq("commentgroupsub_flag",new Long(1)));
	   }
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.desc("commentgroupsub_createtime"));
		List<BaseEntity> blist=Tools.getManager(CommentGroupSub.class).getList(clist, olist, 0, 100);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
				rlist.add((CommentGroupSub)b); 
				}
			}
		}
		return rlist;
}
public static int getCommentcount(String gdsid)
{
	int count=0;
    if(gdsid==null||gdsid.length()<=0||!Tools.isNumber(gdsid))
    {
    	return count;
    }
    Product product=ProductHelper.getById(gdsid);

    ArrayList<CommentGroup> cglist=new ArrayList<CommentGroup>();
    cglist=getCommentGroupListBygdsid(gdsid);
  
    if(cglist!=null&&cglist.size()>0)
    {
    	for(CommentGroup cg:cglist)
    	{
    		if(cg!=null&&cg.getCommentgroup_flag()!=null&&cg.getCommentgroup_flag().longValue()==1)
    		{
    			ArrayList<CommentGroupSub> cgslist=getCommentGroupSubList(cg.getId());
    			if(cgslist!=null&&cgslist.size()>0)
    			{
    				for(CommentGroupSub cgs:cgslist)
    				{
    					if(cgs!=null&&cgs.getCommentgroupsub_flag()!=null&&cgs.getCommentgroupsub_flag().longValue()==1
    							&&cgs.getCommentgroupsub_gdsid()!=null&&cgs.getCommentgroupsub_gdsid().length()>0&&!cgs.getCommentgroupsub_gdsid().equals(gdsid))
    					{
    						Product p=ProductHelper.getById(cgs.getCommentgroupsub_gdsid().trim());
    						if(p!=null)
    						{
    							Date times=product.getGdsmst_createdate()!=null?product.getGdsmst_createdate():new Date();
    							count+=getCommentListNew(cgs.getCommentgroupsub_gdsid(),times);
    						}
    						
    					}
    				}
    			}
    		}
    	}
    }
    count+=CommentHelper.getCommentLength(gdsid);
    return count;
}
%>