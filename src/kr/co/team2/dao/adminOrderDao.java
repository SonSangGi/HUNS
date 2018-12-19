package kr.co.team2.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.OrderDetail;
import kr.co.team2.vo.Orders;
import kr.co.team2.vo.monthlySales;

public class adminOrderDao {

	private adminOrderDao() {
	}

	private static adminOrderDao instance;

	public static adminOrderDao getInstance() {
		if (instance == null) {
			instance = new adminOrderDao();
		}
		return instance;
	}

	@SuppressWarnings("unchecked")
	public List<monthlySales> getRecentOrders() throws SQLException {
		return SqlMapClientUtil.getSqlMapClient().queryForList("getRecentOrders");
	}

	// 장바구니 삭제
	public void deleteCart(int optNo) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().delete("deleteCart", optNo);
	}

	// 주문 디테일 전체 조회
	@SuppressWarnings("unchecked")
	public List<OrderDetail> getAllOrderDetails() throws SQLException {
		return SqlMapClientUtil.getSqlMapClient().queryForList("getAllOrderDetails");
	}

	// 주문 번호로 조회
	public Orders getOrderByNo(int orderNo) throws SQLException {
		return (Orders) SqlMapClientUtil.getSqlMapClient().queryForObject("getOrderByN", orderNo);
	}

	// 주문 수정
	public void orderUpdate(Orders order) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().update("orderUpdat", order);
	}
	//입금대기 주문 조회
	public int getBeforeOrders()throws SQLException{
		return (Integer)SqlMapClientUtil.getSqlMapClient().queryForObject("getBeforeOrders");
	}

}
