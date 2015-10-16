package com.d1.helper;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.PayMethod;
import com.d1.bean.Ticket;
import com.d1.bean.TicketCrd;
import com.d1.bean.TicketFlag;
import com.d1.bean.TicketGroup;
import com.d1.bean.TicketPwd;
import com.d1.bean.User;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.StringUtils;
import com.d1.util.Tools;


/**
 * E券（购物券）相关处理方法。
 * @author kk
 *
 */
public class TicketHelper {
	
	/**
	 * 通过ID找到对象
	 * @param id
	 * @return v
	 */
	public static Ticket getById(String id) {
		if(!Tools.isMath(id)) return null;
		return (Ticket)Tools.getManager(Ticket.class).get(id);
	}
	
	/**
	 * 通过ID找到对象
	 * @param id
	 * @return TicketCrd
	 */
	public static TicketCrd getCrdById(String id){
		if(!Tools.isMath(id)) return null;
		return (TicketCrd)Tools.getManager(TicketCrd.class).get(id);
	}
	
	/**
	 * 验证Ticket是否有效
	 * @param request
	 * @param response
	 * @param payid
	 * @param ticket Ticket对象
	 * @return
	 */
	public static boolean validTicket(HttpServletRequest request,HttpServletResponse response,String payid,Ticket ticket){
		if(ticket==null)return false ; 
		ArrayList<Ticket> list = getAllLoginUserAvaiableTickets(request,response,payid);
		 if(list==null||list.size()==0)return false ;
		 for(Ticket t:list){
			 if(ticket.getId().equals(t.getId()))return true ;
		 }
		 return false ;
	}
	
	/**
	 * 验证TicketCrd是否有效
	 * @param request
	 * @param response
	 * @param payid
	 * @param ticketCrd TicketCrd对象
	 * @return
	 */
	public static boolean validTicketCrd(HttpServletRequest request,HttpServletResponse response,String payid,TicketCrd ticketCrd){
		if(ticketCrd==null)return false ; 
		ArrayList<TicketCrd> list = getAllLoginUserAvaiableTicketCrds(request,response,payid);
		 if(list==null||list.size()==0)return false ;
		 for(TicketCrd t:list){
			 if(ticketCrd.getId().equals(t.getId()))return true ;
		 }
		 return false ;
	}
	
