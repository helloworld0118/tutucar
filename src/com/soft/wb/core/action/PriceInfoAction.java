package com.soft.wb.core.action;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ModelDriven;
import com.soft.core.action.AbstractAction;
import com.soft.core.utils.BeanUtil;
import com.soft.core.utils.JsonOperate;
import com.soft.wb.core.dao.PriceInfoDao;
import com.soft.wb.core.entity.Admin;
import com.soft.wb.core.entity.PriceGroup;
import com.soft.wb.core.entity.PriceInfo;

@Controller
@Scope("prototype")
public class PriceInfoAction extends AbstractAction  implements ModelDriven<PriceInfo> {
	private static final long serialVersionUID = 1L;
    private PriceInfo price=new PriceInfo();
    private PriceInfoDao dao;
    
	public PriceInfo getPrice() {
		return price;
	}

	public void setPrice(PriceInfo price) {
		this.price = price;
	}

	public PriceInfoDao getDao() {
		return dao;
	}
	@Resource
	public void setDao(PriceInfoDao dao) {
		this.dao = dao;
	}

	@Override
	public PriceInfo getModel() {
		// TODO Auto-generated method stub
		return price;
	}
	public void getPrices() throws Exception{
		DetachedCriteria criteria=DetachedCriteria.forClass(PriceInfo.class);
		DetachedCriteria countcriteria=DetachedCriteria.forClass(PriceInfo.class);
		long count=dao.getCount(countcriteria, PriceInfo.class);
		List<PriceInfo> list=dao.find(criteria, (page-1)*getRows(), getRows());
		getResponse().getWriter().write(JsonOperate.getpageJson(count, new Gson().toJson(list)));
	}

	public void save() throws Exception{
		try {
			if (price.getId() > 0) {
				PriceInfo tempprice = dao.get(price.getId());
				int id = tempprice.getId();
				BeanUtil.copy(price, tempprice);
				tempprice.setId(id);
				dao.save(tempprice);
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"修改成功\" }");
			}else{
				dao.save(price);
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"增加成功\" }");
			}
		} catch (Exception e) {
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"操作失败请联系管理员\" }");
		}
		
	}
	
	public void delete() throws Exception{
		try {
			price = dao.get(price.getId());
			dao.delete(price);	
			getResponse().getWriter().write("{\"success\":true, \"msg\":\"删除成功\" }");
		} catch (Exception e) {
			e.printStackTrace();
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"删除失败请联系管理员\" }");
		}
	}
}
