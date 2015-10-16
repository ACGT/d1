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
	 * 抽奖活动--抽奖次数表
	 * @author kk
	 *
	 */
	@Entity
	@Table(name="lot8zn")
	public class LotAct extends BaseEntity implements java.io.Serializable {

		/**
		 * serial version id
		 */
		private static final long serialVersionUID = 1L;
		
		@Id
		@Column(name="lot8zn_id")
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		private String id;//done

		/**
		 * 减多少
		 */
		
		private Long lot8zn_mbrid;
		private Long lot8zn_totcount;
		private Long lot8zn_count;
		private Date lot8zn_createdate;
		private String lot8zn_cardno;
		private Long lot8zn_status;
		

		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public Long getLot8zn_mbrid() {
			return lot8zn_mbrid;
		}
		public void setLot8zn_mbrid(Long lot8zn_mbrid) {
			this.lot8zn_mbrid = lot8zn_mbrid;
		}
		public Long getLot8zn_totcount() {
			return lot8zn_totcount;
		}
		public void setLot8zn_totcount(Long lot8zn_totcount) {
			this.lot8zn_totcount = lot8zn_totcount;
		}
		public Long getLot8zn_count() {
			return lot8zn_count;
		}
		public void setLot8zn_count(Long lot8zn_count) {
			this.lot8zn_count = lot8zn_count;
		}
		public Date getLot8zn_createdate() {
			return lot8zn_createdate;
		}
		public void setLot8zn_createdate(Date lot8zn_createdate) {
			this.lot8zn_createdate = lot8zn_createdate;
		}
		public String getLot8zn_cardno() {
			return lot8zn_cardno;
		}
		public void setLot8zn_cardno(String lot8zn_cardno) {
			this.lot8zn_cardno = lot8zn_cardno;
		}
		public Long getLot8zn_status() {
			return lot8zn_status;
		}
		public void setLot8zn_status(Long lot8zn_status) {
			this.lot8zn_status = lot8zn_status;
		}

}
