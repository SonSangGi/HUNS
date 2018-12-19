package kr.co.team2.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.AllReviews;
import kr.co.team2.vo.Category;
import kr.co.team2.vo.Criteria;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.PhotoReviews;
import kr.co.team2.vo.Review;
import kr.co.team2.vo.ReviewInfo;
import kr.co.team2.vo.ReviewPass;
import kr.co.team2.vo.User;
import kr.co.team2.vo.Option;

public class ReviewDao {

	private static ReviewDao self = new ReviewDao();
	private ReviewDao() {}
	public static ReviewDao getInstance() {return self;}
	
	@SuppressWarnings("unchecked")
	public List<Review> getAllPhotoReviews() throws SQLException {
		List<Review> reviews = (List<Review>)SqlMapClientUtil.getSqlMapClient().queryForList("getAllPhotoReviews");
		return reviews;
	}
	
	@SuppressWarnings("unchecked")
	public List<Review> getAllReviewsByItemNo(int itemNo) throws SQLException {
		List<Review> reviews = (List<Review>)SqlMapClientUtil.getSqlMapClient().queryForList("getAllReviewsByItemNo",itemNo);
		return reviews;
	}
	
	@SuppressWarnings("unchecked")
	public List<Review> getAllReviewsByItemNoTop3(int itemNo) throws SQLException {
		List<Review> reviews = (List<Review>)SqlMapClientUtil.getSqlMapClient().queryForList("getAllReviewsByItemNoTop3",itemNo);
		return reviews;
	}
	
	@SuppressWarnings("unchecked")
	public List<AllReviews> getAllAllReviews() throws SQLException {
		List<AllReviews> allReviews = (List<AllReviews>)SqlMapClientUtil.getSqlMapClient().queryForList("getAllAllReviews");
		return allReviews;
	}
	
	public int getAllReviewsCount(Criteria criteria) throws SQLException {
		int count = (Integer)SqlMapClientUtil.getSqlMapClient().queryForObject("getAllReviewsCount",criteria);
		return count;
	}
	
	public List<AllReviews> getAllReviewsByCriteria (Criteria criteria) throws SQLException {
		List<AllReviews> reviews = (List<AllReviews>)SqlMapClientUtil.getSqlMapClient().queryForList("getAllReviewsByCriteria",criteria);
		return reviews;
	}
	
	public AllReviews getAllReviewByReviewNo(int reviewNo) throws SQLException {
		AllReviews allReviews = (AllReviews)SqlMapClientUtil.getSqlMapClient().queryForObject("getAllReviewsByReviewNo",reviewNo);
		return allReviews;
	}
	
	public List<PhotoReviews> getAllofPhotoReviews() throws SQLException {
		List<PhotoReviews> photoReviews = (List<PhotoReviews>)SqlMapClientUtil.getSqlMapClient().queryForList("getAllofPhotoReviews");
		return photoReviews;
	}
	
	public Item getItemByReviewNo(int reviewNo) throws SQLException {
		Item item = (Item)SqlMapClientUtil.getSqlMapClient().queryForObject("getItemByReviewNo",reviewNo);
		return item;
	}
	
	public int getPhotoReviewsCount (Criteria criteria) throws SQLException {
		int count = (Integer)SqlMapClientUtil.getSqlMapClient().queryForObject("getPhotoReviewsCount", criteria);
		return count;		
	}
	
	public List<PhotoReviews> getPhotoReviewsByCriteria (Criteria criteria) throws SQLException {
		List<PhotoReviews> reviews = SqlMapClientUtil.getSqlMapClient().queryForList("getPhotoReviewsByCriteria", criteria);
		return reviews;
	}
	
	public ReviewInfo getReviewInfoByReviewNo (int reviewNo) throws SQLException {
		ReviewInfo reviewInfo = (ReviewInfo)SqlMapClientUtil.getSqlMapClient().queryForObject("getReviewInfoByReviewNo",reviewNo);
		return reviewInfo;
	}
	
