<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static ArrayList<Directory> getAllCategory(){
	ArrayList<Directory> list =new ArrayList<Directory>();

	List<BaseEntity> b_list =Tools.getManager(Directory.class).getList(null, null, 0, 6000);
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((Directory)be);
		}
	}
	
	return list;
}
static ArrayList<Directory> getBaseCategory(){
	ArrayList<Directory> list =new ArrayList<Directory>();
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("rakmst_showflag",new Long(1)));
	clist.add(Restrictions.eq("rakmst_parentrackcode","0"));
	List<BaseEntity> b_list =Tools.getManager(Directory.class).getList(null, null, 0, 100);
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((Directory)be);
		}
	}
	
	return list;
}
static ArrayList<Directory> getRckmst(){
	ArrayList<Directory> list2 =new ArrayList<Directory>();
	ArrayList<Directory> list=getBaseCategory();
	if(list!=null ){
	for(Directory dir:list){
		if(dir.getId().trim().equals("012") || dir.getId().trim().equals("014") || dir.getId().trim().equals("015") || dir.getId().startsWith("02") || dir.getId().startsWith("03")){
				list2.add(dir);
			}
		}
	}
	
	return list2;
}
static ArrayList<Directory> getSubRckmst(String pcode){
	ArrayList<Directory> list2 =new ArrayList<Directory>();
	ArrayList<Directory> list=getAllCategory();
	if(list!=null ){
	for(Directory dir:list){
		if(dir.getRakmst_parentrackcode().trim().equals(pcode)){
				list2.add(dir);
			}
		}
	}
	return list2;
}
%><%
String filepath = Const.PROJECT_PATH + "taobao/SellerCats.xml";
File file=new File(filepath);
if (file.exists()) {//判断文件目录的存在

//如果存在，先删除，再创建 
boolean d = file.delete();
     if(d){
    	 file.createNewFile();//创建文件  
     }

}
 else {
  File file2=new File(file.getParent());

    file2.mkdirs();
    if(file.isDirectory()){      

    	 if( file.delete()){
        	 file.createNewFile();//创建文件  
         } 

      }else{      

       file.createNewFile();//创建文件   
      }

}

ArrayList<Directory> list=getRckmst();
String ret="1";
if(list!=null && list.size()>0){
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	  if(file.exists()){//判断文件的存在性        
		        BufferedWriter bWriter = null;   
		        try {     
		            bWriter= new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF-8"));
		            bWriter.write("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
		            bWriter.newLine();
		            bWriter.write("<root>");
		            bWriter.newLine();
		            bWriter.write("<version>1.0</version>");//Feed数据格式的版本号
		            bWriter.newLine();
		            bWriter.write("<modified>");
		            bWriter.write(format.format(new Date()));// Feed数据文件最近修改时间
		            bWriter.write("</modified>");
		            bWriter.newLine();
		            bWriter.write("<seller_id>d1优尚网官网</seller_id>");//给合作商家创建的淘宝会员账号
		            bWriter.newLine();
		            bWriter.write("<seller_cats>");
		            bWriter.newLine();
		            
		            for(Directory r:list){
		            	 bWriter.write("<cat>");
				         bWriter.newLine();
				         bWriter.write("<scid>");
				         bWriter.write(r.getId().trim());
				         bWriter.write("</scid>");
				         bWriter.newLine();
				         bWriter.write("<name>");
				         bWriter.write(r.getRakmst_rackname().trim());
				         bWriter.write("</name>");
				         bWriter.newLine();
				         bWriter.write("<cats>");
				         bWriter.newLine();
		        	ArrayList<Directory> list2=getSubRckmst(r.getId().trim());
		        	if(list2!=null){
		        		for(Directory r2:list2){
		        			bWriter.write("<cat>");
		        			 bWriter.newLine();
		        			bWriter.write("<scid>");
		        			bWriter.write(r2.getId().trim());
		        			bWriter.write("</scid>");
		        			 bWriter.newLine();
		        			bWriter.write("<name>");
		        			bWriter.write(r2.getRakmst_rackname().trim());
		        			bWriter.write("</name>");
		        			 bWriter.newLine();
		        			bWriter.write("</cat>");
		        			 bWriter.newLine();
		        		}
		        		
		        	}
		        	bWriter.write("</cats>");
		        	 bWriter.newLine();
		        	bWriter.write("</cat>");
		        	 bWriter.newLine();
		        	}
		            bWriter.write("</seller_cats>");
		            bWriter.newLine();
		            bWriter.write("</root>");
		       	 
		            bWriter.flush();
		            bWriter.close();  
		            ret="1";
		        } catch (Exception e) {   
		        	ret="-100";
		            e.printStackTrace();   
		        }   
		        finally {   
		            try {   
		           	 bWriter.close();
		            } catch (Exception e) {   
		                e.printStackTrace();   
		            }   
		        }     

		      }
	 // response.sendRedirect("/admin/taobaoxml.jsp?sellcats=1");
}
%>