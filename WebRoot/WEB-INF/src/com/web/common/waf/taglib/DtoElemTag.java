package com.web.common.waf.taglib;

import com.web.common.transfer.*;
import java.beans.*;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Iterator;
import javax.servlet.ServletRequest;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.BodyTagSupport;

// Referenced classes of package com.audien.common.waf.taglib:
//            Outer, PageListTag

public class DtoElemTag extends BodyTagSupport
    implements Outer
{

    public DtoElemTag()
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
        throws JspException
    {
        javax.servlet.jsp.tagext.Tag parent = getParent();
        ServletRequest request = pageContext.getRequest();
        JspWriter out = pageContext.getOut();
        if(name == null && param == null)
            throw new JspException("DtoElemTag >> name or param is required");
        if(value == null && param == null)
            throw new JspException("DtoElemTag >> value or param is required");
        if(name == null)
            name = param;
        if(value == null)
            value = request.getAttribute(param);
        if(value == null)
            return 0;
        if(name.equalsIgnoreCase("dtoclass"))
        {
            String className = value.getClass().getName();
            int sdx = className.lastIndexOf(".");
            int edx = className.lastIndexOf("DTO");
            if(edx == -1)
                throw new JspException("DTO'name must be xxxDTO");
            name = className.substring(sdx + 1, edx);
        }
        data = value;
        if(value instanceof PageDTO)
            type = 2;
        else
        if(value instanceof ListDTO)
            type = 3;
        else
        if(value instanceof DTO)
            type = 1;
        else
            throw new JspException("only DTO is allowed");
        return 1;
    }

    public int doAfterBody()
        throws JspException
    {
        return 0;
    }

    public int doEndTag()
        throws JspException
    {
        if(value == null)
            return 0;
        ServletRequest request = pageContext.getRequest();
        JspWriter out = pageContext.getOut();
        try
        {
            out.print("<entry name='" + name + "'>\n");
            if(type == 2 || type == 3)
            {
                boolean isPage = type == 2;
                if(type == 2)
                {
                    PageDTO pagedto = (PageDTO)value;
                    out.print("<total-page>" + pagedto.getTotalPage() + "</total-page>");
                    out.print("<total-count>" + pagedto.getTotalCount() + "</total-count>");
                    out.print("<page>" + pagedto.getPage() + "</page>");
                    out.print("<page-size>" + pagedto.size() + "</page-size>");
                    out.println("<page-list><![CDATA[\n");
                    PageListTag listTag = new PageListTag();
                    listTag.setPageContext(pageContext);
                    listTag.setTotalCount(new Integer(pagedto.getTotalCount()));
                    listTag.setViewPage(new Integer(pagedto.getPage()));
                    listTag.setRowPerPage(new Integer(10));
                    listTag.setPageListCount("10");
                    listTag.setJavaScript(name + ".searchList");
                    listTag.doStartTag();
                    listTag.doEndTag();
                    out.println("]]></page-list>\n");
                }
                out.print("<list name='item-list'>\n");
                for(iter = ((ListDTO)value).iterator(); iter.hasNext();)
                {
                    data = iter.next();
                    out.print("<entry>\n");
                    out.print(getProperties(data));
                    out.print("</entry>\n");
                    cnt++;
                }

                out.print("</list>\n");
            } else
            if(type == 1)
                out.print(getProperties(value));
            out.print("</entry>");
        }
        catch(IOException e)
        {
            throw new JspException("DtoElemTag >> " + e.getMessage());
        }
        return 6;
    }

    private String getProperties(Object object)
        throws JspException
    {
        StringBuffer sb = new StringBuffer();
        try
        {
            BeanInfo info = Introspector.getBeanInfo(object.getClass(), java.lang.Object.class);
            PropertyDescriptor properties[] = info.getPropertyDescriptors();
            sb = new StringBuffer();
            for(int i = 0; i < properties.length; i++)
            {
                String name = properties[i].getName();
                Method method = properties[i].getReadMethod();
                Object value = method.invoke(object, new Object[0]);
                value = value != null ? value : "";
                sb.append("  <field name='" + name + "'><![CDATA[" + value + "]]></field>\n");
            }

        }
        catch(Exception e)
        {
            throw new JspException("DtoElemTag >> " + e.getMessage());
        }
        return sb.toString();
    }

    private final int DTO_TYPE = 1;
    private final int PageDTO_TYPE = 2;
    private final int ListDTO_TYPE = 3;
    private Object value;
    private String name;
    private String param;
    private int type;
    private Object data;
    private int cnt;
    private Iterator iter;
}
