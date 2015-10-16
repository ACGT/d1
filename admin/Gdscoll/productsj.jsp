<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkrgt.jsp"%>
<%!
/**
 * 取sku列表，只取有库存的、上架的商品，修改库存时要清除列表
 * @param productId
 * @return
 */
public static ArrayList<Sku> getSkuListViaProductId(String productId){
	
	if(Tools.isNull(productId)||!SkuHelper.hasSku(productId))return null;
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("skumst_gdsid", productId));
	clist.add(Restrictions.gt("skumst_stock", new Long(0)));//有库存
	
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
    String id="";
    if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
    {
    	id=request.getParameter("id");
        if(session.getAttribute("admin_mng")!=null){
        	   String userid=session.getAttribute("admin_mng").toString();
        	   ArrayList<AdminPower> aplist=AdminPowerHelper.getAwardByGdsid(userid, "gds_sjmodi"); 
        	   if(aplist==null||aplist.size()<=0)
        	   {
        		   out.print("{\"success\":false,\"message\":\"对不起，您没有权限！\"}");
        		   return;
        	   }
         } 
         else
         {
        		out.print("{\"success\":false,\"message\":\"对不起，您没有登录！\"}");
        		return;
         }      
        Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(id);
        if(gdscoll!=null)
        {
        	ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid1(id);
        	if(gdlist!=null&&gdlist.size()>0)
        	{
        		for(Gdscolldetail gd:gdlist)
        		{
        			if(gd!=null&&gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
        			{
        				Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
        				if(p!=null&&p.getGdsmst_validflag().longValue()==5)
        				{
        					p.setGdsmst_validflag(new Long(1));
        					p.setGdsmst_stocklinkty(new Long(1));
        					p.setGdsmst_autoupdatedate(new Date());
        					if(!Tools.getManager(Product.class).update(p, true))
        					{
        						
        						out.print("{\"success\":false,\"message\":\"更新商品上架失败！\"}");
        	                	return;
        					}
        					else
        					{
        						if(p.getGdsmst_skuname1()!=null&&p.getGdsmst_skuname1().length()>0){
	        						ArrayList<Sku> skulist=getSkuListViaProductId(p.getId());
	        						out.print(skulist.size());
	            					if(skulist!=null&&skulist.size()>0)
	            					{
	            						for(Sku sku:skulist)
	            						{
	            							if(sku.getSkumst_stock().longValue()>0&&sku.getSkumst_validflag().longValue()!=1)
	            							{
	            								sku.setSkumst_validflag(new Long(1));
	            								if(!Tools.getManager(Sku.class).update(sku, false))
	            								{
	            									out.print("{\"success\":false,\"message\":\"更新商品id为"+p.getId()+"的"+p.getGdsmst_skuname1()+sku.getSkumst_sku1()+"上架失败！\"}");
	            									return;
	            								}
	            							}
	            						}
	            					}
        						}            					
        					}
        				}
        			}
        		}
        	}
        	if(gdscoll.getGdscoll_flag().longValue()==0){
        	    gdscoll.setGdscoll_flag(new Long(1));
                if(!Tools.getManager(Gdscoll.class).update(gdscoll, false))
                {
                	out.print("{\"success\":false,\"message\":\"更新搭配上架失败！\"}");
                	return;
                }
                else
                {
                	out.print("{\"success\":false,\"message\":\"上架成功！\"}");
                }
        	}
        	
        }
        
    
    }
    else
    {
    	out.print("{\"success\":false,\"message\":\"参数不正确！\"}");
    }

%>