package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="actindex")
public class ActIndex extends BaseEntity implements java.io.Serializable {
	/**
	 * searial version id
	 */
	
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="actindex_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String actindex_shopcode;
	private String actindex_name;
	private Long   actindex_status;
	private String actindex_shuser;
    private Date   actindex_shdate;
    private Long   actindex_type;
    private Long   actindex_dectype;
    private Long   actindex_delflag;
    private Date   actindex_deldate;
	private String actindex_content;
    private String actindex_adduser;
    private String actindex_subad;
    private String actindex_gourl;
    private String  actindex_areatitle;
    private String actindex_areatcolor;
    private String  actindex_areatbgcolor;
    private Date actindex_createdate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getActindex_shopcode() {
		return actindex_shopcode;
	}
	public void setActindex_shopcode(String actindex_shopcode) {
		this.actindex_shopcode = actindex_shopcode;
	}
	public String getActindex_name() {
		return actindex_name;
	}
	public void setActindex_name(String actindex_name) {
		this.actindex_name = actindex_name;
	}
	public Long getActindex_status() {
		return actindex_status;
	}
	public void setActindex_status(Long actindex_status) {
		this.actindex_status = actindex_status;
	}
	public String getActindex_shuser() {
		return actindex_shuser;
	}
	public void setActindex_shuser(String actindex_shuser) {
		this.actindex_shuser = actindex_shuser;
	}
	public Date getActindex_shdate() {
		return actindex_shdate;
	}
	public void setActindex_shdate(Date actindex_shdate) {
		this.actindex_shdate = actindex_shdate;
	}
	public Long getActindex_type() {
		return actindex_type;
	}
	public void setActindex_type(Long actindex_type) {
		this.actindex_type = actindex_type;
	}
	public Long getActindex_dectype() {
		return actindex_dectype;
	}
	public void setActindex_dectype(Long actindex_dectype) {
		this.actindex_dectype = actindex_dectype;
	}
	public Long getActindex_delflag() {
		return actindex_delflag;
	}
	public void setActindex_delflag(Long actindex_delflag) {
		this.actindex_delflag = actindex_delflag;
	}
	
	public Date getActindex_deldate() {
		return actindex_deldate;
	}
	public void setActindex_deldate(Date actindex_deldate) {
		this.actindex_deldate = actindex_deldate;
	}
	public String getActindex_content() {
		return actindex_content;
	}
	public void setActindex_content(String actindex_content) {
		this.actindex_content = actindex_content;
	}
	public String getActindex_adduser() {
		return actindex_adduser;
	}
	public void setActindex_adduser(String actindex_adduser) {
		this.actindex_adduser = actindex_adduser;
	}
	public String getActindex_subad() {
		return actindex_subad;
	}
	public void setActindex_subad(String actindex_subad) {
		this.actindex_subad = actindex_subad;
	}
	public String getActindex_gourl() {
		return actindex_gourl;
	}
	public void setActindex_gourl(String actindex_gourl) {
		this.actindex_gourl = actindex_gourl;
	}
	public String getActindex_areatitle() {
		return actindex_areatitle;
	}
	public void setActindex_areatitle(String actindex_areatitle) {
		this.actindex_areatitle = actindex_areatitle;
	}
	public String getActindex_areatcolor() {
		return actindex_areatcolor;
	}
	public void setActindex_areatcolor(String actindex_areatcolor) {
		this.actindex_areatcolor = actindex_areatcolor;
	}
	public String getActindex_areatbgcolor() {
		return actindex_areatbgcolor;
	}
	public void setActindex_areatbgcolor(String actindex_areatbgcolor) {
		this.actindex_areatbgcolor = actindex_areatbgcolor;
	}
	public Date getActindex_createdate() {
		return actindex_createdate;
	}
	public void setActindex_createdate(Date actindex_createdate) {
		this.actindex_createdate = actindex_createdate;
	}
    
	/*create table actindex(actindex_id int,actindex_shopcode char(8),actindex_name varchar(200),
actindex_status smallint,actindex_shuser varchar(50),actindex_shdate datetime,
actindex_type smallint,actindex_dectype smallint,actindex_content ntext,actindex_adduser varchar(50),
actindex_createdate datetime)
	 * */
}
