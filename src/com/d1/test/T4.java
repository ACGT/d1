package com.d1.test;

public class T4 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String s  = "�����г�������¶԰����2��������԰1999��¥2001# 13581907901";
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
	    	//����
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
