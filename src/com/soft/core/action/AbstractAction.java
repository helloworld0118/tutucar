package com.soft.core.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;

public abstract class AbstractAction extends ActionSupport implements ServletRequestAware, ServletResponseAware {

	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected int page;
	protected int rows;
	protected String query;

	public HttpServletResponse getResponse() {
		response.setContentType("text/html;charset=UTF-8");
		return response;
	}
	public HttpSession getSession() {
		return request.getSession();
	}
	public String getQuery() {
		return query;
	}

	public void setQuery(String query) {
		this.query = query;
	}
	
	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}	
	
//	protected UserInfo getCurrentUser() {
//		return (UserInfo) ActionContext.getContext().getSession().get(SystemConstant.CURRENT_USER);
//	}
	
}
