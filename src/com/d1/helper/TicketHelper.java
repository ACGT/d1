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
 * Eȯ������ȯ����ش�������
 * @author kk
 *
 */
public class TicketHelper {
	
	/**
	 * ͨ��ID�ҵ�����
	 * @param id
	 * @return v
	 */
	public static Ticket getById(String id) {
		if(!Tools.isMath(id)) return null;
		return (Ticket)Tools.getManager(Ticket.class).get(id);
	}
	
	/**
	 * ͨ��ID�ҵ�����
	 * @param id
	 * @return TicketCrd
	 */
	public static TicketCrd getCrdById(String id){
		if(!Tools.isMath(id)) return null;
		return (TicketCrd)Tools.getManager(TicketCrd.class).get(id);
	}
	
	/**
	 * ��֤Ticket�Ƿ���Ч
	 * @param request
	 * @param response
	 * @param payid
	 * @param ticket Ticket����
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
	 * ��֤TicketCrd�Ƿ���Ч
	 * @param request
	 * @param response
	 * @param payid
	 * @param ticketCrd TicketCrd����
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
	 * ��ȡ�Ż�ȯ�ܼ���Ľ�����������ܼۡ�ֱ��ȯ���Լ��˷ѣ��ۿ�ȯ�����˷ѣ�����
	 * ---�߾��������ֱ��ȯ��������������յ�ȯ�����ս�Ӧ����Ʒ���+�˷ѱȽϺ�Ľ��
	 * ��������ص�ȯ������ ��Ʒ���+�˷���������ȯ�Ľ��Ӧ���� ��Ʒ���+�˷ѣ�������ȯ�Ľ��
	 * @param request
	 * @param response
	 * @param ticket_id ʹ�õ��Ż�ȯid�����û�ѡ����Ż�ȯ
	 * @param ticket_type ʹ��ȯ�����ͣ�0��ʾ����ȯ��1��ʾ�ۿ�ȯ��2��ʾƷ�Ƽ��⡣��ticket_type=2ʱ���Ͳ����ticket_id��
	 * @param addressId �û��ĵ�ַid
	 * @param payid �û���֧����ʽ
	 * @return
	 */
	public static float getMaxTicketSaveMoney(HttpServletRequest request,HttpServletResponse response,
			String ticket_id,String ticket_type,String addressId,String payId){
		
		User loginUser = UserHelper.getLoginUser(request, response) ;
		
		if(loginUser==null)return 0f ;//û��¼
		
		float normal_money = CartHelper.getNormalProductMoney(request, response);//����ܼ�����Ǯ
		//float shipfee = OrderHelper.getExpressFee(request, response, addressId, payId);//�˷�
		
		if("0".equals(ticket_type)){//tktmst����ȯ�����Լ��˷�
			Ticket ticket = (Ticket)Tools.getManager(Ticket.class).get(ticket_id);
			
			if(ticket!=null&&!loginUser.getId().equals(ticket.getTktmst_mbrid()+""))return 0f;//��һ�°�ȫ�жϣ�����ʹ�ñ��˵��Ż�ȯ
			
			if(TicketHelper.validTicket(request, response, payId, ticket)){//��Ч
				String shopcode=ticket.getTktmst_shopcodes();
				if(Tools.isNull(shopcode))shopcode="00000000";
				if(!shopcode.equals("11111111")){
				normal_money = CartHelper.getShopNormalProductMoney(request, response,shopcode);
				}
				if(ticket!=null&&ticket.getTktmst_value()!=null&&ticket.getTktmst_value().floatValue()>0){
					//float max_cut_money = normal_money  ;//���������
					float cartMoney_2344 = 0f ;//���Դ��۵���Ʒ�ܽ��
					if(Tools.isNull(ticket.getTktmst_rackcode())||"000".equals(ticket.getTktmst_rackcode()))cartMoney_2344=normal_money;
					else cartMoney_2344=CartHelper.getTotalRackcodePayMoney2(request,response,ticket.getTktmst_rackcode(),ticket.getTktmst_shopcodes());
					float 	max_cut_money = ticket.getTktmst_value().floatValue() ;
				//System.out.println("d1gjlrackcode"+ticket.getTktmst_rackcode()+"----"+cartMoney_2344);
					if(cartMoney_2344<max_cut_money&&ticket.getTktmst_gdsvalue().longValue()!=0){//����ȯ����ô����ȯ�ļ���
					//if(ticket.getTktmst_value().floatValue()<max_cut_money){
					 	max_cut_money =cartMoney_2344 ;
					//}
					}
					//System.out.println("d1gjlrackcode"+max_cut_money);
					return Tools.getFloat(max_cut_money,2);
				}
			}
		}else if("1".equals(ticket_type)){//tktcrd�ۿ�ȯ
			TicketCrd ticket123 = (TicketCrd)Tools.getManager(TicketCrd.class).get(ticket_id);
			
			if(!loginUser.getId().equals(ticket123.getTktcrd_mbrid()+""))return 0f;//��һ�°�ȫ�жϣ�����ʹ�ñ��˵��Ż�ȯ
			
			if(TicketHelper.validTicketCrd(request, response, payId, ticket123)){//��֤�Ƿ���Ч
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
					float max_get_money = normal_money*ticket123.getTktcrd_discount().floatValue() ;//����ܼ���Ľ�� 
			
					//ʣ����
					if(ticket123.getTktcrd_realvalue().floatValue()<max_get_money){
						max_get_money=ticket123.getTktcrd_realvalue().floatValue();
					}
					
					return Tools.getFloat(max_get_money,2);
				}
			}
		}else if("2".equals(ticket_type)){//Ʒ�Ƽ���
			float ticket_money = TicketHelper.getBrandCutMoney(request, response);//Ʒ�Ƽ�������ܼ�����
			if(ticket_money>0){//����Ʒ�Ƽ���
				float max_get_money = 0f ;
				if(normal_money>ticket_money){
					max_get_money = ticket_money ;
				}else{//��̫����
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
	 * �õ�Ʒ�Ƽ��������һ������ȯ
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getBrandCutMoney(HttpServletRequest request,HttpServletResponse response){
		return CartHelper.getBrandCutMoney(request, response);
	}
	
	/**
	 * ��ȡȫ���û����Ż�ȯ������tktmst��tktcrd
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
	 * �õ����и��û����õļ���ȯ���Ѿ��жϹ��ﳵ��������
	 * @param request
	 * @param response
	 * @param payid
	 * @return
	 */
	public static ArrayList<TicketCrd> getAllLoginUserAvaiableTicketCrds(HttpServletRequest request,HttpServletResponse response,String payid){
		if(!UserHelper.isLogin(request, response)){
			return null ;
		}
		User loginUser = UserHelper.getLoginUser(request, response);//��½�û�
		
		ArrayList<TicketCrd> rlist = new ArrayList<TicketCrd>();//Ҫ���صĽ��
		
		ArrayList<TicketCrd> list = getAllUserAvaiableTicketCrds(loginUser.getId(),payid);
		
		if(list!=null&&list.size()>0){
			for(TicketCrd tc:list){
				if(payid!=null&&tc.getTktcrd_payid()!=null&&tc.getTktcrd_payid().longValue()!=-1
						&&!payid.equals(tc.getTktcrd_payid()+""))continue;//֧����ʽ����
				
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
									rlist.add(tc);//��Ч����
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
								rlist.add(tc);//��Ч����
							}
						}
					}
				}
			}
		}
		return rlist ;
	}
	
	/**
	 * ���ݵ�ǰ���ﳵ�����ȡ���п��õ�Ticket����ȯ���Ѿ��жϹ�����������
	 * @param payid ֧����ʽ����Ӧpaymst��
	 * @return
	 */
	public static ArrayList<Ticket> getAllLoginUserAvaiableTickets(HttpServletRequest request,HttpServletResponse response,String payid){
		if(!UserHelper.isLogin(request, response)){
			return null ;
		}
		
		User loginUser = UserHelper.getLoginUser(request, response);//��½�û�
		
		ArrayList<Ticket> rlist = new ArrayList<Ticket>();//Ҫ���صĽ��
		
		//Ȼ������
		ArrayList<Ticket> list = getAllUserAvaiableTickets(loginUser.getId(),payid);
		
		if(list==null||list.size()==0)return null;
		
		for(Ticket ticket:list){
			
			if(ticket.getTktmst_brandname()!=null&&ticket.getTktmst_brandname().trim().length()>0&&ticket.getTktmst_gdsvalue()!=null){//������Ʒ������
				if(CartHelper.getCartBrandPayMoney2(request, response, ticket.getTktmst_brandname().trim(),ticket.getTktmst_shopcodes())<ticket.getTktmst_gdsvalue().floatValue())continue;
			}
			
			if(ticket.getTktmst_sprckcodeStr()!=null&&ticket.getTktmst_sprckcodeStr().trim().length()>0&&ticket.getTktmst_gdsvalue()!=null){//������Ʒ������
				if(CartHelper.getCartSprckcodePayMoney(request, response, ticket.getTktmst_sprckcodeStr())<ticket.getTktmst_gdsvalue().floatValue())continue;
			}
			
			float cartMoney = CartHelper.getTotalRackcodePayMoney2(request, response,ticket.getTktmst_rackcode(),ticket.getTktmst_shopcodes());//���ﳵ����ȯ���
			if(ticket.getTktmst_gdsvalue()!=null&&ticket.getTktmst_gdsvalue().floatValue()>0&&cartMoney<ticket.getTktmst_gdsvalue().floatValue())continue;//�����㲻ȡ
			
			if(payid!=null&&ticket.getTktmst_payid()!=null&&
					ticket.getTktmst_payid().longValue()!=-1&&
					!payid.equals(ticket.getTktmst_payid()+""))continue;//֧����ʽ����Ҳ��ȡ
			
			if(!CartHelper.existsDirectory(request, response,ticket.getTktmst_rackcode()))continue;//���ﳵ���಻����Ҳ��ȡ
			if(!CartHelper.existsShopCodeP(request, response,ticket.getTktmst_shopcodes()))continue;
			if(ticket.getTktmst_validates()!=null&&ticket.getTktmst_validatee()!=null){
				if(ticket.getTktmst_validates().getTime()<System.currentTimeMillis()&&
						ticket.getTktmst_validatee().getTime()>=System.currentTimeMillis()){
					if(UserHelper.isPingAnUser(request, response)){
						if(ticket.getTktmst_cardno()!=null&&(ticket.getTktmst_cardno().toLowerCase().startsWith("pingan")||ticket.getTktmst_cardno().toLowerCase().startsWith("pa"))){
							rlist.add(ticket);
						}
					}else{
						rlist.add(ticket);//��Ч����
					}
				}
			}
		}
		return rlist ;
	}
	
	/**
	 * ��ȡ�û��������õĹ���ȯ��
	 * @param userId
	 * @param flag true��ʾȡ���У�falseֻȡδʹ�õ�
	 * @param payid ֧����ʽ
	 * @return
	 */
	private static ArrayList<Ticket> getAllUserTickets(String userId,boolean flag,String payid){
		if(Tools.isNull(userId))return null;
		ArrayList<Ticket> list = new ArrayList<Ticket>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("tktmst_mbrid", new Long(userId)));
		
		if(!flag){
			clist.add(Restrictions.eq("tktmst_validflag", new Long(0)));//0 δʹ��
			clist.add(Restrictions.ne("tktmst_ifcrd", new Long(1)));//tktmst_ifcrd<>1 ����1��ʾ��crd���ɵ�
		}
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("tktmst_createdate"));//������ʱ������
		
		List<BaseEntity> rlist = Tools.getManager(Ticket.class).getList(clist, olist, 0, 1000);
		if(rlist==null||rlist.size()==0)return null;
		
		for(BaseEntity b:rlist){
			list.add((Ticket)b);
		}
		
		return list ;
	}
	
	/**
	 * �õ��û����м���ȯ
	 * @param userId
	 * @param flag true��ʾȡ���У�falseֻȡ���õ�
	 * @param payid
	 * @return
	 */
	private static ArrayList<TicketCrd> getAllUserTicketCrds(String userId,boolean flag,String payid){
		if(Tools.isNull(userId))return null;
		ArrayList<TicketCrd> list = new ArrayList<TicketCrd>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("tktcrd_mbrid", new Long(userId)));//��Աid
		
		if(!flag){
			clist.add(Restrictions.gt("tktcrd_realvalue", new Long(0)));//ʣ�������0
			clist.add(Restrictions.eq("tktcrd_validflag", new Long(1)));//tktcrd_validflag=1��ʾ�ǹο���
		}
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("tktcrd_createdate"));//������ʱ������
		
		List<BaseEntity> rlist = Tools.getManager(TicketCrd.class).getList(clist, olist, 0, 1000);
		if(rlist==null||rlist.size()==0)return null;
		
		for(BaseEntity b:rlist){
			list.add((TicketCrd)b);
		}
		
		return list ;
	}
	
	/**
	 * ȡ�������õ�tickets
	 * @param userId
	 * @param payid ֧����ʽ
	 * @return
	 */
	public static ArrayList<Ticket> getAllUserAvaiableTickets(String userId,String payid){
		return getAllUserTickets(userId,false,payid);
	}
	
	/**
	 * ȡ�������õ�ticketcrd�б�
	 * @param userId
	 * @param payid
	 * @return
	 */
	public static ArrayList<TicketCrd> getAllUserAvaiableTicketCrds(String userId,String payid){
		return getAllUserTicketCrds(userId,false,payid);
	}
	
	/**
	 * ȡ����tickets
	 * @param userId
	 * @param payid ֧����ʽ
	 * @return
	 */
	public static ArrayList<Ticket> getAllUserTickets(String userId,String payid){
		return getAllUserTickets(userId,true,payid);
	}
	
	/**
	 * �ο�һ��Eȯ���ο�������һ����¼��tktmst������HashMap��<br/>
	 * map.get("type")����0��Ϊ����ȯTicketCrd������1����ֱ��ȯTicket��<br/>
	 * map.get("ticket")Ϊ��Ӧ��ȯ��TicketCrd��Ticket���󣬸���ǰ���typeֵ�жϣ�<br/>
	 * ��map.get("ticket")Ϊnull����ʾ�ν�ʧ�ܣ�ͨ��map.get("failreason")��ȡʧ��ԭ��<br/>
	 * mapһ��������ֵ��type/ticket/failreason��<br/>
	 * @param cardno ����
	 * @param pwd ���룬����www.d1.com.cn��Ŀǰû����
	 * @param payid ֧����ʽ����-1�����֧����ʽ�������ʻ����������
	 * @return null��ʾʧ�ܣ������ǿ��Ŵ�������Ѿ�����
	 * @throws Exception exception��������ݾ���û�йγ�����ԭ��
	 */
	public static HashMap<String,Object> drawTicket(HttpServletRequest request,HttpServletResponse response,String cardno,String pwd,String payid){
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		if(Tools.isNull(cardno)){
			map.put("failreason", "ȯ��Ϊ��");
			return map ;
		}
		
		//δ��¼�û����ù�
		if(!UserHelper.isLogin(request, response)){
			map.put("failreason", "û�е�¼");
			return map ;
		}
		if(UserHelper.isPingAnUser(request, response)){
			if(cardno!=null&&!cardno.toLowerCase().startsWith("pingan")&&!cardno.toLowerCase().startsWith("pa")
					&&cardno.indexOf("_")==-1){
				map.put("failreason", "ƽ���û�����ʹ�ô�ȯ");
				return map ;
			}
		}
		User loginUser = UserHelper.getLoginUser(request, response);//��½�û�
		
		TicketPwd tp = (TicketPwd)Tools.getManager(TicketPwd.class).findByProperty("tktpwd_cardno", cardno);
		
		TicketCrd tc = (TicketCrd)Tools.getManager(TicketCrd.class).findByProperty("tktcrd_cardno", cardno);
		
		//mbrmst_finishdate�ж��¿�
		List<BaseEntity> flagList = Tools.getManager(TicketFlag.class).getList(null, null, 0, 1000);
		if(flagList!=null){
			for(BaseEntity be:flagList){
				TicketFlag tf = (TicketFlag)be;
				if(cardno.startsWith(tf.getTktflag_cardnot())){
					if(tf.getTktflag_validflag()!=null&&tf.getTktflag_validflag().longValue()==2){//���»�Ա
						if(loginUser.getMbrmst_finishdate()!=null){
							map.put("failreason", "��ȯ�Ž����»�Աʹ��");
							return map ;
						}
					}
					if(tf.getTktflag_validflag()!=null&&tf.getTktflag_validflag().longValue()==3){//ÿ����Ա�޼���
						int total = 0 ;
						ArrayList<Ticket> tList123 = getAllUserTickets(loginUser.getId(), "-1");
						if(tList123!=null){
							for(Ticket t32784:tList123){
								if(t32784.getTktmst_cardno()!=null&&t32784.getTktmst_cardno().startsWith(tf.getTktflag_cardnot()))total++;
							}
						}
						if(tf.getTktflag_maxcount()!=null&&total>=tf.getTktflag_maxcount().intValue()){
							map.put("failreason", "����ʹ�ô����Ѵ�����");
							return map ;
						}
					}
				}
			}
		}
		
		
		//if(tp.getTktpwd_pwd()!=null&&!tp.getTktpwd_pwd().equals(pwd))return null;//���벻��ȷ����ʱ���ж�����
		
		if(tp!=null){//������ȷ
		
			if(tp.getTktpwd_tktstartdate()!=null&&tp.getTktpwd_tktenddate()!=null){
				if(tp.getTktpwd_tktstartdate().getTime()>System.currentTimeMillis()||
						tp.getTktpwd_tktenddate().getTime()<System.currentTimeMillis()){
					map.put("failreason", "ȯ���ѹ���");
					return map ;
				}
			}
			
			if(tp.getTktpwd_ifvip()!=null&&tp.getTktpwd_ifvip().longValue()==1){//ֻ����VIP�û���
				if(!UserHelper.isVip(loginUser)){
					map.put("failreason", "��ȯ��ֻ����VIP�û�ʹ��");
					return map ;
				}
			}
			
			if(Tools.longValue(tp.getTktpwd_payid()) != -1 && !"-1".equals(payid)){//��ָ����֧����ʽ
				PayMethod pay = PayMethodHelper.getById(payid);
				if(pay != null){
					if(!payid.equals(tp.getTktpwd_payid()+"")){
						map.put("failreason", "��ȯ��ֻ����"+pay.getPaymst_name()+"ʹ��");//֧����ʽ����Ҳ����
						return map ;
					}
				}else{
					map.put("failreason", "ȯ��ֻ�����ض���֧����ʽʹ��");//֧����ʽ����Ҳ����
					return map ;
				}
			}
			
			if(tp.getTktpwd_sendcount()!=null&&tp.getTktpwd_maxcount()!=null){
				if(tp.getTktpwd_sendcount().longValue()>=tp.getTktpwd_maxcount().longValue()){
					map.put("failreason", "ȯ��ʹ�ô����ѳ�������");
					return map ;
				}
			}
			
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("tktmst_mbrid", new Long(loginUser.getId())));//��Ա�Ѿ��ο��ļ�¼
			clist.add(Restrictions.eq("tktmst_cardno", cardno));//��Ա�Ѿ��ο��ļ�¼
			
			int sendcount = Tools.getManager(Ticket.class).getLength(clist);
			
			if(tp.getTktpwd_everymaxcount()!=null&&(long)sendcount>=tp.getTktpwd_everymaxcount().longValue()){
				map.put("failreason", "ʹ�ô����ѳ�������");
				return map ;
			}
			
			//��ʼ�γ�������������¼��tktmst��
			Ticket t = new Ticket();
			t.setTktmst_baihuo(tp.getTktpwd_baihuo());
			t.setTktmst_cardno(cardno);
			t.setTktmst_createdate(new Date());
			t.setTktmst_downflag(new Long(0));
			t.setTktmst_gdsvalue(new Float(tp.getTktpwd_gdsvalue()));//������
			t.setTktmst_ifcrd(new Long(0));
			t.setTktmst_mbrid(new Long(loginUser.getId()));
			t.setTktmst_memo(tp.getTktpwd_memo());
			t.setTktmst_payid(tp.getTktpwd_payid());
			t.setTktmst_rackcode(tp.getTktpwd_rackcode());
			t.setTktmst_sprckcodeStr(tp.getTktpwd_sprckcodeStr());
			t.setTktmst_validatee(tp.getTktpwd_tktenddate());
			t.setTktmst_validates(tp.getTktpwd_tktstartdate());
			t.setTktmst_validflag(new Long(0));//δʹ��
			t.setTktmst_value(new Float(tp.getTktpwd_value()));//������
			t.setTktmst_type("003005");
			t.setTktmst_brandname(tp.getTktpwd_brandname());
			t.setTktmst_shopcodes(tp.getTktpwd_shopcodes());
			Tools.getManager(Ticket.class).create(t);
			
			if(tp.getTktpwd_sendcount()!=null){
				//�ο�����+1
				tp.setTktpwd_sendcount(new Long(tp.getTktpwd_sendcount().longValue()+1));
			}else{
				tp.setTktpwd_sendcount(new Long(1));//�ο�һ��
			}
			
			Tools.getManager(TicketPwd.class).update(tp, false);
			
			map.put("type", "1");
			map.put("ticket", t);
			
			return map ;
		}else if(tc!=null){//�ҳ�������ȯ
			if(tc.getTktcrd_validflag()!=null&&tc.getTktcrd_validflag().longValue()==1){//�Ѿ��ο�
				map.put("failreason", "��ȯ���ѱ�ʹ��");
				return map ;
			}
			
			if(tc.getTktcrd_validates()!=null&&tc.getTktcrd_validatee()!=null){
				if(tc.getTktcrd_validates().getTime()>System.currentTimeMillis()||
						tc.getTktcrd_validatee().getTime()<System.currentTimeMillis()){
					map.put("failreason", "��ȯ���Ѿ�����");
					return map ;
				}
			}
			
			if(Tools.longValue(tc.getTktcrd_payid()) != -1 && !"-1".equals(payid)){//��ָ����֧����ʽ
				PayMethod pay = PayMethodHelper.getById(payid);
				if(pay != null){
					if(!payid.equals(tc.getTktcrd_payid()+"")){
						map.put("failreason", "��ȯ��ֻ����"+pay.getPaymst_name()+"ʹ��");//֧����ʽ����Ҳ����
						return map ;
					}
				}else{
					map.put("failreason", "��ȯ��ֻ�����ض���֧����ʽʹ��");//֧����ʽ����Ҳ����
					return map ;
				}
			}
			
			tc.setTktcrd_mbrid(new Long(loginUser.getId()));
			tc.setTktcrd_validflag(new Long(1));
			Tools.getManager(TicketCrd.class).update(tc, true);
			
			map.put("type", "0");
			map.put("ticket", tc);
			
			return map;
			
		}else if(cardno.length()>10){//������ticketgroup�ļ�¼
			String tgid = cardno.substring(0,cardno.length()-10);
			
			String num = cardno.substring(cardno.length()-10);//10λ��
			
			String last2num = num.substring(num.length()-2);
			
			map.put("failreason", "ȯ�Ų���ȷ");//����Ḳ��
			
			if(StringUtils.isDigits(num)){
				TicketGroup tg = (TicketGroup)Tools.getManager(TicketGroup.class).findByProperty("tktgroup_title", tgid);
				if(tg!=null){//�жϹ���
					int sum = 0 ;
					for(int i=0;i<8;i++){//ǰ8λ������
						sum+=new Integer(num.charAt(i)+"").intValue();
					}
					
					String sum2 = (sum+tg.getTktgroup_checkcode().longValue())+"";
					if(sum2.length()>2)sum2=sum2.substring(sum2.length()-2);//ȡ�����λ
					else if(sum2.length()<2)sum2="0"+sum2 ;//��0��û���������
					
					if(last2num.equals(sum2)){//���Ϲ���
						
						if(tg.getTktgroup_ifvip()!=null&&tg.getTktgroup_ifvip().longValue()==1){//ֻ����VIP�û���
							if(!UserHelper.isVip(loginUser)){
								map.put("failreason", "ȯ��ֻ����VIP�û�ʹ��");
								return map ;
							}
						}
						
						if(Tools.longValue(tg.getTktgroup_payid()) != -1 && !"-1".equals(payid)){//��ָ����֧����ʽ
							PayMethod pay = PayMethodHelper.getById(payid);
							if(pay != null){
								if(!payid.equals(tg.getTktgroup_payid()+"")){
									map.put("failreason", "ȯ��ֻ����"+pay.getPaymst_name()+"ʹ��");//֧����ʽ����Ҳ����
									return map ;
								}
							}else{
								map.put("failreason", "ȯ��ֻ�����ض���֧����ʽʹ��");//֧����ʽ����Ҳ����
								return map ;
							}
						}
						
						List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
						//clist.add(Restrictions.eq("tktmst_mbrid", new Long(loginUser.getId())));//��Ա�Ѿ��ο��ļ�¼
						clist.add(Restrictions.eq("tktmst_cardno", cardno));//��Ա�Ѿ��ο��ļ�¼
						
						int sendcount = Tools.getManager(Ticket.class).getLength(clist);
						
						if(sendcount>=1){
							map.put("failreason", "��ȯ���ѱ�ʹ��");
							return map ;
						}
						
						List<SimpleExpression> clist123 = new ArrayList<SimpleExpression>();
						//clist123.add(Restrictions.eq("tktcrd_mbrid", new Long(loginUser.getId())));//��Ա�Ѿ��ο��ļ�¼
						clist123.add(Restrictions.eq("tktcrd_cardno", cardno));//��Ա�Ѿ��ο��ļ�¼
						
						int sendcount123 = Tools.getManager(TicketCrd.class).getLength(clist123);
						
						if(sendcount123>=1){
							map.put("failreason", "��ȯ���ѱ�ʹ��");
							return map ;
						}
						
						if(tg.getTktgroup_flag()!=null){
							if(tg.getTktgroup_flag().longValue()==0){//�ٷֱȼ���ȯ
								TicketCrd t = new TicketCrd();
								t.setTktcrd_cardno(cardno);
								t.setTktcrd_createdate(new Date());
								t.setTktcrd_discount(tg.getTktgroup_discount());
								t.setTktcrd_enddate(tg.getTktgroup_validatee());
								t.setTktcrd_getdate(new Date());
								t.setTktcrd_mbrid(new Long(loginUser.getId()));
								t.setTktcrd_memo(tg.getTktgroup_memo());
								t.setTktcrd_payid(tg.getTktgroup_payid());
								t.setTktcrd_realvalue(tg.getTktgroup_value());//ʣ����
								t.setTktcrd_type(tg.getTktgroup_type());
								t.setTktcrd_validatee(tg.getTktgroup_validatee());
								t.setTktcrd_validates(tg.getTktgroup_validates());
								t.setTktcrd_validflag(new Long(1));//�ο�δʹ��
								t.setTktcrd_value(tg.getTktgroup_value());//�ܽ��
								t.setTktcrd_brandname(tg.getTktgroup_brandname());
								t.setTktcrd_rackcode(tg.getTktgroup_rackcode());
								Tools.getManager(TicketCrd.class).create(t);
								map.put("type", "0");
								map.put("ticket", t);
							}else if(tg.getTktgroup_flag().longValue()==1){//ֱ��ȯ
								Ticket t = new Ticket();
								t.setTktmst_cardno(cardno);
								t.setTktmst_createdate(new Date());
								t.setTktmst_downflag(new Long(0));
								t.setTktmst_gdsvalue(new Float(tg.getTktgroup_gdsvalue()));//������
								t.setTktmst_ifcrd(new Long(0));
								t.setTktmst_mbrid(new Long(loginUser.getId()));
								t.setTktmst_memo(tg.getTktgroup_memo());
								t.setTktmst_payid(tg.getTktgroup_payid());
								t.setTktmst_rackcode(tg.getTktgroup_rackcode());
								t.setTktmst_sprckcodeStr(tg.getTktgroup_sprckcodestr());
								t.setTktmst_validatee(tg.getTktgroup_validatee());
								t.setTktmst_validates(tg.getTktgroup_validates());
								t.setTktmst_validflag(new Long(0));//δʹ��
								t.setTktmst_value(new Float(tg.getTktgroup_value()));//������.
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
		 * ��Ӧ��Ticket
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
