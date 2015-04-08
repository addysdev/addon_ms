package com.web.common.waf.taglib;

import java.io.IOException;
import javax.servlet.ServletRequest;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.TagSupport;

// Referenced classes of package com.audien.common.waf.taglib:
//            Outer

public class EntryElemTag extends TagSupport
    implements Outer
{

    public EntryElemTag()
    {
    }

    public String getName()
    {
        return name;
    }

    public Object getValue()
    {
        return value;
    }

    public String getParam()
    {
        return param;
    }

    public Object getData()
    {
        return data;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setParam(String param)
    {
        this.param = param;
    }

    public void setValue(Object value)
    {
        this.value = value;
    }

    public int doStartTag()
        throws JspTagException
    {
        javax.servlet.jsp.tagext.Tag parent = getParent();
        ServletRequest request = pageContext.getRequest();
        JspWriter out = pageContext.getOut();
        if(name == null && param == null)
            throw new JspTagException("OjbElemTag >> name or param is required");
        if(value == null && param == null)
            throw new JspTagException("OjbElemTag >> value or param is required");
        if(name == null)
            name = param;
        if(value == null && param != null)
            value = request.getAttribute(param);
        if(value == null)
            throw new JspTagException("OjbElemTag >> value is null");
        data = value;
        try
        {
            out.print("<entry name='" + name + "'>\n");
        }
        catch(IOException e)
        {
            throw new JspTagException("OjbElemTag >> " + e.getMessage());
        }
        return 1;
    }

    public int doEndTag()
        throws JspTagException
    {
        javax.servlet.jsp.tagext.Tag parent = getParent();
        ServletRequest request = pageContext.getRequest();
        JspWriter out = pageContext.getOut();
        try
        {
            out.print("</entry>");
        }
        catch(IOException e)
        {
            throw new JspTagException("OjbElemTag >> " + e.getMessage());
        }
        return 6;
    }

    private Object value;
    private String name;
    private String param;
    private Object data;
}
