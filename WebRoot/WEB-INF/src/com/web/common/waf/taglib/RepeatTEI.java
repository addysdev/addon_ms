package com.web.common.waf.taglib;

import javax.servlet.jsp.tagext.*;

public class RepeatTEI extends TagExtraInfo
{

    public RepeatTEI()
    {
    }

    public VariableInfo[] getVariableInfo(TagData data)
    {
        String id = data.getAttributeString("id");
        String type = data.getAttributeString("type");
        String idx = data.getAttributeString("idx");
        if(idx == null)
            idx = "idx";
        String idxType = "java.lang.Integer";
        VariableInfo info[] = {
            new VariableInfo(id, type, true, 0), new VariableInfo(idx, idxType, true, 0)
        };
        return info;
    }
}
