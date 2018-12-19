package kr.co.team2.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.Category;
import kr.co.team2.vo.Criteria;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.ItemQuestion;
import kr.co.team2.vo.ItemQuestionType;
import kr.co.team2.vo.Option;

public class adminItemDao {

	private static adminItemDao instance;

	private adminItemDao() {
	}

	public static adminItemDao getInstance() {
		if (instance == null) {
			instance = new adminItemDao();
		}
		return instance;
	}

	// 미답변 문의
	@SuppressWarnings("unchecked")
	public List<ItemQuestion> getNotAnswerQuestion() throws SQLException {
		return SqlMapClientUtil.getSqlMapClient().queryForList("getNotAnswerQuestion");
	}

	// 답변 문의
	@SuppressWarnings("unchecked")
	public List<ItemQuestion> getAnsweredQuestion() throws SQLException {
		return SqlMapClientUtil.getSqlMapClient().queryForList("getAnsweredQuestion");
	}

	// 문의 타입 조회
	public String getQuestionTypeByNo(int questionNo) throws SQLException {
		return (String) SqlMapClientUtil.getSqlMapClient().queryForObject("getQuestionTypeByNo", questionNo);
	}

	// 전체 아이템 카운트
	public int getAllItemsCount() throws SQLException {
		return (Integer) SqlMapClientUtil.getSqlMapClient().queryForObject("getAllItemsCount");
	}

	// 미답변 문의 카운트
	public int getNotAnswerCount() throws SQLException {
		return (Integer) SqlMapClientUtil.getSqlMapClient().queryForObject("getNotAnswerCount");
	}

	// 오늘의 리뷰 카운트
	public int getTodayReviewCount() throws SQLException {
		return (Integer) SqlMapClientUtil.getSqlMapClient().queryForObject("getTodayReviewCount");
	}

	// 모든 상품 조회
	@SuppressWarnings("unchecked")
	public List<Item> getAllItems() throws SQLException {
		return (List<Item>) SqlMapClientUtil.getSqlMapClient().queryForList("getAllItems");
	}

	@SuppressWarnings("unchecked")
	public List<Item> getItemByCriteria(Criteria criteria) throws SQLException {
		return (List<Item>) SqlMapClientUtil.getSqlMapClient().queryForList("getItemByCriteria", criteria);
	}

	// 번호로 상품 조회
	public Item getItemByNo(int itemNo) throws SQLException {
		return (Item) SqlMapClientUtil.getSqlMapClient().queryForObject("getItemByN", itemNo);
	}

	// 상위 카테고리 조회
	@SuppressWarnings("unchecked")
	public List<Category> getTopCategorys() throws SQLException {
		return (List<Category>) SqlMapClientUtil.getSqlMapClient().queryForList("getTopCategorys");
	}

	// 번호로 카테고리 조회
	public Category getCategoryByNo(int cateNo) throws SQLException {
		return (Category) SqlMapClientUtil.getSqlMapClient().queryForObject("getCateByN", cateNo);
	}

	// 하위 카테고리 조회
	@SuppressWarnings("unchecked")
	public List<Category> getChildCategorys(int categoryNo) throws SQLException {
		return (List<Category>) SqlMapClientUtil.getSqlMapClient().queryForList("getChildCategotys", categoryNo);
	}

	@SuppressWarnings("unchecked")
	public List<Option> getAllOptions() throws SQLException {
		return (List<Option>) SqlMapClientUtil.getSqlMapClient().queryForList("getAllOptions");
	}

	// 아이템번호로 옵션 조회
	@SuppressWarnings("unchecked")
	public List<Option> getOptionByItemNo(int itemNo) throws SQLException {
		return (List<Option>) SqlMapClientUtil.getSqlMapClient().queryForList("getOptionByItemN", itemNo);
	}

	// 옵션번호로 옵션 조회
	public Option getOptionByOptNo(int itemNo) throws SQLException {
		return (Option) SqlMapClientUtil.getSqlMapClient().queryForObject("getOptionByOptN", itemNo);
	}

	// 옵션번호로 옵션 조회
	public List<String> getDistincetColorByItemNo(int itemNo) throws SQLException {
		return SqlMapClientUtil.getSqlMapClient().queryForList("getDistincetColorByItemNo", itemNo);
	}

	// 옵션번호로 옵션 조회
	public List<String> getDistincetSizeByItemNo(int itemNo) throws SQLException {
		return SqlMapClientUtil.getSqlMapClient().queryForList("getDistincetSizeByItemNo", itemNo);
	}

	// 아이템 시퀀스 조회
	public int getItemSEQ() throws SQLException {
		return (Integer) SqlMapClientUtil.getSqlMapClient().queryForObject("getItemSEQ");
	}

	// 아이템 생성
	public void addItem(Item item) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().insert("addItem", item);
	}

	// 옵션 생성
	public void addOption(Option option) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().insert("addOption", option);
	}

	// 하위카테고리 생성
	public void addparentsCategory(Category category) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().insert("addParentsCategory", category);
	}

	// 하위카테고리 생성
	public void addChildCategory(Category category) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().insert("addChildCategory", category);
	}

	// 하위 카테고리 삭제
	public void deleteChildCategory(int cateNo) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().delete("deleteChildCategory", cateNo);
	}

	// 아이템 삭제
	public void deleteItem(int itemNo) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().delete("deleteItem", itemNo);
	}

	// 아이템 번호로 옵션 삭제
	public void deleteOptionByItemNo(int itemNo) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().delete("deleteOptionByItemNo", itemNo);
	}

	// 옵션 업데이트
	public void deleteOptionByOptNo(int optNo) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().update("deleteOptionByOptNo", optNo);
	}

	// 아이템 업데이트
	public void updateItem(Item item) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().update("updateItem", item);
	}

}
