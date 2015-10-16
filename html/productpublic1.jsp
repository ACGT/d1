<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.bean.*,java.util.*,com.d1.helper.*,org.hibernate.criterion.*,org.hibernate.*,com.d1.dbcache.core.*"%>
<%!

static String getUid(String str){
	if(str==null)str="";
	String x = "***"+StringUtils.getCnSubstring(str,0,10);
	x=x.replaceAll("调单", "ddan");
	return x;
}
/* //替换商品描述得换行
public static String repstr(String desc){
	if(desc == null) return "";
	return desc.replaceAll("\r","<br/>");
}
 */
 
 /**
	 * 根据分组对象获得此物品的所在分组的列表
	 * @param GoodsGroup - 分组对象
	 * @return List<GoodsGroupDetail>
	 */
	public static List<GoodsGroupDetail> getGroupDetail(GoodsGroup gg){
		if(gg == null) return null;
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdsgrpdtl_mstid", new Long(gg.getId())));
		
		List list = Tools.getManager(GoodsGroupDetail.class).getList(listRes, null, 0, 100);
		
		if(list == null || list.isEmpty()) return null;
		
		int size = list.size();
		
		List<GoodsGroupDetail> ggdList = new ArrayList<GoodsGroupDetail>();
		for(int i=0;i<size;i++){
			GoodsGroupDetail ggd = (GoodsGroupDetail)list.get(i);
			Product goods = ProductHelper.getById(ggd.getGdsgrpdtl_gdsid());
			if(goods == null) continue;
			
			ggdList.add(ggd);
		}
		//只有一件物品了，也就没必要显示出来了。
		if(ggdList.size() <= 1) return null;
		
		return ggdList;
	}
	
	/**
	 * 根据物品对象获得物品所在的组
	 * @param product - 物品对象
	 * @return GoodsGroup
	 */
	public static GoodsGroup getGroup(Product product){
		if(product == null) return null;
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdsgrpdtl_gdsid", product.getId()));
		
		List<Order> listorder=new ArrayList<Order>();
		listorder.add(Order.desc("id"));
			
		List list = Tools.getManager(GoodsGroupDetail.class).getList(listRes, listorder, 0, 1);
		
		if(list == null || list.isEmpty()) return null;
		
		GoodsGroupDetail gd = (GoodsGroupDetail)list.get(0);
		
		long ggId = Tools.longValue(gd.getGdsgrpdtl_mstid());
		if(ggId <= 0) return null;
		
		return (GoodsGroup)Tools.getManager(GoodsGroup.class).get(String.valueOf(ggId));
	}
 
 
//获取秒杀
public static String GetXSMS(long discountendDate , float memberprice , float oldmemberprice){
   	StringBuilder sb = new StringBuilder();
   	sb.append("<div class=\"mscontent\" id=\"mscontent\">");
   	sb.append("<img src=\"http://images.d1.com.cn/Index/images/msimg.gif\" width=\"17\" height=\"17\" />");
    sb.append("<b>&nbsp;秒杀价:<font style=\"color:#c00000; font-size:18px;\">￥"+Tools.getFormatMoney(memberprice)+"</font></b>&nbsp;&nbsp;");
    long time = discountendDate - System.currentTimeMillis();
    //System.out.print(time);
    float price = oldmemberprice - memberprice;
    sb.append("节省:￥"+Tools.getFormatMoney(price)+"&nbsp;&nbsp;");
    if(time/(3600*24*1000)<7)
    {
      sb.append("倒计时:<span class=\"countdown\" time=\""+time+"\"><em></em>天<em></em>小时<em></em>分<em></em>秒</span>");
    }
    sb.append("</div>");
    return sb.toString();
}
//获取秒杀
public static String GetXSMSNew1(long discountendDate , float memberprice , float oldmemberprice){
 	StringBuilder sb = new StringBuilder();
 	sb.append("<div class=\"mscontent\" id=\"mscontent\">");
 	sb.append("<img src=\"http://images.d1.com.cn/Index/images/msimg.gif\" width=\"17\" height=\"17\" />");
  sb.append("<b>&nbsp;秒杀价:<font style=\"color:#c00000; font-size:18px;\">￥"+Tools.getFormatMoney(memberprice)+"</font></b>&nbsp;&nbsp;");
  long time = discountendDate - System.currentTimeMillis();
  //System.out.print(time);
 // float price = oldmemberprice - memberprice;
  sb.append("原会员价:￥"+Tools.getFormatMoney(oldmemberprice)+"&nbsp;&nbsp;<br/>");
  if(time/(3600*24*1000)<7)
  {
    sb.append("剩余时间:<span class=\"countdown\" time=\""+time+"\"><em></em>天<em></em>时<em></em>分<em></em>秒</span>");
  }
  sb.append("</div>");
  return sb.toString();
}
//获取秒杀
public static String GetXSMSNew2(long discountendDate , float memberprice , float oldmemberprice){
	StringBuilder sb = new StringBuilder();
	sb.append("<div class=\"mscontent\" id=\"mscontent\">");
	sb.append("<img src=\"http://images.d1.com.cn/Index/images/msimg.gif\" width=\"17\" height=\"17\" />");
sb.append("<b>&nbsp;秒杀价:￥"+Tools.getFormatMoney(memberprice)+"</b>&nbsp;&nbsp;");
long time = discountendDate - System.currentTimeMillis();
//System.out.print(time);
// float price = oldmemberprice - memberprice;
sb.append("原会员价:￥"+Tools.getFormatMoney(oldmemberprice)+"&nbsp;&nbsp;<br/>");
if(time/(3600*24*1000)<7)
{
  sb.append("剩余时间:<span class=\"countdown\" time=\""+time+"\"><em></em>天<em></em>时<em></em>分<em></em>秒</span>");
}
sb.append("</div>");
return sb.toString();
}
//获取商品规格
private static String getGGInfo(Product product){
	if(product == null) return "";
	ProductStandard stand = ProductStandardHelper.getById(product.getGdsmst_stdid());
	if(stand == null) return "";
	StringBuilder sb = new StringBuilder();
	sb.append("<table>");
	int count = 0;
	long[] showflag = new long[]{Tools.longValue(stand.getStdmst_showflag1()),Tools.longValue(stand.getStdmst_showflag2()),Tools.longValue(stand.getStdmst_showflag3()),Tools.longValue(stand.getStdmst_showflag4()),Tools.longValue(stand.getStdmst_showflag5()),Tools.longValue(stand.getStdmst_showflag6()),Tools.longValue(stand.getStdmst_showflag7())
			,Tools.longValue(stand.getStdmst_showflag8()),Tools.longValue(stand.getStdmst_showflag9()),Tools.longValue(stand.getStdmst_showflag10()),Tools.longValue(stand.getStdmst_showflag11()),Tools.longValue(stand.getStdmst_showflag12())};
	String[] atrname = new String[]{stand.getStdmst_atrname1(),stand.getStdmst_atrname2(),stand.getStdmst_atrname3(),stand.getStdmst_atrname4(),stand.getStdmst_atrname5(),stand.getStdmst_atrname6(),stand.getStdmst_atrname7()
			,stand.getStdmst_atrname8(),stand.getStdmst_atrname9(),stand.getStdmst_atrname10(),stand.getStdmst_atrname11(),stand.getStdmst_atrname12()};
	String[] stdvalue = new String[]{product.getGdsmst_stdvalue1(),product.getGdsmst_stdvalue2(),product.getGdsmst_stdvalue3(),product.getGdsmst_stdvalue4(),product.getGdsmst_stdvalue5(),product.getGdsmst_stdvalue6(),product.getGdsmst_stdvalue7()
			,product.getGdsmst_stdvalue8(),product.getGdsmst_stdvalue9(),product.getGdsmst_stdvalue10(),product.getGdsmst_stdvalue11(),product.getGdsmst_stdvalue12()};
	for(int i=0;i<showflag.length;i++){
		//System.out.println(showflag[i]+"=============="+stdvalue[i]);
		if(showflag[i] >0 && !Tools.isNull(stdvalue[i])){
			count++;
			if (count % 2 != 0){
				sb.append("<tr><td  width=\"250\">").append(Tools.trim(atrname[i])).append("：").append(stdvalue[i]).append("</td>");
			}else{
				sb.append("<td>").append(Tools.trim(atrname[i])).append("：").append(stdvalue[i]).append("</td></tr>");
			}
		}
	}
	if (count % 2 != 0){
		sb.append("<td></td></tr>");
	}
	sb.append("</table>");
	return sb.toString();
}
//获得品牌故事。
private static String getBrandName(Product product){
	if(product == null) return "";
	String rackcode = product.getGdsmst_rackcode();
	BbsTopic bbs = BbsTopicHelper.getBrandStory(product.getId(),(!Tools.isNull(rackcode) && rackcode.length()>6 ? rackcode.substring(0,6):""),product.getGdsmst_brandname());
	if(bbs == null) return "";
	StringBuilder sb = new StringBuilder();
		
	sb.append("<div class=\"gstitle\"><img src=\"http://images.d1.com.cn/Index/images/ppgs.jpg\" />品牌故事</div>");
	sb.append("<div class=\"goods_content_list\" style=\"text-align:left; paddint-left:10px;\">");
	sb.append("<table width=\"750\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\">");
	sb.append("<tr><td valign=\"top\"><font color=\"#333333\" style='font-size:14px;line-height:25px;'>");
	
	String content = bbs.getBbsmst_content();
	if(content != null){
		content = content.replace("[uploadimg]UploadFile","[uploadimg]http://shequ.d1.com.cn/UploadFile");
		content = content.replace("[img]/smile","[img]http://shequ.d1.com.cn/smile");
	}
	sb.append(content);
	sb.append("</font> </td></tr>");
	sb.append("</table></div>");
	
	return Ubbnet.ConvertBSS(sb.toString());
}
private static String getGdspkt(Product product){
	if(product == null) return null;
	
	List list = ProductPackageHelper.getGdspktByGdsid(product.getId(),5);
	if(list == null || list.isEmpty()) return null;
	
	int size = list.size();
	
	StringBuilder sb = new StringBuilder();
	sb.append("<a name=\"zjzh2012\" id=\"zjzh2012\"></a>");
	sb.append("<div style=\" text-align:left;\"  >");
	sb.append("<div id=\"zhtab\" class=\"zh_title\">");
	for (int i = 0; i <size; i++){
		if(i == 0){
			sb.append("<a href=\"javascript:void(0)\" class=\"newa\">最佳组合").append(i+1).append("</a>");
		}else{
			sb.append("<a href=\"javascript:void(0)\">最佳组合").append(i+1).append("</a>");
		}
	}
	sb.append("</div><div class=\"clear\"></div>");
	
	sb.append("<div id=\"content_list\">");
	int flag = 0;
	
	for(int i=0;i<size;i++){
		ProductPackage pp = (ProductPackage)list.get(i);
		flag++;
		List listItem = ProductPackageItemHelper.getGdsmstByGdspid(pp.getId());
		if(listItem != null && !listItem.isEmpty()){
			int itemSize = listItem.size();
			
			int ulWidth = itemSize*124+(itemSize-1)*34;
			
			String title = Tools.clearHTML(product.getGdsmst_gdsname());
			sb.append("<div class=\"content_sub\" style=\" display:none\"><div class=\"package\"><ul style=\"width:").append(ulWidth).append("px;\">");
			sb.append("<li><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\"><img src='").append(ProductHelper.getImageTo120(product)).append("' width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
			sb.append("<span>&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#666666\">原价：￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font></span><input type=\"hidden\" name=\"gdsmp").append(flag).append("\" id=\"gdsmp").append(flag).append("\" value='").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("'></li>");
			
			float memberprice = 0;
            float pktprice = 0;
            
            for(int j=0;j<itemSize;j++){
            	ProductPackageItem ppi = (ProductPackageItem)listItem.get(j);
            	Product goods = ProductHelper.getById(ppi.getGdspktdtl_gdsid());
            	if(goods != null && !product.getId().equals(goods.getId())){
            		title = Tools.clearHTML(goods.getGdsmst_gdsname());
            		sb.append("<li class=\"otherli\" ><img src=\"http://images.d1.com.cn/Index/images/zhadd.jpg\" width=\"16\" height=\"16\" style=\"border:none;\" /></li>");
            		sb.append("<li><a href=\"").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\"><img src=\"").append(ProductHelper.getImageTo120(goods)).append("\" width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(goods.getGdsmst_gdsname())).append("\" /></a>");
            		sb.append("<a href=\"").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
            		sb.append("<span><input type='checkbox' checked='checked' onClick=\"selectInit1('").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("','").append(Tools.getFormatMoney(Tools.floatValue(goods.getGdsmst_memberprice()) - Tools.floatValue(ppi.getGdspktdtl_savemoney()))).append("',this.checked,").append(flag).append(")\" name='pktsel").append(flag).append("' value='").append(goods.getId()).append("'>");
            		sb.append("&nbsp;&nbsp;<font color=\"#666666\" >原价：￥").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("</font></span>");
            		sb.append("</li>");
            	}
            	memberprice += Tools.floatValue(goods.getGdsmst_memberprice());
            	pktprice += Tools.floatValue(ppi.getGdspktdtl_savemoney());
            }
            
            sb.append("</ul></div>");
            sb.append("<table class=\"zh_content\"><tr><td><span>组合购买</span>");
            sb.append("<strike>总价：￥<font id=\"memberP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice)).append("</font></strike><br/>");
            sb.append("组合价：<font color=\"#bc0000\" face=\"微软雅黑\"><b>￥<font id=\"pktP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice - pktprice)).append("</font></b></font><br/>");
            sb.append("共优惠：￥<font id=\"cheap").append(flag).append("\">").append(Tools.getFormatMoney(pktprice)).append("</font><br/><br/>");
            sb.append("<img src=\"http://images.d1.com.cn/Index/images/ljgmgzh.jpg\" code=\"").append(pp.getId()).append("\" onclick=\"check_pkt('").append(flag).append("','").append(product.getId()).append("',this)\" class=\"addimg\" />");
            sb.append("</td></tr></table>");
            sb.append("</div>");
		}
	}
	sb.append("</div></div>");
	
	return sb.toString();
}



//获取新图
private static ArrayList<GdsCutImg> getByGdsid(String gdsid){
	ArrayList<GdsCutImg> list=new ArrayList<GdsCutImg>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_gdsid", gdsid));
	List<BaseEntity> b_list = Tools.getManager(GdsCutImg.class).getList(clist, null, 0,1);
	if(b_list==null || b_list.size()==0) return null;		
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((GdsCutImg)be);
		}
	}	
	
     return list;
}

