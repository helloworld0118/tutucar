package com.soft.wb.wechat.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.soft.core.action.AbstractAction;
import com.soft.wb.wechat.service.CoreService;
import com.soft.wb.wechat.util.SHA1;
@Controller
@Scope("prototype")
public class WechatAction extends AbstractAction {
	private String TOKEN = "tutucarweixin";
	private static final String GET = "GET";
	public void init() throws IOException {
		if (GET.equals(request.getMethod())) {
            //get
			System.out.println("doget");
            doget();
        }else {
        	System.out.println("dopost");
        	dopost();
        }
		
	}
	private void doget(){
		String signature = request.getParameter("signature");
		String echostr = request.getParameter("echostr");
		String timestamp = request.getParameter("timestamp");
		String nonce = request.getParameter("nonce");

		String[] str = { TOKEN, timestamp, nonce };
		Arrays.sort(str); 
		String bigStr = str[0] + str[1] + str[2];
		String digest = new SHA1().getDigestOfString(bigStr.getBytes())
				.toLowerCase();
		if (digest.equals(signature)) {
			try {
				getResponse().getWriter().print(echostr);
			} catch (IOException e) {
			}
		}
	}
	private void dopost(){
		String respMessage = CoreService.processRequest(request);  
        PrintWriter out=null;
		try {
			out = getResponse().getWriter();
			out.print(respMessage);  
		    out.close(); 
		} catch (IOException e) {
			e.printStackTrace();
		}  
        
	}
}
