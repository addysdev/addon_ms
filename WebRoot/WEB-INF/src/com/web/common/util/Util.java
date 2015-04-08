package com.web.common.util;

import java.io.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Properties;
import java.util.StringTokenizer;

public class Util
{

    public Util()
    {
    }

    public static String ChQuot(String str)
    {
        if(str == null)
            return "";
        int i = str.indexOf("'");
        String strnew = "";
        for(; i > -1; i = str.indexOf("'"))
        {
            strnew = strnew + str.substring(0, i) + "''";
            str = str.substring(i + 1);
        }

        strnew = strnew + str;
        return strnew;
    }

    public static String BR(String str)
    {
        str = strNull(str);
        int i = str.indexOf("\n");
        String strnew = "";
        for(; i > -1; i = str.indexOf("\n"))
        {
            strnew = strnew + str.substring(0, i) + "<br>";
            str = str.substring(i + 1);
        }

        strnew = strnew + str;
        return strnew;
    }

    public static String strNull(String str)
    {
        return str != null ? str.trim() : "";
    }

    public static String strNullZ(String str)
    {
        return str != null ? str.trim() : "0";
    }

    public static String CutStr(String str, int MaxLen)
    {
        String strnew = "";
        int _length = 0;
        if(str == null || str.length() == 0)
            return strnew;
        if(str.length() > MaxLen)
        {
            for(int i = 0; i < MaxLen - 1; i++)
                strnew = strnew + str.charAt(i);

            strnew = strnew + " ...";
        } else
        {
            strnew = str;
        }
        return strnew;
    }

    public static String CutNum(String str, int MaxLen)
    {
        String strnew = "";
        int _length = 0;
        if(str == null || str.length() == 0)
            return strnew;
        if(str.length() > MaxLen)
        {
            for(int i = 0; i < MaxLen - 1; i++)
                strnew = strnew + str.charAt(i);

        } else
        {
            strnew = str;
        }
        return strnew;
    }

    public static String strDate(String str, int flag)
    {
        String strnew = "";
        if(strNull(str).trim().length() == 0)
            return strNull(str);
        if(flag == 1)
        {
            if(str.length() == 10)
                strnew = str.substring(0, 4) + "." + str.substring(5, 7) + "." + str.substring(8, 10);
            else
                strnew = str.substring(0, 4) + "." + str.substring(4, 6) + "." + str.substring(6, 8);
        } else
        if(flag == 2)
            strnew = str.substring(0, 4) + "." + str.substring(4, 6) + "." + str.substring(6, 8) + " " + str.substring(8, 10) + ":" + str.substring(10, 12);
        else
            strnew = str.substring(2, 4) + "." + str.substring(4, 6) + "." + str.substring(6, 8);
        return strnew;
    }

    public static String strDate2(String str, int flag)
    {
        String strnew = "";
        if(strNull(str).trim().length() == 0)
            return strNull(str);
        if(flag == 1)
        {
            if(str.length() == 10)
                strnew = str.substring(0, 4) + "/" + str.substring(5, 7) + "/" + str.substring(8, 10);
            else
                strnew = str.substring(0, 4) + "/" + str.substring(4, 6) + "/" + str.substring(6, 8);
        } else
        if(flag == 2)
            strnew = str.substring(0, 4) + "/" + str.substring(4, 6) + "/" + str.substring(6, 8) + " " + str.substring(8, 10) + ":" + str.substring(10, 12);
        else
            strnew = str.substring(2, 4) + "/" + str.substring(4, 6) + "/" + str.substring(6, 8);
        return strnew;
    }

    public static String strMonth(String str)
    {
        String strnew = "";
        if(strNull(str).trim().length() == 0)
            return strNull(str);
        if(str.length() == 7)
            strnew = str.substring(0, 4) + "." + str.substring(5, 7);
        else
            strnew = str.substring(0, 4) + "." + str.substring(4, 6);
        return strnew;
    }

    public static String Comma(int i)
    {
        DecimalFormat fmt1 = new DecimalFormat("#,###,###,###");
        String str = fmt1.format(i);
        return str;
    }

    public static String Comma(double d)
    {
        DecimalFormat fmt1 = new DecimalFormat("#,###,###,###,###,###");
        String str = fmt1.format(d);
        return str;
    }

