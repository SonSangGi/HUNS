package kr.co.team2.service.admin;

import java.sql.SQLException;
import java.util.List;

import kr.co.team2.dao.UserDao;
import kr.co.team2.dao.adminUserDao;
import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.AdminUser;
import kr.co.team2.vo.User;
import kr.co.team2.vo.UserLog;

public class adminUserService {

	adminUserDao userDao = adminUserDao.getInstance();

	public List<User> getAllUsers() throws SQLException {
		return userDao.getAllUsers();
	}

	public User usergetUserByNo(int userNo) throws SQLException {
		return userDao.getUserByNo(userNo);
	}

	public void updateUser(User user) throws SQLException {
		userDao.updateUser(user);
	}

	public void addAdmin(AdminUser adminUser) throws SQLException {
		userDao.addAdmin(adminUser);
	}

	public AdminUser getAdminUserByNo(String id) throws SQLException {
		return userDao.getAdminUserByNo(id);
	}

	public void addLog(UserLog log) throws SQLException {
		userDao.addLog(log);
	}

	public List<UserLog> getAllLog() throws SQLException {
		return userDao.getAllLog();
	}
}
