<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%!
//获取该商户的所有模块
private ArrayList<ShopModel> getShopModelList(String shopinfo_id)
{
	ArrayList<ShopModel> rlist = new ArrayList<ShopModel>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("shopmodel_infoid", new Long(shopinfo_id)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("shopmodel_sort"));
	List<BaseEntity> list = Tools.getManager(ShopModel.class).getList(clist, olist, 0, 18);
	if(clist==null||clist.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((ShopModel)be);
	}
	
	return rlist ;
	
}
public static class GdsMsTimeComparator implements Comparator<Product>{
	@Override
	public int compare(Product p0, Product p1) {
		
		if(p0.getGdsmst_promotionstart()!=null&&p1.getGdsmst_promotionstart()!=null){
			if(p0.getGdsmst_promotionstart().getTime()<p1.getGdsmst_promotionstart().getTime()){
				return 1 ;
			}else if(p0.getGdsmst_promotionstart().getTime()==p1.getGdsmst_promotionstart().getTime()){
				return 0 ;
			}else{
				return -1 ;
			}
		}
		return 0;
	}
}
public static class GdsMsTimeComparator2 implements Comparator<Product>{
	@Override
	public int compare(Product p0, Product p1) {
		if(p0.getGdsmst_promotionstart()!=null&&p1.getGdsmst_promotionstart()!=null){
			if(p0.getGdsmst_promotionstart().getTime()>p1.getGdsmst_promotionstart().getTime()){
				return 1 ;
			}else if(p0.getGdsmst_promotionstart().getTime()==p1.getGdsmst_promotionstart().getTime()){
				return 0 ;
			}else{
				return -1 ;
			}
		}
		return 0;
	}
}

