<%@page import="java.math.BigInteger"%>
<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%><%!

////删除缓存的jsp，每分钟执行一次
/**
 * 根据数据库中记录的值恢复bean，用于删除列表缓存
 * @param bean
 * @param before_value
 */
private void recoverBean(BaseEntity bean,String before_value){
	try{
		String[] fs = before_value.split("!@#");//!@#是触发器中定义的字段分隔符
		Class<?>[] args = new Class<?>[]{};
		if(fs!=null&&fs.length>0){
			for(int a=0;a<fs.length;a++){
				String s10 = fs[a];//如userId=123456
				if(s10.indexOf("=")>-1){
					String fieldName = s10.substring(0,s10.indexOf("="));//如userId
					String fieldValue = s10.substring(s10.indexOf("=")+1);//如123456
					
					String setMethodName="set"+Character.toUpperCase(fieldName.charAt(0))+fieldName.substring(1);//如setUserId
					String getMethodName="get"+Character.toUpperCase(fieldName.charAt(0))+fieldName.substring(1);//如getUserId
					
					Class<?> returnType = bean.getClass().getMethod(getMethodName, args).getReturnType();//得到返回类型，如Long,String
					
					if(returnType.getName().indexOf("Long")>-1){
						if(StringUtils.isDigits(fieldValue)){
							Long v123 = new Long(fieldValue);
							bean.getClass().getMethod(setMethodName, returnType).invoke(bean, v123);//调用setUserId(123456)
						}
					}else if(returnType.getName().indexOf("Integer")>-1){
						if(StringUtils.isDigits(fieldValue)){
							Integer v123 = new Integer(fieldValue);
							bean.getClass().getMethod(setMethodName, returnType).invoke(bean, v123);
						}
					}else if(returnType.getName().indexOf("Float")>-1){
						if(!Tools.isNull(fieldValue)){
							Float v123 = new Float(fieldValue);
							bean.getClass().getMethod(setMethodName, returnType).invoke(bean, v123);
						}
					}else if(returnType.getName().indexOf("Double")>-1){
						if(!Tools.isNull(fieldValue)){
							Double v123 = new Double(fieldValue);
							bean.getClass().getMethod(setMethodName, returnType).invoke(bean, v123);
						}
					}else if(returnType.getName().indexOf("String")>-1){
						if(!Tools.isNull(fieldValue)){
							bean.getClass().getMethod(setMethodName, returnType).invoke(bean, fieldValue);
						}
					}else{
						System.err.println("参数类型不对，In "+this.getClass().getName()+" "+getMethodName+" "+returnType.getName());
					}
				}
			}
		}
	}catch(Exception ex){
		ex.printStackTrace();
	}
}

/**
 * 直连数据库的Hibernate配置文件
 */
private static final String HIBERNATE_FILE = Const.HIBERNATE_CON_FILE;

/**
 *jsp是否正在运行
 */
private static boolean running = false ;


%><%

//new MailUtil();//执行收客服邮件的程序

String ip = request.getRemoteHost();
if(ip.equals("localhost")||ip.equals("127.0.0.1")){
	
	//如果上一分钟的jsp还没有执行完，这个jsp等待
	int count = 0 ;
	while(running){
		try {
			count ++;
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
	
	running = true ;
	for(int i=0;i<20-count;i++){
		Session session123 = null ;
		try{
			session123 = MyHibernateUtil.currentSession(HIBERNATE_FILE) ;
			
			long maxId = -1 ;
			
			//把已有的记录全部更新成status=1，立即提交，避免长时间锁表
			try{
				SQLQuery query = session123.createSQLQuery("select max(id) from f_access_log");
				BigInteger xId = (BigInteger)query.uniqueResult();
				if(xId!=null){
					maxId = xId.longValue();
				}
			}catch(Exception ex){
				ex.printStackTrace();
			}
			
			//如果有记录
			if(maxId>0){
				//把所有status=1的记录读出来，清除缓存，这里清除缓存不再读数据库，而是用f_access_log里的数据还原原来的Bean，速度极快
				SQLQuery query = session123.createSQLQuery("select id,class_name,oper_name,access_id,before_value,after_value from f_access_log where id<="+maxId);
				
				@SuppressWarnings("rawtypes")
				List list = query.list();
				
				if(list!=null&&list.size()>0){
					//逐个清除缓存和列表缓存
					for(int ix=0;ix<list.size();ix++){
						try{
							Object[] objs = (Object[])list.get(ix);//objs[0]就是id，objs[1]就是class_name
							Class<?> className = Class.forName((String)objs[1]);//bean class
							
							String beanId = (String)objs[3];//bean id
							String oper_name = ""+objs[2];//oper name，删除/增加/修改
							
							BaseManager manager = Tools.getManager(className);
							
							//操作之前的bean的数据，还原之
							BaseEntity beanOld = (BaseEntity)className.newInstance();
							beanOld.setId(beanId);
							
							//修改之后的数据
							BaseEntity beanNew = (BaseEntity)className.newInstance();
							beanNew.setId(beanId);
							
							String before_value = (String)objs[4];
							String after_value = (String)objs[5];
							
							//设置数据，还原操作之前bean的值
							if(!Tools.isNull(before_value)){
								recoverBean(beanOld,before_value);
							}
							
							//设置数据，还原操作之前bean的值
							if(!Tools.isNull(after_value)){
								recoverBean(beanNew,after_value);
							}
							
							//开始清缓存
							if("d".equals(oper_name)){//删除操作
								manager.clearListCache(beanOld);
								manager.clearOmCache(beanId);
							}else if("i".equals(oper_name)){//插入操作
								manager.clearListCache(beanOld);
								manager.clearOmCache(beanId);
							}else if("u".equals(oper_name)){//修改操作
								manager.clearListCache(beanOld);
								manager.clearListCache(beanNew);
								manager.clearOmCache(beanId);
							}
							
							//如果是商品，先更新lucene索引！！！
							if(Product.class.getName().equals(className.getName())){
								ProductManager pmanager = (ProductManager)Tools.getManager(Product.class);
								if("d".equals(oper_name)){//删除商品索引，一般不会有这种情况
									pmanager.removeProductId(beanId);
									SearchManager.getInstance().removeProductIndex(beanId);
								}else if("i".equals(oper_name)){//增加商品索引
									pmanager.addProductId(beanId);
									Product product = (Product)Tools.getManager(Product.class).get(beanId);
									if(product!=null&&product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()==1){
										SearchManager.getInstance().createProductIndex(product);
									}
								}else if("u".equals(oper_name)){//修改商品索引
									pmanager.removeProductId(beanId);
									pmanager.addProductId(beanId);
									Product product = (Product)Tools.getManager(Product.class).get(beanId);
									if(product!=null&&product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()==1){
										SearchManager.getInstance().addUpdateProductId(beanId);
									}
								}
							}
						}catch(Exception ex){
							ex.printStackTrace();
						}//end try
					}//end for
				}
				
				//删除log记录
				Transaction tx1 = null ;
				try{
					tx1 = session123.beginTransaction() ;
					session123.createSQLQuery("delete from f_access_log where id<="+maxId).executeUpdate();
					tx1.commit();
				}catch(Exception ex){
					if(tx1!=null)tx1.rollback();
					ex.printStackTrace();
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			MyHibernateUtil.closeSession(HIBERNATE_FILE);
		}
		
		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}//end for
	
	running = false ;
}//end if

%>