package kr.co.team2.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.ModelAndView;
import kr.co.team2.dao.ItemDao;
import kr.co.team2.dao.MyPageDao;
import kr.co.team2.dao.ReviewDao;
import kr.co.team2.vo.Criteria;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.ItemQuestion;
import kr.co.team2.vo.PhotoReviews;
import kr.co.team2.vo.Review;
import kr.co.team2.vo.ReviewInfo;
import kr.co.team2.vo.User;

@Controller
public class MypageController {
	
	
	@RequestMapping("/mypage/home.do")
	public ModelAndView MyPageMainHome(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
		
		if (loginedUser == null) {
			mav.setViewName("redirect:/users/loginform.do?fail=deny"); // 실행됨.
			return mav;
		}
		mav.setViewName("mypage/mypagehome.jsp");
		
		return mav;
		
	}
	
	@RequestMapping("/mypage/mypageview.do")
	public ModelAndView MyPageView(HttpServletRequest request, HttpServletResponse response) throws SQLException {

		HttpSession session = request.getSession();
		ModelAndView mav = new ModelAndView();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
	
		if (loginedUser == null) {
			mav.setViewName("redirect:/users/loginform.do?fail=deny"); // 실행됨.
			return mav;
		}
		int userno = loginedUser.getNo();
		List<Review> reviews = new ArrayList<Review>();
		List<ItemQuestion> questionviews = new ArrayList<ItemQuestion>(); 
		
		String opt = request.getParameter("opt");
		String keyword = request.getParameter("keyword");
		String category = request.getParameter("category");
		
		if(category == null) {
			category = "review";
		}
		
		Criteria criteria = new Criteria();
		
		if(keyword!= null && !keyword.isEmpty()) {
			criteria.setOpt(opt);
			criteria.setKeyword(keyword.toUpperCase());
		}
		
		//리뷰, 문의글의 여부를 target에 넣어준 후 리뷰글인지 문의글인지 확인 후 db접근
		criteria.setTarget(category);
		criteria.setNo(userno);
		MyPageDao myPageDao = MyPageDao.getInstance();
		ReviewDao reviewDao = ReviewDao.getInstance();
		
		if(category.equals("review")) {
			reviews = reviewDao.getMyReviewsByCriteriaOnReviewDao(criteria);
					
			// 리뷰 내용이 15자가 넘어가면 줄여주는 기능
			for(Review review : reviews) {
				String content = review.getContents();
						
				if(content.length() > 15) {
					content = content.substring(0,15);
					String colons = "...";
					content += colons;
					review.setContents(content);
				}
			
			}
			
			mav.addAttribute("reviews", reviews);
		}else if(category.equals("question")) {
			questionviews = myPageDao.getQuestionviewsByCriteria(criteria);
			mav.addAttribute("questionviews", questionviews);
		}
		
		System.out.println("리뷰:"+reviews.isEmpty());
		System.out.println("문의:"+questionviews.isEmpty());
		
		mav.setViewName("mypage/myboardview.jsp");
		
		
		return mav;
		
	}
	
	@RequestMapping("/mypage/delRev.do")
	public ModelAndView MyPageRevDel(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();
		ReviewDao reviewDao = ReviewDao.getInstance();
		
		int delRevNo = Integer.parseInt(request.getParameter("delRevNo"));
		
		ReviewInfo reviewInfo = reviewDao.getReviewInfoByReviewNo(delRevNo);
		
		reviewDao.deleteReviewInfoByReviewInfoNo(reviewInfo.getNo());
		reviewDao.deleteReviewByReviewNo(delRevNo);
		
		mav.setViewName("redirect:/mypage/mypageview.do");
		return mav;
		
	}
	
	@RequestMapping("/mypage/recentItem.do")
	public ModelAndView recentItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Cookie[] cookies = request.getCookies();
		MyPageDao myPageDao = MyPageDao.getInstance();
		
		List<Item> cookieItems = new ArrayList<>();
		if(cookies !=null) {
			String cookieValue = this.getCookieValue(cookies, "recent-item");
			if(cookieValue != null) {
				String[] items = cookieValue.split(":");
				for(String cookieitemNo : items) {
					
					List<Item> cookieitem = myPageDao.getImpoItemByNo(Integer.parseInt(cookieitemNo));
					Double score = 0.0;
					int likes = 0;
					int totalLikes = 0;
					int reviewNo = 0;
					for(Item reviewScore : cookieitem) {
						likes += reviewScore.getReview().getLikes();
						totalLikes += reviewScore.getReview().getLikesParticipate();
						score += reviewScore.getReview().getScore();
						reviewNo = reviewScore.getReview().getNo();
						
					}
					if (cookieitem.size() > 0) {
						score = score/cookieitem.size();
					}
					System.out.println("평점" + score);
					
					Item recent = myPageDao.getrecentByNo(Integer.parseInt(cookieitemNo));
					
					Review review = new Review();
					review.setScore(score);
					review.setLikes(likes);
					review.setNo(reviewNo);
					review.setLikesParticipate(totalLikes);
					
					
					recent.setReview(review);
					
					cookieItems.add(recent);
				}	
			}
		}
		mav.addAttribute("cookieItems", cookieItems);
		mav.setViewName("mypage/recentItem.jsp");
		return mav;
		
	}
	
	private String getCookieValue(Cookie[] cookies, String cookieName) {
		
		if(cookies ==null) {
		}	
		for(Cookie cookie : cookies) {
			String name = cookie.getName();
			if(name.equals(cookieName)) {
				return cookie.getValue();
			}
		}
		
		return null;
	}
}