//预告区商品
public static String getmslistnew(){
    SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	StringBuilder sb=new StringBuilder();
	ArrayList<Product> list = new ArrayList<Product>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("sggdsdtl_sort"));
	List<BaseEntity> b_list = Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 200);

	if(b_list!=null){
		for(BaseEntity be:b_list){
			SgGdsDtl sg=(SgGdsDtl)be ;
			Product p=ProductHelper.getById(sg.getSggdsdtl_gdsid());
		   	Date sdate=p.getGdsmst_promotionstart();
          	Date edate=p.getGdsmst_promotionend();	
			if(p.getGdsmst_validflag().longValue()==1&&sdate!=null
					&&sdate.getTime()>(new Date()).getTime()&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31){
				list.add(p);
			}
		}
	}
	Collections.sort(list,new GdsMsTimeComparator());
      if(list!=null&&list.size()>0){
      	int i=0;
      	String gdsid="";
          SimpleDateFormat mdfmt = new SimpleDateFormat("MM月dd日");
          SimpleDateFormat hourfmt = new SimpleDateFormat("hh时");
          sb.append("<ul>");
          for (Product product:list){
        	  gdsid=product.getId();
        	  SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", gdsid);
              boolean ismiaoshao=false;
              if(product==null)continue;
             // if(i==3)break;
             long gdsnum=sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
             String gdstitle=sg.getSggdsdtl_gdsname();
             if (gdstitle!=null&&gdstitle.length()>32){
            	 gdstitle=gdstitle.substring(0,32);
             }
             String gdsmemo=sg.getSggdsdtl_memo();
             if(Tools.isNull(gdsmemo))
             {
            	 gdsmemo=product.getGdsmst_title();
             }
             if (gdsmemo!=null&&gdsmemo.length()>25){
            	 gdsmemo=gdsmemo.substring(0,25);
             }
             double dl= Tools.getDouble(product.getGdsmst_msprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
		 	 String fl=ProductGroupHelper.getRoundPrice((float)dl);
		 	 if(fl.length()==1){
		 		fl = fl+".0";
		 	 }
             i++;
             if(gdsnum > 0){
         		if(i%3==0){
             	 sb.append("<li class=\"r\" style=\"height:515px\">");
              }else{
             	 sb.append("<li class=\"l\" style=\"height:515px\">");
              }
 	         }else{
 	        	if(i%3==0){
                	 sb.append("<li class=\"r_soldout\" style=\"height:515px\">");
              }else{
                	 sb.append("<li class=\"l_soldout\" style=\"height:515px\">");
              }
 	      }
          
       	 sb.append("<div class=\"sgl_item\" style=\"position: relative;\">");
      	 sb.append("<div class=\"i_img\">");
      	 sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+sg.getSggdsdtl_gdsname()+"\">");
      	 sb.append("<img style=\"padding-top:4px;padding-bottom:4px;\" src=\"http://images1.d1.com.cn"+product.getGdsmst_img310()+"\" width=\"310\" height=\"310\">");
      	 sb.append("</a>");
      	 /*sb.append("<div class=\"ii_f\">5<span class=\"z\">折</span></div>");*/
      	 if(gdsnum <= 0){
       	   sb.append("<div class=\"li_nogds\"></div>");
       	 }
      	 sb.append("</div>");
         sb.append("<div class=\"i_title\">");
         sb.append("<span class=\"zhekou_t\" style=\"  color: #FFFFFF;\">"+fl+"折</span>");
         sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+sg.getSggdsdtl_gdsname()+"\">");
         sb.append("<span  class=\"tt\" style=\"padding-left: 40px;\">"+gdstitle+"</span><br />");
         sb.append("</a>");
         sb.append("<span class=\"gkey\">"+gdsmemo+"</span>"); 
         sb.append("</div>");
		 sb.append("<div style=\"height:117px;\">");
		 sb.append("<div class=\"i_price_newbg\">");
		 sb.append("<span class=\"s2_1\"><font style=\"font-size:22px; font-family: '微软雅黑';\">￥ </font>"+product.getGdsmst_msprice()+"</span>");
		 sb.append("<span class=\"s3new\"><del>市场价：￥"+product.getGdsmst_saleprice().longValue()+"</del></span>");
		 sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\" \">");
		 if(gdsnum > 0){
		 	sb.append("<span class=\"jijkqiang\"></span>");
		 }else{
			sb.append("<span class=\"shouqing\"></span>");
		 }
		 sb.append("</a>");
		 sb.append("</div>");
		 sb.append("<div style=\"height:47px; vertical-align: middle;padding-top:10px;\">");
		 //sb.append("<span style=\"padding-left:16px;padding-right:105px;\">已有&nbsp;"+(sg.getSggdsdtl_vbuynum().longValue()+sg.getSggdsdtl_vusrnum().longValue())+"人购买</span>");
		 //sb.append("<span style=\"font-family:'微软雅黑'; font-size:12pt;\">仅剩余&nbsp;<span style=\"color:#F0424E; font-size:14pt;\">"+gdsnum+"</span>件</span>");
		 sb.append("<span style=\"padding-left:16px;font-family:'微软雅黑'; color:#3f3f3f; font-size:12pt;padding-right:10px;\" id=\"djsnew"+product.getId()+"\"></span>");
		 sb.append("<span style=\"\">共<span style=\"font-family:'微软雅黑'\">&nbsp;"+sg.getSggdsdtl_vallnum()+"&nbsp;</span>件</span>");
		 sb.append("</div>");
		 sb.append("</div>");
		 sb.append("</div>");
		 sb.append("</li>");
            
     }
          sb.append("</ul>");
      	}
      return sb.toString();
}
public static int getsgSumbyRackcode(String rackcode){
	SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	int sum = 0;
	String type = "";
	String order = "";
	List<SgGdsDtl> sglist1=getsghot(""); 
	if(sglist1!=null&&sglist1.size()>0){
		String gdsid="";
		String ids="";
		for(SgGdsDtl sg2:sglist1){
			ids+=sg2.getSggdsdtl_gdsid()+",";
		}
 		ArrayList<Product> p_list = getProductList(ids,rackcode,type,order);
 		if(p_list != null && p_list.size()>0){
 			for(Product product:p_list){
 			boolean ismiaoshao=false;
            if(product==null)continue;
            Date nowday=new Date();
            if(product.getGdsmst_promotionstart()!=null&&product.getGdsmst_promotionend()!=null&&product.getGdsmst_msprice()!=null){
            	Date sdate=product.getGdsmst_promotionstart();
            	Date edate=product.getGdsmst_promotionend();	
            
            	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
            			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
            			&&product.getGdsmst_msprice().floatValue()>=0f){
            		ismiaoshao = true;
            	}
            }
             if(!ismiaoshao)continue;
             sum++;
 			}
 			
 		}
	}
	return sum;
}
public static ArrayList<SgGdsDtl> getsghot(String gdsid){
	ArrayList<SgGdsDtl> list = new ArrayList<SgGdsDtl>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));//1上架
	clist.add(Restrictions.le("sggdsdtl_cls", new Long(5)));
	if(!Tools.isNull(gdsid)){
		clist.add(Restrictions.eq("sggdsdtl_gdsid", gdsid));
	}
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("sggdsdtl_sort"));
	olist.add(Order.desc("sggdsdtl_sdate"));
	List<BaseEntity> b_list = Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 200);
	//System.out.println("=b_list.size()==33===="+b_list.size());
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((SgGdsDtl)be);
		}
	}
	return list ;
}
//闪购列表
public static String getmslist(String rackcode,String type,String order){
	ArrayList<Product> plistys =new ArrayList<Product>();
    SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	StringBuilder sb=new StringBuilder();
	  List<SgGdsDtl> sglist1=getsghot(""); 
      if(sglist1!=null&&sglist1.size()>0){
      	String gdsid="";
      	String ids="";
      	int i = 0;

    	
    	boolean buyflag=true;
     		sb.append("<ul>");
     		for(SgGdsDtl sg:sglist1){
     			gdsid = sg.getSggdsdtl_gdsid();
     		Product product=ProductHelper.getById(gdsid);
     		if(product==null)continue;
     		gdsid = product.getId();
     		
     		//if(gdsid.equals("01205490"))System.out.println(p_list.size()+"-------------闪购不显示商品中"+gdsid);
     		boolean ismiaoshao=false;
            if(product==null)continue;
            Date nowday=new Date();
            if(product.getGdsmst_promotionstart()!=null&&product.getGdsmst_promotionend()!=null&&product.getGdsmst_msprice()!=null){
            	Date sdate=product.getGdsmst_promotionstart();
            	Date edate=product.getGdsmst_promotionend();	
            
            	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
            			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
            			&&product.getGdsmst_msprice().floatValue()>=0f){
            		ismiaoshao = true;
            	}
            	if(sdate.getTime()>nowday.getTime()){
                	plistys.add(product);
                }
            }
            
           // if(gdsid.equals("01205490"))System.out.println("闪购不显示商品中"+gdsid);
             if(!ismiaoshao)continue;
             long gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
             long gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum().longValue();
             //System.out.println("===gdsnum==="+gdsnum+"====gdsnum2===="+gdsnum2+"====="+gdsid+"====getGdsmst_validflag====="+product.getGdsmst_validflag().longValue());
            long buynum= sg.getSggdsdtl_vbuynum().longValue()+sg.getSggdsdtl_vusrnum().longValue();

             if (gdsnum<=0||gdsnum2<=0 ||product.getGdsmst_validflag().longValue()==2){
             	  gdsnum=0;
             	 buynum= sg.getSggdsdtl_vallnum().longValue();
             }
             double dl= Tools.getDouble(product.getGdsmst_msprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
		 	 String fl=ProductGroupHelper.getRoundPrice((float)dl);
		 	 if(fl.length()==1){
		 		fl = fl+".0";
		 	 }
             i++;
             String gdstitle=sg.getSggdsdtl_gdsname();
             if (gdstitle!=null&&gdstitle.length()>32){
            	 gdstitle=gdstitle.substring(0,32);
             }
             String gdsmemo=sg.getSggdsdtl_memo();
             if(Tools.isNull(gdsmemo))
             {
            	 gdsmemo=product.getGdsmst_title();
             }
             if (gdsmemo!=null&&gdsmemo.length()>25){
            	 gdsmemo=gdsmemo.substring(0,25);
             }
             if(gdsnum > 0){
            		if(i%3==0){
                	 sb.append("<li class=\"r\" style=\"height:515px\">");
                 }else{
                	 sb.append("<li class=\"l\" style=\"height:515px\">");
                 }
    	         }else{
    	        	if(i%3==0){
                   	 sb.append("<li class=\"r_soldout\" style=\"height:515px\">");
                 }else{
                   	 sb.append("<li class=\"l_soldout\" style=\"height:515px\">");
                 }
    	      }
             
          	 sb.append("<div class=\"sgl_item\" style=\"position: relative;\">");
         	 sb.append("<div class=\"i_img\">");
         	 sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+sg.getSggdsdtl_gdsname()+"\">");
         	 sb.append("<img style=\"padding-top:4px;padding-bottom:4px;\" src=\"http://images1.d1.com.cn"+product.getGdsmst_img310()+"\" width=\"310\" height=\"310\">");
         	 sb.append("</a>");
         	 /*sb.append("<div class=\"ii_f\">5<span class=\"z\">折</span></div>");*/
         	 if(gdsnum <= 0){
          	   sb.append("<div class=\"li_nogds\"></div>");
          	 }
         	 sb.append("</div>");
             sb.append("<div class=\"i_title\">");
             sb.append("<span class=\"zhekou_t\" style=\"  color: #FFFFFF;\">"+fl+"折</span>");
             sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+sg.getSggdsdtl_gdsname()+"\">");
             sb.append("<span  class=\"tt\" style=\"padding-left: 40px;\">"+gdstitle+"</span><br />");
             sb.append("</a>");
             sb.append("<span class=\"gkey\">"+gdsmemo+"</span>"); 
             sb.append("</div>");
			 sb.append("<div style=\"height:117px;\">");
			  
			 sb.append("<div class=\"i_price_new\">");
			 sb.append("<span class=\"s2_1\"><font style=\"font-size:22px; font-family: '微软雅黑';\">￥ </font>"+product.getGdsmst_msprice()+"</span>");
			 sb.append("<span class=\"s3\"><del>市场价：￥"+product.getGdsmst_saleprice().longValue()+"</del></span>");
			 sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\" \">");
			 if(gdsnum > 0){
			 	sb.append("<span class=\"lijiqiang\"></span>");
			 }else{
				sb.append("<span class=\"shouqing\"></span>");
			 }
			 sb.append("</a>");
			 sb.append("</div>");
			 sb.append("<div style=\"height:47px; vertical-align: middle;padding-top:10px;\">");
			 sb.append("<span style=\"padding-left:16px;padding-right:105px;\">已有&nbsp;"+(buynum)+"人购买</span>");
			 sb.append("<span style=\"font-family:'微软雅黑'; font-size:12pt;\">仅剩余&nbsp;<span style=\"color:#F0424E; font-size:14pt;\">"+gdsnum+"</span>件</span>");
			 sb.append("</div>");
			 
			 sb.append("</div>");
			 sb.append("</div>");
			 sb.append("</li>");
             
           	 /*if(gdsnum > 0){
           		if(i%3==0){
               	 sb.append("<li class=\"r\">");
                }else{
               	 sb.append("<li class=\"l\">");
                }
   	         }else{
   	        	if(i%3==0){
                  	 sb.append("<li class=\"r_soldout\">");
                }else{
                  	 sb.append("<li class=\"l_soldout\">");
                }
   	         }
             
          	 sb.append("<div class=\"sgl_item\">");
         	 sb.append("<div class=\"i_img\">");
         	 sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+sg.getSggdsdtl_gdsname()+"\">");
         	 sb.append("<img src=\"http://images1.d1.com.cn"+sg.getSggdsdtl_imgurl()+"\" width=\"310\" height=\"310\">");
         	 sb.append("</a>");
         	 /*sb.append("<div class=\"ii_f\">5<span class=\"z\">折</span></div>");*/
         	 /*if(gdsnum <= 0){
         	   sb.append("<div class=\"li_nogds\"></div>");
         	 }
         	 sb.append("</div>");
             sb.append("<div class=\"i_title\">");
             sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+sg.getSggdsdtl_gdsname()+"\">");
             sb.append("<span class=\"tt\">"+gdstitle+"</span><br />");
             sb.append("</a>");
             sb.append("<span class=\"gkey\">"+gdsmemo+"</span>"); 
             sb.append("</div>");
             sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+sg.getSggdsdtl_gdsname()+"\">");
			 sb.append("<div class=\"i_price\">");
			 sb.append("<span class=\"num\">");
			 sb.append("限量<font color=\"#ffcf4c\">"+sg.getSggdsdtl_vallnum()+"</font>件<br />");
			 sb.append("仅剩"+gdsnum+"件");
			 sb.append("</span>");
			 sb.append("<span class=\"pp\">");
			 sb.append("<span class=\"s\"><font size=\"5\">￥</font>"+product.getGdsmst_msprice().longValue());
			 sb.append("</span><br />");
			 sb.append("<span class=\"m\">");
			 sb.append("市场价：￥"+product.getGdsmst_saleprice());
			 sb.append("</span>");
			 sb.append("</span>");
			 sb.append("</div>");
			 sb.append("</a>");
			 sb.append("</div>");
			 sb.append("</li>");*/
      		}
     		if(plistys!=null&&plistys.size()>0){
			 for (Product product:plistys){
				  gdsid=product.getId();
	        	  SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", gdsid);
	              boolean ismiaoshao=false;
	              if(product==null)continue;
	             // if(i==3)break;
	             long gdsnum=sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
	             String gdstitle=sg.getSggdsdtl_gdsname();
	             if (gdstitle!=null&&gdstitle.length()>32){
	            	 gdstitle=gdstitle.substring(0,32);
	             }
	             String gdsmemo=sg.getSggdsdtl_memo();
	             if(Tools.isNull(gdsmemo))
	             {
	            	 gdsmemo=product.getGdsmst_title();
	             }
	             if (gdsmemo!=null&&gdsmemo.length()>25){
	            	 gdsmemo=gdsmemo.substring(0,25);
	             }
	             double dl= Tools.getDouble(product.getGdsmst_msprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
			 	 String fl=ProductGroupHelper.getRoundPrice((float)dl);
			 	 if(fl.length()==1){
			 		fl = fl+".0";
			 	 }
	             i++;
	             if(gdsnum > 0){
	         		if(i%3==0){
	             	 sb.append("<li class=\"r\" style=\"height:515px\">");
	              }else{
	             	 sb.append("<li class=\"l\" style=\"height:515px\">");
	              }
	 	         }else{
	 	        	if(i%3==0){
	                	 sb.append("<li class=\"r_soldout\" style=\"height:515px\">");
	              }else{
	                	 sb.append("<li class=\"l_soldout\" style=\"height:515px\">");
	              }
	 	      }
	          
	       	 sb.append("<div class=\"sgl_item\" style=\"position: relative;\">");
	      	 sb.append("<div class=\"i_img\">");
	      	 sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+sg.getSggdsdtl_gdsname()+"\">");
	      	 sb.append("<img style=\"padding-top:4px;padding-bottom:4px;\" src=\"http://images1.d1.com.cn"+product.getGdsmst_img310()+"\" width=\"310\" height=\"310\">");
	      	 sb.append("</a>");
	      	 /*sb.append("<div class=\"ii_f\">5<span class=\"z\">折</span></div>");*/
	      	 if(gdsnum <= 0){
	       	   sb.append("<div class=\"li_nogds\"></div>");
	       	 }
	      	 sb.append("</div>");
	         sb.append("<div class=\"i_title\">");
	         sb.append("<span class=\"zhekou_t\" style=\"  color: #FFFFFF;\">"+fl+"折</span>");
	         sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+sg.getSggdsdtl_gdsname()+"\">");
	         sb.append("<span  class=\"tt\" style=\"padding-left: 40px;\">"+gdstitle+"</span><br />");
	         sb.append("</a>");
	         sb.append("<span class=\"gkey\">"+gdsmemo+"</span>"); 
	         sb.append("</div>");
			 sb.append("<div style=\"height:117px;\">");
			 sb.append("<div class=\"i_price_newbg\">");
			 sb.append("<span class=\"s2_1\"><font style=\"font-size:22px; font-family: '微软雅黑';\">￥ </font>"+product.getGdsmst_msprice()+"</span>");
			 sb.append("<span class=\"s3new\"><del>市场价：￥"+product.getGdsmst_saleprice().longValue()+"</del></span>");
			 sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\" \">");
			 if(gdsnum > 0){
			 	sb.append("<span class=\"jijkqiang\"></span>");
			 }else{
				sb.append("<span class=\"shouqing\"></span>");
			 }
			 sb.append("</a>");
			 sb.append("</div>");
			 sb.append("<div style=\"height:47px; vertical-align: middle;padding-top:10px;\">");
			 //sb.append("<span style=\"padding-left:16px;padding-right:105px;\">已有&nbsp;"+(sg.getSggdsdtl_vbuynum().longValue()+sg.getSggdsdtl_vusrnum().longValue())+"人购买</span>");
			 //sb.append("<span style=\"font-family:'微软雅黑'; font-size:12pt;\">仅剩余&nbsp;<span style=\"color:#F0424E; font-size:14pt;\">"+gdsnum+"</span>件</span>");
			 sb.append("<span style=\"padding-left:16px;font-family:'微软雅黑'; color:#3f3f3f; font-size:12pt;padding-right:10px;\" id=\"djsnew"+product.getId()+"\"></span>");
			 sb.append("<span style=\"\">共<span style=\"font-family:'微软雅黑'\">&nbsp;"+sg.getSggdsdtl_vallnum()+"&nbsp;</span>件</span>");
			 sb.append("</div>");
			 sb.append("</div>");
			 sb.append("</div>");
			 sb.append("</li>");
			 
     	     }
     	 }
     		sb.append("</ul>");
     }
      return sb.toString();
}

