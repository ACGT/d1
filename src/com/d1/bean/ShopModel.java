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
@Table(name="shopmodel")
public class ShopModel extends BaseEntity implements java.io.Serializable {

			/**
			 * serial version id
			 */
			private static final long serialVersionUID = 1L;
			
			@Id
			@Column(name="shopmodel_id")
			@GeneratedValue(strategy=GenerationType.IDENTITY)
			private String id ;//done
			private String shopmodel_title;
			private String shopmodel_shopcode;
			private Long shopmodel_type;
			private Long shopmodel_infoid;
			private String shopmodel_content;
			private String shopmodel_list;
			private Long shopmodel_size;
			private Long shopmodel_flag;
			private Long shopmodel_sort;
			private Long shopmodel_style=new Long(0);
			private String shopmodel_cximg;
			private String shopmodel_txt;//模块标题
			private String shopmodel_txtcolor;//模块颜色
			private String shopmodel_txtmore;//标题点击链接
			private Date shopmodel_createdate;
			private Long shopmodel_balloon;//模板气球
			private String shopmodel_balname;//气球中的文字
			private Long shopmodel_orderflag;//是否显示排序
			private Long shopmodel_gdsnum=new Long(0);
			public Long getShopmodel_orderflag() {
				return shopmodel_orderflag;
			}
			public void setShopmodel_orderflag(Long shopmodel_orderflag) {
				this.shopmodel_orderflag = shopmodel_orderflag;
			}
			public Long getShopmodel_balloon() {
				return shopmodel_balloon;
			}
			public void setShopmodel_balloon(Long shopmodel_balloon) {
				this.shopmodel_balloon = shopmodel_balloon;
			}
			public String getShopmodel_balname() {
				return shopmodel_balname;
			}
			public void setShopmodel_balname(String shopmodel_balname) {
				this.shopmodel_balname = shopmodel_balname;
			}
			public String getId() {
				return id;
			}
			public void setId(String id) {
				this.id = id;
			}
			public String getShopmodel_title() {
				return shopmodel_title;
			}
			public void setShopmodel_title(String shopmodel_title) {
				this.shopmodel_title = shopmodel_title;
			}
			public String getShopmodel_shopcode() {
				return shopmodel_shopcode;
			}
			public void setShopmodel_shopcode(String shopmodel_shopcode) {
				this.shopmodel_shopcode = shopmodel_shopcode;
			}
			public Long getShopmodel_type() {
				return shopmodel_type;
			}
			public void setShopmodel_type(Long shopmodel_type) {
				this.shopmodel_type = shopmodel_type;
			}
			
			public Long getShopmodel_infoid() {
				return shopmodel_infoid;
			}
			public void setShopmodel_infoid(Long shopmodel_infoid) {
				this.shopmodel_infoid = shopmodel_infoid;
			}
			public String getShopmodel_content() {
				return shopmodel_content;
			}
			public void setShopmodel_content(String shopmodel_content) {
				this.shopmodel_content = shopmodel_content;
			}
			public String getShopmodel_list() {
				return shopmodel_list;
			}
			public void setShopmodel_list(String shopmodel_list) {
				this.shopmodel_list = shopmodel_list;
			}
			public Long getShopmodel_size() {
				return shopmodel_size;
			}
			public void setShopmodel_size(Long shopmodel_size) {
				this.shopmodel_size = shopmodel_size;
			}
			public Long getShopmodel_flag() {
				return shopmodel_flag;
			}
			public void setShopmodel_flag(Long shopmodel_flag) {
				this.shopmodel_flag = shopmodel_flag;
			}
			public Long getShopmodel_sort() {
				return shopmodel_sort;
			}
			public void setShopmodel_sort(Long shopmodel_sort) {
				this.shopmodel_sort = shopmodel_sort;
			}
			public Long getShopmodel_style() {
				return shopmodel_style;
			}
			public void setShopmodel_style(Long shopmodel_style) {
				this.shopmodel_style = shopmodel_style;
			}
			public String getShopmodel_cximg() {
				return shopmodel_cximg;
			}
			public void setShopmodel_cximg(String shopmodel_cximg) {
				this.shopmodel_cximg = shopmodel_cximg;
			}
			public String getShopmodel_txt() {
				return shopmodel_txt;
			}
			public void setShopmodel_txt(String shopmodel_txt) {
				this.shopmodel_txt = shopmodel_txt;
			}
			public String getShopmodel_txtcolor() {
				return shopmodel_txtcolor;
			}
			public void setShopmodel_txtcolor(String shopmodel_txtcolor) {
				this.shopmodel_txtcolor = shopmodel_txtcolor;
			}
			public String getShopmodel_txtmore() {
				return shopmodel_txtmore;
			}
			public void setShopmodel_txtmore(String shopmodel_txtmore) {
				this.shopmodel_txtmore = shopmodel_txtmore;
			}
			public Date getShopmodel_createdate() {
				return shopmodel_createdate;
			}
			public void setShopmodel_createdate(Date shopmodel_createdate) {
				this.shopmodel_createdate = shopmodel_createdate;
			}
			public Long getShopmodel_gdsnum() {
				return shopmodel_gdsnum;
			}
			public void setShopmodel_gdsnum(Long shopmodel_gdsnum) {
				this.shopmodel_gdsnum = shopmodel_gdsnum;
			}
			 
			
/*
 * create table shopmodel(shopmodel_id int primary key identity(1,1),shopmodel_title varchar(300),shopmodel_type int,shopmodel_content varchar(800),shopmodel_list varchar(800),
shopmodel_size int,shopmodel_flag int,shopmodel_createdate datetime)
 * */

}
