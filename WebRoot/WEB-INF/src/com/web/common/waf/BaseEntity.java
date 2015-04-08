package com.web.common.waf;

import com.web.common.util.LogUtil;
import java.io.Serializable;
import java.util.HashMap;
import javax.servlet.http.*;
import org.apache.log4j.Logger;

public class BaseEntity
    implements Serializable, HttpSessionBindingListener, HttpSessionActivationListener
{

    public BaseEntity(String userId)
    {
        logger = LogUtil.instance().getLogger("consoleLogger");
        this.userId = userId;
        datas = new HashMap();
    }

    public String getUserId()
    {
        return userId;
    }

    protected void setDummy()
    {
        dummy = true;
    }

    protected boolean isDummy()
    {
        return dummy;
    }

    public void setAttribute(String key, String value)
    {
        datas.put(key, value);
    }

    public String getAttribute(String key)
    {
        return (String)datas.get(key);
    }

    public String toString()
    {
        StringBuffer sb = new StringBuffer();
        sb.append("BaseEntity [ userId=").append(userId);
        sb.append(", datas=").append(datas);
        sb.append(" ]");
        return sb.toString();
    }

    public void valueBound(HttpSessionBindingEvent event)
    {
        HttpSession hs = event.getSession();
        SessionManager manager = SessionManager.getInstance();
        manager.addHttpSession(hs);
        try
        {
            String lineSep = System.getProperty("line.separator");
            trace(lineSep + lineSep + lineSep + lineSep + lineSep + lineSep);
            trace("===================================================");
            trace("BaseEntity is bounded. - " + userId);
            trace("session : " + event.getSession());
            trace("attName : " + event.getName());
            trace("attValue : " + event.getValue());
            trace("===================================================");
            trace(lineSep + lineSep + lineSep + lineSep + lineSep + lineSep);
        }
        catch(Exception e)
        {
            trace("BaseEntity is bound but 로그찍는중 에러");
        }
        trace("BaseEntity is bounded. - " + userId);
    }

    public void sessionDidActivate(HttpSessionEvent event)
    {
        HttpSession hs = event.getSession();
        SessionManager manager = SessionManager.getInstance();
        manager.addHttpSession(hs);
        try
        {
            trace("===================================================");
            trace("BaseEntity is activated. - " + userId);
            trace("session : " + event.getSession());
            trace("===================================================");
        }
        catch(Exception e)
        {
            trace("BaseEntity is activated but 로그찍는중 에러");
        }
        trace("BaseEntity is activated. - " + userId);
    }

    public void sessionWillPassivate(HttpSessionEvent event)
    {
        trace("BaseEntity will passivate - " + userId);
    }

    public void valueUnbound(HttpSessionBindingEvent event)
    {
        HttpSession hs = event.getSession();
        SessionManager manager = SessionManager.getInstance();
        manager.removeHttpSession(hs.getId());
        if(!isDummy())
        {
            try
            {
                String lineSep = System.getProperty("line.separator");
                trace(lineSep + lineSep + lineSep + lineSep + lineSep + lineSep);
                trace("===================================================");
                trace("BaseEntity is unBound. - " + userId);
                trace("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
                trace("attName : " + event.getName());
                trace("attValue : " + event.getValue());
                trace("session : " + event.getSession());
                trace("===================================================");
                trace(lineSep + lineSep + lineSep + lineSep + lineSep + lineSep);
            }
            catch(Exception e)
            {
                trace("BaseEntity is unbounded but 로그찍는중 에러");
            }
        } else
        {
            String lineSep = System.getProperty("line.separator");
            trace(lineSep + lineSep + lineSep + lineSep + lineSep + lineSep);
            trace("===================================================");
            trace("Dummy BaseEntity is unBound. - " + userId);
            trace("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            trace("session : " + event.getSession());
            trace("===================================================");
            trace(lineSep + lineSep + lineSep + lineSep + lineSep + lineSep);
        }
    }

    public void trace(String msg)
    {
        logger.debug(msg);
    }

    Logger logger;
    protected String userId;
    protected HashMap datas;
    private boolean dummy;
}
