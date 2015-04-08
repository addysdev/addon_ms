package com.web.common.util;

import java.io.Serializable;
import java.util.ArrayList;

public class ListDTO implements Serializable{

	 private int iCurrentPage		= 1;
     private int iListScale			= 10; // 리스트의 갯수
     private int iPageScale			= 10; // 페이지 갯수
     private int iTotalPageCount	= 0; // 전체 페이지 갯수
     private int iTotalItemCount    = 0; // 전체 아이템 갯수
     private ArrayList  arrayList = null;


	 public ListDTO(int iCurrentPage, int totalitemcount, int listScale, int pageScale){
			this.iListScale = listScale;
			this.iPageScale = pageScale;

			if(iCurrentPage <= 0) iCurrentPage = 1;
			this.iCurrentPage = iCurrentPage;
			this.iTotalItemCount = totalitemcount;
			if(this.iTotalItemCount%this.iListScale == 0) this.iTotalPageCount = this.iTotalItemCount/this.iListScale;
			else this.iTotalPageCount = this.iTotalItemCount/this.iListScale+1;

     }

    public void setArrayList(ArrayList result){
        arrayList = result;
    }

    public ArrayList getArrayList(){
        return arrayList;
    }

    public String getPageScript(String frm, String cur_page, String func_name){
        if(func_name == null || "".equals(func_name)) func_name = "goPage";

        StringBuffer result = new StringBuffer();

        result.append("\n<script language=\"javascript\">\n");
        result.append("function "+func_name+"(page,type){\n");
        result.append("\tif(page == null || page <= 0) return;\n");
        result.append("\tdocument.forms[\""+frm+"\"].elements[\""+cur_page+"\"].value = page;\n");
        result.append("\tdocument.forms[\""+frm+"\"].submit();\n");
        result.append("}\n");
        result.append("</script>\n");

        return result.toString();
    }

    public int getItemCount(){
    	if(this.iTotalItemCount < this.iListScale) return this.iTotalItemCount;
    	else return this.iListScale;
    }

    public String getPagging(String func_name){
		return getPagging(func_name,  "images/");
	}

    public String getPagging(String func_name, String contextPath){
        int iTemp=0;
        contextPath = contextPath +"common";
        if(getItemCount() < 1) return "";

        if(func_name == null || "".equals(func_name)) func_name = "goPage";
        StringBuffer page = new StringBuffer();
        int intStartPage =((int)Math.ceil((double)iCurrentPage/(double)iPageScale)-1)*iPageScale+1;

        if (intStartPage>1) {
           page.append("<a href=\"javascript:"+func_name+"("+(intStartPage-iPageScale)+",2)\" onMouseOver=\"window.status='Previous Page'; return true\" onMouseOut=\"window.status=''; return true\" target='_self'><img src=\""+contextPath+"/images/sub/btn_icon_relocation.gif\" border=0 align=absmiddle></a>\n");
        }else{
           page.append("<img src=\""+contextPath+"/images/sub/btn_icon_relocation.gif\" border=0 align=absmiddle>\n");
        }
		if (iCurrentPage > 1) {
		   page.append("<a href=\"javascript:"+func_name+"("+(iCurrentPage-1)+",2)\" onMouseOver=\"window.status='First Page'; return true\" onMouseOut=\"window.status=''; return true\"> <img src=\""+contextPath+"/images/sub/btn_text_relocation.gif\" border=0 title='Prev Page' align=absmiddle></a>&nbsp;\n");
		}
		else {
		   page.append("<img src=\""+contextPath+"/images/sub/btn_text_relocation.gif\" border=0 title=\"Prev Page\" align=absmiddle>&nbsp;\n");
		}

        for (int i=intStartPage; i<intStartPage + iPageScale ; i++) {
                iTemp=i;
                if (i<=iTotalPageCount) {
                     if (i !=iCurrentPage) {
                    page.append("<a href=\"javascript:"+func_name+"("+i+",2)\" onMouseOver=\"window.status='page " + i + "'; return true\" onMouseOut=\"window.status=''; return true\" class='b_list01'>"+i+"</a>&nbsp;\n");
                } else {
                      page.append("<font class='text_pageNo'>"+ i +"</font>&nbsp;\n");
                         }
                } else	{
                        break;
                }
         }

        if (iCurrentPage < iTotalPageCount) {
           page.append("<a href=\"javascript:"+func_name+"("+(iCurrentPage+1)+",2)\" onMouseOver=\"window.status='Next Page'; return true\" onMouseOut=\"window.status=''; return true\"> <img src=\""+contextPath+"/images/sub/btn_text_next.gif\" border=0 title='Next Page' align=absmiddle></a>\n");
        }
        else {
           page.append("<img src=\""+contextPath+"/images/sub/btn_text_next.gif\" border=0 title='Next Page' align=absmiddle>\n");
        }

		if (iTemp+1<= iTotalPageCount) {
		  page.append("<a href=\"javascript:"+func_name+"("+(iTemp+1)+",2)\"  onMouseOver=\"window.status='Next Page'; return true\" onMouseOut=\"window.status=''; return true\"><img src=\""+contextPath+"/images/sub/btn_icon_next.gif\" border=0 align=absmiddle></a>\n");
		}else{
		  page.append("<img src=\""+contextPath+"/images/sub/btn_icon_next.gif\" border=0 align=absmiddle>\n");
		}

       return page.toString();
    }

}
