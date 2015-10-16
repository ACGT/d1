<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.*,com.d1.dbcache.core.*,com.d1.manager.*,com.d1.helper.*,com.d1.util.*,java.util.*,org.hibernate.criterion.*,org.hibernate.*"%>

<%!
   //获得所有分类
   private static ArrayList<Directory> getallDirectory()
   {
		ArrayList<Directory> list=new ArrayList<Directory>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		//clist.add(Restrictions.eq("rakmst_typeid", new Long(1)));
		//clist.add(Restrictions.eq("rakmst_showflag", new Long(1)));
		List<BaseEntity> b_list = Tools.getManager(Directory.class).getList(null, null, 0, 2000);
		if(b_list==null||b_list.size()==0)return null;
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Directory)be);
			}
		}
		return list;
   }
//获取所有上架商品
   private static ArrayList<Product> getlist()
   {
	    ArrayList<Product> list=new ArrayList<Product>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));		
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, null, 0,10000);
		if(b_list==null||b_list.size()==0)return null;
		if(b_list!=null){
			for(BaseEntity be:b_list){
				if(be!=null&&Tools.isNumber(be.getId())){
				list.add((Product)be);
				}
			}
		}
		return list;
	
   }
%>

<%
      //type=1代表分类，type=2代表频道，type=3代表商品，type=4代表汇总
      String type="";
      if(request.getParameter("type")!=null&&request.getParameter("type").length()>0)
      {
    	  type=request.getParameter("type");
      }

		//输出相应xml内容
		if(type.equals("1")){
			StringBuffer sb=new StringBuffer("");
	        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
	        sb.append("<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">");
	        ArrayList<Directory> list=getallDirectory();
	        if(list!=null&&list.size()>0)
	        {
	        	for(Directory dir:list)
	        	{
	        		if(dir!=null&&(dir.getId().startsWith("02")||dir.getId().startsWith("03")||dir.getId().startsWith("014")||dir.getId().startsWith("015")))
	        		{
	        			sb.append("<url>");
	        			sb.append("<loc>http://www.d1.com.cn/result.jsp?productsort="+dir.getId()+"</loc>");
	        			sb.append("</url>");
	        		}
	        	}
	        }
	        sb.append("</urlset>");
			response.setContentType("text/xml");
			out.print(sb);
		}
		else if(type.equals("2")){
			StringBuffer sb=new StringBuffer("");
	        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
	        sb.append("<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">");
	        ArrayList<Tag> list=TagHelper.getTags();
	        if(list!=null&&list.size()>0)
	        {
	        	for(Tag t:list)
	        	{
	        		if(t!=null)
	        		{
	        			sb.append("<url>");
	        			sb.append("<loc>http://www.d1.com.cn/channel/"+t.getId()+"</loc>");
	        			sb.append("</url>");
	        		}
	        	}
	        }
	        sb.append("</urlset>");
			response.setContentType("text/xml");
			out.print(sb);
		}
		else if(type.equals("3")){
			StringBuffer sb=new StringBuffer("");
	        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
	        sb.append("<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">");
	        ArrayList<Product> list=getlist();
	        if(list!=null&&list.size()>0)
	        {
	        	for(Product t:list)
	        	{
	        		if(t!=null)
	        		{
	        			sb.append("<url>");
	        			sb.append("<loc>http://www.d1.com.cn/product/"+t.getId()+"</loc>");
	        			sb.append("</url>");
	        		}
	        	}
	        }
	        sb.append("</urlset>");
			response.setContentType("text/xml");
			out.print(sb);
		}
		else
		{
			StringBuffer sb=new StringBuffer("");
	        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
	        sb.append("<sitemapindex xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">");
	        sb.append("<sitemap>");
	        sb.append("<loc>http://www.d1.com.cn/sort.xml</loc>");
	        sb.append("</sitemap>");
	        sb.append("<sitemap>");
	        sb.append("<loc>http://www.d1.com.cn/channel.xml</loc>");
	        sb.append("</sitemap>");
	        sb.append("<sitemap>");
	        sb.append("<loc>http://www.d1.com.cn/product.xml</loc>");
	        sb.append("</sitemap>");
            sb.append("</sitemapindex>");
			response.setContentType("text/xml");
			out.print(sb);
		}
			
%>