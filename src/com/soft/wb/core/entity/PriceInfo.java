package com.soft.wb.core.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "tu_price", catalog = "tutucar")
public class PriceInfo {
	private int id;
	private int price;
	private CarInfo car;
	private ServiceInfo service;
	private int timeoutPrice;
	private int kmoutPrice;
	private PriceGroup group;
	private String remark;
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "id", unique = true, nullable = false)
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	@ManyToOne
	@JoinColumn(name="car_id")
	public CarInfo getCar() {
		return car;
	}

	public void setCar(CarInfo car) {
		this.car = car;
	}
	@ManyToOne
	@JoinColumn(name="service_id")
	public ServiceInfo getService() {
		return service;
	}

	public void setService(ServiceInfo service) {
		this.service = service;
	}

	public int getTimeoutPrice() {
		return timeoutPrice;
	}

	public void setTimeoutPrice(int timeoutPrice) {
		this.timeoutPrice = timeoutPrice;
	}

	public int getKmoutPrice() {
		return kmoutPrice;
	}

	public void setKmoutPrice(int kmoutPrice) {
		this.kmoutPrice = kmoutPrice;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	@ManyToOne
	@JoinColumn(name="group_id")
	public PriceGroup getGroup() {
		return group;
	}

	public void setGroup(PriceGroup group) {
		this.group = group;
	}
	
}
