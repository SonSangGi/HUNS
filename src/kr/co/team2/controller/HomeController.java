package kr.co.team2.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;


import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.ModelAndView;
import kr.co.team2.dao.HomeDao;
import kr.co.team2.dao.ReviewDao;
import kr.co.team2.vo.Cart;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.Option;
import kr.co.team2.vo.PhotoReviews;
import kr.co.team2.vo.Review;
import kr.co.team2.vo.User;

@Controller
public class HomeController {
	@RequestMapping("/home.do")
	public ModelAndView home(HttpServletRequest request, HttpServletResponse response) throws SQLException {

		System.out.println("home() 메소드 실행됨");
		ModelAndView mav = new ModelAndView();
		HomeDao homeDao = HomeDao.getInstance();
		int cartCount = 0;
		//장바구니 갯수 구하기
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("LOGIN_USER_INFO");
		
		
		if(user != null) {
			cartCount = homeDao.getCartCount(user.getNo()); 		
		}
		//신상품 최근 등록 날짜 순
		List<Item> items = homeDao.getItemByCreateDate();
		
		ReviewDao reviewDao = ReviewDao.getInstance();
		
		List<PhotoReviews> bestReviews = reviewDao.getMainBestReviews();
		
		for(PhotoReviews reviews : bestReviews) {
			String content = reviews.getContents();

			Item item = reviewDao.getItemByReviewNo(reviews.getNo());
			String itemName = item.getName();
			
			if(content.length() > 15) {
				content = content.substring(0,15);
				String colons = "...";
				content += colons;
				reviews.setContents(content);
			}
			
			if(itemName.length() > 15) {
				itemName = itemName.substring(0,15);
				String colons = "...";
				itemName += colons;
				item.setName(itemName);
			}
			
			reviews.setItem(item);
		}
		mav.addAttribute("bestReviews", bestReviews);
		
		//int cate_no = homeDao.getCategoryByreviewScore();
		int cate_no= 103;
		//제일 리뷰가 좋은 카테고리 
		int sub_no = homeDao.getTopCategoryBycateNo(cate_no);
		//베스트 상품 리뷰 평점
		List<Item> itemsScores = homeDao.getBestItemByScore();
		
		//상의 베스트
		List<Item> bestTopItems = homeDao.getTopItemsByCategoryNo(100);
		
		//팬츠 베스트
		List<Item> bestPantItems = homeDao.getPantItemsByCategoryNo(101);

		session.setAttribute("cartCount", cartCount);
		
		mav.addAttribute("items", items);
		mav.addAttribute("sub_no", sub_no);
		mav.addAttribute("itemsScores", itemsScores);
		mav.addAttribute("bestTopItems", bestTopItems);
		mav.addAttribute("bestPantItems", bestPantItems);
		mav.setViewName("home.jsp");
		return mav;
	}
	

	
}
