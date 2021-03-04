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
import com.soft.wb.core.dao.UserGroupDao;
import com.soft.wb.core.entity.User;
import com.soft.wb.core.entity.UserGroup;
import com.soft.wb.core.entity.UserGroup;

@Controller
@Scope("prototype")
public class UserGroupAction extends AbstractAction implements ModelDriven<UserGroup> {
	private UserGroup group=new UserGroup();
	private UserGroupDao dao;
	
	public UserGroup getGroup() {
		return group;
	}

	public void setGroup(UserGroup group) {
		this.group = group;
	}

	public UserGroupDao getDao() {
		return dao;
	}
	@Resource
	public void setDao(UserGroupDao dao) {
		this.dao = dao;
	}

	@Override
	public UserGroup getModel() {
		// TODO Auto-generated method stub
		return group;
	}
	private static final long serialVersionUID = 1L;
	public void getUserGroups() throws Exception{
		DetachedCriteria criteria=DetachedCriteria.forClass(UserGroup.class);
		DetachedCriteria countcriteria=DetachedCriteria.forClass(UserGroup.class);
		long count=dao.getCount(countcriteria, UserGroup.class);
		List<UserGroup> list=dao.find(criteria, (page-1)*getRows(), getRows());
		getResponse().getWriter().write(JsonOperate.getpageJson(count, new Gson().toJson(list)));
	}
	public void save() throws Exception{
		try {
			if (group.getId() > 0) {
				UserGroup tempUserGroup = dao.get(group.getId());
				int id = tempUserGroup.getId();
				BeanUtil.copy(group, tempUserGroup);
				tempUserGroup.setId(id);
				dao.save(tempUserGroup);
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
