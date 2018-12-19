package kr.co.team2.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.common.collect.Sets.SetView;

import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.JSONView;
import kr.co.jhta.mvc.servlet.ModelAndView;
import kr.co.team2.dao.CartDao;
import kr.co.team2.dao.HomeDao;
import kr.co.team2.dao.OrderListDao;
import kr.co.team2.vo.Cart;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.Option;
import kr.co.team2.vo.User;

@Controller
public class CartController {

	
	
	@RequestMapping("/carts/cart.do")
	public ModelAndView cartCheck(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		
		/*
		 * 메인페이지에서 장바구니를 클릭시 이쪽페이지로이동한다.
		 * 이쪽페이지에서 쿠키를 사용해서 쿠키 안에 데이터가 비어 있으면
		 * 
		 * if(세션이 없을때){ 
		 * 		if(쿠키가 비면){
		 * 			mav.setViewName(/carts/cart-empty.do);
		 * 		} else { 쿠키가 비어 있지않으면}
		 * 			mav.setViewName(/carts/cart-order.do?type=cookie);
		 * 	}else if(세션이 있을때){
		 * 		세션에 잇는 정보를 통해 user_no를 가지고 와서 db에 있는 cart를 찾는다.
		 * 		if( 해당 유저에 대한 cart의 정보가 있으면){
		 * 			mav.setView(/carts/cart-order.do?type=db);
		 * 		else if(정보가 없으면){
		 * 			mav.setView(/carts/cart-empty.do)
		 * 			
		 * 		}
		 * return 
		 * */
		/*List<Item> items = cartDao.getCart(cartId);
		if (Item.isempty) {
			mav.setViewName("cart-empty.jsp");
		} else {
			mav.setViewName("cart-order.jsp");
		}
		*/

		/*if () {
			if(Item.isEmpty) {
				mav.setView("/carts/cart-empty.do");
			} else {
				mav.setView("/carts/cart-order.do?type=db");
			}
		}
		*/
		
		
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	
	@RequestMapping("/carts/cart-empty.do")
	public ModelAndView cartEmpty (HttpServletRequest request, HttpServletResponse response) throws SQLException {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("carts/cart-empty.jsp");
		
		return mav;
		
	}
	
	@RequestMapping("/carts/cart-order.do")
	public ModelAndView cartOrder (HttpServletRequest request, HttpServletResponse response) throws SQLException {
		
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("LOGIN_USER_INFO");
		if (user == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}
		
		int optNo = Integer.parseInt(request.getParameter("optNo"));
		int qty = Integer.parseInt(request.getParameter("amount"));
		
		Cart cart = new Cart();
		cart.setUser(user);
		
		Option option = new Option();
		option.setNo(optNo);
		cart.setOption(option);
		
		cart.setCount(qty);
		
		CartDao cartDao = CartDao.getInstance();
		cartDao.saveCart(cart);
		
		session.setAttribute("cartCount", HomeDao.getInstance().getCartCount(user.getNo()));
		
		mav.setViewName("redirect:cart-list.do");

		return mav;
	}

	@RequestMapping("/carts/cart-list.do")
	public ModelAndView cartList (HttpServletRequest request, HttpServletResponse response) throws SQLException {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("LOGIN_USER_INFO");
		if (user == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}
		
		CartDao cartDao = CartDao.getInstance();
		List<Cart> carts = cartDao.getCart(user.getNo());
		
		mav.addAttribute("carts", carts);
		mav.addAttribute("cart", carts.size()); // cart (1) 불러오기
		mav.setViewName("carts/cart-order.jsp");
		
		return mav;
	}
	
	
	
	// 장바구니 비우기
	@RequestMapping("/carts/deleteAll.do")
	public ModelAndView deleteAll(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("LOGIN_USER_INFO");
		if (user == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}

		int userno = user.getNo();
		CartDao cartDao = CartDao.getInstance();
		cartDao.deleteAllCart(userno);
		
		session.setAttribute("cartCount", 0);
		
		mav.setViewName("redirect:/carts/cart-list.do");
	
		return mav;
		
	}

	@RequestMapping("/carts/deletemany.do")
	public ModelAndView deleteMany(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("LOGIN_USER_INFO");
		if (user == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}
		
		CartDao cartDao = CartDao.getInstance();
		
		String[] cartnos = request.getParameterValues("cartno");
		for (String text : cartnos) {
			int cartno = Integer.parseInt(text);
			cartDao.deleteCartByCartNo(cartno);
		}
		
		session.setAttribute("cartCount", HomeDao.getInstance().getCartCount(user.getNo()));
		
		mav.setViewName("redirect:/carts/cart-list.do");
		return mav;
	}
	
	// 장바구니 삭제
	@RequestMapping("/carts/delete.do")
	public ModelAndView delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("LOGIN_USER_INFO");
		if (user == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}
		
		int no = Integer.parseInt(request.getParameter("cartno"));
		CartDao cartDao = CartDao.getInstance();
		cartDao.deleteCartByCartNo(no);
		
		session.setAttribute("cartCount", HomeDao.getInstance().getCartCount(user.getNo()));

		mav.setViewName("redirect:/carts/cart-list.do");
		return mav;
	}
	
	@RequestMapping("/carts/update.do")
	public ModelAndView update(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("LOGIN_USER_INFO");
		if (user == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}
		int count = Integer.parseInt(request.getParameter("count"));
		int cartNo = Integer.parseInt(request.getParameter("cartNo"));
		Cart cart = new Cart();
		cart.setUser(user);
		cart.setNo(cartNo);
		cart.setCount(count);
		
		String result = "";
		CartDao cartDao = CartDao.getInstance();
		try {
			cartDao.updateCartCount(cart);
			result = "OK";
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("주문 업데이트 오류");
			result = "NO";
		}
		mav.addAttribute("result", result);
		mav.setView(new JSONView());
		return mav;
	}
}


