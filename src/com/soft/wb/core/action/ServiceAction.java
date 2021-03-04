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
import com.soft.wb.core.dao.ServiceInfoDao;
import com.soft.wb.core.entity.ServiceInfo;

@Controller
@Scope("prototype")
public class ServiceAction extends AbstractAction implements ModelDriven<ServiceInfo>{

	private static final long serialVersionUID = 1L;
	private ServiceInfo service=new ServiceInfo();
	private ServiceInfoDao dao;
	
	public ServiceInfo getService() {
		return service;
	}

	public void setService(ServiceInfo service) {
		this.service = service;
	}

	public ServiceInfoDao getDao() {
		return dao;
	}
	@Resource
	public void setDao(ServiceInfoDao dao) {
		this.dao = dao;
	}

	@Override
	public ServiceInfo getModel() {
		// TODO Auto-generated method stub
		return service;
	}
	public void getServices() throws Exception{
		DetachedCriteria criteria=DetachedCriteria.forClass(ServiceInfo.class);
		DetachedCriteria countcriteria=DetachedCriteria.forClass(ServiceInfo.class);
		long count=dao.getCount(countcriteria, ServiceInfo.class);
		List<ServiceInfo> list=dao.find(criteria, (page-1)*getRows(), getRows());
		getResponse().getWriter().write(JsonOperate.getpageJson(count, new Gson().toJson(list)));
	}

	public void save() throws Exception{
		try {
			if (service.getId() > 0) {
				ServiceInfo tempServiceInfo = dao.get(service.getId());
				int id = tempServiceInfo.getId();
				BeanUtil.copy(service, tempServiceInfo);
				tempServiceInfo.setId(id);
				dao.save(tempServiceInfo);
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"修改成功\" }");
			}else{
				dao.save(service);
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"增加成功\" }");
			}
		} catch (Exception e) {
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"操作失败请联系管理员\" }");
		}
		
	}
	
	public void delete() throws Exception{
		try {
			service = dao.get(service.getId());
			dao.delete(service);	
			getResponse().getWriter().write("{\"success\":true, \"msg\":\"删除成功\" }");
		} catch (Exception e) {
			e.printStackTrace();
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"删除失败请联系管理员\" }");
		}
	}
}
