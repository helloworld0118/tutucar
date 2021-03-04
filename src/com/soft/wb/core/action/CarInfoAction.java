package com.soft.wb.core.action;


import java.util.List;

import javax.annotation.Resource;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ModelDriven;
import com.soft.core.action.AbstractAction;
import com.soft.core.utils.BeanUtil;
import com.soft.core.utils.JsonOperate;
import com.soft.wb.core.dao.CarInfoDao;
import com.soft.wb.core.entity.Admin;
import com.soft.wb.core.entity.CarInfo;
import com.soft.wb.core.entity.PriceInfo;
import com.soft.wb.core.entity.ServiceInfo;
import com.soft.wb.core.entity.User;

@Controller
@Scope("prototype")
public class CarInfoAction extends AbstractAction implements ModelDriven<CarInfo> {

	private static final long serialVersionUID = 1L;
	private CarInfo car=new CarInfo();
	private CarInfoDao dao;
	private PriceInfo price;
	public PriceInfo getPrice() {
		return price;
	}

	public void setPrice(PriceInfo price) {
		this.price = price;
	}

	public CarInfo getCar() {
		return car;
	}

	public void setCar(CarInfo car) {
		this.car = car;
	}

	public CarInfoDao getDao() {
		return dao;
	}
	@Resource
	public void setDao(CarInfoDao dao) {
		this.dao = dao;
	}

	@Override
	public CarInfo getModel() {
		// TODO Auto-generated method stub
		return car;
	}
	public void getCars() throws Exception{
		DetachedCriteria criteria=DetachedCriteria.forClass(CarInfo.class);
		DetachedCriteria countcriteria=DetachedCriteria.forClass(CarInfo.class);
		long count=dao.getCount(countcriteria, CarInfo.class);
		List<CarInfo> list=dao.find(criteria, (page-1)*getRows(), getRows());
		getResponse().getWriter().write(JsonOperate.getpageJson(count, new Gson().toJson(list)));
	}
	public void save() throws Exception{
		try {
			if (car.getId() > 0) {
				CarInfo tempcar = dao.get(car.getId());
				int id = tempcar.getId();
				BeanUtil.copy(car, tempcar);
				tempcar.setId(id);
				dao.save(tempcar);
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"修改成功\" }");
			}else{
				dao.save(car);
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"增加成功\" }");
			}
		} catch (Exception e) {
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"操作失败请联系管理员\" }");
		}
	}
	public void delete() throws Exception{
		try {
			car = dao.get(car.getId());
			dao.delete(car);	
			getResponse().getWriter().write("{\"success\":true, \"msg\":\"删除成功\" }");
		} catch (Exception e) {
			e.printStackTrace();
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"删除失败请联系管理员\" }");
		}
	}
	public String detail(){
	    car = dao.get(car.getId());
	    return "detail";
	}
}
