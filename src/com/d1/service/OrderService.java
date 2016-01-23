package com.d1.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.HibernateException;

import com.d1.bean.Award;
import com.d1.bean.AwardUseLog;
import com.d1.bean.BirthGds;
import com.d1.bean.BuyLimit;
import com.d1.bean.BuyLimitDtl;
import com.d1.bean.Cart;
import com.d1.bean.CartItem;
import com.d1.bean.OrderBase;
import com.d1.bean.OrderCache;
import com.d1.bean.OrderItemCache;
import com.d1.bean.OrderMain;
import com.d1.bean.OrderShopCache;
import com.d1.bean.PayMethod;
import com.d1.bean.Prepay;
import com.d1.bean.Product;
import com.d1.bean.ProductGroup;
import com.d1.bean.SecKill;
import com.d1.bean.SgGdsDtl;
import com.d1.bean.Sku;
import com.d1.bean.Ticket;
import com.d1.bean.TicketCrd;
import com.d1.bean.TmallGrp;
import com.d1.bean.Tuandh;
import com.d1.bean.User;
import com.d1.bean.UserAddress;
import com.d1.bean.UsrPoint;
import com.d1.bean.id.OrderIdGenerator;
import com.d1.bean.id.SequenceIdGenerator;
import com.d1.helper.UserHelper;
import com.d1.util.Tools;



/**
 * ����������������񣬲�Ҫ�Լ�new�������÷���������ͨ��Tools.getService�����������У�
 * @author kk
 *
 */
public class OrderService {