//查询商品信息
public static ArrayList<Product> getProductList(String ids,String rockcode,String type,String order){
	   if(Tools.isNull(ids)){
		   return null;
	   }
	   ArrayList<Product> list=new ArrayList<Product>();
	   List<Criterion> clist = new ArrayList<Criterion>();
	   String[] arr_ids = ids.replace('，', ',').split(",");
	   clist.add(Restrictions.in("id", arr_ids));
	   if(!Tools.isNull(rockcode) && !rockcode.equals("0") && !rockcode.equals("021")){//021,031是鞋子
		   clist.add(Restrictions.like("gdsmst_rackcode", rockcode+"%"));
	   }else if(!Tools.isNull(rockcode) && !rockcode.equals("0")){
		   clist.add(Restrictions.sqlRestriction(" (gdsmst_rackcode like '021%' or gdsmst_rackcode like '031%')"));
	   }
	   //type 1 默认 2销量 3价格
	   List<Order> olist=new ArrayList<Order>();
	   if(!Tools.isNull(type)){
		   if(type.equals("2")){//销量
			   olist.add(Order.desc("gdsmst_salecount"));
		   }
	   }
	   if(!Tools.isNull(order)&&!Tools.isNull(type)&&type.equals("3")){//按照价格降序
		   if(order.equals("1")){//降序
			   olist.add(Order.desc("gdsmst_msprice"));
		   }else if(order.equals("2")){//按照价格升序
			   olist.add(Order.asc("gdsmst_msprice"));
		   }
	   }
	   if(order.equals("3")){//按照开始时间排序
		   olist.add(Order.desc("gdsmst_promotionstart"));
	   }
	   List<BaseEntity> list2 = Tools.getManager(Product.class).getListCriterion(clist, olist, 0, 500);
	   if(list2==null || list2.size()==0){
			return null;
	   }
	   for(BaseEntity be:list2){
			list.add((Product)be);
	   }
	return list;
}

