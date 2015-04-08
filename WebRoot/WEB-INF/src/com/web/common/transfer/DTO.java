package com.web.common.transfer;


// Referenced classes of package com.audien.common.transfer:
//            IDTO

public abstract class DTO
    implements IDTO
{

    public DTO()
    {
        page = 1;
        pageSize = 0x7fffffff;
        responseCode = "0";
        message = "";
        responseCode = "0";
    }

    public String getMessage()
    {
        return message;
    }

    public void setMessage(String message)
    {
        this.message = message;
    }

    public String getResponseCode()
    {
        return responseCode;
    }

    public void setResponseCode(String responseCode)
    {
        this.responseCode = responseCode;
    }

    public int getPage()
    {
        return page;
    }

    public void setPage(int page)
    {
        this.page = page;
    }

    public int getPageSize()
    {
        return pageSize;
    }

    public void setPageSize(int pageSize)
    {
        this.pageSize = pageSize;
    }

    private int page;
    private int pageSize;
    private String responseCode;
    private String message;
}
