package kr.co.team2.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.JSONView;
import kr.co.jhta.mvc.servlet.ModelAndView;
import kr.co.team2.dao.ReviewDao;
import kr.co.team2.service.admin.adminItemService;
import kr.co.team2.service.admin.adminOrderService;
import kr.co.team2.service.admin.adminUserService;
import kr.co.team2.vo.AdminUser;
import kr.co.team2.vo.Category;
import kr.co.team2.vo.Criteria;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.ItemQuestion;
import kr.co.team2.vo.Option;
import kr.co.team2.vo.OrderDetail;
import kr.co.team2.vo.Orders;
import kr.co.team2.vo.PhotoReviews;
import kr.co.team2.vo.ReviewInfo;
import kr.co.team2.vo.User;
import kr.co.team2.vo.UserLog;
import kr.co.team2.vo.monthlySales;

@Controller
public class AdminController {
	adminItemService itemService = new adminItemService();

	/*-------------------------관리자 로그인 및 생성 관련-------------------------------*/
	@RequestMapping("/admin/main/loginform.do")
	public ModelAndView loginform(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/etc/login.jsp");
		return mav;
	}

	@RequestMapping("/admin/main/registerform.do")
	public ModelAndView registerForm(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp");
			return mav;
		}

		mav.setViewName("admin/etc/register.jsp");
		return mav;
	}

	@RequestMapping("/admin/main/addAdmin.do")
	public ModelAndView addAdmin(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp");
			return mav;
		}

		String id = request.getParameter("id");
		String password = DigestUtils.sha256Hex(request.getParameter("password"));
		System.out.println(id);
		System.out.println(password);
		if (userService.getAdminUserByNo(id) != null) {
			mav.addAttribute("result", "err");
			mav.setViewName("admin/etc/register.jsp");
			return mav;
		}

		AdminUser adminUser = new AdminUser();
		adminUser.setId(id);
		adminUser.setPassword(password);
		userService.addAdmin(adminUser);
		System.out.println("관리자가 생성되었습니다.\nID: " + id);

		// 접속로그
		String ip = itemService.getIp(request);
		String loginId = (String) session.getAttribute("ADMIN_USER_LOGIN");
		UserLog log = new UserLog();
		log.setContents("관리자 생성" + "(" + id + ")");
		log.setId(loginId);
		log.setIp(ip);
		userService.addLog(log);

		mav.addAttribute("result", "ok");
		mav.setViewName("admin/etc/register.jsp");
		return mav;
	}

	// 로그인 체크
	@RequestMapping("/admin/main/check.do")
	public ModelAndView loginCheck(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		String id = request.getParameter("id");
		String password = DigestUtils.sha256Hex(request.getParameter("password"));
		String result = "NO";
		AdminUser admin;
		try {
			admin = userService.getAdminUserByNo(id);
			if (!admin.getPassword().equals(password)) {
				result = "pwNo";
				String ip = itemService.getIp(request);
				UserLog log = new UserLog();
				log.setContents("관리자 로그인 실패");
				log.setId(id);
				log.setIp(ip);
				userService.addLog(log);
			} else {
				result = "OK";
				HttpSession session = request.getSession();
				session.setAttribute("ADMIN_USER_LOGIN", id);
				User user = userService.usergetUserByNo(0);
				session.setAttribute("LOGIN_USER_INFO", user);
				session.setMaxInactiveInterval(1800);
				String ip = itemService.getIp(request);
				UserLog log = new UserLog();
				log.setContents("관리자 로그인");
				log.setId(id);
				log.setIp(ip);
				userService.addLog(log);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = "idNo";
		}

		mav.addAttribute("result", result);
		mav.setView(new JSONView());
		return mav;
	}

	// 로그아웃
	@RequestMapping("/admin/main/logout.do")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}
		session.removeAttribute("ADMIN_USER_LOGIN");
		session.removeAttribute("LOGIN_USER_INFO");
		mav.setViewName("home.jsp");
		return mav;
	}

	/*---------------------------상품 컨트롤러---------------------------------------*/
	/*
	 * 메인 화면
	 */
	@RequestMapping("/admin/main/home.do")
	public ModelAndView home(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		mav.setViewName("admin/etc/home.jsp");
		return mav;
	}

	// Ajax 주문,리뷰,문의 카운트 값 전송
	@RequestMapping("/admin/main/count.do")
	public ModelAndView count(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}
		int orderCount = orderSevice.getBeforeOrders();
		int reviewCount = itemService.getTodayReviewCount();
		int notAnswerCount = itemService.getNotAnswerCount();
		mav.addAttribute("orderCount", orderCount);
		mav.addAttribute("reviewCount", reviewCount);
		mav.addAttribute("notAnswerCount", notAnswerCount);
		mav.setView(new JSONView());
		return mav;
	}

	/*
	 * Ajax Json 월별 매출
	 */
	@RequestMapping("/admin/main/chart.do")
	public ModelAndView charts(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}
		String result = "";
		List<monthlySales> monthly = new ArrayList<>();
		try {
			monthly = orderSevice.getRecentOrders();
			result = "OK";
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("오류: 차트를 불러오는 도중 오류가 생겼습니다.");
			result = "NO";
		}
		mav.addAttribute("monthly", monthly);
		mav.addAttribute("result", result);
		mav.setView(new JSONView());
		return mav;
	}

	/*
	 * 차트
	 */
	@RequestMapping("/admin/etc/charts.do")
	public ModelAndView chartList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}
		mav.setViewName("admin/etc/charts.jsp");
		return mav;
	}

	/*
	 * 상품 등록 폼
	 */
	@RequestMapping("/admin/product/addform.do")
	public ModelAndView productAddform(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		List<Category> categorys = itemService.getTopCategorys();

		mav.addAttribute("topCategorys", categorys);
		mav.setViewName("admin/product/addform.jsp");
		return mav;
	}

	/*
	 * 상품 수정 폼
	 */
	@RequestMapping("/admin/product/modifyform.do")
	public ModelAndView productmodifyform(HttpServletRequest request, HttpServletResponse response)
			throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		Item item = itemService.getItemByNo(itemNo);
		List<Category> categorys = itemService.getTopCategorys();

		mav.addAttribute("item", item);
		mav.addAttribute("topCategorys", categorys);
		mav.setViewName("admin/product/modifyform.jsp");
		return mav;
	}

	// 상품 수정

	@RequestMapping("/admin/product/modify.do")
	public ModelAndView productModify(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		String saveDirectory = "C:/web_workspace/shopping/WebContent/images/items";
		System.out.println("경로: " + saveDirectory);
		int maxPostSize = 1024 * 1024 * 20;
		String encoding = "UTF-8";

		MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding,
				new DefaultFileRenamePolicy());
		int no = Integer.parseInt(mr.getParameter("itemNo"));
		System.out.println(no);
		int childCategory = Integer.parseInt(mr.getParameter("childCategory"));
		String name = mr.getParameter("name");
		String contents = mr.getParameter("content");
		int price = Integer.parseInt(mr.getParameter("price"));
		int discount = Integer.parseInt(mr.getParameter("discount"));
		String display = mr.getParameter("display");
		String sell = mr.getParameter("sell");
		String image = mr.getFilesystemName("main");
		String option = mr.getParameter("option");

		Item item = itemService.getItemByNo(no);
		item.setName(name);
		item.setContents(contents);
		item.setPrice(price);
		item.setCurrentDiscount(discount);
		item.setDisplayAvailable(display);
		item.setSellAvailable(sell);
		if (image != null) {
			item.setImage(image);
		}
		Category category = new Category();
		category.setNo(childCategory);
		item.setCategory(category);

		itemService.updateItem(item);
		if (!option.equals("")) {
			String[] optionsSplit = option.split(",");
			for (String var : optionsSplit) {
				String[] opts = var.split("&");
				Option opt = new Option();
				for (int i = 0; i <= opts.length - 1; i++) {
					if (i == 0) {
						opt.setColor(opts[i]);
					}
					if (i == 1) {
						opt.setSize(opts[i]);
					}
					if (i == 2) {
						opt.setStock(Integer.parseInt(opts[i]));
					}
					if (i == 3) {
						opt.setCurrentPrice(Integer.parseInt(opts[i]));
					}
					opt.setItem(item);
				}
				itemService.addOption(opt);
			}
		}
		mav.setViewName("redirect:/admin/product/list.do");
		return mav;
	}

	/*
	 * 상품 등록
	 */
	@RequestMapping("/admin/product/add.do")
	public ModelAndView productAdd(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		String saveDirectory = "C:/web_workspace/shopping/WebContent/images/items";
		System.out.println("경로: " + saveDirectory);
		int maxPostSize = 1024 * 1024 * 20;
		String encoding = "UTF-8";

		MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding,
				new DefaultFileRenamePolicy());
		int no = itemService.getItemSEQ();
		int childCategory = Integer.parseInt(mr.getParameter("childCategory"));
		String name = mr.getParameter("name");
		String contents = mr.getParameter("content");
		int price = Integer.parseInt(mr.getParameter("price"));
		int discount = Integer.parseInt(mr.getParameter("discount"));
		String display = mr.getParameter("display");
		String sell = mr.getParameter("sell");
		String image = mr.getFilesystemName("main");
		String option = mr.getParameter("option");
		Item item = new Item();
		item.setNo(no);
		item.setName(name);
		item.setContents(contents);
		item.setPrice(price);
		item.setCurrentDiscount(discount);
		item.setDisplayAvailable(display);
		item.setSellAvailable(sell);
		item.setImage(image);
		Category category = new Category();
		category.setNo(childCategory);
		item.setCategory(category);

		itemService.addItem(item);

		if (!option.equals("")) {
			String[] optionsSplit = option.split(",");
			for (String var : optionsSplit) {
				String[] opts = var.split("&");
				Option opt = new Option();
				for (int i = 0; i <= opts.length - 1; i++) {
					if (i == 0) {
						opt.setColor(opts[i]);
					}
					if (i == 1) {
						opt.setSize(opts[i]);
					}
					if (i == 2) {
						opt.setStock(Integer.parseInt(opts[i]));
					}
					if (i == 3) {
						opt.setCurrentPrice(Integer.parseInt(opts[i]));
					}
					opt.setItem(item);
					System.out.println(opts[i]);
				}
				itemService.addOption(opt);
			}
		}
		saveFile(request, saveDirectory, image);
		mav.setViewName("redirect:/admin/product/list.do");
		return mav;
	}

	/*
	 * Ajax Json 상품 삭제
	 */
	@RequestMapping("/admin/product/deleteItem.do")
	public ModelAndView deleteItem(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		String result = "";
		try {
			itemService.deleteItem(itemNo);
			result = "OK";
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("오류: 상품 삭제중 문제가 발생하였습니다.");
			result = "NO";
		}
		mav.addAttribute("result", result);
		mav.setView(new JSONView());
		return mav;
	}

	/*
	 * Ajax Json 옵션 삭제
	 */
	@RequestMapping("/admin/product/delOpt.do")
	public ModelAndView deleteOption(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		int optNo = Integer.parseInt(request.getParameter("optNo"));
		String result = "";
		try {
			itemService.deleteOptionByOptNo(optNo);
			result = "OK";
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("오류: 상품 삭제중 문제가 발생하였습니다.");
			result = "NO";
		}
		mav.addAttribute("result", result);
		mav.setView(new JSONView());
		return mav;
	}

	/*
	 * Ajax Json 하위 카테고리 조회
	 */
	@RequestMapping("/admin/product/childCategory.do")
	public ModelAndView getChildCategorys(HttpServletRequest request, HttpServletResponse response)
			throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		List<Category> categorys = itemService.getChildCategorys(Integer.parseInt(request.getParameter("categoryNo")));

		mav.addAttribute("childCategorys", categorys);
		mav.setView(new JSONView());
		return mav;
	}

	/*
	 * Ajax Json 하위 카테고리 삭제
	 */
	@RequestMapping("/admin/product/deleteChild.do")
	public ModelAndView adeleteChildCategory(HttpServletRequest request, HttpServletResponse response)
			throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		int cateNo = Integer.parseInt(request.getParameter("cateNo"));
		String result = "";
		try {
			itemService.deleteChildCategory(cateNo);
			result = "OK";
		} catch (Exception e) {
			System.err.println("오류: 카테고리 삭제중 문제가 발생하였습니다.");
			result = "NO";
		}
		mav.addAttribute("result", result);
		mav.setView(new JSONView());
		return mav;
	}

	/*
	 * 카테고리 생성..
	 */
	@RequestMapping("/admin/product/addCategory.do")
	public ModelAndView addCategory(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		int cateSubNo = 0;
		String contents;
		Category category = new Category();
		if (request.getParameter("cateNo") != null) {
			cateSubNo = Integer.parseInt(request.getParameter("cateNo"));
			contents = request.getParameter("contents");
			category.setContents(contents);
			category.setSubNo(cateSubNo);
		} else {
			contents = request.getParameter("contents");
			category.setContents(contents);
		}
		String result = "";
		try {
			itemService.addCategory(category);
			result = "OK";
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("오류: 카테고리 생성중 문제가 발생하였습니다.");
			result = "NO";
		}
		mav.addAttribute("result", result);
		mav.setView(new JSONView());
		return mav;
	}

	/*
	 * 상품 페이지
	 */
	@RequestMapping("/admin/product/list.do")
	public ModelAndView productList(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}
		List<Category> categorys = itemService.getTopCategorys();
		int totalRows = itemService.getAllItemsCount();

		mav.addAttribute("topCategorys", categorys);
		mav.addAttribute("totalRows", totalRows);
		mav.setViewName("admin/product/list.jsp");
		return mav;
	}

	// 스크롤 페이징 및 검색
	@RequestMapping("/admin/product/getItemScroll.do")
	public ModelAndView getItemScroll(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		int cp = 1;
		int rows = 5;
		if (request.getParameter("cp") != null) {
			cp = Integer.parseInt(request.getParameter("cp"));
		}
		int topCateNo = 0;
		int childCateNo = 0;
		if (request.getParameter("topCateNo") != null) {
			topCateNo = Integer.parseInt(request.getParameter("topCateNo"));
			if (topCateNo != 0) {
				childCateNo = Integer.parseInt(request.getParameter("childCateNo"));
			}
		}
		Boolean allDate = Boolean.parseBoolean(request.getParameter("allDate"));

		String firstDate = null;
		String lastDate = null;
		if (!allDate) {
			lastDate = request.getParameter("lastDate");
			if (lastDate != "") {
				firstDate = request.getParameter("firstDate");
			}
		}
		System.out.println(topCateNo);
		System.out.println(childCateNo);

		System.out.println("--------------------------");
		String keyword = request.getParameter("keyword");
		String display = request.getParameter("display");
		String sell = request.getParameter("sell");

		Criteria criteria = new Criteria();
		criteria.setRows(rows);
		criteria.setBeginIndex((cp - 1) * rows + 1);
		criteria.setSubCategory(childCateNo);
		criteria.setNo(topCateNo);
		criteria.setEndIndex(cp * rows);
		criteria.setKeyword(keyword);
		criteria.setFirstDate(firstDate);
		criteria.setLastDate(lastDate);
		criteria.setDisplayAvailable(display);
		criteria.setSellAvailable(sell);
		List<Item> items = itemService.getItemByCriteria(criteria);
		mav.addAttribute("itemsScroll", items);
		mav.setView(new JSONView());
		return mav;
	}

	/*
	 * Ajax Json 상품 디테일
	 */
	@RequestMapping("/admin/product/detail.do")
	public ModelAndView productDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		Item item = itemService.getItemByNo(Integer.parseInt(request.getParameter("itemNo")));

		mav.addAttribute("item", item);
		mav.setView(new JSONView());
		return mav;
	}

	/*
	 * 카테고리 페이지
	 */
	@RequestMapping("/admin/product/category.do")
	public ModelAndView category(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		List<Category> categorys = itemService.getTopCategorys();

		mav.addAttribute("categorys", categorys);
		mav.setViewName("admin/product/category.jsp");
		return mav;
	}

	/*
	 * 상위 카테고리
	 */
	@RequestMapping("/admin/TopCategory.do")
	public ModelAndView getTopCategory(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		List<Category> categorys = itemService.getTopCategorys();
		System.out.println(categorys.size());

		mav.addAttribute("categorys", categorys);
		mav.setView(new JSONView());
		return mav;
	}

	@RequestMapping("/admin/board/board.do")
	public ModelAndView boardList(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		} else {
			User user = userService.usergetUserByNo(0);
			session.setAttribute("LOGIN_USER_INFO", user);
		}
		List<ItemQuestion> notAnswerQuestions = itemService.getNotAnswerQuestion();
		List<ItemQuestion> AnsweredQuestions = itemService.getAnsweredQuestion();

		mav.addAttribute("notAnswerQuestions", notAnswerQuestions);
		mav.addAttribute("AnsweredQuestions", AnsweredQuestions);
		mav.setViewName("admin/board/boardlist.jsp");
		return mav;
	}

	@RequestMapping("/admin/board/reviews.do")
	public ModelAndView reviewList(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		ReviewDao reviewDao = ReviewDao.getInstance();

		// 모든 포토 리뷰 조회
		List<PhotoReviews> photoReviews = reviewDao.getAllofPhotoReviews();

		// 리뷰 내용이 15자가 넘어가면 줄여주는 기능
		for (PhotoReviews reviews : photoReviews) {
			String content = reviews.getContents();

			if (content.length() > 15) {
				content = content.substring(0, 15);
				String colons = "...";
				content += colons;
				reviews.setContents(content);
			}

			User user = reviewDao.getUserByUserNo(reviews.getUser().getNo());
			Item item = reviewDao.getItemByReviewNo(reviews.getNo());
			reviews.setUser(user);
			reviews.setItem(item);
		}

		mav.addAttribute("reviews", photoReviews);

		mav.setViewName("admin/board/reviewlist.jsp");
		return mav;
	}

	@RequestMapping("/admin/board/delRev.do")
	public ModelAndView reviewDel(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();
		ReviewDao reviewDao = ReviewDao.getInstance();

		String[] delRevNo = null;
		if (request.getParameter("delRevNo") != null) {
			delRevNo = request.getParameter("delRevNo").split(",");
		}

		String result = "";
		try {
			for (String revNo : delRevNo) {
				int reviewNo = Integer.parseInt(revNo);

				ReviewInfo reviewInfo = reviewDao.getReviewInfoByReviewNo(reviewNo);

				reviewDao.deleteReviewInfoByReviewInfoNo(reviewInfo.getNo());
				reviewDao.deleteReviewByReviewNo(reviewNo);
				result = "OK";
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("리뷰 삭제중 오류가 생겼습니다.");
			result = "NO";
		}
		mav.addAttribute("result", result);
		mav.setView(new JSONView());

		return mav;
	}

	/*------------------------------ 회원 컨트롤러----------------------------------*/
	adminUserService userService = new adminUserService();

	// 회원 목록
	@RequestMapping("/admin/user/list.do")
	public ModelAndView userList(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		List<User> users = userService.getAllUsers();

		mav.addAttribute("users", users);
		mav.setViewName("admin/user/list.jsp");
		return mav;
	}

	// 회원가입/탈퇴 관리
	@RequestMapping("/admin/user/mgt.do")
	public ModelAndView userManagement(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		List<User> users = userService.getAllUsers();

		mav.addAttribute("users", users);
		mav.setViewName("admin/user/mgt.jsp");
		return mav;
	}

	// 로그인 로그 관리
	@RequestMapping("/admin/user/log.do")
	public ModelAndView loginLog(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		List<UserLog> logs = userService.getAllLog();
		mav.addAttribute("logs", logs);
		mav.setViewName("admin/user/log.jsp");
		return mav;
	}

	// 회원 탈퇴 및 해제
	@RequestMapping("/admin/user/delUser.do")
	public ModelAndView updateUser(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		String resultValue = request.getParameter("result");
		String[] userNos = null;
		if (request.getParameter("userNos") != null) {
			userNos = request.getParameter("userNos").split(",");
		}

		String result = "";
		try {
			for (String userNo : userNos) {
				User user = userService.usergetUserByNo(Integer.parseInt(userNo));
				if ("N".equals(resultValue)) {
					user.setAvailable("N");
				} else {
					user.setAvailable("Y");
				}
				userService.updateUser(user);
			}
			result = "OK";
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("탈퇴 처리중 오류가 생겼습니다.");
			result = "NO";
		}
		mav.addAttribute("result", result);
		mav.setView(new JSONView());
		return mav;
	}

	/*----------------------------------- 주문 컨트롤러 ------------------------------------*/
	adminOrderService orderSevice = new adminOrderService();

	@RequestMapping("/admin/order/list.do")
	public ModelAndView orderList(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		List<OrderDetail> orderDetails = orderSevice.getAllOrderDetails();

		/*
		 * for (OrderDetail orderDetail : orderDetails) {
		 * System.out.println("----------테스트용-----------");
		 * System.out.println("주문 디테일 번호:"+orderDetail.getNo());
		 * System.out.println("주문 개수: "+orderDetail.getQty());
		 * System.out.println("주문 옵션: "+orderDetail.getOption().getColor()+" "
		 * +orderDetail.getOption().getSize()+" "+orderDetail.getOption().
		 * getCurrentPrice());
		 * System.out.println("주문 아이템: "+orderDetail.getOption().getItem().getName());
		 * System.out.println("주문 회원: "+orderDetail.getOrder().getUser().getName());
		 * 
		 * }
		 */
		mav.addAttribute("orderDetails", orderDetails);
		mav.setViewName("admin/order/list.jsp");
		return mav;
	}

	@RequestMapping("/admin/order/mgt.do")
	public ModelAndView orderManagement(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		mav.setViewName("admin/order/mgt.jsp");
		return mav;
	}

	@RequestMapping("/admin/order/orderUpdate.do")
	public ModelAndView orderUpdate(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		if (session.getAttribute("ADMIN_USER_LOGIN") == null) {
			mav.setViewName("admin/etc/login.jsp?fail=login");
			return mav;
		}

		request.setCharacterEncoding("utf-8");
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		String state = request.getParameter("state");
		String result = "";
		try {
			Orders order = orderSevice.getOrderByNo(orderNo);
			order.setState(state);
			orderSevice.orderUpdate(order);
			result = "OK";
		} catch (Exception e) {
			e.printStackTrace();
			result = "NO";
		}
		mav.addAttribute("result", result);
		mav.setView(new JSONView());
		return mav;
	}

	private void saveFile(HttpServletRequest request, String saveDirectory, String fileName) {
		FileInputStream input = null;
		FileOutputStream output = null;
		try {
			File file = new File(saveDirectory + "/" + fileName);

			input = new FileInputStream(file);
			output = new FileOutputStream(new File(request.getSession().getServletContext().getRealPath("/")
					+ File.separator + "/images/items/" + fileName));

			int readBuffer = 0;
			byte[] buffer = new byte[1024];
			while ((readBuffer = input.read(buffer)) != -1) {
				output.write(buffer, 0, readBuffer);
			}
		} catch (IOException e) {
			System.out.println(e);
		} finally {
			try {
				input.close();
				output.close();
			} catch (IOException io) {
			}
		}
	}
}
