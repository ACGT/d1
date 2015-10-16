package com.d1.search;

import com.d1.util.Base64;
import com.d1.util.Tools;

/**
 * �Ƚ�һ�������Ƿ�ƥ��һ���ַ������û����롰NZK���͡�NiuZku������ƥ�䡰ţ�п㡱<br/>
 * @author kk
 */
public class StringMatchUtil {
	
	/**
	 * �ж��û��������Ƿ�matchһ����ѯ�ؼ��ʣ�����ֻ��1��ȫ���Ƚ�һ��Ҳ�޷���<br/>
	 * ����ؼ��ʳ���10�򣬿�����ɢ��<br/>
	 * @param input �û���������������ݣ�������ƴ�������֡���ĸ�ȸ�����ʽ
	 * @param key ��ѯ�ؼ��ʿ���Ĵ�
	 * @param fullPinYin key��ȫƴ
	 * @param firstPinYin key��ƴ����ĸ����ĸ��_���
	 * @return true ��ʾƥ��
	 */
	public static boolean match(String input,String key,String fullPinYin,String firstPinYin){
		if(Tools.isNull(input)||Tools.isNull(key))return false;
		input = input.toLowerCase();
		
		//fullPinYin = ChineseToSpell.getFullSpell(key);//ȫƴ
		//firstPinYin = ChineseToSpell.getFirstSpell(key);//ƴ����ĸ
		
		//��һ����ĸҪһ�²���ƥ��
		if(key.charAt(0)!=input.charAt(0)
				&&firstPinYin.charAt(0)!=input.charAt(0))return false;
		
		if(input.length()>fullPinYin.length())return false ;
		
		//������֡�ƴ������ĸƥ������ٷ���
		if(key.startsWith(input))return true ;
		if(fullPinYin.startsWith(input))return true ;
		if(firstPinYin.startsWith(input))return true ;
		
		int p=0;//fullPinYin��Ӧ��λ��
		int px=0;//input�ж�Ӧ��λ��
		for(int i=0;i<fullPinYin.length()&&px<input.length();i++){
			if(fullPinYin.charAt(p)!=input.charAt(px)){
				
				//����ĸ�ڶ������ϵ�λ�ò���ȣ�˵����ƥ��
				if(p>0&&firstPinYin.charAt(p-1)=='_')return false;
				
				boolean findNext = false ;//�Ƿ��ҵ���һ����ĸ
				
				for(int j=p+1;j<firstPinYin.length();j++){
					if(firstPinYin.charAt(j)!='_'){
						findNext = true ;
						p = j;
						i = p ;//����ƶ�
						
						//�����һ����ĸ���û�����Ĳ�һ�£���ƥ��
						if(fullPinYin.charAt(p)!=input.charAt(px)){
							return false ;
						}else{//�����ȽϺ�����ַ�
							break;
						}
					}
				}//end for j
				
				//�������û�ҵ���һ����ĸ
				if(!findNext){
					return false ;
				}
			}

			p++;
			px++;
		}//end for i

		if(px<input.length()){
			return false;//���û�Ƚ���input
		}
		
		return true ;
	}
	
	public static void main(String[] args)throws Exception{

		System.out.println(match("shfushui","ˬ��ˮ","shuangfushui","sH____f_s___")+" true");
		
		System.out.println(Base64.encode("��ˮ"));
		System.out.println(match("nshib","��ʿǮ��","nanshiqianbao","n__s__q___b__")+" false");
		System.out.println(match("nshiqbb","��ʿǮ��","nanshiqianbao","n__s__q___b__")+" false");
		System.out.println(match("nshiQianB","��ʿǮ��","nanshiqianbao","n__s__q___b__")+" true");
		System.out.println(match("nshiqiangb","��ʿǮ��","nanshiqianbao","n__s__q___b__")+" false");
		
		System.out.println(match("wanzk","�Ұ�ţ�п�","woainiuzaiku","w_a_n__z__k_")+" true");
		System.out.println(match("woainizku","�Ұ�ţ�п�","woainiuzaiku","w_a_n__z__k_")+" false");
		System.out.println(match("woainzaika","�Ұ�ţ�п�","woainiuzaiku","w_a_n__z__k_")+" false");
		System.out.println(match("wiainzku","�Ұ�ţ�п�","woainiuzaiku","w_a_n__z__k_")+" false");
		System.out.println(match("wanzk","�Ұ�ţ�п�","woainiuzaiku","w_a_n__z__k_")+" true");
		System.out.println(match("woainzku","�Ұ�ţ�п�","woainiuzaiku","w_a_n__z__k_")+" true");
		System.out.println(match("waniuzk","�Ұ�ţ�п�","woainiuzaiku","w_a_n__z__k_")+" true");
		
		System.out.println(match("woaoniuzaiku","�Ұ�ţ�п�","woainiuzaiku","w_a_n__z__k_")+" false");
		System.out.println(match("woainzku","�Ұ�ţ�п�","woainiuzaiku","w_a_n__z__k_")+" true");
		System.out.println(match("wanzka","�Ұ�ţ�п�","woainiuzaiku","w_a_n__z__k_")+" false");
		System.out.println(match("woaniuzaoku","�Ұ�ţ�п�","woainiuzaiku","w_a_n__z__k_")+" false");
		System.out.println(match("woainiuzaikup","�Ұ�ţ�п�","woainiuzaiku","w_a_n__z__k_")+" false");
		
	}
}
