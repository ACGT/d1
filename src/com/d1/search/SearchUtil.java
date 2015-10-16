package com.d1.search;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;

import org.apache.lucene.analysis.tokenattributes.TermAttribute;
import org.wltea.analyzer.lucene.IKTokenizer;

import com.d1.util.StringUtils;
import com.d1.util.Tools;

/**
 * ���������ؼ����б�Ĺ��ߣ����ڣ������£�����һ�μ���
 * @author kk
 *
 */
public class SearchUtil {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception{
		//test6();
		//test2();
		//ArrayList<String> l = ikSplit("������");
		//for(String s:l)System.out.println(s);
		
		//test7();
		
	}
	

	/**
	 * ���Ա��ؼ�������С���������硰��ޢ��ˮ����һ���ʣ����ǡ���ޢ���͡���ˮ�����Ǵʣ���ô����ޢ��ˮ���Ͳ���һ�δʡ�<br/>
	 * �����û����롰��ޢ��ˮ����ʱ��Ϳ��Բ�ɡ���ޢ   ��ˮ���Զ��ִʽ���������������<br/>
	 * ��Ҫ���ж�Σ�������С���ʿ⣬֪��Դ�ļ���Ŀ���ļ�����һ��Ϊֹ��<br/>
	 */
	public static void test6(){
		try{
			BufferedReader br = new BufferedReader(new FileReader(new File("d:/taobao5.txt")));
			
			String line = null ;
			//ArrayList<String> list_k = new ArrayList<String>();
			
			HashMap<String,String> map = new HashMap<String,String>();//���д�
			
			while((line=br.readLine())!=null){
				map.put(line, "");
			}
			br.close();
			
			Iterator<String> it = map.keySet().iterator();;
			//StringBuffer sb = new StringBuffer();
			ArrayList<String> rlist = new ArrayList<String>();
			//int c = 0;
			
			while(it.hasNext()){
				//c++;
				String name = it.next();//�����ļ����ÿһ���ʣ����еڶ��η���
				
				HashMap<String,String> rmap = new HashMap<String,String>();//���map
				
				//�����������ƥ��
				for(int i=0;i<name.length();i++){
					String k = name.charAt(i)+"";
					
					int p = 0 ;
					for(int j=i+1;j<=name.length();j++){
						String w = name.substring(i,j);
						//System.out.println(w);
						if(map.containsKey(w)&&!name.equals(w)){
							k = name.substring(i,j);
							//System.out.println(w);
							p = j-i-1;
							break;
						}
					}
					i+=p;
					rmap.put(k,"");
				}
				
				Iterator<String> it2 = rmap.keySet().iterator();
				boolean add = false ;
				while(it2.hasNext()){
					String k2 = it2.next();
					if(!map.containsKey(k2)){
						add = true ;
					}
				}
				
				
				if(add){
					//System.out.println(name);
					//sb.append(name).append(System.getProperty("line.separator"));
					rlist.add(name);
				}else{
					System.out.print(">>>"+name+"  �ִʽ����");
					Iterator<String> it3 = rmap.keySet().iterator();
					//boolean add = false ;
					while(it3.hasNext()){
						String k2 = it3.next();
						System.out.print(k2+"|");
					}
					System.out.println();
					
					//System.out.println(name);
				}
				//if(c>1000)break;
			}
			
			Collections.sort(rlist);
			StringBuffer sb = new StringBuffer();
			for(String s123:rlist){
				sb.append(s123).append(System.getProperty("line.separator"));
			}
			
			
			FileWriter fw = new FileWriter(new File("d:/taobao6.txt"));
			fw.write(sb.toString());
			fw.flush();
			fw.close();
			
			
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
	/**
	 * ����IKAnalyzer�ִʽ��
	 * @param name
	 * @return
	 */
	public static ArrayList<String> ikSplit(String name){
		if(Tools.isNull(name))return null;
		
		ArrayList<String> list = new ArrayList<String>();
		HashMap<String,String> map = new HashMap<String,String>();//mapΪ��ȥ��
		IKTokenizer tokenizer = new IKTokenizer(new StringReader(name) , false);
		try {
			while(tokenizer.incrementToken()){
				TermAttribute termAtt = tokenizer.getAttribute(TermAttribute.class);
				map.put(termAtt.term(),"");				
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Iterator<String> it = map.keySet().iterator();
		while(it.hasNext()){
			list.add(it.next());
		}
		
		if(list.size()<=1)return list;//���ֻ��һ���ʣ��ֵ�û���⣬�����Ż�
		
		//Ȼ���Ż�һ�·ִʽ����������ƥ�䣬ȥ��һЩ�����Ի��Ľ����
		//�硰������ţ�п㡱�ִʽ���ǡ�������ţ�п�   ������   ����   ��  ţ��   �п㡱��
		//����ʵ��ֻ��Ҫ��������   ţ�п㡱����Ϊ��ţ�С��Ǹ��ʣ���ţ�п㡱�������ʣ�
		ArrayList<String> rlist = new ArrayList<String>();
		
		for(int i=0;i<list.size();i++){
			String s1 = list.get(i);
			map.put(s1, "");
		}
		
		//for(String s:list)System.out.println("map===="+s);
		
		HashMap<String,String> rmap = new HashMap<String,String>();//���map
 		
		for(int i=0;i<name.length();i++){
			String k = name.charAt(i)+"";
			
			int p = 0 ;
			for(int j=i+1;j<=name.length();j++){
				String w = name.substring(i,j);
				//System.out.println(w);
				if(map.containsKey(w)&&!name.equals(w)){
					k = name.substring(i,j);
					//System.out.println(w);
					p = j-i-1;
				}
			}
			i+=p;
			rmap.put(k,"");
		}
 		
 		Iterator<String> it2 = rmap.keySet().iterator();
		while(it2.hasNext()){
			rlist.add(it2.next());
		}
		return rlist;
	}
	
	/**
	 * �����Ա��ؼ����ļ���ȥ�ء�����
	 */
	public static void test5(){
		try{
			BufferedReader br = new BufferedReader(new FileReader(new File("d:/taobaokey.txt")));
			
			String line = null ;
			ArrayList<String> list_k = new ArrayList<String>();
			
			HashMap<String,String> map = new HashMap<String,String>();
			
			while((line=br.readLine())!=null){
				line = line.replaceAll("[^\\u4e00-\\u9fa5]", " ");
				line = line.replaceAll("\\s+", " ");
				String[] fs = line.split(" ");
				if(fs!=null){
					for(int i=0;i<fs.length;i++){
						String sss = fs[i];
						String temp = sss.replaceAll("[\\u4e00-\\u9fa5]", "");
						if(sss.length()!=temp.length()&&sss.length()>1)map.put(fs[i], "");
					}
				}
			}
			br.close();
			
			
			
			Iterator<String> it = map.keySet().iterator();		
			while(it.hasNext()){
				
				String k = it.next();
				list_k.add(k);
				/*
				ArrayList<String> ll = ikSplit(k);
				
				if(ll!=null&&ll.size()>1){
					boolean show = true ;
					for(String s123:ll){
						if(!map.containsKey(s123)){
							sb.append(k).append(System.getProperty("line.separator"));
							show = false ;
							break;
						}
					}
					if(show){
						System.out.print(k+"         ==>");
						for(String s123:ll)System.out.print(s123+"|");
						System.out.println();
					}
				}else{
					sb.append(k).append(System.getProperty("line.separator"));
					//System.out.println(k);
				}
				*/
			}
			System.out.println("go end");
			Collections.sort(list_k);
			
			StringBuffer sb = new StringBuffer();
			for(String ss:list_k){
				sb.append(ss).append(System.getProperty("line.separator"));
			}
			
			FileWriter fw = new FileWriter(new File("d:/taobao_keywords.txt"));
			fw.write(sb.toString());
			fw.flush();
			fw.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	/**
	 * ����ƥ���ٶ�
	 */
	public static void test4(){
		try{
			BufferedReader br = new BufferedReader(new FileReader(new File("d:/r_ok2.txt")));
			
			String line = null ;
			ArrayList<String> list_k = new ArrayList<String>();
			
			HashMap<String,ArrayList<String>> map_hash = new HashMap<String,ArrayList<String>>();
			
			//StringBuffer sb = new StringBuffer();
			
			while((line=br.readLine())!=null){
				String temp = line.toLowerCase();
				//String tempw = line.substring(line.indexOf(" ")+1);
				//temp = line.substring(0,line.indexOf(" "));
				//sb.append(temp+","+ChineseToSpell.getFullSpell(temp)+","+ChineseToSpell.getFirstSpell(temp)+","+tempw).append(System.getProperty("line.separator"));
				if(!StringUtils.isDigits(temp))list_k.add(line);
				
				String st = PinyinUtil.getFirstPinyin(temp);
				if(st.length()>0){
					String a1 = st.charAt(0)+"";
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
				if(map_hash.containsKey(a1)){
					ArrayList<String> l = map_hash.get(a1);
					l.add(temp);
				}else{
					ArrayList<String> l = new ArrayList<String>();
					l.add(temp);
					map_hash.put(a1, l);
				}
			}
			br.close();
			
			/*
			FileWriter fw = new FileWriter(new File("d:/r_ok2.txt"));
			fw.write(sb.toString());
			fw.flush();
			fw.close();*/
			
			
			long start = System.currentTimeMillis();
			for(int i=0;i<100;i++){
				String input = "shhlshiqi";
				ArrayList<String> ll = map_hash.get((input.charAt(0)+"").toLowerCase());
				for(String s:ll){
					String[] ss = s.split(",");
					if(StringMatchUtil.match(input, ss[0],ss[1],ss[2])){
						System.out.println(ss[0]);
					}
				}
			}
			long end = System.currentTimeMillis();
			
			System.out.println(end-start);
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
	public static void test3(){
		System.out.println("go");
		try{
			BufferedReader br = new BufferedReader(new FileReader(new File("d:/r.txt")));
					
			String line = null ;
			ArrayList<String> list_k = new ArrayList<String>();
			
			while((line=br.readLine())!=null){
				String temp = line.substring(0,line.indexOf(" "));
				if(!StringUtils.isDigits(temp))list_k.add(line);
			}
			br.close();
			
			Collections.sort(list_k);
			
			StringBuffer sb = new StringBuffer();
			
			for(String s:list_k){
				sb.append(s).append(System.getProperty("line.separator"));
			}
			
			FileWriter fw = new FileWriter(new File("d:/r_ok.txt"));
			fw.write(sb.toString());
			fw.flush();
			fw.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
	/**
	 * �ҳ�d1��Ʒ�������ʺ����������������Ҫ���кü���Сʱ
	 */
	public static void test2(){
		try{
			BufferedReader br = new BufferedReader(new FileReader(new File("d:/taobao.txt")));
			String line = null ;
			ArrayList<String> list_k = new ArrayList<String>();
			
			while((line=br.readLine())!=null){
				list_k.add(line);
			}
			br.close();
			
			BufferedReader br2 = new BufferedReader(new FileReader(new File("d:/d1.txt")));
			String line2 = null ;
			
			HashMap<String,Integer> m = new HashMap<String,Integer>();
			
			int c=0;
			while((line2=br2.readLine())!=null){
				c++;
				if(c%1000==0)System.out.println(line2);
				//if(c>10)break;
				for(String s:list_k){
					if(line2.toLowerCase().indexOf(s.toLowerCase())>-1){
						if(m.containsKey(s)){
							Integer i = m.get(s);
							m.put(s, new Integer(i.intValue()+1));
						}else{
							m.put(s, new Integer(1));
						}
					}
				}
			}
			
			br2.close();
			
			//ArrayList<String> l123 = new ArrayList<String>();
			StringBuffer sb = new StringBuffer();
			
			Iterator<String> it = m.keySet().iterator();
			while(it.hasNext()){
				String k = it.next();
				sb.append(k+" "+m.get(k)).append(System.getProperty("line.separator"));
			}
			
			FileWriter fw = new FileWriter(new File("d:/r.txt"));
			fw.write(sb.toString());
			fw.flush();
			fw.close();
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}

	public static void test(){
		try{
			BufferedReader br = new BufferedReader(new FileReader(new File("d:/taobaokey.txt")));
			String line = null ;
			HashMap<String,String> m = new HashMap<String,String>();
			
			int c = 0;
			while((line=br.readLine())!=null){
				line = line.trim();
				line = line.replaceAll("\\s+", ",");
				String[] ls = line.split(",");
				if(ls!=null&&ls.length>0){
					for(int i=0;i<ls.length;i++){
						m.put(ls[i], "");
						c++;
					}
				}
			}
			br.close();
			
			System.out.println(c);
			ArrayList<String> list = new ArrayList<String>();
			Iterator<String> it = m.keySet().iterator();
			while(it.hasNext()){
				list.add(it.next());
			}
			
			Collections.sort(list);
			StringBuffer sb = new StringBuffer();
			
			for(String s:list){
				sb.append(s).append(System.getProperty("line.separator"));
			}
			
			FileWriter fw = new FileWriter(new File("d:/taobaokey.txt"));
			fw.write(sb.toString());
			fw.flush();
			fw.close();
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
}
