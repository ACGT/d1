<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%!
   //获取平铺图
   private ArrayList<GdsCutImg> getAll(String gdsid)
   {
      ArrayList<GdsCutImg> gdslist=new ArrayList<GdsCutImg>();
      List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
      clist.add(Restrictions.eq("gdsmst_gdsid", gdsid));

      List<BaseEntity> list = Tools.getManager(GdsCutImg.class).getList(clist, null, 0, 1000);

      if(list==null||list.size()==0)return null;
		for(BaseEntity c:list){
			gdslist.add((GdsCutImg)c);
		}
      return gdslist ;
   }

   //获取细节图   
   private ArrayList<GdsImgDtl> getAllxj(String gdsid)
   {
      ArrayList<GdsImgDtl> gdslist=new ArrayList<GdsImgDtl>();
      List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
      clist.add(Restrictions.eq("gdsimgdtl_gdsid", gdsid));

      List<BaseEntity> list = Tools.getManager(GdsImgDtl.class).getList(clist, null, 0, 1000);

      if(list==null||list.size()==0)return null;
		for(BaseEntity c:list){
			gdslist.add((GdsImgDtl)c);
		}
      return gdslist ;
   }
   //获取Sku
   public static ArrayList<Sku> getSkuListViaProductId(String productId){
		
		if(Tools.isNull(productId)||!SkuHelper.hasSku(productId))return null;
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("skumst_gdsid", productId));
		
		List<BaseEntity> list = Tools.getManager(Sku.class).getList(clist, null, 0, 100);
		
		ArrayList<Sku> rlist = new ArrayList<Sku>();
		if(list!=null&&list.size()>0){
			for(BaseEntity sku:list){
				rlist.add((Sku)sku);
			}
		}
		return rlist ;
	}
%>
<%

    String gdsid="";
    if(request.getParameter("gdsid")!=null){
    	gdsid=request.getParameter("gdsid");
    }
    if(!gdsid.equals("")){
    	Product p=ProductHelper.getById(gdsid);
    	if(p!=null)
    	{
    		try{
    		//删除商品表
    		System.out.print(gdsid);
    		if(Tools.getManager(Product.class).delete(p))
    		{
	    		//删除GdsCutImg表
	    		ArrayList<GdsCutImg> list1= getAll(gdsid);
	    		if(list1!=null&&list1.size()>0)
	    		{
	    			for(GdsCutImg gds:list1)
	    			{
	    				if(gds!=null)
	    				{
	    					Tools.getManager(GdsCutImg.class).delete(gds);
	    				}
	    			}
	    		}
	    		
	    		//删除GdsImgDtl表
	    		ArrayList<GdsImgDtl> list2= getAllxj(gdsid);
	    		if(list2!=null&&list2.size()>0)
	    		{
	    			for(GdsImgDtl gds:list2)
	    			{
	    				if(gds!=null)
	    				{
	    					Tools.getManager(GdsImgDtl.class).delete(gds);
	    				}
	    			}
	    		}
	    		//删除Sku
	    		if(SkuHelper.hasSku(p))
		    		{
		    		    ArrayList<Sku> skulist=getSkuListViaProductId(gdsid);
		    		    if(skulist!=null&&skulist.size()>0){
		    		    	for(Sku s:skulist)
		    		    	{
		    		    	   Tools.getManager(Sku.class).delete(s);
		    		    	}
		    		    }
		    		}
	    		out.print("{\"success\":true,\"message\":\"删除商品成功！\"}");
    		}
    		}
    		catch(Exception e)
    		{
    			out.print("{\"success\":false,\"message\":\"删除商品出错！\"}");
        		return;
    		}
    	}
    	else
    	{
    		out.print("{\"success\":false,\"message\":\"商品不存在！\"}");
    		return;
    	}
    }
    else
    {
    	out.print("{\"success\":false,\"message\":\"商品id不正确！\"}");
		return;
    }

%>