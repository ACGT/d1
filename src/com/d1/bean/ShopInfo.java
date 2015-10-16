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
@Table(name="shopinfo")
public class ShopInfo extends BaseEntity implements java.io.Serializable {

		/**
		 * serial version id
		 */
		private static final long serialVersionUID = 1L;
		
		@Id
		@Column(name="shopinfo_id")
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		private String id ;//done
		private Long shopinfo_indexflag;
		private String shopinfo_shopcode;
		private String shopinfo_title;
		private String shopinfo_logo;//店招图
		private String shopinfo_ztimglist;
		private String shopinfo_bgcolor;
		private String shopinfo_floatcontent;
		private Long shopinfo_floatposition;
		private Date shopinfo_createdate;
		private String shopinfo_bigimg;//首张广告图
		private String shopinfo_lineflag;
		private String shopinfo_bgimg;//店招背景图
		private Long shopinfo_del=new Long(0);
		private String shopinfo_wapbanner;
		private Date shopinfo_tmbegin;//特卖会开始时间
		private Date shopinfo_tmend;//特卖会结束时间
		private Long shopinfo_adheight=new Long(0);
		
		public Date getShopinfo_tmbegin() {
			return shopinfo_tmbegin;
		}
		public void setShopinfo_tmbegin(Date shopinfo_tmbegin) {
			this.shopinfo_tmbegin = shopinfo_tmbegin;
		}
		public Date getShopinfo_tmend() {
			return shopinfo_tmend;
		}
		public void setShopinfo_tmend(Date shopinfo_tmend) {
			this.shopinfo_tmend = shopinfo_tmend;
		}
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public Long getShopinfo_indexflag() {
			return shopinfo_indexflag;
		}
		public void setShopinfo_indexflag(Long shopinfo_indexflag) {
			this.shopinfo_indexflag = shopinfo_indexflag;
		}
		public String getShopinfo_shopcode() {
			return shopinfo_shopcode;
		}
		public void setShopinfo_shopcode(String shopinfo_shopcode) {
			this.shopinfo_shopcode = shopinfo_shopcode;
		}
		public String getShopinfo_title() {
			return shopinfo_title;
		}
		public void setShopinfo_title(String shopinfo_title) {
			this.shopinfo_title = shopinfo_title;
		}
		public String getShopinfo_logo() {
			return shopinfo_logo;
		}
		public void setShopinfo_logo(String shopinfo_logo) {
			this.shopinfo_logo = shopinfo_logo;
		}
		public String getShopinfo_ztimglist() {
			return shopinfo_ztimglist;
		}
		public void setShopinfo_ztimglist(String shopinfo_ztimglist) {
			this.shopinfo_ztimglist = shopinfo_ztimglist;
		}
		public String getShopinfo_bgcolor() {
			return shopinfo_bgcolor;
		}
		public void setShopinfo_bgcolor(String shopinfo_bgcolor) {
			this.shopinfo_bgcolor = shopinfo_bgcolor;
		}
		public String getShopinfo_floatcontent() {
			return shopinfo_floatcontent;
		}
		public void setShopinfo_floatcontent(String shopinfo_floatcontent) {
			this.shopinfo_floatcontent = shopinfo_floatcontent;
		}
		public Long getShopinfo_floatposition() {
			return shopinfo_floatposition;
		}
		public void setShopinfo_floatposition(Long shopinfo_floatposition) {
			this.shopinfo_floatposition = shopinfo_floatposition;
		}
		public Date getShopinfo_createdate() {
			return shopinfo_createdate;
		}
		public void setShopinfo_createdate(Date shopinfo_createdate) {
			this.shopinfo_createdate = shopinfo_createdate;
		}
		public String getShopinfo_bigimg() {
			return shopinfo_bigimg;
		}
		public void setShopinfo_bigimg(String shopinfo_bigimg) {
			this.shopinfo_bigimg = shopinfo_bigimg;
		}
		public String getShopinfo_lineflag() {
			return shopinfo_lineflag;
		}
		public void setShopinfo_lineflag(String shopinfo_lineflag) {
			this.shopinfo_lineflag = shopinfo_lineflag;
		}
		public String getShopinfo_bgimg() {
			return shopinfo_bgimg;
		}
		public void setShopinfo_bgimg(String shopinfo_bgimg) {
			this.shopinfo_bgimg = shopinfo_bgimg;
		}
		public Long getShopinfo_del() {
			return shopinfo_del;
		}
		public void setShopinfo_del(Long shopinfo_del) {
			this.shopinfo_del = shopinfo_del;
		}
		public String getShopinfo_wapbanner() {
			return shopinfo_wapbanner;
		}
		public void setShopinfo_wapbanner(String shopinfo_wapbanner) {
			this.shopinfo_wapbanner = shopinfo_wapbanner;
		}
		public Long getShopinfo_adheight() {
			return shopinfo_adheight;
		}
		public void setShopinfo_adheight(Long shopinfo_adheight) {
			this.shopinfo_adheight = shopinfo_adheight;
		}
		

		
		/*  create table shopinfo(shopinfo_id int primary key identity(1,1),shopinfo_shopcode char(8),shopinfo_logo varchar(300),
 shopinfo_ztimglist varchar(50),shopinfo_createdate datetime)

		 * */
}
