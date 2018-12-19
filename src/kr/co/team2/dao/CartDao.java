package kr.co.team2.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapSession;
import com.ibatis.sqlmap.engine.mapping.sql.Sql;

import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.Cart;
import kr.co.team2.vo.Item;

public class CartDao {
	private static CartDao self = new CartDao();
	private CartDao () {}
	public static CartDao getInstance() {
		return self;
	}
	
	public void saveCart(Cart cart) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		sqlMapClient.insert("saveCart", cart);
	}
	
	public List<Cart> getCart(int userNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Cart> carts = (List<Cart>)sqlMapClient.queryForList("getCart", userNo);
		
		return carts;
	}
	public Cart getCartByNo(int cartNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		return (Cart)sqlMapClient.queryForObject("getCartByNo", cartNo);
		
	}
	
	// 선택 삭제
	public void deleteCartByCartNo(int cartNo) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().delete("deleteCartByCartNo",cartNo);
		
	}
	
	// 장바구니 비우기
	public void deleteAllCart(int userno) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().delete("deleteAllCart", userno);
	}
	
	public void updateCartCount(Cart cart)throws SQLException{
		SqlMapClientUtil.getSqlMapClient().update("updateCartCount",cart);
	}
}
