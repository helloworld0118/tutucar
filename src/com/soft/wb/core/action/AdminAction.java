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
import com.soft.wb.core.dao.AdminDao;
import com.soft.wb.core.entity.Admin;

@Controller
@Scope("prototype")
public class AdminAction extends AbstractAction implements ModelDriven<Admin> {
	private static final long serialVersionUID = 1L;
	private Admin admin = new Admin();
	public Admin getAdmin() {
		return admin;
	}
	public void setAdmin(Admin admin) {
		this.admin = admin;
	}
	private AdminDao dao;
	@Resource
	public void setDao(AdminDao dao) {
		this.dao = dao;
	}
	public void getAdmins() throws Exception{
		DetachedCriteria criteria=DetachedCriteria.forClass(Admin.class);
		DetachedCriteria countcriteria=DetachedCriteria.forClass(Admin.class);
		long count=dao.getCount(countcriteria, Admin.class);
		List<Admin> list=dao.find(criteria, (page-1)*getRows(), getRows());
		getResponse().getWriter().write(JsonOperate.getpageJson(count, new Gson().toJson(list)));
	}

	public void save() throws Exception{
		try {
			if (admin.getId() > 0) {
				Admin tempAdmin = dao.get(admin.getId());
				int id = tempAdmin.getId();
				BeanUtil.copy(admin, tempAdmin);
				tempAdmin.setId(id);
				dao.save(tempAdmin);
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"修改成功\" }");
			}else{
				dao.save(admin);
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"增加成功\" }");
			}
		} catch (Exception e) {
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"操作失败请联系管理员\" }");
		}
		
	}
	
	public void delete() throws Exception{
		try {
			admin = dao.get(admin.getId());
			dao.delete(admin);	
			getResponse().getWriter().write("{\"success\":true, \"msg\":\"删除成功\" }");
		} catch (Exception e) {
			e.printStackTrace();
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"删除失败请联系管理员\" }");
		}
	}
	public void login() throws Exception{
		DetachedCriteria criteria=DetachedCriteria.forClass(Admin.class);
		criteria.add(Restrictions.eq("name", admin.getName()));
		criteria.add(Restrictions.eq("password", admin.getPassword()));
		List<Admin> list=dao.find(criteria);
		if(list.size()==0){
			getResponse().getWriter().write("{ \"state\":\"failure\", \"msg\":\"账号与密码不匹配\" }");
		}else{
			getSession().setAttribute("admin", list.get(0));
			getResponse().getWriter().write("{ \"state\":\"success\", \"msg\":\"index.html\" }");
		}
	}
	public String logout(){
    	getSession().removeAttribute("admin");
    	return "logout";
    }
	@Override
	public Admin getModel() {
		// TODO Auto-generated method stub
		return admin;
	}
}
