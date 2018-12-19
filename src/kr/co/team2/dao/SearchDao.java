package kr.co.team2.dao;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.Category;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.Review;

public class SearchDao {

	private static SearchDao self = new SearchDao();
	private SearchDao() {}
	public static SearchDao getInstance() {
		return self;
	}
	
	
	
}
