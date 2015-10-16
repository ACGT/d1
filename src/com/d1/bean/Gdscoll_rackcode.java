package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.*;

import com.d1.dbcache.core.BaseEntity;

/**
 * ��������Ӧ��
 * @author wdx
 *
 */
@Entity
@Table(name="gdscoll_rackcode")
public class Gdscoll_rackcode extends BaseEntity implements java.io.Serializable {
	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;	
	@Id
	@Column(name="id") 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private Long gr_box;//�ڼ�������
	private String gr_code;//ĳ��������ĳ������µķ����
	private Long gr_category;//���
	private Date gr_createtime;//����ʱ��
    private Long gr_order;//����
    private Long gr_gdsmstorder;//��Ʒ�б�����
	public Long getGr_gdsmstorder() {
		return gr_gdsmstorder;
	}
	public void setGr_gdsmstorder(Long gr_gdsmstorder) {
		this.gr_gdsmstorder = gr_gdsmstorder;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getGr_box() {
		return gr_box;
	}
	public void setGr_box(Long gr_box) {
		this.gr_box = gr_box;
	}
	public String getGr_code() {
		return gr_code;
	}
	public void setGr_code(String gr_code) {
		this.gr_code = gr_code;
	}
	public Long getGr_category() {
		return gr_category;
	}
	public void setGr_category(Long gr_category) {
		this.gr_category = gr_category;
	}
	public Date getGr_createtime() {
		return gr_createtime;
	}
	public void setGr_createtime(Date gr_createtime) {
		this.gr_createtime = gr_createtime;
	}
	public Long getGr_order() {
		return gr_order;
	}
	public void setGr_order(Long gr_order) {
		this.gr_order = gr_order;
	}
	
	

}
