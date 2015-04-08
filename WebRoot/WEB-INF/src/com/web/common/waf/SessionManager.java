package com.web.common.waf;

import java.io.PrintStream;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SessionManager
{

    private SessionManager()
    {
        sessions = Collections.synchronizedMap(new HashMap());
    }

    public static SessionManager getInstance()
    {
        if(instance == null)
            synchronized(com.web.common.waf.SessionManager.class)
            {
                if(instance == null)
                    instance = new SessionManager();
            }
        return instance;
    }

    public static boolean isLogin(HttpServletRequest request)
    {
        HttpSession hs = request.getSession();
        Object obj = hs.getAttribute("BASE_ENTITY_KEY");
        return obj != null && (obj instanceof BaseEntity);
    }

    public void login(HttpServletRequest request, BaseEntity entity)
        throws ServletException
    {
        if(entity == null)
        {
            throw new ServletException("waf.admin.nullBaseEntity");
        } else
        {
            chekDummy(entity);
            HttpSession hs = request.getSession(true);
            hs.setMaxInactiveInterval(3600);
            hs.setAttribute("BASE_ENTITY_KEY", entity);
            return;
        }
    }

    public static void logout(HttpServletRequest request)
    {
        HttpSession hs = request.getSession();
        hs.invalidate();
    }

    public void addHttpSession(HttpSession session)
    {
        sessions.put(session.getId(), session);
        BaseEntity be = (BaseEntity)session.getAttribute("BASE_ENTITY_KEY");
    }

    public HttpSession removeHttpSession(String sessionId)
    {
        return (HttpSession)sessions.remove(sessionId);
    }

    public HttpSession removeHttpSession(HttpServletRequest request)
    {
        HttpSession hs = request.getSession();
        return removeHttpSession(hs.getId());
    }

    public HttpSession getHttpSession(String sessionId)
    {
        return (HttpSession)sessions.get(sessionId);
    }

    public HttpSession getHttpSession(HttpServletRequest request)
    {
        HttpSession hs = request.getSession();
        return hs;
    }

    public BaseEntity getBaseEntity(String sessionId)
    {
        HttpSession hs = (HttpSession)sessions.get(sessionId);
        return hs == null ? null : (BaseEntity)hs.getAttribute("BASE_ENTITY_KEY");
    }

    public BaseEntity getBaseEntity(HttpServletRequest request)
    {
        HttpSession hs = request.getSession();
        return (BaseEntity)hs.getAttribute("BASE_ENTITY_KEY");
    }

    public ArrayList getAllBaseEntitys()
    {
        Set set = sessions.entrySet();
        Iterator it = set.iterator();
        ArrayList al = new ArrayList();
        try
        {
            if(set != null)
                System.out.println("set.size() : " + set.size());
            HttpSession hs;
            for(; it.hasNext(); al.add(hs.getAttribute("BASE_ENTITY_KEY")))
            {
                java.util.Map.Entry obj = (java.util.Map.Entry)it.next();
                System.out.println("obj : " + obj);
                System.out.println("toString : " + obj.toString());
                System.out.println("class name : " + obj.getClass().getName());
                hs = (HttpSession)obj.getValue();
            }

            System.out.println("al.size() : " + al.size());
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.println("SessionManager@getAllBaseEntitys Exception : " + e.getMessage());
        }
        return al;
    }

    public int getTotalCount()
    {
        return sessions.size();
    }

    public ArrayList getAllHttpSessions()
    {
        Set set = sessions.entrySet();
        ArrayList al = new ArrayList(set);
        return al;
    }

    private boolean chekDummy(BaseEntity entity)
    {
        String userId = entity.getUserId();
        Collection col = sessions.values();
        for(Iterator it = col.iterator(); it.hasNext();)
        {
            HttpSession hs = (HttpSession)it.next();
            BaseEntity be = (BaseEntity)hs.getAttribute("BASE_ENTITY_KEY");
            if(be.getUserId().equals(userId))
            {
                be.setDummy();
                hs.invalidate();
                return true;
            }
        }

        return false;
    }

    private static SessionManager instance;
    public static final String SESSION_KEY = "BASE_ENTITY_KEY";
    public static final int SESSION_TIMEOUT = 3600;
    private Map sessions;
}
