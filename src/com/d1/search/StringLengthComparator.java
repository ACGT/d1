package com.d1.search;

import java.util.Comparator;

/**
 * �Ƚ��ַ������ȵ���
 * @author kk
 *
 */
public class StringLengthComparator implements Comparator<String>{

	@Override
	public int compare(String p0, String p1) {
		if(p0.length()>p1.length())return -1;
		else if(p0.length()==p1.length())return 0;
		else return 1;
	}
}
