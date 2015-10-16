package com.d1.search;

import java.util.Comparator;

import com.d1.util.Tools;

/**
 * ���չؼ��ʽ���������򣬸�ʽ��ţ�п�|189�������ӻ�|100���������ǵ���
 * @author kk
 *
 */
public class StringCountComparator implements Comparator<String>{

	@Override
	public int compare(String p0, String p1) {
		if(Tools.isNull(p0)||Tools.isNull(p1))return 0;
		int n0 = new Integer(p0.substring(p0.indexOf("|")+1));
		int n1 = new Integer(p1.substring(p1.indexOf("|")+1));
		
		if(n0>n1){
			return -1 ;
		}else if(n0==n1){
			return 0 ;
		}else{
			return 1 ;
		}
	}
}