	/**
	 * 获取优惠券能减免的金额，用于最后算总价。直减券可以减运费，折扣券不算运费！！！
	 * ---高军亮如果是直减券不从这儿计算最终的券的最终金额，应在商品金额+运费比较后的金额
	 * ，如果返回的券金额大于 商品金额+运费则最终用券的金额应该是 商品金额+运费，否则是券的金额
	 * @param request
	 * @param response
	 * @param ticket_id 使用的优惠券id，即用户选择的优惠券
	 * @param ticket_type 使用券的类型，0表示减免券，1表示折扣券，2表示品牌减免。当ticket_type=2时，就不会管ticket_id了
	 * @param addressId 用户的地址id
	 * @param payid 用户的支付方式
	 * @return
	 */
	public static float getMaxTicketSaveMoney(HttpServletRequest request,HttpServletResponse response,
			String ticket_id,String ticket_type,String addressId,String payId){
		
		User loginUser = UserHelper.getLoginUser(request, response) ;
		
		if(loginUser==null)return 0f ;//没登录
		
		float normal_money = CartHelper.getNormalProductMoney(request, response);//最多能减多少钱
		//float shipfee = OrderHelper.getExpressFee(request, response, addressId, payId);//运费
		
		if("0".equals(ticket_type)){//tktmst减免券，可以减运费
			Ticket ticket = (Ticket)Tools.getManager(Ticket.class).get(ticket_id);
			
			if(ticket!=null&&!loginUser.getId().equals(ticket.getTktmst_mbrid()+""))return 0f;//做一下安全判断，不能使用别人的优惠券
			
			if(TicketHelper.validTicket(request, response, payId, ticket)){//有效
				String shopcode=ticket.getTktmst_shopcodes();
				if(Tools.isNull(shopcode))shopcode="00000000";
				if(!shopcode.equals("11111111")){
				normal_money = CartHelper.getShopNormalProductMoney(request, response,shopcode);
				}
				if(ticket!=null&&ticket.getTktmst_value()!=null&&ticket.getTktmst_value().floatValue()>0){
					//float max_cut_money = normal_money  ;//最多减免多少
					float cartMoney_2344 = 0f ;//可以打折的商品总金额
					if(Tools.isNull(ticket.getTktmst_rackcode())||"000".equals(ticket.getTktmst_rackcode()))cartMoney_2344=normal_money;
					else cartMoney_2344=CartHelper.getTotalRackcodePayMoney2(request,response,ticket.getTktmst_rackcode(),ticket.getTktmst_shopcodes());
					float 	max_cut_money = ticket.getTktmst_value().floatValue() ;
				//System.out.println("d1gjlrackcode"+ticket.getTktmst_rackcode()+"----"+cartMoney_2344);
					if(cartMoney_2344<max_cut_money&&ticket.getTktmst_gdsvalue().longValue()!=0){//分类券才这么计算券的减免
					//if(ticket.getTktmst_value().floatValue()<max_cut_money){
					 	max_cut_money =cartMoney_2344 ;
					//}
					}
					//System.out.println("d1gjlrackcode"+max_cut_money);
					return Tools.getFloat(max_cut_money,2);
				}
			}
		}else if("1".equals(ticket_type)){//tktcrd折扣券
			TicketCrd ticket123 = (TicketCrd)Tools.getManager(TicketCrd.class).get(ticket_id);
			
			if(!loginUser.getId().equals(ticket123.getTktcrd_mbrid()+""))return 0f;//做一下安全判断，不能使用别人的优惠券
			
			if(TicketHelper.validTicketCrd(request, response, payId, ticket123)){//验证是否有效
				String shopcode="00000000";
				
				normal_money = CartHelper.getShopNormalProductMoney(request, response,shopcode);
				if(ticket123!=null&&ticket123!=null&&ticket123.getTktcrd_realvalue()!=null&&ticket123.getTktcrd_realvalue().floatValue()>0){
					if (ticket123.getTktcrd_brandname()!=null&&ticket123.getTktcrd_brandname().length()>0){
						if(CartHelper.getCartBrandPayMoney2(request, response, ticket123.getTktcrd_brandname().trim(),"00000000")>0){
							normal_money=CartHelper.getCartBrandPayMoney2(request, response, ticket123.getTktcrd_brandname().trim(),"00000000");
						}else{
							return 0f;
						}
						}
					if(!Tools.isNull(ticket123.getTktcrd_rackcode())&&!"000".equals(ticket123.getTktcrd_rackcode())){
						normal_money=CartHelper.getTotalRackcodePayMoney2(request,response,ticket123.getTktcrd_rackcode(),"00000000");
					}
					float max_get_money = normal_money*ticket123.getTktcrd_discount().floatValue() ;//最多能减免的金额 
			
					//剩余金额
					if(ticket123.getTktcrd_realvalue().floatValue()<max_get_money){
						max_get_money=ticket123.getTktcrd_realvalue().floatValue();
					}
					
					return Tools.getFloat(max_get_money,2);
				}
			}
		}else if("2".equals(ticket_type)){//品牌减免
			float ticket_money = TicketHelper.getBrandCutMoney(request, response);//品牌减免最多能减多少
			if(ticket_money>0){//满足品牌减免
				float max_get_money = 0f ;
				if(normal_money>ticket_money){
					max_get_money = ticket_money ;
				}else{//不太可能
					max_get_money = normal_money;
				}
				
				return Tools.getFloat(max_get_money,2);
			}
		}
		else if("3".equals(ticket_type))
		{
			return 100f;
		}
		return 0f;
	}
	
