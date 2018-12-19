package kr.co.team2.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.OrderDetail;
import kr.co.team2.vo.Orders;

public class OrdersDao {
	private static OrdersDao self = new OrdersDao();
	private OrdersDao () {}
	public static OrdersDao getInstance() {
		return self;
	}

	public int getOrderSeq() throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int no = (Integer) sqlMapClient.queryForObject("getOrderSeq");
		return no;
	}
	
	public void saveOrder(Orders orders) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.insert("saveOrder", orders );
	}
	
	public void saveOrderDetail(OrderDetail orderDetail) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.insert("saveOrderDetail", orderDetail );
	}
	
	
	@SuppressWarnings("unchecked")
	public List<OrderDetail> getOrders(Map<String, Object> params) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<OrderDetail> orders = (List<OrderDetail>)sqlMapClient.queryForList("getOrders", params);
		
		return orders;

	}
	
	
}
