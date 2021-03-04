package com.soft.wb.wechat.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.soft.wb.wechat.model.Button;
import com.soft.wb.wechat.model.CommonButton;
import com.soft.wb.wechat.model.ComplexButton;
import com.soft.wb.wechat.model.Menu;
import com.soft.wb.wechat.model.ViewButton;
import com.soft.wb.wechat.util.AccessToken;
import com.soft.wb.wechat.util.WeixinUtil;


/**
 * 菜单管理器类
 * 
 * @author wangbing 
 * @date 2014-05-12 
 */
public class MenuManager {

	public static void main(String[] args) {
		// 第三方用户唯一凭证
		String appId = "wx85e4e4dc95cee8b5";
		// 第三方用户唯一凭证密钥
		String appSecret = "d9cb4239fae0d562f763b55a3becf862";

		// 调用接口获取access_token
		AccessToken at = WeixinUtil.getAccessToken(appId, appSecret);
		if (null != at) {
			// 调用接口创建菜单
			int result = WeixinUtil.createMenu(getMenu(), at.getToken());
			// 判断菜单创建结果
			if (0 == result)
				System.out.println("创建成功");
			else
				System.out.println("菜单创建失败，错误码：" + result);
		}
	}

	/**
	 * 组装菜单数据
	 * 
	 * @return
	 */
	private static Menu getMenu() {
//		CommonButton btn11 = new CommonButton();
//		btn11.setName("");
//		btn11.setType("click");
//		btn11.setKey("11");
		ViewButton btn11 = new ViewButton();
		btn11.setName("快速订车");
		btn11.setType("view");
		btn11.setUrl("http://112.253.28.19/weixin01/show.html");
		CommonButton btn12 = new CommonButton();
		btn12.setName("车看车型");
		btn12.setType("click");
		btn12.setKey("12");

		CommonButton btn13 = new CommonButton();
		btn13.setName("长租服务");
		btn13.setType("click");
		btn13.setKey("13");

		CommonButton btn14 = new CommonButton();
		btn14.setName("我的通途");
		btn14.setType("click");
		btn14.setKey("14");
		
		CommonButton btn15 = new CommonButton();
		btn15.setName("联系我们");
		btn15.setType("click");
		btn15.setKey("15");

//		CommonButton btn21 = new CommonButton();
//		btn21.setName("歌曲点播");
//		btn21.setType("click");
//		btn21.setKey("21");
//
//		CommonButton btn22 = new CommonButton();
//		btn22.setName("经典游戏");
//		btn22.setType("click");
//		btn22.setKey("22");
//
//		CommonButton btn23 = new CommonButton();
//		btn23.setName("美女电台");
//		btn23.setType("click");
//		btn23.setKey("23");
//
//		CommonButton btn24 = new CommonButton();
//		btn24.setName("人脸识别");
//		btn24.setType("click");
//		btn24.setKey("24");
//
//		CommonButton btn25 = new CommonButton();
//		btn25.setName("聊天唠嗑");
//		btn25.setType("click");
//		btn25.setKey("25");
//
//		CommonButton btn31 = new CommonButton();
//		btn31.setName("Q友圈");
//		btn31.setType("click");
//		btn31.setKey("31");
//
//		CommonButton btn33 = new CommonButton();
//		btn33.setName("幽默笑话");
//		btn33.setType("click");
//		btn33.setKey("33");
//		
		CommonButton btn31 = new CommonButton();
		btn31.setName("优惠公告");
		btn31.setType("click");
		btn31.setKey("31");
		
		CommonButton btn32 = new CommonButton();
		btn32.setName("意见反馈");
		btn32.setType("click");
		btn32.setKey("32");
		ComplexButton mainBtn1 = new ComplexButton();
		mainBtn1.setName("车辆预定");
		mainBtn1.setSub_button(new Button[] { btn11, btn12, btn13 ,btn14,btn15});
		ViewButton btn2= new ViewButton();
		btn2.setName("通途品牌");
		btn2.setType("view");
		btn2.setUrl("http://www.tutucar.com/invitation/");
		ComplexButton mainBtn3 = new ComplexButton();
		mainBtn3.setName("优惠公告");
		mainBtn3.setSub_button(new Button[] { btn31, btn32});
		Menu menu = new Menu();
		menu.setButton(new Button[] { mainBtn1, btn2, mainBtn3 });

		return menu;
	}
}