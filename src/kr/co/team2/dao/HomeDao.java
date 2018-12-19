package kr.co.team2.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.Cart;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.Review;

public class HomeDao {

	private static HomeDao self = new HomeDao();
	private HomeDao () {}
	public static HomeDao getInstance() { return self;}
	
	//신상품 최근 등록 날짜 순
		public List<Item> getItemByCreateDate() throws SQLException {
			List<Item> items = (List<Item>)SqlMapClientUtil.getSqlMapClient().queryForList("getItemByCreateDate");
			return items;
		}
		
		/*// 상의 베스트 상품
		public List<Item>getItemByTop(String name) throws SQLException {
			List<Item> items = SqlMapClientUtil.getSqlMapClient().queryForList("getItemByTop");
			return items;
		}
		//카테고리 내용으로 번호 찾기
		public Category getCategoryByContents(String name) throws SQLException{
			Category category = (Category)SqlMapClientUtil.getSqlMapClient().queryForObject("getCategoryByContents");
			List<Category> categorys = (List<Category>)SqlMapClientUtil.getSqlMapClient().queryForList("getCategoryByNo",category.getNo());
			List<Item> items = null;
			for(Category topCategory : categorys) {
			 items = (List<Item>)SqlMapClientUtil.getSqlMapClient().queryForObject("getItemByTop",topCategory.getNo());
			 
			}
		}*/
		//카테고리 번호로 해당 상품 조회
		
		//리뷰 top5 조회
		public List<Review> getReviewBycount()throws SQLException{
			List<Review> reviews =  (List<Review>)SqlMapClientUtil.getSqlMapClient().queryForList("getReviewBycount");
			return reviews;
		}
		//베스트 상품 리뷰 평점
		public List<Item> getBestItemByScore()throws SQLException{
			List<Item> itemsScore = (List<Item>)SqlMapClientUtil.getSqlMapClient().queryForList("getBestItemByScore");
			return itemsScore;
		}
		//상의 베스트(재고순)
		public List<Item> getTopItemsByCategoryNo(int cateNo) throws SQLException {
			List<Item> bestTopItems = (List<Item>)SqlMapClientUtil.getSqlMapClient().queryForList("getTopItemsByCategoryNo",cateNo);
			return bestTopItems;
		}
		//팬츠 베스트 (재고순)
		public List<Item> getPantItemsByCategoryNo(int cateNo) throws SQLException {
			List<Item> bestPantItems = (List<Item>)SqlMapClientUtil.getSqlMapClient().queryForList("getPantItemsByCategoryNo",cateNo);
			return bestPantItems;
		}
		public int getCartCount(int no) throws SQLException {
		int cartCount = (int)SqlMapClientUtil.getSqlMapClient().queryForObject("getCartCount",no);
			return cartCount;
		}
		
		public int getCategoryByreviewScore() throws SQLException{
			int cate_no = (int)SqlMapClientUtil.getSqlMapClient().queryForObject("getCategoryByreviewScore");
			return cate_no;
		}
		
		public int getTopCategoryBycateNo(int cateNo) throws SQLException{
			int sub_no = (int)SqlMapClientUtil.getSqlMapClient().queryForObject("getTopCategoryBycateNo",cateNo);
			return sub_no;
		}
}
