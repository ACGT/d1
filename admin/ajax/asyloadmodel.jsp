<%@ page contentType="text/html; charset=UTF-8" import="java.math.*,java.util.*,com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp" %>

<%!
public static String format_two(float value) {  
    BigDecimal bd = new BigDecimal(value);  
    bd = bd.setScale(2, RoundingMode.HALF_UP);  
    return bd.toString();  
} 
/**
 * 按照销量比较商品，销量是计算出来的
 * @author cg
 *
 */
public static class ZkProductComparator implements Comparator<Product>{
	@Override
	public int compare(Product p0, Product p1) {
		long l0 = p0.getGdsmst_memberprice().longValue()*100/p0.getGdsmst_saleprice().longValue();
		long l1 = p1.getGdsmst_memberprice().longValue()*100/p1.getGdsmst_saleprice().longValue();
		if(l0>l1){
			return -1 ;
		}else if(l0==l1){
			return 0 ;
		}else{
			return 1 ;
		}
	}
}


public static boolean getmsflag(Product p){
	Date nowday=new Date();
	 boolean ismiaoshao=false;
	 SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	 if(p.getGdsmst_promotionstart()!=null&&p.getGdsmst_promotionend()!=null&&p.getGdsmst_msprice()!=null){
	 	Date sdate=p.getGdsmst_promotionstart();
	 	Date edate=p.getGdsmst_promotionend();	

	 	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
	 			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
	 			&&p.getGdsmst_msprice().floatValue()>0f){
	 		ismiaoshao = true;
	 	}

	 }
	 if(ismiaoshao){

	 	ismiaoshao=CartHelper.getsgbuy(p.getId());
	 }
	 return ismiaoshao;
	}
/**
 * 根据商品编号和推荐位号得出一条推荐商品信息
 *
 */
public static PromotionProduct getPromtionProductForname(String code,String gdsid){
	PromotionProduct pro_product = new PromotionProduct();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
	clist.add(Restrictions.eq("spgdsrcm_gdsid",gdsid));
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, null, 0, 10);
	if(list==null||list.size()==0)return null;	
	return (PromotionProduct)list.get(0) ;
}

