package kr.co.team2.service.admin;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.co.team2.dao.ItemDao;
import kr.co.team2.dao.adminItemDao;
import kr.co.team2.dao.adminOrderDao;
import kr.co.team2.utils.SqlMapClientUtil;
import kr.co.team2.vo.Category;
import kr.co.team2.vo.Criteria;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.ItemQuestion;
import kr.co.team2.vo.Option;

public class adminItemService {

	adminItemDao dao = adminItemDao.getInstance();
	adminOrderDao orderDao = adminOrderDao.getInstance();

	// 미답변 문의
	public List<ItemQuestion> getNotAnswerQuestion() throws SQLException {
		List<ItemQuestion> questions = dao.getNotAnswerQuestion();
		for (ItemQuestion itemQuestion : questions) {
			itemQuestion.setTitle(dao.getQuestionTypeByNo(itemQuestion.getItemQuestionType().getNo()));
		}
		return questions;
	}

	// 답변한 문의
	public List<ItemQuestion> getAnsweredQuestion() throws SQLException {
		List<ItemQuestion> questions = dao.getAnsweredQuestion();
		for (ItemQuestion itemQuestion : questions) {
			itemQuestion.setTitle(dao.getQuestionTypeByNo(itemQuestion.getItemQuestionType().getNo()));
		}
		return questions;
	}

	// 미답변 문의 카운트
	public int getAllItemsCount() throws SQLException {
		return dao.getAllItemsCount();
	}

	// 미답변 문의 카운트
	public int getNotAnswerCount() throws SQLException {
		return dao.getNotAnswerCount();
	}

	// 오늘의 리뷰 카운트
	public int getTodayReviewCount() throws SQLException {
		return dao.getTodayReviewCount();
	}

	// 전체 아이템 조회
	public List<Item> getAllItems() throws SQLException {
		List<Item> items = dao.getAllItems();
		for (Item item : items) {
			List<Option> options = dao.getOptionByItemNo(item.getNo());
			item.setOption(options);
		}
		return items;
	}

	public List<Item> getItemByCriteria(Criteria criteria) throws SQLException {
		List<Item> items = dao.getItemByCriteria(criteria);
		for (Item item : items) {
			List<Option> options = dao.getOptionByItemNo(item.getNo());
			item.setOption(options);
		}
		return items;
	}
	
	// 아이템 컬러,사이즈 문자열 조회
	public List<String> getDistincetColorByItemNo(int itemNo) throws SQLException {
		return dao.getDistincetColorByItemNo(itemNo);
	}
	public List<String> getDistincetSizeByItemNo(int itemNo) throws SQLException {
		return dao.getDistincetColorByItemNo(itemNo);
	}
	// 번호로 아이템 조회
	public Item getItemByNo(int itemNo) throws SQLException {
		Item item = dao.getItemByNo(itemNo);

		Category category = dao.getCategoryByNo(item.getCategory().getNo());
		List<Option> options = dao.getOptionByItemNo(item.getNo());

		item.setCategory(category);
		item.setOption(options);
		System.out.println(category.getContents());

		return item;
	}

	// 상위 카테고리 조회
	public List<Category> getTopCategorys() throws SQLException {
		return dao.getTopCategorys();
	}

	// 하위 카테고리 조회
	public List<Category> getChildCategorys(int categoryNo) throws SQLException {
		return dao.getChildCategorys(categoryNo);
	}

	// 전체 옵션 조회
	public List<Option> getAllOptions() throws SQLException {
		return dao.getAllOptions();
	}

	// 아이템 시퀀스 가져오기
	public int getItemSEQ() throws SQLException {
		return dao.getItemSEQ();
	}

	// 아이템 생성
	public void addItem(Item item) throws SQLException {
		dao.addItem(item);
	}

	// 옵션 생성
	public void addOption(Option option) throws SQLException {
		dao.addOption(option);
	}

	// 카테고리 생성
	public void addCategory(Category category) throws SQLException {
		if (category.getSubNo() != 0) {
			dao.addChildCategory(category);
		} else {
			dao.addparentsCategory(category);
		}
	}

	// 하위 카테고리 삭제
	public void deleteChildCategory(int cateNo) throws SQLException {
		dao.deleteChildCategory(cateNo);
	}

	// 아이템,옵션,장바구니 삭제
	public void deleteItem(int itemNo) throws SQLException {
		List<Option> options = new ArrayList<>();
		if (itemNo != 0) {
			options = dao.getOptionByItemNo(itemNo);
		}
		if (!options.isEmpty()) {
			for (Option option : options) {
				orderDao.deleteCart(option.getNo());
			}
			dao.deleteOptionByItemNo(itemNo);
		}
		dao.deleteItem(itemNo);
	}

	// 옵션 장바구니 삭제
	public void deleteOptionByOptNo(int optNo) throws SQLException {
		dao.deleteOptionByOptNo(optNo);
		orderDao.deleteCart(optNo);
	}

	// 아이템 업데이트
	public void updateItem(Item item) throws SQLException {
		dao.updateItem(item);
	}
	
	public String getIp(HttpServletRequest request) {

		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Real-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-RealIP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
}
