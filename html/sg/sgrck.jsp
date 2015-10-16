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

public static class GdsMsSalesComparator implements Comparator<SgGdsDtl>{
	@Override
	public int compare(SgGdsDtl s0, SgGdsDtl s1) {
		long snum0=s0.getSggdsdtl_vbuynum().longValue()+s0.getSggdsdtl_vusrnum().longValue();
		long snum1=s1.getSggdsdtl_vbuynum().longValue()+s1.getSggdsdtl_vusrnum().longValue();

		 
			if(snum0<snum1){
				return 1 ;
			}else if(snum0==snum1){
				return 0 ;
			}else{
				return -1 ;
			}
 
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
			if(p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_promotionstart()!=null
					&&p.getGdsmst_promotionstart().getTime()>(new Date()).getTime()&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31){
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
	List<BaseEntity> b_list = Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 350);
	//System.out.println("=b_list.size()==33===="+b_list.size());
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((SgGdsDtl)be);
		}
	}
	return list ;
}

public static String getmsmodel2(List<SgGdsDtl> sglist,String type,String rackcode,String instock){
	ArrayList<Product> plistys =new ArrayList<Product>();
	 SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	StringBuilder sb=new StringBuilder();
	if(sglist!=null && sglist.size()>0){
 		sb.append("<ul>");
 		String gdsid="";
 		int i = 0;
 		for(SgGdsDtl sg:sglist){
 			gdsid = sg.getSggdsdtl_gdsid();
 		Product product=ProductHelper.getById(gdsid);
 		if(rackcode.equals("02")||rackcode.equals("03")||rackcode.equals("014")||rackcode.equals("050")){
	 		if(product.getGdsmst_rackcode().startsWith(rackcode))continue;
	 		}else{
	 			if(rackcode.equals("012")&&!product.getGdsmst_rackcode().startsWith("012")&&!product.getGdsmst_rackcode().startsWith("060")
	 					&&!product.getGdsmst_rackcode().startsWith("070")&&!product.getGdsmst_rackcode().startsWith("080"))continue;
	 			if(rackcode.equals("015")&&!product.getGdsmst_rackcode().startsWith("015")&&!product.getGdsmst_rackcode().startsWith("040"))continue;
	 		}
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
         if (gdsmemo!=null&&gdsmemo.length()>25){
        	 gdsmemo=gdsmemo.substring(0,25);
         }
         if("1".equals(instock)&&gdsnum <= 0)continue;

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


public static String getmsmodel(List<Product> p_list,String type,String instock){
	ArrayList<Product> plistys =new ArrayList<Product>();
	 SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	StringBuilder sb=new StringBuilder();
	if(p_list!=null && p_list.size()>0){
 		sb.append("<ul>");
 		String gdsid="";
 		int i = 0;
 		for(Product product:p_list){
 		List<SgGdsDtl> sglist2=getsghot(product.getId());
 		SgGdsDtl sg = sglist2.get(0);
 		gdsid = product.getId();
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
         if (gdsmemo!=null&&gdsmemo.length()>25){
        	 gdsmemo=gdsmemo.substring(0,25);
         }
         if("1".equals(instock)&&gdsnum <= 0)continue;
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
//闪购列表
public static String getmslist(String rackcode,String type,String order,String instock){
	
	ArrayList<Product> p_list =new ArrayList<Product>();
   
	
	  List<SgGdsDtl> sglist1=getsghot(""); 
	  if(type!=null&&type.equals("1")){
		  return 	getmsmodel2(sglist1,type,rackcode,instock);
	  }else{
		 
      if(sglist1!=null&&sglist1.size()>0){
      	String gdsid="";
      	String ids="";
      	//if(!Tools.isNull(rackcode)) return "";
      	if(type!=null&&type.equals("2")){
      		
      	Collections.sort(sglist1,new GdsMsSalesComparator());
      
      	for(SgGdsDtl sg2:sglist1){
	 		//ids+=sg2.getSggdsdtl_gdsid()+",";
	 		Product p=ProductHelper.getById(sg2.getSggdsdtl_gdsid());
	 		if(rackcode.equals("02")||rackcode.equals("03")||rackcode.equals("014")||rackcode.equals("050")){
	 		if(rackcode!=null&&!p.getGdsmst_rackcode().startsWith(rackcode))continue;
	 		}else{
	 			if(rackcode.equals("012")&&!p.getGdsmst_rackcode().startsWith("012")&&!p.getGdsmst_rackcode().startsWith("060")
	 					&&!p.getGdsmst_rackcode().startsWith("070")&&!p.getGdsmst_rackcode().startsWith("080"))continue;
	 			if(rackcode.equals("015")&&!p.getGdsmst_rackcode().startsWith("015")&&!p.getGdsmst_rackcode().startsWith("040"))continue;
	 		}
	 		p_list.add(p);
		}
      	}else{

    	   for(SgGdsDtl sg2:sglist1){
	 		ids+=sg2.getSggdsdtl_gdsid()+",";
           // System.out.println(type+"-----------"+(sg2.getSggdsdtl_vbuynum().longValue()+sg2.getSggdsdtl_vusrnum().longValue()));
	 		//Product p=ProductHelper.getById(sg2.getSggdsdtl_gdsid());
	 		
		  }
    	  
          p_list = getProductList(ids,rackcode,type,order);
          //System.out.println("------2222-----");
      	}
      	return 	getmsmodel(p_list,type,instock);
      }
       	
   }
      return "";
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
	   if(rockcode.equals("02")||rockcode.equals("03")||rockcode.equals("014")||rockcode.equals("050")){
		   clist.add(Restrictions.like("gdsmst_rackcode", rockcode+"%"));
	 		}else{
	 			if(rockcode.equals("012")){
	 				 clist.add(Restrictions.sqlRestriction(" (gdsmst_rackcode like '012%' or gdsmst_rackcode like '060%' or gdsmst_rackcode like '070%' or gdsmst_rackcode like '080%')"));
	 			}
	 			if(rockcode.equals("015")){
	 				clist.add(Restrictions.sqlRestriction(" (gdsmst_rackcode like '015%' or gdsmst_rackcode like '040%' )"));
	 			}
	 		}
	  
	   //type 1 默认 2销量 3价格
	   List<Order> olist=new ArrayList<Order>();
	   /*if(!Tools.isNull(type)){
		   if(type.equals("2")){//销量
			   olist.add(Order.desc("gdsmst_salecount"));
		   }
	   }*/
	   if(!Tools.isNull(order)&&!Tools.isNull(type)&&type.equals("3")){//按照价格降序
		   if(order.equals("1")){//降序
			   olist.add(Order.desc("gdsmst_msprice"));
		   }else if(order.equals("2")){//按照价格升序
			   olist.add(Order.asc("gdsmst_msprice"));
		   }
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
		plist=PromotionHelper.getBrandListByCode("3697", -1);
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
		List<BaseEntity> b_list = Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 300);

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
	String instock = request.getParameter("instock");
	String order = "2";
	if(request.getParameter("order")!=null){
		order = request.getParameter("order");
	}
	if("getsglist".equals(act2)){
		StringBuilder sb = new StringBuilder();
		String mslist = getmslist(rackcode,type,order,instock);
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
