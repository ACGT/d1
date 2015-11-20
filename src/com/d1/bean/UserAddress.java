package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * �û��ջ���ַ��
 * @author kk
 *
 */
@Entity
@Table(name="mbrcst")
public class UserAddress extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="mbrcst_pk")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	
	private Long mbrcst_id;//PK
	private Long mbrcst_mbrid;//PK
	private String mbrcst_name;
	private Long mbrcst_rsex;
	private String mbrcst_relation;
	private Long mbrcst_countryid;
	private Long mbrcst_provinceid;
	private Long mbrcst_cityid;
	private String mbrcst_raddress;
	private String mbrcst_rzipcode;
	private String mbrcst_remail;
	private String mbrcst_rphone;
	private String mbrcst_memo;
	private int mbrcst_isdefault;
	private Date createdate;
	private Date updatedate;
	
	/**
	 * 0 ���˵�ַ 1���˵�ַ
	 */
	private Long mbrcst_rthird;
	private String mbrcst_rtelephonecode;
	private String mbrcst_rtelephone;
	private String mbrcst_rtelephoneext;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getMbrcst_id() {
		return mbrcst_id;
	}
	public void setMbrcst_id(Long mbrcst_id) {
		this.mbrcst_id = mbrcst_id;
	}
	public Long getMbrcst_mbrid() {
		return mbrcst_mbrid;
	}
	public void setMbrcst_mbrid(Long mbrcst_mbrid) {
		this.mbrcst_mbrid = mbrcst_mbrid;
	}
	public String getMbrcst_name() {
		return mbrcst_name;
	}
	public void setMbrcst_name(String mbrcst_name) {
		this.mbrcst_name = mbrcst_name;
	}
	public Long getMbrcst_rsex() {
		return mbrcst_rsex;
	}
	public void setMbrcst_rsex(Long mbrcst_rsex) {
		this.mbrcst_rsex = mbrcst_rsex;
	}
	public String getMbrcst_relation() {
		return mbrcst_relation;
	}
	public void setMbrcst_relation(String mbrcst_relation) {
		this.mbrcst_relation = mbrcst_relation;
	}
	public Long getMbrcst_countryid() {
		return mbrcst_countryid;
	}
	public void setMbrcst_countryid(Long mbrcst_countryid) {
		this.mbrcst_countryid = mbrcst_countryid;
	}
	public Long getMbrcst_provinceid() {
		return mbrcst_provinceid;
	}
	public void setMbrcst_provinceid(Long mbrcst_provinceid) {
		this.mbrcst_provinceid = mbrcst_provinceid;
	}
	public Long getMbrcst_cityid() {
		return mbrcst_cityid;
	}
	public void setMbrcst_cityid(Long mbrcst_cityid) {
		this.mbrcst_cityid = mbrcst_cityid;
	}
	public String getMbrcst_raddress() {
		return mbrcst_raddress;
	}
	public void setMbrcst_raddress(String mbrcst_raddress) {
		this.mbrcst_raddress = mbrcst_raddress;
	}
	public String getMbrcst_rzipcode() {
		return mbrcst_rzipcode;
	}
	public void setMbrcst_rzipcode(String mbrcst_rzipcode) {
		this.mbrcst_rzipcode = mbrcst_rzipcode;
	}
	public String getMbrcst_remail() {
		return mbrcst_remail;
	}
	public void setMbrcst_remail(String mbrcst_remail) {
		this.mbrcst_remail = mbrcst_remail;
	}
	public String getMbrcst_rphone() {
		return mbrcst_rphone;
	}
	public void setMbrcst_rphone(String mbrcst_rphone) {
		this.mbrcst_rphone = mbrcst_rphone;
	}
	public String getMbrcst_memo() {
		return mbrcst_memo;
	}
	public void setMbrcst_memo(String mbrcst_memo) {
		this.mbrcst_memo = mbrcst_memo;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Date getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}
	public Long getMbrcst_rthird() {
		return mbrcst_rthird;
	}
	public void setMbrcst_rthird(Long mbrcst_rthird) {
		this.mbrcst_rthird = mbrcst_rthird;
	}
	public String getMbrcst_rtelephonecode() {
		return mbrcst_rtelephonecode;
	}
	public void setMbrcst_rtelephonecode(String mbrcst_rtelephonecode) {
		this.mbrcst_rtelephonecode = mbrcst_rtelephonecode;
	}
	public String getMbrcst_rtelephone() {
		return mbrcst_rtelephone;
	}
	public void setMbrcst_rtelephone(String mbrcst_rtelephone) {
		this.mbrcst_rtelephone = mbrcst_rtelephone;
	}
	public String getMbrcst_rtelephoneext() {
		return mbrcst_rtelephoneext;
	}
	public void setMbrcst_rtelephoneext(String mbrcst_rtelephoneext) {
		this.mbrcst_rtelephoneext = mbrcst_rtelephoneext;
	}
	public int getMbrcst_isDefault() {
		return mbrcst_isdefault;
	}
	public void setMbrcst_isDefault(int isDefault) {
		this.mbrcst_isdefault = isDefault;
	}
}
