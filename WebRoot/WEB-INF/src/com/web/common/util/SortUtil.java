package com.web.common.util;

import java.util.ArrayList;
import java.util.Arrays;
import org.apache.log4j.Logger;

// Referenced classes of package com.audien.common.util:
//            LogUtil

public class SortUtil
{

    public SortUtil()
    {
    }

    public static void main(String args[])
    {
        String strArray[] = {
            "0", "4", "0", "0", "3", "0", "4", "0", "8", "0", 
            "0", "3", "0", "0", "0", "2", "0", "0", "0", "0", 
            "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", 
            "10", "225", "28", "47", "6", "7", "70"
        };
        ArrayList list = sortByIndexString(strArray, "ASC");
    }

    public static Object[] sort(Object array[])
    {
        Arrays.sort(array);
        return array;
    }

    public static ArrayList sortByIndexInt(Integer array[], String sortType)
    {
        ArrayList list = new ArrayList();
        int temp[] = new int[array.length];
        for(int i = 0; i < array.length; i++)
            temp[i] = array[i].intValue();

        array = (Integer[])sort(array);
        if("ASC".equals(sortType))
        {
            for(int i = 0; i < array.length; i++)
            {
                int idx = 0;
                for(int j = 0; j < array.length; j++)
                {
                    if(temp[j] != array[i].intValue())
                        continue;
                    idx = j;
                    temp[j] = -1;
                    break;
                }

                list.add((new StringBuffer(String.valueOf(idx))).toString());
            }

        } else
        {
            for(int i = array.length - 1; i > -1; i--)
            {
                int idx = 0;
                for(int j = 0; j < array.length; j++)
                {
                    if(temp[j] != array[i].intValue())
                        continue;
                    idx = j;
                    temp[j] = -1;
                    break;
                }

                list.add((new StringBuffer(String.valueOf(idx))).toString());
            }

        }
        return list;
    }

    public static ArrayList sortByIndexLong(Long array[], String sortType)
    {
        ArrayList list = new ArrayList();
        long temp[] = new long[array.length];
        for(int i = 0; i < array.length; i++)
            temp[i] = array[i].longValue();

        array = (Long[])sort(array);
        if("ASC".equals(sortType))
        {
            for(int i = 0; i < array.length; i++)
            {
                int idx = 0;
                for(int j = 0; j < array.length; j++)
                {
                    if(temp[j] != array[i].longValue())
                        continue;
                    idx = j;
                    temp[j] = -1L;
                    break;
                }

                list.add((new StringBuffer(String.valueOf(idx))).toString());
            }

        } else
        {
            for(int i = array.length - 1; i > -1; i--)
            {
                int idx = 0;
                for(int j = 0; j < array.length; j++)
                {
                    if(temp[j] != array[i].longValue())
                        continue;
                    idx = j;
                    temp[j] = -1L;
                    break;
                }

                list.add((new StringBuffer(String.valueOf(idx))).toString());
            }

        }
        return list;
    }

    public static ArrayList sortByIndexFloat(Float array[], String sortType)
    {
        ArrayList list = new ArrayList();
        float temp[] = new float[array.length];
        for(int i = 0; i < array.length; i++)
            temp[i] = array[i].floatValue();

        array = (Float[])sort(array);
        if("ASC".equals(sortType))
        {
            for(int i = 0; i < array.length; i++)
            {
                int idx = 0;
                for(int j = 0; j < array.length; j++)
                {
                    if(temp[j] != array[i].floatValue())
                        continue;
                    idx = j;
                    temp[j] = -1F;
                    break;
                }

                list.add((new StringBuffer(String.valueOf(idx))).toString());
            }

        } else
        {
            for(int i = array.length - 1; i > -1; i--)
            {
                int idx = 0;
                for(int j = 0; j < array.length; j++)
                {
                    if(temp[j] != array[i].floatValue())
                        continue;
                    idx = j;
                    temp[j] = -1F;
                    break;
                }

                list.add((new StringBuffer(String.valueOf(idx))).toString());
            }

        }
        return list;
    }

    public static ArrayList sortByIndexString(String array[], String sortType)
    {
        ArrayList list = new ArrayList();
        String temp[] = new String[array.length];
        for(int i = 0; i < array.length; i++)
            temp[i] = array[i];

        array = (String[])sort(array);
        if("ASC".equals(sortType))
        {
            for(int i = 0; i < array.length; i++)
            {
                int idx = 0;
                for(int j = 0; j < array.length; j++)
                {
                    if(!temp[j].equals(array[i]))
                        continue;
                    idx = j;
                    temp[j] = "";
                    break;
                }

                list.add((new StringBuffer(String.valueOf(idx))).toString());
            }

        } else
        {
            for(int i = array.length - 1; i > -1; i--)
            {
                int idx = 0;
                for(int j = 0; j < array.length; j++)
                {
                    if(!temp[j].equals(array[i]))
                        continue;
                    idx = j;
                    temp[j] = "";
                    break;
                }

                list.add((new StringBuffer(String.valueOf(idx))).toString());
            }

        }
        return list;
    }

    private static Logger logger = LogUtil.getLogger("consoleLogger");

    static 
    {
        LogUtil.instance();
    }
}