public static List<Product> getSgHotList(long cls){
	
	List<Product> list=new ArrayList<Product>();
	SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));
	clist.add(Restrictions.eq("sggdsdtl_cls", new Long(cls)));
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.desc("sggdsdtl_sort"));
	
	List<BaseEntity> blist=Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 100);
	if(blist!=null){
		for(BaseEntity be:blist){
			SgGdsDtl sg=(SgGdsDtl)be ;
			Product p=ProductHelper.getById(sg.getSggdsdtl_gdsid());
		   	Date sdate=p.getGdsmst_promotionstart();
          	Date edate=p.getGdsmst_promotionend();	
			if(sdate!=null
					&&((cls==6&&edate.getTime()>(new Date()).getTime())||(sdate.getTime()<(new Date()).getTime()&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31))){
				list.add(p);
			}
		}
	}
	return list;
}
%>
<%
String chePingAn1 = Tools.getCookie(request,"PINGAN");
String flags="2";
//根据推荐编码获得推荐商品信息列表
	String act= request.getParameter("act");
	String code= request.getParameter("code");
	if("form_search".equals(act)){
		ArrayList<Promotion> plist=new ArrayList<Promotion>(); 
		String str = "";
		plist=PromotionHelper.getBrandListByCode("3684", -1);
		if(plist != null && plist.size()>0){
		str = "[";
		for(Promotion p:plist){
			if(p!=null){
				str+= "{\"id\":\""+ p.getId() +"\",\"endTime\":\""+ p.getSplmst_tjendtime().getTime() +"\"}";
				str += ",";
				//System.out.println("============"+p.getSplmst_tjendtime());
			}
		}
		str = str.substring(0,str.length()-1);
		str+="]";
		}
		out.print(str);
		return;
	}
	
	//新品里面的倒计时
	String act_new= request.getParameter("act_new");
	if("getsgnew".equals(act_new)){
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		ArrayList<Product> list = new ArrayList<Product>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("sggdsdtl_sort"));
		List<BaseEntity> b_list = Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 200);

		if(b_list!=null){
			for(BaseEntity be:b_list){
				SgGdsDtl sg=(SgGdsDtl)be ;
				Product p=ProductHelper.getById(sg.getSggdsdtl_gdsid());
			   	Date sdate=p.getGdsmst_promotionstart();
	          	Date edate=p.getGdsmst_promotionend();	
				if(p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_promotionstart()!=null
						&&p.getGdsmst_promotionstart().getTime()>(new Date()).getTime()&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31){
					list.add(p);
				}
			}
		}
		Collections.sort(list,new GdsMsTimeComparator());
		String str = "";
	      if(list!=null&&list.size()>0){
	    	str = "[";
	      	String gdsid="";
	          for (Product product:list){
	        	  gdsid=product.getId();
	        	  SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", gdsid);
	              boolean ismiaoshao=false;
	              if(product==null)continue;
	  				str+= "{\"id\":\""+ gdsid +"\",\"endTime\":\""+ product.getGdsmst_promotionstart().getTime() +"\"}";
	  				str += ",";
	  				//System.out.println("============"+product.getGdsmst_promotionstart());
	          }
	        str = str.substring(0,str.length()-1);
	  		str+="]";
	    	
			out.print(str);
			return;
	}
	}
	      
	String act2 = request.getParameter("act2");
	String rackcode = request.getParameter("rackcode");
	String type = request.getParameter("type");
	String order = "2";
	if(request.getParameter("order")!=null){
		order = request.getParameter("order");
	}
	if("getsglist".equals(act2)){
		StringBuilder sb = new StringBuilder();
		String mslist = getmslist(rackcode,type,order);
		if(mslist != null){	
			
		    Map<String,Object> map = new HashMap<String,Object>();
		    map.put("code",new Integer(1));
		    map.put("content",mslist);
			if(!Tools.isNull(order)&&!Tools.isNull(type)&&type.equals("3")){
				if(order.equals("1")){
					order = "2";
					map.put("order",order);
				}else{
					order = "1";
					map.put("order",order);
				}
			}
			if(!Tools.isNull(rackcode)){
				map.put("rackcode",rackcode);
			}
		    out.print(JSONObject.fromObject(map));
		    return;        	
		}else{
			out.print("{\"code\":0,message:\"数据加载失败！\"}");
			return;
		}
	}
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！">
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买">
<title>超值闪购--D1优尚网</title>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js?"+System.currentTimeMillis())%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/autotab.js?"+System.currentTimeMillis())%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/rollImageKP.js?"+System.currentTimeMillis())%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/wapcheck.js?"+System.currentTimeMillis())%>"></script>
<link type="text/css" rel="stylesheet" href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/index2014.css?"+System.currentTimeMillis())%>" />

