package com.web.common.util;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.*;

public class DateUtil
{

    public DateUtil()
    {
    }

    public static String getTime()
    {
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
        return sdf.format(d);
    }

    public static String getTime(String format)
    {
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(d);
    }

    public static String getCurrentDate()
    {
        return getCurrentDate("yyyyMMdd");
    }

    public static String getCurrentDate(String format)
    {
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(d);
    }

    public static String getThisMonth()
    {
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
        return sdf.format(d);
    }

    public static String getThisYear()
    {
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        return sdf.format(d);
    }

    public static String getCurrentTime()
    {
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
        return sdf.format(d);
    }

    public static String getDayInterval(String format, int distance)
    {
        Calendar cal = getCalendar();
        cal.roll(5, distance);
        Date d = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(d);
    }
    public static String getDayInterval2(int distance)
    {
	    Calendar cal = new GregorianCalendar();
	    cal.add(Calendar.DATE,distance);
	    
	    String month="01";
	    
	    if((cal.get(Calendar.MONTH) + 1)<10){
	    	month="0"+(cal.get(Calendar.MONTH) + 1);
	    }else{
	    	month=""+(cal.get(Calendar.MONTH) + 1);
	    }
	    
	    String day="01";
	    
	    if(cal.get(Calendar.DAY_OF_MONTH)<10){
	    	day="0"+cal.get(Calendar.DAY_OF_MONTH);
	    }else{
	    	day=""+cal.get(Calendar.DAY_OF_MONTH);
	    }

	    return cal.get(Calendar.YEAR)+"-"+month+"-"+day;

    }
    public static String getDayInterval(String dateString, String format, int distance)
    {
        Calendar cal = getCalendar(dateString);
        cal.roll(5, distance);
        Date d = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(d);
    }

    public static String getYesterday()
    {
        Calendar cal = getCalendar();
        cal.roll(5, -1);
        Date d = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        return sdf.format(d);
    }

    public static String getLastMonth()
    {
        Calendar cal = getCalendar();
        cal.roll(2, -1);
        Date d = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM");
        return sdf.format(d);
    }

    public static String[] getDates(String startDay, String endDay)
    {
        Vector v = new Vector();
        v.addElement(startDay);
        Calendar cal = getCalendar();
        cal.setTime(string2Date(startDay));
        for(String nextDay = date2String(cal.getTime()); !nextDay.equals(endDay); v.addElement(nextDay))
        {
            cal.add(5, 1);
            nextDay = date2String(cal.getTime());
        }

        String go[] = new String[v.size()];
        v.copyInto(go);
        return go;
    }

    public static Calendar getCalendar()
    {
        Calendar calendar = new GregorianCalendar(TimeZone.getTimeZone("GMT+09:00"), Locale.KOREA);
        calendar.setTime(new Date());
        return calendar;
    }

    public static Calendar getCalendar(String dateString)
    {
        Calendar calendar = new GregorianCalendar(TimeZone.getTimeZone("GMT+09:00"), Locale.KOREA);
        calendar.setTime(string2Date(dateString, "yyyyMMdd"));
        return calendar;
    }

    public static Calendar getCalendar(Date date)
    {
        Calendar calendar = new GregorianCalendar(TimeZone.getTimeZone("GMT+09:00"), Locale.KOREA);
        calendar.setTime(date);
        return calendar;
    }

    public static String date2String(Date d)
    {
        return date2String(d, "yyyyMMdd");
    }

    public static String date2String(Date d, String format)
    {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(d);
    }

    public static Date string2Date(String s)
    {
        return string2Date(s, "yyyy/MM/dd");
    }

    public static Date string2Date(String s, String format)
    {
        Date d = null;
        try
        {
            SimpleDateFormat sdf = new SimpleDateFormat(format);
            d = sdf.parse(s, new ParsePosition(0));
        }
        catch(Exception e)
        {
            throw new RuntimeException("Date format not valid.");
        }
        return d;
    }

    public static long getDayDistance(String startDate, String endDate)
        throws Exception
    {
        return getDayDistance(startDate, endDate, null);
    }

    public static long getDayDistance(String startDate, String endDate, String format)
        throws Exception
    {
        if(format == null)
            format = "yyyyMMdd";
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        long day2day = 0L;
        try
        {
            Date sDate = sdf.parse(startDate);
            Date eDate = sdf.parse(endDate);
            day2day = (eDate.getTime() - sDate.getTime()) / 0x5265c00L;
        }
        catch(Exception e)
        {
            throw new Exception("wrong format string");
        }
        return Math.abs(day2day);
    }
}
