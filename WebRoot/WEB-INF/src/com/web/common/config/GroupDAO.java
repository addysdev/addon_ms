package com.web.common.config;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.web.common.config.GroupDTO;
import com.web.common.user.UserDTO;
import com.web.framework.data.DataSet;
import com.web.framework.persist.AbstractDAO;
import com.web.framework.persist.DAOException;
import com.web.framework.persist.ISqlStatement;
import com.web.framework.persist.ListDTO;
import com.web.framework.persist.ListStatement;
import com.web.framework.persist.QueryStatement;
import com.web.framework.util.StringUtil;

public class GroupDAO extends AbstractDAO {
	/**
	 * 그룹  리스트 (일반 그룹 트리 리스트)
	 * @param  groupDto 그룹정보
	 * @return  arrlist ArrayList
	 * @throws DAOException
	 */
	public ArrayList groupTreeList(GroupDTO groupDto) throws DAOException {

		ArrayList<GroupDTO> arrlist = new ArrayList<GroupDTO>();
		
		String procedure = "{ CALL hp_mgGroupInquiry ( ? ,? ,? ,? ,? ) }";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(groupDto.getLogid());
		sql.setSql(procedure);
		sql.setString(groupDto.getChUserID());
		sql.setString(groupDto.getGroupID());
		sql.setString(groupDto.getJobGb());
		sql.setInteger(groupDto.getGroupStep());
		sql.setString(groupDto.getUserID());

		DataSet ds = null;
		
		try{
			
			ds = broker.executeProcedure(sql);

			while(ds.next()){
				 groupDto = new GroupDTO();
				 groupDto.setGroupID(ds.getString("GroupID"));
				 groupDto.setUpGroupID(ds.getString("UpGroupID"));
				 groupDto.setGroupName(ds.getString("GroupName"));
				 groupDto.setUserID(ds.getString("UserID"));
				 groupDto.setGroupStep(ds.getInt("GroupStep"));
				 groupDto.setGroupSort(ds.getInt("GroupSort"));

				 arrlist.add(groupDto);
			}

		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}

		return arrlist;
 	
	}
	/**
	 * 그룹 상세정보
	 * @param  groupDto 그룹정보
	 * @return  groupDto
	 * @throws DAOException
	 */
	public GroupDTO groupView(GroupDTO groupDto) throws DAOException {
		
		String GroupID=groupDto.getGroupID();

		String procedure = "{ CALL hp_mgGroupSelect ( ? ,? ,? ,? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(groupDto.getLogid());
		sql.setSql(procedure);
		sql.setString("");
		sql.setString("SELECT");
		sql.setString(GroupID);
		sql.setString("");

		try{
			
			ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				 groupDto = new GroupDTO();
				 groupDto.setGroupID(ds.getString("GroupID"));
				 groupDto.setUpGroupID(ds.getString("UpGroupID"));
				 groupDto.setGroupName(ds.getString("GroupName"));
				 groupDto.setGroupStep(ds.getInt("GroupStep"));
				 groupDto.setGroupSort(ds.getInt("GroupSort"));
				 groupDto.setFaxCnt(ds.getString("FaxCnt"));
			 }
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}

