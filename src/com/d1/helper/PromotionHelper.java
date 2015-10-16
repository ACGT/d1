package com.d1.helper;

import java.util.Date;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Promotion;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.StringUtils;
import com.d1.util.Tools;

/**
 * 推荐位工具类
 * @author zpp
 *
 */
public class PromotionHelper {
	/**
	 * 根据推荐位号获得推荐列表
	 * @return
	 */
	public static ArrayList<Promotion> getBrandList(String[] codes){
		if(codes==null||codes.length==0)return null;
		ArrayList<Promotion> list = new ArrayList<Promotion>();
		
		for(int i=0;i<codes.length;i++){
			if(!StringUtils.isDigits(codes[i]))continue;
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("splmst_code", new Long(codes[i])));
			
			List<BaseEntity> b_list = Tools.getManager(Promotion.class).getList(clist, null, 0, 1000);
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((Promotion)be);
				}
			}
			
		}
		Collections.sort(list,new PromotionComparator());
		
		return list ;
	}


	
	/**
	 * 根据推荐位号获得推荐列表
	 * @param code - 推荐位
	 * @param count - 取几位，如果<=0则为100
	 * @return ArrayList<Promotion>
	 */
	public static ArrayList<Promotion> getBrandListByCode(String code , int count){
		if(!Tools.isMath(code)) return null;
		if(count <= 0) count = 100;
		ArrayList<Promotion> list = new ArrayList<Promotion>();

		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("splmst_code", new Long(code)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("splmst_seqview"));
		List<BaseEntity> b_list = Tools.getManager(Promotion.class).getList(clist, olist, 0, count);
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Promotion)be);
			}
		}
		return list ;
	}
	/**
	 * 获取图片路径
	 * @return
	 */
	public static String getPathUrl(int urltype,String fromurl){
		String geturl="";
		if(urltype==1){
			geturl="http://www.d1.com.cn/html/"+fromurl+".htm";
		}
		else if(fromurl.equals("#")){
			geturl="javascript:;";
		}
		else{
			geturl=fromurl;
		}
		return geturl;
	}
	
	public static String getImgPromotion(String code,int count){
		StringBuilder sb=new StringBuilder();
		ArrayList<Promotion> list=PromotionHelper.getBrandListByCode(code,count);
		if(list!=null && list.size()>0){
			for(Promotion promotion:list){
				if(!promotion.getSplmst_url().equals("#")){
					sb.append("<a href=\"").append(PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))).append("\" target=\"_blank\">");
				}
				sb.append("<img src=\"").append(promotion.getSplmst_picstr()).append("\"  alt=\"").append(promotion.getSplmst_name()).append("\" border=\"0\">");
				if(!promotion.getSplmst_url().equals("#")){
					sb.append("</a>");
				}
			
			}
		}
		return sb.toString();
	}
	
	/**
	 * 根据推荐位号获得(北方)推荐列表
	 * @param code - 推荐位
	 * @param count - 取几位，如果<=0则为100
	 * @return ArrayList<Promotion>
	 */
	public static ArrayList<Promotion> getBrandListByCodeAndArea(String code ,String area, int count){
		if(!Tools.isNumber(code)) return null;
		if(count <= 0) count = 100;
		ArrayList<Promotion> list = new ArrayList<Promotion>();

		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("splmst_code", new Long(code)));
		//clist.add(Restrictions.ge("splmst_tjendtime", new Date()));
		if(!Tools.isNull(area)&&Tools.isNumber(area))
		{
			if(Tools.parseInt(area)==2){
			   clist.add(Restrictions.ne("splmst_areaid", new Long(1)));
			}
			else if(Tools.parseInt(area)==1)
			{
				clist.add(Restrictions.le("splmst_areaid", new Long(area)));
			}
			else
			{
				
			}
		}
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("splmst_seqview"));
		List<BaseEntity> b_list = Tools.getManager(Promotion.class).getList(clist, olist, 0, count);
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Promotion)be);
			}
		}
		return list ;
	}
	
	/**
	 * 图片文字推荐<a><img></a>
	 * @return
	 
	public static String getBrandImgText(String[] codes){
		ArrayList<Promotion> list=getBrandList(codes);
		StringBuffer str=new StringBuffer();
		if(list!=null){
			for(int i=0;i<list.size();i++){
				Promotion promotion=list.get(i);
				if(!(i==0 && promotion.getSplmst_seqview().intValue()==0)){
					str.append("<li>");
				}
				if(!promotion.getSplmst_url().equals("#")){
					str.append("<a href=\""+getPathUrl(0,promotion.getSplmst_url())+"\" target=\"_blank\">");
				}
				str.append("<img src=\""+promotion.getSplmst_picstr()+"\"  alt=\""+promotion.getSplmst_name()+"\">");
				if(!promotion.getSplmst_url().equals("#")){
					str.append("</a>");
				}
				if(i==0 && promotion.getSplmst_seqview().intValue()==0){
				    str.append("<br/>");
				}else{
					str.append("</li>");
				}
			}
		}
		return str.toString();
	}
	*/
	/**
	 * 图片推荐<a><img></a>
	 * @return
	
	public static String getBrandImg(String[] codes){
		ArrayList<Promotion> list=getBrandList(codes);
		StringBuffer str=new StringBuffer();
		if(list!=null){
			for(int i=0;i<list.size();i++){
				Promotion promotion=list.get(i);
				if(!promotion.getSplmst_url().equals("#")){
					str.append("<a href=\""+getPathUrl(0,promotion.getSplmst_url())+"\" target=\"_blank\">");
				}
				str.append("<img src=\""+promotion.getSplmst_picstr()+"\" >");
				if(!promotion.getSplmst_url().equals("#")){
					str.append("</a>");
				}
				
			}
		}
		return str.toString();
	}*/
	
} 
class PromotionComparator implements Comparator<Promotion>{

	@Override
	public int compare(Promotion p0, Promotion p1) {
		if(p0.getSplmst_code()!=null&&p1.getSplmst_code()!=null){
			if(p0.getSplmst_code().longValue()>p1.getSplmst_code().longValue()){
				return 1 ;
			}else if(p0.getSplmst_code().longValue()==p1.getSplmst_code().longValue()){
				
				if(p0.getSplmst_seqview()!=null&&p1.getSplmst_seqview()!=null){
					if(p0.getSplmst_seqview().longValue()>p1.getSplmst_seqview().longValue()){
						return 1;
					}else if(p0.getSplmst_seqview().longValue()<p1.getSplmst_seqview().longValue()){
						return -1;
					}
				}
				
				return 0 ;
				
			}else{
				return -1 ;
			}
		}
		return 0;
	}
}