<script>

if(checkMobile()){
	window.location.href="http://m.d1.cn";
}
</script>
<style type="text/css">

.i_price_new {
background-image: url(http://images.d1.com.cn/zt2014/0304/pricebg-big1.gif);
background-repeat: repeat;
height: 70px;

}
.i_price_newbg {
background-image: url(http://images.d1.com.cn/zt2014/0304/bgbigbar-or.gif);
background-repeat: repeat;
height: 70px;
}

.lijiqiang {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/lijiqiang-big.png);
background-repeat: no-repeat;
background-position: 0px 0px;
width: 126px;
height: 47px;
right:17px;
bottom: 60px;
}
.jijkqiang {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/getitsoon.jpg);
background-repeat: no-repeat;
background-position: 0px 0px;
width: 126px;
height: 47px;
right:17px;
bottom: 60px;
}
.shouqing{
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/shouqingbig.png);
background-repeat: no-repeat;
background-position: 0px 0px;
width: 126px;
height: 47px;
right:17px;
bottom: 60px;
}

.s2_1 {
color: #FFFFFF;
font-size: 43px;
line-height: 43px;
padding-left: 16px;
/*vertical-align: bottom;*/
font-family: 'arial';
display: block;
height: 38px;
padding-top: 5px;
}

.s3{
color: #f7949b;
font-size: 10px;
padding-left: 21px;
vertical-align: top;
font-family: '微软雅黑';
}
.s3new{
color: #fcbf9c;
font-size: 10px;
padding-left: 21px;
vertical-align: top;
font-family: '微软雅黑';
}
.zhekou_t {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/checknap.png);
background-position: 0px 0px;
width: 39px; height: 18px;
left:12px;
bottom: 165px;
}
.djs_newlist{
font-size: 14pt;
color: #f0424e;
padding:0px 2px;
font-family: 'arial';
}
.productadright{position: fixed;_position: absolute;right: 0px;bottom: 0px;width: 160px;font-size: 12px;_top: expression(documentElement.scrollTop+documentElement.clientHeight-this.offsetHeight);overflow: hidden;z-index: 200000;display: block;}
.page_f{
    left: 0px;bottom: 0px;width: 100px;font-size: 12px;display: block;
	float:left;
	margin-top:10px; 
	margin-left:10px; 
	position:fixed; 
	_position:absolute;
	_bottom:auto; 
	_top:expression(eval(document.documentElement.scrollTop));
	z-index:99999;
}

