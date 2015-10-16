package com.d1.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.d1.Const;

/**
 * 搜索IP地址的工具,使用纯真IP数据库，记得更新一下，IP数据库是事先排好叙的！！
 * ip.txt是原来的数据，ip2.txt是把ip填完0之后的数据，ip_ok.txt是是排好序的数据！！！
 * @author kk
 */
public class IPAreaManager {
	private static IPAreaManager me = null ;
	
	public static IPAreaManager getInstance(){
		if (me == null) {
			synchronized (IPAreaManager.class) {
				if (me == null) {
					me = new IPAreaManager();
				}
			}
		}
		return me;
	}
	
	/**
	 * 存放所有ip数据的list,大概有41万条左右
	 */
	private static ArrayList<String> IP_LIST = new ArrayList<String>();
	
	/**
	 * 所有省份
	 */
	private static String[] PROVINCES = new String[]{"北京",
		"天津",
		"河北",
		"山西",
		"内蒙古",
		"辽宁",
		"吉林",
		"黑龙江",
		"上海",
		"江苏",
		"浙江",
		"安徽",
		"福建",
		"江西",
		"山东",
		"河南",
		"湖北",
		"湖南",
		"广东",
		"广西",
		"海南",
		"重庆",
		"四川",
		"贵州",
		"云南",
		"西藏",
		"陕西",
		"甘肃",
		"青海",
		"宁夏",
		"新疆",
		"台湾",
		"香港",
		"澳门"};
	
	/**
	 * 初始化IP数据
	 */
	private IPAreaManager()
	{
		/*try
		{
			System.out.println("初始化IP数据....开始");
			long st = System.currentTimeMillis();
			BufferedReader br = new BufferedReader(new FileReader(new File(Const.PROJECT_PATH+"conf/ip_ok.txt")));
			String line = null ;
			
			while((line = br.readLine())!=null)
			{
				IP_LIST.add(line);
			}
			br.close();
			long end = System.currentTimeMillis();
			System.out.println("初始化IP数据完成....费时==="+(end-st)+"   IP总记录数="+IP_LIST.size());
		}
		catch(IOException ex)
		{
			ex.printStackTrace();
		}*/
	}
	
	public static void main(String[] args)throws Exception
	{
		//fillIpText();
		//sortIpText();
		
		System.out.println(IPAreaManager.getInstance().findIpArea("61.153.154.42"));
		System.out.println(IPAreaManager.getInstance().findIpArea2("61.153.154.42"));
		System.out.println(IPAreaManager.getInstance().findIpArea3("61.153.154.42"));
		//System.out.println(IPAreaManager.getInstance().findIpArea2("059.108.111.000"));
		//System.out.println(IPAreaManager.getInstance().findIpArea3("059.108.111.000"));
		
	}
	
	/**
	 * 把13.123.2.234变成013.123.002.234，以便进行比较
	 * @param ip
	 * @return
	 */
	public String fillIP(String ip)
	{
		if(ip==null||ip.length()==0)return null;
		
		Pattern pattern = Pattern.compile("([0-9]+)\\.([0-9]+)\\.([0-9]+)\\.([0-9]+)");
		Matcher matcher = pattern.matcher(ip);
		if(matcher.find())
        {
			int ipdata1 = Integer.parseInt(matcher.group(1));
			int ipdata2 = Integer.parseInt(matcher.group(2));
			int ipdata3 = Integer.parseInt(matcher.group(3));
			int ipdata4 = Integer.parseInt(matcher.group(4));
			
			String resIP = "";
			if(ipdata1<10)resIP+="00"+ipdata1;
			else if(ipdata1<100)resIP+="0"+ipdata1;
			else resIP+=ipdata1;
			
			resIP+=".";
			
			if(ipdata2<10)resIP+="00"+ipdata2;
			else if(ipdata2<100)resIP+="0"+ipdata2;
			else resIP+=ipdata2;
			
			resIP+=".";
			
			if(ipdata3<10)resIP+="00"+ipdata3;
			else if(ipdata3<100)resIP+="0"+ipdata3;
			else resIP+=ipdata3;
			
			resIP+=".";
			
			if(ipdata4<10)resIP+="00"+ipdata4;
			else if(ipdata4<100)resIP+="0"+ipdata4;
			else resIP+=ipdata4;
			
			return resIP;
        }
		return null;
	}
	
	/**
	 * 查找IP的对应的地址，利用二分法查找，比较快。
	 * @param ip 要查找的ip
	 * @return 返回的地址，如“北京市朝阳区 飞龙网吧”
	 * @throws Exception
	 */
	public String findIpArea(String ip)
	{
		ip = fillIP(ip);
		if(ip==null)return null;
		
		//二分法搜索
		int low = 0;
		int high = IP_LIST.size()-1;
		int mid = (low + high) >>> 1;

		while (low <= high) 
		{
		    mid = (low + high) >>> 1;
		    String s = IP_LIST.get(mid);
		    String ip1 = s.substring(0,15);//起始IP 15刚好是IP的长度
		    String ip2 = s.substring(16,16+15);//截至IP 文本每一行的第二个IP
		    
		    int cmp1 = ip.compareTo(ip1);
		    int cmp2 = ip.compareTo(ip2);
		    
		    if (cmp1>0&&cmp2>0)
		    	low = mid + 1;
		    else if (cmp1<0&&cmp2<0)
		    	high = mid - 1;
		    else if(cmp1<0&&cmp2>0) //IP数据库有错，ip1应该小于ip2才对
		    	return null;
		    else
				return IP_LIST.get(mid).substring(32); // 找到了，哈哈 32是两个IP之后的地址数据
		}
		return null;
	}
	
