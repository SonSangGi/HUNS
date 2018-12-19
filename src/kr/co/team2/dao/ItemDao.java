package kr.co.team2.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.Category;
import kr.co.team2.vo.Criteria;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.ItemQuestion;
import kr.co.team2.vo.Option;
import kr.co.team2.vo.Review;

public class ItemDao {

	private static ItemDao self = new ItemDao();
	private ItemDao() {}
	public static ItemDao getInstance() {
		return self;
	}
	
	// 카테고리 상위번호로 제품 조회
	@SuppressWarnings("unchecked")
	public List<Item> getItemsByCategoryNo() throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Item> items = sqlMapClient.queryForList("getItemsByCategoryNo");
		return items;
	}
	
	@SuppressWarnings("unchecked")
	// 상세 제품 확인하기 
	public List<Item> getItemsByDetailNo() throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Item> items = sqlMapClient.queryForList("getItemsByDetailNo");
		return items;
	}
	
	// 디테일 화면에서 아이템 번호로 상품 이름, 상품 가격 조회
	public Item getItemByItemNo(int itemNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		Item item = (Item)sqlMapClient.queryForObject("getItemByItemNo", itemNo);
		return item;
	}
	
	// 디테일 화면에서 아이템 번호로 해당 상품 옵션들 조회
	@SuppressWarnings("unchecked")
	public List<Option> getItemOptionByItemNo(int itemNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Option> options = sqlMapClient.queryForList("getItemOptionByItemNo", itemNo);
		return options;
	}
	
	// 디테일 화면에서 아이템 번호로 해당 상품 size 조회
	@SuppressWarnings("unchecked")
	public List<Option> getItemSizeByItemNo(String selColor) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Option> options = sqlMapClient.queryForList("getItemSizeByItemNo", selColor);
		return options;
	}
	
	@SuppressWarnings("unchecked")
	public List<Option> getItemSizeBySelected(Map<String, Object> map) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Option> option = sqlMapClient.queryForList("getItemSizeBySelected",map);
		return option;
	}
	
//	public Option getItemByOptions(String selColor, String selSize) throws SQLException {
//		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
//		Option option = (Option)sqlMapClient.queryForObject("getItemByOptions",selColor,selSize);
//		return option;
//	}
	
	// 디테일 화면에서 카테고리 번호로 제품 등록일순 조회
	@SuppressWarnings("unchecked")
	public List<Item> itemsOrderByDate() throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Item> items = sqlMapClient.queryForList("itemsOrderByDate");
		return items;
	}
	
	// 디테일 화면에서 카테고리 번호로 제품 인기순으로 조회
	@SuppressWarnings("unchecked")
	public List<Item> itemsOrderByStock() throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Item> items = sqlMapClient.queryForList("itemsOrderByStock");
		return items;
	}
	
	@SuppressWarnings("unchecked")
	public List<Item> getItemsByCriteria(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Item> items = sqlMapClient.queryForList("getItemsByCriteria", criteria);
		return items;
	}
	
	public Category mainCategoryName(int no) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		Category category = (Category)sqlMapClient.queryForObject("mainCategoryName", no);
		return category;
	}
	
	@SuppressWarnings("unchecked")
	public List<Category> subCategorySortByNo(int no) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Category> categorys = sqlMapClient.queryForList("subCategorySortByNo", no);
		return categorys;
	}
	
	public int getItemsCount(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int count = (Integer) sqlMapClient.queryForObject("getItemsCount",criteria);
		return count;
	}
	
	@SuppressWarnings("unchecked")
	public List<Review> getPhotosByItemNo(int itemNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Review> photos = sqlMapClient.queryForList("getPhotosByItemNo",itemNo);
		return photos;
	}
	
	@SuppressWarnings("unchecked")
	public List<Review> getReviewByItemNo(int itemNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Review> reviews = sqlMapClient.queryForList("getReviewByItemNo", itemNo);
		return reviews;
	}
	
	@SuppressWarnings("unchecked")
	public List<ItemQuestion> getQuestionBoardByItemNo(int itemNo) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<ItemQuestion> question = sqlMapClient.queryForList("getQuestionBoardByItemNo",itemNo);
		return question;
	}
	
	@SuppressWarnings("unchecked")
	public List<Option> sendOptNoToReview(Map<String, Object> map) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		List<Option> optionNo = sqlMapClient.queryForList("sendOptNoToReview", map);
		return optionNo;
	}
}
