package com.d1.util;

public class LPStringUtils {
	public static int StrinStr(String bigstr,String smstr){
		return StrinStr(bigstr,smstr,",");
	}

	private static int StrinStr(String bigstr, String smstr, String skipstr) {
		String tempskipstr[]=bigstr.split(skipstr);
		int returnint=-1;
		for (int j=0;j<tempskipstr.length;j++){
			if (tempskipstr[j].compareTo(smstr)==0)returnint=j;
		}
		return returnint;
	}
	
	public static String StrOrdStr(String bigstr,String smstr,String skipstr){
		String returnstr = "";
		String tempskipstr[] = bigstr.split(skipstr);
		for (int j = 0; j < tempskipstr.length; j++) {
			if (tempskipstr[j].length() > 0) {
				if (tempskipstr[j].compareTo(smstr) == 0)
					;
				else
					returnstr = returnstr + skipstr + tempskipstr[j];
			}
		}
		if (returnstr.length() > 0) {
			returnstr = smstr + returnstr;
		} else {
			returnstr = smstr;
		}
		return returnstr;
	}
	
	public static String StrReservations(String resstr,String skipstr,int resint){
		String returnstr="";
		String tempskipstr[]=resstr.split(skipstr);
		for (int j=0;j<tempskipstr.length;j++){
			returnstr=returnstr+skipstr+tempskipstr[j];
			if (j>resint)break;
		}
		return returnstr;
	}
	
	public static String Strnotnull(String instr){
		if (instr==null)return "";
		else return instr;
	}
	
	public static long Str2long(String instr){
		long retlong= 0;
		try {
			retlong=Long.parseLong(instr);
			return retlong;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return 0;
		}
		
	}
	public static int Str2int(String instr){
		int retlong= 0;
		try {
			retlong=Integer.parseInt(instr);
			return retlong;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return 0;
		}
		
	}
	
	public static float Str2float(String inset){
		float retfloat= 0;
		try {
			retfloat=Float.parseFloat(inset);
			return retfloat;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return 0;
		}
	}
	
	public static double Str2double(String inset){
		double retdouble=0;
		try {
			retdouble=Double.parseDouble(inset);
			return retdouble;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return 0;
		}
		
	}
	
	public static String GetRedstr(int getlen){
		char redemchar[]={'1','2','3','4','5','6','7','8','9','0','t','h','e','q','u','i','c','k','b','r','o','w','n','f','o','x','j','u','m','p','s','o','v','e','r','a','l','a','z','y','d','o','g','T','H','E','Q','U','I','C','K','B','R','O','W','N','F','O','X','J','U','M','P','S','O','V','E','R','A','L','A','Z','Y','D','O','G'};
		java.util.Random r=new java.util.Random(); 
		String rendstr="";
		for (int i=0;i<getlen;i++){
			rendstr+=redemchar[r.nextInt(redemchar.length)]+"";
		}
		return rendstr;
	}
	
}
