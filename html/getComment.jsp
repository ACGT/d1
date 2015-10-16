<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.bean.*,java.util.*,com.d1.helper.*,org.hibernate.criterion.*, com.d1.dbcache.core.BaseEntity,org.hibernate.criterion.*,org.hibernate.*,java.text.*"%>
<%!

/**获取一个月前的评论
	 * 获得对应商品的评论信息（已审核且页面显示状态为1）
	 * @param productId - 物品ID
	 * @param start - 开始
	 * @param length - 长度
	 * @return List<Comment>
	 */
	public static List getCommentListNew(String productId ,String rackcode,Date times, int start , int length){
		if(Tools.isNull(productId)) return null;
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdscom_gdsid", productId));
		listRes.add(Restrictions.eq("gdscom_status", new Long(1)));	
		if(Tools.isNull(rackcode)||!rackcode.startsWith("014")){
        Calendar c=Calendar.getInstance();
        c.setTime(times);
		c.add(Calendar.DATE,-20);
		listRes.add(Restrictions.ge("gdscom_createdate", c.getTime()));
		}
		//listRes.add(Restrictions.eq("gdscom_checkStatue", new Long(1)));
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.desc("gdscom_createdate"));
		
		return Tools.getManager(Comment.class).getList(listRes, listOrder, start, length);
	}



//获取所有评论主组
public static ArrayList<CommentGroup> getCommentGroupList()
{
	ArrayList<CommentGroup> list=new ArrayList<CommentGroup>();
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();		
	clist.add(Restrictions.eq("commentgroup_flag",new Long(1)));
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.desc("commentgroup_createtime"));
	List<BaseEntity> blist=Tools.getManager(CommentGroup.class).getList(clist, olist, 0, 10000);
	if(blist!=null&&blist.size()>0)
	{
		for(BaseEntity b:blist)
		{
			if(b!=null)
			{
				list.add((CommentGroup)b);
			}
		}
	}
	return list;
}

   //根据商品编号获取评论组
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

	 /**
    根据评论主组id获取评论组详细记录
 */
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

   /**
            获取多个商品的评论列表
   */
    public static ArrayList<Comment> getCommentList(String gdsid)
    {
	    if(gdsid==null||gdsid.length()<=0||!Tools.isNumber(gdsid))
	    {
	    	return null;
	    }
	    Product product=ProductHelper.getById(gdsid);
	    
	    ArrayList<Comment> clist=new ArrayList<Comment>();
	    ArrayList<Comment> clist1=new ArrayList<Comment>();
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
	    							clist1.addAll(getCommentListNew(cgs.getCommentgroupsub_gdsid(),p.getGdsmst_rackcode(),times,0, 500));
	    						}
	    						
	    					}
	    				}
	    			}
	    		}
	    	}
	    }
	    clist.addAll(CommentHelper.getCommentList(gdsid,0, 500));
	    Collections.sort(clist1,new com.d1.comp.CommentsCreateTimeComparator());
	    clist.addAll(clist1);
        return clist;
    }
   
    /**
    获取多个商品的评论列表
*/
	public static ArrayList<Comment> getCommentListPage(ArrayList<Comment> commentlist, int start , int length)
	{
	    ArrayList<Comment> clist=new ArrayList<Comment>();
	    if(commentlist!=null&&commentlist.size()>0)
	    {
	    	for(int i=start;i<length+start&&i<commentlist.size();i++)
	    	{
	    		Comment c=commentlist.get(i);
	    		if(c!=null)
	    		{
	    			clist.add(c);
	    		}
	    	}
	    }
	    return clist;
	}

   
   
   
    public static double getCommentLevel1019(String gdsid){
    	if(Tools.isNull(gdsid)) return 0;
    	int score_5 = 0;
		int score_4 = 0;
		int score_3 = 0;
		int score_2 = 0;
		int score_1 = 0;
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
	    						score_5 += CommentHelper.getCommentLevelCount(cgs.getCommentgroupsub_gdsid() , 5);
	    						score_4 += CommentHelper.getCommentLevelCount(cgs.getCommentgroupsub_gdsid() , 4);
	    						score_3 += CommentHelper.getCommentLevelCount(cgs.getCommentgroupsub_gdsid() , 3);
	    						score_2 += CommentHelper.getCommentLevelCount(cgs.getCommentgroupsub_gdsid()  , 2);
	    						score_1 += CommentHelper.getCommentLevelCount(cgs.getCommentgroupsub_gdsid() , 1);
	    						
	    						score_5 += CommentHelper.getCacheCommentLevelCount(cgs.getCommentgroupsub_gdsid() , 5);
	    						score_4 += CommentHelper.getCacheCommentLevelCount(cgs.getCommentgroupsub_gdsid() , 4);
	    						score_3 += CommentHelper.getCacheCommentLevelCount(cgs.getCommentgroupsub_gdsid() , 3);
	    						score_2 += CommentHelper.getCacheCommentLevelCount(cgs.getCommentgroupsub_gdsid() , 2);
	    						score_1 += CommentHelper.getCacheCommentLevelCount(cgs.getCommentgroupsub_gdsid() , 1);
	    					}
	    				}
	    			}
	    		}
	    	}
	    }
	    score_5 += CommentHelper.getCommentLevelCount(gdsid, 5);
		score_4 += CommentHelper.getCommentLevelCount(gdsid, 4);
		score_3 += CommentHelper.getCommentLevelCount(gdsid, 3);
		score_2 += CommentHelper.getCommentLevelCount(gdsid, 2);
		score_1 += CommentHelper.getCommentLevelCount(gdsid, 1);
		
	    score_5 += CommentHelper.getCacheCommentLevelCount(gdsid, 5);
		score_4 += CommentHelper.getCacheCommentLevelCount(gdsid ,4);
		score_3 += CommentHelper.getCacheCommentLevelCount(gdsid, 3);
		score_2 += CommentHelper.getCacheCommentLevelCount(gdsid, 2);
		score_1 += CommentHelper.getCacheCommentLevelCount(gdsid, 1);
	    return (score_5 + score_4 * 0.8 + score_3 * 0.6 + score_2 * 0.4 + score_1 * 0.2) / (score_1 + score_2 + score_3 + score_4 + score_5);

    }


    /**
     * 商品评价星级显示
     * @param productId - 物品ID
     * @return int
     */
    public static int getLevelView1019(String productId){
        double score= getCommentLevel1019(productId);
        int avgscore=0;
        try{
        avgscore=(int)(score * 10);
        }catch(Exception ex)
        {
        	avgscore=0;
        }
        return avgscore;
    }
      
   
   
   
   
   
   
%>
