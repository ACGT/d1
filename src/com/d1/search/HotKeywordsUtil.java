package com.d1.search;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

import com.d1.Const;
import com.d1.util.Tools;

/**
 * ��ȡ�������������й��ߣ�������������ʽ�����ʾ
 * @author kk
 */
public class HotKeywordsUtil {
	/**
	 * ȡ�����ļ�
	 */
	private static final String HOT_KEY_CONF_FILE = Const.PROJECT_PATH+"/conf/hot_search_keys.txt";
	
	/**
	 * ɢ�д洢��hashmap
	 */
	private static HashMap<String,ArrayList<String>> map_hash = new HashMap<String,ArrayList<String>>();
	
	/**
	 * ��ʼ�������ʵ�list��map����ȡ�����ļ�
	 */
	static{
		try{
			BufferedReader br = new BufferedReader(new FileReader(new File(HOT_KEY_CONF_FILE)));
			
			String line = null ;

			while((line=br.readLine())!=null){
				String temp = line.toLowerCase();
				String[] fs = temp.split(",");
				
				if(fs==null||fs.length!=4)continue;
				
				String fullSpell = fs[1] ;//ȫƴ
				String firstPinYin = "";
				if(fullSpell!=null&&fullSpell.length()>0){
					String a1 = fullSpell.charAt(0)+"";//��һ����ĸ
					firstPinYin = a1 ;
					if(map_hash.containsKey(a1)){
						ArrayList<String> l = map_hash.get(a1);
						l.add(temp);
					}else{
						ArrayList<String> l = new ArrayList<String>();
						l.add(temp);
						map_hash.put(a1, l);
					}
				}
				
				String a1 = temp.charAt(0)+"";
				if(!firstPinYin.equals(a1)){//��һ��char�����Ǻ���
					if(map_hash.containsKey(a1)){
						ArrayList<String> l = map_hash.get(a1);
						l.add(temp);
					}else{
						ArrayList<String> l = new ArrayList<String>();
						l.add(temp);
						map_hash.put(a1, l);
					}
				}
			}
			br.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
	/**
	 * �õ�jason���ؽ��
	 * @param input
	 * @param top
	 * @return
	 */
	public static String getTopJsonHotKeyWords(String input,int top){
		ArrayList<String> list = com.d1.search.HotKeywordsUtil.getTopMatchHotSearchKeyWords(input,top);
		
		String ns = "{\"results\":[]}";
		if(list==null||list.size()==0)return ns;
		
		StringBuffer sb = new StringBuffer();
		sb.append("{\"results\":[");
		int size = list.size();
		for(int i=0;i<size;i++){
			String k = list.get(i);
			if(k.indexOf("|")>-1){
				k=k.substring(0,k.indexOf("|"));
			}
			sb.append("{\"id\":\""+i+"\",\"name\":\""+k+"\"}");
			if(i<size-1) sb.append(",");
		}
		sb.append("]}");
		return sb.toString();
	}
	
	/**
	 * for autocomplete��������
	 * @param input
	 * @param top
	 * @return
	 */
	public static String getTopJsonHotKeyWords_auto(String input,int top){
		ArrayList<String> list = com.d1.search.HotKeywordsUtil.getTopMatchHotSearchKeyWords(input,top);
		
		String ns = "jsonp"+System.currentTimeMillis()+"([{}])";
		if(list==null||list.size()==0)return ns;
		
		StringBuffer sb = new StringBuffer();
		sb.append("jspnp"+System.currentTimeMillis()+"([");
		int size = list.size();
		for(int i=0;i<size;i++){
			String k = list.get(i);
			if(k.indexOf("|")>-1){
				k=k.substring(0,k.indexOf("|"));
			}
			sb.append("{\"id\":\""+i+"\",\"name\":\""+k+"\"}");
			if(i<size-1) sb.append(",");
		}
		sb.append("])");
		return sb.toString();
	}
	/**
	 * ȡ����top��ƥ��ؼ���
	 * @param input
	 * @param top
	 * @return
	 */
	public static ArrayList<String> getTopMatchHotSearchKeyWords(String input,int top){
		if(Tools.isNull(input))return null ;
		input = input.toLowerCase();
		ArrayList<String> list_ok = getAllMatchHotSearchKeyWords(input);
		
		if(list_ok==null||list_ok.size()==0)return null;
		
		Collections.sort(list_ok,new StringCountComparator());
		
		ArrayList<String> list_re = new ArrayList<String>();
		for(int i=0;i<top&&i<list_ok.size();i++){
			list_re.add(list_ok.get(i));
		}
		return list_re;
	}
	
	/**
	 * �õ���������������
	 * @param input �û����������
	 * @return arraylist �����ǡ�ţ�п�|189�����ָ�ʽ
	 */
	private static ArrayList<String> getAllMatchHotSearchKeyWords(String input){
		if(Tools.isNull(input))return null;
		ArrayList<String> list = map_hash.get(input.charAt(0)+"");
		if(list==null||list.size()==0)return null;
		
		ArrayList<String> list_ok = new ArrayList<String>();
		for(String s:list){
			String[] fs = s.split(",");
			if(fs==null|fs.length!=4)continue;
			if(StringMatchUtil.match(input, fs[0], fs[1], fs[2])){
				list_ok.add(fs[0]+"|"+fs[3]);
			}
		}
		
		return list_ok;
	}
	
	public static void main(String[] args)throws Exception{
		ArrayList<String> l = getTopMatchHotSearchKeyWords("zhzh",15);
		System.out.println("go");
		if(l!=null)
		for(String s:l){
			System.out.println(s);
		}
	}
}
