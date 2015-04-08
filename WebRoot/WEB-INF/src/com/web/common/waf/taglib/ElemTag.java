package com.web.common.waf.taglib;

import java.io.IOException;
import java.lang.reflect.Method;
import javax.servlet.ServletRequest;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.TagSupport;

// Referenced classes of package com.audien.common.waf.taglib:
//            Outer

public class ElemTag extends TagSupport
{

    public ElemTag()
    {
    }

    public String getField()
    {
        return field;
    }

    public String getValue()
    {
        return value;
    }

    public String getName()
    {
        return name;
    }

    public String getParam()
    {
        return param;
    }

    public Object getTarget()
    {
        return target;
    }

    public void setField(String field)
    {
        this.field = field;
    }

    public void setValue(String value)
    {
        this.value = value;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setParam(String param)
    {
        this.param = param;
    }

    public void setTarget(Object target)
    {
        this.target = target;
    }

    public int doStartTag()
        throws JspTagException
    {
        ServletRequest request = pageContext.getRequest();
        if(target == null)
        {
            javax.servlet.jsp.tagext.Tag parent = getParent();
            if(parent != null && (parent instanceof Outer))
                target = ((Outer)parent).getData();
        }
        if(name == null && field == null && param == null)
            throw new JspTagException("ElemTag >> name or field or param is required");
        if(name == null && field != null)
            name = field;
        if(name == null && param != null)
            name = param;
        if(name == null)
            throw new JspTagException("ElemTag >> name is null");
        if(value == null && field == null && param == null)
            throw new JspTagException("ElemTag >> value or field or param is required");
        if(value == null && field != null)
        {
            if(target == null)
                throw new JspTagException("ElemTag >> target is null");
            char c = Character.toUpperCase(field.charAt(0));
            String readMethod = "get" + c + field.substring(1);
            try
            {
                Class cls = target.getClass();
                Method method = cls.getMethod(readMethod, new Class[0]);
                Object o = method.invoke(target, new Object[0]);
                if(o != null)
                    value = o.toString();
            }
            catch(Exception e)
            {
                throw new JspTagException("ElemTag >> " + e.getMessage());
            }
        }
        if(value == null && param != null)
        {
            Object o = request.getAttribute(param);
            if(o != null)
                value = o.toString();
        }
        if(value == null)
            value = "";
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
            out.print("<field name='" + name + "'>" + value + "</field>");
        }
        catch(IOException e)
        {
            throw new JspTagException("ElemTag >> " + e.getMessage());
        }
        return 6;
    }

    private String field;
    private String value;
    private String name;
    private String param;
    private Object target;
}
