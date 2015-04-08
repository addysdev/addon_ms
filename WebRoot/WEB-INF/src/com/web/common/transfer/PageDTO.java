package com.web.common.transfer;

import java.util.List;

// Referenced classes of package com.audien.common.transfer:
//            ListDTO

public abstract class PageDTO extends ListDTO
{

    public PageDTO()
    {
    }

    public PageDTO(List itemList)
    {
        super(itemList);
    }

    public PageDTO(List itemList, int page, int pageSize, int totalCount)
    {
        super(itemList);
        setPage(page);
        setPageSize(pageSize);
        setTotalCount(totalCount);
    }

    public final int getEndNumber()
    {
        int temp = (getStartNumber() + getPageSize()) - 1;
        int end = temp > totalCount ? totalCount : temp;
        return end;
    }

    public final int getTotalCount()
    {
        return totalCount;
    }

    public final void setTotalCount(int totalCount)
    {
        this.totalCount = totalCount;
    }

    public final int getTotalPage()
    {
        if(getPageSize() == 0x7fffffff)
            return 1;
        else
            return getTotalCount() / getPageSize() + (getTotalCount() % getPageSize() == 0 ? 0 : 1);
    }

    public final boolean hasNextPage()
    {
        return getPage() != getTotalPage();
    }

    public final boolean hasPreviousPage()
    {
        return getPage() != 1;
    }

    public final int getStartNumber()
    {
        return (getPage() - 1) * getPageSize() + 1;
    }

    private int totalCount;
}
