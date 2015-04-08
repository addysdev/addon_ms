package com.web.common.util;

import java.io.*;
import java.util.Properties;

public class PropertyManager
{

    public PropertyManager()
    {
        prop = new Properties();
        init("\\WEB-INF\\config\\connect.properties");
    }

    public static PropertyManager getInstance()
    {
        return instance;
    }

    public void init(String filePath)
    {
        try
        {
            FileInputStream fis = new FileInputStream(filePath);
            prop = new Properties();
            prop.load(fis);
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
    }

    public String getPropertyValue(String name)
    {
        return prop.getProperty(name);
    }

    public static void main(String args[])
    {
        try
        {
            PropertyManager ppm = getInstance();
            System.out.println("profile name : " + ppm.getPropertyValue("CONNECT.PROFILENAME"));
            System.out.println("ip address : " + ppm.getPropertyValue("CONNECT.IPADDRESS"));
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

    private static PropertyManager instance = new PropertyManager();
    private Properties prop;
    private final String file_path = "\\WEB-INF\\config\\connect.properties";
}
