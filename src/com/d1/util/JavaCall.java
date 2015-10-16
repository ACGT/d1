package com.d1.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

public class JavaCall
{
public static void main(String[] args)throws Exception
{
	BufferedReader br = new BufferedReader(new FileReader(new File("d://1.txt")));
	String content = "";
	String line = null ;
	while((line=br.readLine())!=null){
		content+=line+System.getProperty("line.separator");
	}
	
	StringBuffer sb = new StringBuffer();
	//System.out.println(content);
	boolean inhref = false ;
	for(int i=0;i<content.length()-1;i++){
		if((content.charAt(i)+""+content.charAt(i+1)).equals("<a"))inhref=true ;
		if(content.charAt(i)=='>')inhref=false ;
		if((""+content.charAt(i)).matches("[^\\x00-\\xff]+")){//空格和中文要编码
			if(inhref)
			sb.append(java.net.URLEncoder.encode(content.charAt(i)+"","utf-8"));
			else
				sb.append(content.charAt(i));
		}else{
			sb.append(content.charAt(i));
		}
	}
	
	System.out.println(sb.toString());
}
}