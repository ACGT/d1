<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.bean.*,java.util.*,com.d1.helper.*,org.hibernate.criterion.*,com.d1.dbcache.core.*"%>

<%!
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

   //根据id获取评论组，id不存在获取全部
	public static  ArrayList<CommentGroup> getCommentGroupList(String id){
	   ArrayList<CommentGroup> rlist=new   ArrayList<CommentGroup>();
	   List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	   if(id!=null&&id.length()>0&&Tools.isNumber(id))
	   {
		  clist.add(Restrictions.eq("id",id));
	   }
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.desc("commentgroup_createtime"));
		List<BaseEntity> blist=Tools.getManager(CommentGroup.class).getList(clist, olist, 0, 2000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					rlist.add((CommentGroup)b);
				}
			}
		}
		return rlist;
	}

	//根据商品编号获取评论组
	public static ArrayList<CommentGroup> getCommentGroupListBygdsid(String gdsid)
    {
	   ArrayList<CommentGroupSub> rlist=new   ArrayList<CommentGroupSub>();
	   List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	   if(gdsid!=null&&gdsid.length()>0&&Tools.isNumber(gdsid))
	   {
		  clist.add(Restrictions.eq("commentgroupsub_gdsid",gdsid));
	   }
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.desc("commentgroupsub_createtime"));
		List<BaseEntity> blist=Tools.getManager(CommentGroupSub.class).getList(clist, null, 0, 100);
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
		ArrayList<CommentGroup> cglist1=new ArrayList<CommentGroup>();
		if(rlist!=null&&rlist.size()>0)
		{
			for(CommentGroupSub cgs:rlist)
			{
				if(cgs!=null)
				{
					CommentGroup cg=(CommentGroup)Tools.getManager(CommentGroup.class).get(cgs.getCommentgroupsub_cgid().toString());
					if(cg!=null){
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
	
	
	//根据商品编号和分类号获取评论组
		public static ArrayList<CommentGroup> getCGListByGC(String gdsid,String code,String flag)
	    {
			ArrayList<CommentGroup> rlist=new   ArrayList<CommentGroup>();
			List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
			if(code!=null&&code.length()>0&&Tools.isNumber(code))
			{
				 clist.add(Restrictions.like("commentgroup_rackcode",code+'%'));
			}
			if(flag!=null&&flag.length()>0&&Tools.isNumber(flag))
			{
				 clist.add(Restrictions.eq("commentgroup_flag",new Long(flag)));
			}
			List<Order> olist=new ArrayList<Order>();
			olist.add(Order.desc("commentgroup_createtime"));
			List<BaseEntity> blist=Tools.getManager(CommentGroup.class).getList(clist, olist, 0, 2000);
			if(blist!=null&&blist.size()>0)
			{
				for(BaseEntity b:blist)
				{
					if(b!=null)
					{
						rlist.add((CommentGroup)b);
					}
				}
			}
			if(gdsid.length()<=0||!Tools.isNumber(gdsid)){
				return rlist;
			}
			
			
			ArrayList<CommentGroup> cglist1=new ArrayList<CommentGroup>();
			if(rlist!=null&&rlist.size()>0)
			{
				for(CommentGroup cgs:rlist)
				{
					if(cgs!=null)
					{
						
						ArrayList<CommentGroupSub> cgslist=getCommentGroupSubList(cgs.getId());
						if(cgslist!=null&&cgslist.size()>0)
						{
							for(CommentGroupSub c:cgslist)
							{
								if(c!=null&&c.getCommentgroupsub_gdsid().equals(gdsid))
								{
									cglist1.add(cgs);
									break;
								}
							}
						}						
						
					}
				}
				return cglist1;
			}
			else {
				return null;
			}
	    }
	
	
	
		//根据商品编号和分类号获取评论组
				public static ArrayList<CommentGroup> getCGListByGC1(String gdsid,String code,String flag)
			    {
					ArrayList<CommentGroup> rlist=new   ArrayList<CommentGroup>();
					List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
					if(code!=null&&code.length()>0&&Tools.isNumber(code))
					{
						 clist.add(Restrictions.like("commentgroup_rackcode",code+"%"));
					}
					if(flag!=null&&flag.length()>0&&Tools.isNumber(flag))
					{
						 clist.add(Restrictions.eq("commentgroup_flag",new Long(flag)));
					}
					List<Order> olist=new ArrayList<Order>();
					olist.add(Order.desc("commentgroup_createtime"));
					List<BaseEntity> blist=Tools.getManager(CommentGroup.class).getList(clist, olist, 0, 2000);
					if(blist!=null&&blist.size()>0)
					{
						for(BaseEntity b:blist)
						{
							if(b!=null)
							{
								rlist.add((CommentGroup)b);
							}
						}
					}
					if(gdsid.length()<=0||!Tools.isNumber(gdsid)){
						return rlist;
					}
					
					
					ArrayList<CommentGroup> cglist1=new ArrayList<CommentGroup>();
					if(rlist!=null&&rlist.size()>0)
					{
						for(CommentGroup cgs:rlist)
						{
							if(cgs!=null)
							{
								
								ArrayList<CommentGroupSub> cgslist=getCommentGroupSubList(cgs.getId());
								if(cgslist!=null&&cgslist.size()>0)
								{
									for(CommentGroupSub c:cgslist)
									{
										if(c!=null&&c.getCommentgroupsub_gdsid().equals(gdsid))
										{
											cglist1.add(cgs);
											break;
										}
									}
								}						
								
							}
						}
						return cglist1;
					}
					else {
						return null;
					}
			    }
			
			
	
%>