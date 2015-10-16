package com.d1.search;

import com.d1.util.Base64;
import com.d1.util.Tools;

/**
 * 比较一段输入是否匹配一个字符串，用户输入“NZK”和“NiuZku”都能匹配“牛仔裤”<br/>
 * @author kk
 */
public class StringMatchUtil {
	
	/**
	 * 判断用户的输入是否match一个查询关键词，数量只有1万，全部比较一次也无妨。<br/>
	 * 如果关键词超过10万，可以用散列<br/>
	 * @param input 用户输入搜索框的内容，可以是拼音、汉字、声母等各种形式
	 * @param key 查询关键词库里的词
	 * @param fullPinYin key的全拼
	 * @param firstPinYin key的拼音声母，韵母用_填充
	 * @return true 表示匹配
	 */
	public static boolean match(String input,String key,String fullPinYin,String firstPinYin){
		if(Tools.isNull(input)||Tools.isNull(key))return false;
		input = input.toLowerCase();
		
		//fullPinYin = ChineseToSpell.getFullSpell(key);//全拼
		//firstPinYin = ChineseToSpell.getFirstSpell(key);//拼音声母
		
		//第一个字母要一致才算匹配
		if(key.charAt(0)!=input.charAt(0)
				&&firstPinYin.charAt(0)!=input.charAt(0))return false;
		
		if(input.length()>fullPinYin.length())return false ;
		
		//如果汉字、拼音或声母匹配则快速返回
		if(key.startsWith(input))return true ;
		if(fullPinYin.startsWith(input))return true ;
		if(firstPinYin.startsWith(input))return true ;
		
		int p=0;//fullPinYin对应的位置
		int px=0;//input中对应的位置
		for(int i=0;i<fullPinYin.length()&&px<input.length();i++){
			if(fullPinYin.charAt(p)!=input.charAt(px)){
				
				//在韵母第二个以上的位置不相等，说明不匹配
				if(p>0&&firstPinYin.charAt(p-1)=='_')return false;
				
				boolean findNext = false ;//是否找到下一个声母
				
				for(int j=p+1;j<firstPinYin.length();j++){
					if(firstPinYin.charAt(j)!='_'){
						findNext = true ;
						p = j;
						i = p ;//向后移动
						
						//如果下一个声母和用户输入的不一致，则不匹配
						if(fullPinYin.charAt(p)!=input.charAt(px)){
							return false ;
						}else{//继续比较后面的字符
							break;
						}
					}
				}//end for j
				
				//不相等又没找到下一个声母
				if(!findNext){
					return false ;
				}
			}

			p++;
			px++;
		}//end for i

		if(px<input.length()){
			return false;//如果没比较完input
		}
		
		return true ;
	}
	
	public static void main(String[] args)throws Exception{

		System.out.println(match("shfushui","爽肤水","shuangfushui","sH____f_s___")+" true");
		
		System.out.println(Base64.encode("香水"));
		System.out.println(match("nshib","男士钱包","nanshiqianbao","n__s__q___b__")+" false");
		System.out.println(match("nshiqbb","男士钱包","nanshiqianbao","n__s__q___b__")+" false");
		System.out.println(match("nshiQianB","男士钱包","nanshiqianbao","n__s__q___b__")+" true");
		System.out.println(match("nshiqiangb","男士钱包","nanshiqianbao","n__s__q___b__")+" false");
		
		System.out.println(match("wanzk","我爱牛仔裤","woainiuzaiku","w_a_n__z__k_")+" true");
		System.out.println(match("woainizku","我爱牛仔裤","woainiuzaiku","w_a_n__z__k_")+" false");
		System.out.println(match("woainzaika","我爱牛仔裤","woainiuzaiku","w_a_n__z__k_")+" false");
		System.out.println(match("wiainzku","我爱牛仔裤","woainiuzaiku","w_a_n__z__k_")+" false");
		System.out.println(match("wanzk","我爱牛仔裤","woainiuzaiku","w_a_n__z__k_")+" true");
		System.out.println(match("woainzku","我爱牛仔裤","woainiuzaiku","w_a_n__z__k_")+" true");
		System.out.println(match("waniuzk","我爱牛仔裤","woainiuzaiku","w_a_n__z__k_")+" true");
		
		System.out.println(match("woaoniuzaiku","我爱牛仔裤","woainiuzaiku","w_a_n__z__k_")+" false");
		System.out.println(match("woainzku","我爱牛仔裤","woainiuzaiku","w_a_n__z__k_")+" true");
		System.out.println(match("wanzka","我爱牛仔裤","woainiuzaiku","w_a_n__z__k_")+" false");
		System.out.println(match("woaniuzaoku","我爱牛仔裤","woainiuzaiku","w_a_n__z__k_")+" false");
		System.out.println(match("woainiuzaikup","我爱牛仔裤","woainiuzaiku","w_a_n__z__k_")+" false");
		
	}
}
