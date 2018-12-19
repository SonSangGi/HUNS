package kr.co.team2.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.Criteria;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.ItemQuestion;
import kr.co.team2.vo.Review;

public class MyPageDao {

	private static MyPageDao self = new MyPageDao();
	private MyPageDao() {}
	public static MyPageDao getInstance() {
		return self;
	}
	
	public List<ItemQuestion> getMyBoardByNo(int userno) throws SQLException{
		List<ItemQuestion> items = SqlMapClientUtil.getSqlMapClient().queryForList("getMyBoardByNo", userno);
		return items;
	}
	public List<Review> getMyReviewsByCriteria(Criteria criteria) throws SQLException {
		List<Review> reviews = (List<Review>)SqlMapClientUtil.getSqlMapClient().queryForList("getMyReviewsByCriteria",criteria);
		return reviews;
	}
	public List<ItemQuestion> getQuestionviewsByCriteria(Criteria criteria) throws SQLException {		
		List<ItemQuestion> questions = (List<ItemQuestion>)SqlMapClientUtil.getSqlMapClient().queryForList("getQuestionviewsByCriteria", criteria);
		return questions;
	}
	public List<Item> getImpoItemByNo(int itemno) throws SQLException{
		List<Item> recentItem = (List<Item>)SqlMapClientUtil.getSqlMapClient().queryForList("getImpoItemByNo",itemno);
		return recentItem;
	}
	public Item getrecentByNo(int itemno) throws SQLException{
		Item recentItem = (Item)SqlMapClientUtil.getSqlMapClient().queryForObject("getrecentByNo",itemno);
		return recentItem;
	}
	
}
