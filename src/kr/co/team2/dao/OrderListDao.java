package kr.co.team2.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.Option;
import kr.co.team2.vo.OrderDetail;
import kr.co.team2.vo.Orders;

public class OrderListDao {
	private static OrderListDao self = new OrderListDao();
	private OrderListDao () {}
	public static OrderListDao getInstance() {
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
	
	
	public List<OrderDetail> getOrderSave(int userNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<OrderDetail> orders = (List<OrderDetail>)sqlMapClient.queryForList("getOrderSave",userNo);
		
		return orders;

	}
	
	public Option getOrderOption(int optNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		Option opt = (Option)sqlMapClient.queryForObject("getOrderOption", optNo);
		return opt;
	}
}
