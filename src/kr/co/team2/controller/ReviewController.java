package kr.co.team2.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jdk.internal.org.objectweb.asm.tree.analysis.SourceInterpreter;
import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.JSONView;
import kr.co.jhta.mvc.servlet.ModelAndView;
import kr.co.team2.dao.ReviewDao;
import kr.co.team2.vo.AllReviews;
import kr.co.team2.vo.Category;
import kr.co.team2.vo.Criteria;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.Option;
import kr.co.team2.vo.Pagination;
import kr.co.team2.vo.PhotoReviews;
import kr.co.team2.vo.Review;
import kr.co.team2.vo.ReviewInfo;
import kr.co.team2.vo.ReviewPass;
import kr.co.team2.vo.User;

@Controller
public class ReviewController {

	@RequestMapping("/reviews/allreview.do")
	public ModelAndView allReview(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		ReviewDao reviewDao = ReviewDao.getInstance();
		
		int cp = 1;
		int rows = 4;
		String sort = request.getParameter("sort") == null ? "recent" : request.getParameter("sort");
		String price = request.getParameter("price");
		String keyword = request.getParameter("keyword");
		
		try {
			cp = Integer.parseInt(request.getParameter("cp"));
			rows = Integer.parseInt(request.getParameter("rows"));
		} catch (Exception e) {}
		
		Criteria criteria = new Criteria();
		criteria.setBeginIndex((cp-1)*rows +1);
		criteria.setEndIndex(cp*rows);
		criteria.setSort(sort);
		criteria.setPrice(price);
		criteria.setKeyword(keyword);
		
		int totalRows = reviewDao.getAllReviewsCount(criteria);
		Pagination pagination = new Pagination(cp, rows, totalRows);
		
		List<AllReviews> allReviews = reviewDao.getAllReviewsByCriteria(criteria);
		
		for(AllReviews allReview : allReviews) {
			
			// 리뷰 점수가 높은 3개를 뽑는다
			List<Review> reviews = reviewDao.getAllReviewsByItemNoTop3(allReview.getNo());
			
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
			
			// 상품 품명이 25자가 넘어가면 줄여주는 기능
			String name = allReview.getName();
			
			if(name.length() > 25) {
				name = name.substring(0, 25);
				String colons = "...";
				name += colons;
				allReview.setName(name);
			}
			
			allReview.setReviews(reviews);
		}
		
		List<PhotoReviews> bestReviews = reviewDao.getAllBestReviews();
		
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
		
		mav.addAttribute("allReviews", allReviews);
		mav.addAttribute("bestReviews", bestReviews);
		mav.addAttribute("pagination", pagination);
		
		mav.setViewName("reviews/allreview.jsp");
		return mav;
		
	}

	@RequestMapping("/reviews/add.do")
	public ModelAndView reviewAdd(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("LOGIN_USER_INFO");
		if (user == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}
		
		String saveDirectory = "C:/web_workspace/shopping/WebContent/images/reviews/images";
		int maxPostSize = 1024 * 1024 * 20;
		String encoding = "UTF-8";
		
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, new DefaultFileRenamePolicy());
		
		String photo = mr.getFilesystemName("photo");
		
		int optNo = Integer.parseInt(mr.getParameter("option-no"));
		int score = Integer.parseInt(mr.getParameter("option-star"));
		String contents = mr.getParameter("review-contents");
		
		Review review = new Review();
		ReviewDao reviewDao = ReviewDao.getInstance();
		
		int reviewNo = reviewDao.getReviewSeq();
		
		review.setNo(reviewNo);
		review.setOption(reviewDao.getOptionByOptionNo(optNo));
		review.setUser(reviewDao.getUserByUserNo(user.getNo()));
		review.setContents(contents);
		review.setScore(score);
		review.setPhoto(photo);
		
		reviewDao.addReview(review);
		
