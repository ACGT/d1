<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%!
/**
 * 取sku列表，修改库存时要清除列表
 * @param productId
 * @return
 */
 public static final BaseManager manager = Tools.getManager(Sku.class);
public static ArrayList<Sku> getSkuListViaProductId(String productId){
	//以前的逻辑是先判断商品表中是否有SKU，再判断gdsmst_skuname1是否有值，现在逻辑是在SKU无的情况下依旧可以查出数据。
	//因此现在的逻辑改为：只判断商品表中是否存在SKU
	//if(Tools.isNull(productId)||!SkuHelper.hasSku(productId))return null;
	Product p = (Product)Tools.getManager(Product.class).get(productId);
	if(Tools.isNull(productId)||p==null)return null;
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("skumst_gdsid", productId));
	
	List<BaseEntity> list = manager.getList(clist, null, 0, 100);
	
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
    String gdsid=request.getParameter("gid");
    ArrayList<Sku> slist=getSkuListViaProductId(gdsid);
    Product p=ProductHelper.getById(gdsid);
    if(p!=null&&slist!=null&&slist.size()>0)
    {
    	for(Sku s:slist)
    	{%>
    		<tr class="lsstr<%= gdsid %>" style="background:#fefce5;"><td colspan="2" style="text-align:center; border:solid 1px #d2d2d4; border-top:none;" height="27"><%=gdsid %></td>
    		<td style="text-align:center; border:solid 1px #d2d2d4; border-top:none; border-left:none;"></td>
    		<td style="text-align:center; border:solid 1px #d2d2d4; border-top:none; border-left:none;"><%=s.getSkumst_sku1() %></td>
    		<td style="text-align:center; border:solid 1px #d2d2d4; border-top:none; border-left:none;"></td>
    		<td style="text-align:center; border:solid 1px #d2d2d4; border-top:none; border-left:none;"></td>
    		<td style="text-align:center; border:solid 1px #d2d2d4; border-top:none; border-left:none;"></td>
    		<td style="text-align:center; border:solid 1px #d2d2d4; border-top:none; border-left:none;"><%= Tools.getFloat(p.getGdsmst_saleprice(), 1) %></td>
    		<td style="text-align:center; border:solid 1px #d2d2d4; border-top:none; border-left:none;"><%= Tools.getFloat(p.getGdsmst_memberprice(), 1) %></td>
    		<td style="text-align:center; border:solid 1px #d2d2d4; border-top:none; border-left:none;">
    		<input attr="<%= s.getId() %>" type="text" style="width:30px;" value="<%= s.getSkumst_stock() %>"></input></td>
    		<td style="text-align:center; border:solid 1px #d2d2d4; border-top:none; border-left:none;"></td>
    		
    		<td style="text-align:center; border:solid 1px #d2d2d4; border-top:none; border-left:none;"></td>
    		<td style="text-align:center; border:solid 1px #d2d2d4; border-top:none; border-left:none;"></td>
    		</tr>
    	<%}
    	
    	
    }
    else
    {%>
    	无
    <%}
%>
