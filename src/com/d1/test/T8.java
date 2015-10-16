package com.d1.test;

import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.TenpayNumFee;
import com.d1.bean.TicketGroup;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.StringUtils;
import com.d1.util.Tools;

public class T8 {
	public static void main(String[] args){

	/*	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.in("gdscom_gdsid", "01416604,01408466"));
	
		List<BaseEntity> list  = Tools.getManager(Comment.class).getList(listRes, null, 0, 1000);
		System.out.println(list.size());*/
		/*String name="01700100";
		String namevalue="test";
		String name2="01700102";
		String namevalue2="test2";
		String name3="01700104";
		Map<String,Object> map = new HashMap<String,Object>();
		map.put(name,namevalue);
		map.put(name2,namevalue2);
		System.out.print(JSONObject.fromObject(map));
		String jsonmap=JSONObject.fromObject(map).toString();
		JSONObject  jsonob = JSONObject.fromObject(jsonmap); 
    	
	   	 String getname = jsonob.getString(name);  
	    System.out.println("name:"+getname);
	    Map<String, Object> map2 = (Map)jsonob;
	    map2.get(name3);
	    System.out.println(map2.get(name));
	    map2.put(name,namevalue2);
	    System.out.println(map2.get(name));
	   */
		Random rndcard = new Random();
         try{
		FileWriter fw = new FileWriter(new File("/testerror.txt"),true);
		for(long i=1;i<1000000;i++){
		String cardno=rndcard.nextInt(99999999)+"";
		String str0="";
		if (cardno.length()<8)
		{
			for(int j=1;j<=8-cardno.length();j++){
				str0+="0";
			}
		}
		//System.out.println(str0+"-----"+cardno);
		cardno=str0+cardno;
		      		int sum=0;
				for(int k=0;k<8;k++){//前8位加起来
						sum+=new Integer(cardno.charAt(k)+"").intValue();
					}
				sum=65+sum;
				cardno=cardno+(sum+"").substring((sum+"").length()-2, (sum+"").length());
				//System.out.println("test"+cardno);
		fw.write(" test"+cardno+"--------"+sum+System.getProperty("line.separator"));
		}
		fw.flush();
		fw.close();
		
         }
         catch(Exception ex){
        	 ex.printStackTrace();
         }
	    

	}
}
