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
	 * 抽奖活动--抽奖结果表
	 * @author kk
	 *
	 */
	@Entity
	@Table(name="lotwin8zn")
	public class LotWinAct extends BaseEntity implements java.io.Serializable {

		/**
		 * serial version id
		 */
		private static final long serialVersionUID = 1L;
		
		@Id
		@Column(name="lotwin8zn_id")
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		private String id;//done

		/**
		 * 减多少
		 */

		
		private Long lotwin8zn_mbrid;
		private String  lotwin8zn_uid;
		private Long lotwin8zn_winid;
		private String lotwin8zn_winname;
		private String lotwin8zn_memo;
		private String lotwin8zn_gdsid;
		private Long lotwin8zn_flag;
		private Date lotwin8zn_createtime;
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public Long getLotwin8zn_mbrid() {
			return lotwin8zn_mbrid;
		}
		public void setLotwin8zn_mbrid(Long lotwin8zn_mbrid) {
			this.lotwin8zn_mbrid = lotwin8zn_mbrid;
		}
		public String getLotwin8zn_uid() {
			return lotwin8zn_uid;
		}
		public void setLotwin8zn_uid(String lotwin8zn_uid) {
			this.lotwin8zn_uid = lotwin8zn_uid;
		}
		public Long getLotwin8zn_winid() {
			return lotwin8zn_winid;
		}
		public void setLotwin8zn_winid(Long lotwin8zn_winid) {
			this.lotwin8zn_winid = lotwin8zn_winid;
		}
		public String getLotwin8zn_winname() {
			return lotwin8zn_winname;
		}
		public void setLotwin8zn_winname(String lotwin8zn_winname) {
			this.lotwin8zn_winname = lotwin8zn_winname;
		}
		public String getLotwin8zn_memo() {
			return lotwin8zn_memo;
		}
		public void setLotwin8zn_memo(String lotwin8zn_memo) {
			this.lotwin8zn_memo = lotwin8zn_memo;
		}
		public String getLotwin8zn_gdsid() {
			return lotwin8zn_gdsid;
		}
		public void setLotwin8zn_gdsid(String lotwin8zn_gdsid) {
			this.lotwin8zn_gdsid = lotwin8zn_gdsid;
		}
		public Long getLotwin8zn_flag() {
			return lotwin8zn_flag;
		}
		public void setLotwin8zn_flag(Long lotwin8zn_flag) {
			this.lotwin8zn_flag = lotwin8zn_flag;
		}
		public Date getLotwin8zn_createtime() {
			return lotwin8zn_createtime;
		}
		public void setLotwin8zn_createtime(Date lotwin8zn_createtime) {
			this.lotwin8zn_createtime = lotwin8zn_createtime;
		}
		
		
}
