package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="minimst")
public class Mini extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="minimst_id")
	private String id;//done
	private String minimst_name;
	private String minimst_dtl;
	private String minimst_tl;
	private String minimst_tlmap;
	private Long minimst_style;
	private Long minimst_colstyle;
	private String minimst_background;
	private String minimst_col1pic;
	private String minimst_col1rck;
	private String minimst_col1name;
	private String minimst_col1map;
	private Long minimst_col1linenum;
	private Long minimst_col1type;
	private String minimst_col2pic;
	private String minimst_col2rck;
	private String minimst_col2name;
	private String minimst_col2map;
	private Long minimst_col2linenum;
	private Long minimst_col2type;
	private String minimst_col3pic;
	private String minimst_col3rck;
	private String minimst_col3name;
	private String minimst_col3map;
	private Long minimst_col3linenum;
	private Long minimst_col3type;
	private String minimst_col4pic;
	private String minimst_col4rck;
	private String minimst_col4name;
	private String minimst_col4map;
	private Long minimst_col4linenum;
	private Long minimst_col4type;
	private String minimst_col5pic;
	private String minimst_col5rck;
	private String minimst_col5name;
	private String minimst_col5map;
	private Long minimst_col5linenum;
	private Long minimst_col5type;
	private String minimst_col6pic;
	private String minimst_col6rck;
	private String minimst_col6name;
	private String minimst_col6map;
	private Long minimst_col6linenum;
	private Long minimst_col6type;
	private String minimst_detail;
	private String minimst_rackcode;
	private Date minimst_time;
	private String minimst_description;
	private String minimst_keywords;
	private String minimst_bottom;
	private Long minimst_sex;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMinimst_name() {
		return minimst_name;
	}
	public void setMinimst_name(String minimst_name) {
		this.minimst_name = minimst_name;
	}
	public String getMinimst_dtl() {
		return minimst_dtl;
	}
	public void setMinimst_dtl(String minimst_dtl) {
		this.minimst_dtl = minimst_dtl;
	}
	public String getMinimst_tl() {
		return minimst_tl;
	}
	public void setMinimst_tl(String minimst_tl) {
		this.minimst_tl = minimst_tl;
	}
	public String getMinimst_tlmap() {
		return minimst_tlmap;
	}
	public void setMinimst_tlmap(String minimst_tlmap) {
		this.minimst_tlmap = minimst_tlmap;
	}
	public Long getMinimst_style() {
		return minimst_style;
	}
	public void setMinimst_style(Long minimst_style) {
		this.minimst_style = minimst_style;
	}
	public Long getMinimst_colstyle() {
		return minimst_colstyle;
	}
	public void setMinimst_colstyle(Long minimst_colstyle) {
		this.minimst_colstyle = minimst_colstyle;
	}
	public String getMinimst_background() {
		return minimst_background;
	}
	public void setMinimst_background(String minimst_background) {
		this.minimst_background = minimst_background;
	}
	public String getMinimst_col1pic() {
		return minimst_col1pic;
	}
	public void setMinimst_col1pic(String minimst_col1pic) {
		this.minimst_col1pic = minimst_col1pic;
	}
	public String getMinimst_col1rck() {
		return minimst_col1rck;
	}
	public void setMinimst_col1rck(String minimst_col1rck) {
		this.minimst_col1rck = minimst_col1rck;
	}
	public String getMinimst_col1name() {
		return minimst_col1name;
	}
	public void setMinimst_col1name(String minimst_col1name) {
		this.minimst_col1name = minimst_col1name;
	}
	public String getMinimst_col1map() {
		return minimst_col1map;
	}
	public void setMinimst_col1map(String minimst_col1map) {
		this.minimst_col1map = minimst_col1map;
	}
	public Long getMinimst_col1linenum() {
		return minimst_col1linenum;
	}
	public void setMinimst_col1linenum(Long minimst_col1linenum) {
		this.minimst_col1linenum = minimst_col1linenum;
	}
	public Long getMinimst_col1type() {
		return minimst_col1type;
	}
	public void setMinimst_col1type(Long minimst_col1type) {
		this.minimst_col1type = minimst_col1type;
	}
	public String getMinimst_col2pic() {
		return minimst_col2pic;
	}
	public void setMinimst_col2pic(String minimst_col2pic) {
		this.minimst_col2pic = minimst_col2pic;
	}
	public String getMinimst_col2rck() {
		return minimst_col2rck;
	}
	public void setMinimst_col2rck(String minimst_col2rck) {
		this.minimst_col2rck = minimst_col2rck;
	}
	public String getMinimst_col2name() {
		return minimst_col2name;
	}
	public void setMinimst_col2name(String minimst_col2name) {
		this.minimst_col2name = minimst_col2name;
	}
	public String getMinimst_col2map() {
		return minimst_col2map;
	}
	public void setMinimst_col2map(String minimst_col2map) {
		this.minimst_col2map = minimst_col2map;
	}
	public Long getMinimst_col2linenum() {
		return minimst_col2linenum;
	}
	public void setMinimst_col2linenum(Long minimst_col2linenum) {
		this.minimst_col2linenum = minimst_col2linenum;
	}
	public Long getMinimst_col2type() {
		return minimst_col2type;
	}
	public void setMinimst_col2type(Long minimst_col2type) {
		this.minimst_col2type = minimst_col2type;
	}
	public String getMinimst_col3pic() {
		return minimst_col3pic;
	}
	public void setMinimst_col3pic(String minimst_col3pic) {
		this.minimst_col3pic = minimst_col3pic;
	}
	public String getMinimst_col3rck() {
		return minimst_col3rck;
	}
	public void setMinimst_col3rck(String minimst_col3rck) {
		this.minimst_col3rck = minimst_col3rck;
	}
	public String getMinimst_col3name() {
		return minimst_col3name;
	}
	public void setMinimst_col3name(String minimst_col3name) {
		this.minimst_col3name = minimst_col3name;
	}
	public String getMinimst_col3map() {
		return minimst_col3map;
	}
	public void setMinimst_col3map(String minimst_col3map) {
		this.minimst_col3map = minimst_col3map;
	}
	public Long getMinimst_col3linenum() {
		return minimst_col3linenum;
	}
	public void setMinimst_col3linenum(Long minimst_col3linenum) {
		this.minimst_col3linenum = minimst_col3linenum;
	}
	public Long getMinimst_col3type() {
		return minimst_col3type;
	}
	public void setMinimst_col3type(Long minimst_col3type) {
		this.minimst_col3type = minimst_col3type;
	}
	public String getMinimst_col4pic() {
		return minimst_col4pic;
	}
	public void setMinimst_col4pic(String minimst_col4pic) {
		this.minimst_col4pic = minimst_col4pic;
	}
	public String getMinimst_col4rck() {
		return minimst_col4rck;
	}
	public void setMinimst_col4rck(String minimst_col4rck) {
		this.minimst_col4rck = minimst_col4rck;
	}
	public String getMinimst_col4name() {
		return minimst_col4name;
	}
	public void setMinimst_col4name(String minimst_col4name) {
		this.minimst_col4name = minimst_col4name;
	}
	public String getMinimst_col4map() {
		return minimst_col4map;
	}
	public void setMinimst_col4map(String minimst_col4map) {
		this.minimst_col4map = minimst_col4map;
	}
	public Long getMinimst_col4linenum() {
		return minimst_col4linenum;
	}
	public void setMinimst_col4linenum(Long minimst_col4linenum) {
		this.minimst_col4linenum = minimst_col4linenum;
	}
	public Long getMinimst_col4type() {
		return minimst_col4type;
	}
	public void setMinimst_col4type(Long minimst_col4type) {
		this.minimst_col4type = minimst_col4type;
	}
	public String getMinimst_col5pic() {
		return minimst_col5pic;
	}
	public void setMinimst_col5pic(String minimst_col5pic) {
		this.minimst_col5pic = minimst_col5pic;
	}
	public String getMinimst_col5rck() {
		return minimst_col5rck;
	}
	public void setMinimst_col5rck(String minimst_col5rck) {
		this.minimst_col5rck = minimst_col5rck;
	}
	public String getMinimst_col5name() {
		return minimst_col5name;
	}
	public void setMinimst_col5name(String minimst_col5name) {
		this.minimst_col5name = minimst_col5name;
	}
	public String getMinimst_col5map() {
		return minimst_col5map;
	}
	public void setMinimst_col5map(String minimst_col5map) {
		this.minimst_col5map = minimst_col5map;
	}
	public Long getMinimst_col5linenum() {
		return minimst_col5linenum;
	}
	public void setMinimst_col5linenum(Long minimst_col5linenum) {
		this.minimst_col5linenum = minimst_col5linenum;
	}
	public Long getMinimst_col5type() {
		return minimst_col5type;
	}
	public void setMinimst_col5type(Long minimst_col5type) {
		this.minimst_col5type = minimst_col5type;
	}
	public String getMinimst_col6pic() {
		return minimst_col6pic;
	}
	public void setMinimst_col6pic(String minimst_col6pic) {
		this.minimst_col6pic = minimst_col6pic;
	}
	public String getMinimst_col6rck() {
		return minimst_col6rck;
	}
	public void setMinimst_col6rck(String minimst_col6rck) {
		this.minimst_col6rck = minimst_col6rck;
	}
	public String getMinimst_col6name() {
		return minimst_col6name;
	}
	public void setMinimst_col6name(String minimst_col6name) {
		this.minimst_col6name = minimst_col6name;
	}
	public String getMinimst_col6map() {
		return minimst_col6map;
	}
	public void setMinimst_col6map(String minimst_col6map) {
		this.minimst_col6map = minimst_col6map;
	}
	public Long getMinimst_col6linenum() {
		return minimst_col6linenum;
	}
	public void setMinimst_col6linenum(Long minimst_col6linenum) {
		this.minimst_col6linenum = minimst_col6linenum;
	}
	public Long getMinimst_col6type() {
		return minimst_col6type;
	}
	public void setMinimst_col6type(Long minimst_col6type) {
		this.minimst_col6type = minimst_col6type;
	}
	public String getMinimst_detail() {
		return minimst_detail;
	}
	public void setMinimst_detail(String minimst_detail) {
		this.minimst_detail = minimst_detail;
	}
	public String getMinimst_rackcode() {
		return minimst_rackcode;
	}
	public void setMinimst_rackcode(String minimst_rackcode) {
		this.minimst_rackcode = minimst_rackcode;
	}
	public Date getMinimst_time() {
		return minimst_time;
	}
	public void setMinimst_time(Date minimst_time) {
		this.minimst_time = minimst_time;
	}
	public String getMinimst_description() {
		return minimst_description;
	}
	public void setMinimst_description(String minimst_description) {
		this.minimst_description = minimst_description;
	}
	public String getMinimst_keywords() {
		return minimst_keywords;
	}
	public void setMinimst_keywords(String minimst_keywords) {
		this.minimst_keywords = minimst_keywords;
	}
	public String getMinimst_bottom() {
		return minimst_bottom;
	}
	public void setMinimst_bottom(String minimst_bottom) {
		this.minimst_bottom = minimst_bottom;
	}
	public Long getMinimst_sex() {
		return minimst_sex;
	}
	public void setMinimst_sex(Long minimst_sex) {
		this.minimst_sex = minimst_sex;
	}
}
