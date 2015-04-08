package com.web.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.framework.util.DateTimeUtil;
import com.web.framework.util.FileUtil;
import com.web.framework.util.StringUtil;
import com.web.framework.logging.Log;
import com.web.framework.logging.LogFactory;

public class inCopyServlet  extends HttpServlet {

    Log log = LogFactory.getLog(getClass());
	public static String NAS_PATH = FileUtil.NAS_PATH;
	//public static String TEMP_PATH = NAS_PATH+"/ScanUpload";
	public static String TEMP_PATH = FileUtil.TEMP_PATH;
	//String RDPath=NAS_PATH+"/RDRcv";
	public static String REAL_PATH ="";
    
    public void doGet(HttpServletRequest request,HttpServletResponse reponse)
    throws ServletException, IOException {

    try
	    {     
	    	//파일카피(NAS로 파일이동) START
	
    		System.out.println("################");
			String inPath=StringUtil.nvl(request.getParameter("filepath"),"");
			String inName=StringUtil.nvl(request.getParameter("filename"),"");
			String UFID=StringUtil.nvl(request.getParameter("UFID"),"");
				
				
			File wasfile=null;
					
			String inFilePath=NAS_PATH+"/"+inPath;
					
			wasfile = new File(inFilePath,inName);
			log.debug("Path:"+inFilePath);
			log.debug("Files:"+inName);

					log.debug("file.exists()"+wasfile.exists());
					if(wasfile.exists()){//WAS에 파일이 존재할경우
					
				        FileInputStream inFile = null;
			
			        	inFile = new FileInputStream(wasfile);
			        	
			        	String filePath=NAS_PATH+"/Image/Send/"+DateTimeUtil.getDate();
						boolean check=setDirectory(filePath);
			            
			            FileOutputStream outFile= new FileOutputStream(filePath+"/"+UFID+".tif");//NAS 경로를 정한다.
				         
			            byte b[] = new byte[1024];
			            
			            try {
			                int nRead;
			                do {
			                    nRead = inFile.read( b );
			                    outFile.write( b, 0, nRead );
			                } while ( nRead == 1024 );
			
			            } catch ( Exception e ) {
			            	e.printStackTrace();
			            } finally {
			                if ( inFile != null )
			                	inFile.close();
			                if(outFile != null){
			                	outFile.close();
			                }
			            }

					}
		
	    }catch(Exception e){
	       e.printStackTrace();
	    }
	   

    }  
	/**
	 * 업로드 디렉토리 세팅
	 */
	private static boolean setDirectory( String directory) {
		File wantedDirectory = new File(directory);
		if (wantedDirectory.isDirectory())
			return true;
	    
		return wantedDirectory.mkdirs();
	}
	
} 
    
    

