package com.d1.helper;


import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.d1.bean.Tuandh;
import com.d1.bean.TuandhGroup;
import com.d1.bean.User;

import com.d1.util.StringUtils;
import com.d1.util.Tools;

public class TuandhGroupHelper {
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
	User loginUser = UserHelper.getLoginUser(request, response);//��½�û�
	if(cardno.length()>10){//������ticketgroup�ļ�¼
		String tgid = cardno.substring(0,cardno.length()-10);
		
		String num = cardno.substring(cardno.length()-10);//10λ��
		
		String last2num = num.substring(num.length()-2);
		
		map.put("failreason", "ȯ�Ų���ȷ");//����Ḳ��
		
		if(StringUtils.isDigits(num)){
			TuandhGroup tg = (TuandhGroup)Tools.getManager(TuandhGroup.class).findByProperty("tuandhgroup_title", tgid);
			if(tg!=null){//�жϹ���
				int sum = 0 ;
				for(int i=0;i<8;i++){//ǰ8λ������
					sum+=new Integer(num.charAt(i)+"").intValue();
				}
				
				String sum2 = (sum+tg.getTuandhgroup_checkcode().longValue())+"";
				if(sum2.length()>2)sum2=sum2.substring(sum2.length()-2);//ȡ�����λ
				else if(sum2.length()<2)sum2="0"+sum2 ;//��0��û���������
				
				if(last2num.equals(sum2)){//���Ϲ���
					Tuandh tuan = (Tuandh)Tools.getManager(Tuandh.class).findByProperty("tuandh_cardno", cardno);
					if(tuan!=null){
						if(tuan.getTuandh_status().intValue()==2){
							map.put("failreason", "��ȯ���ѱ�ʹ��");
							return map ;
						}
					}else{
						//δ�ο������һ���¼�¼
						Tuandh t=new Tuandh();
						t.setTuandh_cardno(cardno);
						t.setTuandh_createtime(tg.getTuandhgroup_createdate());
						t.setTuandh_endtime(tg.getTuandhgroup_validatee());
						t.setTuandh_gdsid(tg.getTuandhgroup_gdsid());
						t.setTuandh_memo(tg.getTuandhgroup_memo());
						t.setTuandh_title(tg.getTuandhgroup_memo());
						t.setTuandh_status(new Long(1));
						t.setTuandh_yztime(new Date());
						t.setTuandh_mbrid(new Long(loginUser.getId()));
						t.setTuandh_mid(tg.getTuandhgroup_mid());
						Tools.getManager(Tuandh.class).create(t);
					}
					
				
				}
			}
		}// end if
	}
	
	return map ;
}
}
