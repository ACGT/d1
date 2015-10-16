package com.d1.comp;

import java.util.Comparator;

import com.d1.bean.Product;

/**
 * �����޸�ʱ��Ƚ���Ʒ
 * @author kk
 *
 */
public class UpdateTimeComparator implements Comparator<Product>{

	@Override
	public int compare(Product p0, Product p1) {
		//�Ȱ����Ƿ�ȱ������
		if(p0.getGdsmst_ifhavegds()!=null&&p1.getGdsmst_ifhavegds()!=null){
			if(p0.getGdsmst_ifhavegds().longValue()>p1.getGdsmst_ifhavegds().longValue()){
				return -1;
			}else if(p0.getGdsmst_ifhavegds().longValue()<p1.getGdsmst_ifhavegds().longValue()){
				return 1;
			}
		}
		
		if(p0.getGdsmst_updatedate()!=null&&p1.getGdsmst_updatedate()!=null){
			if(p0.getGdsmst_updatedate().getTime()>p1.getGdsmst_updatedate().getTime()){
				return 1 ;
			}else if(p0.getGdsmst_updatedate().getTime()==p1.getGdsmst_updatedate().getTime()){
				return 0 ;
			}else{
				return -1 ;
			}
		}
		return 0;
	}
}
