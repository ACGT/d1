package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="stdmst")
public class Standard extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="stdmst_stdid")
	private String id;//done
	private String stdmst_stdname;
	private String stdmst_atrname1;
	private String stdmst_atrname2;
	private String stdmst_atrname3;
	private String stdmst_atrname4;
	private String stdmst_atrname5;
	private String stdmst_atrname6;
	private String stdmst_atrname7;
	private String stdmst_atrname8;
	private String stdmst_atrname9;
	private String stdmst_atrname10;
	private String stdmst_atrname11;
	private String stdmst_atrname12;
	private String stdmst_atrdtl1;
	private String stdmst_atrdtl2;
	private String stdmst_atrdtl3;
	private String stdmst_atrdtl4;
	private String stdmst_atrdtl5;
	private String stdmst_atrdtl6;
	private String stdmst_atrdtl7;
	private String stdmst_atrdtl8;
	private String stdmst_atrdtl9;
	private String stdmst_atrdtl10;
	private String stdmst_atrdtl11;
	private String stdmst_atrdtl12;
	private String stdmst_unit1;
	private String stdmst_unit2;
	private String stdmst_unit3;
	private String stdmst_unit4;
	private String stdmst_unit5;
	private String stdmst_unit6;
	private String stdmst_unit7;
	private String stdmst_unit8;
	private String stdmst_unit9;
	private String stdmst_unit10;
	private String stdmst_unit11;
	private String stdmst_unit12;
	private Long stdmst_showflag1;
	private Long stdmst_showflag2;
	private Long stdmst_showflag3;
	private Long stdmst_showflag4;
	private Long stdmst_showflag5;
	private Long stdmst_showflag6;
	private Long stdmst_showflag7;
	private Long stdmst_showflag8;
	private Long stdmst_showflag9;
	private Long stdmst_showflag10;
	private Long stdmst_showflag11;
	private Long stdmst_showflag12;
	private String stdmst_spestr;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getStdmst_stdname() {
		return stdmst_stdname;
	}
	public void setStdmst_stdname(String stdmst_stdname) {
		this.stdmst_stdname = stdmst_stdname;
	}
	public String getStdmst_atrname1() {
		return stdmst_atrname1;
	}
	public void setStdmst_atrname1(String stdmst_atrname1) {
		this.stdmst_atrname1 = stdmst_atrname1;
	}
	public String getStdmst_atrname2() {
		return stdmst_atrname2;
	}
	public void setStdmst_atrname2(String stdmst_atrname2) {
		this.stdmst_atrname2 = stdmst_atrname2;
	}
	public String getStdmst_atrname3() {
		return stdmst_atrname3;
	}
	public void setStdmst_atrname3(String stdmst_atrname3) {
		this.stdmst_atrname3 = stdmst_atrname3;
	}
	public String getStdmst_atrname4() {
		return stdmst_atrname4;
	}
	public void setStdmst_atrname4(String stdmst_atrname4) {
		this.stdmst_atrname4 = stdmst_atrname4;
	}
	public String getStdmst_atrname5() {
		return stdmst_atrname5;
	}
	public void setStdmst_atrname5(String stdmst_atrname5) {
		this.stdmst_atrname5 = stdmst_atrname5;
	}
	public String getStdmst_atrname6() {
		return stdmst_atrname6;
	}
	public void setStdmst_atrname6(String stdmst_atrname6) {
		this.stdmst_atrname6 = stdmst_atrname6;
	}
	public String getStdmst_atrname7() {
		return stdmst_atrname7;
	}
	public void setStdmst_atrname7(String stdmst_atrname7) {
		this.stdmst_atrname7 = stdmst_atrname7;
	}
	public String getStdmst_atrname8() {
		return stdmst_atrname8;
	}
	public void setStdmst_atrname8(String stdmst_atrname8) {
		this.stdmst_atrname8 = stdmst_atrname8;
	}
	public String getStdmst_atrdtl1() {
		return stdmst_atrdtl1;
	}
	public void setStdmst_atrdtl1(String stdmst_atrdtl1) {
		this.stdmst_atrdtl1 = stdmst_atrdtl1;
	}
	public String getStdmst_atrdtl2() {
		return stdmst_atrdtl2;
	}
	public void setStdmst_atrdtl2(String stdmst_atrdtl2) {
		this.stdmst_atrdtl2 = stdmst_atrdtl2;
	}
	public String getStdmst_atrdtl3() {
		return stdmst_atrdtl3;
	}
	public void setStdmst_atrdtl3(String stdmst_atrdtl3) {
		this.stdmst_atrdtl3 = stdmst_atrdtl3;
	}
	public String getStdmst_atrdtl4() {
		return stdmst_atrdtl4;
	}
	public void setStdmst_atrdtl4(String stdmst_atrdtl4) {
		this.stdmst_atrdtl4 = stdmst_atrdtl4;
	}
	public String getStdmst_atrdtl5() {
		return stdmst_atrdtl5;
	}
	public void setStdmst_atrdtl5(String stdmst_atrdtl5) {
		this.stdmst_atrdtl5 = stdmst_atrdtl5;
	}
	public String getStdmst_atrdtl6() {
		return stdmst_atrdtl6;
	}
	public void setStdmst_atrdtl6(String stdmst_atrdtl6) {
		this.stdmst_atrdtl6 = stdmst_atrdtl6;
	}
	public String getStdmst_atrdtl7() {
		return stdmst_atrdtl7;
	}
	public void setStdmst_atrdtl7(String stdmst_atrdtl7) {
		this.stdmst_atrdtl7 = stdmst_atrdtl7;
	}
	public String getStdmst_atrdtl8() {
		return stdmst_atrdtl8;
	}
	public void setStdmst_atrdtl8(String stdmst_atrdtl8) {
		this.stdmst_atrdtl8 = stdmst_atrdtl8;
	}
	public String getStdmst_unit1() {
		return stdmst_unit1;
	}
	public void setStdmst_unit1(String stdmst_unit1) {
		this.stdmst_unit1 = stdmst_unit1;
	}
	public String getStdmst_unit2() {
		return stdmst_unit2;
	}
	public void setStdmst_unit2(String stdmst_unit2) {
		this.stdmst_unit2 = stdmst_unit2;
	}
	public String getStdmst_unit3() {
		return stdmst_unit3;
	}
	public void setStdmst_unit3(String stdmst_unit3) {
		this.stdmst_unit3 = stdmst_unit3;
	}
	public String getStdmst_unit4() {
		return stdmst_unit4;
	}
	public void setStdmst_unit4(String stdmst_unit4) {
		this.stdmst_unit4 = stdmst_unit4;
	}
	public String getStdmst_unit5() {
		return stdmst_unit5;
	}
	public void setStdmst_unit5(String stdmst_unit5) {
		this.stdmst_unit5 = stdmst_unit5;
	}
	public String getStdmst_unit6() {
		return stdmst_unit6;
	}
	public void setStdmst_unit6(String stdmst_unit6) {
		this.stdmst_unit6 = stdmst_unit6;
	}
	public String getStdmst_unit7() {
		return stdmst_unit7;
	}
	public void setStdmst_unit7(String stdmst_unit7) {
		this.stdmst_unit7 = stdmst_unit7;
	}
	public String getStdmst_unit8() {
		return stdmst_unit8;
	}
	public void setStdmst_unit8(String stdmst_unit8) {
		this.stdmst_unit8 = stdmst_unit8;
	}
	public Long getStdmst_showflag1() {
		return stdmst_showflag1;
	}
	public void setStdmst_showflag1(Long stdmst_showflag1) {
		this.stdmst_showflag1 = stdmst_showflag1;
	}
	public Long getStdmst_showflag2() {
		return stdmst_showflag2;
	}
	public void setStdmst_showflag2(Long stdmst_showflag2) {
		this.stdmst_showflag2 = stdmst_showflag2;
	}
	public Long getStdmst_showflag3() {
		return stdmst_showflag3;
	}
	public void setStdmst_showflag3(Long stdmst_showflag3) {
		this.stdmst_showflag3 = stdmst_showflag3;
	}
	public Long getStdmst_showflag4() {
		return stdmst_showflag4;
	}
	public void setStdmst_showflag4(Long stdmst_showflag4) {
		this.stdmst_showflag4 = stdmst_showflag4;
	}
	public Long getStdmst_showflag5() {
		return stdmst_showflag5;
	}
	public void setStdmst_showflag5(Long stdmst_showflag5) {
		this.stdmst_showflag5 = stdmst_showflag5;
	}
	public Long getStdmst_showflag6() {
		return stdmst_showflag6;
	}
	public void setStdmst_showflag6(Long stdmst_showflag6) {
		this.stdmst_showflag6 = stdmst_showflag6;
	}
	public Long getStdmst_showflag7() {
		return stdmst_showflag7;
	}
	public void setStdmst_showflag7(Long stdmst_showflag7) {
		this.stdmst_showflag7 = stdmst_showflag7;
	}
	public Long getStdmst_showflag8() {
		return stdmst_showflag8;
	}
	public void setStdmst_showflag8(Long stdmst_showflag8) {
		this.stdmst_showflag8 = stdmst_showflag8;
	}
	
	public String getStdmst_atrname9() {
		return stdmst_atrname9;
	}
	public void setStdmst_atrname9(String stdmst_atrname9) {
		this.stdmst_atrname9 = stdmst_atrname9;
	}
	public String getStdmst_atrname10() {
		return stdmst_atrname10;
	}
	public void setStdmst_atrname10(String stdmst_atrname10) {
		this.stdmst_atrname10 = stdmst_atrname10;
	}
	public String getStdmst_atrname11() {
		return stdmst_atrname11;
	}
	public void setStdmst_atrname11(String stdmst_atrname11) {
		this.stdmst_atrname11 = stdmst_atrname11;
	}
	public String getStdmst_atrname12() {
		return stdmst_atrname12;
	}
	public void setStdmst_atrname12(String stdmst_atrname12) {
		this.stdmst_atrname12 = stdmst_atrname12;
	}
	public String getStdmst_atrdtl9() {
		return stdmst_atrdtl9;
	}
	public void setStdmst_atrdtl9(String stdmst_atrdtl9) {
		this.stdmst_atrdtl9 = stdmst_atrdtl9;
	}
	public String getStdmst_atrdtl10() {
		return stdmst_atrdtl10;
	}
	public void setStdmst_atrdtl10(String stdmst_atrdtl10) {
		this.stdmst_atrdtl10 = stdmst_atrdtl10;
	}
	public String getStdmst_atrdtl11() {
		return stdmst_atrdtl11;
	}
	public void setStdmst_atrdtl11(String stdmst_atrdtl11) {
		this.stdmst_atrdtl11 = stdmst_atrdtl11;
	}
	public String getStdmst_atrdtl12() {
		return stdmst_atrdtl12;
	}
	public void setStdmst_atrdtl12(String stdmst_atrdtl12) {
		this.stdmst_atrdtl12 = stdmst_atrdtl12;
	}
	public String getStdmst_unit9() {
		return stdmst_unit9;
	}
	public void setStdmst_unit9(String stdmst_unit9) {
		this.stdmst_unit9 = stdmst_unit9;
	}
	public String getStdmst_unit10() {
		return stdmst_unit10;
	}
	public void setStdmst_unit10(String stdmst_unit10) {
		this.stdmst_unit10 = stdmst_unit10;
	}
	public String getStdmst_unit11() {
		return stdmst_unit11;
	}
	public void setStdmst_unit11(String stdmst_unit11) {
		this.stdmst_unit11 = stdmst_unit11;
	}
	public String getStdmst_unit12() {
		return stdmst_unit12;
	}
	public void setStdmst_unit12(String stdmst_unit12) {
		this.stdmst_unit12 = stdmst_unit12;
	}
	public Long getStdmst_showflag9() {
		return stdmst_showflag9;
	}
	public void setStdmst_showflag9(Long stdmst_showflag9) {
		this.stdmst_showflag9 = stdmst_showflag9;
	}
	public Long getStdmst_showflag10() {
		return stdmst_showflag10;
	}
	public void setStdmst_showflag10(Long stdmst_showflag10) {
		this.stdmst_showflag10 = stdmst_showflag10;
	}
	public Long getStdmst_showflag11() {
		return stdmst_showflag11;
	}
	public void setStdmst_showflag11(Long stdmst_showflag11) {
		this.stdmst_showflag11 = stdmst_showflag11;
	}
	public Long getStdmst_showflag12() {
		return stdmst_showflag12;
	}
	public void setStdmst_showflag12(Long stdmst_showflag12) {
		this.stdmst_showflag12 = stdmst_showflag12;
	}
	
	public String getStdmst_spestr() {
		return stdmst_spestr;
	}
	public void setStdmst_spestr(String stdmst_spestr) {
		this.stdmst_spestr = stdmst_spestr;
	}
	
}
