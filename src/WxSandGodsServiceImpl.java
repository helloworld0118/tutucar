

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.google.gson.Gson;
import com.soft.wb.core.action.OrderFormAction;

@Service
public class WxSandGodsServiceImpl 
{
	public static void main(String[] args) throws Exception {
	 	getDelivernotify("1219807801201407213161718652","oPOZiuJ6s55J3UljRYcuRQux5mIM","BJ201407220124523");
	}
    public static String getDelivernotify(String transid, String openid, String threeTradeNo) throws Exception
    {
        AccessTokenUtil at=new AccessTokenUtil();
        String timestamp = Long.toString(System.currentTimeMillis()/1000);
        WxPayHelper WxPayHelper = new WxPayHelper();
        HashMap<String, String> bizObj = new HashMap<String, String>();
        bizObj.put("appid", OrderFormAction.APP_ID);
        bizObj.put("openid", openid);
        bizObj.put("transid", transid);
        bizObj.put("out_trade_no", threeTradeNo);
        bizObj.put("deliver_timestamp", timestamp);
        bizObj.put("deliver_status", "1");//TODO 0表示失败，1是成功
        bizObj.put("deliver_msg", "ok");
        String app_signature = WxPayHelper.GetBizSign(bizObj);
        bizObj.put("sign_method", "sha1");
        bizObj.put("app_signature", app_signature);
        String info="error";
        String token=at.getAccessToken();
        try{  
            URL url = new URL("https://api.weixin.qq.com/pay/delivernotify?access_token="+token);  
            URLConnection urlConnection = url.openConnection();  
            urlConnection.setDoOutput(true);  
            urlConnection.setRequestProperty("content-type", "application/x-www-form-urlencoded");  
            OutputStreamWriter out = new OutputStreamWriter(urlConnection.getOutputStream());  
            out.write(new Gson().toJson(bizObj));  
            out.flush();  
            out.close();  
            InputStream inputStream = urlConnection.getInputStream();  
            String encoding = urlConnection.getContentEncoding();  
            info = IOUtils.toString(inputStream, encoding);  
            System.out.println(info);  
        }catch(IOException e){  
            
            e.printStackTrace();
        }  
        return info;
    }


}
