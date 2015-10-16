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
 * 缓存页面的filter，要缓存的页面在web.xml里配置<br/>
 * 做这个缓存是防止部分页面大规模并发，比如result.jsp。
 * @author kk
 **/
public class CacheFilter implements Filter { 
	/**
	 * 配置
	 */
	private static FilterConfig config = null ;
	
	public void init(FilterConfig filterConfig) throws ServletException {    
		config = filterConfig;
	}
	
	/**
	 * 页面缓存的map，设置最大缓存长度3000
	 */
	private static Map<String,PageContentBean> pageMap = Collections.synchronizedMap(new LRUCache<String,PageContentBean>(3000));
	
	/**
	 * filter方法，实现部分jsp的快速缓存。<br>
	 */
	public void doFilter(ServletRequest request,ServletResponse response,FilterChain chain) throws IOException, ServletException {    
		HttpServletRequest req = (HttpServletRequest)request;

		PageContentBean pcb = pageMap.get(requestToKey(req));
		String html = null ;
		
		long cache_millis = 30000 ;//默认30秒
		String pc = config.getInitParameter("cache_millis") ;
		if(pc!=null&&pc.length()>0){
			cache_millis = new Long(pc).longValue();
		}
		
		//缓存大于15秒则重新从服务器端获取...
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
	 * 把参数转换成key，用于做缓存的key
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
		
		private long newTime ;//页面时间
		private String content ;//页面内容
		
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

