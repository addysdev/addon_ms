// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) ansi 
// Source File Name:   ListDTO.java

package com.web.common.transfer;

import java.util.*;

// Referenced classes of package com.audien.common.transfer:
//            DTO, IDTO

public abstract class ListDTO extends DTO
{

    public ListDTO()
    {
        itemList = new ArrayList(10);
    }

    public ListDTO(List itemList)
    {
        this.itemList = itemList;
    }

    public final IDTO get(int index)
    {
        return (IDTO)itemList.get(index);
    }

    public List getItemList()
    {
        return itemList;
    }

    public void setItemList(List itemList)
    {
        this.itemList = itemList;
    }

    public final int size()
    {
        return itemList.size();
    }

    public final Iterator iterator()
    {
        return itemList.iterator();
    }

    public final void sort()
    {
        Collections.sort(itemList);
    }

    public final void sort(Comparator c)
    {
        Collections.sort(itemList, c);
    }

    public final boolean add(IDTO object)
    {
        return itemList.add(object);
    }

    public final boolean addAll(List list)
    {
        return itemList.addAll(list);
    }

    public final boolean addAll(int index, List list)
    {
        return itemList.addAll(index, list);
    }

    public final boolean isEmpty()
    {
        return itemList.isEmpty();
    }

    private List itemList;
}
