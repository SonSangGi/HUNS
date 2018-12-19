package kr.co.team2.controller;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.tomcat.util.digester.Digester;

import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.JSONView;
import kr.co.jhta.mvc.servlet.ModelAndView;
import kr.co.team2.dao.UserDao;
import kr.co.team2.dao.adminUserDao;
import kr.co.team2.service.admin.adminItemService;
import kr.co.team2.service.admin.adminUserService;
import kr.co.team2.vo.User;
import kr.co.team2.vo.UserLog;
import kr.co.team2.vo.UserQuestion;

@Controller
public class UserController {
	
	// 화면 출력

	// 회원가입폼
	@RequestMapping("/users/registerform.do")
	public ModelAndView register(HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
		UserDao userDao = UserDao.getInstance();
		List<UserQuestion> userQuestions = userDao.userQuestionByDb();
		System.out.println("registerform() 메소드 실행됨");
		ModelAndView mav = new ModelAndView();
		mav.addAttribute("userQuestions", userQuestions);
		mav.setViewName("users/registerform.jsp");

		return mav;
	}
	
		
	// 수정폼
	@RequestMapping("/users/modifyform.do")
	public ModelAndView modifyform(HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("LOGIN_USER_INFO");
		UserDao userDao = UserDao.getInstance(); // DB와 연동시키는 명령문
		user = userDao.getUserByNo(user.getNo());
		if (user == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}
		
		//한번에 입력된 전화번호를 3등분하는 로직
		String tel = user.getTel();
		String[] tels = tel.split("-");
		
		String tel1 = tels[0];
		String tel2 = tels[1];
		String tel3 = tels[2];
		user.setTel1(tel1);
		user.setTel2(tel2);
		user.setTel3(tel3);
		
		//한 번에 입력 된 핸드폰 번호를 3등분하는 로직
		String phoneTel = user.getPhoneTel();
		String[] phoneTels = phoneTel.split("-");
		
		String phoneTel1 = phoneTels[0];
		String phoneTel2 = phoneTels[1];
		String phoneTel3 = phoneTels[2];
		user.setPhoneTel1(phoneTel1);
		user.setPhoneTel2(phoneTel2);
		user.setPhoneTel3(phoneTel3);
		
		// 입력받아있는 이메일을 3등분하는 로직
		String email = user.getEmail();
		String[] emailbox = email.split("@");
		
		String email1 = emailbox[0];
		String email2 = emailbox[1];
		user.setEmail1(email1);
		user.setEmail2(email2);
		
		
		
		List<UserQuestion> Questions = userDao.userQuestionByDb();
		UserQuestion userQuestion = userDao.getUserQuestionNo(user.getNo());
		
		System.out.println("modifyform() 메소드 실행됨");
		mav.addAttribute("user", user);
		mav.addAttribute("userQuestion", userQuestion);
		mav.addAttribute("Questions", Questions);
		mav.setViewName("users/modifyform.jsp");
		return mav;
	}
		

	// 로그인폼
	@RequestMapping("/users/loginform.do")
	public ModelAndView loginmodal(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("users/loginform.jsp");
		return mav;
	}
	
	// 회원가입완료 화면 
	@RequestMapping("/users/completed.do")
	public ModelAndView complete(HttpServletRequest request, HttpServletResponse response) 
			throws  Exception {
		
		System.out.println("completed() 메소드 실행됨.");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("users/completed.jsp");
		
		return mav;
	}

	// 수정완료 화면
	@RequestMapping("/users/modifycmp.do")
	public ModelAndView modifycmp(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("users/modifycmp.jsp");
		return mav;
	}
	
	
	// 아이디 찾기 화면
	@RequestMapping("/users/findidform.do")
	public ModelAndView findid(HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		ModelAndView mav = new  ModelAndView();
		mav.setViewName("users/findid.jsp");
		return mav;
	}
	
	// 아이디 찾기 완료 화면
	@RequestMapping("/users/findidcmpform.do")
	public ModelAndView findidcmp(HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		ModelAndView mav = new ModelAndView();

		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		UserDao userDao = UserDao.getInstance();
		User user = userDao.getUserByNo(userNo);
		
		System.out.println(user.getName());
		System.out.println(user.getId());
		System.out.println(user.getEmail());
		
		mav.addAttribute("findUser", user);
		mav.setViewName("users/findidcmp.jsp");
		return mav;
	}
	
	// 비밀번호 찾기 화면
	@RequestMapping("/users/findpwdform.do")
	public ModelAndView findpwd(HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("users/findpwd.jsp");
		return mav;
	}
	
