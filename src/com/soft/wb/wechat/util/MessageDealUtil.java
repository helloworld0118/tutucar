package com.soft.wb.wechat.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.stereotype.Service;

import com.soft.wb.wechat.model.Article;
import com.soft.wb.wechat.model.MusicMessage;
import com.soft.wb.wechat.model.NewsMessage;
import com.soft.wb.wechat.model.TextMessage;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.core.util.QuickWriter;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.xml.PrettyPrintWriter;
import com.thoughtworks.xstream.io.xml.XppDriver;

public class MessageDealUtil {  
  
    public static final String RESP_MESSAGE_TYPE_TEXT = "text";  
  
    public static final String RESP_MESSAGE_TYPE_MUSIC = "music";  
    public static final String RESP_MESSAGE_TYPE_NEWS = "news";  
    public static final String REQ_MESSAGE_TYPE_TEXT = "text";  
    public static final String REQ_MESSAGE_TYPE_IMAGE = "image";  
  
    public static final String REQ_MESSAGE_TYPE_LINK = "link";  
    public static final String REQ_MESSAGE_TYPE_LOCATION = "location";  
    public static final String REQ_MESSAGE_TYPE_VOICE = "voice";  
  
    public static final String REQ_MESSAGE_TYPE_EVENT = "event";  
  
    public static final String EVENT_TYPE_SUBSCRIBE = "subscribe";  
  
    public static final String EVENT_TYPE_UNSUBSCRIBE = "unsubscribe";  
    public static final String EVENT_TYPE_CLICK = "CLICK";  
  
    public static Map<String, String> parseXml(HttpServletRequest request) {  
        Map<String, String> map = new HashMap<String, String>();  
  
        InputStream inputStream=null;
		try {
			inputStream = request.getInputStream();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}  
        SAXReader reader = new SAXReader();  
        Document document=null;
		try {
			document = reader.read(inputStream);
		} catch (DocumentException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} 
        Element root = document.getRootElement();  
        List<Element> elementList = root.elements();  
  
        for (Element e : elementList)  {
            map.put(e.getName(), e.getText());  
        }
        try {
			inputStream.close();
		} catch (IOException e1) {
			e1.printStackTrace();
		}  
        inputStream = null;  
  
        return map;  
    }  
  
    public static String textMessageToXml(TextMessage textMessage) {  
    	System.out.println(textMessage.getContent());
        xstream.alias("xml", textMessage.getClass());  
        System.out.println(xstream.toXML(textMessage));
        return xstream.toXML(textMessage);  
    }  
  
    public static String musicMessageToXml(MusicMessage musicMessage) {  
        xstream.alias("xml", musicMessage.getClass());  
        return xstream.toXML(musicMessage);  
    }  
  
    public static String newsMessageToXml(NewsMessage newsMessage) {
        xstream.alias("xml", newsMessage.getClass());  
        xstream.alias("item", new Article().getClass());  
        return xstream.toXML(newsMessage);  
    }  
  
    private static 	XStream xstream = new XStream(new XppDriver() {  
        public HierarchicalStreamWriter createWriter(Writer out) {  
            return new PrettyPrintWriter(out) {  
                boolean cdata = true;  
                @SuppressWarnings("unchecked")  
                public void startNode(String name, Class clazz) {  
                    super.startNode(name, clazz);  
                }  
  
                protected void writeText(QuickWriter writer, String text) {  
                    if (cdata) {  
                        writer.write("<![CDATA[");  
                        writer.write(text);  
                        writer.write("]]>");  
                    } else {  
                        writer.write(text);  
                    }  
                }  
            };  
        }  
    });  
}  