	/**
	 * �µ�������������Eȯ����Ԥ���޸������붩�������붩����ϸ��
	 * @param request
	 * @param response
	 * @param loginUser
	 * @param cartList ���ﳵ���м�¼
	 * @param raddress �ջ��˵�ַ
	 * @param rprovince
	 * @param rcity
	 * @param paddress �����˵�ַ�����µ��ˣ�mbrcst����mbrcst_rthird=0�ļ�¼
	 * @param pprovince
	 * @param pcity
	 * @param paymethod ֧����ʽ
	 * @param deliver �ͻ�ʱ��
	 * @param gdsmoney ��Ʒ�ܽ��
	 * @param normal_money ��Ʒ����ȯ�Ľ�������ܼ���Ľ��
	 * @param ticket_id Eȯ��id
	 * @param ticket_type ʹ��ȯ�����ͣ�0��ʾ����(tktmst)��1��ʾ�ۿ�(tktcrd)��2��ʾƷ�Ƽ���
	 * @param ticket_cut_money ȯʡ�µ�Ǯ �����ticket_typeʹ�ã�����0ʱ��Ч������Ʒ�Ƽ���
	 * @param prepay_money Ԥ���ʡ�µ�Ǯ������0ʱ��Ч
	 * @param shipfee �˷�
	 * @param sumawardvalue ���ֻ���ʹ�õ��ܻ���
	 * @param memo ��������
	 * @return OrderCache �����Ķ���
	 */
	public OrderCache createOrder(HttpServletRequest request,
			HttpServletResponse response, User loginUser, 
			ArrayList<Cart> cartList,
			UserAddress raddress,String rprovince,String rcity,
			UserAddress paddress,String pprovince,String pcity,
			PayMethod paymethod, String deliver,
			float gdsmoney,float normal_money,
			String ticket_id,
			String ticket_type,float ticket_cut_money,float prepay_money,
			float shipfee,long sumawardvalue,String memo) throws Exception 
	{
		if(cartList==null||cartList.size()==0)return null ;
		
		long d1actvalue=0;
		long total_point = 0 ;//�ܻ���
		
		Map<Long,Long> map=new HashMap<Long,Long>();  
		for(Cart cx:cartList){
			if(cx.getType().longValue()==2||cx.getType().longValue()==-5){//���ֶһ���Ʒ
				total_point+=cx.getPoint().longValue();
			}
               if(cx.getActid()!=null&&cx.getActid().longValue()>0){
		        Long arrstri=cx.getActid();
		        if (map.containsKey(arrstri)){
	                map.put(arrstri,cx.getActmoney());
	            }
	            d1actvalue+=cx.getActmoney().longValue();
               }
		}
		
		gdsmoney=gdsmoney+d1actvalue;
		//�ȴ���������Ȼ�󴴽���ϸ
		OrderCache order = new OrderCache();
		order.setId(OrderIdGenerator.generate());//order id��ͨ��һ��sequence������
		order.setOdrmst_id(new Long(SequenceIdGenerator.generate("4")));
		order.setOdrmst_ip(request.getRemoteHost());
	
		HttpSession session = (HttpSession)request.getSession();
		String first_referer_url = (String)session.getAttribute("first_referer_url");
		if(Tools.isNull(first_referer_url)){
			first_referer_url = Tools.getCookie(request, "d1.com.cn.srcurl");
		}
		order.setOdrmst_srcurl(first_referer_url);//��Դ��cookiename=d1.com.cn.srcurl
		order.setOdrmst_temp("");//���˲�������ͬ�ӿڣ���cookie��ȡ���ȴ�����Ȼ��update
		
		order.setOdrmst_mbrid(new Long(loginUser.getId()));//��Աid 
		order.setOdrmst_rname(raddress.getMbrcst_name());//�ջ������� 
		order.setOdrmst_orderdate(new Date());//��������
		
		if(raddress.getMbrcst_rsex()!=null){
			if(raddress.getMbrcst_rsex().longValue()==1){
				order.setOdrmst_rsex("Ů");
			}else{
				order.setOdrmst_rsex("��");
			}
		}
		String brandpidstr="";
		//System.out.println(memo);
		if(("2".equals(ticket_type)||"0".equals(ticket_type))&&memo.indexOf("@@@@")>=0){
		String[] arrmemo=memo.split("@@@@");
		 
		 brandpidstr=arrmemo[0];
		 if(arrmemo.length>1){
		 memo=arrmemo[1];
		 }else{
			 memo="";
		 }
		}
		
		
		order.setOdrmst_rzipcode(raddress.getMbrcst_rzipcode());//�ջ����ʱ�
		order.setOdrmst_raddress(raddress.getMbrcst_raddress());//�ջ��˵�ַ
		order.setOdrmst_rphone(raddress.getMbrcst_rphone());//�ջ��˵绰���ֻ�
		order.setOdrmst_remail(raddress.getMbrcst_remail());//�ջ���email
		order.setOdrmst_rcountry("�й�");//����
		order.setOdrmst_rprovince(rprovince);//�ջ���ʡ
		order.setOdrmst_rcity(rcity);//�ջ��˳���
		
		order.setOdrmst_pzipcode(paddress.getMbrcst_rzipcode());//�����������Ϣ
		order.setOdrmst_paddress(paddress.getMbrcst_raddress());//�����������Ϣ
		order.setOdrmst_pcountry("�й�");//�����������Ϣ
		order.setOdrmst_pprovince(pprovince);//�����������Ϣ
		order.setOdrmst_pcity(pcity);//�����������Ϣ
		order.setOdrmst_pophone(paddress.getMbrcst_rtelephonecode()+"-"+paddress.getMbrcst_rtelephone()+"-"+paddress.getMbrcst_rtelephoneext());//�����������Ϣ
		order.setOdrmst_phphone(paddress.getMbrcst_rtelephonecode()+"-"+paddress.getMbrcst_rtelephone()+"-"+paddress.getMbrcst_rtelephoneext());//�����������Ϣ
		order.setOdrmst_pmphone(paddress.getMbrcst_rtelephonecode()+"-"+paddress.getMbrcst_rtelephone()+"-"+paddress.getMbrcst_rtelephoneext());//�����������Ϣ 
		order.setOdrmst_pusephone(paddress.getMbrcst_rphone());//�����������Ϣ 
		order.setOdrmst_pbp("");//�����������Ϣ
		order.setOdrmst_pemail(paddress.getMbrcst_remail());//�����������Ϣ
		order.setOdrmst_pname(paddress.getMbrcst_name());//�����������Ϣ
		
		if(paddress.getMbrcst_rsex()!=null){
			if(paddress.getMbrcst_rsex().longValue()==1){
				order.setOdrmst_psex("Ů");
			}else{
				order.setOdrmst_psex("��");
			}
		}
		
		String shiptype = request.getParameter("shiptype");//ѡ��Ŀ�ݷ�ʽ

		if("1".equals(shiptype))
		{
			memo=memo+"<br>�û�ѡ��˳�����ʷ��Ѹ���������ע�⣡������";
			order.setOdrmst_d1shipmethod("˳����");
		}
		
		//�ͻ�ʱ��+�������
		order.setOdrmst_customerword("[�ͻ�ʱ��:"+deliver+" �����ǰ��ϵ,����ǩ�� �뵱������������ױƷ���ղ��ɲ��Ʒ��װ��]<br><span style=\"color:#FF0000\">"+memo+"</span>");
		order.setOdrmst_internalmemo("[�ͻ�ʱ��:"+deliver+" �����ǰ��ϵ,����ǩ�� �뵱������������ױƷ���ղ��ɲ��Ʒ��װ��]<br><span style=\"color:#FF0000\">�������:"+memo+"</span>");
		
		order.setOdrmst_insurancefee(new Double(0));//���շ��ã�û��
		order.setOdrmst_netpayfee(new Double(0));//û��
		order.setOdrmst_taxfee(new Double(0));//û����
		order.setOdrmst_giftfee(new Double(0));//û����
		order.setOdrmst_giftid(new Long(0));//û����
		order.setOdrmst_sndshopcode("00000000");//d1����ȫ�����
		order.setOdrmst_refundplan("");//ȱ���˻�ѡ�񷽰��������ֶ�
		order.setOdrmst_jcflag(new Long(0));//û��
		order.setOdrmst_sumawardvalue(new Long(sumawardvalue));//���ֶһ�ʹ���ܻ���
		
		order.setOdrmst_orderstatus(new Long(0));//Ĭ��Ϊδ����״̬
		order.setOdrmst_oldodrid(order.getId());//���ڲ�����𵥶���
		
		//���鿴�����1VIP 0����VIP
		if(UserHelper.isVip(loginUser))order.setOdrmst_specialtype(new Long(1));
		else order.setOdrmst_specialtype(new Long(0));
		
		//========================��ʼ��Ǯ������Ҫ������========================
		order.setOdrmst_shipfee(new Double(shipfee));//�����˷�
		
		Ticket ticket = null ;//�ö����õ�������ȯ
		
		
		order.setOdrmst_d1actmoney(d1actvalue);//������Żݽ��
		
		boolean hasSetOrderMoney = false ;//�Ƿ��Ѿ����ö�����ء�Ǯ�����ֶ�
		
		//�ȿ�Ԥ����Eȯ�Ƿ����ˣ�����ȯ��Ȼ���Ԥ������
		if(prepay_money>0&&ticket_cut_money>0){
	
			if("0".equals(ticket_type)){//tktmst����ȯ��ֱ��ȯ���Լ��˷�
				ticket = (Ticket)Tools.getManager(Ticket.class).txGet(ticket_id);

				Tools.getManager(Ticket.class).txBeforeUpdate(ticket);
				ticket.setTktmst_validflag(new Long(1));//���Ϊ��ʹ�ã�ֱ��ȯһ��������
				Tools.getManager(Ticket.class).txUpdate(ticket, true);
			}else if("1".equals(ticket_type)){//tktcrd�ۿ�ȯ
				TicketCrd ticket123 = (TicketCrd)Tools.getManager(TicketCrd.class).txGet(ticket_id);
			
				//�۵��ۿ�ȯʣ����ö��
				ticket123.setTktcrd_realvalue(new Long(ticket123.getTktcrd_realvalue().longValue()-(long)ticket_cut_money));
				Tools.getManager(TicketCrd.class).txUpdate(ticket123, false);
							
				//����һ��Ticket��¼����������������ɹ���������¼���ᴴ��������
				ticket = new Ticket();
				ticket.setTktmst_cardno(ticket123.getTktcrd_cardno());
				ticket.setTktmst_downflag(new Long(1));
				ticket.setTktmst_createdate(new Date());
				ticket.setTktmst_gdsvalue(new Float(gdsmoney));
				ticket.setTktmst_ifcrd(new Long(1));//�����1�ı�ʶ����Ticket��¼����ʾ�Ӽ���ȯ����������
				ticket.setTktmst_mbrid(ticket123.getTktcrd_mbrid());
				ticket.setTktmst_memo("���ۿ�ȯ����");
				ticket.setTktmst_payid(new Long(paymethod.getId()));
				if (Tools.isNull(ticket123.getTktcrd_rackcode())){
				ticket.setTktmst_rackcode("000");
				}else{
					ticket.setTktmst_rackcode(ticket123.getTktcrd_rackcode());	
				}
				ticket.setTktmst_sodrid(order.getId());//����id
				ticket.setTktmst_uodrid(order.getId());//ʹ�ö���id
				ticket.setTktmst_type(ticket123.getTktcrd_type());//����ȯ���ͣ�����������ȯ
				ticket.setTktmst_validatee(new Date());
				ticket.setTktmst_validates(new Date());
				ticket.setTktmst_validflag(new Long(1));//���Ϊ��ʹ�ã�
				ticket.setTktmst_brandname(ticket123.getTktcrd_brandname());
				ticket.setTktmst_value(new Float(ticket_cut_money));
					
				Tools.getManager(Ticket.class).txCreate(ticket);//������¼
			}else if("2".equals(ticket_type)){//Ʒ�Ƽ��⣬����������ȯ������󴴽�һ��tktmst��¼
				ticket = new Ticket();
				ticket.setTktmst_createdate(new Date());
				ticket.setTktmst_downflag(new Long(1));
				ticket.setTktmst_gdsvalue(new Float(gdsmoney));
				ticket.setTktmst_ifcrd(new Long(0));//���Ǽ���ȯ�ҳ�����
				ticket.setTktmst_mbrid(new Long(loginUser.getId()));//��Աid
				ticket.setTktmst_memo("Ʒ�Ƽ��ⴴ��");
				ticket.setTktmst_payid(new Long(paymethod.getId()));//pay id
				ticket.setTktmst_rackcode("000");
				ticket.setTktmst_cardno("pbrand"+loginUser.getId());
				ticket.setTktmst_validatee(new Date());
				ticket.setTktmst_validates(new Date());
				ticket.setTktmst_sodrid(order.getId());//����id
				ticket.setTktmst_type("015004");//Ʒ�Ƽ���ȯ
				ticket.setTktmst_value(new Float(ticket_cut_money));
				ticket.setTktmst_validflag(new Long(1));//���Ϊ��ʹ��
				ticket.setTktmst_uodrid(order.getId());
				Tools.getManager(Ticket.class).txCreate(ticket);//����
			}
			else if("3".equals(ticket_type)){//200-100�������������ȯ������󴴽�һ��tktmst��¼				
				ticket = new Ticket();
				ticket.setTktmst_createdate(new Date());
				ticket.setTktmst_downflag(new Long(1));
				ticket.setTktmst_gdsvalue(new Float(gdsmoney));
				ticket.setTktmst_ifcrd(new Long(0));//���Ǽ���ȯ�ҳ�����
				ticket.setTktmst_mbrid(new Long(loginUser.getId()));//��Աid
				ticket.setTktmst_memo("200-100�");
				ticket.setTktmst_cardno("pcuxiao200j100"+loginUser.getId());
				ticket.setTktmst_payid(new Long(paymethod.getId()));//pay id
				ticket.setTktmst_rackcode("000");
				ticket.setTktmst_validatee(new Date());
				ticket.setTktmst_validates(new Date());
				ticket.setTktmst_sodrid(order.getId());//����id
				ticket.setTktmst_type("015004");
				ticket.setTktmst_value(new Float(ticket_cut_money));
				ticket.setTktmst_validflag(new Long(1));//���Ϊ��ʹ��
				ticket.setTktmst_uodrid(order.getId());
				Tools.getManager(Ticket.class).txCreate(ticket);//����
			}

			//��Ԥ������һ��Ԥ���ʹ�ü�¼
			Prepay prepay = new Prepay();
			prepay.setPrepay_createdate(new Date());
			prepay.setPrepay_mbrid(new Long(loginUser.getId()));
			prepay.setPrepay_log("�µ���Ԥ���<br/>");
			prepay.setPrepay_memo("�µ�");
			prepay.setPrepay_odrid(order.getId());
			prepay.setPrepay_status(new Long(0));//ͳ�Ƶ�ʱ���status=0��Ԥ��������
			prepay.setPrepay_type(new Long(2));//��������
			prepay.setPrepay_value(-prepay_money);//һ���Ǹ�������ʾ�ۿ�
			prepay.setPropay_operator(loginUser.getMbrmst_name());//�û���
			Tools.getManager(Prepay.class).txCreate(prepay);
			
			float real_save_money = ticket_cut_money+prepay_money+d1actvalue ;//����������ʡ��Ǯ
			
			//���ö�������Ǯ���ֶ�ֵ
			if(paymethod.getId().equals("0") || paymethod.getId().equals("44")){//���������ȷ��0.5Ԫ
				order.setOdrmst_acturepaymoney(Tools.getDouble5(new Float(gdsmoney+shipfee-real_save_money)));
			}else{
				order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(gdsmoney+shipfee-real_save_money),2));	
			}
			order.setOdrmst_gdsmoney(Tools.getDouble(new Float(gdsmoney),2));
			order.setOdrmst_ordermoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
			order.setOdrmst_getmoney(Tools.getDouble(new Float(real_save_money),2));
			order.setOdrmst_prepayvalue(Tools.getDouble(new Float(prepay_money),2));
			
			order.setOdrmst_tktvalue(Tools.getDouble(new Float(ticket_cut_money+d1actvalue),2));//Eȯ���
			order.setOdrmst_tktid(new Long(ticket.getId()));//Eȯ��ţ���Ӧtktmst.id
			
