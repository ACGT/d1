package com.d1.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Collections;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.d1.LRUCache;
import com.d1.util.MD5;

/**
 * ����ҳ���filter��Ҫ�����ҳ����web.xml������<br/>
 * ����������Ƿ�ֹ����ҳ����ģ����������result.jsp��
 * @author kk
 **/
public class CacheFilter implements Filter { 
	/**
	 * ����
	 */
	private static FilterConfig config = null ;
	
	public void init(FilterConfig filterConfig) throws ServletException {    
		config = filterConfig;
	}
	
	/**
	 * ҳ�滺���map��������󻺴泤��3000
	 */
	private static Map<String,PageContentBean> pageMap = Collections.synchronizedMap(new LRUCache<String,PageContentBean>(3000));
	
	/**
	 * filter������ʵ�ֲ���jsp�Ŀ��ٻ��档<br>
	 */
	public void doFilter(ServletRequest request,ServletResponse response,FilterChain chain) throws IOException, ServletException {    
		HttpServletRequest req = (HttpServletRequest)request;

		PageContentBean pcb = pageMap.get(requestToKey(req));
		String html = null ;
		
		long cache_millis = 30000 ;//Ĭ��30��
		String pc = config.getInitParameter("cache_millis") ;
		if(pc!=null&&pc.length()>0){
			cache_millis = new Long(pc).longValue();
		}
		
		//�������15�������´ӷ������˻�ȡ...
		if(pcb==null||(System.currentTimeMillis()-pcb.getNewTime()>cache_millis)){
			CacheResponseWrapper responseWrapper =  new CacheResponseWrapper((HttpServletResponse)response);    
			chain.doFilter(request, responseWrapper);   
			
			html = responseWrapper.getContent();
			
			PageContentBean pcbNew = new PageContentBean();
			pcbNew.setContent(html);
			pcbNew.setNewTime(System.currentTimeMillis());
			
			pageMap.put(requestToKey(req), pcbNew);
		}else{
			html = pcb.getContent();
		}
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.write(html);
		pw.flush();
		pw.close();
	}     
	
	/**
	 * �Ѳ���ת����key�������������key
	 * @param request
	 * @return
	 */
	private String requestToKey(HttpServletRequest request){
		StringBuffer sb = new StringBuffer();
		sb.append(request.getRequestURI()).append("?");
		String queryString = request.getQueryString();
		if(queryString==null)queryString="";
		try{
			queryString = URLEncoder.encode(queryString,"UTF-8");
		}catch(Exception ex){
			ex.printStackTrace();
		}
		sb.append(queryString);
		return MD5.toMD5(sb.toString());
	}
	
	public void destroy() {
		//do nothing
	}
	
	private class PageContentBean{
		
		private long newTime ;//ҳ��ʱ��
		private String content ;//ҳ������
		
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public long getNewTime() {
			return newTime;
		}
		public void setNewTime(long newTime) {
			this.newTime = newTime;
		}
		
	}
} 