	/**
	 * 得到品牌减免金额，产生一个虚拟券
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getBrandCutMoney(HttpServletRequest request,HttpServletResponse response){
		return CartHelper.getBrandCutMoney(request, response);
	}
	
	/**
	 * 获取全部用户的优惠券，包括tktmst和tktcrd
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<TicketWrap> getTotalLoginUserTickets(HttpServletRequest request,HttpServletResponse response){
		User lUser = UserHelper.getLoginUser(request, response);
		if(lUser==null)return null;
		ArrayList<TicketHelper.TicketWrap> rlist = new ArrayList<TicketHelper.TicketWrap>();
		ArrayList<Ticket> list1 = getAllUserTickets(lUser.getId(),"-1");
		ArrayList<TicketCrd> list2 = getAllUserTicketCrds(lUser.getId(),true,"-1");
		
		if(list1!=null){
			for(Ticket t:list1){
				TicketHelper.TicketWrap tw = new TicketHelper.TicketWrap();
				tw.setType(0);
				tw.setCreateDate(t.getTktmst_createdate());
				tw.setTicket(t);
				rlist.add(tw);
			}
		}
		
		if(list2!=null){
			for(TicketCrd t:list2){
				TicketHelper.TicketWrap tw = new TicketHelper.TicketWrap();
				tw.setCreateDate(t.getTktcrd_createdate());
				tw.setType(1);
				tw.setTicketCrd(t);
				rlist.add(tw);
			}
		}
		
		Collections.sort(rlist,new TicketWrapCreateDateComparator());
		return rlist ;
	}
	
	/**
	 * 得到所有该用户能用的减免券，已经判断购物车金额等条件
	 * @param request
	 * @param response
	 * @param payid
	 * @return
	 */
	public static ArrayList<TicketCrd> getAllLoginUserAvaiableTicketCrds(HttpServletRequest request,HttpServletResponse response,String payid){
		if(!UserHelper.isLogin(request, response)){
			return null ;
		}
		User loginUser = UserHelper.getLoginUser(request, response);//登陆用户
		
		ArrayList<TicketCrd> rlist = new ArrayList<TicketCrd>();//要返回的结果
		
		ArrayList<TicketCrd> list = getAllUserAvaiableTicketCrds(loginUser.getId(),payid);
		
		if(list!=null&&list.size()>0){
			for(TicketCrd tc:list){
				if(payid!=null&&tc.getTktcrd_payid()!=null&&tc.getTktcrd_payid().longValue()!=-1
						&&!payid.equals(tc.getTktcrd_payid()+""))continue;//支付方式不对
				
				if(tc.getTktcrd_validates()!=null&&tc.getTktcrd_validatee()!=null){
					if(tc.getTktcrd_validates().getTime()<System.currentTimeMillis()&&
							tc.getTktcrd_validatee().getTime()>=System.currentTimeMillis()){
						if (tc.getTktcrd_brandname()!=null&&tc.getTktcrd_brandname().length()>0){
							if(CartHelper.getCartBrandPayMoney2(request, response, tc.getTktcrd_brandname().trim(),"00000000")>0){
								if(UserHelper.isPingAnUser(request, response)){
									if(tc.getTktcrd_cardno()!=null&&(tc.getTktcrd_cardno().toLowerCase().startsWith("pingan")
											||tc.getTktcrd_cardno().toLowerCase().startsWith("pa")||tc.getTktcrd_cardno().indexOf("_")>=0)){
										rlist.add(tc);
									}
								}else{
									rlist.add(tc);//有效期内
								}
							}
						}
						else{
							if(UserHelper.isPingAnUser(request, response)){
								if(tc.getTktcrd_cardno()!=null&&(tc.getTktcrd_cardno().toLowerCase().startsWith("pingan")
										||tc.getTktcrd_cardno().toLowerCase().startsWith("pa")||tc.getTktcrd_cardno().indexOf("_")>=0)){
									rlist.add(tc);
								}
							}else{
								rlist.add(tc);//有效期内
							}
						}
					}
				}
			}
		}
		return rlist ;
	}
	