		return groupDto;
	}
	/**
	 * 그룹 등록
	 * @param groupDto 그룹정보
	 * @return groupDto GroupDTO
	 * @throws DAOException
	 */
	public GroupDTO groupInsert(GroupDTO groupDto) throws DAOException {

		String GroupID=groupDto.getGroupID();
		String IGroupID=groupDto.getIGroupID();
		String GroupName=groupDto.getGroupName();
		int GroupStep=1;
		
		String procedure = "{ CALL  hp_mgGroupRegist (? , ? , ? , ?)} ";
		
		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(groupDto.getLogid());
		sql.setSql(procedure);
		sql.setString("");
		sql.setString(GroupID);
		sql.setString(GroupName);
		sql.setString(IGroupID);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			if(ds.next()){ 
				 groupDto = new GroupDTO();
				 groupDto.setGroupID(ds.getString("R_GroupID"));
				 groupDto.setGroupStep(ds.getInt("R_GroupStep"));
				 groupDto.setGroupName(ds.getString("R_GroupName"));
				 log.debug("getGroupID"+groupDto.getGroupID());
				 log.debug("getGroupStep"+groupDto.getGroupStep());
			 }
			
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}
		
		return groupDto;	
    }
	/**
	 * 그룹 수정
	 * @param groupDto 그룹정보
	 * @return groupDto GroupDTO
	 * @throws DAOException
	 */
	public GroupDTO groupUpdate(GroupDTO groupDto) throws DAOException {
		
		String GroupID=groupDto.getGroupID();
		String GroupName=groupDto.getGroupName();
		int GroupStep=1;
		
		String procedure = "{ CALL  hp_mgGroupModify (? , ? , ? , ? , ? )} ";
		
		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(groupDto.getLogid());
		sql.setSql(procedure);
		sql.setString("");
		sql.setString(GroupID);
		sql.setString(GroupName);
		sql.setString("UPDATE");
		sql.setInteger(0);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			if(ds.next()){ 
				 groupDto = new GroupDTO();
				 groupDto.setGroupID(ds.getString("R_GroupID"));
				 groupDto.setGroupStep(ds.getInt("R_GroupStep"));
				 groupDto.setGroupName(ds.getString("R_GroupName"));
			 }
			
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}
		
		return groupDto;	
    }
	/**
	 * 그룹 삭제
	 * @param groupDto 그룹정보
	 * @return groupDto GroupDTO
	 * @throws DAOException
	 */
	public GroupDTO groupDelete(GroupDTO groupDto) throws DAOException {

		String GroupID=groupDto.getGroupID();
		String GroupName=groupDto.getGroupName();
		int GroupStep=1;
		
		String procedure = "{ CALL  hp_mgGroupDelete (? , ? )} ";
		
		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(groupDto.getLogid());
		sql.setSql(procedure);
		sql.setString("");
		sql.setString(GroupID);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			if(ds.next()){ 
				 groupDto = new GroupDTO();
				 groupDto.setGroupID(ds.getString("R_GroupID"));
				 groupDto.setGroupStep(ds.getInt("R_GroupStep"));

			 }
			
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}
		
		return groupDto;	
    }
	/**
	 * 그룹 순서정렬 (같은 뎁스의 순서를 변경한다)
	 * @param groupDto 그룹정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int groupOrderUpdate(GroupDTO groupDto) throws DAOException {
		
		int GroupSort=groupDto.getGroupSort();
		String GroupID=groupDto.getGroupID();

		String procedure = "{ CALL  hp_mgGroupModify (? , ? , ? , ? , ? )} ";
		
		DataSet ds = null;
		int retVal=-1;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(groupDto.getLogid());
		sql.setSql(procedure);
		sql.setString("");
		sql.setString(GroupID);
		sql.setString("");
		sql.setString("SORT");
		sql.setInteger(GroupSort);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			if(ds.next()){ 
				 retVal=ds.getInt("ResultCode");

			 }
			
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}	
		return retVal;	
    }
	/**
	 * 그룹명 중복체크
	 * @param groupDto 그룹정보
	 * @return groupDto GroupDTO 
	 * @throws DAOException
	 */
	public GroupDTO groupNameDupCheck(GroupDTO groupDto) throws DAOException {
		
		String GroupName=groupDto.getGroupName();

		String procedure = "{ CALL  hp_mgGroupSelect (? , ? , ? , ? )} ";
		
		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(groupDto.getLogid());
		sql.setSql(procedure);
		sql.setString("");
		sql.setString("DUPLICATE");
		sql.setString("1");
		sql.setString(GroupName);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			if(ds.next()){ 
				 groupDto = new GroupDTO();
				 groupDto.setResult(Integer.parseInt(ds.getString("Result")));

			 }
			
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}	
		
		return groupDto;	
    }
	public int changeGroupSort(String[] groupID, GroupDTO groupDto) {
		
		String procedure = "{ CALL hp_mgGroupSortChange (?, ?, ?, ? ) }";
		
		int retVal = 0;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; groupID != null && i<groupID.length; i++){ 
				
				List batch=new Vector();
				String[] GroupID_R = groupID[i].split("\\|");
				batch.add(GroupID_R[0]); //GroupID
				batch.add(GroupID_R[1]); //GroupSort
				batch.add(groupDto.getUpGroupID()); //UpGroupID
				batch.add(groupDto.getGroupStep()); //GroupStep
				
				batchList.add(batch);
			}
		
			sql.setBatch(batchList);
			resultVal=broker.executeProcedureBatch(sql);
			
			for(int i=0;i<resultVal.length;i++){
				if(resultVal[i]==-1){
					retVal=-1;
					break;
				}else{
					retVal=resultVal[i];
				}
			}
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally{
			return retVal;
		}
	}
	
	
	public int changeGroupStep(String logid, String selectGroupID) throws DAOException {
		

		String procedure = "{ CALL  hp_mgGroupStepChange (? )} ";
		
		DataSet ds = null;
		int retVal=-1;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(logid);
		sql.setSql(procedure);
		sql.setString(selectGroupID);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			if(ds.next()){ 
				 retVal=ds.getInt("ResultCode");

			 }
			
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}	
		return retVal;	
		
	}
	public String selectGroupInfo(GroupDTO groupDto) throws DAOException {
		String procedure = "{ CALL  hp_mgGroupSelect ( ? ,?, ?, ? )} ";
		
		DataSet ds = null;
		String retVal = "";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(groupDto.getLogid());
		sql.setSql(procedure);
		sql.setString("");
		sql.setString("SELECT");
		sql.setString(groupDto.getGroupID());
		sql.setString(null);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			if(ds.next()){ 
				 retVal=ds.getString("GroupStep");

			 }
			
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}	
		return retVal;	
	}
	public int checkGroupName(GroupDTO groupDto) throws DAOException {
			
			String procedure = "{ CALL  hp_mgGroupSelect (?, ?, ? ,?)} ";
			
			DataSet ds = null;
			int retVal = 0;
			
			QueryStatement sql = new QueryStatement();
			
			sql.setKey(groupDto.getLogid());
			sql.setSql(procedure);
			sql.setString(null);
			sql.setString("CHECK");
			sql.setString(null);
			sql.setString(groupDto.getGroupName());
			
			try{
				
				ds = broker.executeProcedure(sql);
				
				if(ds.next()){ 
					 retVal=ds.getInt("Result");
	
				 }
				
			}catch(Exception e){
			      e.printStackTrace();
				  log.error(e.getMessage());
				  throw new DAOException(e.getMessage());
			}finally
			{
				try
			    {
			        if (ds != null) { ds.close(); ds = null; }
			    } 
			    catch (Exception ignore)
			    {
			    	log.error(ignore.getMessage());
			    }
			}	
			return retVal;	
		}
	public int checkGroupId(GroupDTO groupDto) throws DAOException {
		
		String procedure = "{ CALL  hp_mgGroupSelect (?, ?, ? ,?)} ";
		
		DataSet ds = null;
		int retVal = 0;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(groupDto.getLogid());
		sql.setSql(procedure);
		sql.setString(null);
		sql.setString("CHECKID");
		sql.setString(groupDto.getGroupID());
		sql.setString(null);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			if(ds.next()){ 
				 retVal=ds.getInt("Result");

			 }
			
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}	
		return retVal;	
	}
	
}
