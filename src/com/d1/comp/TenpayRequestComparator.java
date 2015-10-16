package com.d1.comp;

import java.util.Comparator;
	
	public  class TenpayRequestComparator implements Comparator{      
		  public int compare(Object computer1, Object computer2) { 
			  
		        String s1 = ((String) computer1).toLowerCase();      
		        String s2 = ((String) computer2).toLowerCase();  
		        
		        s1=s1.substring(0,s1.indexOf("="));
		        s2=s2.substring(0,s2.indexOf("="));
		        if (s1.charAt(0) > s2.charAt(0)||"".equals(s2.charAt(0))) {      
		            return 1;      
		        } else if (s1.charAt(0) < s2.charAt(0)||"".equals(s1.charAt(0))) {      
		            return -1;      
		        } else {      
		            if(s1.length()==s2.length()){      
		            	 //System.out.println( s1+"---"+s2+"----"+s1.compareTo(s2));
		                return s1.compareTo(s2);    
		            }
		            else if(s1.length()>s2.length()){   
		            	return s1.compareTo(s2); 
		            }     
		            return 0;      
		        }      
		              
		 }      
		}