	/**
	 * 根据当前购物车情况获取所有可用的Ticket购物券，已经判断过各种条件。
	 * @param payid 支付方式，对应paymst表
	 * @return
	 */
	public static ArrayList<Ticket> getAllLoginUserAvaiableTickets(HttpServletRequest request,HttpServletResponse response,String payid){
		if(!UserHelper.isLogin(request, response)){
			return null ;
		}
		
		User loginUser = UserHelper.getLoginUser(request, response);//登陆用户
		
		ArrayList<Ticket> rlist = new ArrayList<Ticket>();//要返回的结果
		
		//然后增加
		ArrayList<Ticket> list = getAllUserAvaiableTickets(loginUser.getId(),payid);
		
		if(list==null||list.size()==0)return null;
		
		for(Ticket ticket:list){
			
			if(ticket.getTktmst_brandname()!=null&&ticket.getTktmst_brandname().trim().length()>0&&ticket.getTktmst_gdsvalue()!=null){//设置了品牌限制
				if(CartHelper.getCartBrandPayMoney2(request, response, ticket.getTktmst_brandname().trim(),ticket.getTktmst_shopcodes())<ticket.getTktmst_gdsvalue().floatValue())continue;
			}
			
			if(ticket.getTktmst_sprckcodeStr()!=null&&ticket.getTktmst_sprckcodeStr().trim().length()>0&&ticket.getTktmst_gdsvalue()!=null){//设置了品牌限制
				if(CartHelper.getCartSprckcodePayMoney(request, response, ticket.getTktmst_sprckcodeStr())<ticket.getTktmst_gdsvalue().floatValue())continue;
			}
			
			float cartMoney = CartHelper.getTotalRackcodePayMoney2(request, response,ticket.getTktmst_rackcode(),ticket.getTktmst_shopcodes());//购物车能用券金额
			if(ticket.getTktmst_gdsvalue()!=null&&ticket.getTktmst_gdsvalue().floatValue()>0&&cartMoney<ticket.getTktmst_gdsvalue().floatValue())continue;//金额不满足不取
			
			if(payid!=null&&ticket.getTktmst_payid()!=null&&
					ticket.getTktmst_payid().longValue()!=-1&&
					!payid.equals(ticket.getTktmst_payid()+""))continue;//支付方式不对也不取
			
			if(!CartHelper.existsDirectory(request, response,ticket.getTktmst_rackcode()))continue;//购物车分类不满足也不取
			if(!CartHelper.existsShopCodeP(request, response,ticket.getTktmst_shopcodes()))continue;
			if(ticket.getTktmst_validates()!=null&&ticket.getTktmst_validatee()!=null){
				if(ticket.getTktmst_validates().getTime()<System.currentTimeMillis()&&
						ticket.getTktmst_validatee().getTime()>=System.currentTimeMillis()){
					if(UserHelper.isPingAnUser(request, response)){
						if(ticket.getTktmst_cardno()!=null&&(ticket.getTktmst_cardno().toLowerCase().startsWith("pingan")||ticket.getTktmst_cardno().toLowerCase().startsWith("pa"))){
							rlist.add(ticket);
						}
					}else{
						rlist.add(ticket);//有效期内
					}
				}
			}
		}
		return rlist ;
	}
	
	/**
	 * 获取用户所有能用的购物券。
	 * @param userId
	 * @param flag true表示取所有，false只取未使用的
	 * @param payid 支付方式
	 * @return
	 */
	private static ArrayList<Ticket> getAllUserTickets(String userId,boolean flag,String payid){
		if(Tools.isNull(userId))return null;
		ArrayList<Ticket> list = new ArrayList<Ticket>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("tktmst_mbrid", new Long(userId)));
		
