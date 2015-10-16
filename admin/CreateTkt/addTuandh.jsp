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
	String title = request.getParameter("txttitle2");
	String txtnum=request.getParameter("txtnum2");
	//String txtStart=request.getParameter("txtStart2");
	String txtEnd=request.getParameter("txtEnd2");
	String txtmemo1=request.getParameter("txtmemo1");
	String txtmemo2=request.getParameter("txtmemo2");
	String txtgdsid=request.getParameter("txtgdsid");
	String mid=request.getParameter("mid");
	String shipfee=request.getParameter("shipfee");
	String dhprice=request.getParameter("dhprice");
	String dhmaxcount=request.getParameter("dhmaxcount");
	String typetkt=request.getParameter("typetkt");
	String fee=request.getParameter("fee");
	if(Tools.isNull(shipfee)){
		shipfee="0";
	}
	if(Tools.isNull(title)){
		Tools.outJs(out, "请输入券头", "back");
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
	if(Tools.isNull(mid)){
		Tools.outJs(out, "请选择兑换平台", "back");
		return;
	}
	long checkcode=Math.round(Math.random()*90+10);//2位随机码
	if(!Tools.isNull(typetkt)){
	try{
		TuandhGroup tg=new TuandhGroup();
		tg.setTuandhgroup_checkcode(checkcode);
		tg.setTuandhgroup_createdate(new Date());
		tg.setTuandhgroup_gdsid(txtgdsid);
		tg.setTuandhgroup_memo(txtmemo1);
		tg.setTuandhgroup_memo2(txtmemo2);
		tg.setTuandhgroup_mid(new Long(mid));
		tg.setTuandhgroup_num(new Long(txtnum));
		tg.setTuandhgroup_title(title.trim());
		tg.setTuandhgroup_validatee(sdf.parse(txtEnd));
		tg.setTuandhgroup_dhprice(new Float(dhprice));
		tg.setTuandhgroup_shipfee(new Long(shipfee));
		tg.setTuandhgroup_fee(new Long(fee));
		tg.setTuandhgroup_maxbuycount(new Long(dhmaxcount));
		tg.setTuandhgroup_validates(new Date());
		tg=(TuandhGroup)Tools.getManager(TuandhGroup.class).create(tg);
	if(tg!=null && !Tools.isNull(tg.getId())){
		
		Random rndcard = new Random();
		String path = Const.PROJECT_PATH + "createcard/"+getUploadFilePath();
		  File file = new File(path);
		  //判断文件夹是否存在,如果不存在则创建文件夹
		  if (!file.exists()) {
		   file.mkdirs();
		  }
		String fileName = Tools.getDBDate()+".txt";//文件名
		FileWriter fw = new FileWriter(new File(path+fileName),true);
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
		 out.println("<a href=\"/createcard/"+getUploadFilePath()+fileName+"\" target=\"_blank\">兑换码券头"+title+"生成成功</a><br/>");
	}else{
		Tools.outJs(out, "生成失败", "back");
		return;
	}
	}catch(Exception ex){
		 ex.printStackTrace();
	}
}else{
	
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
		Tuandh tdh=new Tuandh();
		tdh.setTuandh_cardno(title+cardno);
		tdh.setTuandh_dhprice(new Float(dhprice));
		tdh.setTuandh_endtime(sdf.parse(txtEnd));
		tdh.setTuandh_shipfee(new Long(shipfee));
		tdh.setTuandh_fee(new Long(fee));
		tdh.setTuandh_memo(txtmemo2);
		tdh.setTuandh_status(new Long(0));
		tdh.setTuandh_maxbuycount(new Long(dhmaxcount));
		tdh.setTuandh_mid(new Long(mid));
		tdh.setTuandh_gdsid(txtgdsid);
		tdh.setTuandh_title(txtmemo1.trim());
		tdh.setTuandh_createtime(new Date());
		
		Tools.getManager(Tuandh.class).create(tdh);

	}
	
	fw.flush();
	fw.close();
	
	}catch(Exception ex){
		 ex.printStackTrace();
	}
	 out.println("<a href=\"/createcard/"+getUploadFilePath()+fileName+"\" target=\"_blank\">券头"+title+"生成成功</a><br/>");
	 
}
}


%>
<p><a href="index.jsp" target="_blank">回到券生成页面</a></p>