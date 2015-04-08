package com.web.common.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
//import sun.misc.BASE64Decoder;
//import sun.misc.BASE64Encoder;

public class Base64Util
{

    public Base64Util()
    {
    }

    public static String encode(byte encodeBytes[])
    {
      //  BASE64Encoder base64Encoder = new BASE64Encoder();
        ByteArrayInputStream bin = new ByteArrayInputStream(encodeBytes);
        ByteArrayOutputStream bout = new ByteArrayOutputStream();
        byte buf[] = (byte[])null;
        try
        {
        //    base64Encoder.encodeBuffer(bin, bout);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        buf = bout.toByteArray();
        return (new String(buf)).trim();
    }

    public static byte[] decode(String strDecode)
    {
       // BASE64Decoder base64Decoder = new BASE64Decoder();
        ByteArrayInputStream bin = new ByteArrayInputStream(strDecode.getBytes());
        ByteArrayOutputStream bout = new ByteArrayOutputStream();
        byte buf[] = (byte[])null;
        try
        {
       //     base64Decoder.decodeBuffer(bin, bout);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        buf = bout.toByteArray();
        return buf;
    }
}