		if(!flag){
			clist.add(Restrictions.eq("tktmst_validflag", new Long(0)));//0 未使用
			clist.add(Restrictions.ne("tktmst_ifcrd", new Long(1)));//tktmst_ifcrd<>1 等于1表示从crd生成的
		}
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("tktmst_createdate"));//按创建时间排序
		
		List<BaseEntity> rlist = Tools.getManager(Ticket.class).getList(clist, olist, 0, 1000);
		if(rlist==null||rlist.size()==0)return null;
		
		for(BaseEntity b:rlist){
			list.add((Ticket)b);
		}
		
		return list ;
	}
	
	/**
	 * 得到用户所有减免券
	 * @param userId
	 * @param flag true表示取所有，false只取可用的
	 * @param payid
	 * @return
	 */
	private static ArrayList<TicketCrd> getAllUserTicketCrds(String userId,boolean flag,String payid){
		if(Tools.isNull(userId))return null;
		ArrayList<TicketCrd> list = new ArrayList<TicketCrd>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("tktcrd_mbrid", new Long(userId)));//会员id
		
		if(!flag){
			clist.add(Restrictions.gt("tktcrd_realvalue", new Long(0)));//剩余金额大于0
			clist.add(Restrictions.eq("tktcrd_validflag", new Long(1)));//tktcrd_validflag=1表示是刮开的
		}
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("tktcrd_createdate"));//按创建时间排序
		
		List<BaseEntity> rlist = Tools.getManager(TicketCrd.class).getList(clist, olist, 0, 1000);
		if(rlist==null||rlist.size()==0)return null;
		
		for(BaseEntity b:rlist){
			list.add((TicketCrd)b);
		}
		
		return list ;
	}
	
	/**
	 * 取所有能用的tickets
	 * @param userId
	 * @param payid 支付方式
	 * @return
	 */
	public static ArrayList<Ticket> getAllUserAvaiableTickets(String userId,String payid){
		return getAllUserTickets(userId,false,payid);
	}
	
	/**
	 * 取所有能用得ticketcrd列表
	 * @param userId
	 * @param payid
	 * @return
	 */
	public static ArrayList<TicketCrd> getAllUserAvaiableTicketCrds(String userId,String payid){
		return getAllUserTicketCrds(userId,false,payid);
	}
	
	/**
	 * 取所有tickets
	 * @param userId
	 * @param payid 支付方式
	 * @return
	 */
	public static ArrayList<Ticket> getAllUserTickets(String userId,String payid){
		return getAllUserTickets(userId,true,payid);
	}
	
	/**
	 * 刮开一个E券，刮开后生成一条记录到tktmst表。返回HashMap，<br/>
	 * map.get("type")若是0则为减免券TicketCrd，若是1则是直减券Ticket！<br/>
	 * map.get("ticket")为对应的券，TicketCrd或Ticket对象，根据前面的type值判断！<br/>
	 * 若map.get("ticket")为null，表示刮奖失败，通过map.get("failreason")获取失败原因！<br/>
	 * map一共存三个值，type/ticket/failreason！<br/>
	 * @param cardno 卡号
	 * @param pwd 密码，都是www.d1.com.cn，目前没有用
	 * @param payid 支付方式，填-1则忽略支付方式，用在帐户中心里面刮
	 * @return null表示失败，可能是卡号错误或者已经过期
	 * @throws Exception exception里面的内容就是没有刮出来的原因
	 */
	public static HashMap<String,Object> drawTicket(HttpServletRequest request,HttpServletResponse response,String cardno,String pwd,String payid){
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		if(Tools.isNull(cardno)){
			map.put("failreason", "券号为空");
			return map ;
		}
		
		//未登录用户不让刮
		if(!UserHelper.isLogin(request, response)){
			map.put("failreason", "没有登录");
			return map ;
		}
		if(UserHelper.isPingAnUser(request, response)){
			if(cardno!=null&&!cardno.toLowerCase().startsWith("pingan")&&!cardno.toLowerCase().startsWith("pa")
					&&cardno.indexOf("_")==-1){
				map.put("failreason", "平安用户不能使用此券");
				return map ;
			}
		}
		User loginUser = UserHelper.getLoginUser(request, response);//登陆用户
		
		TicketPwd tp = (TicketPwd)Tools.getManager(TicketPwd.class).findByProperty("tktpwd_cardno", cardno);
		
		TicketCrd tc = (TicketCrd)Tools.getManager(TicketCrd.class).findByProperty("tktcrd_cardno", cardno);
		
		//mbrmst_finishdate判断新客
		List<BaseEntity> flagList = Tools.getManager(TicketFlag.class).getList(null, null, 0, 1000);
		if(flagList!=null){
			for(BaseEntity be:flagList){
				TicketFlag tf = (TicketFlag)be;
				if(cardno.startsWith(tf.getTktflag_cardnot())){
					if(tf.getTktflag_validflag()!=null&&tf.getTktflag_validflag().longValue()==2){//限新会员
						if(loginUser.getMbrmst_finishdate()!=null){
							map.put("failreason", "该券号仅限新会员使用");
							return map ;
						}
					}
					if(tf.getTktflag_validflag()!=null&&tf.getTktflag_validflag().longValue()==3){//每个会员限几张
						int total = 0 ;
						ArrayList<Ticket> tList123 = getAllUserTickets(loginUser.getId(), "-1");
						if(tList123!=null){
							for(Ticket t32784:tList123){
								if(t32784.getTktmst_cardno()!=null&&t32784.getTktmst_cardno().startsWith(tf.getTktflag_cardnot()))total++;
							}
						}
						if(tf.getTktflag_maxcount()!=null&&total>=tf.getTktflag_maxcount().intValue()){
							map.put("failreason", "您的使用次数已达上限");
							return map ;
						}
					}
				}
			}
		}
		
		
		//if(tp.getTktpwd_pwd()!=null&&!tp.getTktpwd_pwd().equals(pwd))return null;//密码不正确，暂时不判断密码
		
		if(tp!=null){//密码正确
		
			if(tp.getTktpwd_tktstartdate()!=null&&tp.getTktpwd_tktenddate()!=null){
				if(tp.getTktpwd_tktstartdate().getTime()>System.currentTimeMillis()||
						tp.getTktpwd_tktenddate().getTime()<System.currentTimeMillis()){
					map.put("failreason", "券号已过期");
					return map ;
				}
			}
			
			if(tp.getTktpwd_ifvip()!=null&&tp.getTktpwd_ifvip().longValue()==1){//只允许VIP用户刮
				if(!UserHelper.isVip(loginUser)){
					map.put("failreason", "该券号只允许VIP用户使用");
					return map ;
				}
			}
			
			if(Tools.longValue(tp.getTktpwd_payid()) != -1 && !"-1".equals(payid)){//有指定的支付方式
				PayMethod pay = PayMethodHelper.getById(payid);
				if(pay != null){
					if(!payid.equals(tp.getTktpwd_payid()+"")){
						map.put("failreason", "该券号只允许"+pay.getPaymst_name()+"使用");//支付方式不对也不行
						return map ;
					}
				}else{
					map.put("failreason", "券号只允许特定的支付方式使用");//支付方式不对也不行
					return map ;
				}
			}
			
			if(tp.getTktpwd_sendcount()!=null&&tp.getTktpwd_maxcount()!=null){
				if(tp.getTktpwd_sendcount().longValue()>=tp.getTktpwd_maxcount().longValue()){
					map.put("failreason", "券号使用次数已超过限制");
					return map ;
				}
			}
			
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("tktmst_mbrid", new Long(loginUser.getId())));//会员已经刮开的记录
			clist.add(Restrictions.eq("tktmst_cardno", cardno));//会员已经刮开的记录
			
			int sendcount = Tools.getManager(Ticket.class).getLength(clist);
			
			if(tp.getTktpwd_everymaxcount()!=null&&(long)sendcount>=tp.getTktpwd_everymaxcount().longValue()){
				map.put("failreason", "使用次数已超过限制");
				return map ;
			}
			
			//开始刮出来，并创建记录到tktmst表
			Ticket t = new Ticket();
			t.setTktmst_baihuo(tp.getTktpwd_baihuo());
			t.setTktmst_cardno(cardno);
			t.setTktmst_createdate(new Date());
			t.setTktmst_downflag(new Long(0));
			t.setTktmst_gdsvalue(new Float(tp.getTktpwd_gdsvalue()));//满多少
			t.setTktmst_ifcrd(new Long(0));
			t.setTktmst_mbrid(new Long(loginUser.getId()));
			t.setTktmst_memo(tp.getTktpwd_memo());
			t.setTktmst_payid(tp.getTktpwd_payid());
			t.setTktmst_rackcode(tp.getTktpwd_rackcode());
			t.setTktmst_sprckcodeStr(tp.getTktpwd_sprckcodeStr());
			t.setTktmst_validatee(tp.getTktpwd_tktenddate());
			t.setTktmst_validates(tp.getTktpwd_tktstartdate());
			t.setTktmst_validflag(new Long(0));//未使用
			t.setTktmst_value(new Float(tp.getTktpwd_value()));//减多少
			t.setTktmst_type("003005");
			t.setTktmst_brandname(tp.getTktpwd_brandname());
			t.setTktmst_shopcodes(tp.getTktpwd_shopcodes());
			Tools.getManager(Ticket.class).create(t);
			
			if(tp.getTktpwd_sendcount()!=null){
				//刮开次数+1
				tp.setTktpwd_sendcount(new Long(tp.getTktpwd_sendcount().longValue()+1));
			}else{
				tp.setTktpwd_sendcount(new Long(1));//刮开一次
			}
			
			Tools.getManager(TicketPwd.class).update(tp, false);
			
			map.put("type", "1");
			map.put("ticket", t);
			
			return map ;
		}else if(tc!=null){//挂出来减免券
			if(tc.getTktcrd_validflag()!=null&&tc.getTktcrd_validflag().longValue()==1){//已经刮开
				map.put("failreason", "该券号已被使用");
				return map ;
			}
			
			if(tc.getTktcrd_validates()!=null&&tc.getTktcrd_validatee()!=null){
				if(tc.getTktcrd_validates().getTime()>System.currentTimeMillis()||
						tc.getTktcrd_validatee().getTime()<System.currentTimeMillis()){
					map.put("failreason", "该券号已经过期");
					return map ;
				}
			}
			
			if(Tools.longValue(tc.getTktcrd_payid()) != -1 && !"-1".equals(payid)){//有指定的支付方式
				PayMethod pay = PayMethodHelper.getById(payid);
				if(pay != null){
					if(!payid.equals(tc.getTktcrd_payid()+"")){
						map.put("failreason", "该券号只允许"+pay.getPaymst_name()+"使用");//支付方式不对也不行
						return map ;
					}
				}else{
					map.put("failreason", "该券号只允许特定的支付方式使用");//支付方式不对也不行
					return map ;
				}
			}
			
			tc.setTktcrd_mbrid(new Long(loginUser.getId()));
			tc.setTktcrd_validflag(new Long(1));
			Tools.getManager(TicketCrd.class).update(tc, true);
			
			map.put("type", "0");
			map.put("ticket", tc);
			
			return map;
			
		}else if(cardno.length()>10){//可能是ticketgroup的记录
			String tgid = cardno.substring(0,cardno.length()-10);
			
			String num = cardno.substring(cardno.length()-10);//10位数
			
			String last2num = num.substring(num.length()-2);
			
			map.put("failreason", "券号不正确");//后面会覆盖
			
			if(StringUtils.isDigits(num)){
				TicketGroup tg = (TicketGroup)Tools.getManager(TicketGroup.class).findByProperty("tktgroup_title", tgid);
				if(tg!=null){//判断规则
					int sum = 0 ;
					for(int i=0;i<8;i++){//前8位加起来
						sum+=new Integer(num.charAt(i)+"").intValue();
					}
					
					String sum2 = (sum+tg.getTktgroup_checkcode().longValue())+"";
					if(sum2.length()>2)sum2=sum2.substring(sum2.length()-2);//取最后两位
					else if(sum2.length()<2)sum2="0"+sum2 ;//补0，没有这种情况
					
					if(last2num.equals(sum2)){//符合规则
						
						if(tg.getTktgroup_ifvip()!=null&&tg.getTktgroup_ifvip().longValue()==1){//只允许VIP用户刮
							if(!UserHelper.isVip(loginUser)){
								map.put("failreason", "券号只允许VIP用户使用");
								return map ;
							}
						}
						
						if(Tools.longValue(tg.getTktgroup_payid()) != -1 && !"-1".equals(payid)){//有指定的支付方式
							PayMethod pay = PayMethodHelper.getById(payid);
							if(pay != null){
								if(!payid.equals(tg.getTktgroup_payid()+"")){
									map.put("failreason", "券号只允许"+pay.getPaymst_name()+"使用");//支付方式不对也不行
									return map ;
								}
							}else{
								map.put("failreason", "券号只允许特定的支付方式使用");//支付方式不对也不行
								return map ;
							}
						}
						
						List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
						//clist.add(Restrictions.eq("tktmst_mbrid", new Long(loginUser.getId())));//会员已经刮开的记录
						clist.add(Restrictions.eq("tktmst_cardno", cardno));//会员已经刮开的记录
						
						int sendcount = Tools.getManager(Ticket.class).getLength(clist);
						
						if(sendcount>=1){
							map.put("failreason", "该券号已被使用");
							return map ;
						}
						
						List<SimpleExpression> clist123 = new ArrayList<SimpleExpression>();
						//clist123.add(Restrictions.eq("tktcrd_mbrid", new Long(loginUser.getId())));//会员已经刮开的记录
						clist123.add(Restrictions.eq("tktcrd_cardno", cardno));//会员已经刮开的记录
						
						int sendcount123 = Tools.getManager(TicketCrd.class).getLength(clist123);
						
						if(sendcount123>=1){
							map.put("failreason", "该券号已被使用");
							return map ;
						}
						
						if(tg.getTktgroup_flag()!=null){
							if(tg.getTktgroup_flag().longValue()==0){//百分比减免券
								TicketCrd t = new TicketCrd();
								t.setTktcrd_cardno(cardno);
								t.setTktcrd_createdate(new Date());
								t.setTktcrd_discount(tg.getTktgroup_discount());
								t.setTktcrd_enddate(tg.getTktgroup_validatee());
								t.setTktcrd_getdate(new Date());
								t.setTktcrd_mbrid(new Long(loginUser.getId()));
								t.setTktcrd_memo(tg.getTktgroup_memo());
								t.setTktcrd_payid(tg.getTktgroup_payid());
								t.setTktcrd_realvalue(tg.getTktgroup_value());//剩余金额
								t.setTktcrd_type(tg.getTktgroup_type());
								t.setTktcrd_validatee(tg.getTktgroup_validatee());
								t.setTktcrd_validates(tg.getTktgroup_validates());
								t.setTktcrd_validflag(new Long(1));//刮开未使用
								t.setTktcrd_value(tg.getTktgroup_value());//总金额
								t.setTktcrd_brandname(tg.getTktgroup_brandname());
								t.setTktcrd_rackcode(tg.getTktgroup_rackcode());
								Tools.getManager(TicketCrd.class).create(t);
								map.put("type", "0");
								map.put("ticket", t);
							}else if(tg.getTktgroup_flag().longValue()==1){//直减券
								Ticket t = new Ticket();
								t.setTktmst_cardno(cardno);
								t.setTktmst_createdate(new Date());
								t.setTktmst_downflag(new Long(0));
								t.setTktmst_gdsvalue(new Float(tg.getTktgroup_gdsvalue()));//满多少
								t.setTktmst_ifcrd(new Long(0));
								t.setTktmst_mbrid(new Long(loginUser.getId()));
								t.setTktmst_memo(tg.getTktgroup_memo());
								t.setTktmst_payid(tg.getTktgroup_payid());
								t.setTktmst_rackcode(tg.getTktgroup_rackcode());
								t.setTktmst_sprckcodeStr(tg.getTktgroup_sprckcodestr());
								t.setTktmst_validatee(tg.getTktgroup_validatee());
								t.setTktmst_validates(tg.getTktgroup_validates());
								t.setTktmst_validflag(new Long(0));//未使用
								t.setTktmst_value(new Float(tg.getTktgroup_value()));//减多少.
								t.setTktmst_type(tg.getTktgroup_type());
								t.setTktmst_brandname(tg.getTktgroup_brandname());
								t.setTktmst_shopcodes(tg.getTktgroup_shopcode());
								Tools.getManager(Ticket.class).create(t);
								map.put("type", "1");
								map.put("ticket", t);
							}
						}
					}
				}
			}// end if
		}
		
		return map ;
	}
	
	public static class TicketWrap{
		/**
		 * 0=Ticket,1=TicketCrd
		 */
		private int type;
		
		/**
		 * 对应的Ticket
		 */
		private Ticket ticket ;
		
		/**
		 * TicketCrd
		 */
		private TicketCrd ticketCrd ;
		
		private Date createDate ;

		public Date getCreateDate() {
			return createDate;
		}

		public void setCreateDate(Date createDate) {
			this.createDate = createDate;
		}

		public int getType() {
			return type;
		}

		public void setType(int type) {
			this.type = type;
		}

		public Ticket getTicket() {
			return ticket;
		}

		public void setTicket(Ticket ticket) {
			this.ticket = ticket;
		}

		public TicketCrd getTicketCrd() {
			return ticketCrd;
		}

		public void setTicketCrd(TicketCrd ticketCrd) {
			this.ticketCrd = ticketCrd;
		}

	}
	
	public static class TicketWrapCreateDateComparator implements Comparator<TicketWrap> {

		@Override
		public int compare(TicketWrap p0, TicketWrap p1) {
			if(p0==null||p1==null)return 0;
			if(p0.getCreateDate()!=null&&p1.getCreateDate()!=null){
				if(p0.getCreateDate().getTime()>p1.getCreateDate().getTime()){
					return -1;
				}else if(p0.getCreateDate().getTime()<p1.getCreateDate().getTime()){
					return 1;
				}
			}
			return 0;
		}
		
	}
}
