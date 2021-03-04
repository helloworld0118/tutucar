package com.soft.wb.core.action;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.cxf.wsdl.TMessage;
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
import com.soft.wb.core.Util.model.PriceModel;
import com.soft.wb.core.dao.CarInfoDao;
import com.soft.wb.core.dao.OrderFormDao;
import com.soft.wb.core.dao.PriceInfoDao;
import com.soft.wb.core.dao.ServiceInfoDao;
import com.soft.wb.core.dao.UserDao;
import com.soft.wb.core.entity.CarInfo;
import com.soft.wb.core.entity.Evaluation;
import com.soft.wb.core.entity.OrderForm;
import com.soft.wb.core.entity.PriceInfo;
import com.soft.wb.core.entity.ServiceInfo;
import com.soft.wb.core.entity.User;
import com.soft.wb.core.entity.UserGroup;
import com.soft.wb.wechat.util.RequestHandler;
import com.soft.wb.wechat.util.ResponseHandler;

@Controller
@Scope("prototype")
public class OrderFormAction extends AbstractAction implements ModelDriven<OrderForm> {
	public static String APP_ID="wx85e4e4dc95cee8b5";
	public static String APP_KEY="4YUfQY9LW7SHOUsr2Wdb5AQTpaDw3L1LOPBGLjb4h1Ru0WXzDnaOfuSre8RoaWz8yqkM1j5Y4NS0xEYeed8CbLUqiEZEtxBNWBJA54PJ1zeooA4H931i6DGK475hjoZn";
	private static String PartnerId="1219807801";
	public static String PartnerKey="fa0504aeaec1a001b1be20d329952fc0";
	private static final long serialVersionUID = 1L;
    private OrderForm orderform=new OrderForm();
    private OrderFormDao orderFormdao;
    private CarInfoDao carinfodao;
    private PriceInfoDao priceinfodao;
	private UserDao userdao;
	private ServiceInfoDao serviceinfodao;
	@Resource
	public void setServiceinfodao(ServiceInfoDao serviceinfodao) {
		this.serviceinfodao = serviceinfodao;
	}

	public OrderForm getOrderform() {
		return orderform;
	}

	public void setOrderform(OrderForm orderform) {
		this.orderform = orderform;
	}
	@Resource
	public void setOrderFormdao(OrderFormDao orderFormdao) {
		this.orderFormdao = orderFormdao;
	}
	@Resource
	public void setPriceinfodao(PriceInfoDao priceinfodao) {
		this.priceinfodao = priceinfodao;
	}
	@Resource
    public void setUserdao(UserDao userdao) {
		this.userdao = userdao;
	}
	@Resource
	public void setCarinfodao(CarInfoDao carinfodao) {
		this.carinfodao = carinfodao;
	}

