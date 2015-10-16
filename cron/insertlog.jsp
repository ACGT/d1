<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%><%@page import="
java.io.*,java.sql.*,java.util.*"%><%!
	private static Object LOCK = new Object();

	public synchronized static void insert(ArrayList<String> list) {
		Connection conn = null ;
		File hibernate_conf_file = new File("/etc/hibernate.properties");
		Properties ps = new Properties();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String days15 = sdf.format(new java.util.Date(System.currentTimeMillis()-7l*Tools.DAY_MILLIS));
		
		
		try{
			InputStream in = new FileInputStream(hibernate_conf_file);
			ps.load(in); 
			in.close();
			
			Class.forName(ps.getProperty("hibernate.connection.driver_class"));
			conn = DriverManager.getConnection(ps.getProperty("hibernate.connection.url"),
					ps.getProperty("hibernate.connection.username"),
					ps.getProperty("hibernate.connection.password"));
			
			conn.setAutoCommit(false);
			
			Statement st = conn.createStatement();
			st.executeUpdate("delete from hitlog where logdate<'"+days15+"'");
			conn.commit();
			
			conn.setAutoCommit(false);
			
			if(list!=null&&list.size()>0){
				
				String insertSql = "insert into hitlog(logdate,ip,first_referer_url,session_id,login_user_id,last_user_order_date,subad,user_create_date,request_uri,user_agent,refer_url,request_parameters,rackcode,brandname) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement statement = conn.prepareStatement(insertSql);
				for(String line:list){
					String[] ls = line.split("\\|");
					String rackcode="no",brandname="no";
					if("/product.jsp".equals(ls[8])){
						if(ls[11]!=null){
							String gdsid = ls[11].replaceAll("[^0-9]", "");//product id
							Product product = ProductHelper.getById(gdsid);
							if(product!=null){
								rackcode = product.getGdsmst_rackcode();
								brandname=product.getGdsmst_brandname();
							}
						}
					}
					if(ls!=null&&ls.length>=12){
						statement.setString(1, ls[0]);
						statement.setString(2, ls[1]);
						statement.setString(3, ls[2]);
						statement.setString(4, ls[3]);
						statement.setString(5, ls[4]);
						statement.setString(6, ls[5]);
						statement.setString(7, ls[6]);
						statement.setString(8, ls[7]);
						statement.setString(9, ls[8]);
						statement.setString(10, ls[9]);
						statement.setString(11, ls[10]);
						statement.setString(12, ls[11]);
						statement.setString(13, rackcode);
						statement.setString(14, brandname);
						statement.addBatch();
					}else if(ls!=null&&ls.length>=11){
						statement.setString(1, ls[0]);
						statement.setString(2, ls[1]);
						statement.setString(3, ls[2]);
						statement.setString(4, ls[3]);
						statement.setString(5, ls[4]);
						statement.setString(6, ls[5]);
						statement.setString(7, ls[6]);
						statement.setString(8, ls[7]);
						statement.setString(9, ls[8]);
						statement.setString(10, ls[9]);
						statement.setString(11, ls[10]);
						statement.setString(12, "no");
						statement.setString(13, rackcode);
						statement.setString(14, brandname);
						statement.addBatch();
					}
				}
				
				statement.executeBatch();
				conn.commit();
			}
			
			
		}catch(Exception ex){
			ex.printStackTrace();
			try{
				if(conn!=null)conn.rollback();
			}catch(Exception ex1){
				ex1.printStackTrace();
			}
		}finally{
			try{
				if(conn!=null)conn.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
		
	}
%><%
if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){
	synchronized(LOCK){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date yesterday = new java.util.Date(System.currentTimeMillis()-Tools.DAY_MILLIS);
		File logFile = new File("/opt/d1web/log/hit.log."+sdf.format(yesterday));
		
		int count = 0 ;
		System.out.println("===============insert log...=================");
		BufferedReader br = new BufferedReader(new FileReader(logFile));
		String line = null ;
		ArrayList<String> list = new ArrayList<String>();
		while((line=br.readLine())!=null){
			list.add(line);
			count++;
			if(count%500==0){
				insert(list);
				list.clear();
				list = new ArrayList<String>(); 
				//System.out.println("===============insert log...================="+count);
			}
		}
		
		br.close();
		System.out.println("===============insert log...lines="+count+"=================");
		insert(list);
	}
}
%>