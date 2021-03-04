package com.soft.wb.wechat.action;

import java.util.Date;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.soft.core.action.AbstractAction;

@Controller
@Scope("prototype")
public class WarningAction extends AbstractAction {

	private static final long serialVersionUID = 1L;

	public void init() throws Exception {
		if ("POST".equals(request.getMethod())) {
			response.getWriter().print("success");
		}
	}
}
