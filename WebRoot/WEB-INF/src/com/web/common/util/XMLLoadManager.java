package com.web.common.util;

import java.io.PrintStream;
import java.util.Hashtable;
import org.apache.log4j.Logger;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.web.framework.util.XmlUtil;

// Referenced classes of package com.audien.common.util:
//            LogUtil, XmlUtil

public class XMLLoadManager
{

    private XMLLoadManager()
    {
        logger = LogUtil.instance().getLogger("consoleLogger");
        ht = new Hashtable();
        load("/WEB-INF/config/webpages.xml");
    }

    public static XMLLoadManager getInstance()
    {
        return instance;
    }

    private void load(String file_path)
    {
        try
        {
        	Element root = XmlUtil.loadDocument(file_path);
            NodeList nList = root.getElementsByTagName("webpage");
            for(int i = 0; i < nList.getLength(); i++)
            {
                org.w3c.dom.Node node = nList.item(i);
                if(node != null)
                {
                    String name = XmlUtil.getSubTagValue(node, "name");
                    String jsp = XmlUtil.getSubTagValue(node, "jsp");
                    String desc = XmlUtil.getSubTagValue(node, "description");
                    String pages[] = new String[3];
                    pages[0] = name;
                    pages[1] = jsp;
                    pages[2] = desc;
                    ht.put(name, pages);
                }
            }

        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    public void reload()
    {
        load("/home/tmax/huation/WEB-INF/config/webpages.xml");
    }

    public String getPageUrl(String name)
    {
        String pageurl = "";
        String tmp[] = new String[3];
        if(ht.containsKey(name))
        {
            tmp = (String[])ht.get(name);
            pageurl = tmp[1];
        }
        return pageurl;
    }

    public static void main(String args[])
    {
        try
        {
            Element root = XmlUtil.loadDocument("/home/tmax/huation/WEB-INF/config/webpages.xml");
            NodeList nList = root.getElementsByTagName("webpage");
            for(int i = 0; i < nList.getLength(); i++)
            {
                org.w3c.dom.Node node = nList.item(i);
                if(node != null)
                {
                    String name = XmlUtil.getSubTagValue(node, "name");
                    String jsp = XmlUtil.getSubTagValue(node, "jsp");
                    String s = XmlUtil.getSubTagValue(node, "description");
                }
            }

        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.println(e);
        }
    }

    Logger logger;
    private static XMLLoadManager instance = new XMLLoadManager();
    private Hashtable ht;
    private static final String file_path = "WEB-INF/config/webpages.xml";

}