    public static String Comma(String s)
    {
        int i = Integer.parseInt(s);
        DecimalFormat fmt1 = new DecimalFormat("#,###,###,###,###,###");
        String str = fmt1.format(i);
        return str;
    }

    public static String SaleP(String s)
    {
        int i = Integer.parseInt(s);
        int intsp = (70 * i) / 100;
        String strsp = Integer.toString(intsp);
        return strsp;
    }

    public static String SaleP(int i)
    {
        int intsp = (70 * i) / 100;
        String strsp = Integer.toString(intsp);
        return strsp;
    }

    public static long unComma(String s)
        throws Exception
    {
        NumberFormat nf = NumberFormat.getInstance();
        Number myNum = nf.parse(s);
        return myNum.longValue();
    }

    public static String fileImage(String extenstion)
    {
        int idx = extenstion.lastIndexOf(".");
        if(idx == -1)
            return "unknown.gif";
        String ext = extenstion.substring(idx + 1);
        String str = "";
        if(ext.toUpperCase().equals("TXT"))
            str = "txt.gif";
        else
        if(ext.toUpperCase().equals("EXE"))
            str = "exe.gif";
        else
        if(ext.toUpperCase().equals("COM"))
            str = "com.gif";
        else
        if(ext.toUpperCase().equals("HTML"))
            str = "html.gif";
        else
        if(ext.toUpperCase().equals("HTM"))
            str = "html.gif";
        else
        if(ext.toUpperCase().equals("ZIP"))
            str = "compressed.gif";
        else
        if(ext.toUpperCase().equals("ARJ"))
            str = "compressed.gif";
        else
        if(ext.toUpperCase().equals("JAR"))
            str = "compressed.gif";
        else
        if(ext.toUpperCase().equals("GIF"))
            str = "gif.gif";
        else
        if(ext.toUpperCase().equals("JPG"))
            str = "jpg.gif";
        else
        if(ext.toUpperCase().equals("BMP"))
            str = "bmp.gif";
        else
        if(ext.toUpperCase().equals("MP3"))
            str = "mp3.gif";
        else
        if(ext.toUpperCase().equals("RAR"))
            str = "ra.gif";
        else
        if(ext.toUpperCase().equals("RAM"))
            str = "ra.gif";
        else
        if(ext.toUpperCase().equals("RA"))
            str = "ra.gif";
        else
        if(ext.toUpperCase().equals("MPEG"))
            str = "avi.gif";
        else
        if(ext.toUpperCase().equals("AVI"))
            str = "avi.gif";
        else
        if(ext.toUpperCase().equals("ASF"))
            str = "avi.gif";
        else
        if(ext.toUpperCase().equals("GVA"))
            str = "avi.gif";
        else
        if(ext.toUpperCase().equals("HWP"))
            str = "hwp.gif";
        else
        if(ext.toUpperCase().equals("DOC"))
            str = "defalut.gif";
        else
        if(ext.toUpperCase().equals("PDF"))
            str = "defalut.gif";
        else
            str = "unknown.gif";
        return str;
    }

    public static String Reply(String org, String RName)
    {
        int winColumns = 60;
        if(RName != null)
            org = "---------- [" + RName + "] ´ÔÀÇ ±Û --------\n" + org;
        org = "\n> " + org + "\n";
        int pos = 1;
        for(int beforePos = 1; (pos = org.indexOf("\n", beforePos)) != -1; beforePos = ++pos)
        {
            String left = "";
            String right = "";
            if(pos - beforePos > winColumns - 26)
            {
                int midPos = org.lastIndexOf(" ", beforePos + (winColumns - 26));
                if(midPos < beforePos + (winColumns - 26) / 2)
                {
                    midPos = beforePos + winColumns;
                    if(midPos > pos)
                        midPos = pos;
                    left = org.substring(0, midPos);
                    right = org.substring(midPos, org.length());
                } else
                {
                    left = org.substring(0, midPos);
                    right = org.substring(midPos + 1, org.length());
                }
                org = left + "\n" + right;
                pos = midPos;
            }
            left = org.substring(0, pos + 1);
            right = org.substring(pos + 1, org.length());
            org = left + "> " + right;
        }

        org = org + " -------------------------------------\n\n";
        return org;
    }

    public static String Reply(String org)
    {
        String orgs = Reply(org, null);
        return orgs;
    }

