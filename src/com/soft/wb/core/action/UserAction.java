package com.soft.wb.core.action;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ModelDriven;
import com.soft.core.action.AbstractAction;
import com.soft.core.utils.BeanUtil;
import com.soft.core.utils.JsonOperate;
import com.soft.wb.core.Util.Utils;
import com.soft.wb.core.dao.OrderFormDao;
import com.soft.wb.core.dao.UserDao;
import com.soft.wb.core.entity.OrderForm;
import com.soft.wb.core.entity.User;

@Controller
@Scope("prototype")
public class UserAction extends AbstractAction implements ModelDriven<User> {
	private static final long serialVersionUID = 1L;
	private User user=new User();
	private UserDao dao;
	private OrderFormDao orderformDao;
	
	@Resource
	public void setDao(UserDao dao) {
		this.dao = dao;
	}
	@Resource
	public void setOrderformDao(OrderFormDao orderformDao) {
		this.orderformDao = orderformDao;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public User getUser() {
		return user;
	}
	@Override
	public User getModel() {
		return user;
	}
	public String register() {
		dao.save(user);
		return "registerSuccess";
	}
	public String updatePwd() throws Exception {
		DetachedCriteria criteria=DetachedCriteria.forClass(User.class);
		criteria.add(Restrictions.eq("phone", user.getPhone()));
		User tempUser=(User) dao.find(criteria).get(0);
		tempUser.setPassword(user.getPassword());
		dao.save(tempUser);
		String PostData = "account=justfun&password=hellobing&mobile="+user.getPhone().trim()+"&content="+URLEncoder.encode("您的用户名："+user.getPhone()+"，密码已修改，新密码："+user.getPassword()+"。请牢记新密码！","utf-8");
		String ret =Utils.SMS(PostData, "http://sms.106jiekou.com/utf8/sms.aspx");
		System.out.println(ret);
		return "registerSuccess";
	}
	public void isVildate() throws Exception{
		String code=(String) getSession().getAttribute("code");
		String pcode=request.getParameter("code");
		System.out.println(code);
		System.out.println(pcode);
		if(code.trim().equals(pcode)){
			getResponse().getWriter().write("{\"success\":true, \"msg\":\"updatePwd.jsp\" }");
		}else{
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"验证码不匹配\" }");
		}
	}
    public String logout(){
    	getSession().removeAttribute("tu_user");
    	return SUCCESS;
    }
	public String login() {
		String userinfo = request.getParameter("userinfo");
		String password = request.getParameter("password");
		DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
		if(null==userinfo||"".equals(userinfo)||null==password||"".equals(password)){
			return ERROR;
		}
		if (userinfo.indexOf("@") >= 0) {
			criteria.add(Restrictions.eq("email", userinfo));
		} else {
			criteria.add(Restrictions.eq("phone", userinfo));
		}
		User user = (User) dao.find(criteria).get(0);
		if (null == user) {
			request.setAttribute("error", "没有该账号");
			return ERROR;
		} else if (!user.getPassword().equals(password.trim())) {
			request.setAttribute("error", "账号与密码不匹配");
			return ERROR;
		} else {
			getSession().setAttribute("tu_user", user);
			return "loginSuccess";
		}
	}
	public void getUsers() throws Exception{
		DetachedCriteria criteria=DetachedCriteria.forClass(User.class);
		DetachedCriteria countcriteria=DetachedCriteria.forClass(User.class);
		long count=dao.getCount(countcriteria, User.class);
		List<User> list=dao.find(criteria, (page-1)*getRows(), getRows());
		getResponse().getWriter().write(JsonOperate.getpageJson(count, new Gson().toJson(list)));
	}
	public void save() throws Exception{
		try {
			if (user.getId() > 0) {
				User tempUser = dao.get(user.getId());
				int id = tempUser.getId();
				BeanUtil.copy(user, tempUser);
				tempUser.setId(id);
				dao.save(tempUser);
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"修改成功\" }");
			}else{
				dao.save(user);
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"增加成功\" }");
			}
		} catch (Exception e) {
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"操作失败请联系管理员\" }");
		}
		
	}
	
	public void delete() throws Exception{
		try {
			user = dao.get(user.getId());
			dao.delete(user);	
			getResponse().getWriter().write("{\"success\":true, \"msg\":\"删除成功\" }");
		} catch (Exception e) {
			e.printStackTrace();
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"删除失败请联系管理员\" }");
		}
	}
  public String detail(){
	  user=(User) getSession().getAttribute("tu_user");
	  if(null==user){
			getSession().setAttribute("backurl", "userAction!detail");
			return "error";
	  }
	  DetachedCriteria criteria=DetachedCriteria.forClass(OrderForm.class);
	  criteria.add(Restrictions.eq("user", user));
	  criteria.addOrder(Order.desc("createDate"));
	  List<OrderForm> list=orderformDao.find(criteria);
	  request.setAttribute("orderFormList", list);
	  return "detail";
  }
  public void forgetRegisterMsg() throws Exception{
		String phone=request.getParameter("phoneNum");
		DetachedCriteria criteria=DetachedCriteria.forClass(User.class);
		criteria.add(Restrictions.eq("phone", phone));
		int size=dao.find(criteria).size();
		if(size<0){
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"该手机号未经注册\"}");
			return;
		}else{
			double count=Math.random()*9000+1000;
			int code=(int) count;
			String PostData = "account=justfun&password=hellobing&mobile="+user.getPhone().trim()+"&content="+URLEncoder.encode("您的验证码是："+code+"。请不要把验证码泄露给其他人。如非本人操作，可不用理会！","utf-8");
			String ret =Utils.SMS(PostData, "http://sms.106jiekou.com/utf8/sms.aspx");
			getSession().removeAttribute("sendcount");
			String index=(String) getSession().getAttribute("sendcount");
			if(null!=index&&!"".equals(index)){
				int i=Integer.parseInt(index);
				if(i>3){
					getResponse().getWriter().write("{\"success\":false, \"msg\":\"该号码发送太频繁\" }");
					return;
				}else{
					i++;
					getSession().setAttribute("sendcount",i+"");
				}
			}else{
				getSession().setAttribute("sendcount",1+"");
			}
			if(ret.trim().equals("100")){
				getSession().setAttribute("code", code+"");
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"发送成功\" }");
			}else if(ret.trim().equals("102")){
				getResponse().getWriter().write("{\"success\":false, \"msg\":\"手机号错误\" }");
			}else if(ret.trim().equals("108")){
				getResponse().getWriter().write("{\"success\":false, \"msg\":\"该号码发送太频繁\" }");
			}else{
				getResponse().getWriter().write("{\"success\":false, \"msg\":\"系统升级中，稍后再试\" }");
			}
		}
  }
  public void sendRegisterMsg() throws Exception{
	String phone=request.getParameter("phoneNum");
	DetachedCriteria criteria=DetachedCriteria.forClass(User.class);
	criteria.add(Restrictions.eq("phone", phone));
	int size=dao.find(criteria).size();
	if(size>0){
		getResponse().getWriter().write("{\"success\":false, \"msg\":\"该手机号已被注册\"}");
		return;
	}
	double count=Math.random()*9000+1000;
	int code=(int) count;
	String PostData = "account=justfun&password=hellobing&mobile="+phone+"&content="+URLEncoder.encode("您的验证码是："+code+"。请不要把验证码泄露给其他人。如非本人操作，可不用理会！","utf-8");
	String ret =Utils.SMS(PostData, "http://sms.106jiekou.com/utf8/sms.aspx");
	getSession().removeAttribute("sendcount");
	String index=(String) getSession().getAttribute("sendcount");
	if(null!=index&&!"".equals(index)){
		int i=Integer.parseInt(index);
		if(i>3){
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"该号码发送太频繁\" }");
			return;
		}else{
			i++;
			getSession().setAttribute("sendcount",i+"");
		}
	}else{
		getSession().setAttribute("sendcount",1+"");
	}
	if(ret.trim().equals("100")){
		getSession().setAttribute("code", code+"");
		getResponse().getWriter().write("{\"success\":true, \"msg\":\"发送成功\" }");
	}else if(ret.trim().equals("102")){
		getResponse().getWriter().write("{\"success\":false, \"msg\":\"手机号错误\" }");
	}else if(ret.trim().equals("108")){
		getResponse().getWriter().write("{\"success\":false, \"msg\":\"该号码发送太频繁\" }");
	}else{
		getResponse().getWriter().write("{\"success\":false, \"msg\":\"系统升级中，稍后再试\" }");
	}
  }
}
