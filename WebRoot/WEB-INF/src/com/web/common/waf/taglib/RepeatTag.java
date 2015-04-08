package com.web.common.waf.taglib;

import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class RepeatTag extends BodyTagSupport
{

    public RepeatTag()
    {
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public void setIdx(String idx)
    {
        this.idx = idx;
    }

    public void setStart(Integer start)
    {
        if(start != null)
            this.start = start.intValue();
        else
            this.start = 1;
    }

    public void setCollection(Collection collection)
    {
        iterator = collection.iterator();
    }

    public int doStartTag()
        throws JspException
    {
        if(iterator == null)
            return 0;
        else
            return addNext(iterator);
    }

    public int doAfterBody()
        throws JspException
    {
        return addNext(iterator);
    }

    public int doEndTag()
        throws JspException
    {
        try
        {
            if(bodyContent != null)
                bodyContent.writeOut(bodyContent.getEnclosingWriter());
        }
        catch(IOException e)
        {
            throw new JspTagException("IO Error : " + e.getMessage());
        }
        return 6;
    }

    protected int addNext(Iterator iterator)
        throws JspTagException
    {
        if(iterator.hasNext())
        {
            Object tmp = iterator.next();
            Integer cnt = new Integer(start++);
            pageContext.setAttribute(id, tmp, 1);
            pageContext.setAttribute(idx != null ? idx : "idx", cnt, 1);
            return 2;
        } else
        {
            return 0;
        }
    }

    public void release()
    {
        id = null;
        idx = null;
        start = 0;
        type = null;
        iterator = null;
    }

    private Iterator iterator;
    private String type;
    private String idx;
    private int start;
}
