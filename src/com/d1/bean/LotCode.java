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
@Table(name="lotcode")
public class LotCode extends BaseEntity implements java.io.Serializable {

		/**
		 * serial version id
		 */
		private static final long serialVersionUID = 1L;
		
		@Id
		@Column(name="lotcode_id")
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		private String id;//done
		private Long Lotcode_mbrid;
		private String Lotcode_odrid;
		private String Lotcode_rec;
		private Date Lotcode_createdate;
		private Long Lotcode_status;
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public Long getLotcode_mbrid() {
			return Lotcode_mbrid;
		}
		public void setLotcode_mbrid(Long lotcode_mbrid) {
			Lotcode_mbrid = lotcode_mbrid;
		}
		public String getLotcode_odrid() {
			return Lotcode_odrid;
		}
		public void setLotcode_odrid(String lotcode_odrid) {
			Lotcode_odrid = lotcode_odrid;
		}
		public String getLotcode_rec() {
			return Lotcode_rec;
		}
		public void setLotcode_rec(String lotcode_rec) {
			Lotcode_rec = lotcode_rec;
		}
		public Date getLotcode_createdate() {
			return Lotcode_createdate;
		}
		public void setLotcode_createdate(Date lotcode_createdate) {
			Lotcode_createdate = lotcode_createdate;
		}
		public Long getLotcode_status() {
			return Lotcode_status;
		}
		public void setLotcode_status(Long lotcode_status) {
			Lotcode_status = lotcode_status;
		}


}
