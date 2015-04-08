package com.web.common.waf.taglib;

import com.web.common.util.LogUtil;
import java.io.IOException;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.TagSupport;
import org.apache.log4j.Logger;

public class PageListTag extends TagSupport
{

    public PageListTag()
    {
        logger = LogUtil.instance().getLogger("consoleLogger");
    }

    public void setTotalCount(Integer totalCount)
    {
        this.totalCount = totalCount.intValue();
    }

    public void setViewPage(Integer viewPage)
    {
        this.viewPage = viewPage != null ? viewPage.intValue() : 1;
    }

    public void setRowPerPage(Integer rowPerPage)
    {
        this.rowPerPage = rowPerPage.intValue();
    }

    public void setPageListCount(String pageListCount)
    {
        this.pageListCount = Integer.parseInt(pageListCount);
    }

    public void setJavaScript(String javaScript)
    {
        this.javaScript = javaScript;
    }

    public void setViewPageColor(String viewPageColor)
    {
        this.viewPageColor = viewPageColor;
    }

    public void setFirst(String first)
    {
        this.first = first;
    }

    public void setPrev(String prev)
    {
        this.prev = prev;
    }

    public void setNext(String next)
    {
        this.next = next;
    }

    public void setLast(String last)
    {
        this.last = last;
    }

    private String getPageList(int rowCount, int viewPage, int rowPerPage, int pageListCount, String javascript_name, String current_page_color, String first_button, 
            String prev_button, String next_button, String last_button)
    {
        int intTotPage = 0;
        int intStartPage = 0;
        int intEndPage = 0;
        intStartPage = (int)Math.ceil((viewPage - 1) / pageListCount);
        intStartPage = intStartPage * pageListCount + 1;
        if(intStartPage % pageListCount == 0)
            intStartPage = (intStartPage - pageListCount) + 1;
        intTotPage = getTotalPage(rowCount, rowPerPage);
        intEndPage = intTotPage < pageListCount + intStartPage ? intStartPage + (intTotPage - intStartPage) : (intStartPage + pageListCount) - 1;
        StringBuffer sb = new StringBuffer();
        if(intStartPage > pageListCount)
        {
            sb.append("<a href=\"javascript:");
            sb.append(javascript_name);
            sb.append("(1);\">");
            sb.append(first_button);
            sb.append("</a>");
            sb.append("\n");
        } else
        {
            sb.append(first_button);
            sb.append("\n");
        }
        if(intStartPage > pageListCount)
        {
            sb.append("<a href=\"javascript:");
            sb.append(javascript_name).append("(");
            sb.append(intStartPage - pageListCount);
            sb.append(");\">");
            sb.append(prev_button);
            sb.append("</a>");
            sb.append("</a>");
            sb.append("\n");
            sb.append("&nbsp;");
            sb.append("\n");
        } else
        {
            sb.append(prev_button);
            sb.append("\n");
            sb.append("&nbsp;");
            sb.append("\n");
        }
        for(int i = intStartPage; i <= intEndPage; i++)
            if(viewPage == i)
            {
                sb.append("<font size=\"2\" color=\"");
                sb.append(current_page_color);
                sb.append("\"><b>[");
                sb.append(i);
                sb.append("]</b></font>");
                sb.append("\n");
            } else
            {
                sb.append("<a href=\"javascript:");
                sb.append(javascript_name);
                sb.append("(");
                sb.append(i);
                sb.append(");\">[");
                sb.append(i);
                sb.append("]</a>");
                sb.append("\n");
            }

        if(intTotPage > intEndPage)
        {
            sb.append("&nbsp;");
            sb.append("\n");
            sb.append("<a href=\"javascript:");
            sb.append(javascript_name);
            sb.append("(");
            sb.append(intStartPage + pageListCount);
            sb.append(");\">");
            sb.append(next_button);
            sb.append("</a>");
            sb.append("\n");
        } else
        {
            sb.append("&nbsp;");
            sb.append("\n");
            sb.append(next_button);
            sb.append("\n");
        }
        if(intTotPage > intEndPage)
        {
            sb.append("<a href=\"javascript:");
            sb.append(javascript_name);
            sb.append("(");
            sb.append(intTotPage);
            sb.append(");\">");
            sb.append(last_button);
            sb.append("</a>");
        } else
        {
            sb.append(last_button);
        }
        return sb.toString();
    }

    public int doStartTag()
        throws JspTagException
    {
        try
        {
            if(totalCount <= 0)
            {
                return 0;
            } else
            {
                JspWriter out = pageContext.getOut();
                out.println(getPageList(totalCount, viewPage > 0 ? viewPage : 1, rowPerPage <= 0 ? 10 : rowPerPage, pageListCount <= 0 ? 5 : pageListCount, javaScript, viewPageColor == null || viewPageColor.length() <= 0 ? "#FF9933" : viewPageColor, first == null || first.length() <= 0 ? "|¢¸" : first, prev == null || prev.length() <= 0 ? "¢¸" : prev, next == null || next.length() <= 0 ? "¢º" : next, last == null || last.length() <= 0 ? "¢º|" : last));
                return 0;
            }
        }
        catch(IOException e)
        {
            logger.error("", e);
            throw new JspTagException(e.getMessage());
        }
        catch(Exception e)
        {
            logger.error("", e);
            throw new JspTagException(e.getMessage());
        }
    }

    private int getTotalPage(int rowCount, int rowPerPage)
    {
        return (int)Math.ceil(rowCount / rowPerPage) + (rowCount % rowPerPage <= 0 ? 0 : 1);
    }

    Logger logger;
    private int totalCount;
    private int viewPage;
    private int rowPerPage;
    private int pageListCount;
    private String javaScript;
    private String viewPageColor;
    private String first;
    private String prev;
    private String next;
    private String last;
    private static final int DEFAULT_ROW_PER_PAGE = 10;
    private static final int DEFAULT_PAGE_LIST_COUNT = 10;
    private static final String DEFAULT_JAVA_SCRIPT = "gotoPage";
    private static final String DEFAULT_VIEW_PAGE_COLOR = "#FF6300";
    private static final String DEFAULT_FIRST_BUTTON = "|¢¸";
    private static final String DEFAULT_PREV_BUTTON = "¢¸";
    private static final String DEFAULT_NEXT_BUTTON = "¢º";
    private static final String DEFAULT_LAST_BUTTON = "¢º|";
}
