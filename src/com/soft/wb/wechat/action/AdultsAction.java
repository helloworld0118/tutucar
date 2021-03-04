package com.soft.wb.wechat.action;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.soft.core.action.AbstractAction;
import com.soft.wb.core.action.OrderFormAction;

@Controller
@Scope("prototype")
public class AdultsAction extends AbstractAction {

	private static final long serialVersionUID = 1L;

	public void init() {
		System.out.println("ok");
	}
}
