<%@ page contentType="text/html; charset=UTF-8" import="java.util.*"%><%@include file="/inc/header.jsp"%><%@include file="public.jsp"%><%@include file="/admin/chkrgt.jsp"%><%!
public static String getRandomString(int length){  
    String str="abcdefghijklmnopqrstuvwxyz0123456789";  
    Random random = new Random();  
    StringBuffer sb = new StringBuffer();  
      
    for(int i = 0 ; i < length; ++i){  
        int number = random.nextInt(36);//[0,62)  
          
        sb.append(str.charAt(number));  
    }  
    return sb.toString();  
}  

%><%
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "mkt_tktcrt");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

if("post".equals(request.getMethod().toLowerCase())){
	String title = request.getParameter("txttitle");
	String txtvalue = request.getParameter("txtvalue");
	String txtgdsvalue = request.getParameter("txtgdsvalue");
	String txtrackcode = request.getParameter("txtrackcode");
	String txttype=request.getParameter("txttype");
	String txtnum=request.getParameter("txtnum");
	//String txtStart=request.getParameter("txtStart");
	String txtEnd=request.getParameter("txtEnd");
	String txtmemo=request.getParameter("txtmemo");
	String txtdiscount=request.getParameter("txtdiscount");
	String txtmaxcount=request.getParameter("txtmaxcount");
	String cb2=request.getParameter("cb2");
	String cb3=request.getParameter("cb3");
	String shopcode=request.getParameter("shopcode");
	String typetkt=request.getParameter("typetkt");
	String tktflag_memo=txtmemo;
	String tktflag_validflag="1";
	if(Tools.isNull(title)){
		Tools.outJs(out, "请输入券头", "back");
		return;
	}
	if(Tools.isNull(txtvalue) ){
		Tools.outJs(out, "请输入优惠券金额", "back");
		return;
	}
	if(Tools.isNull(txtgdsvalue)&& txttype.equals("1")){
		Tools.outJs(out, "请输入商品金额", "back");
		return;
	}
	if(Tools.isNull(txtnum)){
		Tools.outJs(out, "请输入生成张数", "back");
		return;
	}
	//if(Tools.isNull(txtStart)){
	//	Tools.outJs(out, "请输入开始时间", "back");
	//	return;
	//}
	if(Tools.isNull(txtEnd)){
		Tools.outJs(out, "请输入结束时间", "back");
		return;
	}
	if("0".equals(txttype) && Tools.isNull(txtdiscount)){
		Tools.outJs(out, "请输入折扣", "back");
		return;
	}
	if(!Tools.isNull(cb3)){
		tktflag_memo+="不返利";
		tktflag_validflag="1";
	}else if(!Tools.isNull(cb2)){
		tktflag_memo+="新会员";
		tktflag_validflag="2";
	}else if(!Tools.isNull(txtmaxcount)){
		tktflag_memo+="每人限用"+txtmaxcount+"张";
		tktflag_validflag="3";
	}
	if(txttype.equals("1")){
		txtdiscount="1";
	}else{
		txtgdsvalue="0";
	}
	if(!Tools.isNull(typetkt)){
	long checkcode=Math.round(Math.random()*90+10);//2位随机码
	try{
	TicketGroup tg=new TicketGroup();
	tg.setTktgroup_createdate(new Date());
	tg.setTktgroup_checkcode(checkcode);
	tg.setTktgroup_flag(new Long(txttype));
	tg.setTktgroup_value(new Long(txtvalue));
	tg.setTktgroup_gdsvalue(new Long(txtgdsvalue));
	tg.setTktgroup_memo(txtmemo);
	tg.setTktgroup_num(new Long(txtnum));
	tg.setTktgroup_rackcode(txtrackcode);
	tg.setTktgroup_title(title.trim());
	tg.setTktgroup_type("004003");
	tg.setTktgroup_validatee(sdf.parse(txtEnd));
	tg.setTktgroup_validates(new Date());
	tg.setTktgroup_discount(Tools.parseFloat(txtdiscount));
	tg.setTktgroup_sprckcodestr("");
	tg.setTktgroup_shopcode(shopcode);
	tg.setTktgroup_payid(new Long(-1));
	tg=(TicketGroup)Tools.getManager(TicketGroup.class).create(tg);

	if(tg!=null && !Tools.isNull(tg.getId())){
		if(!Tools.isNull(txtmaxcount) || !Tools.isNull(cb2) || !Tools.isNull(cb3)){
			TicketFlag tf=new TicketFlag();
			tf.setTktflag_cardnot(title);
			tf.setTktflag_createtime(new Date());
			tf.setTktflag_memo(tktflag_memo);
			tf.setTktflag_validflag(new Long(tktflag_validflag));
			if(!Tools.isNull(txtmaxcount)){
				tf.setTktflag_maxcount(new Long(txtmaxcount));
			}
			tf=(TicketFlag)Tools.getManager(TicketFlag.class).create(tf);
			
		}
		Random rndcard = new Random();
		String path = Const.PROJECT_PATH + "createcard/"+getUploadFilePath();
		String fileName = Tools.getDBDate()+".txt";//文件名
		  File file = new File(path);
		  //判断文件夹是否存在,如果不存在则创建文件夹
		  if (!file.exists()) {
			 file.mkdirs();	
		  }
		 
		
		 File file2 = new File(path+fileName);
		if(!file2.exists()){
			file2.createNewFile();//创建文件  
			//System.out.println("testXXXXXXXXXXXXXXXXXXXXXXXXX");
		}
		FileWriter fw = new FileWriter(file2,true);
		//  BufferedWriter buffer = new BufferedWriter(fw);  
		for(long i=1;i<=new Long(txtnum);i++){
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
				sum=(int)checkcode+sum;
				cardno=cardno+(sum+"").substring((sum+"").length()-2, (sum+"").length());
				//System.out.println("test"+cardno);
		fw.write(title+cardno+" \r\n");
		
		}
		fw.flush();
		fw.close();
		 out.println("<a href=\"/createcard/"+getUploadFilePath()+fileName+"\" target=\"_blank\">券头"+title+"生成成功</a><br/>");
	}else{
		Tools.outJs(out, "生成失败", "back");
		return;
	}
	}catch(Exception ex){
		 ex.printStackTrace();
	}
	}else{
		if(txttype.equals("1")){
		String path = Const.PROJECT_PATH + "createcard/"+getUploadFilePath();
		String fileName = Tools.getDBDate()+".txt";//文件名
		  File file = new File(path);
		  //判断文件夹是否存在,如果不存在则创建文件夹
		  if (!file.exists()) {
			 file.mkdirs();	
		  }
	
		 File file2 = new File(path+fileName);
		if(!file2.exists()){
			file2.createNewFile();//创建文件  
		}
		try{
		FileWriter fw = new FileWriter(file2,true);
		 HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		for(int i=1;i<=Tools.parseInt(txtnum);i++){
		 
			String cardno=getRandomString(10);
    		if(hmap.containsKey(cardno)){
    			for(int j=0;j<50;j++){
    				cardno=getRandomString(10);
    			    if(!hmap.containsKey(cardno))break;
    			}
    		}
    		hmap.put(cardno,i);
    		fw.write(title+cardno+" \r\n");

    		TicketPwd tktpwd=new TicketPwd();
    		tktpwd.setTktpwd_cardno(title+cardno);
    		tktpwd.setTktpwd_brandname("");
    		tktpwd.setTktpwd_value(new Long(txtvalue));
    		tktpwd.setTktpwd_gdsvalue(new Long(txtgdsvalue));
    		tktpwd.setTktpwd_shopcodes(shopcode);
    		tktpwd.setTktpwd_sendcount(new Long(0));
    		tktpwd.setTktpwd_maxcount(new Long(1));
    		tktpwd.setTktpwd_rackcode(txtrackcode);
    		tktpwd.setTktpwd_everymaxcount(new Long(1));
    		tktpwd.setTktpwd_tktstartdate(new Date());
    		tktpwd.setTktpwd_tktenddate(sdf.parse(txtEnd));
    		tktpwd.setTktpwd_enddate(sdf.parse(txtEnd));
    		tktpwd.setTktpwd_createdate(new Date());
    		tktpwd.setTktpwd_memo(txtmemo);
    		tktpwd.setTktpwd_baihuo(new Long(0));
    		tktpwd.setTktpwd_mbrid(new Long(0));
    		tktpwd.setTktpwd_ifvip(new Long(0));
    		tktpwd.setTktpwd_payid(new Long(-1));
    		tktpwd.setTktpwd_pwd("www.d1.com.cn");
    		tktpwd.setTktpwd_sprckcodeStr("");
    		Tools.getManager(TicketPwd.class).create(tktpwd);

		}
		
		fw.flush();
		fw.close();
		if(!Tools.isNull(txtmaxcount) || !Tools.isNull(cb2) || !Tools.isNull(cb3)){
			TicketFlag tf=new TicketFlag();
			tf.setTktflag_cardnot(title);
			tf.setTktflag_createtime(new Date());
			tf.setTktflag_memo(tktflag_memo);
			tf.setTktflag_validflag(new Long(tktflag_validflag));
			if(!Tools.isNull(txtmaxcount)){
				tf.setTktflag_maxcount(new Long(txtmaxcount));
			}
			tf=(TicketFlag)Tools.getManager(TicketFlag.class).create(tf);
			
		}
		
		}catch(Exception ex){
			 ex.printStackTrace();
		}
		 out.println("<a href=\"/createcard/"+getUploadFilePath()+fileName+"\" target=\"_blank\">券头"+title+"生成成功</a><br/>");
		}else{
			Tools.outJs(out, "暂不支持百分比券以直接插入券表形式生成！", "back");
			return;
		}
	}
}
%>
<p><a href="index.jsp" target="_blank">回到券生成页面</a></p>
