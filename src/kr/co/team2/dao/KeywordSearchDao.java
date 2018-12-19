package kr.co.team2.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.Criteria;
import kr.co.team2.vo.Item;

public class KeywordSearchDao {

	private static KeywordSearchDao self = new KeywordSearchDao();
	private KeywordSearchDao () {};
	public static KeywordSearchDao getInstance() {
		return self;
	}
	
	
	public List<Item> getItemSearchByCriteria(Criteria criteria) throws SQLException{
		List<Item> items = (List<Item>)SqlMapClientUtil.getSqlMapClient().queryForList("getItemSearchByCriteria", criteria);
		return items;
	}
	public int getSearchCount(Criteria criteria) throws SQLException {
		int searchCount = (int)SqlMapClientUtil.getSqlMapClient().queryForObject("getSearchCount",criteria);
		return searchCount;
	}
	public List<Item> getItemSearchBykeyword(Criteria criteria) throws SQLException {
		List<Item> items = (List<Item>)SqlMapClientUtil.getSqlMapClient().queryForList("getItemSearchBykeyword", criteria);
		return items;
	}
}