    public static String toText(String args)
    {
        String str = "";
        try
        {
            StringBuffer strTxt = new StringBuffer("");
            int len = 0;
            int i = 0;
            len = args.length();
            for(i = 0; i < len; i++)
            {
                char charBuff = args.charAt(i);
                switch(charBuff)
                {
                case 60: // '<'
                    strTxt.append("&lt");
                    break;

                case 62: // '>'
                    strTxt.append("&gt");
                    break;

                case 10: // '\n'
                    strTxt.append("<br>");
                    break;

                case 32: // ' '
                    strTxt.append("&nbsp;");
                    break;

                default:
                    strTxt.append(charBuff);
                    break;

                case 13: // '\r'
                    break;
                }
            }

            str = strTxt.toString();
        }
        catch(Exception exception) { }
        return str;
    }

    public static String toHan(String s)
    {
        try
        {
            if(s != null)
                return new String(s.getBytes(), "ksc5601");
            else
                return s;
        }
        catch(UnsupportedEncodingException ex)
        {
            return "Encoding Error";
        }
    }

    public static String toEng(String s)
    {
        try
        {
            if(s != null)
                return new String(s.getBytes("EUC_KR"), "8859_1");
            else
                return s;
        }
        catch(UnsupportedEncodingException ex)
        {
            return "Encoding Error";
        }
    }

    public static String replaceStr(String org, String from, String to)
    {
        int last = 0;
        int next = 0;
        String result = "";
        String uppper_str = org.toUpperCase();
        from = from.toUpperCase();
        do
        {
            next = uppper_str.indexOf(from, last);
            if(next >= 0)
            {
                result = result + org.substring(last, next) + to;
                last = next + from.length();
            } else
            {
                result = result + org.substring(last);
                return result;
            }
        } while(true);
    }

    public static String getColorCode(String code)
        throws IOException
    {
        if(code == null)
            return "#B4E82E";
        String color = "";
        if(code.equals("1000"))
            color = "#B4E82E";
        else
        if(code.equals("1001"))
            color = "#FFDE2F";
        else
        if(code.equals("1002"))
            color = "#FFAAA9";
        else
        if(code.equals("1003"))
            color = "#7CDEC7";
        else
        if(code.equals("1004"))
            color = "#91C9FF";
        else
        if(code.equals("1005"))
            color = "#BCB8E5";
        else
        if(code.equals("1006"))
            color = "#FFA4CB";
        else
        if(code.equals("1193"))
            color = "#FF9900";
        else
        if(code.equals("1194"))
            color = "#CC6566";
        else
        if(code.equals("1195"))
            color = "#A49FD3";
        return color;
    }

    public static String RenameFileName(String fileName)
        throws IOException
    {
        if(fileName == null || fileName.equals(""))
            return "";
        int cnt = 0;
        int n = 0;
        int filelength = 0;
        String str = "";
        filelength = fileName.length();
        StringTokenizer st2 = new StringTokenizer(fileName, "_");
        cnt = st2.countTokens();
        if(st2.hasMoreTokens())
        {
            for(int j = 0; j < cnt; j++)
                str = st2.nextToken();

            n = str.indexOf(".");
        }
        if(n != -1)
            fileName = fileName.substring(0, filelength - str.length() - 1) + str.substring(n, str.length());
        else
            fileName = fileName.substring(0, filelength - str.length() - 1);
        return fileName;
    }

    public static String propLoad(String keys)
        throws IOException
    {
        String VALUE = "";
        String PROPERTY_PATH = "C:/InetPub/wwwroot/pds/config.properties";
        try
        {
            Properties prop = new Properties();
            prop.load(new FileInputStream(PROPERTY_PATH));
            VALUE = prop.getProperty(keys);
        }
        catch(IOException e)
        {
            throw e;
        }
        return VALUE;
    }

    public static void copyfile(String src, String dest)
        throws IOException
    {
        int return_val = 1;
        try
        {
            File srcFile = new File(src);
            File descFile = new File(dest);
            FileInputStream streamIn = new FileInputStream(srcFile);
            FileOutputStream streamOut = new FileOutputStream(descFile);
            int c;
            while((c = streamIn.read()) != -1) 
                streamOut.write(c);
            streamIn.close();
            streamOut.close();
        }
        catch(Exception e)
        {
            return_val = -1;
        }
    }
}
