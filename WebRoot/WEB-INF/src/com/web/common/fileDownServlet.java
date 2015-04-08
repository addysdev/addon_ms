package com.web.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.framework.util.FileUtil;
import com.web.framework.util.StringUtil;
import com.web.framework.configuration.Configuration;
import com.web.framework.configuration.ConfigurationFactory;
import com.web.framework.logging.Log;
import com.web.framework.logging.LogFactory;

public class fileDownServlet  extends HttpServlet {
    
    Log log = LogFactory.getLog(getClass());
	protected static Configuration config = ConfigurationFactory.getInstance().getConfiguration();

    public void doGet(HttpServletRequest req,HttpServletResponse resp)
    throws ServletException, IOException {

    try
    {
             
        //String rFileName = StringUtil.nvl(req.getParameter("rFileName"));
        String sFileName = StringUtil.nvl(req.getParameter("sFileName"));
        String filePath =StringUtil.nvl(req.getParameter("filePath"),"Order");
        String ServerID =StringUtil.nvl(req.getParameter("ServerID"),"01");
        
        String FILE_PATH="C://Addys";
        
        FILE_PATH=FILE_PATH+"/"+filePath;
	   
      //  File file		=	new File(FileUtil.NAS_PATH +"/"+filePath+"/"+sFileName);
        File file		=	new File(FILE_PATH+"/"+sFileName);
        log.debug("fileFullPath::"+FILE_PATH+"/"+ sFileName);
        String file_name = req.getParameter( "file_name" );
        if ( file_name==null || file_name.equals("") ) {


        }
          FileInputStream in = null;
        
        try {
            in = new FileInputStream(file);
        } catch ( Exception e ) {
            e.printStackTrace();
        }
         
        resp.setContentType( "application/x-msdownload" );
        resp.setHeader( "Content-Disposition", "attachment; filename=\""+ URLEncoder.encode(sFileName, "UTF-8") + "\"" );
        //resp.setHeader( "Content-Disposition", "attachment; filename=\""+ rFileName + "\"" );
        resp.setHeader( "Content-Transfer-Coding", "binary" );

        ServletOutputStream binaryOut = resp.getOutputStream();
        byte b[] = new byte[1024];
         
        try {
            int nRead;
            do {
                nRead = in.read( b );
                binaryOut.write( b, 0, nRead );
            } while ( nRead == 1024 );

        } catch ( Exception e ) {

        } finally {
            if ( in != null )
                in.close();
            if(binaryOut != null){
            	binaryOut.close();
            }
        }

    }catch(Exception e)
    {
       e.printStackTrace();
    }
}
} 
    
    

