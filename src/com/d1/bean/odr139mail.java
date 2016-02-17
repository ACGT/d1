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
@Table(name="odr139mail")
public class odr139mail extends BaseEntity implements java.io.Serializable {
		/**
		 * version id
		 */
		private static final long serialVersionUID = 1L;
		@Id
		@Column(name="odr139mail_id")
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		private String id;//done
		private String odr139mail_odrid;//订单号
		private String odr139mail_txt;//日志
		private int odr139mail_ifsend;//发送状态
		private String odr139mail_uptime;//更新时间
		private Date odr139mail_addtime=new Date();//创建时间
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getOdr139mail_odrid() {
			return odr139mail_odrid;
		}
		public void setOdr139mail_odrid(String odr139mail_odrid) {
			this.odr139mail_odrid = odr139mail_odrid;
		}
		public String getOdr139mail_txt() {
			return odr139mail_txt;
		}
		public void setOdr139mail_txt(String odr139mail_txt) {
			this.odr139mail_txt = odr139mail_txt;
		}
		public int getOdr139mail_ifsend() {
			return odr139mail_ifsend;
		}
		public void setOdr139mail_ifsend(int odr139mail_ifsend) {
			this.odr139mail_ifsend = odr139mail_ifsend;
		}
		public String getOdr139mail_uptime() {
			return odr139mail_uptime;
		}
		public void setOdr139mail_uptime(String odr139mail_uptime) {
			this.odr139mail_uptime = odr139mail_uptime;
		}
		public Date getOdr139mail_addtime() {
			return odr139mail_addtime;
		}
		public void setOdr139mail_addtime(Date odr139mail_addtime) {
			this.odr139mail_addtime = odr139mail_addtime;
		}
		
		
		/*create table odr139mail(
				odr139mail_id int identity(1,1),
				odr139mail_odrid char(12),
				odr139mail_txt varchar(500),
				odr139mail_ifsend tinyint default(0),
				odr139mail_uptime datetime,
				odr139mail_addtime datetime  default(getdate())
				)
	*/
	}