	public Review getReviewByReviewNo  (int reviewNo) throws SQLException {
		Review review = (Review)SqlMapClientUtil.getSqlMapClient().queryForObject("getReviewByReviewNo",reviewNo);
		return review;
	}
	
	public void updateReviewLikesByReview (Review review) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().update("updateReviewLikesByReview", review);
	}
	
	public Option getOptionByOptionNo (int optionNo) throws SQLException {
		Option option = (Option)SqlMapClientUtil.getSqlMapClient().queryForObject("getOptionByOptionNo",optionNo);
		return option;
	}
	
	public User getUserByUserNo (int userNo) throws SQLException {
		User user = (User)SqlMapClientUtil.getSqlMapClient().queryForObject("getUserByUserNo", userNo);
		return user;
	}
	
	public void addReview(Review review) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().insert("addReview",review);
	}
	
	public void deleteReviewByReviewNo (int reviewNo) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().delete("deleteReviewByReviewNo",reviewNo);
	}
	
	public void deleteReviewInfoByReviewInfoNo (int reviewInfoNo) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().delete("deleteReviewInfoByReviewInfoNo",reviewInfoNo);
	}
	
	
	public void addReviewInfo(ReviewInfo reviewInfo) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().insert("addReviewInfo",reviewInfo);
	}
	
	public int getReviewSeq() throws SQLException {
		int reviewNo = (int)SqlMapClientUtil.getSqlMapClient().queryForObject("getReviewSeq");
		return reviewNo;
	}
	
	public void updateRecentItemReviewNoByphotoReviews (PhotoReviews photoReviews) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().update("updateRecentItemReviewNoByphotoReviews",photoReviews);
	}
	
	@SuppressWarnings("unchecked")
	public List<PhotoReviews> getAllBestReviews () throws SQLException {
		List<PhotoReviews> reviews =(List<PhotoReviews>) SqlMapClientUtil.getSqlMapClient().queryForList("getAllBestReviews");
		return reviews;
	}
	
	@SuppressWarnings("unchecked")
	public List<PhotoReviews> getMainBestReviews () throws SQLException {
		List<PhotoReviews> reviews = (List<PhotoReviews>) SqlMapClientUtil.getSqlMapClient().queryForList("getMainBestReviews");
		return reviews;
	}
	
	
	public List<Category> getCategorys() throws SQLException {
		List<Category> categorys = (List<Category>) SqlMapClientUtil.getSqlMapClient().queryForList("getCategorys");
		return categorys;
	}
	
	public Item getItemByItemNo(int itemNo) throws SQLException {
		Item item = (Item) SqlMapClientUtil.getSqlMapClient().queryForObject("getItemByItemNo",itemNo);
		return item;
	}
	
	public List<Review> getMyReviewsByCriteriaOnReviewDao(Criteria criteria) throws SQLException {
		List<Review> reviews = (List<Review>) SqlMapClientUtil.getSqlMapClient().queryForList("getMyReviewsByCriteriaOnReviewDao",criteria);
		return reviews;
	}
	
	public PhotoReviews getPhotoReviewByReviewNo (int reviewNo) throws SQLException {
		PhotoReviews reviews = (PhotoReviews) SqlMapClientUtil.getSqlMapClient().queryForObject("getPhotoReviewByReviewNo",reviewNo);
		return reviews;
	}
	
	public void updateReviewInfo (ReviewInfo reviewInfo) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().update("updateReviewInfo",reviewInfo);
	}
	
	public void updateReviewByReview (Review review) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().update("updateReviewByReview",review);
	}

	public Item getItembyOptionNo (int optNo) throws SQLException {
		Item item = (Item)SqlMapClientUtil.getSqlMapClient().queryForObject("getItembyOptionNo",optNo);
		return item;
	}
	
	public void updateReviewPassOnOption (ReviewPass reviewPass) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().update("updateReviewPassOnOption",reviewPass);
	}

}
