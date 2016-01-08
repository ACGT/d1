package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="brandmst")
public class BrandMst extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	private String id;//done
	private String brandmst_code;
	private String brandmst_rackcode;// ���������
	private String brandmst_engname;//  Ʒ��Ӣ����
	private String brandmst_brandname;//  Ʒ��������
	private String brandmst_keywords;//  ϵ�йؼ��֣��ö��Ÿ���
	private String brandmst_tl;//   ������ͼ��1920
	private String brandmst_body;//   �ϲ����ͼ
	private String brandmst_menu;//   
	private String brandmst_country;//  ���ң��ձ� ���� �й�  ŷ����
	private String brandmst_spic;//   Сͼ
	private String brandmst_mpic;//   ��ͼ
	private String brandmst_page;//   �ֹ�ҳ��
	private String brandmst_authorization;//   Ʒ����Ȩɨ��ͼ
	private String brandmst_otherfile;//  ��ͬ�������ļ�
	private String brandmst_gdscount;//   ��Ʒ������̨����
	private String brandmst_memo;//   Ʒ�ƽ���
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getBrandmst_code() {
		return brandmst_code;
	}
	public void setBrandmst_code(String brandmst_code) {
		this.brandmst_code = brandmst_code;
	}
	public String getBrandmst_rackcode() {
		return brandmst_rackcode;
	}
	public void setBrandmst_rackcode(String brandmst_rackcode) {
		this.brandmst_rackcode = brandmst_rackcode;
	}
	public String getBrandmst_engname() {
		return brandmst_engname;
	}
	public void setBrandmst_engname(String brandmst_engname) {
		this.brandmst_engname = brandmst_engname;
	}
	public String getBrandmst_brandname() {
		return brandmst_brandname;
	}
	public void setBrandmst_brandname(String brandmst_brandname) {
		this.brandmst_brandname = brandmst_brandname;
	}
	public String getBrandmst_keywords() {
		return brandmst_keywords;
	}
	public void setBrandmst_keywords(String brandmst_keywords) {
		this.brandmst_keywords = brandmst_keywords;
	}
	public String getBrandmst_tl() {
		return brandmst_tl;
	}
	public void setBrandmst_tl(String brandmst_tl) {
		this.brandmst_tl = brandmst_tl;
	}
	public String getBrandmst_body() {
		return brandmst_body;
	}
	public void setBrandmst_body(String brandmst_body) {
		this.brandmst_body = brandmst_body;
	}
	public String getBrandmst_menu() {
		return brandmst_menu;
	}
	public void setBrandmst_menu(String brandmst_menu) {
		this.brandmst_menu = brandmst_menu;
	}
	public String getBrandmst_country() {
		return brandmst_country;
	}
	public void setBrandmst_country(String brandmst_country) {
		this.brandmst_country = brandmst_country;
	}
	public String getBrandmst_spic() {
		return brandmst_spic;
	}
	public void setBrandmst_spic(String brandmst_spic) {
		this.brandmst_spic = brandmst_spic;
	}
	public String getBrandmst_mpic() {
		return brandmst_mpic;
	}
	public void setBrandmst_mpic(String brandmst_mpic) {
		this.brandmst_mpic = brandmst_mpic;
	}
	public String getBrandmst_page() {
		return brandmst_page;
	}
	public void setBrandmst_page(String brandmst_page) {
		this.brandmst_page = brandmst_page;
	}
	public String getBrandmst_authorization() {
		return brandmst_authorization;
	}
	public void setBrandmst_authorization(String brandmst_authorization) {
		this.brandmst_authorization = brandmst_authorization;
	}
	public String getBrandmst_otherfile() {
		return brandmst_otherfile;
	}
	public void setBrandmst_otherfile(String brandmst_otherfile) {
		this.brandmst_otherfile = brandmst_otherfile;
	}
	public String getBrandmst_gdscount() {
		return brandmst_gdscount;
	}
	public void setBrandmst_gdscount(String brandmst_gdscount) {
		this.brandmst_gdscount = brandmst_gdscount;
	}
	public String getBrandmst_memo() {
		return brandmst_memo;
	}
	public void setBrandmst_memo(String brandmst_memo) {
		this.brandmst_memo = brandmst_memo;
	}


}
