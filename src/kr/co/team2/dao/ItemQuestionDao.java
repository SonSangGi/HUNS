package kr.co.team2.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.Criteria;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.ItemQuestion;
import kr.co.team2.vo.ItemQuestionComment;
import kr.co.team2.vo.ItemQuestionType;

public class ItemQuestionDao {
	private static ItemQuestionDao self = new ItemQuestionDao();
	private ItemQuestionDao() {}
	public static ItemQuestionDao getInstance() {
		return self;
	}
	
	
	//게시판 추가
	public void addItemQuestion(ItemQuestion item) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().insert("addItemQuestion",item);
	}
	
	//게시판 리스트 보이게
	public List<ItemQuestion> getBoardListAll() throws SQLException {
		List<ItemQuestion> boards = (List<ItemQuestion>)SqlMapClientUtil.getSqlMapClient().queryForList("getBoardListAll");
		return boards;
	}
	
	//게시판 글 얻기
	public ItemQuestion getBoardByNo(int boardno) throws SQLException {
		ItemQuestion board = (ItemQuestion)SqlMapClientUtil.getSqlMapClient().queryForObject("getBoardByNo", boardno);
		return board;
	}

	public List<ItemQuestionType> getquestionByCategoryType() throws SQLException{
		List<ItemQuestionType> types = (List<ItemQuestionType>)SqlMapClientUtil.getSqlMapClient().queryForList("getquestionByCategoryType");
		return types;
	}
	
	//댓글
	public List<ItemQuestionComment> getItemQuestionComment(Criteria criteria) throws SQLException {
		List<ItemQuestionComment> comments = (List<ItemQuestionComment>)SqlMapClientUtil.getSqlMapClient().queryForList("getItemQuestionComment",criteria);
		return comments;
	}
	public void addItemQuestionComment(ItemQuestionComment comment) throws SQLException {
		// TODO Auto-generated method stub
		SqlMapClientUtil.getSqlMapClient().insert("addItemQuestionComment",comment);
		
	}
	public int getCommentCount(int boardno) throws SQLException {
		// TODO Auto-generated method stub
		int commentCount = (Integer)SqlMapClientUtil.getSqlMapClient().queryForObject("getCommentCount",boardno);
		
		return commentCount;
	}
	public void UpdateItemQuestion(ItemQuestion itemQuestion) throws SQLException {
		// TODO Auto-generated method stub
		SqlMapClientUtil.getSqlMapClient().update("updateItemQuestion",itemQuestion);
	}
	public ItemQuestionType getQuestionByTypeNo(int typeno) throws SQLException  {
		ItemQuestionType itemQuestionType = (ItemQuestionType)SqlMapClientUtil.getSqlMapClient().queryForObject("getQuestionByTypeNo",typeno);
		return itemQuestionType;
	}
	public void UpdateItemQuestionComment(ItemQuestionComment itemQuestionComment) throws SQLException {
		SqlMapClientUtil.getSqlMapClient().update("UpdateItemQuestionComment",itemQuestionComment);
	}
	public List<ItemQuestion> getIemQuestionByCriteria(Criteria criteria) throws SQLException {
		List<ItemQuestion> items = (List<ItemQuestion>)SqlMapClientUtil.getSqlMapClient().queryForList("getIemQuestionByCriteria",criteria);
		return items;
	}
	public int getItemQuestionByCount(Criteria criteria) throws SQLException {
		SqlMapClient sqlMapClient = SqlMapClientUtil.getSqlMapClient();
		int count = (Integer) sqlMapClient.queryForObject("getItemQuestionByCount", criteria);
		return count;
		
	}
	
	public List<Item> getAllItemName() throws SQLException{
		return (List<Item>)SqlMapClientUtil.getSqlMapClient().queryForList("getAllItemName");
	}
	
}
