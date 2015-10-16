package com.d1.util;

import java.util.Calendar;

/**
 * ��ҳ�Ĺ���<br/>
 * ���ڷ�ҳ��bean
 * @author kk
 */
public class PageBean {
	/**
	 * �ܳ���
	 */
	private long totalLength ;
	
	/**
	 * ��ǰҳ��
	 */
	private int currentPage ;
	
	/**
	 * ÿҳ��ʾ��
	 */
	private int pageSize;
	
	/**
	 * ��ʼpage
	 */
	private int startPage ;
	
	/**
	 * ����page
	 */
	private int endPage ;
	
	/**
	 * ��ҳ��
	 */
	private int totalPages ;
	
	/**
	 * ��ʼλ��
	 */
	private int start ;
	
	/**
	 * ����һ����ҳbean
	 * @param totalLength �ܳ���
	 * @param pageSize ÿҳ��ʾ��
	 * @param currentPage ��ǰҳ
	 */
	public PageBean(long totalLength,int pageSize,int currentPage){
		this.totalLength = totalLength ;
		this.pageSize = pageSize ;
		this.currentPage = currentPage ;
		
		init();
	}
	
	/**
	 * ��һ��totalPages��start 
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
	 * �Ƿ�����һҳ
	 * @return
	 */
	public boolean hasPreviousPage(){
		return currentPage>1;
	}
	
	/**
	 * �Ƿ�����һҳ
	 * @return
	 */
	public boolean hasNextPage(){
		return currentPage<totalPages;
	}
	
	/**
	 * ������һҳ��ҳ��,����-1ʱ��ʾ����
	 * @return
	 */
	public int getPreviousPage(){
		if(hasPreviousPage())return currentPage - 1;
		return -1;
	}
	/**
	 * ���ص�ǰҳ
	 * @return
	 */
	public int getCurrentPage(){
		return currentPage;
	}
	/**
	 * ������һҳ��ҳ�룬����-1ʱ��ʾ����
	 * @return
	 */
	public int getNextPage(){
		if(hasNextPage())return currentPage+1;
		return -1 ;
	}
	/**
	 * �õ���ʼλ��
	 * @return
	 */
	public int getStart(){
		return start ;
	}
	
	/**
	 * �õ���ʼҳ��������ʾҳ��
	 * @return
	 */
	public int getStartPage(){
		return this.startPage ;
	}
	
	/**
	 * �õ�����ҳ��������ʾҳ��
	 * @return
	 */
	public int getEndPage(){
		return this.endPage ;
	}
	
	public static void main(String[] args){
		System.out.println(Calendar.getInstance().get(Calendar.MONTH));
	}
	
	/**
	 * ��ҳ��
	 * @return
	 */
	public int getTotalPages(){
		return this.totalPages;
	}
}
