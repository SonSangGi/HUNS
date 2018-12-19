package kr.co.team2.service.admin;

import java.sql.SQLException;
import java.util.List;

import kr.co.team2.dao.adminItemDao;
import kr.co.team2.dao.adminOrderDao;
import kr.co.team2.dao.adminUserDao;
import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.Option;
import kr.co.team2.vo.OrderDetail;
import kr.co.team2.vo.Orders;
import kr.co.team2.vo.User;
import kr.co.team2.vo.monthlySales;

public class adminOrderService {

	adminOrderDao orderDao = adminOrderDao.getInstance();
	adminUserDao userDao = adminUserDao.getInstance();
	adminItemDao itemDao = adminItemDao.getInstance();

	//
	public List<monthlySales> getRecentOrders() throws SQLException {
		return orderDao.getRecentOrders();
	}

	// 주문 디테일 전체 조회 @ 모든 값 담아서 전송 (주문정보,유저정보,옵션정보)
	public List<OrderDetail> getAllOrderDetails() throws SQLException {

		List<OrderDetail> orders = orderDao.getAllOrderDetails();

		for (OrderDetail orderDetail : orders) {
			Orders order = orderDao.getOrderByNo(orderDetail.getOrder().getNo());
			System.out.println(order);
			User user = userDao.getUserByNo(order.getUser().getNo());
			System.out.println(user);
			order.setUser(user);
			orderDetail.setOrder(order);

			Option option = itemDao.getOptionByOptNo(orderDetail.getOption().getNo());
			if (option != null) {
				Item item = itemDao.getItemByNo(option.getItem().getNo());
				option.setItem(item);
				orderDetail.setOption(option);
			}
		}

		return orders;
	}

	// 주문 번호로 조회
	public Orders getOrderByNo(int orderNo) throws SQLException {
		return orderDao.getOrderByNo(orderNo);
	}

	// 주문 수정
	public void orderUpdate(Orders order) throws SQLException {
		orderDao.orderUpdate(order);
	}

	// 입금대기 주문 조회
	public int getBeforeOrders() throws SQLException {
		return orderDao.getBeforeOrders();
	}
}
