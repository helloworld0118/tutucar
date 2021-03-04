package com.soft.wb.core.Util.model;

import java.util.ArrayList;
import java.util.List;

import com.soft.wb.core.entity.PriceInfo;

public class PriceModel {
	private String type;
	private List<PriceInfo> prices = new ArrayList<PriceInfo>();

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<PriceInfo> getPrices() {
		return prices;
	}

	public void setPrices(List<PriceInfo> prices) {
		this.prices = prices;
	}

}