	@RequestMapping("/users/findpwd.do")
	public ModelAndView findUserQuestion(HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("비밀번호 찾기 메소드 실행");
		String id = request.getParameter("id");
		System.out.println(id);
		String name = request.getParameter("name");
		System.out.println(name);
		String email = request.getParameter("email");
		System.out.println(email);
		
		User user = new User();
		user.setId(id);
		user.setName(name);
		user.setEmail(email);
		
		UserDao userDao = UserDao.getInstance();
		
		User userInfo = userDao.findUserQuestion(user);
		if (userInfo == null) {
			// 입력오류
			
		}
		UserQuestion userQuestion = userDao.getUserQuestionNo(userInfo.getNo());
		
		mav.addAttribute("userInfo", userInfo);
		mav.addAttribute("userQuestion", userQuestion);
		mav.setViewName("users/findpwdQ.jsp");
		return mav;
	}

	@RequestMapping("/users/checkAnswer.do")
	public ModelAndView checkAnswer(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		int questionNo = Integer.parseInt(request.getParameter("question"));
		String questionAnswer = request.getParameter("answer");
		Integer userNo = Integer.parseInt(request.getParameter("userno"));
		
		UserDao userDao = UserDao.getInstance();
		User user = userDao.getUserByNonQuestion(userNo);
	
		if(user.getUserQuestion().getNo() == questionNo && user.getAnswer().equals(questionAnswer)) {
			mav.addAttribute("userInfo", user);
			mav.setViewName("users/findpwdcmp.jsp");
		} else {
			
		}		
		
		return mav;
	}
	// 데이터의 변경이 가해지면 리다이렉트 시킨다
	
	
	// 기능구현

	// 회원가입 기능 구현
	@RequestMapping("/users/register.do")
	public ModelAndView saveUser(HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		/*String shaPw= DigestUtils.sha256Hex(password);*/
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String birthDay = request.getParameter("birthDay");
		int questionNo = Integer.parseInt(request.getParameter("question"));
		String answer = request.getParameter("answer");
		String address1 = request.getParameter("addr1");
		String address2 = request.getParameter("addr2");
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
		String postcode = request.getParameter("postcode");
		
		User user = new User();
		UserQuestion userQuestion = new UserQuestion();
		user.setId(id);
		user.setPassword(password);
		user.setName(name);
		user.setGender(gender);
		user.setBirthDay(birthDay);
		user.setUserQuestion(userQuestion);
		user.setAnswer(answer);
		user.setAddress1(address1);
		user.setAddress2(address2);
		user.setTel(tel);
		user.setPhoneTel(phoneTel);
		user.setEmail(email);
		userQuestion.setNo(questionNo);
		user.setUserQuestion(userQuestion);
		user.setPostcode(postcode);
		UserDao userDao = UserDao.getInstance();
		userDao.saveUser(user);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:completed.do");
		return mav;
		
	}
	@RequestMapping("/users/cookieid.do")
	public ModelAndView cookieId(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		Cookie[] cookies = request.getCookies();
		UserDao userDao = UserDao.getInstance();
		ModelAndView mav = new ModelAndView();
		
		
		User user = null;
		if(cookies != null) {
			String cookieValue = this.getCookieValue(cookies, "save_id");
				if(cookieValue !=null) {
					user = userDao.getUserByNo(Integer.parseInt(cookieValue));
					mav.addAttribute("userId", user);
				}
			String autoLoginValue = this.getCookieValue(cookies, "autoLogin");
				if(autoLoginValue != null) {
					user = userDao.getUserByNo(Integer.parseInt(autoLoginValue));
					mav.addAttribute("autoUser", user);
					
				}
		}
		
		
		mav.setViewName("users/loginform.jsp");
		
		return mav;
		
	}
	
	// 로그인 기능 구현
	@RequestMapping("/users/login.do")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String checkBox = request.getParameter("checkBox");
		String autoLogin = request.getParameter("autoLogin");
	/*	String shaPw = DigestUtils.sha256Hex(password);*/
		
		UserDao userDao = UserDao.getInstance();
		
		User user = userDao.getUserById(id);		
		
		ModelAndView mav = new ModelAndView();
		
		if (user == null) {
			mav.setViewName("redirect:loginform.do?fail=login");
			return mav;
			
		}
		
		if (user.getAvailable().equals("N")) {
			mav.setViewName("redirect:loginform.do?fail=withdrawal");
			return mav;
		}		
		
