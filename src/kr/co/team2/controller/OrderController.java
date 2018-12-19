package kr.co.team2.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.ModelAndView;
import kr.co.team2.dao.CartDao;
import kr.co.team2.dao.OrderListDao;
import kr.co.team2.dao.OrdersDao;
import kr.co.team2.dao.ReviewDao;
import kr.co.team2.vo.Cart;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.Option;
import kr.co.team2.vo.OrderDetail;
import kr.co.team2.vo.Orders;
import kr.co.team2.vo.User;

@Controller
public class OrderController {
	
	@RequestMapping("/orders/cart-order.do")
	public ModelAndView cartOrder(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ModelAndView mav = new ModelAndView();
		
		String[] cartNos = request.getParameterValues("cartno");
		String[] amounts = request.getParameterValues("amount");
		
		CartDao cartDao = CartDao.getInstance();
		
		List<OrderDetail> orders = new ArrayList<>();
		for (int i=0; i<cartNos.length; i++) {
			int cartNo = Integer.parseInt(cartNos[i]);
			Cart cart = cartDao.getCartByNo(cartNo);
			Option option = cart.getOption();
			
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setOption(option);
			orderDetail.setQty(Integer.parseInt(amounts[i]));
			
			orders.add(orderDetail);
		}
		
		mav.addAttribute("orders", orders);
		mav.setViewName("orders/orders.jsp");
		
		return mav;
	}

	@RequestMapping("/orders/save.do")
	public ModelAndView orders (HttpServletRequest request, HttpServletResponse response) throws SQLException {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("LOGIN_USER_INFO");
		if (user == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}
		String qtys = request.getParameter("qty");
		String optionNos = request.getParameter("optNos");
		
		String[] qtysSplit= qtys.split(",");
		String[] optionsSplit = optionNos.split(",");
		System.out.println("크기:"+optionsSplit.length);
		
		OrdersDao orderDao = OrdersDao.getInstance();
		for(int i=0; i <= optionsSplit.length-1;i++) {
			
			int qty = Integer.parseInt(qtysSplit[i]);
			int optNo = Integer.parseInt(optionsSplit[i]);
			int orderNo = orderDao.getOrderSeq();
			
			System.out.println(optNo);
			System.out.println(qty);
			
			Orders orders = new Orders();
			orders.setNo(orderNo);
			orders.setUser(user);
			
			orderDao.saveOrder(orders);
			
			
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setQty(qty);
			orderDetail.setOrder(orders);
			Option option = new Option();
			option.setNo(optNo);
			orderDetail.setOption(option);
			orderDao.saveOrderDetail(orderDetail);
		}
		
		
		
		mav.setViewName("redirect:completed.do");
		
		
		return mav;
		
	}
	
	
	// 주문완료 페이지 링크
	@RequestMapping("/orders/completed.do")
	public ModelAndView completed (HttpServletRequest request, HttpServletResponse response) throws SQLException {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("LOGIN_USER_INFO");
		if (user == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}
		
		mav.setViewName("orders/completed.jsp");
		return mav;
	}
	

	// 주문조회
	@RequestMapping("/orders/saveList.do")
	public ModelAndView ordersSave (HttpServletRequest request, HttpServletResponse response) throws SQLException {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("LOGIN_USER_INFO");
		if (user == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}
		
		String startDate = request.getParameter("searchStartDate");
		String endDate = request.getParameter("searchEndDate");
		
		Map<String, Object> params = new HashMap<>();
		
		params.put("userno", user.getNo());
		if (startDate != null && !startDate.isEmpty()) {
			params.put("startDate", startDate);
		}
		if (endDate != null && !endDate.isEmpty()) {
			params.put("endDate", endDate);
		}
		
		OrdersDao ordersDao = OrdersDao.getInstance();
		List<OrderDetail> orders = ordersDao.getOrders(params);
		
		mav.addAttribute("orders", orders);
		mav.setViewName("orders/orderList.jsp");
		
		return mav;
	}
	
	
	// 상품 --> 주문하기
	@RequestMapping("/orders/orders.do")
	public ModelAndView orderSave (HttpServletRequest request, HttpServletResponse response) throws SQLException {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("LOGIN_USER_INFO");
		if (user == null) {
			mav.setViewName("redirect:/home.do");
			return mav;
		}
		
		int optNo = Integer.parseInt(request.getParameter("optNo"));
		int qty = Integer.parseInt(request.getParameter("amount"));
		
		OrderListDao orderListDao = OrderListDao.getInstance();
		Option option = orderListDao.getOrderOption(optNo);
		
		
		List<OrderDetail> orders = new ArrayList<>();
		OrderDetail order = new OrderDetail();
		order.setOption(option);
		order.setQty(qty);
		orders.add(order);
		
		mav.addAttribute("orders", orders);
		
		mav.setViewName("orders/orders.jsp");
		
		return mav;
		

	}
	
	
}
