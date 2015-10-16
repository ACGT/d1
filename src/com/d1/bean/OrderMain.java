package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ��������
 * @author kk
 *
 */
@Entity
@Table(name="odrmst")
public class OrderMain extends OrderBase implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="odrmst_odrid") 
	private String id;//done

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
