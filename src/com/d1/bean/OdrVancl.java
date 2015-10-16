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
@Table(name="odrvancl",catalog="dba")
public class OdrVancl extends BaseEntity implements java.io.Serializable {
			/**
			 * version id
			 */
			private static final long serialVersionUID = 1L;
			@Id
			@Column(name="odrvancl_id")
			@GeneratedValue(strategy=GenerationType.IDENTITY)	
			private String id;
			private String odrvancl_odrid;
			private String odrvancl_orderid;
			private String odrvancl_orderdistributetime;
			private String odrvancl_orderstatus; 
			private String odrvancl_orderstatusname;
			private Double odrvancl_totalprice;
			private Double odrvancl_transferprice;
			private Double odrvacl_paidprice;
			private Double odrvancl_unpaidprice;
			private String odrvancl_paymenttype;
			private String odrvancl_needinvoice;
			private String odrvancl_memo;
			
			/*create table odrvancl(odrvancl_id int identity(1,1),odrvancl_odrid char(12),odrvancl_orderid varchar(50),
			odrvancl_orderdistributetime datetime,odrvancl_orderstatus int,odrvancl_orderstatusname varchar(50),
			odrvancl_totalprice float,odrvancl_transferprice float,odrvacl_paidprice float,odrvancl_unpaidprice float,
			odrvancl_paymenttype varchar(50),odrvancl_createdate datetime default(getdate()))
				 * */
			public String getId() {
				return id;
			}
			public void setId(String id) {
				this.id = id;
			}
			public String getOdrvancl_odrid() {
				return odrvancl_odrid;
			}
			public void setOdrvancl_odrid(String odrvancl_odrid) {
				this.odrvancl_odrid = odrvancl_odrid;
			}
			public String getOdrvancl_orderid() {
				return odrvancl_orderid;
			}
			public void setOdrvancl_orderid(String odrvancl_orderid) {
				this.odrvancl_orderid = odrvancl_orderid;
			}
			public String getOdrvancl_orderdistributetime() {
				return odrvancl_orderdistributetime;
			}
			public void setOdrvancl_orderdistributetime(String odrvancl_orderdistributetime) {
				this.odrvancl_orderdistributetime = odrvancl_orderdistributetime;
			}
			public String getOdrvancl_orderstatus() {
				return odrvancl_orderstatus;
			}
			public void setOdrvancl_orderstatus(String odrvancl_orderstatus) {
				this.odrvancl_orderstatus = odrvancl_orderstatus;
			}
			public String getOdrvancl_orderstatusname() {
				return odrvancl_orderstatusname;
			}
			public void setOdrvancl_orderstatusname(String odrvancl_orderstatusname) {
				this.odrvancl_orderstatusname = odrvancl_orderstatusname;
			}
			public Double getOdrvancl_totalprice() {
				return odrvancl_totalprice;
			}
			public void setOdrvancl_totalprice(Double odrvancl_totalprice) {
				this.odrvancl_totalprice = odrvancl_totalprice;
			}
			public Double getOdrvancl_transferprice() {
				return odrvancl_transferprice;
			}
			public void setOdrvancl_transferprice(Double odrvancl_transferprice) {
				this.odrvancl_transferprice = odrvancl_transferprice;
			}
			public Double getOdrvacl_paidprice() {
				return odrvacl_paidprice;
			}
			public void setOdrvacl_paidprice(Double odrvacl_paidprice) {
				this.odrvacl_paidprice = odrvacl_paidprice;
			}
			public Double getOdrvancl_unpaidprice() {
				return odrvancl_unpaidprice;
			}
			public void setOdrvancl_unpaidprice(Double odrvancl_unpaidprice) {
				this.odrvancl_unpaidprice = odrvancl_unpaidprice;
			}
			public String getOdrvancl_paymenttype() {
				return odrvancl_paymenttype;
			}
			public void setOdrvancl_paymenttype(String odrvancl_paymenttype) {
				this.odrvancl_paymenttype = odrvancl_paymenttype;
			}
			public String getOdrvancl_needinvoice() {
				return odrvancl_needinvoice;
			}
			public void setOdrvancl_needinvoice(String odrvancl_needinvoice) {
				this.odrvancl_needinvoice = odrvancl_needinvoice;
			}
			public String getOdrvancl_memo() {
				return odrvancl_memo;
			}
			public void setOdrvancl_memo(String odrvancl_memo) {
				this.odrvancl_memo = odrvancl_memo;
			}
}