	@Override
	public OrderForm getModel() {
		// TODO Auto-generated method stub
		return orderform;
	}
	public String go2choiceCar(){
		OrderForm order=(OrderForm) getSession().getAttribute("ordertemp");
	    if(null==order){
		   getSession().setAttribute("ordertemp",orderform);
	    }else{
	    	orderform=order;
	    }
		User user=(User) getSession().getAttribute("tu_user");
		if(null==user){
			getSession().setAttribute("backurl", "orderFormAction!go2choiceCar");
			return "login";
		}
		DetachedCriteria priceCriteria=DetachedCriteria.forClass(PriceInfo.class);
		priceCriteria.createAlias("car", "c");
		System.out.println(orderform.getCount());
		System.out.println(orderform.getService().getId());
		System.out.println(user.getGroup().getPricegroup().getId());
		priceCriteria.add(Restrictions.ge("c.loadCount", orderform.getCount()));
		priceCriteria.add(Restrictions.eq("service", orderform.getService()));
		priceCriteria.add(Restrictions.eq("group", user.getGroup().getPricegroup()));
		priceCriteria.addOrder(Order.asc("price"));
		getSession().setAttribute("orderForm",orderform);
		List<PriceInfo> list=priceinfodao.find(priceCriteria);
		request.setAttribute("carprices", formatPrices(list));
		getSession().removeAttribute("ordertemp");
		return "chioceCar";
	}
	private List<PriceModel> formatPrices(List<PriceInfo> list){
		List<PriceModel> models=new ArrayList<PriceModel>();
		for (PriceInfo price : list) {
			PriceModel model=new PriceModel();
			boolean have=false;
			for (PriceModel priceModel : models) {
				if(priceModel.getType().equals(price.getCar().getType().trim())){
					have=true;
					break;
				}
			}
			if(!have){
				model.setType(price.getCar().getType());
				models.add(model);
			}
		}
		for (PriceInfo price : list) {
			for (PriceModel priceModel : models) {
				if(priceModel.getType().equals(price.getCar().getType().trim())){
				   priceModel.getPrices().add(price);
				}
			}
		}
		return models;
	}
	public void saveAjax() throws Exception{
		try {
			if (orderform.getId() > 0) {
				OrderForm tempOrderForm = orderFormdao.get(orderform.getId());
				int id = tempOrderForm.getId();
				orderform.setCount(tempOrderForm.getCount());
				orderform.setExtraPrice(tempOrderForm.getExtraPrice());
				orderform.setPrice(tempOrderForm.getPrice());
				BeanUtil.copy(orderform, tempOrderForm);
				tempOrderForm.setId(id);
				orderFormdao.save(tempOrderForm);
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"修改成功\"}");
			}else{
				orderform=(OrderForm) getSession().getAttribute("orderForm");
				String carid=request.getParameter("carid");
				String price=request.getParameter("price");
				if(orderform==null){
					getResponse().getWriter().write("{\"success\":false, \"msg\":\"增加失败\"}");
					return;
				}
				User user=(User) getSession().getAttribute("tu_user");
				orderform.setUser(user);
				String code="BJ"+Utils.getCurrentTime()+user.getId();
				orderform.setCode(code);
				orderform.setCar(new CarInfo(Integer.parseInt(carid)));
				orderform.setPrice(Integer.parseInt(price));
				orderform.setCreateDate(Utils.getCurrentTime2());
				orderFormdao.save(orderform);
//				CarInfo carinfo=carinfodao.get(orderform.getCar().getId());
//				orderform.setCar(carinfo);
				//TODO 1、获取用户组 2、获取服务类型，车辆信息， 查询价格 
				getResponse().getWriter().write("{\"success\":true, \"msg\":\"增加成功\" }");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	public String save() throws Exception{
		try {
			if (orderform.getId() > 0) {
				OrderForm tempOrderForm = orderFormdao.get(orderform.getId());
				int id = tempOrderForm.getId();
				BeanUtil.copy(orderform, tempOrderForm);
				tempOrderForm.setId(id);
				orderFormdao.save(tempOrderForm);
				return "updateSuccess";
			}else{
				orderform=(OrderForm) getSession().getAttribute("orderForm");
				String carid=request.getParameter("carid");
				String price=request.getParameter("price");
				if(orderform==null){
					return "initerror";
				}
				User user=(User) getSession().getAttribute("tu_user");
				orderform.setUser(user);
				String code="BJ"+Utils.getCurrentTime()+user.getId();
				orderform.setCode(code);
				orderform.setCar(new CarInfo(Integer.parseInt(carid)));
				orderform.setPrice(Integer.parseInt(price));
				orderform.setCreateDate(Utils.getCurrentTime2());
				orderFormdao.save(orderform);
				orderform=orderFormdao.get(orderform.getId());
				request.setAttribute("APP_ID",APP_ID);
				request.setAttribute("APP_KEY", APP_KEY);
				request.setAttribute("PartnerId", PartnerId);
				request.setAttribute("PartnerKey", PartnerKey);
				request.setAttribute("code",code);
				request.setAttribute("orderId", orderform.getId());
				CarInfo carinfo=carinfodao.get(orderform.getCar().getId());
				orderform.setCar(carinfo);
				ServiceInfo serviceinfo=serviceinfodao.get(orderform.getService().getId());
				request.setAttribute("serviceTitle", serviceinfo.getTitle());
				request.setAttribute("price", price);
				return "ticketconfirm";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return  ERROR;
		}
		
	}
	public String saveMeet(){
		User user=(User) getSession().getAttribute("tu_user");
		if(null==user){
			String username=request.getParameter("username");
			String phone=request.getParameter("phone");
			user=new User();
			user.setUsername(username);
			user.setPhone(phone);
			UserGroup group =new UserGroup();
			group.setId(0);
			user.setGroup(group);
			user.setId(Integer.parseInt(orderFormdao.add(user).toString()));
			orderform.setUser(user);
		}else{
			orderform.setUser(user);
		}
		String code="BJ"+Utils.getCurrentTime()+user.getId();
		orderform.setCode(code);
		orderform.setCreateDate(Utils.getCurrentTime2());
		orderFormdao.save(orderform);
		return "userCenter";
	}
	//增加评价 or 取消订单
	public String addEvalution(){
		OrderForm tempOrderForm = orderFormdao.get(orderform.getId());
		String content=request.getParameter("evacontent");
		String remark=request.getParameter("evaremark");
		Evaluation evaluatio=new Evaluation();
		evaluatio.setContent(content);
		evaluatio.setRemark(remark);
		orderFormdao.add(evaluatio);
		//evaluatio.setId(Integer.parseInt(orderFormdao.add(evaluatio).toString()));
		//int id = tempOrderForm.getId();
		tempOrderForm.setEvaluation(evaluatio);
		//BeanUtil.copy(orderform, tempOrderForm);
		//tempOrderForm.setId(id);
		tempOrderForm.setState(orderform.getState());
		orderFormdao.save(tempOrderForm);
		if(tempOrderForm.getState()==5){
			User user=(User) getSession().getAttribute("tu_user");
			User userTemp=userdao.get(user.getId());
			int score=Integer.parseInt(user.getScore())+5;//加5个积分
			user.setScore(score+"");
			BeanUtil.copy(user,userTemp);
			userdao.save(userTemp);
		}
		return "initerror";
	}
	public String go2confirm(){
		request.getSession().setAttribute("backurl", "userAction!detail");
		orderform = orderFormdao.get(orderform.getId());
		request.setAttribute("APP_ID",APP_ID);
		request.setAttribute("APP_KEY", APP_KEY);
		request.setAttribute("PartnerId", PartnerId);
		request.setAttribute("PartnerKey", PartnerKey);
		request.setAttribute("code",orderform.getCode());
		request.setAttribute("orderId", orderform.getId());
		ServiceInfo serviceinfo=serviceinfodao.get(orderform.getService().getId());
		request.setAttribute("serviceTitle", serviceinfo.getTitle());
		request.setAttribute("price", orderform.getPrice());
		return "ticketconfirm";
	}
	public String go2detail(){
		orderform = orderFormdao.get(orderform.getId());
		return "ticketdetail";
	}
	public String go2evaluation(){
		request.getSession().setAttribute("backurl", "userAction!detail");
		orderform = orderFormdao.get(orderform.getId());
		return "evaluation";
	}
	public void delete() throws Exception{
		try {
			orderform = orderFormdao.get(orderform.getId());
			orderFormdao.delete(orderform);	
			getResponse().getWriter().write("{\"success\":true, \"msg\":\"删除成功\" }");
		} catch (Exception e) {
			e.printStackTrace();
			getResponse().getWriter().write("{\"success\":false, \"msg\":\"删除失败请联系管理员\" }");
		}
	}
	public void getOrderForms() throws Exception{
		DetachedCriteria criteria=DetachedCriteria.forClass(OrderForm.class);
		DetachedCriteria countcriteria=DetachedCriteria.forClass(OrderForm.class);
		long count=orderFormdao.getCount(countcriteria, OrderForm.class);
		List<OrderForm> list=orderFormdao.find(criteria, (page-1)*getRows(), getRows());
		getResponse().getWriter().write(JsonOperate.getpageJson(count, new Gson().toJson(list)));
	}
	public void showOtherInfo() throws Exception{
		orderform = orderFormdao.get(orderform.getId());
		StringBuffer sb=new StringBuffer();
		sb.append("<table class=\"dv-table\" border=\"0\" style=\"width:80%;\">");
		if(orderform.getService().getId()==1){
			// 机场接送
			if(null!=orderform.getExtra2()&&!"".equals(orderform.getExtra2())){
				sb.append("<tr>");
				sb.append("<td class=\"dv-label\">类型</td><td>接机</td>");
				sb.append("<td class=\"dv-label\">航班</td><td>"+orderform.getExtra2()+"-"+orderform.getExtra3()+"</td>");
				sb.append("<td class=\"dv-label\">上车地点</td><td>北京首都机场T"+orderform.getStartAddress()+"航站楼</td>");
				sb.append("</tr>");
				sb.append("<tr>");
				sb.append("<td class=\"dv-label\">用车时间</td><td>"+orderform.getTime()+"</td>");
				sb.append("<td class=\"dv-label\">乘车人数</td><td>"+orderform.getCount()+"人</td>");
				sb.append("<td class=\"dv-label\">补充说明</td><td>"+orderform.getRemark()+"</td>");
				sb.append("</tr>");
			}else{
				sb.append("<tr>");
				sb.append("<td class=\"dv-label\">类型</td><td>送机</td>");
				sb.append("<td class=\"dv-label\">送往机场</td><td>北京首都机场T"+orderform.getEndAddress()+"航站楼</td>");
				sb.append("<td class=\"dv-label\">上车地点</td><td>"+orderform.getStartAddress()+"</td>");
				sb.append("</tr>");
				sb.append("<tr>");
				sb.append("<td class=\"dv-label\">用车时间</td><td>"+orderform.getTime()+"</td>");
				sb.append("<td class=\"dv-label\">乘车人数</td><td>"+orderform.getCount()+"人</td>");
				sb.append("<td class=\"dv-label\">补充说明</td><td>"+orderform.getRemark()+"</td>");
				sb.append("</tr>");
			}
			
		}else if(orderform.getService().getId()==2){
			//点到点
			sb.append("<tr>");
			sb.append("<td class=\"dv-label\">用车时间</td><td>"+orderform.getTime()+"</td>");
			sb.append("<td class=\"dv-label\">上车地点</td><td>"+orderform.getStartAddress()+"</td>");
			sb.append("<td class=\"dv-label\">地点补充</td><td>"+orderform.getExtra()+"</td>");
			sb.append("</tr>");
			sb.append("<tr>");
			sb.append("<td class=\"dv-label\">乘车人数</td><td>"+orderform.getCount()+"人</td>");
			sb.append("<td class=\"dv-label\">下车地点</td><td>"+orderform.getEndAddress()+"</td>");
			sb.append("<td class=\"dv-label\">预估时间</td><td>"+orderform.getEstimateTime()+"小时</td>");
			sb.append("</tr>");
		}else if(orderform.getService().getId()==3||orderform.getService().getId()==4||orderform.getService().getId()==5){
			//半天包车,全天包车,郊区包车
			sb.append("<tr>");
			sb.append("<td class=\"dv-label\">用车时间</td><td>"+orderform.getTime()+"</td>");
			sb.append("<td class=\"dv-label\">上车地点</td><td>"+orderform.getStartAddress()+"</td>");
			sb.append("<td class=\"dv-label\">地点补充</td><td>"+orderform.getExtra()+"</td>");
			sb.append("</tr>");
			sb.append("<tr>");
			sb.append("<td class=\"dv-label\">乘车人数</td><td>"+orderform.getCount()+"人</td>");
			sb.append("<td class=\"dv-label\">下车地点</td><td>"+orderform.getEndAddress()+"</td>");
			sb.append("<td class=\"dv-label\">&nbsp;</td><td>&nbsp;</td>");
			sb.append("</tr>");
		}else if(orderform.getService().getId()==6||orderform.getService().getId()==7){
			//会议用车,长租服务
			sb.append("<tr>");
			sb.append("<td class=\"dv-label\">用车时间</td><td>"+orderform.getTime()+"</td>");
			sb.append("<td class=\"dv-label\">乘车人数</td><td>"+orderform.getCount()+"人</td>");
			sb.append("</tr>");
			sb.append("<tr>");
			sb.append("<td class=\"dv-label\">联 系 人</td><td>"+orderform.getUser().getUsername()+"</td>");
			sb.append("<td class=\"dv-label\">联系电话</td><td>"+orderform.getUser().getPhone()+"</td>");
			sb.append("</tr>");
		}
		if(null!=orderform.getEvaluation()){
			String str="";
			if(orderform.getState()==1){
				str="原因";
			}else{
				str="评价";
			}
			sb.append("<tr>");
			sb.append("<td class=\"dv-label\">"+str+"</td><td>"+orderform.getEvaluation().getContent()+"</td>");
			sb.append("</tr>");
		}
		sb.append("</table>");
		getResponse().getWriter().write(sb.toString());
	}
	//支付成功
	public void paySuccess() throws Exception{
		String orderFormId=request.getParameter("orderId");
		orderform=orderFormdao.get(Integer.parseInt(orderFormId));
		orderform.setState(3);
		orderFormdao.save(orderform);
		User user=(User) getSession().getAttribute("tu_user");
		User userTemp=userdao.get(user.getId());
		int score=Integer.parseInt(user.getScore())+10;//加10个积分
		user.setScore(score+"");
		BeanUtil.copy(user,userTemp);
		userdao.save(userTemp);
	}
	public String sendPaySuccessMsg() throws Exception{
		String code=request.getParameter("code");
		DetachedCriteria criteria=DetachedCriteria.forClass(OrderForm.class);
		criteria.add(Restrictions.eq("code", code));
		OrderForm order=(OrderForm) orderFormdao.find(criteria).get(0);
		User user=(User) getSession().getAttribute("tu_user");
		System.out.println(orderform.getCode()+"======"+order.getId()+"========"+order.getState());
		if(order.getState()==3){
			String PostData = "account=justfun&password=hellobing&mobile="+user.getPhone().trim()+"&content="+URLEncoder.encode("您的订单编码："+order.getCode()+"。如需帮助请联系客服。","utf-8");
			String ret =Utils.SMS(PostData, "http://sms.106jiekou.com/utf8/sms.aspx");
			System.out.println(ret);
		}
		return "userCenter";
	}
}