	/**
	 * 找到ip对应的省/直辖市，返回结果是“北京”而不是“北京市”，是“湖南”而不是“湖南省”
	 * @param ip IP地址
	 * @return
	 */
	public String findIpArea2(String ip)
	{
		String area = findIpArea(ip);
		if(area==null)return null;
		for(int i=0;i<PROVINCES.length;i++)
		{
			if(area.trim().startsWith(PROVINCES[i]))
			{
				return PROVINCES[i];
			}
		}
		return null;
	}
	
	/**
	 * 返回IP对应的城市或者地区，结果是“朝阳”而不是“朝阳区”，是“大庆”而不是“大庆市”。
	 * @param ip the IP
	 * @return
	 */
	public String findIpArea3(String ip)
	{
		String area = findIpArea(ip);
		if(area==null)return null;
		area = area.trim();
		
		for(int i=0;i<PROVINCES.length;i++)
		{
			if(area.startsWith(PROVINCES[i]))
			{
				String s = area.substring(PROVINCES[i].length());
				if(s.startsWith("市")||s.startsWith("省"))
				{
					s = s.substring(1);
				}
				
				if(s.indexOf(" ")>-1)
				{
					s = s.substring(0,s.indexOf(" "));
				}
				
				if(s.indexOf("区")>-1)
				{
					return s.substring(0,s.indexOf("区"));
				}
				else if(s.indexOf("市")>-1)
				{
					return s.substring(0,s.indexOf("市"));
				}
			}
		}
		return null;
	}
	
	/**
	 * 把整理好的ip数据排一下序，重新写到一个文件里，读取ip2.txt,写到ip_ok.txt里
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	private static void sortIpText()throws Exception
	{
		ArrayList<String> list = new ArrayList<String>();
		BufferedReader br = new BufferedReader(new FileReader(new File("d:/ip2.txt")));
		String line = null ;
		
		while((line = br.readLine())!=null)
		{
			list.add(line);
		}
		br.close();
		
		Collections.sort(list);
		
		StringBuffer sb = new StringBuffer();
		for(int i=0;i<list.size();i++)
		{
			sb.append(list.get(i)+System.getProperty("line.separator"));
		}
		
		FileWriter fw = new FileWriter(new File("d:/ip_ok.txt"),true);
		fw.write(sb.toString());
		fw.flush();
		fw.close();
	}
	
	/**
	 * 把ip数据文件整理一下格式，把13.123.2.234变成013.123.002.234便于排序！！！把ip.txt写成ip2.txt
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	private static void fillIpText()throws Exception
	{
		BufferedReader br = new BufferedReader(new FileReader(new File("d:/ip.txt")));
		String line = null ;
		int count=0;
		StringBuffer sb = new StringBuffer();
		
		while((line = br.readLine())!=null)
		{
			count++;
			
			Pattern pattern = Pattern.compile("([0-9]+)\\.([0-9]+)\\.([0-9]+)\\.([0-9]+)\\s+([0-9]+)\\.([0-9]+)\\.([0-9]+)\\.([0-9]+)\\s+(.*)");
			Matcher matcher = pattern.matcher(line);
			
			if(matcher.find())
            {
				int ipdata1 = Integer.parseInt(matcher.group(1));
				int ipdata2 = Integer.parseInt(matcher.group(2));
				int ipdata3 = Integer.parseInt(matcher.group(3));
				int ipdata4 = Integer.parseInt(matcher.group(4));
				int ipdata5 = Integer.parseInt(matcher.group(5));
				int ipdata6 = Integer.parseInt(matcher.group(6));
				int ipdata7 = Integer.parseInt(matcher.group(7));
				int ipdata8 = Integer.parseInt(matcher.group(8));
				
				String ll = "";
				if(ipdata1<10)ll+="00"+ipdata1;
				else if(ipdata1<100)ll+="0"+ipdata1;
				else ll+=ipdata1;
				
				ll+=".";
				
				if(ipdata2<10)ll+="00"+ipdata2;
				else if(ipdata2<100)ll+="0"+ipdata2;
				else ll+=ipdata2;
				
				ll+=".";
				
				if(ipdata3<10)ll+="00"+ipdata3;
				else if(ipdata3<100)ll+="0"+ipdata3;
				else ll+=ipdata3;
				
				ll+=".";
				
				if(ipdata4<10)ll+="00"+ipdata4;
				else if(ipdata4<100)ll+="0"+ipdata4;
				else ll+=ipdata4;
				
				ll+=" ";
				
				if(ipdata5<10)ll+="00"+ipdata5;
				else if(ipdata5<100)ll+="0"+ipdata5;
				else ll+=ipdata5;
				
				ll+=".";
				
				if(ipdata6<10)ll+="00"+ipdata6;
				else if(ipdata6<100)ll+="0"+ipdata6;
				else ll+=ipdata6;
				
				ll+=".";
				
				if(ipdata7<10)ll+="00"+ipdata7;
				else if(ipdata7<100)ll+="0"+ipdata7;
				else ll+=ipdata7;
				
				ll+=".";
				
				if(ipdata8<10)ll+="00"+ipdata8;
				else if(ipdata8<100)ll+="0"+ipdata8;
				else ll+=ipdata8;
				
				ll+=" "+matcher.group(9)+System.getProperty("line.separator");
				
				sb.append(ll);
                 
            }
			
			if(count==2000)
			{
				FileWriter fw = new FileWriter(new File("d:/ip2.txt"),true);
				fw.write(sb.toString());
				fw.flush();
				fw.close();
				sb=new StringBuffer();
				count=0;
				//break;
				System.out.println("write...done");
			}
		}
		
		br.close();
		
		FileWriter fw = new FileWriter(new File("d:/ip2.txt"),true);
		fw.write(sb.toString());
		fw.flush();
		fw.close();
	}
}

