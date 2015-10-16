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
 * 生成搜索关键词列表的工具，定期（数个月）生成一次即可
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
		//ArrayList<String> l = ikSplit("九牧王");
		//for(String s:l)System.out.println(s);
		
		//test7();
		
	}
	

	/**
	 * 把淘宝关键词做最小颗粒化。如“兰蔻香水”是一个词，但是“兰蔻”和“香水”都是词，那么“兰蔻香水”就不算一次词。<br/>
	 * 这样用户输入“兰蔻香水”的时候就可以拆成“兰蔻   香水”自动分词进行搜索！！！！<br/>
	 * 需要运行多次，不断最小化词库，知道源文件和目标文件行数一致为止。<br/>
	 */
	public static void test6(){
		try{
			BufferedReader br = new BufferedReader(new FileReader(new File("d:/taobao5.txt")));
			
			String line = null ;
			//ArrayList<String> list_k = new ArrayList<String>();
			
			HashMap<String,String> map = new HashMap<String,String>();//所有词
			
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
				String name = it.next();//对于文件里的每一个词，进行第二次分析
				
				HashMap<String,String> rmap = new HashMap<String,String>();//结果map
				
				//从左向右最大匹配
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
					System.out.print(">>>"+name+"  分词结果：");
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
	 * 返回IKAnalyzer分词结果
	 * @param name
	 * @return
	 */
	public static ArrayList<String> ikSplit(String name){
		if(Tools.isNull(name))return null;
		
		ArrayList<String> list = new ArrayList<String>();
		HashMap<String,String> map = new HashMap<String,String>();//map为了去重
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
		
		if(list.size()<=1)return list;//如果只有一个词，分得没问题，不用优化
		
		//然后优化一下分词结果，从左到右匹配，去掉一些不人性化的结果。
		//如“九牧王牛仔裤”分词结果是“九牧王牛仔裤   九牧王   九牧   九  牛仔   仔裤”，
		//但其实我只需要“九牧王   牛仔裤”（因为“牛仔”是个词，“牛仔裤”当两个词）
		ArrayList<String> rlist = new ArrayList<String>();
		
		for(int i=0;i<list.size();i++){
			String s1 = list.get(i);
			map.put(s1, "");
		}
		
		//for(String s:list)System.out.println("map===="+s);
		
		HashMap<String,String> rmap = new HashMap<String,String>();//结果map
 		
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
	 * 生成淘宝关键词文件，去重、排序
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
	 * 测试匹配速度
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
	 * 找出d1商品中搜索词和搜索量，这个方法要运行好几个小时
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