		if (!user.getPassword().equals(password)) {
			mav.setViewName("redirect:loginform.do?fail=login");
			return mav;
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("LOGIN_USER_INFO", user);
		session.setMaxInactiveInterval(60*60);
		//아이디 기억하기
		Cookie[] cookies = request.getCookies();
		if("true".equals(checkBox)) {
			if(cookies != null) {
				String CookieValue = this.getCookieValue(cookies,"save_id");
				System.out.println("CookieValue : "+CookieValue);
				Cookie cookie = new Cookie("save_id",String.valueOf(user.getNo()));
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*365);
				response.addCookie(cookie);
			}	
		}else if("false".equals(checkBox)) {
			if(cookies != null) {
				String CookieValue = this.getCookieValue(cookies,"save_id");
				Cookie cookie = new Cookie("save_id",null);
				cookie.setPath("/");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
				
			}	
		}
		//자동 로그인
		if("true".equals(autoLogin)) {
			if(cookies != null) {
				String CookieValue = this.getCookieValue(cookies,"autoLogin");
				System.out.println("CookieValue : "+CookieValue);
				Cookie cookie = new Cookie("autoLogin",String.valueOf(user.getNo()));
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*365);
				response.addCookie(cookie);
			}	
		}else if("false".equals(checkBox)) {
			if(cookies != null) {
				String CookieValue = this.getCookieValue(cookies,"autoLogin");
				Cookie cookie = new Cookie("autoLogin",null);
				cookie.setPath("/");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}	
		}
		adminItemService ais = new adminItemService();
		adminUserService aus = new adminUserService();
		String ip = ais.getIp(request);
		UserLog userLog = new UserLog();
		userLog.setId(id);
		userLog.setContents("유저 로그인");
		userLog.setIp(ip);
		
		aus.addLog(userLog);
		mav.setViewName("redirect:/home.do");
		return mav;
	}
		
	private String getCookieValue(Cookie[] cookies, String cookieName) {
		
		if(cookies == null) {
			return null;
			
		}
		for(Cookie cookie : cookies) {
			String name = cookie.getName();
			if(name.equals(cookieName)) {
				return cookie.getValue();
			}
		}
		return null;
		
	}
	
	// 아이디 찾기 기능 구현
	@RequestMapping("/users/findid.do")
	public ModelAndView findUserId(HttpServletRequest request, HttpServletResponse response) 
		throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("아이디 찾기 메소드 실행");
		String name = request.getParameter("name");
		System.out.println(name);
		String email = request.getParameter("email");
		System.out.println(email);
		
		User user = new User();
		user.setName(name);
		user.setEmail(email);

		
		UserDao userDao = UserDao.getInstance();
		
		User findUser = userDao.findUserId(user);
		
		int userNo = findUser.getNo();
		
		if (findUser.getName() == null) {
			mav.setViewName("redirect:findidform.do?fail=check");
			return mav;
		}
		
		mav.setViewName("redirect:/users/findidcmpform.do?userNo="+userNo);
		
		return mav;
	}
	
	

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
		String postcode = request.getParameter("postcode");
		
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
		user.setPostcode(postcode);
		
		UserDao userDao = UserDao.getInstance();
		userDao.modifyUser(user);
		
		//session.setAttribute("LOGIN_USER_INFO", user);
		mav.setViewName("redirect:/users/modifycmp.do");
		return mav;
	}

	@RequestMapping("/users/logout.do")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/home.do");
		return mav;
	}
	
	@RequestMapping("/users/idCheck.do")
	public ModelAndView IdCheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("중복체크 실행");
		boolean isIdCheck = false;
		String id = request.getParameter("id");
		
		ModelAndView mav = new ModelAndView();
		System.out.println(id);
		UserDao userDao = UserDao.getInstance();
		if(userDao.getUserById(id)!=null) {
			isIdCheck = true;
			System.out.println(isIdCheck);
		}
		
		
		
		mav.addAttribute("result", isIdCheck);
		mav.setView(new JSONView());
		return mav;
	}
	
	@RequestMapping("/users/deletecmp.do")
	public ModelAndView userDeleteInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		
	
		int no = loginedUser.getNo();
	
		String available = request.getParameter("available");
		
		User user = new User();
		user.setAvailable(available);
		
		UserDao userDao = UserDao.getInstance();
		userDao.userDeleteInfo(no);
		
		mav.setViewName("users/deletecmp.jsp");
		session.invalidate();
		return mav;
	
	}
}