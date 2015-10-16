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
@Table(name="d1acttb")
public class D1ActTb extends BaseEntity implements java.io.Serializable {
		/**
		 * version id
		 */
		private static final long serialVersionUID = 1L;
		@Id
		@Column(name="d1acttb_id")
		@GeneratedValue(strategy=GenerationType.IDENTITY) 
		private String id;
		private String d1acttb_name;
		private String d1acttb_shopcode;
		private Long d1acttb_acttype; //0为满减  //1为推荐位满减只能D1使用，
		private String d1acttb_ppcode; //推荐位号
		private String d1acttb_brandcode;  //品牌编号
		private Long d1acttb_status=new Long(0);  //0申请  1通过申请
		private Date d1acttb_sqtime;  //申请时间
		private String d1acttb_shmn;   //审核人
		private Date d1acttb_shdate;   //审核通过时间
		private Date d1acttb_starttime;
		private Date d1acttb_endtime;
		private Long d1acttb_snum1;
		private Long d1acttb_enum1;
		private Long d1acttb_snum2;
		private Long d1acttb_enum2;
		private Long d1acttb_snum3;
		private Long d1acttb_enum3;
		private String d1acttb_memo;
		private String d1acttb_gourl;
		private Date d1acttb_createdate=new Date();
		
		
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getD1acttb_name() {
			return d1acttb_name;
		}
		public void setD1acttb_name(String d1acttb_name) {
			this.d1acttb_name = d1acttb_name;
		}
		public String getD1acttb_shopcode() {
			return d1acttb_shopcode;
		}
		public void setD1acttb_shopcode(String d1acttb_shopcode) {
			this.d1acttb_shopcode = d1acttb_shopcode;
		}
		public Long getD1acttb_acttype() {
			return d1acttb_acttype;
		}
		public void setD1acttb_acttype(Long d1acttb_acttype) {
			this.d1acttb_acttype = d1acttb_acttype;
		}
		public String getD1acttb_ppcode() {
			return d1acttb_ppcode;
		}
		public void setD1acttb_ppcode(String d1acttb_ppcode) {
			this.d1acttb_ppcode = d1acttb_ppcode;
		}
		public String getD1acttb_brandcode() {
			return d1acttb_brandcode;
		}
		public void setD1acttb_brandcode(String d1acttb_brandcode) {
			this.d1acttb_brandcode = d1acttb_brandcode;
		}
		public Long getD1acttb_status() {
			return d1acttb_status;
		}
		public void setD1acttb_status(Long d1acttb_status) {
			this.d1acttb_status = d1acttb_status;
		}
		public Date getD1acttb_sqtime() {
			return d1acttb_sqtime;
		}
		public void setD1acttb_sqtime(Date d1acttb_sqtime) {
			this.d1acttb_sqtime = d1acttb_sqtime;
		}
		public String getD1acttb_shmn() {
			return d1acttb_shmn;
		}
		public void setD1acttb_shmn(String d1acttb_shmn) {
			this.d1acttb_shmn = d1acttb_shmn;
		}
		public Date getD1acttb_shdate() {
			return d1acttb_shdate;
		}
		public void setD1acttb_shdate(Date d1acttb_shdate) {
			this.d1acttb_shdate = d1acttb_shdate;
		}
		public Date getD1acttb_starttime() {
			return d1acttb_starttime;
		}
		public void setD1acttb_starttime(Date d1acttb_starttime) {
			this.d1acttb_starttime = d1acttb_starttime;
		}
		public Date getD1acttb_endtime() {
			return d1acttb_endtime;
		}
		public void setD1acttb_endtime(Date d1acttb_endtime) {
			this.d1acttb_endtime = d1acttb_endtime;
		}
		public Long getD1acttb_snum1() {
			return d1acttb_snum1;
		}
		public void setD1acttb_snum1(Long d1acttb_snum1) {
			this.d1acttb_snum1 = d1acttb_snum1;
		}
		public Long getD1acttb_enum1() {
			return d1acttb_enum1;
		}
		public void setD1acttb_enum1(Long d1acttb_enum1) {
			this.d1acttb_enum1 = d1acttb_enum1;
		}
		public Long getD1acttb_snum2() {
			return d1acttb_snum2;
		}
		public void setD1acttb_snum2(Long d1acttb_snum2) {
			this.d1acttb_snum2 = d1acttb_snum2;
		}
		public Long getD1acttb_enum2() {
			return d1acttb_enum2;
		}
		public void setD1acttb_enum2(Long d1acttb_enum2) {
			this.d1acttb_enum2 = d1acttb_enum2;
		}
		public Long getD1acttb_snum3() {
			return d1acttb_snum3;
		}
		public void setD1acttb_snum3(Long d1acttb_snum3) {
			this.d1acttb_snum3 = d1acttb_snum3;
		}
		public Long getD1acttb_enum3() {
			return d1acttb_enum3;
		}
		public void setD1acttb_enum3(Long d1acttb_enum3) {
			this.d1acttb_enum3 = d1acttb_enum3;
		}
		public String getD1acttb_memo() {
			return d1acttb_memo;
		}
		public void setD1acttb_memo(String d1acttb_memo) {
			this.d1acttb_memo = d1acttb_memo;
		}
		public String getD1acttb_gourl() {
			return d1acttb_gourl;
		}
		public void setD1acttb_gourl(String d1acttb_gourl) {
			this.d1acttb_gourl = d1acttb_gourl;
		}
		public Date getD1acttb_createdate() {
			return d1acttb_createdate;
		}
		public void setD1acttb_createdate(Date d1acttb_createdate) {
			this.d1acttb_createdate = d1acttb_createdate;
		}
		
		// create table d1acttb(d1acttb_id int primary key,d1acttb_name varchar(200),d1acttb_shopcode char(8),d1acttb_acttype int,d1acttb_status int
		//,d1acttb_sqtime datetime,d1acttb_shmn varchar(50),d1acttb_shdate datetime,d1acttb_starttime datetime,
		//d1acttb_endtime datetime,d1acttb_snum1 int,d1acttb_enum1 int,d1acttb_snum2 int,d1acttb_enum2 int
		//,d1acttb_snum3 int,d1acttb_enum3 int,d1acttb_memo varchar(500),d1acttb_createdate datetime)
}
	



