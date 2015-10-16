package com.d1.comp;


	public   class TenpayClient implements Comparable {   
	    String id;   
	    public TenpayClient(String id){   
	        this.id=id;   
	    }   
	    public int compareTo(Object arg0) {   
	    	TenpayClient c=(TenpayClient) arg0;   
	        String s2 = c.id.toLowerCase();        
	        String s1 = this.id.toLowerCase();  
	        if (s1.charAt(0) > s2.charAt(0)||"".equals(s2.charAt(0))) {    
	            return 1;   
	        } else if (s1.charAt(0) < s2.charAt(0)||"".equals(s1.charAt(0))) {        
	            return -1;   
	        } else {        
	            if(s1.length()==s2.length())        
	                return s1.compareTo(s2);        
	            else if(s1.length()>s2.length())        
	                return s1.compareTo(s2);        
	            return 0;   
	        }        
	    }   
	}

