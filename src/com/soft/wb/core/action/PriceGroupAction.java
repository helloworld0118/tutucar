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
import com.soft.wb.core.dao.PriceGroupDao;
import com.soft.wb.core.entity.PriceGroup;

@Controller
@Scope("prototype")
public class PriceGroupAction extends AbstractAction  implements ModelDriven<PriceGroup>{
	private static final long serialVersionUID = 1L;
    private PriceGroup group=new PriceGroup();
    private PriceGroupDao dao;
	public PriceGroup getGroup() {
		return group;
	}
	public void setGroup(PriceGroup group) {
		this.group = group;
	}
	public PriceGroupDao getDao() {
		return dao;
	}
	@Resource
	public void setDao(PriceGroupDao dao) {
		this.dao = dao;
	}
	@Override
	public PriceGroup getModel() {
		// TODO Auto-generated method stub
		return group;
	}
	public void getPriceGroups() throws Exception{
		DetachedCriteria criteria=DetachedCriteria.forClass(PriceGroup.class);
		DetachedCriteria countcriteria=DetachedCriteria.forClass(PriceGroup.class);
		long count=dao.getCount(countcriteria, PriceGroup.class);
		List<PriceGroup> list=dao.find(criteria, (page-1)*getRows(), getRows());
		getResponse().getWriter().write(JsonOperate.getpageJson(count, new Gson().toJson(list)));
	}
	public void save() throws Exception{
		try {
			if (group.getId() > 0) {
				PriceGroup tempcar = dao.get(group.getId());
				int id = tempcar.getId();
				BeanUtil.copy(group, tempcar);
				tempcar.setId(id);
				dao.save(tempcar);
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"修改成功\" }");
			}else{
				dao.save(group);
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"增加成功\" }");
			}
		} catch (Exception e) {
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"操作失败请联系管理员\" }");
		}
	}
	public void delete() throws Exception{
		try {
			group = dao.get(group.getId());
			dao.delete(group);	
			getResponse().getWriter().write("{\"success\":true, \"msg\":\"删除成功\" }");
		} catch (Exception e) {
			e.printStackTrace();
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"删除失败请联系管理员\" }");
		}
	}
}
