package com.web.common.waf.taglib;

import java.io.*;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class PreTag extends BodyTagSupport
{

    public PreTag()
    {
        TAB = "&nbsp;&nbsp;&nbsp;&nbsp;".getBytes();
    }

    public void setTabSize(int tabSize)
    {
        if(tabSize <= 0)
            return;
        String tmp = "";
        for(int i = 0; i < tabSize; i++)
            tmp = tmp + "&nbsp;";

        TAB = tmp.getBytes();
    }

    public int doEndTag()
        throws JspTagException
    {
        try
        {
            if(bodyContent != null)
            {
                java.io.Reader rd = bodyContent.getReader();
                BufferedReader br = new BufferedReader(rd);
                StringWriter sw = new StringWriter();
                do
                {
                    String line = br.readLine();
                    if(line != null)
                    {
                        sw.write(convert(line));
                        sw.write("<br>");
                        sw.write("\n");
                    }
                } while(br.ready());
                bodyContent.clearBody();
                bodyContent.println(sw.toString());
                bodyContent.writeOut(bodyContent.getEnclosingWriter());
                sw.flush();
            }
        }
        catch(IOException e)
        {
            throw new JspTagException("IO Error : " + e.getMessage());
        }
        return 6;
    }

    private String convert(String line)
    {
        if(line == null)
            return line;
        byte buff[] = line.getBytes();
        ByteArrayOutputStream bao = null;
        bao = new ByteArrayOutputStream();
        for(int i = 0; i < buff.length; i++)
            switch(buff[i])
            {
            case 32: // ' '
                bao.write(SPACE, 0, SPACE.length);
                break;

            case 9: // '\t'
                bao.write(TAB, 0, TAB.length);
                break;

            case 60: // '<'
                bao.write(LT, 0, LT.length);
                break;

            case 62: // '>'
                bao.write(GT, 0, GT.length);
                break;

            default:
                bao.write(buff[i]);
                break;
            }

        return new String(bao.toByteArray(), 0, bao.size());
    }

    private static byte SPACE[] = "&nbsp;".getBytes();
    private static byte LT[] = "&lt;".getBytes();
    private static byte GT[] = "&gt;".getBytes();
    private byte TAB[];

}
