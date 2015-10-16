package com.d1.util;

import java.util.Calendar;

/**
 * 翻页的工具<br/>
 * 用于翻页的bean
 * @author kk
 */
public class PageBean {
	/**
	 * 总长度
	 */
	private long totalLength ;
	
	/**
	 * 当前页数
	 */
	private int currentPage ;
	
	/**
	 * 每页显示数
	 */
	private int pageSize;
	
	/**
	 * 开始page
	 */
	private int startPage ;
	
	/**
	 * 结束page
	 */
	private int endPage ;
	
	/**
	 * 总页数
	 */
	private int totalPages ;
	
	/**
	 * 开始位置
	 */
	private int start ;
	
	/**
	 * 构造一个翻页bean
	 * @param totalLength 总长度
	 * @param pageSize 每页显示数
	 * @param currentPage 当前页
	 */
	public PageBean(long totalLength,int pageSize,int currentPage){
		this.totalLength = totalLength ;
		this.pageSize = pageSize ;
		this.currentPage = currentPage ;
		
		init();
	}
	
	/**
	 * 算一下totalPages和start 
	 */
	private void init(){
		if(totalLength%pageSize==0)totalPages = (int)(totalLength/pageSize) ;
		else totalPages = (int)(totalLength/pageSize) +1 ;
		if(currentPage>totalPages)currentPage = totalPages ;
		if(currentPage<1)currentPage=1;
		start = (currentPage-1)*pageSize ;
		
		startPage = currentPage - 3 ;
		if(startPage<1)	{
			endPage = currentPage + 3 -startPage;
			startPage = 1 ;
		}else{
			endPage = currentPage +3 ;
		}
		if(endPage>totalPages)endPage = totalPages ;
		if(endPage-startPage<6&&totalPages>=6){
				startPage = endPage - 6 ;
				if(startPage<1)startPage = 1;
		}
		
	}
	
	/**
	 * 是否有上一页
	 * @return
	 */
	public boolean hasPreviousPage(){
		return currentPage>1;
	}
	
	/**
	 * 是否有下一页
	 * @return
	 */
	public boolean hasNextPage(){
		return currentPage<totalPages;
	}
	
	/**
	 * 返回上一页的页数,返回-1时表示错误
	 * @return
	 */
	public int getPreviousPage(){
		if(hasPreviousPage())return currentPage - 1;
		return -1;
	}
	/**
	 * 返回当前页
	 * @return
	 */
	public int getCurrentPage(){
		return currentPage;
	}
	/**
	 * 返回下一页的页码，返回-1时表示错误
	 * @return
	 */
	public int getNextPage(){
		if(hasNextPage())return currentPage+1;
		return -1 ;
	}
	/**
	 * 得到起始位置
	 * @return
	 */
	public int getStart(){
		return start ;
	}
	
	/**
	 * 得到开始页，用于显示页码
	 * @return
	 */
	public int getStartPage(){
		return this.startPage ;
	}
	
	/**
	 * 得到结束页，用于显示页码
	 * @return
	 */
	public int getEndPage(){
		return this.endPage ;
	}
	
	public static void main(String[] args){
		System.out.println(Calendar.getInstance().get(Calendar.MONTH));
	}
	
	/**
	 * 总页数
	 * @return
	 */
	public int getTotalPages(){
		return this.totalPages;
	}
}
