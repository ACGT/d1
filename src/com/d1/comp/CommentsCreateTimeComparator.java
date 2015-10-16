package com.d1.comp;

import java.util.Comparator;

import com.d1.bean.Comment;

/**
 * 按照评论创建时间排序
 * @author wdx
 *
 */
public class CommentsCreateTimeComparator implements Comparator<Comment>{

	@Override
	public int compare(Comment p0, Comment p1) {
		if(p0.getGdscom_createdate()!=null&&p1.getGdscom_createdate()!=null){
			if(p0.getGdscom_createdate().getTime()>p1.getGdscom_createdate().getTime()){
				return -1 ;
			}else if(p0.getGdscom_createdate().getTime()==p1.getGdscom_createdate().getTime()){
				return 0 ;
			}else{
				return 1 ;
			}
		}
		return 0;
	}

}