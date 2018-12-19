package kr.co.team2.dao;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapException;
import com.sun.corba.se.spi.servicecontext.UEInfoServiceContext;

import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.ModelAndView;
import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.User;
import kr.co.team2.vo.UserQuestion;

public class UserDao {

	private static UserDao self = new UserDao();
	private UserDao () {}
	public static UserDao getInstance() {
		return self;
	}
	
	public void saveUser(User user) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.insert("saveUser", user);
	}
	
	public void modifyUser(User user) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.update("modifyUser", user);
	}
	

	public User getUserById(String userId) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		User user = (User) sqlMapClient.queryForObject("getUserById", userId);
		
		return user;
	}
	public User getUserByNo(int userNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		User user = (User) sqlMapClient.queryForObject("getUserByNo", userNo);
		
		return user;
	}
	
	public User getUserByNonQuestion(int userNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		User user = (User) sqlMapClient.queryForObject("getUserByNonQuestion", userNo);
		return user;
	}
	
	public void changeUserPassword(User user) throws SQLException {
		
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.update("changeUserPassword", user);
	}

	//유저 질문 db
	public List<UserQuestion> userQuestionByDb() throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<UserQuestion> userQuestions = (List<UserQuestion>) sqlMapClient.queryForList("UserQuestionByDb");
			return userQuestions;
	}
	
	public UserQuestion getUserQuestionNo(int userno) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		UserQuestion userQuestion = (UserQuestion) sqlMapClient.queryForObject("UserQuestionByNo", userno);
			return userQuestion;
	}
	
	public User findUserId(User user) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		User user1 = (User) sqlMapClient.queryForObject("findUserId", user);
		return user1;
	}
	
	public User findUserQuestion(User user) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		User user1 = (User) sqlMapClient.queryForObject("findUserQuestion", user);
		return user1;
	}
	
	public void userDeleteInfo(int userno) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.update("userDeleteInfo", userno);
	}
	
	
	/*
	// 수정폼 미완성 기능 구현은 일단 됨.
		@RequestMapping("/users/modify.do")
		public ModelAndView modifyUser(HttpServletRequest request, HttpServletResponse response) 
				throws Exception {
			
			ModelAndView mav = new ModelAndView();
			
			HttpSession session = request.getSession();
			User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
			if (loginedUser == null) {
				mav.setViewName("redirect:/user/loginform.do?fail=deny"); // 실행됨.
				return mav;
			}
			int no = loginedUser.getNo();
			
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			String answer = request.getParameter("answer");
			String name = request.getParameter("name");
			String addr1 = request.getParameter("addr1");
			String addr2 = request.getParameter("addr2");
			String tel1 = request.getParameter("phone1");
			String tel2 = request.getParameter("phone2");
			String tel3 = request.getParameter("phone3");
			String tel = tel1+"-"+tel2+"-"+tel3;
			String phoneTel1 = request.getParameter("mobile1");
			String phoneTel2 = request.getParameter("mobile2");
			String phoneTel3 = request.getParameter("mobile3");
			String phoneTel = phoneTel1+"-"+phoneTel2+"-"+phoneTel3;
			String email1 = request.getParameter("email1");
			String email2 = request.getParameter("email2");
			String email = email1+"@"+email2;
			
			User user = new User();
			user.setNo(no);
			user.setId(id);
			user.setPassword(password);
			user.setName(name);
			user.setAnswer(answer);
			user.setAddress1(addr1);
			user.setAddress2(addr2);
			user.setTel(tel);
			user.setPhoneTel(phoneTel);
			user.setEmail(email);
			
			UserDao userDao = UserDao.getInstance();
			userDao.modifyUser(user);
			
			mav.setViewName("redirect:/users/modifycmp.do");
			return mav;
		}*/
}