			order.setOdrmst_cardmemo(ticket.getTktmst_cardno());//����ȯ��
			
			hasSetOrderMoney = true ;
			
		}else if(ticket_cut_money>0){//Ȼ���Ƿ�ʹ����Eȯ
			if("0".equals(ticket_type)){//tktmst����ȯ�����Լ��˷�
				ticket = (Ticket)Tools.getManager(Ticket.class).txGet(ticket_id);
				Tools.getManager(Ticket.class).txBeforeUpdate(ticket);
				ticket.setTktmst_validflag(new Long(1));//���Ϊ��ʹ��
				Tools.getManager(Ticket.class).txUpdate(ticket, true);
				
				//���ö���Ǯ��ص��ֶ�
				if(paymethod.getId().equals("0")|| paymethod.getId().equals("44")){//���������ȷ��0.5Ԫ
					order.setOdrmst_acturepaymoney(Tools.getDouble5(new Float(gdsmoney+shipfee-ticket_cut_money-d1actvalue)));
				}else{
					order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(gdsmoney+shipfee-ticket_cut_money-d1actvalue),2));
				}
				order.setOdrmst_gdsmoney(Tools.getDouble(new Float(gdsmoney),2));
				order.setOdrmst_ordermoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
				order.setOdrmst_getmoney(Tools.getDouble(new Float(ticket_cut_money+d1actvalue),2));
				order.setOdrmst_prepayvalue(Tools.getDouble(new Float(0),2));
				
				order.setOdrmst_tktvalue(Tools.getDouble(new Float(ticket_cut_money+d1actvalue),2));//Eȯ���
				order.setOdrmst_tktid(new Long(ticket.getId()));//Eȯ��ţ���Ӧtktmst.id
				order.setOdrmst_cardmemo(ticket.getTktmst_cardno());//����ȯ��
				
				hasSetOrderMoney = true ;
				
			}else if("1".equals(ticket_type)){//tktcrd�ۿ�ȯ
				TicketCrd ticket123 = (TicketCrd)Tools.getManager(TicketCrd.class).txGet(ticket_id);
				//�۵��ۿ�ȯʣ����
				ticket123.setTktcrd_realvalue(new Long(ticket123.getTktcrd_realvalue().longValue()-(long)ticket_cut_money));
				Tools.getManager(TicketCrd.class).txUpdate(ticket123, false);
				
				//����һ��Ticket��¼����������������ɹ���������¼���ᴴ��������
				ticket = new Ticket();
				ticket.setTktmst_cardno(ticket123.getTktcrd_cardno());
				ticket.setTktmst_createdate(new Date());
				ticket.setTktmst_gdsvalue(new Float(gdsmoney));
				ticket.setTktmst_ifcrd(new Long(1));//�����1�ı�ʶ����Ticket��¼��ֻ�������ˣ��´β�������
				ticket.setTktmst_mbrid(ticket123.getTktcrd_mbrid());
				ticket.setTktmst_memo("���ۿ�ȯ����");
				ticket.setTktmst_payid(new Long(paymethod.getId()));

				if (Tools.isNull(ticket123.getTktcrd_rackcode())){
					ticket.setTktmst_rackcode("000");
					}else{
					ticket.setTktmst_rackcode(ticket123.getTktcrd_rackcode());	
					}
				ticket.setTktmst_sodrid(order.getId());//����id
				ticket.setTktmst_uodrid(order.getId());//����id
				ticket.setTktmst_type(ticket123.getTktcrd_type());
				ticket.setTktmst_validatee(new Date());
				ticket.setTktmst_validates(new Date());
				ticket.setTktmst_validflag(new Long(1));//���Ϊʹ�ù�
				ticket.setTktmst_value(new Float(ticket_cut_money));
					
				Tools.getManager(Ticket.class).txCreate(ticket);//������¼
					
				//���ö���Ǯ��ص��ֶ�
				if(paymethod.getId().equals("0")|| paymethod.getId().equals("44")){//���������ȷ��0.5Ԫ
					order.setOdrmst_acturepaymoney(Tools.getDouble5(new Float(gdsmoney+shipfee-ticket_cut_money-d1actvalue)));
				}else{
					order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(gdsmoney+shipfee-ticket_cut_money-d1actvalue),2));
				}
				order.setOdrmst_gdsmoney(Tools.getDouble(new Float(gdsmoney),2));
				order.setOdrmst_ordermoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
				order.setOdrmst_getmoney(Tools.getDouble(new Float(ticket_cut_money+d1actvalue),2));
				order.setOdrmst_prepayvalue(Tools.getDouble(new Float(0),2));
				
				order.setOdrmst_tktvalue(Tools.getDouble(new Float(ticket_cut_money+d1actvalue),2));//Eȯ���
				order.setOdrmst_tktid(new Long(ticket.getId()));//Eȯ��ţ���Ӧtktmst.id
				order.setOdrmst_cardmemo(ticket.getTktmst_cardno());//����ȯ��
					
				hasSetOrderMoney = true ;

			}else if("2".equals(ticket_type)){//Ʒ�Ƽ���
				ticket = new Ticket();
				ticket.setTktmst_createdate(new Date());
				ticket.setTktmst_downflag(new Long(1));
				ticket.setTktmst_gdsvalue(new Float(gdsmoney));
				ticket.setTktmst_ifcrd(new Long(0));//���Ǽ���ȯ�ҳ�����
				ticket.setTktmst_mbrid(new Long(loginUser.getId()));//��Աid
				ticket.setTktmst_memo("Ʒ�Ƽ��ⴴ��");
				ticket.setTktmst_payid(new Long(paymethod.getId()));//pay id
				ticket.setTktmst_uodrid(order.getId());//����id
				ticket.setTktmst_rackcode("000");
				ticket.setTktmst_validatee(new Date());
				ticket.setTktmst_validates(new Date());
				ticket.setTktmst_sodrid(order.getId());//����id
				ticket.setTktmst_type("015004");//Ʒ�Ƽ���ȯ
				ticket.setTktmst_value(new Float(ticket_cut_money));
				ticket.setTktmst_validflag(new Long(1));//���Ϊ��ʹ��
				ticket.setTktmst_uodrid(order.getId());
				
				
				Tools.getManager(Ticket.class).txCreate(ticket);//����
					
				//���ö���Ǯ��ص��ֶ�
				if(paymethod.getId().equals("0")|| paymethod.getId().equals("44")){//���������ȷ��0.5Ԫ
					order.setOdrmst_acturepaymoney(Tools.getDouble5(new Float(gdsmoney+shipfee-ticket_cut_money-d1actvalue)));
				}else{
					order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(gdsmoney+shipfee-ticket_cut_money-d1actvalue),2));
				}
				order.setOdrmst_gdsmoney(Tools.getDouble(new Float(gdsmoney),2));
				order.setOdrmst_ordermoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
				order.setOdrmst_getmoney(Tools.getDouble(new Float(ticket_cut_money+d1actvalue),2));
				order.setOdrmst_prepayvalue(Tools.getDouble(new Float(0),2));
				
				order.setOdrmst_tktvalue(Tools.getDouble(new Float(ticket_cut_money+d1actvalue),2));//Eȯ���
				order.setOdrmst_tktid(new Long(ticket.getId()));//Eȯ��ţ���Ӧtktmst.id
				
				hasSetOrderMoney = true ;
			}
			else if("3".equals(ticket_type)){//200-100�������������ȯ������󴴽�һ��tktmst��¼				
				/*ticket = new Ticket();
				ticket.setTktmst_createdate(new Date());
				ticket.setTktmst_downflag(new Long(1));
				ticket.setTktmst_gdsvalue(new Float(gdsmoney));
				ticket.setTktmst_ifcrd(new Long(0));//���Ǽ���ȯ�ҳ�����
				ticket.setTktmst_mbrid(new Long(loginUser.getId()));//��Աid
				ticket.setTktmst_memo("200-100�");
				ticket.setTktmst_payid(new Long(paymethod.getId()));//pay id
				ticket.setTktmst_rackcode("000");
				ticket.setTktmst_validatee(new Date());
				ticket.setTktmst_validates(new Date());
				ticket.setTktmst_sodrid(order.getId());//����id
				ticket.setTktmst_type("015004");
				ticket.setTktmst_value(new Float(ticket_cut_money));
				ticket.setTktmst_validflag(new Long(1));//���Ϊ��ʹ��
				ticket.setTktmst_uodrid(order.getId());
				Tools.getManager(Ticket.class).txCreate(ticket);//����
				
				//���ö���Ǯ��ص��ֶ�
				if(paymethod.getId().equals("0")|| paymethod.getId().equals("44")){//���������ȷ��0.5Ԫ
					order.setOdrmst_acturepaymoney(Tools.getDouble5(new Float(gdsmoney+shipfee-ticket_cut_money)));
				}else{
					order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(gdsmoney+shipfee-ticket_cut_money),2));
				}
				order.setOdrmst_gdsmoney(Tools.getDouble(new Float(gdsmoney),2));
				order.setOdrmst_ordermoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
				order.setOdrmst_getmoney(Tools.getDouble(new Float(ticket_cut_money),2));
				order.setOdrmst_prepayvalue(Tools.getDouble(new Float(0),2));
				
				order.setOdrmst_tktvalue(Tools.getDouble(new Float(ticket_cut_money),2));//Eȯ���
				order.setOdrmst_tktid(new Long(ticket.getId()));//Eȯ��ţ���Ӧtktmst.id
				
				hasSetOrderMoney = true ;*/
			}
		}
		else if(prepay_money>0){//ֻʹ����Ԥ���
			//��Ԥ������һ��Ԥ���ʹ�ü�¼
			Prepay prepay = new Prepay();
			prepay.setPrepay_createdate(new Date());
			prepay.setPrepay_log("�µ���Ԥ���<br/>");
			prepay.setPrepay_memo("�µ�");
			prepay.setPrepay_mbrid(new Long(loginUser.getId()));
			prepay.setPrepay_odrid(order.getId());
			prepay.setPrepay_status(new Long(0));//ͳ�Ƶ�ʱ���status=0��Ԥ��������
			prepay.setPrepay_type(new Long(2));//��������
			prepay.setPrepay_value(-prepay_money);//һ���Ǹ�������ʾ�ۿ�
			prepay.setPropay_operator(loginUser.getMbrmst_name());//�û���
			Tools.getManager(Prepay.class).txCreate(prepay);
			
			/*//ȫ���ۿۻ
			float zhemoney=0f;

			if(normal_money>=200&& normal_money<500){
				zhemoney=Tools.getFloat(normal_money*0.1f,1);
			}else if(normal_money>=500){
				zhemoney=Tools.getFloat(normal_money*0.2f,1);
			}
*/
			
			//���ö���Ǯ��ص��ֶ�
			if(paymethod.getId().equals("0")|| paymethod.getId().equals("44")){//���������ȷ��0.5Ԫ
				order.setOdrmst_acturepaymoney(Tools.getDouble5(new Float(gdsmoney+shipfee-prepay_money-d1actvalue)));
			}else{
				order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(gdsmoney+shipfee-prepay_money-d1actvalue),2));
			}
			order.setOdrmst_gdsmoney(Tools.getDouble(new Float(gdsmoney),2));
			order.setOdrmst_ordermoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
			order.setOdrmst_getmoney(Tools.getDouble(new Float(prepay_money+d1actvalue),2));
			order.setOdrmst_prepayvalue(Tools.getDouble(new Float(prepay_money),2));
			
			order.setOdrmst_tktvalue(Tools.getDouble(new Float(d1actvalue),2));//Eȯ���
			order.setOdrmst_tktid(new Long(0));//Eȯ��ţ���Ӧtktmst.id
			
			hasSetOrderMoney = true ;
		}
		
		//���û��Ԥ���Ҳû���Ż�ȯ����ô����Ҫ�������ּ۸�
		if(!hasSetOrderMoney){
			//ȫ���ۿۻ
			/*float zhemoney2=0f;

			if(normal_money>=200&& normal_money<500){
				zhemoney2=Tools.getFloat(normal_money*0.1f,1);
			}else if(normal_money>=500){
				zhemoney2=Tools.getFloat(normal_money*0.2f,1);
			}*/
			if(paymethod.getId().equals("0")|| paymethod.getId().equals("44")){//���������ȷ��0.5Ԫ
				order.setOdrmst_acturepaymoney(Tools.getDouble5(new Float(gdsmoney+shipfee-d1actvalue)));
			}else{
				order.setOdrmst_acturepaymoney(Tools.getDouble(new Float(gdsmoney+shipfee-d1actvalue),2));
			}
			order.setOdrmst_gdsmoney(Tools.getDouble(new Float(gdsmoney),2));
			order.setOdrmst_ordermoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
			order.setOdrmst_getmoney(Tools.getDouble(new Float(d1actvalue),2));
			order.setOdrmst_prepayvalue(Tools.getDouble(new Float(0),2));
			
			order.setOdrmst_tktvalue(Tools.getDouble(new Float(d1actvalue),2));//Eȯ���
			order.setOdrmst_tktid(new Long(0));//Eȯ��ţ���Ӧtktmst.id��û��ȯ���ó�0
			
			hasSetOrderMoney = true ;
		}

		//========================������Ǯ������========================
		order.setOdrmst_centerfee(new Double(0));//û����
		order.setOdrmst_rthird(new Long(0));//�Ƿ�������ջ� ����
		
		order.setOdrmst_paytype(new Long(paymethod.getPaymst_type().intValue()));//֧����ʽ���ͣ���Ӧpaymst_type��
		order.setOdrmst_payid(new Long(paymethod.getId()));//֧����ʽ��ţ���Ӧpaymst_payid��
		order.setOdrmst_actpay(paymethod.getPaymst_actpay());
		
		order.setOdrmst_paymethod(paymethod.getPaymst_name());//֧����ʽ�硰������� ��֧������
		
		if("0".equals(paymethod.getId())){//�������
			order.setOdrmst_shipmethod("�������(��������)");//������ʽ  �硰������š��͡�������ţ������������֧���ɹ����޸�
			order.setOdrmst_shipid(new Long(11));//������ʽ��� ������ʽ��ţ���Ӧsndmst_shipid��
		}else{
			order.setOdrmst_shipid(new Long(10));//�������
			order.setOdrmst_shipmethod("�������");
		}
		
		System.out.println("����������odrid="+order.getId()+" acturepaymoney="+order.getOdrmst_acturepaymoney()+" gdsmoney="+order.getOdrmst_gdsmoney()+" getmoney="+order.getOdrmst_getmoney()+" ordermoney="+order.getOdrmst_ordermoney());
		Tools.getManager(OrderCache.class).txCreate(order);//����������������������
		
		
		//�����̻���Ӧ���¼��������¼û�����ˣ����Ǻ�̨�й�����ѯ��������Ҫ����������
		OrderShopCache orderShopCache = new OrderShopCache();
		orderShopCache.setOdrshp_odrid(order.getId());
		orderShopCache.setOdrshp_shopcode("08102301");
		orderShopCache.setOdrshp_sndshopcode("00000000");//d1����ȫ�����
		orderShopCache.setOdrshp_orderdate(new Date());
		orderShopCache.setOdrshp_shopname("D1���������з���");
		orderShopCache.setOdrshp_country("�й�");
		orderShopCache.setOdrshp_province(rprovince);
		orderShopCache.setOdrshp_city(rcity);
		orderShopCache.setOdrshp_gdsmoney(Tools.getFloat(new Float(gdsmoney),2));
		orderShopCache.setOdrshp_shipfee(Tools.getFloat(new Float(shipfee),2));
		orderShopCache.setOdrshp_centerfee(Tools.getFloat(new Float(0),2));
		orderShopCache.setOdrshp_ordermoney(Tools.getFloat(new Float(gdsmoney+shipfee-d1actvalue),2));
		orderShopCache.setOdrshp_payshopmoney(new Float(0));
		orderShopCache.setOdrshp_incomevalue(Tools.getFloat(new Float(gdsmoney+shipfee-d1actvalue),2));
		orderShopCache.setOdrshp_realincome(Tools.getFloat(new Float(gdsmoney+shipfee-d1actvalue),2));
		orderShopCache.setOdrshp_giftid(new Long(0));
		orderShopCache.setOdrshp_giftfee(new Float(0));
		orderShopCache.setOdrshp_downflag(new Long(1));
		
		Tools.getManager(OrderShopCache.class).txCreate(orderShopCache);
		
		
		long total_point_for_cut = total_point ;
		
		if(total_point>0){//����л��ֶһ���Ʒ�����û��Ļ���
			/*
			UsrPoint us = new UsrPoint();
			us.setUsrpoint_createdate(new Date());
			us.setUsrpoint_odrid(order.getId());
			us.setUsrpoint_mbrid(order.getOdrmst_mbrid());
			us.setUsrpoint_usescore(new Long(0));
			us.setUsrpoint_score(new Long(total_point_for_cut));
			Tools.getManager(UsrPoint.class).txCreate(us);
			*/
			/*
			List<SimpleExpression> clist123 = new ArrayList<SimpleExpression>();
			clist123.add(Restrictions.eq("usrscore_mbrid", new Long(loginUser.getId())));
			clist123.add(Restrictions.gt("usrscore_realscr", new Float(0)));
			
			List<Order> olist123 = new ArrayList<Order>();
			olist123.add(Order.asc("usrscore_createdate"));
			
			List<BaseEntity> listus123 = Tools.getManager(UserScore.class).txGetList(clist123, null, 0, 1000);//�û����л��ּ�¼
			if(listus123!=null&&listus123.size()>0){
				for(int i=0;i<listus123.size();i++){
					UserScore us = (UserScore)listus123.get(i);
					if(total_point_for_cut>0){
						if(us.getUsrscore_realscr()!=null){
							if(us.getUsrscore_realscr().longValue()>=total_point_for_cut){
								us.setUsrscore_realscr(Tools.getFloat(new Float(us.getUsrscore_realscr().longValue()-total_point_for_cut),2));
								Tools.getManager(UserScore.class).txUpdate(us, false);
								total_point_for_cut = 0;//������
							}else{
								total_point_for_cut = total_point_for_cut-us.getUsrscore_realscr().longValue();
								us.setUsrscore_realscr(new Float(0));
								Tools.getManager(UserScore.class).txUpdate(us, false);
							}
						}
					}
				}
				
				if(total_point_for_cut>0){
					throw new Exception(this.getClass().getName()+"���ֲ���֧����");
				}
			}else{
				throw new Exception(this.getClass().getName()+"���ֲ�����");
			}
			*/
		}
		
		//��ʼ����������ϸ............
		for(int i=0;i<cartList.size();i++){
			Cart cart = cartList.get(i);
			TmallGrp tmgrp=(TmallGrp)Tools.getManager(TmallGrp.class).txGet(cart.getProductId());
			if(tmgrp!=null){
				String tktshop="";
				if(ticket!=null)tktshop=ticket.getTktmst_shopcodes();
				createItem(tmgrp,cart,order.getId(),loginUser.getId(),brandpidstr,ticket_type,tktshop);
				continue;
			}
			
			if(cart.getType().longValue()==14){//����һ���û�ֻ�ܹ���һ��
				BuyLimit blm = (BuyLimit)Tools.getManager(BuyLimit.class).txFindByProperty("gdsbuyonemst_gdsid", cart.getProductId());
				if(blm!=null&&blm.getGdsbuyonemst_starttime()!=null&&blm.getGdsbuyonemst_endtime()!=null){
					if(blm.getGdsbuyonemst_starttime().getTime()<=System.currentTimeMillis()&&
							blm.getGdsbuyonemst_endtime().getTime()>=System.currentTimeMillis()){
						BuyLimitDtl bld = new BuyLimitDtl();
						bld.setGdsbuyonedtl_createtime(new Date());
						bld.setGdsbuyonedtl_gdsid(cart.getProductId());
						bld.setGdsbuyonedtl_mbrid(new Long(loginUser.getId()));
						bld.setGdsbuyonedtl_mstid(new Long(blm.getId()));
						bld.setGdsbuyonedtl_odrid(order.getId());
						Tools.getManager(BuyLimitDtl.class).txCreate(bld);
					}
				}
			}
			
			if(cart.getType().longValue()>=0&&cart.getAmount().longValue()>0){//��ʽ��Ʒ
				//������Ҫ��һ����Ʒ��ע����txGet����
				Product p = (Product)Tools.getManager(Product.class).txGet(cart.getProductId());
				
				Sku sku = null ;
				
				if(!Tools.isNull(cart.getSkuId())){
					sku = (Sku)Tools.getManager(Sku.class).txGet(cart.getSkuId());
				}
				
				//��������һ����¼������ռ��������
				CartItem ci = new CartItem();
				ci.setAmount(cart.getAmount());
				ci.setCreateDate(new Date());
				ci.setOrderId(order.getId());
				ci.setProductId(p.getId());
				ci.setSkuId(cart.getSkuId());
				ci.setUserId(loginUser.getId());
				Tools.getManager(CartItem.class).txCreate(ci);
				
				OrderItemCache orderItem = new OrderItemCache();
				orderItem.setId(SequenceIdGenerator.generate("5"));//ע��5��seqid
				
                orderItem.setOdrdtl_shopcode(p.getGdsmst_shopcode());
                orderItem.setOdrdtl_oldodrid(order.getId());
				orderItem.setOdrdtl_purprice(Tools.getDouble(p.getGdsmst_inprice(),2));
				orderItem.setOdrdtl_addshipfee(Tools.getDouble(new Float(p.getGdsmst_addshipfee()),2));//�����˷�  �ر��ص���Ʒ����Ʒ��ȡ
				orderItem.setOdrdtl_aspmemo("");//�ɹ���¼
				if(cart.getActid()!=null&&cart.getActid().longValue()>0){
				orderItem.setOdrdtl_actid(cart.getActid());
				orderItem.setOdrdtl_actmemo(cart.getActmemo());
				orderItem.setOdrdtl_actmoney(cart.getActmoney());
				}
				
				orderItem.setOdrdtl_odrid(order.getId());//������
				orderItem.setOdrdtl_gdsid(cart.getProductId());//product id
				if(sku!=null)orderItem.setOdrdtl_sku1(sku.getSkumst_sku1());//sku id
				orderItem.setOdrdtl_sku2("");//sku2 id û�� 
				
				
				if("0".equals(ticket_type)){
                    if(brandpidstr.length()>0){
					if(brandpidstr.indexOf(cart.getProductId())==-1){
						orderItem.setOdrdtl_examineflag(new Long(1));
					}
                    }else{
                    	String tktshopcode=ticket.getTktmst_shopcodes();
                    	if(Tools.isNull(tktshopcode))tktshopcode="00000000";
                    	if(!tktshopcode.equals(cart.getShopcode())&&!tktshopcode.equals("11111111")){
                    		orderItem.setOdrdtl_examineflag(new Long(1));
                    	}
                    	
                    }
				}else if("1".equals(ticket_type)){
					if(!"00000000".equals(cart.getShopcode())){
						orderItem.setOdrdtl_examineflag(new Long(1));
					}
					
				}else if("2".equals(ticket_type)){
					if(brandpidstr.indexOf(cart.getShopcode())==-1){
						orderItem.setOdrdtl_examineflag(new Long(1));
					}
				}
				
				orderItem.setOdrdtl_referer(cart.getRefererurl());
				orderItem.setOdrdtl_gdsname(cart.getTitle());//��Ʒ��
				orderItem.setOdrdtl_memberprice(new Double(p.getGdsmst_memberprice()));//��Ա��
				orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//�г���
				orderItem.setOdrdtl_vipprice(new Double(p.getGdsmst_vipprice()));//vip ��
				
				if(cart.getType().longValue()==0||cart.getType().longValue()==12){//�������Ʒ
					orderItem.setOdrdtl_gifttype(cart.getGiftType());
					orderItem.setOdrdtl_rackcode(cart.getGiftRackcode());
					orderItem.setOdrdtl_buyflag(new Long(2));//��ƷΪ2
				}else{
					orderItem.setOdrdtl_gifttype("");
					orderItem.setOdrdtl_rackcode(p.getGdsmst_rackcode());
					orderItem.setOdrdtl_buyflag(new Long(0));//1Ϊ������Ʒ
				}
				orderItem.setOdrdtl_downflag(cart.getType());
				Double finalprice = Tools.getDouble(new Float(cart.getMoney().floatValue()/cart.getAmount().longValue()),2);//�ɽ�����
				
				orderItem.setOdrdtl_finalprice(Tools.getDouble(finalprice,2));//���ɽ�����
				orderItem.setOdrdtl_gdscount(cart.getAmount());//��������
				orderItem.setOdrdtl_totalmoney(Tools.getDouble(cart.getMoney(),2));//�ɽ��ܽ��
				
				orderItem.setOdrdtl_shipstatus(new Long(1));//����״̬��1Ϊδ����
				orderItem.setOdrdtl_sendcount(cart.getAmount());//�����������ʼ0
				orderItem.setOdrdtl_creatdate(new Date());//��������
				
				orderItem.setOdrdtl_promotionword("");//������
				orderItem.setOdrdtl_refundcount(new Long(0));//û����������
				orderItem.setOdrdtl_weight(new Long(0));//��Ʒ����  ����
				
				
				
				orderItem.setOdrdtl_stddetail1(p.getGdsmst_stdvalue1());//����Ʒ��ȡ
				orderItem.setOdrdtl_stddetail2(p.getGdsmst_stdvalue2());
				orderItem.setOdrdtl_stddetail3(p.getGdsmst_stdvalue3());
				orderItem.setOdrdtl_stddetail4(p.getGdsmst_stdvalue4());
				orderItem.setOdrdtl_stddetail5(p.getGdsmst_stdvalue5());
				orderItem.setOdrdtl_stddetail6(p.getGdsmst_stdvalue6());
				orderItem.setOdrdtl_stddetail7(p.getGdsmst_stdvalue7());
				orderItem.setOdrdtl_stddetail8(p.getGdsmst_stdvalue8());
				orderItem.setOdrdtl_stddetail9("");//��Ʒû��stddetail9�ֶ�
				
				orderItem.setOdrdtl_presellflag(new Long(0));//�����ֶΣ�����
				orderItem.setOdrdtl_incometype(new Long(0));//�����ֶΣ�����
				orderItem.setOdrdtl_incomevalue(new Double(0));//�����ֶ�
				
				orderItem.setOdrdtl_totalincomevalue(Tools.getDouble(finalprice*cart.getAmount(),2));//�����̻������� ����
				orderItem.setOdrdtl_eyuan(new Double(0));//��ƷӦ��Eȯ ��Ʒ��ȡ���۸��ܴ�����ȯ����Ʒ
				
				orderItem.setOdrdtl_spendcount(Tools.getDouble(new Float((int)cart.getMoney().intValue()),2));//���û�����
				
				orderItem.setOdrdtl_managememo("");//��Ʒ��������
				orderItem.setOdrdtl_gdspurmemo("");//�ɹ���ע 
				
				orderItem.setOdrdtl_specialflag(p.getGdsmst_specialflag());//0��ʲô�����룬1��ʾ��Ʒ������ȯ��2��ʾ���������˷���
				//orderItem.setOdrdtl_gifttype("");//��Ʒ����
				
				orderItem.setOdrdtl_refcount(p.getGdsmst_refcount());//�Ƿ�μӷ���ȯ������μ�Ϊ0������Ϊ1��Ŀǰû���ã�
				orderItem.setOdrdtl_jcflag(new Long(0));//û����
				
				orderItem.setOdrdtl_temp(order.getOdrmst_temp());//��Ʒ���ǣ���¼������Դ������Ҫ���硰�Ź���Ʒ�����Ź��һ���
				
				//�޸Ķһ���״̬
				if(cart.getType().longValue()==13){//�һ���
					Tuandh tuan = (Tuandh)Tools.getManager(Tuandh.class).txFindByProperty("tuandh_cardno", cart.getTuanCode());
					
					if(tuan.getTuandh_status().intValue()==2){
						throw new Exception("�һ���"+tuan.getTuandh_cardno()+"�ѱ�ʹ�ã�");
					}else{
						orderItem.setOdrdtl_tuancardno(cart.getTuanCode());//�̻��һ�ȯ��
						tuan.setTuandh_status(new Long(2));
						tuan.setTuandh_odrid(order.getId());
						tuan.setTuandh_dhtime(new Date());
						Tools.getManager(Tuandh.class).txUpdate(tuan, false);
					}
				}
				if(cart.getType().longValue()==20){//�һ���
					SgGdsDtl sg = (SgGdsDtl)Tools.getManager(SgGdsDtl.class).txFindByProperty("sggdsdtl_gdsid", cart.getProductId());
					
					if(sg!=null&&sg.getSggdsdtl_status().intValue()==1){
						sg.setSggdsdtl_realnum(new Long(sg.getSggdsdtl_realnum().longValue()+cart.getAmount()));
						Tools.getManager(SgGdsDtl.class).txUpdate(sg, false);
					}
				}
				//�޸Ķһ���״̬
				if(cart.getType().longValue()==19){//��������״̬�޸�
					BirthGds birthgds = (BirthGds)Tools.getManager(BirthGds.class).txFindByProperty("birthgds_mbrid", new Long(loginUser.getId()));
					if(birthgds==null||birthgds.getBirthgds_status().longValue()==2){
						throw new Exception("���������Ѿ���ȡ�������ظ���ȡ��");
					}else{
					birthgds.setBirthgds_status(new Long(2));
					birthgds.setBirthgds_odrid(order.getId());
					birthgds.setBirthgds_update(new Date());
					Tools.getManager(BirthGds.class).txUpdate(birthgds, false);
					}
		
				}
				
				
				//�޸���ɱ��Ʒ����ɱ�����������tuanCode��addCart�Ž�ȥ��
				if("SecKill".equals(cart.getTuanCode())){
					SecKill sk_34434 = (SecKill)Tools.getManager(SecKill.class).txFindByProperty("mstjgds_gdsid", cart.getProductId());
					if(sk_34434!=null&&sk_34434.getMstjgds_state()!=null&&sk_34434.getMstjgds_state().longValue()==1){
						if(sk_34434.getMstjgds_count()==null){
							sk_34434.setMstjgds_count(cart.getAmount());
						}else{
							sk_34434.setMstjgds_count(new Long(cart.getAmount().longValue()+sk_34434.getMstjgds_count().longValue()));
						}
						Tools.getManager(SecKill.class).txUpdate(sk_34434, false);
					}
				}
				
				//�Ź���Ʒ�����Ź�������
				if(cart.getType().longValue()==6){
					ProductGroup pg3k = (ProductGroup)Tools.getManager(ProductGroup.class).txGet(cart.getAwardId());//ע�⣬awardId�������product group ��id
					if(pg3k!=null){
						long tcount = (pg3k.getTgrpmst_relcount()==null?0:pg3k.getTgrpmst_relcount().longValue());
						tcount=tcount+cart.getAmount().longValue();
						pg3k.setTgrpmst_relcount(new Long(tcount));
						Tools.getManager(ProductGroup.class).txUpdate(pg3k, false);
					}
				}
				
				//����������ϸ
				Tools.getManager(OrderItemCache.class).txCreate(orderItem);
				
				if(cart.getType().longValue()==2){//����ǻ��ֶһ���Ʒ���۳����ֲ�����һ���һ���¼�������˻�����
					Award award = (Award)Tools.getManager(Award.class).txFindByProperty("award_gdsid", cart.getProductId());
					
					AwardUseLog awl = new AwardUseLog();
					awl.setScrchgawd_applytime(new Date());
					awl.setScrchgawd_awardid(new Long(award.getId()));
					awl.setScrchgawd_mbrid(new Long(loginUser.getId()));
					awl.setScrchgawd_mbrmst_haddr(raddress.getMbrcst_raddress());
					awl.setScrchgawd_mbrmst_name(raddress.getMbrcst_name());
					awl.setScrchgawd_mbrmst_postcode(raddress.getMbrcst_rzipcode());
					awl.setScrchgawd_mbrmst_usephone(raddress.getMbrcst_rphone());
					awl.setScrchgawd_name(loginUser.getMbrmst_name());
					awl.setScrchgawd_status(new Long(1));//״̬һ��Ҫ��1
					awl.setScrchgawd_uid(loginUser.getMbrmst_uid());
					awl.setScrchgawd_updtime(new Date());
					Tools.getManager(AwardUseLog.class).txCreate(awl);
					
					UsrPoint usrpoint = new UsrPoint();
					usrpoint.setUsrpoint_odrid(order.getId());
					usrpoint.setUsrpoint_gdsid(cart.getProductId());
					usrpoint.setUsrpoint_mbrid(Long.parseLong(loginUser.getId()));
					usrpoint.setUsrpoint_score(-cart.getPoint());
					usrpoint.setUsrpoint_shopcode(cart.getShopcode());
					usrpoint.setUsrpoint_type(new Long(-1));
					usrpoint.setUsrpoint_usescore(new Long(0));
					usrpoint.setUsrpoint_createdate(new Date());
					
					Tools.getManager(UsrPoint.class).txCreate(usrpoint);
				}
			}else{//����ȯ���ײ���ʲô�ĵ�������
				if(cart.getType().longValue()==-5){//�һ�ȯ������cart.getAmount��
					for(int xy123=0;xy123<cart.getAmount().intValue();xy123++){
						String awardId = cart.getProductId();
						Ticket t789 = new Ticket();
						t789.setTktmst_createdate(new Date());
						t789.setTktmst_downflag(new Long(1));
						//t789.setTktmst_gdsvalue(new Float(gdsmoney));
						t789.setTktmst_ifcrd(new Long(0));//���Ǽ���ȯ�ҳ�����
						t789.setTktmst_mbrid(new Long(loginUser.getId()));//��Աid
						t789.setTktmst_memo("���ֶһ�����");
						t789.setTktmst_payid(new Long(-1));//pay id
						t789.setTktmst_rackcode("000");
						t789.setTktmst_validatee(new Date(System.currentTimeMillis()+30*Tools.DAY_MILLIS));
						t789.setTktmst_validates(new Date());
						t789.setTktmst_sodrid(order.getId());//����id
						t789.setTktmst_type("003007");//���ֻ�ȯ
						//t789.setTktmst_value(new Float(ticket_cut_money));
						t789.setTktmst_validflag(new Long(0));//���Ϊδʹ��
						t789.setTktmst_uodrid(order.getId());
						t789.setTktmst_cardno("");
						t789.setTktmst_baihuo(new Long(0));
						
						
						if("3".equals(awardId)){//15Ԫ�Ż�ȯ��������50����ʹ��
							t789.setTktmst_gdsvalue(new Float(50));
							t789.setTktmst_value(new Float(15));
						}else if("36".equals(awardId)){//30Ԫ�Ż�ȯ��������200����ʹ��
							t789.setTktmst_gdsvalue(new Float(200));
							t789.setTktmst_value(new Float(30));
						}else if("66".equals(awardId)){//5Ԫ�Ż�ȯ�����޹�����
							t789.setTktmst_gdsvalue(new Float(0));
							t789.setTktmst_value(new Float(5));
						}else if("67".equals(awardId)){//10Ԫ�Ż�ȯ�����޹�����
							t789.setTktmst_gdsvalue(new Float(0));
							t789.setTktmst_value(new Float(10));
						}else if("92".equals(awardId)){//20Ԫ�Ż�ȯ��������100����ʹ��
							t789.setTktmst_gdsvalue(new Float(100));
							t789.setTktmst_value(new Float(20));
						}else if("294".equals(awardId)){//50Ԫ�Ż�ȯ��������300����ʹ��
							t789.setTktmst_gdsvalue(new Float(300));
							t789.setTktmst_value(new Float(50));
						}else if("526".equals(awardId)){//300��100Ԫ�Ż�ȯ
							t789.setTktmst_gdsvalue(new Float(300));
							t789.setTktmst_value(new Float(100));
						}else if("787".equals(awardId)){//200��50Ԫ�Ż�ȯ
							t789.setTktmst_gdsvalue(new Float(200));
							t789.setTktmst_value(new Float(50));
						}else if("479".equals(awardId)){//10Ԫ�Ż�ȯ��ȫ��������ʹ��
							t789.setTktmst_gdsvalue(new Float(0));
							t789.setTktmst_value(new Float(10));
						}else if("480".equals(awardId)){//100Ԫ�Ż�ȯ��������200����ʹ��
							t789.setTktmst_gdsvalue(new Float(200));
							t789.setTktmst_value(new Float(100));
						}
						
						Tools.getManager(Ticket.class).txCreate(t789);//�����һ����ɵ��Ż�ȯ
					}
				}
			}

		}

		//�����ȯ����Ԥ���֧���������з��ã����޸�״̬
		if(ticket_cut_money+prepay_money>=gdsmoney+shipfee){
			if(order.getOdrmst_orderstatus()!=null&&order.getOdrmst_orderstatus().longValue()==0){
				Tools.getManager(OrderCache.class).txBeforeUpdate(order);
				order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+ new Date()+"Ԥ����Eȯȫ���տ�");
				order.setOdrmst_getmoney(Tools.getDouble(new Float(gdsmoney+shipfee),2));
				order.setOdrmst_validdate(new Date());
				order.setOdrmst_realstatus(new Long(1));//ʵ��
				order.setOdrmst_realgettime(new Date());
				order.setOdrmst_orderstatus(new Long(2));//ȷ���տ�״̬
				
				Tools.getManager(OrderCache.class).txUpdate(order, true);
				
				//���ô洢���̰Ѷ����޸ĳɡ�ȷ���տ״̬����ִ�п����޸Ķ���������
				ProcedureWork work = new ProcedureWork(order.getId());
				Tools.getManager(OrderMain.class).currentSession().doWork(work);//ִ��work
			}
		}else if(loginUser.getMbrmst_finishdate()!=null&&order.getOdrmst_payid()!=null
				&&order.getOdrmst_payid().longValue()==0){
			confirmGetMoney(order,loginUser);
		}
		
		return order ;
	}
	private void createItem(TmallGrp tmgrp,Cart cart,String odrid,String uid,String brandpidstr,String ticket_type,String tktshopcode){
			String[] gs = tmgrp.getTmallgrp_items().split(",");
			String gsp="";
			float gspall=0f;
			int gslen=gs.length;
			for(int l=0;l<gslen;l++){
				Product p=(Product)Tools.getManager(Product.class).txGet(gs[l]);
				if(p!=null){
							gspall=gspall+p.getGdsmst_memberprice().floatValue();
				}
			}
			float gdtlmoney=cart.getMoney().floatValue();
			String productId=cart.getProductId();
			float dtlmall=0f;
	 for(int l=0;l<gslen;l++){
					Product p=(Product)Tools.getManager(Product.class).txGet(gs[l]);
					float mprice=p.getGdsmst_memberprice().floatValue();
					float dtlm= Tools.getFloat(gdtlmoney*(mprice/gspall),1);
					if(l==gslen-1)dtlm=gdtlmoney-dtlmall;
					dtlmall+=dtlm;
		
		//��������һ����¼������ռ��������
		CartItem ci = new CartItem();
		ci.setAmount(cart.getAmount());
		ci.setCreateDate(new Date());
		ci.setOrderId(odrid);
		ci.setProductId(p.getId());
		ci.setSkuId(cart.getSkuId());
		ci.setUserId(uid);
		Tools.getManager(CartItem.class).txCreate(ci);
		
		OrderItemCache orderItem = new OrderItemCache();
		orderItem.setId(SequenceIdGenerator.generate("5"));//ע��5��seqid
		
        orderItem.setOdrdtl_shopcode(p.getGdsmst_shopcode());
        orderItem.setOdrdtl_oldodrid(odrid);
		orderItem.setOdrdtl_purprice(Tools.getDouble(p.getGdsmst_inprice(),2));
		orderItem.setOdrdtl_addshipfee(Tools.getDouble(new Float(p.getGdsmst_addshipfee()),2));//�����˷�  �ر��ص���Ʒ����Ʒ��ȡ
		orderItem.setOdrdtl_aspmemo("");//�ɹ���¼
		if(cart.getActid()!=null&&cart.getActid().longValue()>0){
		orderItem.setOdrdtl_actid(cart.getActid());
		orderItem.setOdrdtl_actmemo(cart.getActmemo());
		orderItem.setOdrdtl_actmoney(cart.getActmoney()/gslen);
		}
		
		orderItem.setOdrdtl_odrid(odrid);//������
		orderItem.setOdrdtl_gdsid(gs[l]);//product id
		orderItem.setOdrdtl_sku1("");//sku id
		orderItem.setOdrdtl_sku2("");//sku2 id û�� 
		
		
		if("0".equals(ticket_type)){
            if(brandpidstr.length()>0){
			if(brandpidstr.indexOf(cart.getProductId())==-1){
				orderItem.setOdrdtl_examineflag(new Long(1));
			}
            }else{
            	if(Tools.isNull(tktshopcode))tktshopcode="00000000";
            	if(!tktshopcode.equals(cart.getShopcode())&&!tktshopcode.equals("11111111")){
            		orderItem.setOdrdtl_examineflag(new Long(1));
            	}
            	
            }
		}else if("1".equals(ticket_type)){
			if(!"00000000".equals(cart.getShopcode())){
				orderItem.setOdrdtl_examineflag(new Long(1));
			}
			
		}else if("2".equals(ticket_type)){
			if(brandpidstr.indexOf(cart.getShopcode())==-1){
				orderItem.setOdrdtl_examineflag(new Long(1));
			}
		}
		
		orderItem.setOdrdtl_referer(cart.getRefererurl());
		orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//��Ʒ��
		orderItem.setOdrdtl_memberprice(new Double(mprice));//��Ա��
		orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//�г���
		orderItem.setOdrdtl_vipprice(new Double(p.getGdsmst_vipprice()));//vip ��
		
		if(cart.getType().longValue()==0||cart.getType().longValue()==12){//�������Ʒ
			orderItem.setOdrdtl_gifttype(cart.getGiftType());
			orderItem.setOdrdtl_rackcode(cart.getGiftRackcode());
			orderItem.setOdrdtl_buyflag(new Long(2));//��ƷΪ2
		}else{
			orderItem.setOdrdtl_gifttype("");
			orderItem.setOdrdtl_rackcode(p.getGdsmst_rackcode());
			orderItem.setOdrdtl_buyflag(new Long(0));//1Ϊ������Ʒ
		}
		orderItem.setOdrdtl_downflag(cart.getType());
		//Double finalprice = Tools.getDouble(new Float(cart.getMoney().floatValue()/cart.getAmount().longValue()),2);//�ɽ�����
		
		orderItem.setOdrdtl_finalprice(Tools.getDouble(dtlm,2));//���ɽ�����
		orderItem.setOdrdtl_gdscount(cart.getAmount());//��������
		orderItem.setOdrdtl_totalmoney(Tools.getDouble(dtlm,2));//�ɽ��ܽ��
		
		orderItem.setOdrdtl_shipstatus(new Long(1));//����״̬��1Ϊδ����
		orderItem.setOdrdtl_sendcount(cart.getAmount());//�����������ʼ0
		orderItem.setOdrdtl_creatdate(new Date());//��������
		
		orderItem.setOdrdtl_promotionword("");//������
		orderItem.setOdrdtl_refundcount(new Long(0));//û����������
		orderItem.setOdrdtl_weight(new Long(0));//��Ʒ����  ����
		
		
		
		orderItem.setOdrdtl_stddetail1(p.getGdsmst_stdvalue1());//����Ʒ��ȡ
		orderItem.setOdrdtl_stddetail2(p.getGdsmst_stdvalue2());
		orderItem.setOdrdtl_stddetail3(p.getGdsmst_stdvalue3());
		orderItem.setOdrdtl_stddetail4(p.getGdsmst_stdvalue4());
		orderItem.setOdrdtl_stddetail5(p.getGdsmst_stdvalue5());
		orderItem.setOdrdtl_stddetail6(p.getGdsmst_stdvalue6());
		orderItem.setOdrdtl_stddetail7(p.getGdsmst_stdvalue7());
		orderItem.setOdrdtl_stddetail8(p.getGdsmst_stdvalue8());
		orderItem.setOdrdtl_stddetail9("");//��Ʒû��stddetail9�ֶ�
		
		orderItem.setOdrdtl_presellflag(new Long(0));//�����ֶΣ�����
		orderItem.setOdrdtl_incometype(new Long(0));//�����ֶΣ�����
		orderItem.setOdrdtl_incomevalue(new Double(0));//�����ֶ�
		
		orderItem.setOdrdtl_totalincomevalue(Tools.getDouble(dtlm,2));//�����̻������� ����
		orderItem.setOdrdtl_eyuan(new Double(0));//��ƷӦ��Eȯ ��Ʒ��ȡ���۸��ܴ�����ȯ����Ʒ
		
		orderItem.setOdrdtl_spendcount(Tools.getDouble(new Float((int)cart.getMoney().intValue()),2));//���û�����
		
		orderItem.setOdrdtl_managememo("");//��Ʒ��������
		orderItem.setOdrdtl_gdspurmemo("");//�ɹ���ע 
		
		orderItem.setOdrdtl_specialflag(p.getGdsmst_specialflag());//0��ʲô�����룬1��ʾ��Ʒ������ȯ��2��ʾ���������˷���
		//orderItem.setOdrdtl_gifttype("");//��Ʒ����
		
		orderItem.setOdrdtl_refcount(p.getGdsmst_refcount());//�Ƿ�μӷ���ȯ������μ�Ϊ0������Ϊ1��Ŀǰû���ã�
		orderItem.setOdrdtl_jcflag(new Long(0));//û����
		
		orderItem.setOdrdtl_temp("");//��Ʒ���ǣ���¼������Դ������Ҫ���硰�Ź���Ʒ�����Ź��һ���

		//����������ϸ
		Tools.getManager(OrderItemCache.class).txCreate(orderItem);
	}

	}
	
	/**
	 * ֧���ɹ��޸Ķ���״̬�������Ҫ֧���Ľ��Ƚϲ���ȷ��Ҳ����null
	 * @param order - ��������
	 * @param dblAmount - ֧���Ľ��
	 * @return int -1orderΪnull,-2״̬����δ֧��״̬��-3��һ����-4���ݿ�ִ�д���0�ɹ�
	 */
	public int updateOrderStatus(OrderBase order , double dblAmount){
		/*if(order == null) return -1;
		//���û������������memcached�����ݿ⻺�棬���Ҫ�޸ĳɷֲ�ʽ�������ݿ���������
		synchronized(order){
			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return -2;
			//��ȷ����
			if((int)Math.round(Tools.doubleValue(order.getOdrmst_acturepaymoney())*10) != (int)Math.round(dblAmount*10)) return -3;//��һ��
			Tools.getManager(order.getClass()).txBeforeUpdate(order);
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(System.currentTimeMillis())+"֧��ϵͳ�Զ��տ�");
			order.setOdrmst_validdate(new Date());
			order.setOdrmst_orderstatus(new Long(2));
			order.setOdrmst_getmoney(Tools.getDouble(new Double((double)dblAmount),2));
			
			Tools.getManager(order.getClass()).txUpdate(order, true);
			
			//���ô洢���̰Ѷ����޸ĳɡ�ȷ���տ״̬����ִ�п����޸Ķ���������
			ProcedureWork work = new ProcedureWork(order.getId());
			Tools.getManager(order.getClass()).currentSession().doWork(work);//ִ��work
			
			if(Tools.longValue(order.getOdrmst_orderstatus()) == 0) return -4;
			return 1;
		}*/
		int ret=updateOrderStatus2013(order,dblAmount);
		if (ret==1){
		updateOrderStatuswork(order);
		}
		return ret;
	}
	
	
	public  boolean confirmGetMoney(OrderBase order,User loginUser){
		if(order.getOdrmst_orderstatus()!=null&&order.getOdrmst_orderstatus().longValue()==0){
				
			int ret=updateOrderStatushf(order);
		if (ret==1){
			updateOrderStatuswork(order);
			return true ;
			}
		}
		
		return false ;
	}
	public int updateOrderStatushf(OrderBase order ){
		if(order == null) return -1;
		//���û������������memcached�����ݿ⻺�棬���Ҫ�޸ĳɷֲ�ʽ�������ݿ���������
		synchronized(order){
			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return -2;
     		Tools.getManager(order.getClass()).txBeforeUpdate(order);
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(new Date()) +"���������Զ� ȷ��");
			order.setOdrmst_validdate(new Date());
			order.setOdrmst_orderstatus(new Long(1));
			
			Tools.getManager(order.getClass()).txUpdate(order, true);
			
			if(Tools.longValue(order.getOdrmst_orderstatus()) == 0) return -4;
			return 1;
		}
	}
	
	/**
	 * ֧���ɹ��޸Ķ���״̬�������Ҫ֧���Ľ��Ƚϲ���ȷ��Ҳ����null
	 * @param order - ��������
	 * @param dblAmount - ֧���Ľ��
	 * @return int -1orderΪnull,-2״̬����δ֧��״̬��-3��һ����-4���ݿ�ִ�д���0�ɹ�
	 */
	public int updateOrderStatus2013(OrderBase order , double dblAmount){
		if(order == null) return -1;
		//���û������������memcached�����ݿ⻺�棬���Ҫ�޸ĳɷֲ�ʽ�������ݿ���������
		synchronized(order){
			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return -2;
			//��ȷ����
			if((int)Math.round(Tools.doubleValue(order.getOdrmst_acturepaymoney())*10) != (int)Math.round(dblAmount*10)) return -3;//��һ��
			Tools.getManager(order.getClass()).txBeforeUpdate(order);
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(System.currentTimeMillis())+"֧��ϵͳ�Զ��տ�"+order.getOdrmst_acturepaymoney()+"Ԫ");
			order.setOdrmst_validdate(new Date());
			order.setOdrmst_orderstatus(new Long(2));
			order.setOdrmst_getmoney(Tools.getDouble(new Double((double)dblAmount),2));
			order.setOdrmst_realgetmoney(Tools.getDouble(new Double((double)dblAmount),2));
			order.setOdrmst_realstatus(new Long(1));
			order.setOdrmst_realgettime(new Date());
			Tools.getManager(order.getClass()).txUpdate(order, true);
			
			if(Tools.longValue(order.getOdrmst_orderstatus()) == 0) return -4;
			return 1;
		}
	}
	
	public int updateOrderStatuswork(OrderBase order){

		if(order == null) return -1;
		//���û������������memcached�����ݿ⻺�棬���Ҫ�޸ĳɷֲ�ʽ�������ݿ���������
		synchronized(order){
	
			
			//���ô洢���̰Ѷ����޸ĳɡ�ȷ���տ״̬����ִ�п����޸Ķ���������
			try {
			ProcedureWork work = new ProcedureWork(order.getId());
			Tools.getManager(order.getClass()).currentSession().doWork(work);//ִ��work
			
				Tools.getManager(order.getClass()).currentSession().connection().commit();
			} catch (HibernateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
			return 1;
		}

	}
	
	/**
	 * ȡ������
	 * @param orderId
	 */
	public void cancelOrder(OrderBase order){
		if(order==null)return;
		synchronized(order){
			if(order.getOdrmst_orderstatus().longValue()!=-1){
				Tools.getManager(order.getClass()).txBeforeUpdate(order);
				// 1=cache������2=main������3=recent������4=history����
				if(order.getOdrmst_prepayvalue()!=null&&order.getOdrmst_prepayvalue().floatValue()>0){//ʹ����Ԥ���
					Prepay prepay = new Prepay();
					prepay.setPrepay_createdate(new Date());
					prepay.setPrepay_log("ȡ�������˻�");
					prepay.setPrepay_memo("ȡ�������˻�");
					prepay.setPrepay_odrid(order.getId());
					prepay.setPrepay_status(new Long(0));
					prepay.setPrepay_type(new Long(4));
					prepay.setPrepay_mbrid(order.getOdrmst_mbrid());
					prepay.setPrepay_value(new Float(order.getOdrmst_prepayvalue()));
					prepay.setPropay_operator(order.getOdrmst_mbrid()+"");
					Tools.getManager(Prepay.class).txCreate(prepay);
					
					order.setOdrmst_prepayvalue(new Double(0));
				}
				
				if(order.getOdrmst_tktvalue()!=null&&order.getOdrmst_tktvalue().floatValue()>0&&order.getOdrmst_tktid().longValue()!=0){//��������ȯ��
					Ticket ticket = (Ticket)Tools.getManager(Ticket.class).txGet(order.getOdrmst_tktid()+"");
					
					//ʹ�ù���Ticket�����ǴӰٷֱȼ��⡢Ҳ����Ʒ�Ƽ������ɵ�ȯ����
					if(ticket.getTktmst_ifcrd().longValue()==0&&!"015004".equals(ticket.getTktmst_type())){
						Tools.getManager(Ticket.class).txBeforeUpdate(ticket);
						ticket.setTktmst_validflag(new Long(0));
						ticket.setTktmst_sodrid("");
						ticket.setTktmst_uodrid("");
						Tools.getManager(Ticket.class).txUpdate(ticket, true);
					}
				}
				
				order.setOdrmst_tktid(new Long(0));
				order.setOdrmst_tktvalue(new Double(0));
				
				order.setOdrmst_orderstatus(new Long(-1));
				Tools.getManager(order.getClass()).txUpdate(order, true);
			}
		}
	}
}