.topbannerdiv{	position:relative; width:980px; height:450px; margin: 0px auto;}
.topbannerdiv .link1{ position:absolute;  width:980px; height:450px; bottom:0; left:0px; }

.banner328 {
background-image: url(http://images.d1.com.cn/shopadmin/splimg/201408/818.jpg);
background-repeat: no-repeat;
background-position: center;
height: 300px;
}


</style>

</head>

<body style="background:#fcf5b9">
<a name="top1120"></a>
<input type="hidden" name="order" id="order" value="1"/>
<input type="hidden" name="type_his" id="type_his" value="1"/>
<input type="hidden" name="rackcode" id="rackcode"/>

<!-- 头部开始 -->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束 -->

<div style="background-color: #FFFFFF; width: 1000px;margin: 0 auto;">


<div class="index_body">
     <!-- 因为店庆活动，所以暂时隐藏掉（结束） -->
     <a name="sgtop"></a>
      <div class="ib_sg">
        <div id="sginfotab">
          <h2>限量<font color="#f0424e">闪购</font><span class="sgh2txt">每天10点上新</span></h2>
          <div class="sg_menu">
              <ul>
              <%
              int sum = 0;
              //sum = getsgSumbyRackcode("0");
              //if(sum > 0){
              %>
              <li ><a id="cur1" href="javascript:void(0);" class="cur" onclick="getsgou('0',1);">全部闪购<span><%//=getsgSumbyRackcode("0")%></span></a></li>
              <%//} 
              //sum = getsgSumbyRackcode("020");
              //if(sum > 0){
              %>
              <li><a id="cur2" href="javascript:void(0);" onclick="getsgou('02',2);">女装<span><%//=getsgSumbyRackcode("020")%></span></a></li>
              <%//} 
              //sum = getsgSumbyRackcode("030");
              //if(sum > 0){
              %>
              <li><a id="cur3" href="javascript:void(0);" onclick="getsgou('03',3);">男装<span><%//=getsgSumbyRackcode("030")%></span></a></li>
              <%//} 
              //sum = getsgSumbyRackcode("014");
              //if(sum > 0){
              %>
              <li><a id="cur4" href="javascript:void(0);" onclick="getsgou('014',4);">化妆品<span><%//=getsgSumbyRackcode("014")%></span></a></li>
         
              <li><a id="cur7" href="javascript:void(0);" onclick="getsgou('050',5);">箱包皮具<span><%//=getsgSumbyRackcode("050")%></span></a></li>
              <%//} 
              //sum = getsgSumbyRackcode("040");
              //if(sum > 0){
              %>
              <li><a id="cur8" href="javascript:void(0);" onclick="getsgou('015',6);">名品配饰<span><%//=getsgSumbyRackcode("040")%></span></a></li>

              <li><a id="cur10" href="javascript:void(0);" onclick="getsgou('012',7);">居家生活<span><%//=getsgSumbyRackcode("012")%></span></a></li>
              <%//} 
              //sum = getsgSumbyRackcode("060");
              ///if(sum > 0){
              %>
             <%//} 
              String ms_new = getmslistnew();
              if(!Tools.isNull(ms_new)){
              %>
              <li><a id="cur14" href="#jijiangkq" ><span style="color: red;">即将开抢</span></a></li>
              <%}%>
              </ul>
          </div>
          <div class="sg_sort">
            <h3>排序：</h3>
              <ul>
              <li><a href="javascript:void(0);" onclick="getorder(this,1);">默认</a></li>
              <!-- <li class="cur"><a href="#">销量<span class="sgs_top"></span><span class="sgs_bottom"></span></a></li> -->
              <li><a href="javascript:void(0);" onclick="getorder(this,2);">销量 <span class="sgs_top"></span><span class="sgs_bottom"></span></a></li>
              <li class="cur4" id="curprice2"><a href="javascript:void(0);" onclick="getorder(this,3);">价格 <span class="sgs_top2"></span><span class="sgs_bottom"></span></a></li>
              <li style="width:100px;"><input name="instock" id="instock"  type="checkbox" value="1" onchange="getorder(this,4)" />仅显示有货</li>
               
              </ul>
          </div>
          </div>
          <div class="sg_list" id="sg_list"> 
              
               <%out.print(getmslist("0","1","3")); %>
              
          </div>
          <div class="sg_list" id="new_list">
          <script language=javascript>
    		var jsonDatanew = new Array();
    		$(document).ready(function(){
    			$.ajax({
    				type: "post",
    				dataType: "json",
    				url: '/index2014new.jsp?act_new=getsgnew',
    				cache: false,
    				error: function(XmlHttpRequest){
    					alert("获取内容出错，请稍后重试或者联系客服处理！");
    				},success: function(data){
    					//alert(data[0].id);
    					
    					jsonDatanew = eval(data);
    					setInterval("vms_timenew()",1000);	
    				}
    			});
    		});
			</script> 
			<a name="jijiangkq"></a>
               <%//out.print(getmslistnew()); %>
          </div>
      </div>
</div>
</div>


<!-- 底部开始 -->
<%@include file="/inc/foot.jsp" %>
<!-- 底部结束 -->
</body>
</html>

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script language="javascript">

   $(document).ready(function() {
	   
    $(".zblist").find("img").lazyload({ effect: "show", placeholder: "http://images.d1.com.cn/Index/images/grey.gif",threshold : 200 });
		 
		  initborder()
		  
		  
	});
</script>

<script>

 


  var ws=window.screen.width;   
  var the_s=new Array();
  var lasttime=0;
  function vms_time(){
	  //alert(jsonData.length);
	  var data = jsonData;
	  for(var i=0;i<data.length;i++){
		  var end = data[i].endTime;
		  var now = new Date().getTime();
		  lasttime = (end - now)/1000;
		  //alert(lasttime+"===");
		  if(lasttime>0){
			  var the_D=Math.floor((lasttime/3600)/24)
		      var the_H=Math.floor((lasttime-the_D*3600*24)/3600);
			  if(the_H<10){
				  the_H='0'+the_H;
			  }
	          var the_M=Math.floor((lasttime-the_D*3600*24-the_H*3600)/60);
	          if(the_M<10){
	        	  the_M='0'+the_M;
			  }
	          var the_S=Math.floor((lasttime-the_H*3600)%60);
	          if(the_S<10){
	        	  the_S='0'+the_S;
			  }
	          $("#pmstime"+data[i].id).text(the_D+"天 "+the_H+"时"+the_M+"分"+the_S+"秒" );
	      }else{
	    	  $("#pmstime"+data[i].id).text("已结束");
	      }
	 }  
 }
  var showtime=0;
  function vms_timenew(){
	  //alert(jsonData.length);
	  var data = jsonDatanew;
	  for(var i=0;i<data.length;i++){
		  var end = data[i].endTime;
		  var now = new Date().getTime();
		  showtime = (end - now)/1000;
		  //alert(lasttime+"===");
		  if(showtime>0){
			  var the_D=Math.floor((showtime/3600)/24)
		      var the_H=Math.floor((showtime-the_D*3600*24)/3600);
			  if(the_H<10){
				  the_H='0'+the_H;
			  }
	          var the_M=Math.floor((showtime-the_D*3600*24-the_H*3600)/60);
	          if(the_M<10){
	        	  the_M='0'+the_M;
			  }
	          var the_S=Math.floor((showtime-the_H*3600)%60);
	          if(the_S<10){
	        	  the_S='0'+the_S;
			  }
	          $("#djsnew"+data[i].id).html("<span class=\"djs_newlist\">"+the_D+"</span>天 <span class=\"djs_newlist\">"+the_H+"</span>小时<span class=\"djs_newlist\">"+the_M+"</span>分<span class=\"djs_newlist\">"+the_S+"</span>秒后开抢" );
	          //$("#djsnew"+data[i].id).text(the_D+"天 "+the_H+"时"+the_M+"分"+the_S+"秒" );
	      }else{
	    	  $("#djsnew"+data[i].id).text("已开始");
	      }
	 }  
 }
  function getsgou(rackcode,type){
	
	  $.ajax({
			type: "post",
			dataType: "json",
			url: 'sgrck.jsp?act2=getsglist',
			cache: false,
			data: {rackcode:rackcode},
			error: function(XmlHttpRequest){
				alert("页面刷新出错，请稍后重试！");
			},success: function(json){
				//alert(json.code);
				//alert(json.content);
				if(json.code==1){
					$('#sg_list').html(json.content);
					$("#rackcode").val(json.rackcode);
					$('.sg_menu li a').removeClass("cur");
					$('#cur'+type).addClass("cur");
					initborder()
				}
				
			}
	});
	  
  }
  function getorder(t,type){
	  var order = $("#order").val();
	  //alert(type+"=="+order);
	  var rackcode = $("#rackcode").val();
	  var instock=0;
	  $("input[name='instock']:checkbox").each(function(){
		   if($(this).attr("checked")){
			   instock = $(this).val();	  
		   }
	   });
	  if(type=="4"){
		 
		  type= $("#type_his").val();
	  }
	  $.ajax({
			type: "post",
			dataType: "json",
			url: '/index2014new.jsp?act2=getsglist',
			cache: false,
			data: {type:type,order:order,rackcode:rackcode,instock:instock},
			error: function(XmlHttpRequest){
				alert("页面刷新出错，请稍后重试！");
			},success: function(json){
				//alert(json.code);
				//alert(json.content);
				if(json.code==1){
					$('#sg_list').html(json.content);
					//alert(json.order);
					$("#order").val(json.order);
					$("#type_his").val(type);
					if(parseInt(type)==3){
					if(order == 2){
						$('.cur').removeClass("cur");
						$('#curprice2').removeClass("cur3");
						$('#curprice2').addClass("cur2");//升序
					}else{
						$('.cur').removeClass("cur");
						$('#curprice2').removeClass("cur2");
						$('#curprice2').addClass("cur3");
					}
					}
					if(parseInt(type)==2){
						$(t).parent().addClass("cur");
					}
					initborder();
				}
				
			}
	});
	  
  }
  
  function initborder(){
	//当鼠标滑入时将div的class换成divOver
		$('.sg_list li').hover(function(){
				//$(this).addClass('liOver');	
				$(this).css('border', 'solid 1px #f0424e');
			},function(){
				//鼠标离开时移除divOver样式
				//$(this).removeClass('liOver');	
				// 删除一个属性
          $(this).css('border',  'solid 1px #ebebeb');	
			}
		);
  }
</script>