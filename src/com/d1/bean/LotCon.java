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
	 * 抽奖活动--抽奖实物奖品表
	 * @author kk
	 *
	 */
	@Entity
	@Table(name="lotcon")
	public class LotCon extends BaseEntity implements java.io.Serializable {

		/**
		 * serial version id
		 */
		private static final long serialVersionUID = 1L;
		
		@Id
		@Column(name="lotcon_id")
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		private String id;//done

		/**
		 * 减多少
		 */

		private String lotcon_name;
		private Date lotcon_starttime;
		private Date lotcon_endtime;
		private Long lotcon_winid;
		private String lotcon_winname;
		private Long lotcon_flag;
		private Long lotcon_mbrflag;
		private String lotcon_gdsid;
		private String lotcon_memo;
		private Double Lotcon_price;
		private Long Lotcon_sex;
		private Long Lotcon_count;
		private Long Lotcon_wincount;
		private Date lotcon_createtime;
		

		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getLotcon_name() {
			return lotcon_name;
		}
		public void setLotcon_name(String lotcon_name) {
			this.lotcon_name = lotcon_name;
		}
		public Date getLotcon_starttime() {
			return lotcon_starttime;
		}
		public void setLotcon_starttime(Date lotcon_starttime) {
			this.lotcon_starttime = lotcon_starttime;
		}
		public Date getLotcon_endtime() {
			return lotcon_endtime;
		}
		public void setLotcon_endtime(Date lotcon_endtime) {
			this.lotcon_endtime = lotcon_endtime;
		}
		public Long getLotcon_winid() {
			return lotcon_winid;
		}
		public void setLotcon_winid(Long lotcon_winid) {
			this.lotcon_winid = lotcon_winid;
		}
		public String getLotcon_winname() {
			return lotcon_winname;
		}
		public void setLotcon_winname(String lotcon_winname) {
			this.lotcon_winname = lotcon_winname;
		}
		public Long getLotcon_flag() {
			return lotcon_flag;
		}
		public void setLotcon_flag(Long lotcon_flag) {
			this.lotcon_flag = lotcon_flag;
		}
		public Long getLotcon_mbrflag() {
			return lotcon_mbrflag;
		}
		public void setLotcon_mbrflag(Long lotcon_mbrflag) {
			this.lotcon_mbrflag = lotcon_mbrflag;
		}
		public String getLotcon_gdsid() {
			return lotcon_gdsid;
		}
		public void setLotcon_gdsid(String lotcon_gdsid) {
			this.lotcon_gdsid = lotcon_gdsid;
		}
		public String getLotcon_memo() {
			return lotcon_memo;
		}
		public void setLotcon_memo(String lotcon_memo) {
			this.lotcon_memo = lotcon_memo;
		}
		public Double getLotcon_price() {
			return Lotcon_price;
		}
		public void setLotcon_price(Double lotcon_price) {
			Lotcon_price = lotcon_price;
		}
		public Long getLotcon_sex() {
			return Lotcon_sex;
		}
		public void setLotcon_sex(Long lotcon_sex) {
			Lotcon_sex = lotcon_sex;
		}
		public Long getLotcon_count() {
			return Lotcon_count;
		}
		public void setLotcon_count(Long lotcon_count) {
			Lotcon_count = lotcon_count;
		}
		public Long getLotcon_wincount() {
			return Lotcon_wincount;
		}
		public void setLotcon_wincount(Long lotcon_wincount) {
			Lotcon_wincount = lotcon_wincount;
		}
		public Date getLotcon_createtime() {
			return lotcon_createtime;
		}
		public void setLotcon_createtime(Date lotcon_createtime) {
			this.lotcon_createtime = lotcon_createtime;
		}


}