		String sex = mr.getParameter("option-sex");
		int age = Integer.parseInt(mr.getParameter("option-age"));
		int height = Integer.parseInt(mr.getParameter("option-height"));
		int weight = Integer.parseInt(mr.getParameter("option-weight"));
		int size = Integer.parseInt(mr.getParameter("option-size"));
		
		ReviewInfo reviewInfo = new ReviewInfo();
		
		reviewInfo.setReviewNo(review.getNo());
		reviewInfo.setSex(sex);
		reviewInfo.setAge(age);
		reviewInfo.setHeight(height);
		reviewInfo.setWeight(weight);
		reviewInfo.setSizes(size);
		
		reviewDao.addReviewInfo(reviewInfo);
		
		// ITEMS를 업데이트 하는 부분
		PhotoReviews prv = new PhotoReviews();
		prv.setNo(review.getNo());
		Item item = reviewDao.getItemByReviewNo(review.getNo());
		prv.setItem(item);
		
		reviewDao.updateRecentItemReviewNoByphotoReviews(prv);
		ReviewPass reviewPass = new ReviewPass();
		
		reviewPass.setOptNo(optNo);
		reviewPass.setPass("Y");
		
		reviewDao.updateReviewPassOnOption(reviewPass);
		
		mav.setViewName("redirect:photoreview.do");
		return mav;
	}
	
	@RequestMapping("/reviews/reviewadd.do")
	public ModelAndView reviewAddForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		ReviewDao reviewDao = ReviewDao.getInstance();
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("LOGIN_USER_INFO");
		if (user == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}
		
		int no = user.getNo();
		
		int optNo = Integer.parseInt(request.getParameter("no"));
		Item item = reviewDao.getItembyOptionNo(optNo);
		
		mav.addAttribute("item", item);
		mav.addAttribute("userno", no);
		mav.setViewName("reviews/reviewaddform.jsp");
		
		return mav;
	}
	
	@RequestMapping("/reviews/reviewedit.do")
	public ModelAndView reviewEditForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		ReviewDao reviewDao = ReviewDao.getInstance();
		
		int reviewNo = Integer.parseInt(request.getParameter("edtRevNo"));
		
		PhotoReviews review = reviewDao.getPhotoReviewByReviewNo(reviewNo);
		
		Item item = reviewDao.getItemByItemNo(review.getItem().getNo());
		ReviewInfo reviewInfo = reviewDao.getReviewInfoByReviewNo(review.getNo());
		Option option = reviewDao.getOptionByOptionNo(review.getOption().getNo());
		
		review.setItem(item);
		review.setReviewInfo(reviewInfo);
		review.setOption(option);
		
		mav.addAttribute("review", review);
		
		mav.setViewName("reviews/revieweditform.jsp");
		return mav;
	}
	
	@RequestMapping("/reviews/edit.do")
	public ModelAndView reviewEdit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		ReviewDao reviewDao = ReviewDao.getInstance();
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("LOGIN_USER_INFO");
		if (user == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}
		
		String saveDirectory = "C:/web_workspace/shopping/WebContent/images/reviews/images";
		int maxPostSize = 1024 * 1024 * 20;
		String encoding = "UTF-8";
		
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, new DefaultFileRenamePolicy());
		
		String photo = mr.getFilesystemName("photo");
		
		int optNo = Integer.parseInt(mr.getParameter("option-no"));
		int score = Integer.parseInt(mr.getParameter("option-star"));
		String contents = mr.getParameter("review-contents");
		
		int reviewNo = Integer.parseInt(mr.getParameter("review-no"));
		
		String sex = mr.getParameter("option-sex");
		int age = Integer.parseInt(mr.getParameter("option-age"));
		int height = Integer.parseInt(mr.getParameter("option-height"));
		int weight = Integer.parseInt(mr.getParameter("option-weight"));
		int size = Integer.parseInt(mr.getParameter("option-size"));
		
		ReviewInfo reviewInfo = reviewDao.getReviewInfoByReviewNo(reviewNo);
		
		reviewInfo.setReviewNo(reviewNo);
		reviewInfo.setSex(sex);
		reviewInfo.setAge(age);
		reviewInfo.setHeight(height);
		reviewInfo.setWeight(weight);
		reviewInfo.setSizes(size);
		
		reviewDao.updateReviewInfo(reviewInfo);
		
		Review review = reviewDao.getReviewByReviewNo(reviewNo);
		
		review.setNo(reviewNo);
		review.setOption(reviewDao.getOptionByOptionNo(optNo));
		review.setUser(reviewDao.getUserByUserNo(user.getNo()));
		review.setContents(contents);
		review.setScore(score);
		review.setPhoto(photo);
		
		reviewDao.updateReviewByReview(review);
		
		// ITEMS를 업데이트 하는 부분
		PhotoReviews prv = new PhotoReviews();
		prv.setNo(review.getNo());
		Item item = reviewDao.getItemByReviewNo(review.getNo());
		prv.setItem(item);
		
		reviewDao.updateRecentItemReviewNoByphotoReviews(prv);
		
		mav.setViewName("redirect:/mypage/mypageview.do");
		return mav;
	}
	
	@RequestMapping("/reviews/photoreview.do")
	public ModelAndView getAllofPhotoReviews(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		ReviewDao reviewDao = ReviewDao.getInstance();

		int cp = 1;
		int rows = 5;
		String sort = request.getParameter("sort")==null ? "score" : request.getParameter("sort");
		String option1 = request.getParameter("option1");
		String option2 = request.getParameter("option2");
		String option3 = request.getParameter("option3");
		String option4 = request.getParameter("option4");
		String option5 = request.getParameter("option5");
		String keyword = request.getParameter("keyword");
		String category = request.getParameter("category");
		
		try {
			cp = Integer.parseInt(request.getParameter("cp"));
			rows = Integer.parseInt(request.getParameter("rows"));
			
		} catch (Exception e) {}
		
		Criteria criteria = new Criteria();
		criteria.setBeginIndex((cp-1)*rows +1);
		criteria.setEndIndex(cp*rows);
		criteria.setSort(sort);
		criteria.setOption1(option1);
		criteria.setOption2(option2);
		criteria.setOption3(option3);
		criteria.setOption4(option4);
		criteria.setOption5(option5);
		criteria.setKeyword(keyword);
		criteria.setCategory(category);
		
		int totalRows =  reviewDao.getPhotoReviewsCount(criteria);
		Pagination pagination = new Pagination(cp, rows, totalRows);
		
		// 모든 포토 리뷰 조회
		List<PhotoReviews> photoReviews = reviewDao.getPhotoReviewsByCriteria(criteria);
		
		// 리뷰 내용이 15자가 넘어가면 줄여주는 기능
		for(PhotoReviews reviews : photoReviews) {
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
		
		List<PhotoReviews> bestReviews = reviewDao.getAllBestReviews();
		
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
		
		List<Category> categorys = reviewDao.getCategorys();
		
		mav.addAttribute("categorys", categorys);
		mav.addAttribute("bestReviews", bestReviews);
		mav.addAttribute("photoReviews", photoReviews);
		mav.addAttribute("pagination", pagination);
		
		mav.setViewName("reviews/photoreview.jsp");
		return mav;
	}
	
	@RequestMapping("/reviews/detail.do")
	public ModelAndView photoReviewDetail2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		ReviewDao reviewDao = ReviewDao.getInstance();
		
		int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
		
		AllReviews allReviews =  reviewDao.getAllReviewByReviewNo(reviewNo);
		ReviewInfo reviewInfo = reviewDao.getReviewInfoByReviewNo(reviewNo);
		List<Review> reviews = new ArrayList<>();
		reviews.add(reviewDao.getReviewByReviewNo(reviewNo));
		
		allReviews.setItem(reviewDao.getItemByReviewNo(reviewNo));
		allReviews.setReviews(reviews);
		allReviews.setReviewInfo(reviewInfo);
		
		// AJAX 데이터 추가
		mav.addAttribute("reviewJSON", allReviews);
		mav.setView(new JSONView());
		
		return mav;
	}
	
	@RequestMapping("/detail.do")
	public ModelAndView reviewDetailOnMain(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		ReviewDao reviewDao = ReviewDao.getInstance();
		
		int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
		
		AllReviews allReviews =  reviewDao.getAllReviewByReviewNo(reviewNo);
		ReviewInfo reviewInfo = reviewDao.getReviewInfoByReviewNo(reviewNo);
		List<Review> reviews = new ArrayList<>();
		reviews.add(reviewDao.getReviewByReviewNo(reviewNo));
		
		allReviews.setItem(reviewDao.getItemByReviewNo(reviewNo));
		allReviews.setReviews(reviews);
		allReviews.setReviewInfo(reviewInfo);
		
		// AJAX 데이터 추가
		mav.addAttribute("reviewJSON", allReviews);
		mav.setView(new JSONView());
		
		return mav;
	}
	
	@RequestMapping("/likes.do")
	public ModelAndView mainLikesAlter(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		ReviewDao reviewDao = ReviewDao.getInstance();
		
		// TODO :나중에 유저 정보를 받아야함 (중복방지용)
		
		int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
		int newLikes = Integer.parseInt(request.getParameter("likes"));
		boolean reclick = Boolean.parseBoolean(request.getParameter("reclick"));

		Review review = reviewDao.getReviewByReviewNo(reviewNo);
		int likes = review.getLikes();
		int participate = review.getLikesParticipate();
		
		// 증가
		if (newLikes > 0) {
			likes = likes + newLikes;
			
			if (reclick == false ) {
				
				if(participate <0) {
					participate = 0;
				} else {
					participate = participate -1;
				}
				
			} 
			if (reclick == true) {
				participate = participate +1;
			}
			
		// 감소	
		} else if (newLikes < 0) {
			
			if (likes <= 0) {
				likes = 0;
			} else {
				likes = likes - 1;
			}
			
			if (reclick == false ) {
				
				if(participate <0) {
					participate = 0;
				} else {
					participate = participate -1;
				}
				
			}
			
			if (reclick == true) {
				participate = participate +1;
			}
			
		}
		
		review.setLikes(likes);
		review.setLikesParticipate(participate);
		
		reviewDao.updateReviewLikesByReview(review);
		
		mav.addAttribute("review", review);
		mav.setView(new JSONView());
		
		return mav;
		
	}
	
	
	@RequestMapping("/reviews/likes.do")
	public ModelAndView likesAlter(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		ReviewDao reviewDao = ReviewDao.getInstance();
		
		// TODO :나중에 유저 정보를 받아야함 (중복방지용)
		
		int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
		int newLikes = Integer.parseInt(request.getParameter("likes"));
		boolean reclick = Boolean.parseBoolean(request.getParameter("reclick"));

		Review review = reviewDao.getReviewByReviewNo(reviewNo);
		int likes = review.getLikes();
		int participate = review.getLikesParticipate();
		
		// 증가
		if (newLikes > 0) {
			likes = likes + newLikes;
			
			if (reclick == false ) {
				
				if(participate <0) {
					participate = 0;
				} else {
					participate = participate -1;
				}
				
			} 
			if (reclick == true) {
				participate = participate +1;
			}
			
		// 감소	
		} else if (newLikes < 0) {
			
			if (likes <= 0) {
				likes = 0;
			} else {
				likes = likes - 1;
			}
			
			if (reclick == false ) {
				
				if(participate <0) {
					participate = 0;
				} else {
					participate = participate -1;
				}
				
			}
			
			if (reclick == true) {
				participate = participate +1;
			}
			
		}
		
		review.setLikes(likes);
		review.setLikesParticipate(participate);
		
		reviewDao.updateReviewLikesByReview(review);
		
		mav.addAttribute("review", review);
		mav.setView(new JSONView());
		
		return mav;
		
	}

}
