package com.d1.test;


import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.UserQQ;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

 




public class T {
	private static String setrim(String s) {
	    int i = s.length();// 字符串最后一个字符的位置
	    int j = 0;// 字符串第一个字符
	    int k = 0;// 中间变量
	    char[] arrayOfChar = s.toCharArray();// 将字符串转换成字符数组
	    while ((j < i) && (arrayOfChar[(k + j)] <= ' '))
	     ++j;// 确定字符串前面的空格数
	    while ((j < i) && (arrayOfChar[(k + i - 1)] <= ' '))
	     --i;// 确定字符串后面的空格数
	    return (((j > 0) || (i < s.length())) ? s.substring(j, i) : s);// 返回去除空格后的字符串
	  }

		public static String gen(int length) {	
			char[] ss = new char[length];		
			int[] flag = {0,0,0}; //A-Z, a-z, 0-9	
			int i=0;		
			while(flag[0]==0 || flag[1]==0 || flag[2]==0 || i<length) {	
				i = i%length;		  
				int f = (int) (Math.random()*3%3);		
				if(f==0) ss[i] = (char) ('A'+Math.random()*26);	
				else if(f==1) ss[i] = (char) ('a'+Math.random()*26);	
				else ss[i] = (char) ('0'+Math.random()*10);    	
				flag[f]=1;		 
				i++;		
				}	
			return new String(ss);	
			}
		public static ArrayList<UserQQ> getLktQQID(String strAcct){
			ArrayList<UserQQ> list=new ArrayList<UserQQ>();
			System.out.println(strAcct);
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("mbrlktqq_acct", strAcct));
			List<BaseEntity> b_list = Tools.getManager(UserQQ.class).getList(clist, null, 0,10);
			if(b_list==null||b_list.size()==0)return null;
			
				for(BaseEntity be:b_list){
					list.add((UserQQ)be);
				}
			
			return list;
		}
	public static void main(String[] args)throws Exception{
	
		//String ddd="【Sheromo 诗若漫】加厚珍珠绒保暖型显瘦打底裤（打底裤的外形,三层保暖的呵护）售罄预售，12.15左右到";
		//System.out.print(ddd.getBytes().length);
		//String ssss=" sss 1 33 ";
		//System.out.println(ssss);
		
		//System.out.println(setrim(ssss));
		FileWriter fw = new FileWriter(new File("/testerror.txt"),true);
		for(long i=1;i<100000;i++){
		//System.out.println(gen(20));
		fw.write(" test"+gen(20)+"--------"+i+System.getProperty("line.separator"));
		}
		fw.flush();
		fw.close();
		
	
		
		//Oauth oauth = new Oauth();
		//session.setAttribute("accessToken",oauth.access_token);
			//System.out.println(oauth.authorize("code"));

		//System.out.print("ddddddd");
		/*String key2="20120315144350";
		SimpleDateFormat   df2=new   SimpleDateFormat("yyyyMMddHHmmss");  
		java.util.Date   nowszf=new   java.util.Date();   
		java.util.Date   dates=df2.parse(key2);
		System.out.print( nowszf.getTime()/60000-dates.getTime()/60000);
		
		//String strcode="http://www.d1.com.cn/html/gdsmstxsylist.asp?code=7457";
		//System.out.print(URLEncoder.encode(URLEncoder.encode(strcode)));
			
			
		/*SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date yesterday = new java.util.Date(System.currentTimeMillis()-Tools.DAY_MILLIS);
		System.out.println(sdf.format(yesterday));*/
		
		//String gdsid = "2012-01-30 14:55:09|59.108.32.178|http://www.178mp.com/|abcoTQMGnHwkGcodvzTut|no|no|no|no|/index.jsp|Mozilla/4.0(compatible;MSIE6.0;WindowsNT5.1;SV1;Maxthon;.NETCLR1.1.4322;.NETCLR2.0.50727)|http://www.178mp.com/|werwer";
		//String[] ls = gdsid.split("\\|");
		//System.out.println(ls.length);
		
		//BuyLimit bld = (BuyLimit)Tools.getManager(BuyLimit.class).findByProperty("gdsbuyonemst_gdsid", "01205164");
		//System.out.println(bld.getGdsbuyonemst_createtime());
		/*BufferedReader br = new BufferedReader(new FileReader(new File("d://11.xml")));
		String line = null ;
		StringBuffer sb = new StringBuffer();
		while((line=br.readLine())!=null){
			sb.append(line).append(System.getProperty("line.separator"));
		}
		br.close();
		
		System.out.println(getUrlContentViaPost("https://wanlitong-staging.pingan.com.cn/lpmsweb/checkPayment.do",sb.toString()));
	*/
		/*String[] x ={"美","微","蓓","玛","艾","莎","娜","姿","雅","诗","迪","碧","静","柔","丽","达","丹","芬","逸","露"};
		
		for(int i=0;i<x.length;i++){
			for(int j=0;j<x.length;j++){
				for(int k=0;k<x.length;k++){
					System.out.println(x[i]+x[j]+x[k]);
				}
			}
		}*/
	}

}
