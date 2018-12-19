package kr.co.team2.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.AdminUser;
import kr.co.team2.vo.User;
import kr.co.team2.vo.UserLog;

public class adminUserDao {

	private adminUserDao() {}
	private static adminUserDao instance;
	public static adminUserDao getInstance() {
		if(instance == null) {
			instance = new adminUserDao();
		}
		return instance;
	}
	//전체 유저
	@SuppressWarnings("unchecked")
	public List<User> getAllUsers() throws SQLException{
		return SqlMapClientUtil.getSqlMapClient().queryForList("getAllUsers");
	}
	//번호로 유저
	public User getUserByNo(int userNo) throws SQLException{
		return (User) SqlMapClientUtil.getSqlMapClient().queryForObject("getUserByN",userNo);
	}
	public void updateUser(User user) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().update("updateUse",user);
	}
	//관리자 가입
	public void addAdmin(AdminUser adminUser) throws SQLException{
		SqlMapClientUtil.getSqlMapClient().insert("addAdmin",adminUser);
	}
	//관리자 조회
	public AdminUser getAdminUserByNo(String id) throws SQLException{
		return (AdminUser) SqlMapClientUtil.getSqlMapClient().queryForObject("getAdminUserByNo",id);
	}
	//로그 조회
	@SuppressWarnings("unchecked")
	public List<UserLog> getAllLog() throws SQLException {
		return (List<UserLog>) SqlMapClientUtil.getSqlMapClient().queryForList("getAllLog");
	}
	//로그 생성
	public void addLog(UserLog log) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().insert("addLog",log);
	}
}