//查询商品信息
public static ArrayList<Product> getProductList(String ids,String type,int click_flag,String have_gds){
	   if(Tools.isNull(ids)){
		   return null;
	   }
	   
	   ArrayList<Product> list=new ArrayList<Product>();
	   List<Criterion> clist = new ArrayList<Criterion>();
	   String[] arr_ids = ids.replace('，', ',').split(",");
	   clist.add(Restrictions.in("id", arr_ids));
	   if("有货".equals(have_gds)){
		   clist.add(Restrictions.gt("gdsmst_virtualstock", new Long(0)));
	   }
	   List<Order> olist=new ArrayList<Order>();
	   if(type.equals("3")){
			if(click_flag==2){//1降序 2升序 只在价格的时候用
				olist.add(Order.asc("gdsmst_memberprice"));
		    }else{
		    	olist.add(Order.desc("gdsmst_memberprice"));
		    }
	   }
		if(type.equals("1")){//按照销量降序
			olist.add(Order.desc("gdsmst_salecount"));
		}
	   List<BaseEntity> list2 = Tools.getManager(Product.class).getListCriterion(clist, olist, 0, 500);
	   if(list2==null || list2.size()==0){
			return null;
	   }
	 
	   for(BaseEntity be:list2){
			list.add((Product)be);
	   }
	   if(type.equals("2")){//折扣
		   //if(click_flag%2==0){
			   Collections.sort(list,new ZkProductComparator());
			   Collections.reverse(list);//降序
		   //}else{
			   //Collections.sort(list,new ZkProductComparator());
			   //Collections.addAll(list);//升序
		   //}
	   }
	return list;
}
%>
<%
	String id = request.getParameter("model_id");
	//type  1销量  2折扣  3价格  4评论   5有货
	String type = request.getParameter("type");
	String click_flag = request.getParameter("click_flag");//判断奇偶的标记，作为排序的一个标记，偶数为降序，奇数为升序
	String have_gds = request.getParameter("have_gds");
	int click_flag2 = 0;
	if(!Tools.isNull("click_flag")){
		click_flag2 = Integer.parseInt(click_flag);
		//click_flag2++;
	}
	if(Tools.isNull(id)){
		out.print("{\"code\":0,message:\"参数错误！\"}");
		return;
	}
	ShopModel sm = (ShopModel)Tools.getManager(ShopModel.class).get(id);
	StringBuilder sb = new StringBuilder();
	if(sm != null){
		sb.append("<div class='modelist'");
		if(sm.getShopmodel_type()!=null&&sm.getShopmodel_type().toString().equals("2")&&sm.getShopmodel_title()!=null&&sm.getShopmodel_title().length()>0){
			sb.append(" style='background:#"+sm.getShopmodel_title()+";");
		}
		sb.append("'>");
		if(sm!=null && !Tools.isNull(sm.getShopmodel_txt())&&sm.getShopmodel_type().toString().equals("2")){
			sb.append("<div style='height: 90px; '>");
			sb.append("<div class='sm_font' style='color: #"+sm.getShopmodel_txtcolor()+";position: relative;'>");
			sb.append(sm.getShopmodel_txt());
 	    	if(!Tools.isNull(sm.getShopmodel_txtmore())){
	 	    	String txtmore = sm.getShopmodel_txtmore(); 
	 	    	if(txtmore.indexOf("http://") == -1){
	 	    		txtmore = "http://"+sm.getShopmodel_txtmore();
	 	    	}else{
	 	    		txtmore = sm.getShopmodel_txtmore();
	 	    	}
	 	    	sb.append("<span class='sm_font_a'>");
	 	    	sb.append("<a id='css_a' href='"+txtmore+"' target='_blank' style='color: #"+sm.getShopmodel_title()+"'>更多商品&nbsp;<span style='font-family: 方正仿宋; font-size: 13px;'>></span></a></span>");
 	    	}
 	    sb.append("</div>");
 	    sb.append("</div>");
 	    }
		sb.append("<div class='mode_content'>");
		
		
		String gdsidlist=sm.getShopmodel_list();
	    int c=0;
	    String[] gdsidarr=gdsidlist.split(",");
	    if(gdsidarr.length>0){
	    	for(int m = 0;m<gdsidarr.length;m++){
    	        if(gdsidarr[m].length() == 8){//商户编号
    	        	
    	        	ArrayList<Product> p_list = getProductList(gdsidlist,type,click_flag2,have_gds);
    	        	if(p_list!=null && p_list.size()>0){
    	        	for(int i = 0;i<p_list.size();i++){
         			 	Product p=ProductHelper.getById(p_list.get(i).getId());
        				if(p!=null&&p.getGdsmst_ifhavegds()==0&&p.getGdsmst_validflag()==1){
        					c++;
        					
        					String imgurl = "";
        					if(!Tools.isNull(p.getGdsmst_imgurl())){
        						imgurl = p.getGdsmst_imgurl().trim();
        						if(imgurl.indexOf("shopadmin")>0){
        							imgurl = "http://images.d1.com.cn"+imgurl;
        						}else{
        							imgurl = "http://images1.d1.com.cn"+imgurl;
        						}
        					}
        					String img200250 = "";
        					if(!Tools.isNull(p.getGdsmst_img200250())){
        						img200250 = p.getGdsmst_img200250().trim();
        						if(img200250.indexOf("shopadmin")>0){
        							img200250 = "http://images.d1.com.cn"+img200250;
        						}else{
        							img200250 = "http://images1.d1.com.cn"+img200250;
        						}
        					}	
        					String img240300 = "";
        					if(!Tools.isNull(p.getGdsmst_img240300())){
        						img240300 = p.getGdsmst_img240300().trim();
        						if(img240300.indexOf("shopadmin")>0){
        							img240300 = "http://images.d1.com.cn"+img240300;
        						}else{
        							img240300 = "http://images1.d1.com.cn"+img240300;
        						}
        					}	
        					String recimg = "";
        					if(!Tools.isNull(p.getGdsmst_recimg())){
        						recimg = p.getGdsmst_recimg().trim();
        						if(recimg.indexOf("shopadmin")>0){
        							recimg = "http://images.d1.com.cn"+recimg;
        						}else{
        							recimg = "http://images1.d1.com.cn"+recimg;
        						}
        					}	
        					String fzimg = "";
        					if(!Tools.isNull(p.getGdsmst_fzimg())){
        						fzimg = p.getGdsmst_fzimg().trim();
        						if(fzimg.indexOf("shopadmin")>0){
        							fzimg = "http://images.d1.com.cn"+fzimg;
        						}else{
        							fzimg = "http://images1.d1.com.cn"+fzimg;
        						}
        					}	
        					
        					if(sm.getShopmodel_size()==2){
        						sb.append(getshopModelsize2(p,recimg,c));
        			    	}else if(sm.getShopmodel_size()==1){
        			    		sb.append(getshopModelsize1(p,imgurl,c));
        			    	}else if(sm.getShopmodel_size()==3){
        			    		sb.append(getshopModelsize3(p,img200250,c));
        			    	}else if(sm.getShopmodel_size()==4){
        			    		sb.append(getshopModelsize4(p,img240300,c));
        			    	}else if(sm.getShopmodel_size()==5){
        			    		sb.append(getshopModelsize5(p,img240300,c));
        			    	}else if(sm.getShopmodel_size()==7){//240*300*4/行春节模板
        			    		sb.append(getshopModelsize7(p,img240300));
        			    	}else if(sm.getShopmodel_size()==8){//200*250*4/行春节模板
        			    		sb.append(getshopModelsize8(p,img200250));
        			    	}else if(sm.getShopmodel_size()==9){//200*200*4/行春节模板
        			    		sb.append(getshopModelsize9(p,imgurl));
        			    	}else if(sm.getShopmodel_size()==10 || sm.getShopmodel_size()==11 || sm.getShopmodel_size()==12 || sm.getShopmodel_size()==13){
        			    		sb.append("<dl style='width:240px;");
        			    		if(sm.getShopmodel_size()==10){sb.append(" height:420px;");}//10 200*200*4/行默认模板 
        			            else if(sm.getShopmodel_size()==11){sb.append(" height:430px;");}//11 200*250*4 
        			            else if(sm.getShopmodel_size()==12){sb.append(" height:490px;");}//12 240*300*4
        			            else if(sm.getShopmodel_size()==13){sb.append(" height:410px;");}//13 160*160*4
        			        	
        			        	sb.append(" padding-left: 4px; margin-bottom: 4px;'>"); 
        			        	sb.append("<dd>");
        			        	sb.append("<table width='240'"); 
        			            if(sm.getShopmodel_size()==10){sb.append(" height='410'");} 
        			            else if(sm.getShopmodel_size()==11){sb.append(" height='440'");}
        			            else if(sm.getShopmodel_size()==12){sb.append(" height='490'");}
        			            else if(sm.getShopmodel_size()==13){sb.append(" height='280'");}
        			            sb.append(" border='0' cellspacing='0' cellpadding='0' style=' background-color: #FFFFFF;'>");
        			            sb.append("<tr>");
        			            sb.append("<td"); 
        			    		if(sm.getShopmodel_size()==10){sb.append(" height='200'");} 
        			    		else if(sm.getShopmodel_size()==11){sb.append(" height='250'");}
        			    		else if(sm.getShopmodel_size()==12){sb.append(" height='300'");}
        			    		else if(sm.getShopmodel_size()==13){sb.append(" height='160'");}
        			    		sb.append(" colspan='3' align='center' style='position:relative'>");
        			    		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank' title='"+p.getGdsmst_gdsname()+"'>");
        			    		if(sm.getShopmodel_size()==10){
        			    			sb.append("<img src='"+imgurl+"' width='200' height='200' style='padding: 18px;'/>");
        			    		}else if(sm.getShopmodel_size()==11){
        			    			sb.append("<img src='"+img200250+"' width='200' height='250'>");
        			    		}else if(sm.getShopmodel_size()==12){
        			    			sb.append("<img src='"+img240300+"' width='240' height='300'>");
        			    		}else if(sm.getShopmodel_size()==13){
        			    			sb.append("<img src='"+recimg+"' width='160' height='160' style='padding: 40px;'>");
        			    		}
        			    		sb.append("</a>");
        			    		//左上角的爆炸图 spgdsrcm_layertype 0红 1 绿 2橙
        			    		if(!Tools.isNull(sm.getShopmodel_balname())){
        			    			sb.append("<i class='hottxt' style='display: inline;");
        			    			if(sm.getShopmodel_balloon() == 0){
        			    				sb.append(" background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -0px;");
        			    			}else if(sm.getShopmodel_balloon() == 1){
        			    				sb.append(" background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -144px;");
        			    			}else if(sm.getShopmodel_balloon() == 2){
        			    				sb.append(" background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -71px;");
        			    			}
        			    			sb.append("'>");
        			    			sb.append(sm.getShopmodel_balname()!=null?sm.getShopmodel_balname():"");
        			    			sb.append("</i>");
        			    		}
        			    		sb.append("</td>");
        			    		sb.append("</tr>");
        			    		sb.append("<tr>");
        			    		sb.append("<td width='20'"); 
        			    		if(sm.getShopmodel_size()==12){
        			    			sb.append("height='43'"); 
        			    		}else{
        			    			sb.append("height='30'");
        			    		}
        			    		sb.append(">&nbsp;</td>");
        			    		String memprice=format_two(p.getGdsmst_memberprice());
        			    		if(getmsflag(p)){
        			    			memprice=format_two(p.getGdsmst_msprice());
        			    		}
        			    		double dl= Tools.getDouble(p.getGdsmst_memberprice().doubleValue()*10/p.getGdsmst_saleprice().doubleValue(),1);
        			    		String fl=ProductGroupHelper.getRoundPrice((float)dl);
        			    		sb.append("<td width='206' class='mebprice' align='left'><b>");
        			    		sb.append(memprice);
        			    		sb.append("</b>");
        			    		sb.append("<span class='pbox_off'>");
        			    		sb.append(fl+"折</span>");
        			    		sb.append("</td>");
        			    		sb.append("<td width='20'>&nbsp;</td>");
        			    		sb.append("</tr>");
        			    		sb.append("<tr>");
        			    		sb.append("<td height='19'>&nbsp;</td>");
        			    		sb.append("<td height='19' class='saleprice' align='left'>市场价：<del>");
        			    		sb.append(format_two(p.getGdsmst_saleprice().floatValue()));
        			    		sb.append("</del></td><td height='19'>&nbsp;</td>");
        			    		sb.append("</tr>");
        			    		sb.append("<tr>");
        			    		sb.append("<td height='20'>&nbsp;</td>");
        			    		sb.append("<td height='40' align='left' class='td_overfl'>");
        			    		sb.append("<a class='title' href='http://www.d1.com.cn/Product/"+p.getId()+" target='_blank' title="+p.getGdsmst_gdsname()+"'>");
        			    		sb.append("<span>");
        			    		sb.append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),50));
        			    		sb.append("<span></a></td><td height='20'>&nbsp;</td></tr>");
        			    		sb.append("<tr><td height='20'>&nbsp;</td><td height='20' class='title2'  align='left'>");
        			    		//商户显示商品副标题
        			    		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+" target='_blank' title="+p.getGdsmst_title()+"'>");
        			    		sb.append("<span>");
        			    		String intrduce="";
        			    		if(!Tools.isNull(p.getGdsmst_title())){
							    	 intrduce = Tools.substring(Tools.clearHTML(p.getGdsmst_title()),60);
							    }
        			    		sb.append(intrduce);
        			    		sb.append("</span></a></td><td height='20'>&nbsp;</td></tr>");
        			    		sb.append("<tr><td>&nbsp;</td><td align='center");
        			    		if(sm.getShopmodel_size()==13){
        			    			sb.append("height='50px;'");
        			    		}else{
        			    			sb.append("height='55px;'");
        			    		}
        			    		sb.append(">"); 
        			    		sb.append("<a id='theLink' href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'></a>");
        			    		sb.append("</td><td>&nbsp;</td></tr>"); 
        			    		sb.append("<tr><td height='10'>&nbsp;</td><td height='10'>&nbsp;</td><td height='10'>&nbsp;</td></tr></table>");
        			    		sb.append("</dd></dl>");			   
        			    	}else if(sm.getShopmodel_size()==14 || sm.getShopmodel_size()==15 || sm.getShopmodel_size()==16){//粉红疯抢模板
        			        	long memprice=p.getGdsmst_memberprice().longValue();
        				    	if(CartHelper.getmsflag(p)){
        				    		memprice=p.getGdsmst_msprice().longValue();
        				    	}
        				    	double dl= Tools.getDouble(p.getGdsmst_memberprice().doubleValue()*10/p.getGdsmst_saleprice().doubleValue(),1);
        				    	String fl=ProductGroupHelper.getRoundPrice((float)dl);
        				    	String intrduce="";
        			    		if(!Tools.isNull(p.getGdsmst_title())){
							    	 intrduce = Tools.substring(Tools.clearHTML(p.getGdsmst_title()),60);
							    }
        					    String req_gdsname = "";
        				    	if(!Tools.isNull(p.getGdsmst_gdsname())){
        				    		req_gdsname = p.getGdsmst_gdsname();
        				    	}
        			        	sb.append(getFenseFQModel(p,intrduce,req_gdsname,sm));
        			        }else{
        			    		sb.append(getshopModelsizeother(p,fzimg,c));
        			    	}//商品编号结束
        				}//validflag
    	        	}
    	        }
    	        	//String s = sb.toString();
    	    	    //System.out.println("==="+s);
    	    	    //out.print("{\"code\":1,content:\""+s+"\",click_flag:\""+click_flag2+"\"}");
    	    	    Map<String,Object> map = new HashMap<String,Object>();
    	    	    map.put("code",new Integer(1));
    	    	    map.put("content",sb.toString());
    	    	    if(type.equals("3")){
    	    	    	map.put("click_flag",click_flag2);
    	    	    }
    	    	    out.print(JSONObject.fromObject(map));
    	    	    return; 
    	        }else if(gdsidarr[m].length() == 4  || gdsidarr[m].length()==11 && gdsidarr[m].indexOf("all")>0){//推荐位号
    	        	String ids = "";
    	        	ArrayList<PromotionProduct> list=null; 
	        		ArrayList<Product> pro_list=null;
	        		int for_num = 0;
	        		if(gdsidarr[m].indexOf("all")>0){//all代表读取所有的商品
	        			pro_list=getProductList(gdsidarr[m].substring(0, 8),5000);
	        			for_num = pro_list.size();
	        		}else{
	        			list = PromotionProductHelper.getPProductByCode(gdsidarr[m],100);//取出推荐位表中的值
	        			for_num = list.size();
	        		}
	        		//System.out.println("====for_num======"+for_num);
          			    if((list!=null || pro_list!=null) && for_num>0){
          			if(gdsidarr[m].indexOf("all")==-1){
	    	        	for(PromotionProduct pProduct:list){
						 	ids+=pProduct.getSpgdsrcm_gdsid()+",";
						}
          			}else{
          				for(Product pProduct:pro_list){
    					 	ids+=pProduct.getId()+",";
    					}
          			}
          			
    	        	ArrayList<Product> p_list = getProductList(ids,type,click_flag2,have_gds);
    	        	
    	        	if(p_list!=null && p_list.size()>0){
    	        	for(int i = 0;i<p_list.size();i++){
         			 	Product p=ProductHelper.getById(p_list.get(i).getId());
        				if(p!=null&&p.getGdsmst_ifhavegds()==0&&p.getGdsmst_validflag()==1){
        					c++;
        				//根据推荐位号和商品编号查询出当前的推荐位
        				PromotionProduct pro_product = null;
        				if(gdsidarr[m].indexOf("all")==-1){
        					pro_product = getPromtionProductForname(gdsidarr[m],p_list.get(i).getId());
        				}
	        			//排序功能不支持主推模板	
		String imgurl = "";
		if(!Tools.isNull(p.getGdsmst_imgurl())){
			imgurl = p.getGdsmst_imgurl().trim();
			if(imgurl.indexOf("shopadmin")>0){
				imgurl = "http://images.d1.com.cn"+imgurl;
			}else{
				imgurl = "http://images1.d1.com.cn"+imgurl;
			}
		}
		String img200250 = "";
		if(!Tools.isNull(p.getGdsmst_img200250())){
			img200250 = p.getGdsmst_img200250().trim();
			if(img200250.indexOf("shopadmin")>0){
				img200250 = "http://images.d1.com.cn"+img200250;
			}else{
				img200250 = "http://images1.d1.com.cn"+img200250;
			}
		}	
		String img240300 = "";
		if(!Tools.isNull(p.getGdsmst_img240300())){
			img240300 = p.getGdsmst_img240300().trim();
			if(img240300.indexOf("shopadmin")>0){
				img240300 = "http://images.d1.com.cn"+img240300;
			}else{
				img240300 = "http://images1.d1.com.cn"+img240300;
			}
		}	
		String recimg = "";
		if(!Tools.isNull(p.getGdsmst_recimg())){
			recimg = p.getGdsmst_recimg().trim();
			if(recimg.indexOf("shopadmin")>0){
				recimg = "http://images.d1.com.cn"+recimg;
			}else{
				recimg = "http://images1.d1.com.cn"+recimg;
			}
		}	
		String fzimg = "";
		if(!Tools.isNull(p.getGdsmst_fzimg())){
			fzimg = p.getGdsmst_fzimg().trim();
			if(fzimg.indexOf("shopadmin")>0){
				fzimg = "http://images.d1.com.cn"+fzimg;
			}else{
				fzimg = "http://images1.d1.com.cn"+fzimg;
			}
		}	
		
		if(sm.getShopmodel_size()==2){
			sb.append(getshopModelsize2(p,recimg,c));
    	}else if(sm.getShopmodel_size()==1){
    		sb.append(getshopModelsize1(p,imgurl,c));
    	}else if(sm.getShopmodel_size()==3){
    		sb.append(getshopModelsize3(p,img200250,c));
    	}else if(sm.getShopmodel_size()==4){
    		sb.append(getshopModelsize4(p,img240300,c));
    	}else if(sm.getShopmodel_size()==5){
    		sb.append(getshopModelsize5(p,img240300,c));
    	}else if(sm.getShopmodel_size()==7){//240*300*4/行春节模板
    		sb.append(getshopModelsize7(p,img240300));
    	}else if(sm.getShopmodel_size()==8){//200*250*4/行春节模板
    		sb.append(getshopModelsize8(p,img200250));
    	}else if(sm.getShopmodel_size()==9){//200*200*4/行春节模板
    		sb.append(getshopModelsize9(p,imgurl));
    	}else if(sm.getShopmodel_size()==10 || sm.getShopmodel_size()==11 || sm.getShopmodel_size()==12 || sm.getShopmodel_size()==13){
    		String intrduce="";
			String req_gdsname = "";
			if(gdsidarr[m].indexOf("all")==-1){
			    if(!Tools.isNull(list.get(i).getSpgdsrcm_briefintrduce())){
			    	 intrduce = Tools.substring(Tools.clearHTML(list.get(i).getSpgdsrcm_briefintrduce()),60);
			    }
		    	if(!Tools.isNull(list.get(i).getSpgdsrcm_gdsname())){
		    		req_gdsname = list.get(i).getSpgdsrcm_gdsname();
				}
			}else{
				intrduce = p.getGdsmst_title();
				req_gdsname = p.getGdsmst_gdsname();
			}	
		//推荐位通用模板
		sb.append("<dl style='width:240px;");
		if(sm.getShopmodel_size()==10){sb.append(" height:420px;");}//10 200*200*4/行默认模板 
        else if(sm.getShopmodel_size()==11){sb.append(" height:430px;");}//11 200*250*4 
        else if(sm.getShopmodel_size()==12){sb.append(" height:490px;");}//12 240*300*4
        else if(sm.getShopmodel_size()==13){sb.append(" height:410px;");}//13 160*160*4
    	
    	sb.append(" padding-left: 4px; margin-bottom: 4px;'>"); 
    	sb.append("<dd>");
    	sb.append("<table width='240'"); 
        if(sm.getShopmodel_size()==10){sb.append(" height='410'");} 
        else if(sm.getShopmodel_size()==11){sb.append(" height='440'");}
        else if(sm.getShopmodel_size()==12){sb.append(" height='490'");}
        else if(sm.getShopmodel_size()==13){sb.append(" height='280'");}
        sb.append(" border='0' cellspacing='0' cellpadding='0' style=' background-color: #FFFFFF;'>");
        sb.append("<tr>");
        sb.append("<td"); 
		if(sm.getShopmodel_size()==10){sb.append(" height='200'");} 
		else if(sm.getShopmodel_size()==11){sb.append(" height='250'");}
		else if(sm.getShopmodel_size()==12){sb.append(" height='300'");}
		else if(sm.getShopmodel_size()==13){sb.append(" height='160'");}
		sb.append(" colspan='3' align='center' style='position:relative'>");
		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank' title='"+p.getGdsmst_gdsname()+"'>");
		if(sm.getShopmodel_size()==10){
			sb.append("<img src='"+imgurl+"' width='200' height='200' style='padding: 18px;'/>");
		}else if(sm.getShopmodel_size()==11){
			sb.append("<img src='"+img200250+"' width='200' height='250'>");
		}else if(sm.getShopmodel_size()==12){
			sb.append("<img src='"+img240300+"' width='240' height='300'>");
		}else if(sm.getShopmodel_size()==13){
			sb.append("<img src='"+recimg+"' width='160' height='160' style='padding: 40px;'>");
		}
		sb.append("</a>");
		//左上角的爆炸图 spgdsrcm_layertype 0红 1 绿 2橙
		//推荐位的商品有单设的气球和文字，优先显示，其余的一律显示shopmodel表的气球文字。
		if(gdsidarr[m].indexOf("all")==-1){
		if(pro_product!=null && !Tools.isNull(pro_product.getSpgdsrcm_layertitle())){
			sb.append("<i class='hottxt' style='display: inline;");
			if(pro_product.getSpgdsrcm_layertype().indexOf("red") > -1){
				sb.append("background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -0px;");
			}else if(pro_product.getSpgdsrcm_layertype().indexOf("green") > -1){
				sb.append("background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -144px;");
			}else if(pro_product.getSpgdsrcm_layertype().indexOf("orange") > -1){
				sb.append("background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -71px;");
			}else{
				sb.append("background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -0px;");
			}
			sb.append("'>");
			sb.append(pro_product.getSpgdsrcm_layertitle()!=null?pro_product.getSpgdsrcm_layertitle():"");
			sb.append("</i>");
		}else if(!Tools.isNull(sm.getShopmodel_balname())){
			sb.append("<i class='hottxt' style='display: inline;");
			if(sm.getShopmodel_balloon() == 0){
				sb.append(" background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -0px;");
			}else if(sm.getShopmodel_balloon() == 1){
				sb.append(" background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -144px;");
			}else if(sm.getShopmodel_balloon() == 2){
				sb.append(" background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -71px;");
			}
			sb.append("'>");
			sb.append(sm.getShopmodel_balname()!=null?sm.getShopmodel_balname():"");
			sb.append("</i>");
		}
		}else{
			sb.append("<i class='hottxt' style='display: inline;");
			if(sm.getShopmodel_balloon() == 0){
				sb.append(" background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -0px;");
			}else if(sm.getShopmodel_balloon() == 1){
				sb.append(" background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -144px;");
			}else if(sm.getShopmodel_balloon() == 2){
				sb.append(" background: url(http://images.d1.com.cn/zt2014/0110/threecolor.png) no-repeat 0 -71px;");
			}
			sb.append("'>");
			sb.append(sm.getShopmodel_balname()!=null?sm.getShopmodel_balname():"");
			sb.append("</i>");
		}
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td width='20'"); 
		if(sm.getShopmodel_size()==12){
			sb.append("height='43'"); 
		}else{
			sb.append("height='30'");
		}
		sb.append(">&nbsp;</td>");
		String memprice=format_two(p.getGdsmst_memberprice());
		if(getmsflag(p)){
			memprice=format_two(p.getGdsmst_msprice());
		}
		double dl= Tools.getDouble(p.getGdsmst_memberprice().doubleValue()*10/p.getGdsmst_saleprice().doubleValue(),1);
		String fl=ProductGroupHelper.getRoundPrice((float)dl);
		sb.append("<td width='206' class='mebprice' align='left'><b>");
		sb.append(memprice);
		sb.append("</b>");
		sb.append("<span class='pbox_off'>");
		sb.append(fl+"折</span>");
		sb.append("</td>");
		sb.append("<td width='20'>&nbsp;</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td height='19'>&nbsp;</td>");
		sb.append("<td height='19' class='saleprice' align='left'>市场价：<del>");
		sb.append(format_two(p.getGdsmst_saleprice().floatValue()));
		sb.append("</del></td><td height='19'>&nbsp;</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td height='20'>&nbsp;</td>");
		sb.append("<td height='40' align='left' class='td_overfl'>");
		sb.append("<a class='title' href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank' title='"+p.getGdsmst_gdsname()+"'>");
		sb.append("<span>");
		sb.append(Tools.substring(Tools.clearHTML(req_gdsname),50));
		sb.append("<span></a></td><td height='20'>&nbsp;</td></tr>");
		sb.append("<tr><td height='20'>&nbsp;</td><td height='20' class='title2'  align='left'>");
		//商品卖点（读取spgdsrcm表中的值）
		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank' title='"+intrduce+"'>");
		sb.append("<span>");
		sb.append(intrduce);
		sb.append("</span></a></td><td height='20'>&nbsp;</td></tr>");
		sb.append("<tr><td>&nbsp;</td><td align='center'");
		if(sm.getShopmodel_size()==13){
			sb.append("height='50px;'");
		}else{
			sb.append("height='55px;'");
		}
		sb.append(">"); 
		sb.append("<a id='theLink' href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'></a>");
		sb.append("</td><td>&nbsp;</td></tr>"); 
		sb.append("<tr><td height='10'>&nbsp;</td><td height='10'>&nbsp;</td><td height='10'>&nbsp;</td></tr></table>");
		sb.append("</dd></dl>");
        }else if(sm.getShopmodel_size()==14 || sm.getShopmodel_size()==15 || sm.getShopmodel_size()==16){//粉红疯抢模板
        	long memprice=p.getGdsmst_memberprice().longValue();
	    	if(CartHelper.getmsflag(p)){
	    		memprice=p.getGdsmst_msprice().longValue();
	    	}
	    	double dl= Tools.getDouble(p.getGdsmst_memberprice().doubleValue()*10/p.getGdsmst_saleprice().doubleValue(),1);
	    	String fl=ProductGroupHelper.getRoundPrice((float)dl);
	    	String intrduce="";
			String req_gdsname = "";
			if(gdsidarr[m].indexOf("all")==-1){
			    if(!Tools.isNull(list.get(i).getSpgdsrcm_briefintrduce())){
			    	 intrduce = Tools.substring(Tools.clearHTML(list.get(i).getSpgdsrcm_briefintrduce()),60);
			    }
		    	if(!Tools.isNull(list.get(i).getSpgdsrcm_gdsname())){
		    		req_gdsname = list.get(i).getSpgdsrcm_gdsname();
				}
			}else{
				intrduce = p.getGdsmst_title();
				req_gdsname = p.getGdsmst_gdsname();
			}	
        	sb.append(getFenseFQModel(p,intrduce,req_gdsname,sm));
        }else{//validflag//通用模板结束
        	sb.append(getshopModelsizeother(p,fzimg,c));
        }
        }
		}
    	}//list>0	        	
	    
	    //String s = sb.toString();
	    //System.out.println("==="+s);
	    //out.print("{\"code\":1,content:\""+s+"\",click_flag:\""+click_flag2+"\"}");
	    Map<String,Object> map = new HashMap<String,Object>();
	    map.put("code",new Integer(1));
	    map.put("content",sb.toString());
	    map.put("click_flag",click_flag2);
	    out.print(JSONObject.fromObject(map));
	    return;        	
		}
	        				
	        	}//推荐位结束   
	    	   
	    	}
	    		
	    }
	    sb.append("</div>");
	    sb.append("</div>");
		
	}else{
		out.print("{\"code\":0,message:\"数据加载失败！\"}");
		return;
	}
