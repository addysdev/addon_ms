package com.web.common.util;

import java.io.PrintStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

// Referenced classes of package com.audien.common.util:
//            Base64Util

public class SecurityUtil
{

    public SecurityUtil()
    {
    }

    public static byte[] digest(String alg, byte input[])
        throws NoSuchAlgorithmException
    {
        MessageDigest md = MessageDigest.getInstance(alg);
        return md.digest(input);
    }

    public static String getCryptoMD5String(String inputValue)
        throws Exception
    {
        if(inputValue == null)
        {
            throw new Exception("Can't conver to Message Digest 5 String value!!");
        } else
        {
            byte ret[] = digest("MD5", inputValue.getBytes());
            String result = Base64Util.encode(ret);
            return result;
        }
    }

    public static void main(String args[])
    {
        String ary[] = {
            "1111", "2222", "3333", "4444", "5555", "6666"
        };
        try
        {
            for(int i = 0; i < ary.length; i++)
                System.out.println(ary[i] + " : " + getCryptoMD5String(ary[i]));

        }
        catch(Exception exception) { }
    }
}
