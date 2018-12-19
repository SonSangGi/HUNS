package kr.co.team2.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ibatis.sqlmap.engine.type.IntegerTypeHandler;

import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.JSONView;
import kr.co.jhta.mvc.servlet.ModelAndView;
import kr.co.team2.dao.KeywordSearchDao;
import kr.co.team2.vo.Criteria;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.Pagination;
@Controller
public class MenuController {
	
	//페이지 이동
	@RequestMapping("/menu/search.do")
	public ModelAndView search(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		System.out.println("검색");
		ModelAndView mav = new ModelAndView();
		
		String category = request.getParameter("category");
		String opt = request.getParameter("opt");
		String keyword = request.getParameter("keyword");
		String minPrice = request.getParameter("minprice");
		String maxPrice = request.getParameter("maxprice");
		String orderBox = request.getParameter("orders");
		System.out.println("카테고리:"+category);
		System.out.println("옵션:"+opt);
		System.out.println("키워드:"+keyword);
		System.out.println(minPrice+"~"+maxPrice);
		System.out.println("종류:"+orderBox);
		/*if(opt ==null && opt.isEmpty()) {
			opt = "itemName";
		}*/
		Criteria criteria = new Criteria();
		criteria.setSort(orderBox);
		
		if(keyword != null && !keyword.isEmpty()) {
			criteria.setKeyword(keyword);
			criteria.setOpt(opt);
		}
		if(category != null && !category.isEmpty()) {
			criteria.setNo(Integer.parseInt(category));
		}
		if((minPrice != null && !minPrice.isEmpty()) && (maxPrice !=null && !maxPrice.isEmpty())) {
			criteria.setMinPrice(Integer.parseInt(minPrice));
			criteria.setMaxPrice(Integer.parseInt(maxPrice));
		}
		//페이지 처리
		int cp = 1;
		int rows = 9;
		try {
			cp = Integer.parseInt(request.getParameter("cp"));
			System.out.println("cp:"+cp);
		}catch (Exception e) {
			// TODO: handle exception
		}
		
		criteria.setBeginIndex((cp-1)*rows + 1);
		criteria.setEndIndex(cp*rows);
		KeywordSearchDao keywordSearchDao = KeywordSearchDao.getInstance();
		int totalRows = keywordSearchDao.getSearchCount(criteria);
		
		Pagination pagination = new Pagination(cp, rows, totalRows);
		List<Item> items =  keywordSearchDao.getItemSearchByCriteria(criteria);
		mav.addAttribute("totalRows", totalRows);
		mav.addAttribute("items", items);
		//mav.addAttribute("pagination", pagination);
		
		/*
		if(minPrice<0 || maxPrice<0) {
			minPrice = 0;
			maxPrice = 0;
		}
		if(maxPrice != 0) {
			
		}*/
		mav.setViewName("menu/search.jsp");
		
		return mav;
	}
	
	@RequestMapping("/menu/items.do")
	public ModelAndView items(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		System.out.println("검색");
		ModelAndView mav = new ModelAndView();
		
		String category = request.getParameter("category");
		String opt = request.getParameter("opt");
		String keyword = request.getParameter("keyword");
		String minPrice = request.getParameter("minprice");
		String maxPrice = request.getParameter("maxprice");
		String orderBox = request.getParameter("orders");
		/*if(opt ==null && opt.isEmpty()) {
			opt = "itemName";
		}*/
		Criteria criteria = new Criteria();
		criteria.setSort(orderBox);
		
		if(keyword != null && !keyword.isEmpty()) {
			criteria.setKeyword(keyword);
			criteria.setOpt(opt);
		}
		if(category != null && !category.isEmpty()) {
			criteria.setNo(Integer.parseInt(category));
		}
		if((minPrice != null && !minPrice.isEmpty()) && (maxPrice !=null && !maxPrice.isEmpty())) {
			criteria.setMinPrice(Integer.parseInt(minPrice));
			criteria.setMaxPrice(Integer.parseInt(maxPrice));
		}
		//페이지 처리
		int cp = 1;
		int rows = 9;
		try {
			cp = Integer.parseInt(request.getParameter("cp"));
			System.out.println(cp);
		}catch (Exception e) {
			// TODO: handle exception
		}
		
		criteria.setBeginIndex((cp-1)*rows + 1);
		criteria.setEndIndex(cp*rows);
		KeywordSearchDao keywordSearchDao = KeywordSearchDao.getInstance();
		int totalRows = keywordSearchDao.getSearchCount(criteria);
		
		Pagination pagination = new Pagination(cp, rows, totalRows);
		List<Item> items =  keywordSearchDao.getItemSearchByCriteria(criteria);
		System.err.println(items.size());
		System.out.println(items.isEmpty());
		mav.addAttribute("totalRows", totalRows);
		mav.addAttribute("items", items);
		//mav.addAttribute("pagination", pagination);
		
		/*
		if(minPrice<0 || maxPrice<0) {
			minPrice = 0;
			maxPrice = 0;
		}
		if(maxPrice != 0) {
			
		}*/
		//mav.setViewName("menu/search.jsp");
		mav.setView(new JSONView());
		return mav;
	}
	
	@RequestMapping("/menu/admin.do")
	public ModelAndView Admin(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/home.jsp");
		return mav;
	}
	
	@RequestMapping("/menu/register.do")
	public ModelAndView register(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("users/view_register.jsp");
		return mav;
	}
	
	@RequestMapping("/menu/carts.do")
	public ModelAndView cart(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("carts/test.jsp");
		return mav;
		
	}
	
	//@RequestMapping("")
	//public ModelAndView or
		
	
}
