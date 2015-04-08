package com.web.common.waf.taglib;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletRequest;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.BodyTagSupport;

// Referenced classes of package com.audien.common.waf.taglib:
//            Outer

public class ListElemTag extends BodyTagSupport
    implements Outer
{

    public ListElemTag()
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
            throw new JspTagException("ListElemTag >> name or param is required");
        if(value == null && param == null)
            throw new JspTagException("ListElemTag >> value or param is required");
        if(name == null)
            name = param;
        if(value == null && param != null)
            value = request.getAttribute(param);
        if(value == null)
            throw new JspTagException("ListElemTag >> value is null");
        if(value instanceof List)
            iter = ((List)value).iterator();
        else
        if(value instanceof Iterator)
            iter = (Iterator)value;
        else
            throw new JspTagException("value must be List or Iterator");
        try
        {
            out.print("<list name='" + name + "'>\n");
            if(iter.hasNext())
            {
                cnt++;
                data = iter.next();
                out.print("<entry no='" + cnt++ + "'>");
                return 1;
            }
        }
        catch(IOException e)
        {
            throw new JspTagException("ListElemTag >> " + e.getMessage());
        }
        return 0;
    }

    public int doAfterBody()
        throws JspTagException
    {
        javax.servlet.jsp.tagext.Tag parent = getParent();
        ServletRequest request = pageContext.getRequest();
        JspWriter out = pageContext.getOut();
        try
        {
            out.print("</entry>\n");
            if(iter.hasNext())
            {
                data = iter.next();
                out.print("<entry no='" + cnt++ + "'>");
                return 2;
            }
        }
        catch(IOException e)
        {
            throw new JspTagException("ListElemTag >> " + e.getMessage());
        }
        return 6;
    }

    public int doEndTag()
        throws JspTagException
    {
        javax.servlet.jsp.tagext.Tag parent = getParent();
        ServletRequest request = pageContext.getRequest();
        JspWriter out = pageContext.getOut();
        try
        {
            out.print("</list>");
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
    private Iterator iter;
    private Object data;
    private int cnt;
}
