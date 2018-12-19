package kr.co.team2.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.JSONView;
import kr.co.jhta.mvc.servlet.ModelAndView;
import kr.co.team2.dao.ItemDao;
import kr.co.team2.vo.Category;
import kr.co.team2.vo.Criteria;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.ItemQuestion;
import kr.co.team2.vo.Option;
import kr.co.team2.vo.Pagination;
import kr.co.team2.vo.Review;

@Controller
public class StoreController {
		
	ItemDao itemDao = ItemDao.getInstance();
	
	@RequestMapping("/stores/list.do")
	public ModelAndView getItemsByCategoryNo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		/*int cp = 1; 
		int rows = 1;
		int category = 10;
		int subCategory = -1;
		String sort = request.getParameter("order") == null ? "newp" : request.getParameter("order");
		
		try {
			category = Integer.parseInt(request.getParameter("category"));
			subCategory = Integer.parseInt(request.getParameter("subCategory"));
			cp = Integer.parseInt(request.getParameter("cp"));
			rows = Integer.parseInt(request.getParameter("rows"));
		} catch (Exception e) {}*/
		
		int cp = 1; 
		int rows = 9;
		int category = 10;
		int subCategory = -1;
		String sort = "newp";
		
		if(request.getParameter("cp") != null && !request.getParameter("cp").equals("")) {
			cp = Integer.parseInt(request.getParameter("cp"));
		}
		if(request.getParameter("rows") != null && !request.getParameter("rows").equals("")) {
			rows = Integer.parseInt(request.getParameter("rows"));
		}
		if(request.getParameter("category") != null && !request.getParameter("category").equals("")) {
			category = Integer.parseInt(request.getParameter("category"));
		}
		if(request.getParameter("subCategory") != null && !request.getParameter("subCategory").equals("")) {
			subCategory = Integer.parseInt(request.getParameter("subCategory"));
		}
		if(request.getParameter("order") != null && !request.getParameter("order").equals("")) {
			sort = request.getParameter("order");
		}
		
		Criteria criteria = new Criteria();
		criteria.setBeginIndex((cp-1)*rows + 1);
		criteria.setEndIndex(cp*rows);
		criteria.setSort(sort);
		criteria.setNo(category);
		criteria.setSubCategory(subCategory);
		
		int totalRows = itemDao.getItemsCount(criteria);
		Pagination pagination = new Pagination(cp,rows,totalRows);
			
		List<Item> items = itemDao.getItemsByCriteria(criteria);
		List<Category> categorys = itemDao.subCategorySortByNo(category);
		Category cateName = itemDao.mainCategoryName(category);
		
		ModelAndView mav = new ModelAndView();
		mav.addAttribute("items", items);
		mav.addAttribute("categorys", categorys);
		mav.addAttribute("pagination", pagination);
		mav.addAttribute("cateName", cateName);
		mav.setViewName("stores/list.jsp");
		

		return mav;
	}
	
	@RequestMapping("/stores/detail.do")
	public ModelAndView detail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();

		int no = Integer.parseInt(request.getParameter("no"));
		//int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		//int itemQuestionNo = Integer.parseInt(request.getParameter("itemQuestionNo"));
		
		Item item = itemDao.getItemByItemNo(no);
		List<Option> optionz = itemDao.getItemOptionByItemNo(no);
		List<Review> photos = itemDao.getPhotosByItemNo(no);
		List<Review> reviews = itemDao.getReviewByItemNo(no);
		List<ItemQuestion> questions = itemDao.getQuestionBoardByItemNo(no);
		
		Cookie[] cookies = request.getCookies();
		List<Item> cookieItem = new ArrayList<>();
		if(cookies !=null) {
			String cookieValue = this.getCookieValue(cookies,"recent-item");
			if(cookieValue != null) {
				String currentValue = this.addCookieValue(cookieValue,no);
				Cookie cookie = new Cookie("recent-item",currentValue);
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*365);
				response.addCookie(cookie);
			}else if(cookieValue == null) {
				Cookie cookie = new Cookie("recent-item",String.valueOf(no));
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*365);
				response.addCookie(cookie);
			}
		}
		
		if(cookies !=null) {
			String cookieValue = this.getCookieValue(cookies, "recent-item");
			if(cookieValue != null) {
				String[] items = cookieValue.split(":");
				for(String cookieitemNo : items) {
					Item cookieitem = itemDao.getItemByItemNo(Integer.parseInt(cookieitemNo));
					cookieItem.add(cookieitem);
				}	
			}
		}
		mav.addAttribute("cookieItem", cookieItem);
		mav.addAttribute("item", item);
		mav.addAttribute("optionz", optionz);
		mav.addAttribute("photos", photos);
		mav.addAttribute("reviews", reviews);
		mav.addAttribute("questions", questions);
		mav.setViewName("stores/detail.jsp");
		
		return mav;
		
		
	}
	private String addCookieValue(String cookieValue, int itemNo) {
		List<String> items = new ArrayList<String>();
		
		String[] itemValue = cookieValue.split(":");
		
		for(String value : itemValue) {
			items.add(value);
		}
		
		if(items.contains(String.valueOf(itemNo))) {
			System.out.println("itemno:"+ itemNo);
			return cookieValue;
		}
		if(items.size() >=5) {
			items.remove(0);
		}
		items.add(String.valueOf(itemNo));
		
		String currentValue =String.join(":",items);
		
		return currentValue;
	}

	private String getCookieValue(Cookie[] cookies, String cookieName) {
		
		if(cookies ==null) {
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
	@RequestMapping("/stores/optiondetail.do")
	public ModelAndView optiondetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String color = request.getParameter("color");
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		
		Map<String, Object> map = new HashMap<>();
		map.put("color", color);
		map.put("itemNo", itemNo);
		
		List<Option> options = itemDao.getItemSizeBySelected(map);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addAttribute("options", options );
		mav.setView(new JSONView());
		return mav;
	}
}