//获取最佳搭配和组合（也就是组合）
private static String getGdscoll(Product product){
	if(product == null) return null;
	
	List list1 = ProductPackageHelper.getGdspktByGdsid(product.getId(),5);
	List list = new ArrayList<ProductPackage>();
	//if(list == null || list.isEmpty()) return null;
	
	ArrayList<Gdscoll> glist1=GdscollHelper.getGdscollByGdsid(product.getId());
	ArrayList<Gdscoll> glist=new ArrayList<Gdscoll>();
	
	//判断搭配单品是否能够显示在页面
	
	if(glist1!=null&&glist1.size()>0)
	{
		for(int i=0;i<glist1.size();i++)
		{
			Gdscoll g=glist1.get(i);
			int flag1=0;
			if(g!=null)
			{
				ArrayList<Gdscolldetail> gdetail=GdscollHelper.getGdscollBycollid(g.getId());
				if(gdetail!=null&&gdetail.size()>0)
				{
					for(Gdscolldetail gd:gdetail)
					{
						if(gd!=null&&gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
						{
							Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
							if(p!=null&&!p.getId().equals(product.getId()) && p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
							  flag1++;
							}
						}
					}
				}
				if(flag1>0)
				{
					glist.add(g);
				}
			}
		}
	}
	//判断组合单品是否可以显示
	if(list1!=null&&list1.size()>0)
	{
		for(int i=0;i<list1.size();i++)
		{
			ProductPackage g=(ProductPackage)list1.get(i);
			int flag1=0;
			if(g!=null)
			{
				List listItem = ProductPackageItemHelper.getGdsmstByGdspid(g.getId());
				if(listItem!=null&&listItem.size()>0)
				{
					for(int j=0;j<listItem.size();j++)
					{
					   ProductPackageItem gd=(ProductPackageItem)listItem.get(j);
					
						if(gd!=null&&gd.getGdspktdtl_gdsid()!=null&&gd.getGdspktdtl_gdsid().length()>0)
						{
							Product p=ProductHelper.getById(gd.getGdspktdtl_gdsid());
							if(p!=null&&!p.getId().equals(product.getId()) && p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
							  flag1++;
							}
						}
					}
				}
				if(flag1>0)
				{
					list.add(g);
				}
			}
		}
	}
	
	if((list == null || list.isEmpty())&&(glist==null||glist.isEmpty())) return null;
	StringBuilder sb = new StringBuilder();

	if(product.getGdsmst_rackcode().startsWith("02")||product.getGdsmst_rackcode().startsWith("03"))
	{
		int size = glist!=null?glist.size():0;	
		sb.append("<a name=\"zjzh2012\" id=\"zjzh2012\"></a>");
		sb.append("<div style=\" text-align:left;background:#f4f4f4\"  >");
		sb.append("<div id=\"zhtab\" class=\"zh_title\">");
		for (int i = 0; i <size&&i<7; i++){
			if(i == 0){
				sb.append("<a href=\"javascript:void(0)\" class=\"newa\">最佳组合").append(i+1).append("</a>");
			}else{
				sb.append("<a href=\"javascript:void(0)\">最佳组合").append(i+1).append("</a>");
			}
		}
		if(list!=null&&list.size()>0)
		{
			
				for(int j=0;j<list.size()&&j+glist.size()<7;j++)
				{
					sb.append("<a href=\"javascript:void(0)\">最佳组合").append(j+size+1).append("</a>");
				}
		
		}
		sb.append("</div><div class=\"clear\"></div>");
		
		sb.append("<div id=\"content_list\">");
		int flag = 0;
		//获取商品信息
		
		for(int i=0;i<glist.size()&&i<7;i++)
		{
			Gdscoll gdscoll=(Gdscoll)glist.get(i);
			if(gdscoll!=null)
			{
			flag++;
			ArrayList<Gdscolldetail> gdlist=new ArrayList<Gdscolldetail>();
			ArrayList<Gdscolldetail> gdlist1=GdscollHelper.getGdscollBycollid(gdscoll.getId());
			//获取搭配单品排序
			ArrayList<Gdscolldetail> gdlist_1=new ArrayList<Gdscolldetail>();
			ArrayList<Gdscolldetail> gdlist_2=new ArrayList<Gdscolldetail>();
			if(gdlist1!=null&&gdlist1.size()>0)
			{
				for(Gdscolldetail gdl:gdlist1)
				{
					if(gdl!=null&&gdl.getGdscolldetail_gdsflag()!=null&&gdl.getGdscolldetail_gdsflag().longValue()==1)
					{
						gdlist_1.add(gdl);
					}
					else
					{
						gdlist_2.add(gdl);
					}
				}
			}
			if(gdlist_1!=null&&gdlist1.size()>0)
			{
				gdlist.addAll(gdlist_1);
			}
			if(gdlist_2!=null&&gdlist_2.size()>0)
			{
				gdlist.addAll(gdlist_2);
			}
			if(gdlist!=null&&gdlist.size()>0)
			{
	           int count=0;
	           for(int j=0;j<gdlist.size();j++)
	           {
	        	   Gdscolldetail ppi = (Gdscolldetail)gdlist.get(j);
	           	   Product goods = ProductHelper.getById(ppi.getGdscolldetail_gdsid());
	               if(goods != null&& !goods.getId().equals(product.getId()) && goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_flag().longValue()==1&&ProductStockHelper.canBuy(goods)){
	           	       count++;
	           	   }
	               
	           }
	           count++;
	           int ulWidth = count*124+(count-1)*34+158;
	           
	           
	           
				String title = Tools.clearHTML(product.getGdsmst_gdsname());
				String imgurl1="";
			      ArrayList<GdsCutImg> gcilist1= getByGdsid(product.getId());
				  GdsCutImg gci1=new GdsCutImg();
				  if(gcilist1!=null&&gcilist1.size()>0)
				  {
					  gci1=gcilist1.get(0);
				  }
			
				  if(gci1!=null&&gci1.getGdscutimg_100()!=null&&gci1.getGdscutimg_100().length()>0)
				  {
					  imgurl1="http://images.d1.com.cn"+gci1.getGdscutimg_100();
				  }
				  else
				  {
					  imgurl1=ProductHelper.getImageTo120(product);
				  }
				sb.append("<div class=\"content_sub\" style=\" display:none\"><div class=\"package\"><ul style=\"width:").append(ulWidth).append("px;\">");
				if(gdscoll.getGdscoll_smallimgurl()!=null&&gdscoll.getGdscoll_smallimgurl().length()>0)
				{
				//获取搭配图
		        sb.append("<li style=\"position:relative;+position:static;\"><a href=\"/gdscoll/index.jsp?id=").append(gdscoll.getId()).append("\" target=\"_blank\">");
				sb.append("<img src=\"").append("http://images1.d1.com.cn").append(gdscoll.getGdscoll_smallimgurl()).append("\"/>");
				sb.append("</a></li>");
				sb.append("<li class=\"otherli\" style=\"position:relative;+position:static;\"><img src=\"http://images.d1.com.cn/images2012/index2012/equal.png\" width=\"18\" height=\"18\" style=\"border:none;\" /></li>");
				}
				sb.append("<li style=\"position:relative;+position:static;\"><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\"><img src='").append(imgurl1).append("' width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
				sb.append("<span>&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#666666\">原价：￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font></span><input type=\"hidden\" name=\"gdsmp").append(flag).append("\" id=\"gdsmp").append(flag).append("\" value='").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("'></li>");
			
				float memberprice = 0f;
				float memberprice1 = 0f;
	            float zk=0.95f;
	            for(int j=0;j<gdlist.size();j++)
	            {
	            	
	            	Gdscolldetail ppi = (Gdscolldetail)gdlist.get(j);
	            	Product goods = ProductHelper.getById(ppi.getGdscolldetail_gdsid());
	            	if(goods != null && !goods.getId().equals(product.getId())&&goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_flag().longValue()==1&&ProductStockHelper.canBuy(goods)){
	            		//获取显示图片
	            		String imgurl="";
	            		      ArrayList<GdsCutImg> gcilist= getByGdsid(goods.getId());
	            			  GdsCutImg gci=new GdsCutImg();
	            			  if(gcilist!=null&&gcilist.size()>0)
	            			  {
	            				  gci=gcilist.get(0);
	            			  }
	            		
	            			  if(gci!=null&&gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
	            			  {
	            				  imgurl="http://images.d1.com.cn"+gci.getGdscutimg_100();
	            			  }
	            			  else
	            			  {
	            				  imgurl=ProductHelper.getImageTo120(goods);
	            			  }
	            		title = Tools.clearHTML(goods.getGdsmst_gdsname());
	            		sb.append("<li class=\"otherli\" style=\"position:relative;+position:static;\"><img src=\"http://images.d1.com.cn/Index/images/zhadd.jpg\" width=\"16\" height=\"16\" style=\"border:none;\" /></li>");
	            		sb.append("<li style=\"position:relative;+position:static;\"><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\"><img src=\"").append(imgurl).append("\" width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(goods.getGdsmst_gdsname())).append("\"/></a>");
	            		sb.append("<a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
	            		sb.append("<span><input type='checkbox'");
	            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1)
	            		{
	            			sb.append(" checked='checked'");
	            		}
	            		sb.append(" onClick=\"selectInits1('").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("',this.checked,").append(flag).append(",").append("'"+goods.getId()+"'").append(")\" name='pktsel").append(flag).append("' value='").append(goods.getId()).append("'>");
	            		sb.append("&nbsp;&nbsp;<font color=\"#666666\" >原价：￥").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("</font></span>");
	            		sb.append("<span id=\"span"+goods.getId()+flag+"\" style=\"position: absolute;+position:static; +margin-top:-157px; +margin-left:1px;top:1px;left:1px;width: 100px;height: 100px;background-color: #ccc;filter: alpha(opacity=40);-moz-opacity: 0.4;opacity: 0.4;");
	            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1)
	            		{
	            			sb.append(" display:none;");
	            		}
	            		else
	            		{
	            			sb.append(" display:block;");
	            		}
	            		sb.append(" \"></span>");
	            		sb.append("</li>");   
	            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1){
		            		memberprice += Tools.getFloat((int)(goods.getGdsmst_memberprice().floatValue()*zk),2);
		            		memberprice1 += Tools.getFloat((int)(goods.getGdsmst_memberprice().floatValue()),2);
	            		}
	            		
	            	}
	            	
	            	
	            }
	            memberprice += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()*zk),2);
        		memberprice1 += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()),2);
        	
	            sb.append("</ul></div>");
	            sb.append("<table class=\"zh_content\"><tr><td><span>组合购买</span><br/>");
	            sb.append("<strike>总价：￥<font id=\"memberP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice1)).append("</font></strike><br/>");
	            sb.append("组合价：<font color=\"#bc0000\" face=\"微软雅黑\"><b>￥<font id=\"pktP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice)).append("</font></b></font><br/>");
	            sb.append("共优惠：￥<font id=\"cheap").append(flag).append("\">").append(Tools.getFormatMoney(memberprice1-memberprice)).append("</font><br/><br/>");
	            sb.append("<img src=\"http://images.d1.com.cn/Index/images/p_011.png\" code=\"").append(gdscoll.getId()).append("\" onclick=\"check_pkt2('").append(flag).append("','").append(product.getId()).append("',this)\" class=\"addimg\" />");
	            sb.append("</td></tr></table>");
	            sb.append("</div>");
			}
			}
		}
			
	            
	
		//获取组合商品信息
		if(size<7)
		{
			if(list!=null&&list.size()>0)
			{
			for(int j=0;j<list.size()&&j+size<7;j++)
			{
				
					ProductPackage pp = (ProductPackage)list.get(j);
					flag++;
					int count=0;
					List listItem = ProductPackageItemHelper.getGdsmstByGdspid(pp.getId());
					if(listItem != null && !listItem.isEmpty()){
						int itemSize = listItem.size();
						for(int i=0;i<itemSize;i++)
						{
							ProductPackageItem ppw=(ProductPackageItem)listItem.get(i);
							if(ppw!=null&&ppw.getGdspktdtl_gdsid()!=null&&ppw.getGdspktdtl_gdsid().length()>0)
							{
								Product p1=ProductHelper.getById(ppw.getGdspktdtl_gdsid());
								if(p1!=null&&ProductStockHelper.canBuy(p1))
								{
									count++;
								}
							}
						}
						
						
						int ulWidth = count*124+(itemSize-1)*34;
						String imgurl1="";
					      ArrayList<GdsCutImg> gcilist1= getByGdsid(product.getId());
						  GdsCutImg gci1=new GdsCutImg();
						  if(gcilist1!=null&&gcilist1.size()>0)
						  {
							  gci1=gcilist1.get(0);
						  }
					
						  if(gci1!=null&&gci1.getGdscutimg_100()!=null&&gci1.getGdscutimg_100().length()>0)
						  {
							  imgurl1="http://images.d1.com.cn"+gci1.getGdscutimg_100();
						  }
						  else
						  {
							  imgurl1=ProductHelper.getImageTo120(product);
						  }
						String title = Tools.clearHTML(product.getGdsmst_gdsname());
						sb.append("<div class=\"content_sub\" style=\" display:none\"><div class=\"package\"><ul style=\"width:").append(ulWidth).append("px;\">");
						sb.append("<li style=\"position:relative;+position:static;\"><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\"><img src='").append(imgurl1).append("' width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
						sb.append("<span>&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#666666\">原价：￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font></span><input type=\"hidden\" name=\"gdsmp").append(flag).append("\" id=\"gdsmp").append(flag).append("\" value='").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("'>");
						sb.append("</li>");            		
	            		
						float memberprice = 0;
			            float pktprice = 0;
			            
			            for(int k=0;k<itemSize;k++){
			            	
			            	ProductPackageItem ppi = (ProductPackageItem)listItem.get(k);
			            	Product goods = ProductHelper.getById(ppi.getGdspktdtl_gdsid());
			            	
			            	if(goods != null && !product.getId().equals(goods.getId())&&ProductStockHelper.canBuy(goods)){
			            		//获取显示图片
			            		String imgurl="";
			            		      ArrayList<GdsCutImg> gcilist= getByGdsid(goods.getId());
			            			  GdsCutImg gci=new GdsCutImg();
			            			  if(gcilist!=null&&gcilist.size()>0)
			            			  {
			            				  gci=gcilist.get(0);
			            			  }
			            		
			            			  if(gci!=null&&gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
			            			  {
			            				  imgurl="http://images.d1.com.cn"+gci.getGdscutimg_100();
			            			  }
			            			  else
			            			  {
			            				  imgurl=ProductHelper.getImageTo120(goods);
			            			  }
			            		title = Tools.clearHTML(goods.getGdsmst_gdsname());
			            		sb.append("<li class=\"otherli\" style=\"position:relative;+position:static;\"><img src=\"http://images.d1.com.cn/Index/images/zhadd.jpg\" width=\"16\" height=\"16\" style=\"border:none;\" /></li>");
			            		sb.append("<li style=\"position:relative;+position:static;\"><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\"><img src=\"").append(imgurl).append("\" width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(goods.getGdsmst_gdsname())).append("\"/></a>");
			            		sb.append("<a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
			            		sb.append("<span><input type='checkbox' checked='checked' onClick=\"selectInit1('").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("','").append(Tools.getFormatMoney(Tools.floatValue(goods.getGdsmst_memberprice()) - Tools.floatValue(ppi.getGdspktdtl_savemoney()))).append("',this.checked,").append(flag).append(",").append("'"+goods.getId()+"'").append(")\" name='pktsel").append(flag).append("' value='").append(goods.getId()).append("'>");
			            		sb.append("&nbsp;&nbsp;<font color=\"#666666\" >原价：￥").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("</font></span>");
			            		sb.append("<span id=\"span"+goods.getId()+flag+"\" style=\"position: absolute;+position:static;+margin-top:-157px; +margin-left:1px;top:1px;left:1px;width: 100px;height: 100px;background-color: #ccc;filter: alpha(opacity=40);-moz-opacity: 0.4;opacity: 0.4;display:none; \"></span>");
			            		sb.append("</li>");
			            		memberprice += Tools.floatValue(goods.getGdsmst_memberprice());
				            	pktprice += Tools.floatValue(ppi.getGdspktdtl_savemoney());
			            	}
			            	if(product.getId().equals(goods.getId()))
			            	{
			            		memberprice += Tools.floatValue(goods.getGdsmst_memberprice());
				            	pktprice += Tools.floatValue(ppi.getGdspktdtl_savemoney());
			            	}
			            	
			            }
			            
			            sb.append("</ul></div>");
			            sb.append("<table class=\"zh_content\"><tr><td><span>组合购买</span>");
			            sb.append("<strike>总价：￥<font id=\"memberP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice)).append("</font></strike><br/>");
			            sb.append("组合价：<font color=\"#bc0000\" face=\"微软雅黑\"><b>￥<font id=\"pktP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice - pktprice)).append("</font></b></font><br/>");
			            sb.append("共优惠：￥<font id=\"cheap").append(flag).append("\">").append(Tools.getFormatMoney(pktprice)).append("</font><br/><br/>");
			            sb.append("<img src=\"http://images.d1.com.cn/Index/images/ljgmgzh.jpg\" code=\"").append(pp.getId()).append("\" onclick=\"check_pkt('").append(flag).append("','").append(product.getId()).append("',this)\" class=\"addimg\" />");
			            sb.append("</td></tr></table>");
			            sb.append("</div>");
					}
				
			}
			}
		}
		
		
		sb.append("</div></div>");
		
	}
	else
	{
		int size = list!=null?list.size():0;	
		sb.append("<a name=\"zjzh2012\" id=\"zjzh2012\"></a>");
		sb.append("<div style=\" text-align:left;\"  >");
		sb.append("<div id=\"zhtab\" class=\"zh_title\">");
		for (int i = 0; i <size&&i<7; i++){
			if(i == 0){
				sb.append("<a href=\"javascript:void(0)\" class=\"newa\">最佳组合").append(i+1).append("</a>");
			}else{
				sb.append("<a href=\"javascript:void(0)\">最佳组合").append(i+1).append("</a>");
			}
		}
		if(glist!=null&&glist.size()>0)
		{
			
				for(int j=0;j<glist.size()&&j+size<7;j++)
				{
					sb.append("<a href=\"javascript:void(0)\">最佳组合").append(j+size+1).append("</a>");
				}
		
		}
		sb.append("</div><div class=\"clear\"></div>");
		
		sb.append("<div id=\"content_list\">");
		int flag = 0;
		//获取商品信息
		
		//获取组合商品信息
		
			if(list!=null&&list.size()>0)
			{
				for(int j=0;j<size&&j<7;j++)
				{
					
						ProductPackage pp = (ProductPackage)list.get(j);
						flag++;
						int count=0;
						List listItem = ProductPackageItemHelper.getGdsmstByGdspid(pp.getId());
						if(listItem != null && !listItem.isEmpty()){
							int itemSize = listItem.size();
							for(int i=0;i<itemSize;i++)
							{
								ProductPackageItem ppw=(ProductPackageItem)listItem.get(i);
								if(ppw!=null&&ppw.getGdspktdtl_gdsid()!=null&&ppw.getGdspktdtl_gdsid().length()>0)
								{
									Product p1=ProductHelper.getById(ppw.getGdspktdtl_gdsid());
									if(p1!=null&&ProductStockHelper.canBuy(p1))
									{
										count++;
									}
								}
							}
							
							
							int ulWidth = count*124+(itemSize-1)*34;
							String imgurl1="";
						      ArrayList<GdsCutImg> gcilist1= getByGdsid(product.getId());
							  GdsCutImg gci1=new GdsCutImg();
							  if(gcilist1!=null&&gcilist1.size()>0)
							  {
								  gci1=gcilist1.get(0);
							  }
						
							  if(gci1!=null&&gci1.getGdscutimg_100()!=null&&gci1.getGdscutimg_100().length()>0)
							  {
								  imgurl1="http://images.d1.com.cn"+gci1.getGdscutimg_100();
							  }
							  else
							  {
								  imgurl1=ProductHelper.getImageTo120(product);
							  }
							String title = Tools.clearHTML(product.getGdsmst_gdsname());
							sb.append("<div class=\"content_sub\" style=\" display:none\"><div class=\"package\"><ul style=\"width:").append(ulWidth).append("px;\">");
							sb.append("<li style=\"position:relative;+position:static;\"><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\"><img src='").append(imgurl1).append("' width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
							sb.append("</li>");
							float memberprice = 0;
				            float pktprice = 0;
				            
				            for(int k=0;k<itemSize;k++){
				            	
				            	ProductPackageItem ppi = (ProductPackageItem)listItem.get(k);
				            	Product goods = ProductHelper.getById(ppi.getGdspktdtl_gdsid());
				            	
				            	if(goods != null && !product.getId().equals(goods.getId())&&ProductStockHelper.canBuy(goods)){
				            		//获取显示图片
				            		String imgurl="";
				            		      ArrayList<GdsCutImg> gcilist= getByGdsid(goods.getId());
				            			  GdsCutImg gci=new GdsCutImg();
				            			  if(gcilist!=null&&gcilist.size()>0)
				            			  {
				            				  gci=gcilist.get(0);
				            			  }
				            		
				            			  if(gci!=null&&gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
				            			  {
				            				  imgurl="http://images.d1.com.cn"+gci.getGdscutimg_100();
				            			  }
				            			  else
				            			  {
				            				  imgurl=ProductHelper.getImageTo120(goods);
				            			  }
				            		title = Tools.clearHTML(goods.getGdsmst_gdsname());
				            		sb.append("<li class=\"otherli\" style=\"position:relative;+position:static;\"><img src=\"http://images.d1.com.cn/Index/images/zhadd.jpg\" width=\"16\" height=\"16\" style=\"border:none;\" /></li>");
				            		sb.append("<li style=\"position:relative;+position:static;\"><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\"><img src=\"").append(imgurl).append("\" width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(goods.getGdsmst_gdsname())).append("\"/></a>");
				            		sb.append("<a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
				            		sb.append("<span><input type='checkbox' checked='checked' onClick=\"selectInit1('").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("','").append(Tools.getFormatMoney(Tools.floatValue(goods.getGdsmst_memberprice()) - Tools.floatValue(ppi.getGdspktdtl_savemoney()))).append("',this.checked,").append(flag).append(",").append("'"+goods.getId()+"'").append(")\" name='pktsel").append(flag).append("' value='").append(goods.getId()).append("'>");
				            		sb.append("&nbsp;&nbsp;<font color=\"#666666\" >原价：￥").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("</font></span>");
				            		sb.append("<span id=\"span"+goods.getId()+flag+"\" style=\"position: absolute;+position:static;+margin-top:-157px;+margin-left:1px;top:1px;left:1px;width: 100px;height: 100px;background-color: #ccc;filter: alpha(opacity=40);-moz-opacity: 0.4;opacity: 0.4;display:none; \"></span>");
				            		
				            		sb.append("</li>");
				            		memberprice += Tools.floatValue(goods.getGdsmst_memberprice());
					            	pktprice += Tools.floatValue(ppi.getGdspktdtl_savemoney());
				            	}
				            	if(product.getId().equals(goods.getId()))
				            	{
				            		memberprice += Tools.floatValue(goods.getGdsmst_memberprice());
					            	pktprice += Tools.floatValue(ppi.getGdspktdtl_savemoney());
				            	}
				            	
				            }
				            
				            sb.append("</ul></div>");
				            sb.append("<table class=\"zh_content\"><tr><td><span>组合购买</span>");
				            sb.append("<strike>总价：￥<font id=\"memberP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice)).append("</font></strike><br/>");
				            sb.append("组合价：<font color=\"#bc0000\" face=\"微软雅黑\"><b>￥<font id=\"pktP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice - pktprice)).append("</font></b></font><br/>");
				            sb.append("共优惠：￥<font id=\"cheap").append(flag).append("\">").append(Tools.getFormatMoney(pktprice)).append("</font><br/><br/>");
				            sb.append("<img src=\"http://images.d1.com.cn/Index/images/ljgmgzh.jpg\" code=\"").append(pp.getId()).append("\" onclick=\"check_pkt('").append(flag).append("','").append(product.getId()).append("',this)\" class=\"addimg\" />");
				            sb.append("</td></tr></table>");
				            sb.append("</div>");
						}
					
				}
			}
		
		if(size<7)
		{			
		    if(glist!=null&&glist.size()>0)
		    {
		    	
			for(int i=0;i<glist.size()&&i+size<7;i++)
			{
				Gdscoll gdscoll=(Gdscoll)glist.get(i);
				if(gdscoll!=null)
				{
				flag++;
				ArrayList<Gdscolldetail> gdlist=new ArrayList<Gdscolldetail>();
				ArrayList<Gdscolldetail> gdlist1=GdscollHelper.getGdscollBycollid(gdscoll.getId());
				//获取搭配单品排序
				ArrayList<Gdscolldetail> gdlist_1=new ArrayList<Gdscolldetail>();
				ArrayList<Gdscolldetail> gdlist_2=new ArrayList<Gdscolldetail>();
				if(gdlist1!=null&&gdlist1.size()>0)
				{
					for(Gdscolldetail gdl:gdlist1)
					{
						if(gdl!=null&&gdl.getGdscolldetail_gdsflag()!=null&&gdl.getGdscolldetail_gdsflag().longValue()==1)
						{
							gdlist_1.add(gdl);
						}
						else
						{
							gdlist_2.add(gdl);
						}
					}
				}
				if(gdlist_1!=null&&gdlist1.size()>0)
				{
					gdlist.addAll(gdlist_1);
				}
				if(gdlist_2!=null&&gdlist_2.size()>0)
				{
					gdlist.addAll(gdlist_2);
				}
				if(gdlist!=null&&gdlist.size()>0)
				{
		           int count=0;
		           for(int j=0;j<gdlist.size();j++)
		           {
		        	   Gdscolldetail ppi = (Gdscolldetail)gdlist.get(j);
		           	   Product goods = ProductHelper.getById(ppi.getGdscolldetail_gdsid());
		               if(goods != null && !goods.getId().equals(product.getId())&& goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_flag().longValue()==1&&ProductStockHelper.canBuy(goods)){
		           	       count++;
		           	   }
		               
		           }
		           count++;
		           int ulWidth = count*124+(count-1)*34+158;
					String title = Tools.clearHTML(product.getGdsmst_gdsname());
					String imgurl1="";
				      ArrayList<GdsCutImg> gcilist1= getByGdsid(product.getId());
					  GdsCutImg gci1=new GdsCutImg();
					  if(gcilist1!=null&&gcilist1.size()>0)
					  {
						  gci1=gcilist1.get(0);
					  }
				
					  if(gci1!=null&&gci1.getGdscutimg_100()!=null&&gci1.getGdscutimg_100().length()>0)
					  {
						  imgurl1="http://images.d1.com.cn"+gci1.getGdscutimg_100();
					  }
					  else
					  {
						  imgurl1=ProductHelper.getImageTo120(product);
					  }
					sb.append("<div class=\"content_sub\" style=\" display:none\"><div class=\"package\"><ul style=\"width:").append(ulWidth).append("px;\">");
					if(gdscoll.getGdscoll_smallimgurl()!=null&&gdscoll.getGdscoll_smallimgurl().length()>0)
					{
					//获取搭配图
			        sb.append("<li style=\"position:relative;+position:static;\"><a href=\"/gdscoll/index.jsp?id=").append(gdscoll.getId()).append("\" target=\"_blank\">");
					sb.append("<img src=\"").append("http://images1.d1.com.cn").append(gdscoll.getGdscoll_smallimgurl()).append("\"/>");
					sb.append("</a></li>");
					sb.append("<li class=\"otherli\" style=\"position:relative;+position:static;\"><img src=\"http://images.d1.com.cn/images2012/index2012/equal.png\" width=\"18\" height=\"18\" style=\"border:none;\" /></li>");
					}
					sb.append("<li style=\"position:relative;+position:static;\"><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\"><img src='").append(imgurl1).append("' width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
					sb.append("<span>&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#666666\">原价：￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font></span><input type=\"hidden\" name=\"gdsmp").append(flag).append("\" id=\"gdsmp").append(flag).append("\" value='").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("'>");
					sb.append("</li>");
					
					float memberprice = 0f;
					float memberprice1 = 0f;
		            float zk=0.95f;
		            for(int j=0;j<gdlist.size();j++)
		            {
		            	
		            	Gdscolldetail ppi = (Gdscolldetail)gdlist.get(j);
		            	Product goods = ProductHelper.getById(ppi.getGdscolldetail_gdsid());
		            	if(goods != null && !goods.getId().equals(product.getId())&&goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_flag().longValue()==1&&ProductStockHelper.canBuy(goods)){
		            		//获取显示图片
		            		String imgurl="";
		            		      ArrayList<GdsCutImg> gcilist= getByGdsid(goods.getId());
		            			  GdsCutImg gci=new GdsCutImg();
		            			  if(gcilist!=null&&gcilist.size()>0)
		            			  {
		            				  gci=gcilist.get(0);
		            			  }
		            		
		            			  if(gci!=null&&gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
		            			  {
		            				  imgurl="http://images.d1.com.cn"+gci.getGdscutimg_100();
		            			  }
		            			  else
		            			  {
		            				  imgurl=ProductHelper.getImageTo120(goods);
		            			  }
		            		title = Tools.clearHTML(goods.getGdsmst_gdsname());
		            		sb.append("<li class=\"otherli\" style=\"position:relative;+position:static;\"><img src=\"http://images.d1.com.cn/Index/images/zhadd.jpg\" width=\"16\" height=\"16\" style=\"border:none;\" /></li>");
		            		sb.append("<li style=\"position:relative;+position:static;\"><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\"><img src=\"").append(imgurl).append("\" width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(goods.getGdsmst_gdsname())).append("\"/></a>");
		            		sb.append("<a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
		            		sb.append("<span><input type='checkbox'");
		            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1)
		            		{
		            			sb.append(" checked='checked'");
		            		}
		            		sb.append(" onClick=\"selectInits1('").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("',this.checked,").append(flag).append(",").append("'"+goods.getId()+"'").append(")\" name='pktsel").append(flag).append("' value='").append(goods.getId()).append("'>");
		            		sb.append("&nbsp;&nbsp;<font color=\"#666666\" >原价：￥").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("</font></span>");
		            		sb.append("<span id=\"span"+goods.getId()+flag+"\" style=\"position: absolute;+position:static;+margin-top:-157px; +margin-left:1px;top:1px;left:1px;width: 100px;height: 100px;background-color: #ccc;filter: alpha(opacity=40);-moz-opacity: 0.4;opacity: 0.4;");
		            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1)
		            		{
		            			sb.append(" display:none;");
		            		}
		            		else
		            		{
		            			sb.append(" display:block;");
		            		}
		            		sb.append(" \"></span>");
		            		sb.append("</li>");
		            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1)
		            		{
			            		memberprice += Tools.getFloat((int)(goods.getGdsmst_memberprice().floatValue()*zk),2);
			            		memberprice1 += Tools.getFloat((int)(goods.getGdsmst_memberprice().floatValue()),2);
		            		}
		            	}
		            	
		            	
		            }
		            memberprice += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()*zk),2);
            		memberprice1 += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()),2);
            						
		            sb.append("</ul></div>");
		            sb.append("<table class=\"zh_content\"><tr><td><span>组合购买</span><br/>");
		            sb.append("<strike>总价：￥<font id=\"memberP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice1)).append("</font></strike><br/>");
		            sb.append("组合价：<font color=\"#bc0000\" face=\"微软雅黑\"><b>￥<font id=\"pktP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice)).append("</font></b></font><br/>");
		            sb.append("共优惠：￥<font id=\"cheap").append(flag).append("\">").append(Tools.getFormatMoney(memberprice1-memberprice)).append("</font><br/><br/>");
		            sb.append("<img src=\"http://images.d1.com.cn/Index/images/ljgmgzh.jpg\" code=\"").append(gdscoll.getId()).append("\" onclick=\"check_pkt2('").append(flag).append("','").append(product.getId()).append("',this)\" class=\"addimg\" />");
		            sb.append("</td></tr></table>");
		            sb.append("</div>");
				}
				}
			}
				
	            
		    }
	
		}

		
		sb.append("</div></div>");
	}

	return sb.toString();
}
//获取商品详情搭配图的背景图
private static String getBg(String brandid)
{
    if(Tools.isNull(brandid)) return "";
    if(brandid.equals("987")) return "http://images.d1.com.cn/images2012/index2012/feelmind-bg.jpg";
    else if(brandid.equals("1690")) return "http://images.d1.com.cn/images2012/index2012/aleeishe-bg.jpg";
    else if(brandid.equals("1969")) return "http://images.d1.com.cn/images2012/index2012/sheromo-bg.jpg";
    else return "http://images.d1.com.cn/images2012/index2012/aleeishe-bg.jpg";
}


//获取该商品的前十个商品
private ArrayList<Product> getTenProduct(String productid)
{
	if(Tools.isNull(productid)||!Tools.isMath(productid))
	{
		return null;
	}
   	ArrayList<Product> result=new ArrayList<Product>();
   	
   	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
   	clist.add(Restrictions.lt("id",productid));
   	clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
   	clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
   	List<Order> olist=new ArrayList<Order>();
   	olist.add(Order.desc("id"));
   	
   	List<BaseEntity> blist=Tools.getManager(Product.class).getList(clist, olist,0,10);
   	if(blist!=null)
   	{
   		for(BaseEntity b:blist)
   		{
   			if(b!=null)
   			{
   				result.add((Product)b);
   			}
   		}
   	}
   	return result;
}

//获取某一个商品相关的商品列表
	private static ArrayList<Product> GetAboutProduct(String gdsid)
	{
		if(Tools.isNull(gdsid)||!Tools.isNumber(gdsid)) return null;
		ArrayList<Product> result=new ArrayList<Product>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsid",gdsid));
		List<BaseEntity> blist=Tools.getManager(Gdssalesabout.class).getList(clist,null,0, 100);
	
		if(blist!=null&&blist.size()>0)
		{
			
			for(BaseEntity be:blist)
			{
				if(be!=null)
				{
					Gdssalesabout ga=(Gdssalesabout)be;
					if(ga!=null&&ga.getGdsidabout()!=null&&ga.getGdsidabout().length()>0)
					{
						
						Product p=ProductHelper.getById(ga.getGdsidabout());
						if(p!=null&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0)
						{
							result.add(p);
						}
					}
				}
			}
		}
		return result;
	}
	static Size getsize(String sizeid){
		Size size =(Size) Tools.getManager(Size.class).get(sizeid);
		 return size;
	}
	static ArrayList<Sku> getsku(String gdsid){
		ArrayList<Sku> list=new ArrayList<Sku>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("skumst_gdsid", gdsid));
		List<BaseEntity> b_list = Tools.getManager(Sku.class).getList(clist, null, 0,10);
		if(b_list==null || b_list.size()==0) return null;		
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Sku)be);
			}
		}	
		
	   return list;
	}
	
	private static String getGdscoll0719(Product product){
		if(product == null) return null;
		
		List list1 = ProductPackageHelper.getGdspktByGdsid(product.getId(),7);
		List list = new ArrayList<ProductPackage>();
		//if(list == null || list.isEmpty()) return null;
		
		ArrayList<Gdscoll> glist1=GdscollHelper.getGdscollByGdsid(product.getId());
		ArrayList<Gdscoll> glist=new ArrayList<Gdscoll>();
		
		//判断搭配单品是否能够显示在页面
		
		if(glist1!=null&&glist1.size()>0)
		{
			for(int i=0;i<glist1.size();i++)
			{
				Gdscoll g=glist1.get(i);
				int flag1=0;
				if(g!=null)
				{
					ArrayList<Gdscolldetail> gdetail=GdscollHelper.getGdscollBycollid(g.getId());
					if(gdetail!=null&&gdetail.size()>0)
					{
						for(Gdscolldetail gd:gdetail)
						{
							if(gd!=null&&gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
							{
								Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
								if(p!=null&&!p.getId().equals(product.getId()) && p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
								  flag1++;
								}
							}
						}
					}
					if(flag1>0)
					{
						glist.add(g);
					}
				}
			}
		}
		//判断组合单品是否可以显示
		if(list1!=null&&list1.size()>0)
		{
			for(int i=0;i<list1.size();i++)
			{
				ProductPackage g=(ProductPackage)list1.get(i);
				int flag1=0;
				if(g!=null)
				{
					List listItem = ProductPackageItemHelper.getGdsmstByGdspid(g.getId());
					if(listItem!=null&&listItem.size()>0)
					{
						for(int j=0;j<listItem.size();j++)
						{
						   ProductPackageItem gd=(ProductPackageItem)listItem.get(j);
						
							if(gd!=null&&gd.getGdspktdtl_gdsid()!=null&&gd.getGdspktdtl_gdsid().length()>0)
							{
								Product p=ProductHelper.getById(gd.getGdspktdtl_gdsid());
								if(p!=null&&!p.getId().equals(product.getId()) && p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
								  flag1++;
								}
							}
						}
					}
					if(flag1>0)
					{
						list.add(g);
					}
				}
			}
		}
		
		if((list == null || list.isEmpty())&&(glist==null||glist.isEmpty())) return null;
		StringBuilder sb = new StringBuilder();

		if(product.getGdsmst_rackcode().startsWith("02")||product.getGdsmst_rackcode().startsWith("03"))
		{
			int size=list!=null?list.size():0;
			sb.append("<a name=\"zjzh2012\" id=\"zjzh2012\"></a>");
			sb.append("<div style=\" text-align:left;\"  >");
			sb.append("<div id=\"zhtab\" class=\"zh_title\">");
			for (int i = 0; i <size&&i<7; i++){
				if(i == 0){
					sb.append("<a href=\"javascript:void(0)\" class=\"newa\">最佳组合").append(i+1).append("</a>");
				}else{
					sb.append("<a href=\"javascript:void(0)\">最佳组合").append(i+1).append("</a>");
				}
			}
			if(glist!=null&&glist.size()>0)
			{
				for(int j=0;j<glist.size()&&(j+size)<7;j++)
				{
					sb.append("<a href=\"javascript:void(0)\">最佳组合").append(j+size+1).append("</a>");
				}
			}
			//int size = glist!=null?glist.size():0;	
			//sb.append("<a name=\"zjzh2012\" id=\"zjzh2012\"></a>");
			//sb.append("<div style=\" text-align:left;\"  ><hr style=\" border:15px solid #fff\" />");
			//sb.append("<div id=\"zhtab\" class=\"zh_title\">");
			//for (int i = 0; i <size&&i<7; i++){
				//if(i == 0){
					//sb.append("<a href=\"javascript:void(0)\" class=\"newa\">最佳组合").append(i+1).append("</a>");
				//}else{
					//sb.append("<a href=\"javascript:void(0)\">最佳组合").append(i+1).append("</a>");
				//}
			//}
			//if(list!=null&&list.size()>0)
			//{
				
					//for(int j=0;j<list.size()&&j+glist.size()<7;j++)
					//{
						//sb.append("<a href=\"javascript:void(0)\">最佳组合").append(j+size+1).append("</a>");
					//}
			
			//}
			sb.append("</div><div class=\"clear\"></div>");
			
			sb.append("<div id=\"content_list\">");
			int flag = 0;
			
			//获取商品信息
			if(list!=null&&size>0)
			{
				for(int j=0;j<size&&j<7;j++)				
				{
						ProductPackage pp = (ProductPackage)list.get(j);
						flag++;
						int count=0;
						List listItem = ProductPackageItemHelper.getGdsmstByGdspid(pp.getId());
						if(listItem != null && !listItem.isEmpty()){
							int itemSize = listItem.size();
							for(int i=0;i<itemSize;i++)
							{
								ProductPackageItem ppw=(ProductPackageItem)listItem.get(i);
								if(ppw!=null&&ppw.getGdspktdtl_gdsid()!=null&&ppw.getGdspktdtl_gdsid().length()>0)
								{
									Product p1=ProductHelper.getById(ppw.getGdspktdtl_gdsid());
									if(p1!=null&&ProductStockHelper.canBuy(p1))
									{
										count++;
									}
								}
							}
							
							
							int ulWidth = count*124+(itemSize-1)*34;
							String imgurl1="";
						      ArrayList<GdsCutImg> gcilist1= getByGdsid(product.getId());
							  GdsCutImg gci1=new GdsCutImg();
							  if(gcilist1!=null&&gcilist1.size()>0)
							  {
								  gci1=gcilist1.get(0);
							  }
						
							  if(gci1!=null&&gci1.getGdscutimg_100()!=null&&gci1.getGdscutimg_100().length()>0)
							  {
								  imgurl1="http://images.d1.com.cn"+gci1.getGdscutimg_100();
							  }
							  else
							  {
								  imgurl1=ProductHelper.getImageTo120(product);
							  }
							String title = Tools.clearHTML(product.getGdsmst_gdsname());
							sb.append("<div class=\"content_sub\" style=\" display:none\"><div class=\"package\"><ul style=\"width:").append(ulWidth).append("px;\">");
							sb.append("<li><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\"><img src='").append(imgurl1).append("' width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
							sb.append("<span>&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#666666\">原价：￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font></span><input type=\"hidden\" name=\"gdsmp").append(flag).append("\" id=\"gdsmp").append(flag).append("\" value='").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("'></li>");
							
							float memberprice = 0;
				            float pktprice = 0;
				            
				            for(int k=0;k<itemSize;k++){
				            	
				            	ProductPackageItem ppi = (ProductPackageItem)listItem.get(k);
				            	Product goods = ProductHelper.getById(ppi.getGdspktdtl_gdsid());
				            	
				            	if(goods != null && !product.getId().equals(goods.getId())&&ProductStockHelper.canBuy(goods)){
				            		//获取显示图片
				            		String imgurl="";
				            		      ArrayList<GdsCutImg> gcilist= getByGdsid(goods.getId());
				            			  GdsCutImg gci=new GdsCutImg();
				            			  if(gcilist!=null&&gcilist.size()>0)
				            			  {
				            				  gci=gcilist.get(0);
				            			  }
				            		
				            			  if(gci!=null&&gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
				            			  {
				            				  imgurl="http://images.d1.com.cn"+gci.getGdscutimg_100();
				            			  }
				            			  else
				            			  {
				            				  imgurl=ProductHelper.getImageTo120(goods);
				            			  }
				            		title = Tools.clearHTML(goods.getGdsmst_gdsname());
				            		sb.append("<li class=\"otherli\"><img src=\"http://images.d1.com.cn/Index/images/zhadd.jpg\" width=\"16\" height=\"16\" style=\"border:none;\" /></li>");
				            		sb.append("<li><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\"><img src=\"").append(imgurl).append("\" width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a>");
				            		sb.append("<a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
				            		sb.append("<span><input type='checkbox' checked='checked' onClick=\"selectInit('").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("','").append(Tools.getFormatMoney(Tools.floatValue(goods.getGdsmst_memberprice()) - Tools.floatValue(ppi.getGdspktdtl_savemoney()))).append("',this.checked,").append(flag).append(")\" name='pktsel").append(flag).append("' value='").append(goods.getId()).append("'>");
				            		sb.append("&nbsp;&nbsp;<font color=\"#666666\" >原价：￥").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("</font></span>");
				            		sb.append("</li>");
				            		memberprice += Tools.floatValue(goods.getGdsmst_memberprice());
					            	pktprice += Tools.floatValue(ppi.getGdspktdtl_savemoney());
				            	}
				            	if(product.getId().equals(goods.getId()))
				            	{
				            		memberprice += Tools.floatValue(goods.getGdsmst_memberprice());
					            	pktprice += Tools.floatValue(ppi.getGdspktdtl_savemoney());
				            	}
				            	
				            }
				            
				            sb.append("</ul></div>");
				            sb.append("<table class=\"zh_content\"><tr><td><span>组合购买</span>");
				            sb.append("<strike>总价：￥<font id=\"memberP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice)).append("</font></strike><br/>");
				            sb.append("组合价：<font color=\"#bc0000\" face=\"微软雅黑\"><b>￥<font id=\"pktP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice - pktprice)).append("</font></b></font><br/>");
				            sb.append("共优惠：￥<font id=\"cheap").append(flag).append("\">").append(Tools.getFormatMoney(pktprice)).append("</font><br/><br/>");
				            sb.append("<img src=\"http://images.d1.com.cn/Index/images/ljgmgzh.jpg\" code=\"").append(pp.getId()).append("\" onclick=\"check_pkt('").append(flag).append("','").append(product.getId()).append("',this)\" class=\"addimg\" />");
				            sb.append("</td></tr></table>");
				            sb.append("</div>");
						}
					
				}
			}		
			//获取组合商品信息
			if(size<7)
			{
				if(list!=null&&list.size()>0)
				{
					for(int i=0;i<glist.size()&&i+size<7;i++)
					{
						Gdscoll gdscoll=(Gdscoll)glist.get(i);
						if(gdscoll!=null)
						{
						flag++;
						ArrayList<Gdscolldetail> gdlist=new ArrayList<Gdscolldetail>();
						ArrayList<Gdscolldetail> gdlist1=GdscollHelper.getGdscollBycollid(gdscoll.getId());
						//获取搭配单品排序
						ArrayList<Gdscolldetail> gdlist_1=new ArrayList<Gdscolldetail>();
						ArrayList<Gdscolldetail> gdlist_2=new ArrayList<Gdscolldetail>();
						if(gdlist1!=null&&gdlist1.size()>0)
						{
							for(Gdscolldetail gdl:gdlist1)
							{
								if(gdl!=null&&gdl.getGdscolldetail_gdsflag()!=null&&gdl.getGdscolldetail_gdsflag().longValue()==1)
								{
									gdlist_1.add(gdl);
								}
								else
								{
									gdlist_2.add(gdl);
								}
							}
						}
						if(gdlist_1!=null&&gdlist1.size()>0)
						{
							gdlist.addAll(gdlist_1);
						}
						if(gdlist_2!=null&&gdlist_2.size()>0)
						{
							gdlist.addAll(gdlist_2);
						}
						if(gdlist!=null&&gdlist.size()>0)
						{
				           int count=0;
				           for(int j=0;j<gdlist.size();j++)
				           {
				        	   Gdscolldetail ppi = (Gdscolldetail)gdlist.get(j);
				           	   Product goods = ProductHelper.getById(ppi.getGdscolldetail_gdsid());
				               if(goods != null&& !goods.getId().equals(product.getId()) && goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_flag().longValue()==1&&ProductStockHelper.canBuy(goods)){
				           	       count++;
				           	   }
				               
				           }
				           count++;
				           int ulWidth = count*124+(count-1)*34+158;
				           
				           
				           
							String title = Tools.clearHTML(product.getGdsmst_gdsname());
							String imgurl1="";
						      ArrayList<GdsCutImg> gcilist1= getByGdsid(product.getId());
							  GdsCutImg gci1=new GdsCutImg();
							  if(gcilist1!=null&&gcilist1.size()>0)
							  {
								  gci1=gcilist1.get(0);
							  }
						
							  if(gci1!=null&&gci1.getGdscutimg_100()!=null&&gci1.getGdscutimg_100().length()>0)
							  {
								  imgurl1="http://images.d1.com.cn"+gci1.getGdscutimg_100();
							  }
							  else
							  {
								  imgurl1=ProductHelper.getImageTo120(product);
							  }
							sb.append("<div class=\"content_sub\" style=\" display:none\"><div class=\"package\"><ul style=\"width:").append(ulWidth).append("px;\">");
							if(gdscoll.getGdscoll_smallimgurl()!=null&&gdscoll.getGdscoll_smallimgurl().length()>0)
							{
							//获取搭配图
					        sb.append("<li><a href=\"/gdscoll/index.jsp?id=").append(gdscoll.getId()).append("\" target=\"_blank\">");
							sb.append("<img src=\"").append("http://images1.d1.com.cn").append(gdscoll.getGdscoll_smallimgurl()).append("\"/>");
							sb.append("</a></li>");
							sb.append("<li class=\"otherli\"><img src=\"http://images.d1.com.cn/images2012/index2012/equal.png\" width=\"18\" height=\"18\" style=\"border:none;\" /></li>");
							}
							sb.append("<li><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\"><img src='").append(imgurl1).append("' width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
							sb.append("<span>&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#666666\">原价：￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font></span><input type=\"hidden\" name=\"gdsmp").append(flag).append("\" id=\"gdsmp").append(flag).append("\" value='").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("'></li>");
							
							float memberprice = 0f;
							float memberprice1 = 0f;
				            float zk=0.95f;
				            for(int j=0;j<gdlist.size();j++)
				            {
				            	
				            	Gdscolldetail ppi = (Gdscolldetail)gdlist.get(j);
				            	Product goods = ProductHelper.getById(ppi.getGdscolldetail_gdsid());
				            	if(goods != null && !goods.getId().equals(product.getId())&&goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_flag().longValue()==1&&ProductStockHelper.canBuy(goods)){
				            		//获取显示图片
				            		String imgurl="";
				            		      ArrayList<GdsCutImg> gcilist= getByGdsid(goods.getId());
				            			  GdsCutImg gci=new GdsCutImg();
				            			  if(gcilist!=null&&gcilist.size()>0)
				            			  {
				            				  gci=gcilist.get(0);
				            			  }
				            		
				            			  if(gci!=null&&gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
				            			  {
				            				  imgurl="http://images.d1.com.cn"+gci.getGdscutimg_100();
				            			  }
				            			  else
				            			  {
				            				  imgurl=ProductHelper.getImageTo120(goods);
				            			  }
				            		title = Tools.clearHTML(goods.getGdsmst_gdsname());
				            		sb.append("<li class=\"otherli\"><img src=\"http://images.d1.com.cn/Index/images/zhadd.jpg\" width=\"16\" height=\"16\" style=\"border:none;\" /></li>");
				            		sb.append("<li><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\"><img src=\"").append(imgurl).append("\" width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a>");
				            		sb.append("<a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
				            		sb.append("<span><input type='checkbox'");
				            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1)
				            		{
				            			sb.append(" checked='checked'");
				            		}
				            		sb.append(" onClick=\"selectInits('").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("',this.checked,").append(flag).append(")\" name='pktsel").append(flag).append("' value='").append(goods.getId()).append("'>");
				            		sb.append("&nbsp;&nbsp;<font color=\"#666666\" >原价：￥").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("</font></span>");
				            		sb.append("</li>");
				            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1){
					            		memberprice += Tools.getFloat((int)(goods.getGdsmst_memberprice().floatValue()*zk),2);
					            		memberprice1 += Tools.getFloat((int)(goods.getGdsmst_memberprice().floatValue()),2);
				            		}
				            		
				            	}
				            	
				            	
				            }
				            memberprice += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()*zk),2);
			        		memberprice1 += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()),2);
			        	
				            sb.append("</ul></div>");
				            sb.append("<table class=\"zh_content\"><tr><td><span>组合购买</span><br/>");
				            sb.append("<strike>总价：￥<font id=\"memberP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice1)).append("</font></strike><br/>");
				            sb.append("组合价：<font color=\"#bc0000\" face=\"微软雅黑\"><b>￥<font id=\"pktP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice)).append("</font></b></font><br/>");
				            sb.append("共优惠：￥<font id=\"cheap").append(flag).append("\">").append(Tools.getFormatMoney(memberprice1-memberprice)).append("</font><br/><br/>");
				            sb.append("<img src=\"http://images.d1.com.cn/Index/images/ljgmgzh.jpg\" code=\"").append(gdscoll.getId()).append("\" onclick=\"check_pkt2('").append(flag).append("','").append(product.getId()).append("',this)\" class=\"addimg\" />");
				            sb.append("</td></tr></table>");
				            sb.append("</div>");
						}
						}
					}
			}
			
			
			sb.append("</div></div>");
			}
		}
		else
		{
			int size = list!=null?list.size():0;	
			sb.append("<a name=\"zjzh2012\" id=\"zjzh2012\"></a>");
			sb.append("<div style=\" text-align:left;\"  >");
			sb.append("<div id=\"zhtab\" class=\"zh_title\">");
			for (int i = 0; i <size&&i<7; i++){
				if(i == 0){
					sb.append("<a href=\"javascript:void(0)\" class=\"newa\">最佳组合").append(i+1).append("</a>");
				}else{
					sb.append("<a href=\"javascript:void(0)\">最佳组合").append(i+1).append("</a>");
				}
			}
			if(glist!=null&&glist.size()>0)
			{
				
					for(int j=0;j<glist.size()&&j+size<7;j++)
					{
						sb.append("<a href=\"javascript:void(0)\">最佳组合").append(j+size+1).append("</a>");
					}
			
			}
			sb.append("</div><div class=\"clear\"></div>");
			
			sb.append("<div id=\"content_list\">");
			int flag = 0;
			//获取商品信息
			
			//获取组合商品信息
			
				if(list!=null&&list.size()>0)
				{
					for(int j=0;j<size&&j<7;j++)
					{
						
							ProductPackage pp = (ProductPackage)list.get(j);
							flag++;
							int count=0;
							List listItem = ProductPackageItemHelper.getGdsmstByGdspid(pp.getId());
							if(listItem != null && !listItem.isEmpty()){
								int itemSize = listItem.size();
								for(int i=0;i<itemSize;i++)
								{
									ProductPackageItem ppw=(ProductPackageItem)listItem.get(i);
									if(ppw!=null&&ppw.getGdspktdtl_gdsid()!=null&&ppw.getGdspktdtl_gdsid().length()>0)
									{
										Product p1=ProductHelper.getById(ppw.getGdspktdtl_gdsid());
										if(p1!=null&&ProductStockHelper.canBuy(p1))
										{
											count++;
										}
									}
								}
								
								
								int ulWidth = count*124+(itemSize-1)*34;
								String imgurl1="";
							      ArrayList<GdsCutImg> gcilist1= getByGdsid(product.getId());
								  GdsCutImg gci1=new GdsCutImg();
								  if(gcilist1!=null&&gcilist1.size()>0)
								  {
									  gci1=gcilist1.get(0);
								  }
							
								  if(gci1!=null&&gci1.getGdscutimg_100()!=null&&gci1.getGdscutimg_100().length()>0)
								  {
									  imgurl1="http://images.d1.com.cn"+gci1.getGdscutimg_100();
								  }
								  else
								  {
									  imgurl1=ProductHelper.getImageTo120(product);
								  }
								String title = Tools.clearHTML(product.getGdsmst_gdsname());
								sb.append("<div class=\"content_sub\" style=\" display:none\"><div class=\"package\"><ul style=\"width:").append(ulWidth).append("px;\">");
								sb.append("<li><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\"><img src='").append(imgurl1).append("' width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
								sb.append("<span>&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#666666\">原价：￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font></span><input type=\"hidden\" name=\"gdsmp").append(flag).append("\" id=\"gdsmp").append(flag).append("\" value='").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("'></li>");
								
								float memberprice = 0;
					            float pktprice = 0;
					            
					            for(int k=0;k<itemSize;k++){
					            	
					            	ProductPackageItem ppi = (ProductPackageItem)listItem.get(k);
					            	Product goods = ProductHelper.getById(ppi.getGdspktdtl_gdsid());
					            	
					            	if(goods != null && !product.getId().equals(goods.getId())&&ProductStockHelper.canBuy(goods)){
					            		//获取显示图片
					            		String imgurl="";
					            		      ArrayList<GdsCutImg> gcilist= getByGdsid(goods.getId());
					            			  GdsCutImg gci=new GdsCutImg();
					            			  if(gcilist!=null&&gcilist.size()>0)
					            			  {
					            				  gci=gcilist.get(0);
					            			  }
					            		
					            			  if(gci!=null&&gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
					            			  {
					            				  imgurl="http://images.d1.com.cn"+gci.getGdscutimg_100();
					            			  }
					            			  else
					            			  {
					            				  imgurl=ProductHelper.getImageTo120(goods);
					            			  }
					            		title = Tools.clearHTML(goods.getGdsmst_gdsname());
					            		sb.append("<li class=\"otherli\"><img src=\"http://images.d1.com.cn/Index/images/zhadd.jpg\" width=\"16\" height=\"16\" style=\"border:none;\" /></li>");
					            		sb.append("<li><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\"><img src=\"").append(imgurl).append("\" width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a>");
					            		sb.append("<a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
					            		sb.append("<span><input type='checkbox' checked='checked' onClick=\"selectInit('").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("','").append(Tools.getFormatMoney(Tools.floatValue(goods.getGdsmst_memberprice()) - Tools.floatValue(ppi.getGdspktdtl_savemoney()))).append("',this.checked,").append(flag).append(")\" name='pktsel").append(flag).append("' value='").append(goods.getId()).append("'>");
					            		sb.append("&nbsp;&nbsp;<font color=\"#666666\" >原价：￥").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("</font></span>");
					            		sb.append("</li>");
					            		memberprice += Tools.floatValue(goods.getGdsmst_memberprice());
						            	pktprice += Tools.floatValue(ppi.getGdspktdtl_savemoney());
					            	}
					            	if(product.getId().equals(goods.getId()))
					            	{
					            		memberprice += Tools.floatValue(goods.getGdsmst_memberprice());
						            	pktprice += Tools.floatValue(ppi.getGdspktdtl_savemoney());
					            	}
					            	
					            }
					            
					            sb.append("</ul></div>");
					            sb.append("<table class=\"zh_content\"><tr><td><span>组合购买</span>");
					            sb.append("<strike>总价：￥<font id=\"memberP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice)).append("</font></strike><br/>");
					            sb.append("组合价：<font color=\"#bc0000\" face=\"微软雅黑\"><b>￥<font id=\"pktP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice - pktprice)).append("</font></b></font><br/>");
					            sb.append("共优惠：￥<font id=\"cheap").append(flag).append("\">").append(Tools.getFormatMoney(pktprice)).append("</font><br/><br/>");
					            sb.append("<img src=\"http://images.d1.com.cn/Index/images/ljgmgzh.jpg\" code=\"").append(pp.getId()).append("\" onclick=\"check_pkt('").append(flag).append("','").append(product.getId()).append("',this)\" class=\"addimg\" />");
					            sb.append("</td></tr></table>");
					            sb.append("</div>");
							}
						
					}
				}
			
			if(size<7)
			{			
			    if(glist!=null&&glist.size()>0)
			    {
			    	
				for(int i=0;i<glist.size()&&i+size<7;i++)
				{
					Gdscoll gdscoll=(Gdscoll)glist.get(i);
					if(gdscoll!=null)
					{
					flag++;
					ArrayList<Gdscolldetail> gdlist=new ArrayList<Gdscolldetail>();
					ArrayList<Gdscolldetail> gdlist1=GdscollHelper.getGdscollBycollid(gdscoll.getId());
					//获取搭配单品排序
					ArrayList<Gdscolldetail> gdlist_1=new ArrayList<Gdscolldetail>();
					ArrayList<Gdscolldetail> gdlist_2=new ArrayList<Gdscolldetail>();
					if(gdlist1!=null&&gdlist1.size()>0)
					{
						for(Gdscolldetail gdl:gdlist1)
						{
							if(gdl!=null&&gdl.getGdscolldetail_gdsflag()!=null&&gdl.getGdscolldetail_gdsflag().longValue()==1)
							{
								gdlist_1.add(gdl);
							}
							else
							{
								gdlist_2.add(gdl);
							}
						}
					}
					if(gdlist_1!=null&&gdlist1.size()>0)
					{
						gdlist.addAll(gdlist_1);
					}
					if(gdlist_2!=null&&gdlist_2.size()>0)
					{
						gdlist.addAll(gdlist_2);
					}
					if(gdlist!=null&&gdlist.size()>0)
					{
			           int count=0;
			           for(int j=0;j<gdlist.size();j++)
			           {
			        	   Gdscolldetail ppi = (Gdscolldetail)gdlist.get(j);
			           	   Product goods = ProductHelper.getById(ppi.getGdscolldetail_gdsid());
			               if(goods != null && !goods.getId().equals(product.getId())&& goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_flag().longValue()==1&&ProductStockHelper.canBuy(goods)){
			           	       count++;
			           	   }
			               
			           }
			           count++;
			           int ulWidth = count*124+(count-1)*34+158;
						String title = Tools.clearHTML(product.getGdsmst_gdsname());
						String imgurl1="";
					      ArrayList<GdsCutImg> gcilist1= getByGdsid(product.getId());
						  GdsCutImg gci1=new GdsCutImg();
						  if(gcilist1!=null&&gcilist1.size()>0)
						  {
							  gci1=gcilist1.get(0);
						  }
					
						  if(gci1!=null&&gci1.getGdscutimg_100()!=null&&gci1.getGdscutimg_100().length()>0)
						  {
							  imgurl1="http://images.d1.com.cn"+gci1.getGdscutimg_100();
						  }
						  else
						  {
							  imgurl1=ProductHelper.getImageTo120(product);
						  }
						sb.append("<div class=\"content_sub\" style=\" display:none\"><div class=\"package\"><ul style=\"width:").append(ulWidth).append("px;\">");
						if(gdscoll.getGdscoll_smallimgurl()!=null&&gdscoll.getGdscoll_smallimgurl().length()>0)
						{
						//获取搭配图
				        sb.append("<li><a href=\"/gdscoll/index.jsp?id=").append(gdscoll.getId()).append("\" target=\"_blank\">");
						sb.append("<img src=\"").append("http://images1.d1.com.cn").append(gdscoll.getGdscoll_smallimgurl()).append("\"/>");
						sb.append("</a></li>");
						sb.append("<li class=\"otherli\"><img src=\"http://images.d1.com.cn/images2012/index2012/equal.png\" width=\"18\" height=\"18\" style=\"border:none;\" /></li>");
						}
						sb.append("<li><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\"><img src='").append(imgurl1).append("' width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
						sb.append("<span>&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#666666\">原价：￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font></span><input type=\"hidden\" name=\"gdsmp").append(flag).append("\" id=\"gdsmp").append(flag).append("\" value='").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("'></li>");
						
						float memberprice = 0f;
						float memberprice1 = 0f;
			            float zk=0.95f;
			            for(int j=0;j<gdlist.size();j++)
			            {
			            	
			            	Gdscolldetail ppi = (Gdscolldetail)gdlist.get(j);
			            	Product goods = ProductHelper.getById(ppi.getGdscolldetail_gdsid());
			            	if(goods != null && !goods.getId().equals(product.getId())&&goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_flag().longValue()==1&&ProductStockHelper.canBuy(goods)){
			            		//获取显示图片
			            		String imgurl="";
			            		      ArrayList<GdsCutImg> gcilist= getByGdsid(goods.getId());
			            			  GdsCutImg gci=new GdsCutImg();
			            			  if(gcilist!=null&&gcilist.size()>0)
			            			  {
			            				  gci=gcilist.get(0);
			            			  }
			            		
			            			  if(gci!=null&&gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
			            			  {
			            				  imgurl="http://images.d1.com.cn"+gci.getGdscutimg_100();
			            			  }
			            			  else
			            			  {
			            				  imgurl=ProductHelper.getImageTo120(goods);
			            			  }
			            		title = Tools.clearHTML(goods.getGdsmst_gdsname());
			            		sb.append("<li class=\"otherli\"><img src=\"http://images.d1.com.cn/Index/images/zhadd.jpg\" width=\"16\" height=\"16\" style=\"border:none;\" /></li>");
			            		sb.append("<li><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\"><img src=\"").append(imgurl).append("\" width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a>");
			            		sb.append("<a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
			            		sb.append("<span><input type='checkbox'");
			            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1)
			            		{
			            			sb.append(" checked='checked'");
			            		}
			            		sb.append(" onClick=\"selectInits('").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("',this.checked,").append(flag).append(")\" name='pktsel").append(flag).append("' value='").append(goods.getId()).append("'>");
			            		sb.append("&nbsp;&nbsp;<font color=\"#666666\" >原价：￥").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("</font></span>");
			            		sb.append("</li>");
			            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1)
			            		{
				            		memberprice += Tools.getFloat((int)(goods.getGdsmst_memberprice().floatValue()*zk),2);
				            		memberprice1 += Tools.getFloat((int)(goods.getGdsmst_memberprice().floatValue()),2);
			            		}
			            	}
			            	
			            	
			            }
			            memberprice += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()*zk),2);
	            		memberprice1 += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()),2);
	            						
			            sb.append("</ul></div>");
			            sb.append("<table class=\"zh_content\"><tr><td><span>组合购买</span><br/>");
			            sb.append("<strike>总价：￥<font id=\"memberP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice1)).append("</font></strike><br/>");
			            sb.append("组合价：<font color=\"#bc0000\" face=\"微软雅黑\"><b>￥<font id=\"pktP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice)).append("</font></b></font><br/>");
			            sb.append("共优惠：￥<font id=\"cheap").append(flag).append("\">").append(Tools.getFormatMoney(memberprice1-memberprice)).append("</font><br/><br/>");
			            sb.append("<img src=\"http://images.d1.com.cn/Index/images/ljgmgzh.jpg\" code=\"").append(gdscoll.getId()).append("\" onclick=\"check_pkt2('").append(flag).append("','").append(product.getId()).append("',this)\" class=\"addimg\" />");
			            sb.append("</td></tr></table>");
			            sb.append("</div>");
					}
					}
				}
					
		            
			    }
		
			}

			
			sb.append("</div></div>");
		}

		return sb.toString();
	}

static String getsizeinfo(Product p){
Size s=getsize(p.getGdsmst_sizeid().toString());
StringBuilder sb=new StringBuilder();
if(s!=null){
	
	sb.append("<table width=\"770\"  border=\"0\" cellpadding=\"0\" cellspacing=\"0\" >");
	sb.append("<tr>");
	sb.append("<td colspan=\"2\" height=\"61\"  style=\"border:none;\">");
	sb.append("<img src=\"http://images.d1.com.cn/images2012/product/sizeimg_01-1.jpg\" style=\"border:none;\" />");
	sb.append("</td>");
	sb.append("</tr>");
	sb.append("<tr>");
	sb.append("<td width=\"200\"  align=\"left\" style=\"border:none;\">");
	sb.append("<img src=\""+s.getSizemst_photo().trim()+"\" style=\"border:none;\" width=\"200\"/>");
	sb.append("</td>");
	sb.append("<td valign=\"middle\" align=\"left\" style=\"border:none;\">");
	sb.append("<table  border=\"1\" align=\"center\" cellpadding=\"0\" class=\"sizetab\" cellspacing=\"0\" style=\"border:none; border: 3px double #cccccc;width:99%; overflow:visible;\">");
	sb.append("<tr>");
	int colcount=0;
	int colcount1=0;
	int colcount2=0;
	int colcount3=0;
	int colcount4=0;
	int colcount5=0;
	int colcount6=0;
	int colcount7=0;
	int colcount8=0;
	boolean bl1=false;boolean bl2=false;boolean bl3=false;boolean bl4=false;boolean bl5=false;boolean bl6=false;boolean bl7=false;boolean bl8=false;
	ArrayList<Sku> skulist=getsku(p.getId());
	int totalcol=1;
	if(skulist!=null && skulist.size()>0){
	
		for(Sku sku:skulist){
			if(!Tools.isNull(sku.getSkumst_sizevalue1()) && !"--".equals(sku.getSkumst_sizevalue1())){
				bl1=true;
				totalcol++;
			}
			if(!Tools.isNull(sku.getSkumst_sizevalue2()) && !"--".equals(sku.getSkumst_sizevalue2())){
				bl2=true;totalcol++;
			}
			if(!Tools.isNull(sku.getSkumst_sizevalue3()) && !"--".equals(sku.getSkumst_sizevalue3())){
				bl3=true;totalcol++;
			}
			if(!Tools.isNull(sku.getSkumst_sizevalue4()) && !"--".equals(sku.getSkumst_sizevalue4())){
				bl4=true;totalcol++;
			}
			if(!Tools.isNull(sku.getSkumst_sizevalue5()) && !"--".equals(sku.getSkumst_sizevalue5())){
				bl5=true;totalcol++;
			}
			if(!Tools.isNull(sku.getSkumst_sizevalue6()) && !"--".equals(sku.getSkumst_sizevalue6())){
				bl6=true;totalcol++;
			}
			if(!Tools.isNull(sku.getSkumst_sizevalue7()) && !"--".equals(sku.getSkumst_sizevalue7())){
				bl7=true;totalcol++;
			}
			if(!Tools.isNull(sku.getSkumst_sizevalue8()) && !"--".equals(sku.getSkumst_sizevalue8())){
				bl8=true;totalcol++;
			}
		}
	}
	String colwidth=(100/totalcol)+"%";
	if(!Tools.isNull(p.getGdsmst_skuname1())){
		colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\"  bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;\"><strong>");
			sb.append("尺码");
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size1()) && bl1){
			colcount1++;colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size1());
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size2())&& bl2){
			colcount2++;colcount++;
			sb.append("<td width=\"").append(colwidth).append("\" align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size2());
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size3())&& bl3){
			colcount3++;colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size3());
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size4())&& bl4){
			colcount4++;colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\"  bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size4());
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size5())&& bl5){
			colcount5++;colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size5());
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size6())&& bl6){
			colcount6++;colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size6());
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size7())&& bl7){
			colcount7++;colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size7());
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size8())&& bl8){
			colcount8++;colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size8());
			sb.append("</strong></td>");
		}
		sb.append("</tr>");
	if(skulist!=null && skulist.size()>0){
		for(Sku sku:skulist){
			sb.append("<tr>");
			if(!Tools.isNull(sku.getSkumst_sku1())){
				sb.append("<td align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\">");
				sb.append(sku.getSkumst_sku1());
				sb.append("</td>");
			}
			if(colcount1>0){
				sb.append("<td  align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
				sb.append(Tools.isNull(sku.getSkumst_sizevalue1())? "-":sku.getSkumst_sizevalue1());
				sb.append("</strong></td>");
			}
			if(colcount2>0){
				sb.append("<td   align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
				sb.append(Tools.isNull(sku.getSkumst_sizevalue2())? "-":sku.getSkumst_sizevalue2());
				sb.append("</strong></td>");
			}
			if(colcount3>0){
				sb.append("<td   align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
				sb.append(Tools.isNull(sku.getSkumst_sizevalue3())? "-":sku.getSkumst_sizevalue3());
				sb.append("</strong></td>");
			}
			if(colcount4>0){
				sb.append("<td  align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
				sb.append(Tools.isNull(sku.getSkumst_sizevalue4())? "-":sku.getSkumst_sizevalue4());
				sb.append("</strong></td>");
			}
			if(colcount5>0){
				sb.append("<td  align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
				sb.append(Tools.isNull(sku.getSkumst_sizevalue5())? "-":sku.getSkumst_sizevalue5());
				sb.append("</strong></td>");
			}
			if(colcount6>0){
				sb.append("<td   align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
				sb.append(Tools.isNull(sku.getSkumst_sizevalue6())? "-":sku.getSkumst_sizevalue6());
				sb.append("</strong></td>");
			}
			if(colcount7>0){
				sb.append("<td  align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
				sb.append(Tools.isNull(sku.getSkumst_sizevalue7())? "-":sku.getSkumst_sizevalue7());
				sb.append("</strong></td>");
			}
			if(colcount8>0){
				sb.append("<td   align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc; \"><strong>");
				sb.append(Tools.isNull(sku.getSkumst_sizevalue8())? "-":sku.getSkumst_sizevalue8());
				sb.append("</strong></td>");
			}
			sb.append("</tr>");
		}
	}
	sb.append("<tr><td height=\"23\" colspan=\""+colcount+"\" bgcolor=\"#FFFFFF\" align=\"left\" >").append(s.getSizemst_memo()).append("</td></tr>");
sb.append("</table></td></tr></table>");

}
return sb.toString();
}

/**
 * 20120730满足就是色polo的评论得分
 * 
 */

public static double getCommentLevel1(String productId){
	if(Tools.isNull(productId)) return 0;
	if(productId.equals("03000117"))
	{
		int score_5 = CommentHelper.getCommentLevelCount(productId , 5)+CommentHelper.getCommentLevelCount("03000096" , 5);
		int score_4 = CommentHelper.getCommentLevelCount(productId , 4)+CommentHelper.getCommentLevelCount("03000096" , 4);
		int score_3 = CommentHelper.getCommentLevelCount(productId , 3)+CommentHelper.getCommentLevelCount("03000096" , 3);
		int score_2 = CommentHelper.getCommentLevelCount(productId , 2)+CommentHelper.getCommentLevelCount("03000096" , 2);
		int score_1 = CommentHelper.getCommentLevelCount(productId , 1)+CommentHelper.getCommentLevelCount("03000096" , 1);
		
		score_5 += CommentHelper.getCacheCommentLevelCount(productId , 5)+CommentHelper.getCacheCommentLevelCount("03000096" , 5);
		score_4 += CommentHelper.getCacheCommentLevelCount(productId , 4)+CommentHelper.getCacheCommentLevelCount("03000096" , 4);
		score_3 += CommentHelper.getCacheCommentLevelCount(productId , 3)+CommentHelper.getCacheCommentLevelCount("03000096" , 3);
		score_2 += CommentHelper.getCacheCommentLevelCount(productId , 2)+CommentHelper.getCacheCommentLevelCount("03000096" , 2);
		score_1 += CommentHelper.getCacheCommentLevelCount(productId , 1)+CommentHelper.getCacheCommentLevelCount("03000096" , 1);
		return (score_5 + score_4 * 0.8 + score_3 * 0.6 + score_2 * 0.4 + score_1 * 0.2) / (score_1 + score_2 + score_3 + score_4 + score_5);

	}
	else if(productId.equals("03000118"))
	{
		int score_5 = CommentHelper.getCommentLevelCount(productId , 5)+CommentHelper.getCommentLevelCount("03000095" , 5);
		int score_4 = CommentHelper.getCommentLevelCount(productId , 4)+CommentHelper.getCommentLevelCount("03000095" , 4);
		int score_3 = CommentHelper.getCommentLevelCount(productId , 3)+CommentHelper.getCommentLevelCount("03000095" , 3);
		int score_2 = CommentHelper.getCommentLevelCount(productId , 2)+CommentHelper.getCommentLevelCount("03000095" , 2);
		int score_1 = CommentHelper.getCommentLevelCount(productId , 1)+CommentHelper.getCommentLevelCount("03000095" , 1);
		
		score_5 += CommentHelper.getCacheCommentLevelCount(productId , 5)+CommentHelper.getCacheCommentLevelCount("03000095" , 5);
		score_4 += CommentHelper.getCacheCommentLevelCount(productId , 4)+CommentHelper.getCacheCommentLevelCount("03000095" , 4);
		score_3 += CommentHelper.getCacheCommentLevelCount(productId , 3)+CommentHelper.getCacheCommentLevelCount("03000095" , 3);
		score_2 += CommentHelper.getCacheCommentLevelCount(productId , 2)+CommentHelper.getCacheCommentLevelCount("03000095" , 2);
		score_1 += CommentHelper.getCacheCommentLevelCount(productId , 1)+CommentHelper.getCacheCommentLevelCount("03000095" , 1);
		return (score_5 + score_4 * 0.8 + score_3 * 0.6 + score_2 * 0.4 + score_1 * 0.2) / (score_1 + score_2 + score_3 + score_4 + score_5);

	}
	else if(productId.equals("03000119"))
	{
		int score_5 = CommentHelper.getCommentLevelCount(productId , 5)+CommentHelper.getCommentLevelCount("03000094" , 5);
		int score_4 = CommentHelper.getCommentLevelCount(productId , 4)+CommentHelper.getCommentLevelCount("03000094" , 4);
		int score_3 = CommentHelper.getCommentLevelCount(productId , 3)+CommentHelper.getCommentLevelCount("03000094" , 3);
		int score_2 = CommentHelper.getCommentLevelCount(productId , 2)+CommentHelper.getCommentLevelCount("03000094" , 2);
		int score_1 = CommentHelper.getCommentLevelCount(productId , 1)+CommentHelper.getCommentLevelCount("03000094" , 1);
		
		score_5 += CommentHelper.getCacheCommentLevelCount(productId , 5)+CommentHelper.getCacheCommentLevelCount("03000094" , 5);
		score_4 += CommentHelper.getCacheCommentLevelCount(productId , 4)+CommentHelper.getCacheCommentLevelCount("03000094" , 4);
		score_3 += CommentHelper.getCacheCommentLevelCount(productId , 3)+CommentHelper.getCacheCommentLevelCount("03000094" , 3);
		score_2 += CommentHelper.getCacheCommentLevelCount(productId , 2)+CommentHelper.getCacheCommentLevelCount("03000094" , 2);
		score_1 += CommentHelper.getCacheCommentLevelCount(productId , 1)+CommentHelper.getCacheCommentLevelCount("03000094" , 1);
		return (score_5 + score_4 * 0.8 + score_3 * 0.6 + score_2 * 0.4 + score_1 * 0.2) / (score_1 + score_2 + score_3 + score_4 + score_5);

	}
	else if(productId.equals("03000120"))
	{
		int score_5 = CommentHelper.getCommentLevelCount(productId , 5)+CommentHelper.getCommentLevelCount("03000093" , 5);
		int score_4 = CommentHelper.getCommentLevelCount(productId , 4)+CommentHelper.getCommentLevelCount("03000093" , 4);
		int score_3 = CommentHelper.getCommentLevelCount(productId , 3)+CommentHelper.getCommentLevelCount("03000093" , 3);
		int score_2 = CommentHelper.getCommentLevelCount(productId , 2)+CommentHelper.getCommentLevelCount("03000093" , 2);
		int score_1 = CommentHelper.getCommentLevelCount(productId , 1)+CommentHelper.getCommentLevelCount("03000093" , 1);
		
		score_5 += CommentHelper.getCacheCommentLevelCount(productId , 5)+CommentHelper.getCacheCommentLevelCount("03000093" , 5);
		score_4 += CommentHelper.getCacheCommentLevelCount(productId , 4)+CommentHelper.getCacheCommentLevelCount("03000093" , 4);
		score_3 += CommentHelper.getCacheCommentLevelCount(productId , 3)+CommentHelper.getCacheCommentLevelCount("03000093" , 3);
		score_2 += CommentHelper.getCacheCommentLevelCount(productId , 2)+CommentHelper.getCacheCommentLevelCount("03000093" , 2);
		score_1 += CommentHelper.getCacheCommentLevelCount(productId , 1)+CommentHelper.getCacheCommentLevelCount("03000093" , 1);
		return (score_5 + score_4 * 0.8 + score_3 * 0.6 + score_2 * 0.4 + score_1 * 0.2) / (score_1 + score_2 + score_3 + score_4 + score_5);

	}
	else if(productId.equals("03000121"))
	{
		int score_5 = CommentHelper.getCommentLevelCount(productId , 5)+CommentHelper.getCommentLevelCount("03000092" , 5);
		int score_4 = CommentHelper.getCommentLevelCount(productId , 4)+CommentHelper.getCommentLevelCount("03000092" , 4);
		int score_3 = CommentHelper.getCommentLevelCount(productId , 3)+CommentHelper.getCommentLevelCount("03000092" , 3);
		int score_2 = CommentHelper.getCommentLevelCount(productId , 2)+CommentHelper.getCommentLevelCount("03000092" , 2);
		int score_1 = CommentHelper.getCommentLevelCount(productId , 1)+CommentHelper.getCommentLevelCount("03000092" , 1);
		
		score_5 += CommentHelper.getCacheCommentLevelCount(productId , 5)+CommentHelper.getCacheCommentLevelCount("03000092" , 5);
		score_4 += CommentHelper.getCacheCommentLevelCount(productId , 4)+CommentHelper.getCacheCommentLevelCount("03000092" , 4);
		score_3 += CommentHelper.getCacheCommentLevelCount(productId , 3)+CommentHelper.getCacheCommentLevelCount("03000092" , 3);
		score_2 += CommentHelper.getCacheCommentLevelCount(productId , 2)+CommentHelper.getCacheCommentLevelCount("03000092" , 2);
		score_1 += CommentHelper.getCacheCommentLevelCount(productId , 1)+CommentHelper.getCacheCommentLevelCount("03000092" , 1);
		return (score_5 + score_4 * 0.8 + score_3 * 0.6 + score_2 * 0.4 + score_1 * 0.2) / (score_1 + score_2 + score_3 + score_4 + score_5);

	}
	else if(productId.equals("03000122"))
	{
		int score_5 = CommentHelper.getCommentLevelCount(productId , 5)+CommentHelper.getCommentLevelCount("03000091" , 5);
		int score_4 = CommentHelper.getCommentLevelCount(productId , 4)+CommentHelper.getCommentLevelCount("03000091" , 4);
		int score_3 = CommentHelper.getCommentLevelCount(productId , 3)+CommentHelper.getCommentLevelCount("03000091" , 3);
		int score_2 = CommentHelper.getCommentLevelCount(productId , 2)+CommentHelper.getCommentLevelCount("03000091" , 2);
		int score_1 = CommentHelper.getCommentLevelCount(productId , 1)+CommentHelper.getCommentLevelCount("03000091" , 1);
		
		score_5 += CommentHelper.getCacheCommentLevelCount(productId , 5)+CommentHelper.getCacheCommentLevelCount("03000091" , 5);
		score_4 += CommentHelper.getCacheCommentLevelCount(productId , 4)+CommentHelper.getCacheCommentLevelCount("03000091" , 4);
		score_3 += CommentHelper.getCacheCommentLevelCount(productId , 3)+CommentHelper.getCacheCommentLevelCount("03000091" , 3);
		score_2 += CommentHelper.getCacheCommentLevelCount(productId , 2)+CommentHelper.getCacheCommentLevelCount("03000091" , 2);
		score_1 += CommentHelper.getCacheCommentLevelCount(productId , 1)+CommentHelper.getCacheCommentLevelCount("03000091" , 1);
		return (score_5 + score_4 * 0.8 + score_3 * 0.6 + score_2 * 0.4 + score_1 * 0.2) / (score_1 + score_2 + score_3 + score_4 + score_5);

	}
	else if(productId.equals("03000123"))
	{
		int score_5 = CommentHelper.getCommentLevelCount(productId , 5)+CommentHelper.getCommentLevelCount("03000090" , 5);
		int score_4 = CommentHelper.getCommentLevelCount(productId , 4)+CommentHelper.getCommentLevelCount("03000090" , 4);
		int score_3 = CommentHelper.getCommentLevelCount(productId , 3)+CommentHelper.getCommentLevelCount("03000090" , 3);
		int score_2 = CommentHelper.getCommentLevelCount(productId , 2)+CommentHelper.getCommentLevelCount("03000090" , 2);
		int score_1 = CommentHelper.getCommentLevelCount(productId , 1)+CommentHelper.getCommentLevelCount("03000090" , 1);
		
		score_5 += CommentHelper.getCacheCommentLevelCount(productId , 5)+CommentHelper.getCacheCommentLevelCount("03000090" , 5);
		score_4 += CommentHelper.getCacheCommentLevelCount(productId , 4)+CommentHelper.getCacheCommentLevelCount("03000090" , 4);
		score_3 += CommentHelper.getCacheCommentLevelCount(productId , 3)+CommentHelper.getCacheCommentLevelCount("03000090" , 3);
		score_2 += CommentHelper.getCacheCommentLevelCount(productId , 2)+CommentHelper.getCacheCommentLevelCount("03000090" , 2);
		score_1 += CommentHelper.getCacheCommentLevelCount(productId , 1)+CommentHelper.getCacheCommentLevelCount("03000090" , 1);
		return (score_5 + score_4 * 0.8 + score_3 * 0.6 + score_2 * 0.4 + score_1 * 0.2) / (score_1 + score_2 + score_3 + score_4 + score_5);

	}
	else if(productId.equals("03000124"))
	{
		int score_5 = CommentHelper.getCommentLevelCount(productId , 5)+CommentHelper.getCommentLevelCount("03000089" , 5);
		int score_4 = CommentHelper.getCommentLevelCount(productId , 4)+CommentHelper.getCommentLevelCount("03000089" , 4);
		int score_3 = CommentHelper.getCommentLevelCount(productId , 3)+CommentHelper.getCommentLevelCount("03000089" , 3);
		int score_2 = CommentHelper.getCommentLevelCount(productId , 2)+CommentHelper.getCommentLevelCount("03000089" , 2);
		int score_1 = CommentHelper.getCommentLevelCount(productId , 1)+CommentHelper.getCommentLevelCount("03000089" , 1);
		
		score_5 += CommentHelper.getCacheCommentLevelCount(productId , 5)+CommentHelper.getCacheCommentLevelCount("03000089" , 5);
		score_4 += CommentHelper.getCacheCommentLevelCount(productId , 4)+CommentHelper.getCacheCommentLevelCount("03000089" , 4);
		score_3 += CommentHelper.getCacheCommentLevelCount(productId , 3)+CommentHelper.getCacheCommentLevelCount("03000089" , 3);
		score_2 += CommentHelper.getCacheCommentLevelCount(productId , 2)+CommentHelper.getCacheCommentLevelCount("03000089" , 2);
		score_1 += CommentHelper.getCacheCommentLevelCount(productId , 1)+CommentHelper.getCacheCommentLevelCount("03000089" , 1);
		return (score_5 + score_4 * 0.8 + score_3 * 0.6 + score_2 * 0.4 + score_1 * 0.2) / (score_1 + score_2 + score_3 + score_4 + score_5);

	}
	else if(productId.equals("03000125"))
	{
		int score_5 = CommentHelper.getCommentLevelCount(productId , 5)+CommentHelper.getCommentLevelCount("03000088" , 5);
		int score_4 = CommentHelper.getCommentLevelCount(productId , 4)+CommentHelper.getCommentLevelCount("03000088" , 4);
		int score_3 = CommentHelper.getCommentLevelCount(productId , 3)+CommentHelper.getCommentLevelCount("03000088" , 3);
		int score_2 = CommentHelper.getCommentLevelCount(productId , 2)+CommentHelper.getCommentLevelCount("03000088" , 2);
		int score_1 = CommentHelper.getCommentLevelCount(productId , 1)+CommentHelper.getCommentLevelCount("03000088" , 1);
		
		score_5 += CommentHelper.getCacheCommentLevelCount(productId , 5)+CommentHelper.getCacheCommentLevelCount("03000088" , 5);
		score_4 += CommentHelper.getCacheCommentLevelCount(productId , 4)+CommentHelper.getCacheCommentLevelCount("03000088" , 4);
		score_3 += CommentHelper.getCacheCommentLevelCount(productId , 3)+CommentHelper.getCacheCommentLevelCount("03000088" , 3);
		score_2 += CommentHelper.getCacheCommentLevelCount(productId , 2)+CommentHelper.getCacheCommentLevelCount("03000088" , 2);
		score_1 += CommentHelper.getCacheCommentLevelCount(productId , 1)+CommentHelper.getCacheCommentLevelCount("03000088" , 1);
		return (score_5 + score_4 * 0.8 + score_3 * 0.6 + score_2 * 0.4 + score_1 * 0.2) / (score_1 + score_2 + score_3 + score_4 + score_5);

	}
	else
	{
		int score_5 =CommentHelper.getCommentLevelCount(productId , 5);
		int score_4 = CommentHelper.getCommentLevelCount(productId , 4);
		int score_3 = CommentHelper.getCommentLevelCount(productId , 3);
		int score_2 = CommentHelper.getCommentLevelCount(productId , 2);
		int score_1 = CommentHelper.getCommentLevelCount(productId , 1);
		
		score_5 += CommentHelper.getCacheCommentLevelCount(productId , 5);
		score_4 += CommentHelper.getCacheCommentLevelCount(productId , 4);
		score_3 += CommentHelper.getCacheCommentLevelCount(productId , 3);
		score_2 += CommentHelper.getCacheCommentLevelCount(productId , 2);
		score_1 += CommentHelper.getCacheCommentLevelCount(productId , 1);
		return (score_5 + score_4 * 0.8 + score_3 * 0.6 + score_2 * 0.4 + score_1 * 0.2) / (score_1 + score_2 + score_3 + score_4 + score_5);
		}
}


/**
 * 商品评价星级显示
 * @param productId - 物品ID
 * @return int
 */
public static int getLevelView1(String productId){
    double score= getCommentLevel1(productId);
    int avgscore=0;
    try{
    avgscore=(int)(score * 10);
    }catch(Exception ex)
    {
    	avgscore=0;
    }
    return avgscore;
}




//获取最佳搭配和组合（也就是组合）
private static String getGdscoll1(Product product){
	if(product == null) return null;
	
	List list1 = ProductPackageHelper.getGdspktByGdsid(product.getId(),5);
	List list = new ArrayList<ProductPackage>();
	//if(list == null || list.isEmpty()) return null;
	
	ArrayList<Gdscoll> glist1=GdscollHelper.getGdscollByGdsid(product.getId());
	ArrayList<Gdscoll> glist=new ArrayList<Gdscoll>();
	
	//判断搭配单品是否能够显示在页面
	
	if(glist1!=null&&glist1.size()>0)
	{
		for(int i=0;i<glist1.size();i++)
		{
			Gdscoll g=glist1.get(i);
			int flag1=0;
			if(g!=null)
			{
				ArrayList<Gdscolldetail> gdetail=GdscollHelper.getGdscollBycollid(g.getId());
				if(gdetail!=null&&gdetail.size()>0)
				{
					for(Gdscolldetail gd:gdetail)
					{
						if(gd!=null&&gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
						{
							Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
							if(p!=null&&!p.getId().equals(product.getId()) && p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
							  flag1++;
							}
						}
					}
				}
				if(flag1>0)
				{
					glist.add(g);
				}
			}
		}
	}
	//判断组合单品是否可以显示
	if(list1!=null&&list1.size()>0)
	{
		for(int i=0;i<list1.size();i++)
		{
			ProductPackage g=(ProductPackage)list1.get(i);
			int flag1=0;
			if(g!=null)
			{
				List listItem = ProductPackageItemHelper.getGdsmstByGdspid(g.getId());
				if(listItem!=null&&listItem.size()>0)
				{
					for(int j=0;j<listItem.size();j++)
					{
					   ProductPackageItem gd=(ProductPackageItem)listItem.get(j);
					
						if(gd!=null&&gd.getGdspktdtl_gdsid()!=null&&gd.getGdspktdtl_gdsid().length()>0)
						{
							Product p=ProductHelper.getById(gd.getGdspktdtl_gdsid());
							if(p!=null&&!p.getId().equals(product.getId()) && p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
							  flag1++;
							}
						}
					}
				}
				if(flag1>0)
				{
					list.add(g);
				}
			}
		}
	}
	
	if((list == null || list.isEmpty())&&(glist==null||glist.isEmpty())) return null;
	StringBuilder sb = new StringBuilder();

	if(product.getGdsmst_rackcode().startsWith("02")||product.getGdsmst_rackcode().startsWith("03"))
	{
		int size = glist!=null?glist.size():0;	
		sb.append("<a name=\"zjzh2012\" id=\"zjzh2012\"></a>");
		sb.append("<div style=\" text-align:left;\"  >");
		sb.append("<div id=\"zhtab\" class=\"zh_title\">");
		for (int i = 0; i <size&&i<6; i++){
			if(i == 0){
				sb.append("<a href=\"javascript:void(0)\" class=\"newa\">最佳组合").append(i+1).append("</a>");
			}else{
				sb.append("<a href=\"javascript:void(0)\">最佳组合").append(i+1).append("</a>");
			}
		}
		if(list!=null&&list.size()>0)
		{
			
				for(int j=0;j<list.size()&&j+glist.size()<6;j++)
				{
					sb.append("<a href=\"javascript:void(0)\">最佳组合").append(j+size+1).append("</a>");
				}
		
		}
		sb.append("<a href=\"/gdscoll/freegdscoll.jsp?id="+product.getId()+"\" target=\"_blank\">我要搭配</a>");
		sb.append("</div><div class=\"clear\"></div>");
		
		sb.append("<div id=\"content_list\">");
		int flag = 0;
		//获取商品信息
		
		for(int i=0;i<glist.size()&&i<6;i++)
		{
			Gdscoll gdscoll=(Gdscoll)glist.get(i);
			if(gdscoll!=null)
			{
			flag++;
			ArrayList<Gdscolldetail> gdlist=new ArrayList<Gdscolldetail>();
			ArrayList<Gdscolldetail> gdlist1=GdscollHelper.getGdscollBycollid(gdscoll.getId());
			//获取搭配单品排序
			ArrayList<Gdscolldetail> gdlist_1=new ArrayList<Gdscolldetail>();
			ArrayList<Gdscolldetail> gdlist_2=new ArrayList<Gdscolldetail>();
			if(gdlist1!=null&&gdlist1.size()>0)
			{
				for(Gdscolldetail gdl:gdlist1)
				{
					if(gdl!=null&&gdl.getGdscolldetail_gdsflag()!=null&&gdl.getGdscolldetail_gdsflag().longValue()==1)
					{
						gdlist_1.add(gdl);
					}
					else
					{
						gdlist_2.add(gdl);
					}
				}
			}
			if(gdlist_1!=null&&gdlist1.size()>0)
			{
				gdlist.addAll(gdlist_1);
			}
			if(gdlist_2!=null&&gdlist_2.size()>0)
			{
				gdlist.addAll(gdlist_2);
			}
			if(gdlist!=null&&gdlist.size()>0)
			{
	           int count=0;
	           for(int j=0;j<gdlist.size();j++)
	           {
	        	   Gdscolldetail ppi = (Gdscolldetail)gdlist.get(j);
	           	   Product goods = ProductHelper.getById(ppi.getGdscolldetail_gdsid());
	               if(goods != null&& !goods.getId().equals(product.getId()) && goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_flag().longValue()==1&&ProductStockHelper.canBuy(goods)){
	           	       count++;
	           	   }
	               
	           }
	           count++;
	           int ulWidth = count*124+(count-1)*34+158;
	           
	           
	           
				String title = Tools.clearHTML(product.getGdsmst_gdsname());
				String imgurl1="";
			      ArrayList<GdsCutImg> gcilist1= getByGdsid(product.getId());
				  GdsCutImg gci1=new GdsCutImg();
				  if(gcilist1!=null&&gcilist1.size()>0)
				  {
					  gci1=gcilist1.get(0);
				  }
			
				  if(gci1!=null&&gci1.getGdscutimg_100()!=null&&gci1.getGdscutimg_100().length()>0)
				  {
					  imgurl1="http://images.d1.com.cn"+gci1.getGdscutimg_100();
				  }
				  else
				  {
					  imgurl1=ProductHelper.getImageTo120(product);
				  }
				sb.append("<div class=\"content_sub\" style=\" display:none\"><div class=\"package\"><ul style=\"width:").append(ulWidth).append("px;\">");
				if(gdscoll.getGdscoll_smallimgurl()!=null&&gdscoll.getGdscoll_smallimgurl().length()>0)
				{
				//获取搭配图
		        sb.append("<li><a href=\"/gdscoll/index.jsp?id=").append(gdscoll.getId()).append("\" target=\"_blank\">");
				sb.append("<img src=\"").append("http://images1.d1.com.cn").append(gdscoll.getGdscoll_smallimgurl()).append("\"/>");
				sb.append("</a></li>");
				sb.append("<li class=\"otherli\"><img src=\"http://images.d1.com.cn/images2012/index2012/equal.png\" width=\"18\" height=\"18\" style=\"border:none;\" /></li>");
				}
				sb.append("<li><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\"><img src='").append(imgurl1).append("' width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
				sb.append("<span>&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#666666\">原价：￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font></span><input type=\"hidden\" name=\"gdsmp").append(flag).append("\" id=\"gdsmp").append(flag).append("\" value='").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("'></li>");
				
				float memberprice = 0f;
				float memberprice1 = 0f;
	            float zk=0.95f;
	            for(int j=0;j<gdlist.size();j++)
	            {
	            	
	            	Gdscolldetail ppi = (Gdscolldetail)gdlist.get(j);
	            	Product goods = ProductHelper.getById(ppi.getGdscolldetail_gdsid());
	            	if(goods != null && !goods.getId().equals(product.getId())&&goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_flag().longValue()==1&&ProductStockHelper.canBuy(goods)){
	            		//获取显示图片
	            		String imgurl="";
	            		      ArrayList<GdsCutImg> gcilist= getByGdsid(goods.getId());
	            			  GdsCutImg gci=new GdsCutImg();
	            			  if(gcilist!=null&&gcilist.size()>0)
	            			  {
	            				  gci=gcilist.get(0);
	            			  }
	            		
	            			  if(gci!=null&&gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
	            			  {
	            				  imgurl="http://images.d1.com.cn"+gci.getGdscutimg_100();
	            			  }
	            			  else
	            			  {
	            				  imgurl=ProductHelper.getImageTo120(goods);
	            			  }
	            		title = Tools.clearHTML(goods.getGdsmst_gdsname());
	            		sb.append("<li class=\"otherli\"><img src=\"http://images.d1.com.cn/Index/images/zhadd.jpg\" width=\"16\" height=\"16\" style=\"border:none;\" /></li>");
	            		sb.append("<li><a href=\"").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\"><img src=\"").append(imgurl).append("\" width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a>");
	            		sb.append("<a href=\"").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
	            		sb.append("<span><input type='checkbox'");
	            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1)
	            		{
	            			sb.append(" checked='checked'");
	            		}
	            		sb.append(" onClick=\"selectInits('").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("',this.checked,").append(flag).append(")\" name='pktsel").append(flag).append("' value='").append(goods.getId()).append("'>");
	            		sb.append("&nbsp;&nbsp;<font color=\"#666666\" >原价：￥").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("</font></span>");
	            		sb.append("</li>");
	            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1){
		            		memberprice += Tools.getFloat((int)(goods.getGdsmst_memberprice().floatValue()*zk),2);
		            		memberprice1 += Tools.getFloat((int)(goods.getGdsmst_memberprice().floatValue()),2);
	            		}
	            		
	            	}
	            	
	            	
	            }
	            memberprice += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()*zk),2);
    		memberprice1 += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()),2);
    	
	            sb.append("</ul></div>");
	            sb.append("<table class=\"zh_content\"><tr><td><span>组合购买</span><br/>");
	            sb.append("<strike>总价：￥<font id=\"memberP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice1)).append("</font></strike><br/>");
	            sb.append("组合价：<font color=\"#bc0000\" face=\"微软雅黑\"><b>￥<font id=\"pktP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice)).append("</font></b></font><br/>");
	            sb.append("共优惠：￥<font id=\"cheap").append(flag).append("\">").append(Tools.getFormatMoney(memberprice1-memberprice)).append("</font><br/><br/>");
	            sb.append("<img src=\"http://images.d1.com.cn/Index/images/ljgmgzh.jpg\" code=\"").append(gdscoll.getId()).append("\" onclick=\"check_pkt2('").append(flag).append("','").append(product.getId()).append("',this)\" class=\"addimg\" />");
	            sb.append("</td></tr></table>");
	            sb.append("</div>");
			}
			}
		}
			
	            
	
		//获取组合商品信息
		if(size<6)
		{
			if(list!=null&&list.size()>0)
			{
			for(int j=0;j<list.size()&&j+size<6;j++)
			{
				
					ProductPackage pp = (ProductPackage)list.get(j);
					flag++;
					int count=0;
					List listItem = ProductPackageItemHelper.getGdsmstByGdspid(pp.getId());
					if(listItem != null && !listItem.isEmpty()){
						int itemSize = listItem.size();
						for(int i=0;i<itemSize;i++)
						{
							ProductPackageItem ppw=(ProductPackageItem)listItem.get(i);
							if(ppw!=null&&ppw.getGdspktdtl_gdsid()!=null&&ppw.getGdspktdtl_gdsid().length()>0)
							{
								Product p1=ProductHelper.getById(ppw.getGdspktdtl_gdsid());
								if(p1!=null&&ProductStockHelper.canBuy(p1))
								{
									count++;
								}
							}
						}
						
						
						int ulWidth = count*124+(itemSize-1)*34;
						String imgurl1="";
					      ArrayList<GdsCutImg> gcilist1= getByGdsid(product.getId());
						  GdsCutImg gci1=new GdsCutImg();
						  if(gcilist1!=null&&gcilist1.size()>0)
						  {
							  gci1=gcilist1.get(0);
						  }
					
						  if(gci1!=null&&gci1.getGdscutimg_100()!=null&&gci1.getGdscutimg_100().length()>0)
						  {
							  imgurl1="http://images.d1.com.cn"+gci1.getGdscutimg_100();
						  }
						  else
						  {
							  imgurl1=ProductHelper.getImageTo120(product);
						  }
						String title = Tools.clearHTML(product.getGdsmst_gdsname());
						sb.append("<div class=\"content_sub\" style=\" display:none\"><div class=\"package\"><ul style=\"width:").append(ulWidth).append("px;\">");
						sb.append("<li><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\"><img src='").append(imgurl1).append("' width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
						sb.append("<span>&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#666666\">原价：￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font></span><input type=\"hidden\" name=\"gdsmp").append(flag).append("\" id=\"gdsmp").append(flag).append("\" value='").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("'></li>");
						
						float memberprice = 0;
			            float pktprice = 0;
			            
			            for(int k=0;k<itemSize;k++){
			            	
			            	ProductPackageItem ppi = (ProductPackageItem)listItem.get(k);
			            	Product goods = ProductHelper.getById(ppi.getGdspktdtl_gdsid());
			            	
			            	if(goods != null && !product.getId().equals(goods.getId())&&ProductStockHelper.canBuy(goods)){
			            		//获取显示图片
			            		String imgurl="";
			            		      ArrayList<GdsCutImg> gcilist= getByGdsid(goods.getId());
			            			  GdsCutImg gci=new GdsCutImg();
			            			  if(gcilist!=null&&gcilist.size()>0)
			            			  {
			            				  gci=gcilist.get(0);
			            			  }
			            		
			            			  if(gci!=null&&gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
			            			  {
			            				  imgurl="http://images.d1.com.cn"+gci.getGdscutimg_100();
			            			  }
			            			  else
			            			  {
			            				  imgurl=ProductHelper.getImageTo120(goods);
			            			  }
			            		title = Tools.clearHTML(goods.getGdsmst_gdsname());
			            		sb.append("<li class=\"otherli\"><img src=\"http://images.d1.com.cn/Index/images/zhadd.jpg\" width=\"16\" height=\"16\" style=\"border:none;\" /></li>");
			            		sb.append("<li><a href=\"").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\"><img src=\"").append(imgurl).append("\" width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a>");
			            		sb.append("<a href=\"").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
			            		sb.append("<span><input type='checkbox' checked='checked' onClick=\"selectInit('").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("','").append(Tools.getFormatMoney(Tools.floatValue(goods.getGdsmst_memberprice()) - Tools.floatValue(ppi.getGdspktdtl_savemoney()))).append("',this.checked,").append(flag).append(")\" name='pktsel").append(flag).append("' value='").append(goods.getId()).append("'>");
			            		sb.append("&nbsp;&nbsp;<font color=\"#666666\" >原价：￥").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("</font></span>");
			            		sb.append("</li>");
			            		memberprice += Tools.floatValue(goods.getGdsmst_memberprice());
				            	pktprice += Tools.floatValue(ppi.getGdspktdtl_savemoney());
			            	}
			            	if(product.getId().equals(goods.getId()))
			            	{
			            		memberprice += Tools.floatValue(goods.getGdsmst_memberprice());
				            	pktprice += Tools.floatValue(ppi.getGdspktdtl_savemoney());
			            	}
			            	
			            }
			            
			            sb.append("</ul></div>");
			            sb.append("<table class=\"zh_content\"><tr><td><span>组合购买</span>");
			            sb.append("<strike>总价：￥<font id=\"memberP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice)).append("</font></strike><br/>");
			            sb.append("组合价：<font color=\"#bc0000\" face=\"微软雅黑\"><b>￥<font id=\"pktP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice - pktprice)).append("</font></b></font><br/>");
			            sb.append("共优惠：￥<font id=\"cheap").append(flag).append("\">").append(Tools.getFormatMoney(pktprice)).append("</font><br/><br/>");
			            sb.append("<img src=\"http://images.d1.com.cn/Index/images/ljgmgzh.jpg\" code=\"").append(pp.getId()).append("\" onclick=\"check_pkt('").append(flag).append("','").append(product.getId()).append("',this)\" class=\"addimg\" />");
			            sb.append("</td></tr></table>");
			            sb.append("</div>");
					}
				
			}
			}
		}
		
		
		sb.append("</div></div>");
		
	}
	else
	{
		int size = list!=null?list.size():0;	
		sb.append("<a name=\"zjzh2012\" id=\"zjzh2012\"></a>");
		sb.append("<div style=\" text-align:left;\"  >");
		sb.append("<div id=\"zhtab\" class=\"zh_title\">");
		for (int i = 0; i <size&&i<6; i++){
			if(i == 0){
				sb.append("<a href=\"javascript:void(0)\" class=\"newa\">最佳组合").append(i+1).append("</a>");
			}else{
				sb.append("<a href=\"javascript:void(0)\">最佳组合").append(i+1).append("</a>");
			}
		}
		if(glist!=null&&glist.size()>0)
		{
			
				for(int j=0;j<glist.size()&&j+size<6;j++)
				{
					sb.append("<a href=\"javascript:void(0)\">最佳组合").append(j+size+1).append("</a>");
				}
		
		}
		sb.append("<a href=\"/gdscoll/freegdscoll.jsp?id="+product.getId()+"\">我要搭配</a>");
		sb.append("</div><div class=\"clear\"></div>");
		
		sb.append("<div id=\"content_list\">");
		int flag = 0;
		//获取商品信息
		
		//获取组合商品信息
		
			if(list!=null&&list.size()>0)
			{
				for(int j=0;j<size&&j<6;j++)
				{
					
						ProductPackage pp = (ProductPackage)list.get(j);
						flag++;
						int count=0;
						List listItem = ProductPackageItemHelper.getGdsmstByGdspid(pp.getId());
						if(listItem != null && !listItem.isEmpty()){
							int itemSize = listItem.size();
							for(int i=0;i<itemSize;i++)
							{
								ProductPackageItem ppw=(ProductPackageItem)listItem.get(i);
								if(ppw!=null&&ppw.getGdspktdtl_gdsid()!=null&&ppw.getGdspktdtl_gdsid().length()>0)
								{
									Product p1=ProductHelper.getById(ppw.getGdspktdtl_gdsid());
									if(p1!=null&&ProductStockHelper.canBuy(p1))
									{
										count++;
									}
								}
							}
							
							
							int ulWidth = count*124+(itemSize-1)*34;
							String imgurl1="";
						      ArrayList<GdsCutImg> gcilist1= getByGdsid(product.getId());
							  GdsCutImg gci1=new GdsCutImg();
							  if(gcilist1!=null&&gcilist1.size()>0)
							  {
								  gci1=gcilist1.get(0);
							  }
						
							  if(gci1!=null&&gci1.getGdscutimg_100()!=null&&gci1.getGdscutimg_100().length()>0)
							  {
								  imgurl1="http://images.d1.com.cn"+gci1.getGdscutimg_100();
							  }
							  else
							  {
								  imgurl1=ProductHelper.getImageTo120(product);
							  }
							String title = Tools.clearHTML(product.getGdsmst_gdsname());
							sb.append("<div class=\"content_sub\" style=\" display:none\"><div class=\"package\"><ul style=\"width:").append(ulWidth).append("px;\">");
							sb.append("<li><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\"><img src='").append(imgurl1).append("' width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
							sb.append("<span>&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#666666\">原价：￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font></span><input type=\"hidden\" name=\"gdsmp").append(flag).append("\" id=\"gdsmp").append(flag).append("\" value='").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("'></li>");
							
							float memberprice = 0;
				            float pktprice = 0;
				            
				            for(int k=0;k<itemSize;k++){
				            	
				            	ProductPackageItem ppi = (ProductPackageItem)listItem.get(k);
				            	Product goods = ProductHelper.getById(ppi.getGdspktdtl_gdsid());
				            	
				            	if(goods != null && !product.getId().equals(goods.getId())&&ProductStockHelper.canBuy(goods)){
				            		//获取显示图片
				            		String imgurl="";
				            		      ArrayList<GdsCutImg> gcilist= getByGdsid(goods.getId());
				            			  GdsCutImg gci=new GdsCutImg();
				            			  if(gcilist!=null&&gcilist.size()>0)
				            			  {
				            				  gci=gcilist.get(0);
				            			  }
				            		
				            			  if(gci!=null&&gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
				            			  {
				            				  imgurl="http://images.d1.com.cn"+gci.getGdscutimg_100();
				            			  }
				            			  else
				            			  {
				            				  imgurl=ProductHelper.getImageTo120(goods);
				            			  }
				            		title = Tools.clearHTML(goods.getGdsmst_gdsname());
				            		sb.append("<li class=\"otherli\"><img src=\"http://images.d1.com.cn/Index/images/zhadd.jpg\" width=\"16\" height=\"16\" style=\"border:none;\" /></li>");
				            		sb.append("<li><a href=\"").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\"><img src=\"").append(imgurl).append("\" width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a>");
				            		sb.append("<a href=\"").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
				            		sb.append("<span><input type='checkbox' checked='checked' onClick=\"selectInit('").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("','").append(Tools.getFormatMoney(Tools.floatValue(goods.getGdsmst_memberprice()) - Tools.floatValue(ppi.getGdspktdtl_savemoney()))).append("',this.checked,").append(flag).append(")\" name='pktsel").append(flag).append("' value='").append(goods.getId()).append("'>");
				            		sb.append("&nbsp;&nbsp;<font color=\"#666666\" >原价：￥").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("</font></span>");
				            		sb.append("</li>");
				            		memberprice += Tools.floatValue(goods.getGdsmst_memberprice());
					            	pktprice += Tools.floatValue(ppi.getGdspktdtl_savemoney());
				            	}
				            	if(product.getId().equals(goods.getId()))
				            	{
				            		memberprice += Tools.floatValue(goods.getGdsmst_memberprice());
					            	pktprice += Tools.floatValue(ppi.getGdspktdtl_savemoney());
				            	}
				            	
				            }
				            
				            sb.append("</ul></div>");
				            sb.append("<table class=\"zh_content\"><tr><td><span>组合购买</span>");
				            sb.append("<strike>总价：￥<font id=\"memberP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice)).append("</font></strike><br/>");
				            sb.append("组合价：<font color=\"#bc0000\" face=\"微软雅黑\"><b>￥<font id=\"pktP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice - pktprice)).append("</font></b></font><br/>");
				            sb.append("共优惠：￥<font id=\"cheap").append(flag).append("\">").append(Tools.getFormatMoney(pktprice)).append("</font><br/><br/>");
				            sb.append("<img src=\"http://images.d1.com.cn/Index/images/ljgmgzh.jpg\" code=\"").append(pp.getId()).append("\" onclick=\"check_pkt('").append(flag).append("','").append(product.getId()).append("',this)\" class=\"addimg\" />");
				            sb.append("</td></tr></table>");
				            sb.append("</div>");
						}
					
				}
			}
		
		if(size<6)
		{			
		    if(glist!=null&&glist.size()>0)
		    {
		    	
			for(int i=0;i<glist.size()&&i+size<6;i++)
			{
				Gdscoll gdscoll=(Gdscoll)glist.get(i);
				if(gdscoll!=null)
				{
				flag++;
				ArrayList<Gdscolldetail> gdlist=new ArrayList<Gdscolldetail>();
				ArrayList<Gdscolldetail> gdlist1=GdscollHelper.getGdscollBycollid(gdscoll.getId());
				//获取搭配单品排序
				ArrayList<Gdscolldetail> gdlist_1=new ArrayList<Gdscolldetail>();
				ArrayList<Gdscolldetail> gdlist_2=new ArrayList<Gdscolldetail>();
				if(gdlist1!=null&&gdlist1.size()>0)
				{
					for(Gdscolldetail gdl:gdlist1)
					{
						if(gdl!=null&&gdl.getGdscolldetail_gdsflag()!=null&&gdl.getGdscolldetail_gdsflag().longValue()==1)
						{
							gdlist_1.add(gdl);
						}
						else
						{
							gdlist_2.add(gdl);
						}
					}
				}
				if(gdlist_1!=null&&gdlist1.size()>0)
				{
					gdlist.addAll(gdlist_1);
				}
				if(gdlist_2!=null&&gdlist_2.size()>0)
				{
					gdlist.addAll(gdlist_2);
				}
				if(gdlist!=null&&gdlist.size()>0)
				{
		           int count=0;
		           for(int j=0;j<gdlist.size();j++)
		           {
		        	   Gdscolldetail ppi = (Gdscolldetail)gdlist.get(j);
		           	   Product goods = ProductHelper.getById(ppi.getGdscolldetail_gdsid());
		               if(goods != null && !goods.getId().equals(product.getId())&& goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_flag().longValue()==1&&ProductStockHelper.canBuy(goods)){
		           	       count++;
		           	   }
		               
		           }
		           count++;
		           int ulWidth = count*124+(count-1)*34+158;
					String title = Tools.clearHTML(product.getGdsmst_gdsname());
					String imgurl1="";
				      ArrayList<GdsCutImg> gcilist1= getByGdsid(product.getId());
					  GdsCutImg gci1=new GdsCutImg();
					  if(gcilist1!=null&&gcilist1.size()>0)
					  {
						  gci1=gcilist1.get(0);
					  }
				
					  if(gci1!=null&&gci1.getGdscutimg_100()!=null&&gci1.getGdscutimg_100().length()>0)
					  {
						  imgurl1="http://images.d1.com.cn"+gci1.getGdscutimg_100();
					  }
					  else
					  {
						  imgurl1=ProductHelper.getImageTo120(product);
					  }
					sb.append("<div class=\"content_sub\" style=\" display:none\"><div class=\"package\"><ul style=\"width:").append(ulWidth).append("px;\">");
					if(gdscoll.getGdscoll_smallimgurl()!=null&&gdscoll.getGdscoll_smallimgurl().length()>0)
					{
					//获取搭配图
			        sb.append("<li><a href=\"/gdscoll/index.jsp?id=").append(gdscoll.getId()).append("\" target=\"_blank\">");
					sb.append("<img src=\"").append("http://images1.d1.com.cn").append(gdscoll.getGdscoll_smallimgurl()).append("\"/>");
					sb.append("</a></li>");
					sb.append("<li class=\"otherli\"><img src=\"http://images.d1.com.cn/images2012/index2012/equal.png\" width=\"18\" height=\"18\" style=\"border:none;\" /></li>");
					}
					sb.append("<li><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\"><img src='").append(imgurl1).append("' width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
					sb.append("<span>&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#666666\">原价：￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font></span><input type=\"hidden\" name=\"gdsmp").append(flag).append("\" id=\"gdsmp").append(flag).append("\" value='").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("'></li>");
					
					float memberprice = 0f;
					float memberprice1 = 0f;
		            float zk=0.95f;
		            for(int j=0;j<gdlist.size();j++)
		            {
		            	
		            	Gdscolldetail ppi = (Gdscolldetail)gdlist.get(j);
		            	Product goods = ProductHelper.getById(ppi.getGdscolldetail_gdsid());
		            	if(goods != null && !goods.getId().equals(product.getId())&&goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_flag().longValue()==1&&ProductStockHelper.canBuy(goods)){
		            		//获取显示图片
		            		String imgurl="";
		            		      ArrayList<GdsCutImg> gcilist= getByGdsid(goods.getId());
		            			  GdsCutImg gci=new GdsCutImg();
		            			  if(gcilist!=null&&gcilist.size()>0)
		            			  {
		            				  gci=gcilist.get(0);
		            			  }
		            		
		            			  if(gci!=null&&gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
		            			  {
		            				  imgurl="http://images.d1.com.cn"+gci.getGdscutimg_100();
		            			  }
		            			  else
		            			  {
		            				  imgurl=ProductHelper.getImageTo120(goods);
		            			  }
		            		title = Tools.clearHTML(goods.getGdsmst_gdsname());
		            		sb.append("<li class=\"otherli\"><img src=\"http://images.d1.com.cn/Index/images/zhadd.jpg\" width=\"16\" height=\"16\" style=\"border:none;\" /></li>");
		            		sb.append("<li><a href=\"").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\"><img src=\"").append(imgurl).append("\" width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a>");
		            		sb.append("<a href=\"").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
		            		sb.append("<span><input type='checkbox'");
		            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1)
		            		{
		            			sb.append(" checked='checked'");
		            		}
		            		sb.append(" onClick=\"selectInits('").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("',this.checked,").append(flag).append(")\" name='pktsel").append(flag).append("' value='").append(goods.getId()).append("'>");
		            		sb.append("&nbsp;&nbsp;<font color=\"#666666\" >原价：￥").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("</font></span>");
		            		sb.append("</li>");
		            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1)
		            		{
			            		memberprice += Tools.getFloat((int)(goods.getGdsmst_memberprice().floatValue()*zk),2);
			            		memberprice1 += Tools.getFloat((int)(goods.getGdsmst_memberprice().floatValue()),2);
		            		}
		            	}
		            	
		            	
		            }
		            memberprice += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()*zk),2);
        		memberprice1 += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()),2);
        						
		            sb.append("</ul></div>");
		            sb.append("<table class=\"zh_content\"><tr><td><span>组合购买</span><br/>");
		            sb.append("<strike>总价：￥<font id=\"memberP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice1)).append("</font></strike><br/>");
		            sb.append("组合价：<font color=\"#bc0000\" face=\"微软雅黑\"><b>￥<font id=\"pktP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice)).append("</font></b></font><br/>");
		            sb.append("共优惠：￥<font id=\"cheap").append(flag).append("\">").append(Tools.getFormatMoney(memberprice1-memberprice)).append("</font><br/><br/>");
		            sb.append("<img src=\"http://images.d1.com.cn/Index/images/ljgmgzh.jpg\" code=\"").append(gdscoll.getId()).append("\" onclick=\"check_pkt2('").append(flag).append("','").append(product.getId()).append("',this)\" class=\"addimg\" />");
		            sb.append("</td></tr></table>");
		            sb.append("</div>");
				}
				}
			}
				
	            
		    }
	
		}

		
		sb.append("</div></div>");
	}

	return sb.toString();
}


private static ArrayList<PromotionProduct> getbjdxlist(String gdsid)
{
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code", new Long("8322")));
	clist.add(Restrictions.eq("spgdsrcm_gdsid", gdsid));
	clist.add(Restrictions.ge("spgdsrcm_enddate", new Date()));
	clist.add(Restrictions.le("spgdsrcm_begindate", new Date()));
	List<Order> olist = new ArrayList<Order>();
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 1);
	if(clist==null||clist.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((PromotionProduct)be);
	}
	return rlist ;
}
/**
 * 获取活动商品列表
 * 
 */
private static ArrayList<PromotionProduct> gethdgoodslist(String gdsid)
{
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code", new Long("8409")));
	clist.add(Restrictions.eq("spgdsrcm_gdsid", gdsid));
	//clist.add(Restrictions.ge("spgdsrcm_enddate", new Date()));
	//clist.add(Restrictions.le("spgdsrcm_begindate", new Date()));
	List<Order> olist = new ArrayList<Order>();
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 1);
	if(clist==null||clist.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((PromotionProduct)be);
	}
	return rlist ;
}
public static String Getp2013img(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, 1);
	if(list!=null&&list.size()>0)
	{
		for(Promotion p:list)
		{
			if(p!=null)
			{
				
				sb.append("<a href=\"").append(Tools.clearHTML(p.getSplmst_url())).append("\" target=\"_blank\">");
				sb.append("<img src=\"").append(StringUtils.clearHTML(p.getSplmst_picstr())).append("\" />");
				sb.append("</a>");
				
			}
		}
	}
	return sb.toString();
}
%>