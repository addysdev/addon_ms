package com.web.common.util;

import org.apache.log4j.Logger;

import java.sql.*;

import javax.naming.*;
import javax.sql.*;

public class ConnectionManager {
	Logger logger = LogUtil.instance().getLogger("consoleLogger");

	private static ConnectionManager instance = new ConnectionManager();
	private Context initContext = null;
	private Context envContext = null;
	private DataSource ds = null;
	private Connection conn = null;

	private ConnectionManager() {
		logger.debug("Initialize ConnectionManager");
		init();
		logger.debug("Initialize ConnectionManager Success");
	}

	private void init() {
		try {
			initContext = new InitialContext();
			envContext  = (Context)initContext.lookup("java:/comp/env");

		} catch (NamingException ne) {
			ne.printStackTrace();
			logger.error("ConnectionManager@init NamingException : " + ne.getMessage(), ne);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("ConnectionManager@init Exception : " + e.getMessage(), e);
		}
	}

	public static ConnectionManager getInstance() {
		return instance;
	}

	public Connection getConnection(String jdbcname) throws Exception {
		synchronized (ConnectionManager.class) {
			
			try {

				if (ds == null) {
					logger.debug("DataSource is null!!");
					ds = (DataSource)envContext.lookup(jdbcname);
				}

				conn = ds.getConnection();
				logger.debug("DataSource is connected!!");
				return conn;
			} catch (NamingException ne) {
				ne.printStackTrace();
				logger.error("ConnectionManager@init NamingException : " + ne.getMessage(), ne);
				throw new Exception("ConnectionManager@init NamingException : " + ne.getMessage());
			} catch (SQLException se) {
				se.printStackTrace();
				logger.error("ConnectionManager@init SQLException : " + se.getMessage(), se);
				throw new Exception("ConnectionManager@init SQLException : " + se.getMessage());
			} catch (Exception e) {
				e.printStackTrace();
				logger.error("ConnectionManager@init Exception : " + e.getMessage(), e);
				throw new Exception("ConnectionManager@init Exception : " + e.getMessage());
			}
		}
	}

	public Connection getConnection() throws Exception {
		try {
			return getConnection("jdbc/huation");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("ConnectionManager@init Exception : " + e.getMessage(), e);
			throw new Exception("ConnectionManager@init Exception : " + e.getMessage());
		}
	}
}