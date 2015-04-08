package com.web.common.waf.taglib;

import com.web.common.util.LogUtil;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.TagSupport;
import org.apache.log4j.Logger;

public class BaseTag extends TagSupport
{

    public BaseTag()
    {
        logger = LogUtil.instance().getLogger("consoleLogger");
    }

    public int doStartTag()
        throws JspTagException
    {
        return 0;
    }

    public int doEndTag()
        throws JspTagException
    {
        HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
        JspWriter out = pageContext.getOut();
        try
        {
            String base = "<base href='http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/'>";
            out.println(base);
        }
        catch(Exception e)
        {
            throw new JspTagException(e.getClass().getName() + " ] " + e.getMessage());
        }
        return 6;
    }

    Logger logger;
}