%>
<%!
//粉色疯抢三种模板
public static String getFenseFQModel(Product p,String intrduce,String req_gdsname,ShopModel sm){
	//System.out.println("=======11111=======");
	if(p == null){
		return "";
	}
	long memprice=p.getGdsmst_memberprice().longValue();
	if(CartHelper.getmsflag(p)){
		memprice=p.getGdsmst_msprice().longValue();
	}
	double dl= Tools.getDouble(p.getGdsmst_memberprice().doubleValue()*10/p.getGdsmst_saleprice().doubleValue(),1);
	String fl=ProductGroupHelper.getRoundPrice((float)dl);
	String imgurl = "";
	if(!Tools.isNull(p.getGdsmst_imgurl())){
		imgurl = p.getGdsmst_imgurl().trim();
		if(imgurl.indexOf("shopadmin")>0){
			imgurl = "http://images.d1.com.cn"+imgurl;
		}else{
			imgurl = "http://images1.d1.com.cn"+imgurl;
		}
	}
	String img200250 = "";
	if(!Tools.isNull(p.getGdsmst_img200250())){
		img200250 = p.getGdsmst_img200250().trim();
		if(img200250.indexOf("shopadmin")>0){
			img200250 = "http://images.d1.com.cn"+img200250;
		}else{
			img200250 = "http://images1.d1.com.cn"+img200250;
		}
	}	
	String img240300 = "";
	if(!Tools.isNull(p.getGdsmst_img240300())){
		img240300 = p.getGdsmst_img240300().trim();
		if(img240300.indexOf("shopadmin")>0){
			img240300 = "http://images.d1.com.cn"+img240300;
		}else{
			img240300 = "http://images1.d1.com.cn"+img240300;
		}
	}	
	StringBuilder sb = new StringBuilder();
	sb.append("<dl class='fenfq' style='margin-bottom:15px; background-color: #FFFFFF;border:1px solid rgb(200,200,200);");
	//14粉色疯抢：200*200*4    15粉色疯抢：200*250*4    16粉色疯抢：240*300*3
	if(sm.getShopmodel_size()==14){
		sb.append(" margin-left:15px; width:224px; height:385px;");
	}else if(sm.getShopmodel_size()==15){
		sb.append(" margin-left:15px; width:224px; height:430px;");
	}else if(sm.getShopmodel_size()==16){
		sb.append(" margin-left:44px; width:264px; height:480px;");
	}
	sb.append("'>");
	sb.append("<dd>");
	sb.append("<table border='0' cellpadding='0' cellspacing='0' style='position: relative;'");
	if(sm.getShopmodel_size()==14){
		sb.append("width='224'  height='385'");
	}else if(sm.getShopmodel_size()==15){
		sb.append("width='224'  height='430'");
	}else if(sm.getShopmodel_size()==16){
		sb.append("width='264'  height='480'");
	}
	sb.append(">");
	sb.append("<tr>");
	if(sm.getShopmodel_size()==14){
		sb.append("<td style='padding:12px; height:200px;'>");
		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank' title='"+req_gdsname+"'>");
		sb.append("<img src='"+imgurl+"' width='200' height='200'>");
		sb.append("</a>");
		sb.append("</td>");
	}else if(sm.getShopmodel_size()==15){
		sb.append("<td style='padding:12px; height:250px;'>");
		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank' title='"+req_gdsname+"'>");
		sb.append("<img src='"+img200250+"' width='200' height='250'>");
		sb.append("</a>");
		sb.append("</td>");		
	}else if(sm.getShopmodel_size()==16){
		sb.append("<td style='padding:12px; height:300px;'>");
		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank' title='"+req_gdsname+"'>");
		sb.append("<img src='"+img240300+"' width='240' height='300'>");
		sb.append("</a>");
		sb.append("</td>");		
	}
	sb.append("</tr>"); 
	sb.append("<tr>");
	sb.append("<td height='42' style='text-align: left; padding-left: 12px; padding-right: 12px;'>");
	sb.append("<span class='zhekou_t' style='  color: #FFFFFF;'>"+fl+"折</span>");
	sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank' title='"+req_gdsname+"'>");
	sb.append("<span style=' font-family: 微软雅黑; font-size: 14px; line-height: 21px; padding-left: 36px;'>");
	sb.append(Tools.substring(Tools.clearHTML(req_gdsname),46)); 
	sb.append("</span>");
	sb.append("</a>");
	sb.append("</td>");
	sb.append("</tr>");
	sb.append("<tr>");
	if(sm.getShopmodel_size()!=16){
		sb.append("<td height='20' class='temaif'>");
	}else{
		sb.append("<td height='20' class='temaif2'>");
	}
	sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank' title='"+intrduce+"'>");
	sb.append("<span>"+intrduce+"</span>");
	sb.append("</a>");
	sb.append("</td>");
	sb.append("</tr>");
	sb.append("<tr align='left' style='line-height: 50px;'>");
	if(sm.getShopmodel_size()==16){
		sb.append("<td height='60' style='background: url(http://images.d1.com.cn/zt2014/0304/pricebg.gif)' >");
	}else{
		sb.append("<td height='60' style='background: url(http://images.d1.com.cn/zt2014/0304/pricebg.gif) no-repeat;' >");
	}
	sb.append("<span style='color: #FFFFFF;font-size: 20px; padding-left: 6px;'> ￥<span style='font-size: 42px;'>"+memprice+"</span></span>");
	sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
	sb.append("<span class='lijiqiang'></span>");
	sb.append("</a>");
	sb.append("</td>");
	sb.append("</tr>");
	sb.append("<tr>");
	sb.append("<td height='33' align='left' style='padding-left: 12px; text-align: left;'>市场价:￥"+p.getGdsmst_saleprice().longValue()+"</td>");
	sb.append("</tr>");
	sb.append("</table>");
	sb.append("</dd>");
	sb.append("</dl>");
	
	return sb.toString();
}
public static String getshopModelsize1(Product p,String imgurl,int c){
	if(p == null){
		return "";
	}
	StringBuilder sb = new StringBuilder();
	if(c%4==1){
		sb.append("<dl style='height:260px;margin-right:55px;margin-left:8px; '>");
		sb.append("<dt style='background:#fff;'>");
		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
		sb.append("<img src='"+imgurl+"' width='200' height='200'>");
		sb.append("</a>");
		sb.append("</dt>");
		sb.append("<dd style='width:200px; margin:0px;'>");
		sb.append("<span style='color:#8b8b8b;'>");
		sb.append("<font style='display:block; width:85%; margin:0px auto;'>");
		sb.append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),50));
		sb.append("</font>");
		float hyprice = 0;
		float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
		if(getmsflag(p)){
		memprice=Tools.getFloat(p.getGdsmst_msprice(),1);	
			sb.append("<font style='color:#7c7c7c;'>促销价：</font>");									 
		}
		sb.append("<font style='font-family:微软雅黑; color:#b80024; font-size:14px;'><b>￥").append(memprice).append("</b></font></span>");
		sb.append("</dd>");		         
		sb.append("</dl>");
	}else{
		sb.append("<dl style='height:260px;");
		if(c%4!=0){
			sb.append(" margin-right:55px;");
		}else{ 
			sb.append(" margin-right:0px; ");
		}
		sb.append("'>");
		sb.append("<dt style='background:#fff;'>");
		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
		sb.append("<img src='"+imgurl+"' width='200' height='200'>");
		sb.append("</a>");
		sb.append("</dt>");
		sb.append("<dd style='width:200px; margin:0px;'>");
		sb.append("<span style='color:#8b8b8b;'>");
		sb.append("<font style='display:block; width:85%; margin:0px auto;'>");
		sb.append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),50));
		sb.append("</font>");
		float hyprice = 0;
		float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
		if(getmsflag(p)){
			memprice=Tools.getFloat(p.getGdsmst_msprice(),1);	
			sb.append("<font style='color:#7c7c7c;'>促销价：</font>");									 
		}
		sb.append("<font style='font-family:微软雅黑; color:#b80024; font-size:14px;'><b>￥").append(memprice).append("</b></font></span>");
		sb.append("</dd>");		         
		sb.append("</dl>");
	}
	return sb.toString();
}
public static String getshopModelsize2(Product p,String recimg,int c){
	if(p == null){
		return "";
	}
	StringBuilder sb = new StringBuilder();
	sb.append("<dl style='height:220px;");
	if(c%5!=0){
		sb.append("margin-right:45px;");
	}else{ 
		sb.append("margin-right:0px; ");
	} 
	sb.append("'>");
	sb.append("<dt style='background:#fff;'>");
	sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
	sb.append("<img src='"+recimg+"' width='160' height='160'/>");
	sb.append("</a>");
	sb.append("</dt>");
	sb.append("<dd style='width:160px;margin:0px;'>");
	sb.append("<span style='color:#8b8b8b;'>");
	sb.append("<font style='display:block; width:85%; margin:0px auto;'>");
	sb.append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),40));
	sb.append("</font>");
	float hyprice = 0;
	float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
	if(getmsflag(p)){
		memprice=Tools.getFloat(p.getGdsmst_msprice(),1);	
		sb.append("<font style='color:#7c7c7c''>促销价：</font>");									 
	}
	sb.append("<font style='font-family:微软雅黑; color:#b80024; font-size:14px;'><b>￥");
	sb.append(memprice).append("</b></font></span>");
	sb.append("</dd>");		         
	sb.append("</dl>");
	return sb.toString();
}
public static String getshopModelsize3(Product p,String img200250,int c){
	if(p == null){
		return "";
	}
	StringBuilder sb = new StringBuilder();
	if(c%4==1){
		sb.append("<dl style='height:310px;margin-left:8px;margin-right:55px; '>");
		sb.append("<dt style='background:#fff;'>");
		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
		sb.append("<img src='"+img200250+"' width='200' height='250'>");
		sb.append("</a>");
		sb.append("</dt>");
		sb.append("<dd style='width:200px; margin:0px;'>");
		sb.append("<span style='color:#8b8b8b;'>");
		sb.append("<font style='display:block; width:85%; margin:0px auto;'>");
		sb.append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),50));
		sb.append("</font>");
		float hyprice = 0;
		float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
		if(getmsflag(p)){
			memprice=Tools.getFloat(p.getGdsmst_msprice(),1);	
			sb.append("<font style='color:#7c7c7c;'>促销价：</font>");									 
		}
		sb.append("<font style='font-family:微软雅黑; color:#b80024; font-size:14px;'><b>￥").append(memprice).append("</b></font></span>");
	    sb.append("</dd>");		         
		sb.append("</dl>");
	}else{
		sb.append("<dl style='height:310px;");
		if(c%4!=0){
			sb.append("margin-right:55px;");
		}else{ 
			sb.append("margin-right:0px; ");
		}
		sb.append("'>");
		sb.append("<dt style='background:#fff;'>");
		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
		sb.append("<img src='"+img200250+"' width='200' height='250'>");
		sb.append("</a>");
		sb.append("</dt>");
		sb.append("<dd style='width:200px; margin:0px;'>");
		sb.append("<span style='color:#8b8b8b;'>");
		sb.append("<font style='display:block; width:85%; margin:0px auto;'>");
		sb.append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),50));
		sb.append("</font>");
		float hyprice = 0;
		float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
		if(getmsflag(p)){
			memprice=Tools.getFloat(p.getGdsmst_msprice(),1);
			sb.append("<font style='color:#7c7c7c;'>促销价：</font>");								 
		}
		sb.append("<font style='font-family:微软雅黑; color:#b80024; font-size:14px;'><b>￥").append(memprice).append("</b></font></span>");
	    sb.append("</dd>");		         
		sb.append("</dl>");
	}
	return sb.toString();
}
public static String getshopModelsize4(Product p,String img240300,int c){
	if(p == null){
		return "";
	}
	StringBuilder sb = new StringBuilder();
	sb.append("<dl style='height:360px;");
	if(c%4!=0){
		sb.append("margin-right:6px;");
	}else{ 
		sb.append("margin-right:0px; ");
	}
	sb.append("'>");
	sb.append("<dt style='background:#fff;'>");
	sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
    sb.append("<img src='"+img240300+"' width='240' height='300'>");
    sb.append("</a>");
    sb.append("</dt>");
    sb.append("<dd style='width:240px;margin:0px;'>");
    sb.append("<span style='color:#8b8b8b;'>");
    sb.append("<font style='display:block; width:85%; margin:0px auto;'>");
    sb.append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60));
	sb.append("</font>");
    float hyprice = 0;
	float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
	if(getmsflag(p)){
		memprice=Tools.getFloat(p.getGdsmst_msprice(),1);	
		sb.append("<font style='color:#7c7c7c;'>促销价：</font>");
	}
	sb.append("<font style='font-family:微软雅黑; color:#b80024; font-size:14px;'><b>￥").append(memprice).append("</b></font></span>");
    sb.append("</dd>");		         
	sb.append("</dl>");
	return sb.toString();
}
public static String getshopModelsize5(Product p,String img240300,int c){
	if(p == null){
		return "";
	}
	StringBuilder sb = new StringBuilder();
	if(c%3==1){
		sb.append("<dl style='height:360px;margin-right:90px;margin-left:40px;  '>");
		sb.append("<dt style='background:#fff;'>");
		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
		sb.append("<img src='"+img240300+"' width='240' height='300'>");
	    sb.append("</a>");
	    sb.append("</dt>");
	    sb.append("<dd style='width:240px;margin:0px;'>");
	    sb.append("<span style='color:#8b8b8b;'>");
	    sb.append("<font style='display:block; width:85%; margin:0px auto;'>");
	    sb.append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60));
		sb.append("</font>");
	    float hyprice = 0;
		float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
		if(getmsflag(p)){
			memprice=Tools.getFloat(p.getGdsmst_msprice(),1);	
			sb.append("<font style='color:#7c7c7c;'>促销价：</font>");							 
		}
		sb.append("<font style='font-family:微软雅黑; color:#b80024; font-size:14px;'><b>￥").append(memprice).append("</b></font></span>");
	    sb.append("</dd>");		         
		sb.append("</dl>");
	}
	if(c%3==2){
		sb.append("<dl style='height:360px;margin-right:90px;margin-left:0px; '>");
	   	sb.append("<dt style='background:#fff;'>");
	    sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
		sb.append("<img src='"+img240300+"' width='240' height='300'>");
	    sb.append("</a>");
	    sb.append("</dt>");
	    sb.append("<dd style='width:240px;margin:0px;'>");
	    sb.append("<span style='color:#8b8b8b;'>");
	    sb.append("<font style='display:block; width:85%; margin:0px auto;'>");
	    sb.append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60));
		sb.append("</font>");
	    float hyprice = 0;
		float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
		if(getmsflag(p)){
			memprice=Tools.getFloat(p.getGdsmst_msprice(),1);
			sb.append("<font style='color:#7c7c7c;'>促销价：</font>");									 
		}
		sb.append("<font style='font-family:微软雅黑; color:#b80024; font-size:14px;'><b>￥").append(memprice).append("</b></font></span>");
	    sb.append("</dd>");		         
		sb.append("</dl>");
	}
	if(c%3==0){ 
		sb.append("<dl style='height:360px;margin-right:40px;margin-left:0px;  '>");
		sb.append("<dt style='background:#fff;'>");
	    sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
		sb.append("<img src='"+img240300+"' width='240' height='300'>");
    	sb.append("</a>");
    	sb.append("</dt>");
	    sb.append("<dd style='width:240px;margin:0px;'>");
	    sb.append("<span style='color:#8b8b8b;'>");
	    sb.append("<font style='display:block; width:85%; margin:0px auto;'>");
	    sb.append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60));
		sb.append("</font>");
	    float hyprice = 0;
		float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
		if(getmsflag(p)){
			memprice=Tools.getFloat(p.getGdsmst_msprice(),1);	
			sb.append("<font style='color:#7c7c7c;'>促销价：</font>");							 
	}
		sb.append("<font style='font-family:微软雅黑; color:#b80024; font-size:14px;'><b>￥").append(memprice).append("</b></font></span>");
	    sb.append("</dd>");		         
		sb.append("</dl>");
	}
	return sb.toString();
}
public static String getshopModelsize7(Product p,String img240300){
	if(p == null){
		return "";
	}
	StringBuilder sb = new StringBuilder();
	sb.append("<dl style='width:240px;height:350px;padding-left:4px;'>");
	sb.append("<dd>");
	sb.append("<table width='240' height='350' border='0' cellpadding='0' cellspacing='0' >");
	sb.append("<tr>");
	sb.append("<td width='240' height='300' colspan='3'>");
	sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank' title='"+ p.getGdsmst_gdsname()+"'>");
	sb.append("<div class='imgdp' style='background-image: url("+img240300+");'>");
	sb.append("<span class='imgdpt'>").append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60));
	sb.append("</span>");
	sb.append("</div>");
	sb.append("</a>");
	sb.append("</td>");
	sb.append("</tr>");
	sb.append("<tr bgcolor='#6d0609'>");
	long memprice=p.getGdsmst_memberprice().longValue();
	if(getmsflag(p)){
		memprice=p.getGdsmst_msprice().longValue();
	}
    sb.append("<td width='85'><span class='STYLE1'>抢购价￥</span></td>");
    sb.append("<td width='60' rowspan='2' align='left'><span class='STYLE2'>").append(memprice).append("</span></td>");
    sb.append("<td width='95' rowspan='2' align='left'>");
	sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
	sb.append("<img src='http://images.d1.com.cn/zt2013/20140109/dangjiqiangx.jpg' />");
	sb.append("</a>");
	sb.append("</td>");
	sb.append("</tr>");
	sb.append("<tr bgcolor='#6d0609'>");
	sb.append("<td width='90'><span class='STYLE3'><s>市场价￥").append(p.getGdsmst_saleprice().longValue()).append("</s></span></td>");
	sb.append("</tr>");
	sb.append("</table>");
	sb.append("</dd>");
	sb.append("</dl>");
	return sb.toString();
}
public static String getshopModelsize8(Product p,String img200250){
	if(p == null){
		return "";
	}
	StringBuilder sb = new StringBuilder();
	sb.append("<dl style='width:240px;height:300px;padding-left:4px;'>");
	sb.append("<dd>");
	sb.append("<table width='240' height='300' border='0' cellpadding='0' cellspacing='0'>");
	sb.append("<tr>");
	sb.append("<td width='240' height='250' colspan='3'>");
	sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank' title='"+ p.getGdsmst_gdsname()+"'>");
	sb.append("<div class='imgdp250' style='background-image: url("+img200250+");'>");
	sb.append("<span class='imgdpt'>").append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60));
	sb.append("</span>");
	sb.append("</div>");
	sb.append("</a>");
	sb.append("</td>");
	sb.append("</tr>");
	sb.append("<tr bgcolor='#6d0609'>");
	sb.append("<td width='85'><span class='STYLE1'>抢购价￥</span></td>");
	long memprice=p.getGdsmst_memberprice().longValue();
	if(getmsflag(p)){
		memprice=p.getGdsmst_msprice().longValue();
	}
	sb.append("<td width='60' rowspan='2' align='left'><span class='STYLE2'>").append(memprice).append("</span></td>");
	    sb.append("<td width='95' rowspan='2' align='left'>");
	sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
	sb.append("<img src='http://images.d1.com.cn/zt2013/20140109/dangjiqiangx.jpg'/>");
	sb.append("</a>");
	sb.append("</td>");
	sb.append("</tr>");
	sb.append("<tr bgcolor='#6d0609'>");
	sb.append("<td width='90'><span class='STYLE3'><s>市场价￥").append(p.getGdsmst_saleprice().longValue()).append("</s></span></td>");
	sb.append("</tr>");
	sb.append("</table>");
	sb.append("</dd>");
	sb.append("</dl>");
	return sb.toString();
}
public static String getshopModelsize9(Product p,String imgurl){
	if(p == null){
		return "";
	}
	StringBuilder sb = new StringBuilder();
	sb.append("<dl style='width:240px;height:250px;padding-left:4px;'>");
	sb.append("<dd>");
	sb.append("<table width='240' height='250' border='0' cellpadding='0' cellspacing='0'>");
	sb.append("<tr>");
	sb.append("<td width='240' height='200' colspan='3'>");
	sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank' title='"+ p.getGdsmst_gdsname()+"'>");
	sb.append("<div class='imgdp200' style='background-image: url("+imgurl+");'>");
	sb.append("<span class='imgdpt'>").append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60));
	sb.append("</span>");
	sb.append("</div>");
	sb.append("</a>");
	sb.append("</td>");
	sb.append("</tr>");
	sb.append("<tr bgcolor='#6d0609'>");
	sb.append("<td width='85'><span class='STYLE1'>抢购价￥</span></td>"); 
	long memprice=p.getGdsmst_memberprice().longValue();
	if(getmsflag(p)){
		memprice=p.getGdsmst_msprice().longValue();
	}
	sb.append("<td width='60' rowspan='2' align='left'><span class='STYLE2'>").append(memprice).append("</span></td>");
	sb.append("<td width='95' rowspan='2' align='left'>");
	sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
	sb.append("<img src='http://images.d1.com.cn/zt2013/20140109/dangjiqiangx.jpg'/>");
	sb.append("</a>");
	sb.append("</td>");
	sb.append("</tr>");
	sb.append("<tr bgcolor='#6d0609'>");
	sb.append("<td width='90'><span class='STYLE3'><s>市场价￥").append(p.getGdsmst_saleprice().longValue()).append("</s></span></td>");
	sb.append("</tr>");
	sb.append("</table>");
	sb.append("</dd>");
	sb.append("</dl>");
	return sb.toString();
}
public static String getshopModelsizeother(Product p,String fzimg,int c){
	if(p == null){
		return "";
	}
	StringBuilder sb = new StringBuilder();
	if(c%4==1){
		sb.append("<dl style='height:260px;margin-right:100px;margin-left:20px;'>");
		sb.append("<dt style='background:#fff;'>");
		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
		sb.append("<img src='"+fzimg+"' width='160' height='200'>");
		sb.append("</a>");
		sb.append("</dt>");
		sb.append("<dd style='width:160px;margin:0px;'>");
		sb.append("<span style='color:#8b8b8b;'>");
		sb.append("<font style='display:block; width:85%; margin:0px auto;'>");
		sb.append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),40));
		sb.append("</font>");
	    float hyprice = 0;
	 	float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
		if(getmsflag(p)){
			memprice=Tools.getFloat(p.getGdsmst_msprice(),1);
			sb.append("<font style='color:#7c7c7c''>促销价：</font>");								 
		}
		sb.append("<font style='font-family:微软雅黑; color:#b80024; font-size:14px;'><b>￥").append(memprice).append("</b></font>");
		sb.append("</span>");
		sb.append("</dd>");		         
		sb.append("</dl>");
	}
	else if(c%4==2||c%4==3){
		sb.append("<dl style='height:260px;margin-right:100px;margin-left:0px;'>");
		sb.append("<dt style='background:#fff;'>");
		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
		sb.append("<img src='"+fzimg+"' width='160' height='200'>");
		sb.append("</a>");
		sb.append("</dt>");
		sb.append("<dd style='width:160px;margin:0px;'>");
		sb.append("<span style='color:#8b8b8b;'>");
		sb.append("<font style='display:block; width:85%; margin:0px auto;'>");
		sb.append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),40));
		sb.append("</font>");
	    float hyprice = 0;
	 	float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
		if(getmsflag(p)){
			memprice=Tools.getFloat(p.getGdsmst_msprice(),1);
			sb.append("<font style='color:#7c7c7c''>促销价：</font>");								 
		}
		sb.append("<font style='font-family:微软雅黑; color:#b80024; font-size:14px;'><b>￥").append(memprice).append("</b></font>");
		sb.append("</span>");
		sb.append("</dd>");		         
		sb.append("</dl>");
	}else{
		sb.append("<dl style='height:260px;margin-right:20px;margin-left:0px;'>");
		sb.append("<dt style='background:#fff;'>");
		sb.append("<a href='http://www.d1.com.cn/Product/"+p.getId()+"' target='_blank'>");
    	sb.append("<img src='"+fzimg+"' width='160' height='200'>");
    	sb.append("</a>");
		sb.append("</dt>");
		sb.append("<dd style='width:160px;margin:0px;'>");
		sb.append("<span style='color:#8b8b8b;'>");
		sb.append("<font style='display:block; width:85%; margin:0px auto;'>");
		sb.append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),40));
		sb.append("</font>");
	    float hyprice = 0;
	 	float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
		if(getmsflag(p)){
			memprice=Tools.getFloat(p.getGdsmst_msprice(),1);	
	 		sb.append("<font style='color:#7c7c7c''>促销价：</font>");									 
	 }
		sb.append("<font style='font-family:微软雅黑; color:#b80024; font-size:14px;'><b>￥").append(memprice).append("</b></font>");
		sb.append("</span>");
		sb.append("</dd>");		         
		sb.append("</dl>");
	}
	return sb.toString();
}
//获取新品
	public static ArrayList<Product> getProductList(String shopcode,int num){
		ArrayList<Product> list=new ArrayList<Product>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_shopcode", shopcode));
		clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("gdsmst_createdate"));
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,num);
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Product)be);
			}
		}	
		else
		{
			return null;
		}
	     return list;
	}
%>