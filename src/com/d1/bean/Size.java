package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="sizemst")
public class Size  extends BaseEntity implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="sizemst_id")
	private String id;//done
	private String sizemst_name;
	private String sizemst_size1;
	private String sizemst_sizeselected1;
	private String sizemst_sizeunit1;
	private String sizemst_size2;
	private String sizemst_sizeselected2;
	private String sizemst_sizeunit2;
	private String sizemst_size3;
	private String sizemst_sizeselected3;
	private String sizemst_sizeunit3;
	private String sizemst_size4;
	private String sizemst_sizeselected4;
	private String sizemst_sizeunit4;
	private String sizemst_size5;
	private String sizemst_sizeselected5;
	private String sizemst_sizeunit5;
	private String sizemst_size6;
	private String sizemst_sizeselected6;
	private String sizemst_sizeunit6;
	private String sizemst_size7;
	private String sizemst_sizeselected7;
	private String sizemst_sizeunit7;
	private String sizemst_size8;
	private String sizemst_sizeselected8;
	private String sizemst_sizeunit8;
	private Long sizemst_ifchange;
	private String sizemst_photo;
	private String sizemst_memo;
	private Date sizemst_createdate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSizemst_name() {
		return sizemst_name;
	}
	public void setSizemst_name(String sizemst_name) {
		this.sizemst_name = sizemst_name;
	}
	public String getSizemst_size1() {
		return sizemst_size1;
	}
	public void setSizemst_size1(String sizemst_size1) {
		this.sizemst_size1 = sizemst_size1;
	}
	public String getSizemst_sizeselected1() {
		return sizemst_sizeselected1;
	}
	public void setSizemst_sizeselected1(String sizemst_sizeselected1) {
		this.sizemst_sizeselected1 = sizemst_sizeselected1;
	}
	public String getSizemst_sizeunit1() {
		return sizemst_sizeunit1;
	}
	public void setSizemst_sizeunit1(String sizemst_sizeunit1) {
		this.sizemst_sizeunit1 = sizemst_sizeunit1;
	}
	public String getSizemst_size2() {
		return sizemst_size2;
	}
	public void setSizemst_size2(String sizemst_size2) {
		this.sizemst_size2 = sizemst_size2;
	}
	public String getSizemst_sizeselected2() {
		return sizemst_sizeselected2;
	}
	public void setSizemst_sizeselected2(String sizemst_sizeselected2) {
		this.sizemst_sizeselected2 = sizemst_sizeselected2;
	}
	public String getSizemst_sizeunit2() {
		return sizemst_sizeunit2;
	}
	public void setSizemst_sizeunit2(String sizemst_sizeunit2) {
		this.sizemst_sizeunit2 = sizemst_sizeunit2;
	}
	public String getSizemst_size3() {
		return sizemst_size3;
	}
	public void setSizemst_size3(String sizemst_size3) {
		this.sizemst_size3 = sizemst_size3;
	}
	public String getSizemst_sizeselected3() {
		return sizemst_sizeselected3;
	}
	public void setSizemst_sizeselected3(String sizemst_sizeselected3) {
		this.sizemst_sizeselected3 = sizemst_sizeselected3;
	}
	public String getSizemst_sizeunit3() {
		return sizemst_sizeunit3;
	}
	public void setSizemst_sizeunit3(String sizemst_sizeunit3) {
		this.sizemst_sizeunit3 = sizemst_sizeunit3;
	}
	public String getSizemst_size4() {
		return sizemst_size4;
	}
	public void setSizemst_size4(String sizemst_size4) {
		this.sizemst_size4 = sizemst_size4;
	}
	public String getSizemst_sizeselected4() {
		return sizemst_sizeselected4;
	}
	public void setSizemst_sizeselected4(String sizemst_sizeselected4) {
		this.sizemst_sizeselected4 = sizemst_sizeselected4;
	}
	public String getSizemst_sizeunit4() {
		return sizemst_sizeunit4;
	}
	public void setSizemst_sizeunit4(String sizemst_sizeunit4) {
		this.sizemst_sizeunit4 = sizemst_sizeunit4;
	}
	public String getSizemst_size5() {
		return sizemst_size5;
	}
	public void setSizemst_size5(String sizemst_size5) {
		this.sizemst_size5 = sizemst_size5;
	}
	public String getSizemst_sizeselected5() {
		return sizemst_sizeselected5;
	}
	public void setSizemst_sizeselected5(String sizemst_sizeselected5) {
		this.sizemst_sizeselected5 = sizemst_sizeselected5;
	}
	public String getSizemst_sizeunit5() {
		return sizemst_sizeunit5;
	}
	public void setSizemst_sizeunit5(String sizemst_sizeunit5) {
		this.sizemst_sizeunit5 = sizemst_sizeunit5;
	}
	public String getSizemst_size6() {
		return sizemst_size6;
	}
	public void setSizemst_size6(String sizemst_size6) {
		this.sizemst_size6 = sizemst_size6;
	}
	public String getSizemst_sizeselected6() {
		return sizemst_sizeselected6;
	}
	public void setSizemst_sizeselected6(String sizemst_sizeselected6) {
		this.sizemst_sizeselected6 = sizemst_sizeselected6;
	}
	public String getSizemst_sizeunit6() {
		return sizemst_sizeunit6;
	}
	public void setSizemst_sizeunit6(String sizemst_sizeunit6) {
		this.sizemst_sizeunit6 = sizemst_sizeunit6;
	}
	public String getSizemst_size7() {
		return sizemst_size7;
	}
	public void setSizemst_size7(String sizemst_size7) {
		this.sizemst_size7 = sizemst_size7;
	}
	public String getSizemst_sizeselected7() {
		return sizemst_sizeselected7;
	}
	public void setSizemst_sizeselected7(String sizemst_sizeselected7) {
		this.sizemst_sizeselected7 = sizemst_sizeselected7;
	}
	public String getSizemst_sizeunit7() {
		return sizemst_sizeunit7;
	}
	public void setSizemst_sizeunit7(String sizemst_sizeunit7) {
		this.sizemst_sizeunit7 = sizemst_sizeunit7;
	}
	public String getSizemst_size8() {
		return sizemst_size8;
	}
	public void setSizemst_size8(String sizemst_size8) {
		this.sizemst_size8 = sizemst_size8;
	}
	public String getSizemst_sizeselected8() {
		return sizemst_sizeselected8;
	}
	public void setSizemst_sizeselected8(String sizemst_sizeselected8) {
		this.sizemst_sizeselected8 = sizemst_sizeselected8;
	}
	public String getSizemst_sizeunit8() {
		return sizemst_sizeunit8;
	}
	public void setSizemst_sizeunit8(String sizemst_sizeunit8) {
		this.sizemst_sizeunit8 = sizemst_sizeunit8;
	}
	public Long getSizemst_ifchange() {
		return sizemst_ifchange;
	}
	public void setSizemst_ifchange(Long sizemst_ifchange) {
		this.sizemst_ifchange = sizemst_ifchange;
	}
	public String getSizemst_photo() {
		return sizemst_photo;
	}
	public void setSizemst_photo(String sizemst_photo) {
		this.sizemst_photo = sizemst_photo;
	}
	public String getSizemst_memo() {
		return sizemst_memo;
	}
	public void setSizemst_memo(String sizemst_memo) {
		this.sizemst_memo = sizemst_memo;
	}
	public Date getSizemst_createdate() {
		return sizemst_createdate;
	}
	public void setSizemst_createdate(Date sizemst_createdate) {
		this.sizemst_createdate = sizemst_createdate;
	}
}
