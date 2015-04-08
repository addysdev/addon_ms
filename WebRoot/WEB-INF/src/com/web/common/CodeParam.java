package com.web.common;

import com.web.framework.util.StringUtil;

/**
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CodeParam {
	protected String systemcode=""; 
	protected String type="";
	protected String name="";
	protected String selected="";
	protected String event="";
	protected String first="";
	protected String etc="";
	protected String style="";
	protected String styleClass="";
	
	/**
	 * 
	 */
	public CodeParam() {
		super();
		// TODO Auto-generated constructor stub
	}
	
    
    
	/**
     * @return Returns the styleClass.
     */
    public String getStyleClass() {
        return styleClass;
    }



    /**
     * @param styleClass The styleClass to set.
     */
    public void setStyleClass(String styleClass) {
        this.styleClass = styleClass;
    }



    /**
     * @return Returns the style.
     */
    public String getStyle() {
        return style;
    }


    /**
     * @param style The style to set.
     */
    public void setStyle(String style) {
        this.style = style;
    }


    /**
	 * @return Returns the event.
	 */
	public String getEvent() {
		return event;
	}
	/**
	 * @param event The event to set.
	 */
	public void setEvent(String event) {
		this.event = event;
	}
	/**
	 * @return Returns the first.
	 */
	public String getFirst() {
		return first;
	}
	/**
	 * @param first The first to set.
	 */
	public void setFirst(String first) {
		this.first = first;
	}
	/**
	 * @return Returns the name.
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name The name to set.
	 */
	public void setName(String name) {
		this.name = StringUtil.outDataConverter(name);
	}
	/**
	 * @return Returns the selected.
	 */
	public String getSelected() {
		return selected;
	}
	/**
	 * @param selected The selected to set.
	 */
	public void setSelected(String selected) {
		this.selected = selected;
	}
	/**
	 * @return Returns the systemcode.
	 */
	public String getSystemcode() {
		return systemcode;
	}
	/**
	 * @param systemcode The systemcode to set.
	 */
	public void setSystemcode(String systemcode) {
		this.systemcode = systemcode;
	}
	/**
	 * @return Returns the type.
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type The type to set.
	 */
	public void setType(String type) {
		this.type = type;
	}
	/**
	 * @return Returns the etc.
	 */
	public String getEtc() {
		return etc;
	}
	/**
	 * @param etc The etc to set.
	 */
	public void setEtc(String etc) {
		this.etc = etc;
	}
}
