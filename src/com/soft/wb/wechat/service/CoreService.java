package com.soft.wb.wechat.service;
import java.util.ArrayList;
import java.util.Date;  
import java.util.List;
import java.util.Map;  

import javax.servlet.http.HttpServletRequest;  

import org.springframework.stereotype.Service;

import com.soft.wb.wechat.model.TextMessage;
import com.soft.wb.wechat.util.MessageDealUtil;


  
  
/** 
 * 核心服务类 
 *  
 * @author wangbing 
 * @date 2014-05-12 
 */  
public class CoreService {  
    /** 
     * 处理微信发来的请求 
     *  
     * @param request 
     * @return 
     */  
    public static String processRequest(HttpServletRequest request) {  
        String respMessage = null;  
        try {  
            // 默认返回的文本消息内容  
            String respContent = null;  
            // xml请求解析  
            Map<String, String> requestMap = MessageDealUtil.parseXml(request);  
  
            // 发送方帐号（open_id）  
            String fromUserName = requestMap.get("FromUserName");  
            // 公众帐号  
            String toUserName = requestMap.get("ToUserName");  
            // 消息类型  
            String msgType = requestMap.get("MsgType");  
            // 回复文本消息  
            TextMessage textMessage = new TextMessage();  
            textMessage.setToUserName(fromUserName);  
            textMessage.setFromUserName(toUserName);  
            textMessage.setCreateTime(new Date().getTime());  
            textMessage.setMsgType(MessageDealUtil.RESP_MESSAGE_TYPE_TEXT);  
            //textMessage.setFuncFlag(0);  
  
            // 文本消息  
         if (msgType.equals(MessageDealUtil.REQ_MESSAGE_TYPE_TEXT)) { 
        	 String content = requestMap.get("Content");
        	 if(content.equalsIgnoreCase("home")){
        		 respContent = "http://112.253.28.19:8080/tutucar/"; 
        	 } 
         }
//            	 String content = requestMap.get("Content");  
//            	  
//                 // 创建图文消息  
//                 NewsMessage newsMessage = new NewsMessage();  
//                 newsMessage.setToUserName(fromUserName);  
//                 newsMessage.setFromUserName(toUserName);  
//                 newsMessage.setCreateTime(new Date().getTime());  
//                 newsMessage.setMsgType(MessageDealUtil.RESP_MESSAGE_TYPE_NEWS);  
//                 //newsMessage.setFuncFlag(0);  
//                 
//                 List<Article> articleList = new ArrayList<Article>();  
//                 // 单图文消息  
//                 if ("1".equals(content)) {  
//                     Article article = new Article();  
//                     article.setTitle("你不会确定这是什么的！～_～");  
//                     article.setDescription("看也看不懂，听也听不会！理解也理解不了！");  
//                     article.setPicUrl("http://product.chinacache.com/abc.png");  
//                     article.setUrl("http://www.baidu.com");  
//                     articleList.add(article);  
//                     // 设置图文消息个数  
//                     newsMessage.setArticleCount(articleList.size());  
//                     // 设置图文消息包含的图文集合  
//                     newsMessage.setArticles(articleList);  
//                     // 将图文消息对象转换成xml字符串  
//                     respMessage = MessageDealUtil.newsMessageToXml(newsMessage);  
//                 }  
//                 // 单图文消息---不含图片  
//                 else if ("2".equals(content)) {  
//                     Article article = new Article();  
//                     article.setTitle("微信公众帐号开发教程Java版");  
//                     // 图文消息中可以使用QQ表情、符号表情  
//                     article.setDescription("柳峰，80后，" + emoji(0x1F6B9)  
//                             + "，微信公众帐号开发经验4个月。为帮助初学者入门，特推出此系列连载教程，也希望借此机会认识更多同行！\n\n目前已推出教程共12篇，包括接口配置、消息封装、框架搭建、QQ表情发送、符号表情发送等。\n\n后期还计划推出一些实用功能的开发讲解，例如：天气预报、周边搜索、聊天功能等。");  
//                     // 将图片置为空  
//                     article.setPicUrl("");  
//                     article.setUrl("http://blog.csdn.net/lyq8479");  
//                     articleList.add(article);  
//                     newsMessage.setArticleCount(articleList.size());  
//                     newsMessage.setArticles(articleList);  
//                     respMessage = MessageDealUtil.newsMessageToXml(newsMessage);  
//                 }  
//                 // 多图文消息  
//                 else if ("3".equals(content)) {  
//                     Article article1 = new Article();  
//                     article1.setTitle("微信公众帐号开发教程\n引言");  
//                     article1.setDescription("");  
//                     article1.setPicUrl("http://0.xiaoqrobot.duapp.com/images/avatar_liufeng.jpg");  
//                     article1.setUrl("http://blog.csdn.net/lyq8479/article/details/8937622");  
//   
//                     Article article2 = new Article();  
//                     article2.setTitle("第2篇\n微信公众帐号的类型");  
//                     article2.setDescription("");  
//                     article2.setPicUrl("http://avatar.csdn.net/1/4/A/1_lyq8479.jpg");  
//                     article2.setUrl("http://blog.csdn.net/lyq8479/article/details/8941577");  
//   
//                     Article article3 = new Article();  
//                     article3.setTitle("第3篇\n开发模式启用及接口配置");  
//                     article3.setDescription("");  
//                     article3.setPicUrl("http://avatar.csdn.net/1/4/A/1_lyq8479.jpg");  
//                     article3.setUrl("http://blog.csdn.net/lyq8479/article/details/8944988");  
//   
//                     articleList.add(article1);  
//                     articleList.add(article2);  
//                     articleList.add(article3);  
//                     newsMessage.setArticleCount(articleList.size());  
//                     newsMessage.setArticles(articleList);  
//                     respMessage = MessageDealUtil.newsMessageToXml(newsMessage);  
//                 }  
//                 // 多图文消息---首条消息不含图片  
//                 else if ("4".equals(content)) {  
//                     Article article1 = new Article();  
//                     article1.setTitle("微信公众帐号开发教程Java版");  
//                     article1.setDescription("");  
//                     // 将图片置为空  
//                     article1.setPicUrl("");  
//                     article1.setUrl("http://blog.csdn.net/lyq8479");  
//   
//                     Article article2 = new Article();  
//                     article2.setTitle("第4篇\n消息及消息处理工具的封装");  
//                     article2.setDescription("");  
//                     article2.setPicUrl("http://avatar.csdn.net/1/4/A/1_lyq8479.jpg");  
//                     article2.setUrl("http://blog.csdn.net/lyq8479/article/details/8949088");  
//   
//                     Article article3 = new Article();  
//                     article3.setTitle("第5篇\n各种消息的接收与响应");  
//                     article3.setDescription("");  
//                     article3.setPicUrl("http://avatar.csdn.net/1/4/A/1_lyq8479.jpg");  
//                     article3.setUrl("http://blog.csdn.net/lyq8479/article/details/8952173");  
//   
//                     Article article4 = new Article();  
//                     article4.setTitle("第6篇\n文本消息的内容长度限制揭秘");  
//                     article4.setDescription("");  
//                     article4.setPicUrl("http://avatar.csdn.net/1/4/A/1_lyq8479.jpg");  
//                     article4.setUrl("http://blog.csdn.net/lyq8479/article/details/8967824");  
//   
//                     articleList.add(article1);  
//                     articleList.add(article2);  
//                     articleList.add(article3);  
//                     articleList.add(article4);  
//                     newsMessage.setArticleCount(articleList.size());  
//                     newsMessage.setArticles(articleList);  
//                     respMessage = MessageDealUtil.newsMessageToXml(newsMessage);  
//                 }  
//                 // 多图文消息---最后一条消息不含图片  
//                 else if ("5".equals(content)) {  
//                     Article article1 = new Article();  
//                     article1.setTitle("第7篇\n文本消息中换行符的使用");  
//                     article1.setDescription("");  
//                     article1.setPicUrl("http://product.chinacache.com/abc.png");  
//                     article1.setUrl("http://blog.csdn.net/lyq8479/article/details/9141467");  
//   
//                     Article article2 = new Article();  
//                     article2.setTitle("第8篇\n文本消息中使用网页超链接");  
//                     article2.setDescription("");  
//                     article2.setPicUrl("http://avatar.csdn.net/1/4/A/1_lyq8479.jpg");  
//                     article2.setUrl("http://blog.csdn.net/lyq8479/article/details/9157455");  
//   
//                     Article article3 = new Article();  
//                     article3.setTitle("如果觉得文章对你有所帮助，请通过博客留言或关注微信公众帐号xiaoqrobot来支持柳峰！");  
//                     article3.setDescription("");  
//                     // 将图片置为空  
//                     article3.setPicUrl("");  
//                     article3.setUrl("http://blog.csdn.net/lyq8479");  
//   
//                     articleList.add(article1);  
//                     articleList.add(article2);  
//                     articleList.add(article3);  
//                     newsMessage.setArticleCount(articleList.size());  
//                     newsMessage.setArticles(articleList);  
//                     respMessage = MessageDealUtil.newsMessageToXml(newsMessage);  
//                 }    
//            }  
            // 图片消息  
            else if (msgType.equals(MessageDealUtil.REQ_MESSAGE_TYPE_IMAGE)) {  
                respContent = "您发送的是图片消息！";  
            }  
            // 地理位置消息  
            else if (msgType.equals(MessageDealUtil.REQ_MESSAGE_TYPE_LOCATION)) {  
                respContent = "您发送的是地理位置消息！";  
            }  
            // 链接消息  
            else if (msgType.equals(MessageDealUtil.REQ_MESSAGE_TYPE_LINK)) {  
                respContent = "您发送的是链接消息！";  
            }  
            // 音频消息  
            else if (msgType.equals(MessageDealUtil.REQ_MESSAGE_TYPE_VOICE)) {  
                respContent = "您发送的是音频消息！";  
            }  
            // 事件推送  
            else if (msgType.equals(MessageDealUtil.REQ_MESSAGE_TYPE_EVENT)) {  
                // 事件类型  
                String eventType = requestMap.get("Event");  
                // 订阅  
                if (eventType.equals(MessageDealUtil.EVENT_TYPE_SUBSCRIBE)) {  
                    respContent = "感谢关注通途汽车租赁。我们永远站在客户角度考虑问题，满足并超越客户的需求。一切从专业出发，只专注于自己最专业的领域。\n 我们的产品包括： \n1、 长期租车服务（指租期超过一个月以上）  \n2、短期租车服务（租期在一个月之内） \n3、点到点接送服务 \n4、 机场接送服务 \n5、会议活动用车服务 \n6、婚庆用车服务";  
                }  
                // 取消订阅  
                else if (eventType.equals(MessageDealUtil.EVENT_TYPE_UNSUBSCRIBE)) {  
                    // TODO 取消订阅后用户再收不到公众号发送的消息，因此不需要回复消息 
                	System.out.println("取消评阅");
                }  
                // 自定义菜单点击事件  
                else if (eventType.equals(MessageDealUtil.EVENT_TYPE_CLICK)) {  
                    // 事件KEY值，与创建自定义菜单时指定的KEY值对应  
                    String eventKey = requestMap.get("EventKey");  
                    respContent = "制作Ing...！";
                    if (eventKey.equals("15")) {  
                        respContent = "地址：北京市朝阳区酒仙桥路\n电话：010-6538 0036\n传真：010-6538 0036\n手机：13901139774\n邮箱：rentacar@tutucar.com";  
                    } else if (eventKey.equals("31")) {  
                        respContent = "无";  
                    } else if (eventKey.equals("32")) {  
                        respContent = "无";  
                    }
                }  
            }  
            if(null==respMessage){
                 if(null!=respContent){
                	 textMessage.setContent(respContent);  
                     respMessage = MessageDealUtil.textMessageToXml(textMessage);
                 }else{
                	 textMessage.setContent("没有当前内容！");  
                     respMessage = MessageDealUtil.textMessageToXml(textMessage);
                 }
            }  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
  
        return respMessage;  
    }  
    public static String processRequest2(HttpServletRequest request) {  
        String respMessage = null;  
        try {  
            // xml请求解析  
            Map<String, String> requestMap = MessageDealUtil.parseXml(request);  
  
            // 发送方帐号（open_id）  
            String fromUserName = requestMap.get("FromUserName");  
            // 公众帐号  
            String toUserName = requestMap.get("ToUserName");  
            // 消息类型  
            String msgType = requestMap.get("MsgType");  
  
            // 默认回复此文本消息  
            TextMessage textMessage = new TextMessage();  
            textMessage.setToUserName(fromUserName);  
            textMessage.setFromUserName(toUserName);  
            textMessage.setCreateTime(new Date().getTime());  
            textMessage.setMsgType(MessageDealUtil.RESP_MESSAGE_TYPE_TEXT);  
            //textMessage.setFuncFlag(0);  
            // 由于href属性值必须用双引号引起，这与字符串本身的双引号冲突，所以要转义  
            textMessage.setContent("欢迎访问<a href=\"http://blog.csdn.net/lyq8479\">柳峰的博客</a>!");  
            // 将文本消息对象转换成xml字符串  
            respMessage = MessageDealUtil.textMessageToXml(textMessage);  
  
            // 文本消息  
            if (msgType.equals(MessageDealUtil.REQ_MESSAGE_TYPE_TEXT)) {  
                // 接收用户发送的文本消息内容  
               
            }  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return respMessage;  
    }  
  
    /** 
     * emoji表情转换(hex -> utf-16) 
     *  
     * @param hexEmoji 
     * @return 
     */  
    public static String emoji(int hexEmoji) {  
        return String.valueOf(Character.toChars(hexEmoji));  
    }  
}  