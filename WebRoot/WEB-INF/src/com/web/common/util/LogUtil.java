package com.web.common.util;

import java.util.Properties;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

public class LogUtil
{
	
	public static Properties jvmEnv = System.getProperties();
	public static String homedir=jvmEnv.getProperty("framework.home");

    public LogUtil()
    {
        init();
    }

    public static LogUtil instance()
    {
        if(instance == null)
        {
            instance = new LogUtil();
            callCount++;
        }
        return instance;
    }

    public static void init(String fileName)
    {

        String resource = "".equals(fileName) ? homedir+"\\config\\framework.properties" : fileName;
    	PropertyConfigurator.configure(resource);
    }

    public static void init()
    {
        init(homedir+"\\config\\log4j.properties");
    	
    }

    public static Logger getLogger(Class c)
    {
        return Logger.getLogger(c);
    }

    public static Logger getLogger(String s)
    {
        return Logger.getLogger(s);
    }

    private static final String PropFILE = homedir+"\\config\\log4j.properties";
    private static LogUtil instance = null;
    private static int callCount = 0;

}
