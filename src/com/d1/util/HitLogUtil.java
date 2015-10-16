package com.d1.util;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.d1.bean.User;
import com.d1.dbcache.core.MyLoggerUtil;
import com.d1.helper.UserHelper;

/**
 * 记录hit.log的工具
 * @author kk
 */
public class HitLogUtil {
	/*
	4.% 指定特殊字符                                                    %25 
	5.# 表示书签                                                             %23 
	6.& URL 中指定的参数间的分隔符                        %26 
*/
	public static String repbad(String strrep){
		strrep=strrep.replace("%", "%25");
		strrep=strrep.replace("#", "%23");
		strrep=strrep.replace("&", "%26");
		return strrep;
	}
	public static void log(HttpServletRequest request,HttpServletResponse response){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		org.apache.log4j.Logger hitlogger = MyLoggerUtil.getLogger("hitlogger");
		HttpSession session = (HttpSession)request.getSession();
		StringBuffer sb = new StringBuffer();
		sb.append(request.getRemoteHost()).append("|");
		if(session.getAttribute("first_referer_url")!=null){
			sb.append((String)session.getAttribute("first_referer_url")).append("|");
			String first_referer_url = request.getHeader("Referer");
			if(first_referer_url==null||first_referer_url.length()==0){
				first_referer_url = request.getHeader("referer");
			}
			if(first_referer_url!=null){
				first_referer_url=repbad(first_referer_url);
			}
			//if(first_referer_url!=null&&(first_referer_url.indexOf("http://ubmcmm.baidustatic.com")>=0||first_referer_url.indexOf("http://clickvalue.sinaapp.com")>=0)){
				//return;
			//}
			if(first_referer_url!=null&&first_referer_url.indexOf("http://baidu.com")>=0){
				return;
			}
			if(first_referer_url!=null&&first_referer_url.length()>0&&first_referer_url.indexOf("www.d1.com.cn")<0){
				
					try {
						if(java.nio.charset.Charset.forName("GB2312").newEncoder().canEncode(first_referer_url))
						{
						first_referer_url = java.net.URLDecoder.decode(first_referer_url, "GBK");
						}
						else
						{
							first_referer_url = java.net.URLDecoder.decode(first_referer_url, "UTF-8");
						}
					} catch (UnsupportedEncodingException e) {
						System.out.print(first_referer_url+"------");
						e.printStackTrace();
					}
				session.setAttribute("first_referer_url2",first_referer_url);
			}
		}
		else{
			String first_referer_url = request.getHeader("Referer");
			if(first_referer_url==null||first_referer_url.length()==0){
				first_referer_url = request.getHeader("referer");
			}
			//if(first_referer_url!=null&&(first_referer_url.indexOf("http://ubmcmm.baidustatic.com")>=0||first_referer_url.indexOf("http://clickvalue.sinaapp.com")>=0)){
			//	return;
			//}
			if(first_referer_url!=null&&first_referer_url.indexOf("http://baidu.com")>=0){
				return;
			}
			if(first_referer_url!=null){
				first_referer_url=repbad(first_referer_url);
			}
			if(first_referer_url!=null&&first_referer_url.length()>0&&first_referer_url.indexOf("www.d1.com.cn")<0){
				if(first_referer_url.indexOf("www.d1.com.cn")>-1){
					try {
						if(java.nio.charset.Charset.forName("GB2312").newEncoder().canEncode(first_referer_url))
						{
						first_referer_url = java.net.URLDecoder.decode(first_referer_url, "GBK");
						}
						else
						{
							first_referer_url = java.net.URLDecoder.decode(first_referer_url, "UTF-8");
						}
					} catch (UnsupportedEncodingException e) {
						System.out.print(first_referer_url+"------");
						e.printStackTrace();
					}
				}else{
					try {
						if(java.nio.charset.Charset.forName("GB2312").newEncoder().canEncode(first_referer_url))
						{
						first_referer_url = java.net.URLDecoder.decode(first_referer_url, "GBK");
						}
						else
						{
							first_referer_url = java.net.URLDecoder.decode(first_referer_url, "UTF-8");
						}
					} catch (UnsupportedEncodingException e) {
						System.out.print(first_referer_url+"------");
						e.printStackTrace();
					}
				}
				session.setAttribute("first_referer_url",first_referer_url);
				session.setAttribute("first_referer_url2",first_referer_url);
				sb.append(first_referer_url).append("|");
			}else{
				sb.append("no").append("|");
			}
		}
		sb.append(session.getId()).append("|");
		User lUser = UserHelper.getLoginUser(request, response);
		if(lUser!=null){
			sb.append(lUser.getId()).append("|");
			sb.append((lUser.getMbrmst_finishdate()!=null?sdf.format(lUser.getMbrmst_finishdate()):"no")).append("|");
			String strSubad = Tools.getCookie(request,"d1.com.cn.peoplercm.subad");
			sb.append((Tools.isNull(strSubad)?"no":strSubad)).append("|");
			sb.append((lUser.getMbrmst_createdate()!=null?sdf.format(lUser.getMbrmst_createdate()):"no")).append("|");
		}else{
			sb.append("no").append("|");
			sb.append("no").append("|");
			sb.append("no").append("|");
			sb.append("no").append("|");
		}
		sb.append(request.getRequestURI()).append("|");
		if(request.getHeader("User-Agent")!=null){
			sb.append(request.getHeader("User-Agent"));
		}else if(request.getHeader("user-agent")!=null){
			sb.append(request.getHeader("user-agent"));
		}else{
			sb.append("no");
		}
		sb.append("|");
		
		String refererUrl739310 = request.getHeader("Referer") ;
		if(refererUrl739310==null){
			refererUrl739310 = request.getHeader("referer");
		}
		if(refererUrl739310!=null){
			refererUrl739310=repbad(refererUrl739310);
		}
		if(refererUrl739310==null)refererUrl739310="no";
		if(refererUrl739310.indexOf("www.d1.com.cn")>-1){
			try {
				if(java.nio.charset.Charset.forName("GB2312").newEncoder().canEncode(refererUrl739310))
				{
					refererUrl739310 = java.net.URLDecoder.decode(refererUrl739310, "GBK");
				}
				else
				{
					refererUrl739310 = java.net.URLDecoder.decode(refererUrl739310, "UTF-8");
				}
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				return;
			}
		}else{
			try {
				if(java.nio.charset.Charset.forName("GB2312").newEncoder().canEncode(refererUrl739310))
				{
					refererUrl739310 = java.net.URLDecoder.decode(refererUrl739310, "GBK");
				}
				else
				{
					refererUrl739310 = java.net.URLDecoder.decode(refererUrl739310, "UTF-8");
				}
				
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				return;
			}
		}
		
		if(refererUrl739310!=null){
			sb.append(refererUrl739310);
		}else{
			sb.append("no");
		}
		
		sb.append("|");
		
		Enumeration<?> en = request.getParameterNames();
		while(en.hasMoreElements()){
			String k = (String)en.nextElement();
			sb.append(k).append("=").append(request.getParameter(k)).append("&");
		}
		String logStr = sb.toString();
		logStr=logStr.replaceAll("\\s","");
		hitlogger.info(logStr);
	}
}
