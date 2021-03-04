

import com.google.gson.Gson;
import com.soft.wb.core.action.OrderFormAction;

public class AccessTokenUtil
{
   public static String getAccessToken(){
       AccessToken atoken=new AccessToken();
        try
        {
            DownloadBillRequestHandler reqHandler = new DownloadBillRequestHandler(null, null);
            TenpayHttpClient httpClient = new TenpayHttpClient();
            reqHandler.init();
            reqHandler.setGateUrl("https://api.weixin.qq.com/cgi-bin/token");
            reqHandler.setParameter("grant_type", "client_credential");
            reqHandler.setParameter("appid",OrderFormAction.APP_ID);  
            reqHandler.setParameter("secret","d9cb4239fae0d562f763b55a3becf862");//d9cb4239fae0d562f763b55a3becf862
            httpClient.setReqContent(reqHandler.getRequestURL());
            System.out.println(reqHandler.getRequestURL());
            httpClient.setMethod("GET");
            if(httpClient.call()) {
                String resContent = httpClient.getResContent();
                Gson json =new Gson();
                atoken= json.fromJson(resContent, AccessToken.class);
                System.out.println(atoken.getAccess_token());
                System.out.println("responseContent:");
                System.out.println(resContent);         
            } else {
                System.out.println("后台调用通信失败");
                System.out.println(httpClient.getResponseCode());
                System.out.println(httpClient.getErrInfo());
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    return atoken.getAccess_token();
       
   }
   public static void main(String[] args)
{
       AccessTokenUtil at=new AccessTokenUtil();
       at.getAccessToken();
}
}
