package com.d1.test;

public class T4 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String s  = "北京市朝阳区甘露园中立2号青年汇佳园1999号楼2001# 13581907901";
		System.out.println(stringToAscii(s));
		System.out.println(asciiToString(stringToAscii(s)));
	}

	public static String stringToAscii(String value)  
	{  
		if(value==null)return "";
	    StringBuffer sbu = new StringBuffer();  
	    char[] chars = value.toCharArray();   
	    for (int i = 1; i <=chars.length; i++) {  
	    	int c = (int)chars[i-1];
	    	//加密
	    	c+=3*i*i+17*i+17395;
	    	
	    	if(i>=2){
	    		c+=(int)chars[i-2];
	    		c+=19*i;
	    	}
	    	
	        if(i != chars.length)  
	        {  
	            sbu.append(c).append(",");  
	        }  
	        else {  
	            sbu.append(c);  
	        }  
	    }  
	    return sbu.toString();  
	}  
	
	public static String asciiToString(String value)  
	{  
		if(value==null)return "";
	    StringBuffer sbu = new StringBuffer();  
	    String[] chars = value.split(",");  
	    for (int i = 1; i <=chars.length; i++) {  
	    	String r = sbu.toString();
	    	int ix = Integer.parseInt(chars[i-1]);
	    	if(i>=2){
	    		ix-=19*i;
	    		ix-=(int)(r.charAt(i-2));
	    	}
	    	ix-=3*i*i+17*i+17395;
	    	
	        sbu.append((char)ix);  
	    }  
	    return sbu.toString();  
	}  
}
