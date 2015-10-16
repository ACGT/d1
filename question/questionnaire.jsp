<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%!
static ArrayList<Variable> getVariable(String name,String value){
	ArrayList<Variable> list=new ArrayList<Variable>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("name",name));
	//listRes.add(Restrictions.eq("value",value));
	
	List<BaseEntity> mxlist= Tools.getManager(Variable.class).getList(listRes, null, 0, 100);
	if(mxlist==null || mxlist.size()==0) return null;
	for(BaseEntity be:mxlist){
		list.add((Variable)be);
	}
	 return list;
}
%>
<%
if(lUser!=null){
	if ("post".equals(request.getMethod().toLowerCase())) {
	if(!Tools.isNull(request.getParameter("hanwser"))){
		String name="QA_"+lUser.getId();
		ArrayList<Variable> list= getVariable(name,"1");
		if(list!=null && list.size()>0){
			out.print("<script>alert('您已参与过该调查，请勿多次参与'); window.location.href='/index.jsp';</script>");
			return;
		}else{
			Variable va=new Variable();
			va.setName("QA_"+lUser.getId());
			va.setValue("1");
			va=(Variable)Tools.getManager(Variable.class).create(va);
			if(va!=null){
				BufferedWriter bWriter=null;
				int isok=1;
				try{
					String filepath = Const.PROJECT_PATH + "question/question.xml";
					File file=new File(filepath);
					if (file.exists()) {//判断文件目录的存在
					  File file2=new File(file.getParent());
					    file2.mkdirs();
					    if(!file.isDirectory()){      	
					       file.createNewFile();//创建文件   
					      }

					}
					 bWriter=new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF-8"));
					
					String q=request.getParameter("hanwser").trim();
					String content="";
					if(!Tools.isNull(request.getParameter("txtcontent"))){
						content=request.getParameter("txtcontent");
					}
					bWriter.write(q);
					bWriter.write(content);
					bWriter.newLine();
					
				} catch (Exception e) {   
		        	isok=0;
		            e.printStackTrace();   
		        }  finally {   
		            try {   
		            	bWriter.flush();
			           	 bWriter.close();
			            } catch (Exception e) {   
			                e.printStackTrace();   
			            }   
			        }  
				if(isok==1){
					response.sendRedirect("questionop.jsp?op=1");
				}
			}
		}
		
	}
	}
}
%>