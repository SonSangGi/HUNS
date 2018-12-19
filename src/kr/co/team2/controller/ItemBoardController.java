package kr.co.team2.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;


import org.eclipse.jdt.internal.compiler.apt.model.IElementInfo;

import com.google.common.io.FileBackedOutputStream;
import com.ibatis.sqlmap.engine.type.IntegerTypeHandler;
import com.oreilly.servlet.MultipartRequest;

import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.JSONView;
import kr.co.jhta.mvc.servlet.ModelAndView;
import kr.co.team2.dao.ItemDao;
import kr.co.team2.dao.ItemQuestionDao;
import kr.co.team2.vo.Criteria;
import kr.co.team2.vo.Item;
import kr.co.team2.vo.ItemQuestion;
import kr.co.team2.vo.ItemQuestionComment;
import kr.co.team2.vo.ItemQuestionType;
import kr.co.team2.vo.Pagination;
import kr.co.team2.vo.User;

@Controller
public class ItemBoardController {

	@RequestMapping("/itemBoard/list.do")
	public ModelAndView BoardList(HttpServletRequest request, HttpServletResponse response) throws SQLException{
		
		ModelAndView mav = new ModelAndView();
		int cp = 1;
		int rows = 10;
		
		try {
			cp = Integer.parseInt(request.getParameter("cp"));
		}catch (Exception e) {	
		}
		
		
		String title = request.getParameter("title");
		String opt = request.getParameter("opt");
		String keyword = request.getParameter("keyword");
		Criteria criteria = new Criteria();
		
		criteria.setBeginIndex((cp-1)*rows +1);
		criteria.setEndIndex(cp*rows);
		
		
		if(title == null) {
			title = "1";
		}	
		criteria.setTypeno(title);
		
		if(keyword != null && !keyword.isEmpty()) {
			criteria.setOpt(opt);
			criteria.setKeyword(keyword.toUpperCase());	
		}
		
		ItemQuestionDao itemQuestionDao = ItemQuestionDao.getInstance();
		//총 리스트 수 불러오기
		int totalRows = itemQuestionDao.getItemQuestionByCount(criteria);
		Pagination pagination = new Pagination(cp, rows, totalRows);
		
		//리스트 불러오기
		List<ItemQuestion> boards = itemQuestionDao.getIemQuestionByCriteria(criteria);
		
		//List<ItemQuestion> boards = itemQuestionDao.getBoardListAll();
		//카테고리 TYPE불러오기
		List<ItemQuestionType> types = itemQuestionDao.getquestionByCategoryType();
		
		mav.addAttribute("types", types);
		mav.addAttribute("boards", boards);
		mav.addAttribute("pagination", pagination);
		mav.setViewName("itemboard/boardlist.jsp");
		
		
		return mav;
	}
	
	@RequestMapping("/itemBoard/form.do")
	public ModelAndView form(HttpServletRequest request, HttpServletResponse response) throws SQLException{
		
		ModelAndView mav = new ModelAndView();
		ItemQuestionDao itemQuestionDao = ItemQuestionDao.getInstance();
		String load = request.getParameter("load");
		if("board".equals(load)) {
			List<Item> boardItems = itemQuestionDao.getAllItemName();
			mav.addAttribute("boardItems", boardItems);
		}
		else if("item".equals(load)) {
			int itemNo = Integer.parseInt(request.getParameter("itemQuestionNo"));
			
			ItemDao itemDao = ItemDao.getInstance();
			Item item = itemDao.getItemByItemNo(itemNo);
			mav.addAttribute("item", item);
		}
		HttpSession session = request.getSession();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
		if (loginedUser == null) {
			mav.setViewName("redirect:/users/loginform.do?fail=deny"); // 실행됨.
			return mav;
		}
		
		
		//카테고리 TYPE불러오기
		List<ItemQuestionType> types = itemQuestionDao.getquestionByCategoryType();
		//mav.addAttribute("item", item);	
		mav.addAttribute("load", load);
		mav.addAttribute("types", types);
		mav.addAttribute("loginedUser", loginedUser);
		mav.setViewName("itemboard/form.jsp");
		return mav;
	}
	
	@RequestMapping("/itemBoard/add.do")
	public ModelAndView add(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException{
		
		ModelAndView mav= new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		if (loginedUser == null) {
			mav.setViewName("redirect:/users/loginform.do?fail=deny"); // 실행됨.
			return mav;
		}
		/*
		HttpSession session = request.getSession();
		User loginedUser = (User) session.getAttribute("LOGIN_USER_INFO");
		if(loginedUser == null) {
			mav.setViewName("redirect:/users/loginform.do");
			return mav;
		}
		*/
		ItemDao itemDao = ItemDao.getInstance();
		System.out.println( loginedUser.getName() +","+loginedUser.getNo());
		String saveDirectory = "C:/web_workspace/shopping/WebContent/images/itemQuestions";
		int maxPostSize = 1024*1024*100;
		String encoding = "utf-8";
		
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);
		String title = mr.getParameter("title");
		String content = mr.getParameter("contents");
		String secret = mr.getParameter("secret");
		String filename = mr.getFilesystemName("upfile");
		String name = mr.getParameter("name");
		int itemNo = Integer.parseInt(mr.getParameter("item-title"));
		
		secret = secret.toUpperCase();
		ItemQuestion itemQuestion = new ItemQuestion();
		itemQuestion.setTitle(title);
		itemQuestion.setContents(content);
		itemQuestion.setSecret(secret);
		
		itemQuestion.setFilename(filename);
		itemQuestion.setUser(loginedUser);
		Item item = itemDao.getItemByItemNo(itemNo);
		itemQuestion.setItem(item);
		ItemQuestionDao itemQuestionDao = ItemQuestionDao.getInstance();
		itemQuestionDao.addItemQuestion(itemQuestion);
		//자바에서 이미지를 여러개 담을 수 있는 리스트를 만든다.
		if(filename != null) {
			saveFile(request, saveDirectory,filename );
		}
		/*
		 * Enumeration<E> en = mr.getFileNames();
		while(en.hasMoreElements()){
			String filename = (String) en.nextElement();
			
			Image image = new Imgae();
			image.setFileaname();
			images.add(image);
		}
		 */
		
		mav.setViewName("redirect:list.do");
		
		return mav;
	}
	private void saveFile(HttpServletRequest request, String saveDirectory, String filename) {
		// TODO Auto-generated method stub
		
		FileInputStream  in = null;
		FileOutputStream out = null;
		try {
			File file = new File(saveDirectory + "/" + filename);
			in = new FileInputStream(file);
			out = new FileOutputStream(new File(request.getSession().getServletContext().getRealPath("/")
					+ File.separator + "/images/itemQuestions/" + filename));
			int readBuffer = 0;
			byte[] buffer = new byte[1024];
			while ((readBuffer = in.read(buffer))!= -1) {
				out.write(buffer, 0 ,readBuffer);
			}

		}catch (IOException e) {
				System.out.println(e);
			} finally {
				try {
					in.close();
					out.close();
				} catch (IOException io) {
				}
			}
		}
	


	@RequestMapping("/itemBoard/befordetail.do")
	public ModelAndView befordetail(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException{
		int boardno = Integer.parseInt(request.getParameter("boardno"));
		ModelAndView mav= new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
		boolean fail = false;
		if (loginedUser == null) {
			//mav.setViewName("redirect:/users/loginform.do?fail=deny"); // 실행됨.
			fail = true;
		}
		
		ItemQuestionDao itemQuestionDao = ItemQuestionDao.getInstance();
		ItemQuestion board = itemQuestionDao.getBoardByNo(boardno);
		System.out.println(board);
		String secret = board.getSecret();
		String url=null;
		boolean result = false;
		//비공개글
		if("S".equals(secret.toUpperCase())) {
			//세션과 아이디 비교
			if(board.getUser().getNo() == loginedUser.getNo() || loginedUser.getNo() == 0) {
				url = "itemboard/detail.jsp?boardno="+boardno;
				result = true;
			}else {
				url = "redirect:/itemBoard/list.do?fail=secret";
				result = false;
			}
		}else if("P".equals(secret.toUpperCase())) {
			url = "itemboard/detail.jsp?boardno="+boardno;
			result = true;
		}
		
		
		mav.addAttribute("result", result);
		mav.addAttribute("fail", fail);
		mav.setView(new JSONView());
		return mav;
	}
	
	
	
	//게시판 상세정보
	@RequestMapping("/itemBoard/detail.do")
	public ModelAndView detail(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException{
		int boardno = Integer.parseInt(request.getParameter("boardno"));
		ModelAndView mav= new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
	
		if (loginedUser == null) {
			mav.setViewName("redirect:/users/loginform.do?fail=deny"); // 실행됨.
	
		}
		
		ItemQuestionDao itemQuestionDao = ItemQuestionDao.getInstance();
		ItemQuestion board = itemQuestionDao.getBoardByNo(boardno);
		String secret = board.getSecret();
		String url = null;
		//비공개글
		if("S".equals(secret.toUpperCase())) {
			//세션과 아이디 비교
			if(board.getUser().getNo() == loginedUser.getNo() || loginedUser.getNo() == 0) {
				url = "itemboard/detail.jsp?boardno="+boardno;
			}else {
				url = "redirect:/itemBoard/list.do?fail=secret";
			}
		}else if("P".equals(secret.toUpperCase())) {
			url = "itemboard/detail.jsp?boardno="+boardno;
		}
		//페이징 처리
		int cp = 1;
		int rows = 5;
		
		try {
			cp = Integer.parseInt(request.getParameter("cp"));
		}catch (Exception e) {
			// TODO: handle exception
		}
		Criteria criteria = new Criteria();
		criteria.setBeginIndex((cp-1)*rows + 1);
		criteria.setEndIndex(cp*rows);
		//댓글 총 갯수 새기
		criteria.setNo(boardno);
		//댓글 불러오기
		int commentCount = itemQuestionDao.getCommentCount(boardno);
		int totalRows = commentCount;
		Pagination pagination = new Pagination(cp, rows, totalRows); 		
		List<ItemQuestionComment> comments = itemQuestionDao.getItemQuestionComment(criteria);
		
		mav.addAttribute("commentCount", commentCount);
		mav.addAttribute("comments", comments);
		mav.addAttribute("pagination", pagination);
		mav.addAttribute("board", board);
		mav.setViewName(url);
		return mav;
	}
	
	//게시판 상세글 수정 폼
	@RequestMapping("/itemBoard/modifyform.do")
	public ModelAndView modifyform(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException{
		
		ModelAndView mav= new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
		
		if (loginedUser == null) {
			mav.setViewName("redirect:/users/loginform.do?fail=deny"); // 실행됨.
			return mav;
		}
		int boardno = Integer.parseInt(request.getParameter("boardno"));
		ItemQuestionDao itemQuestionDao = ItemQuestionDao.getInstance();
		List<ItemQuestionType> types = itemQuestionDao.getquestionByCategoryType();
		ItemQuestion board = itemQuestionDao.getBoardByNo(boardno);
		List<Item> boardItems = itemQuestionDao.getAllItemName();
		mav.addAttribute("boardItems", boardItems);
		mav.addAttribute("board", board);
		mav.addAttribute("types", types);
		mav.setViewName("itemboard/modifyform.jsp");
		return mav;
	}
	//게시판 상세글 수정
	/**
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	@RequestMapping("/itemBoard/modify.do")
	public ModelAndView modify(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException{
		
		ModelAndView mav= new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
		
		if (loginedUser == null) {
			mav.setViewName("redirect:/users/loginform.do?fail=deny"); // 실행됨.
			return mav;
		}
		
		String saveDirectory = "C:/web_workspace/shopping/WebContent/images/itemQuestions";
		int maxPostSize = 1024 * 1024 * 100;
		String encoding = "utf-8";
		
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);
		
		
		
		
		int boardno = Integer.parseInt(mr.getParameter("boardno"));
		String title =  mr.getParameter("title");
		int typeno =   Integer.parseInt(mr.getParameter("title"));
		String contents = mr.getParameter("contents");
		String upfile = mr.getFilesystemName("upfile");
		String secret = mr.getParameter("secret");
		int itemTitle = Integer.parseInt(mr.getParameter("item-title"));
		ItemQuestionDao itemQuestionDao = ItemQuestionDao.getInstance();
		ItemQuestion itemQuestion = itemQuestionDao.getBoardByNo(boardno);
		ItemQuestionType itemQuestionType = new ItemQuestionType();
		itemQuestion.setTitle(title);
		itemQuestion.setSecret(secret);
		itemQuestion.setContents(contents);
		
		
		itemQuestionType.setNo(typeno);
		itemQuestion.setItemQuestionType(itemQuestionType);
		Item item = new Item();
		item.setNo(itemTitle);
		itemQuestion.setItem(item);
		
		if(upfile != null) {
			itemQuestion.setFilename(upfile);
			saveFile(request, saveDirectory,upfile );
		}
		
		
		itemQuestionDao.UpdateItemQuestion(itemQuestion);
		
		
		mav.setViewName("redirect:detail.do?boardno="+boardno);
		return mav;
	}
	
	
	//게시판 삭제
	@RequestMapping("/itemBoard/delete.do")
	public ModelAndView delete(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException{
	
		int boardno = Integer.parseInt(request.getParameter("boardno"));
		ModelAndView mav= new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
		
		if (loginedUser == null) {
			mav.setViewName("redirect:/users/loginform.do?fail=deny"); // 실행됨.
			return mav;
		}
		
		ItemQuestionDao itemQuestionDao = ItemQuestionDao.getInstance();
		ItemQuestion itemQuestion = itemQuestionDao.getBoardByNo(boardno);
		ItemQuestionComment itemQuestionComment = new ItemQuestionComment();
		itemQuestion.setAvailable("N");
		itemQuestionComment.setAvailable("N");
		itemQuestionComment.setItemQuestion(itemQuestion);
		
		itemQuestionDao.UpdateItemQuestion(itemQuestion);
		itemQuestionDao.UpdateItemQuestionComment(itemQuestionComment);
		
		mav.setViewName("redirect:list.do");
		return mav;
	}
	
	//댓글 
	@RequestMapping("/itemBoard/comment.do")
	public ModelAndView comment(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException{
		
		ModelAndView mav= new ModelAndView();
		HttpSession session = request.getSession();
		User loginedUser = (User)session.getAttribute("LOGIN_USER_INFO");
		
		if (loginedUser == null) {
			mav.setViewName("redirect:/users/loginform.do?fail=deny"); // 실행됨.
			return mav;
		}

		int boardno = Integer.parseInt(request.getParameter("boardno"));
		String commentText = request.getParameter("commentText");
		String name = loginedUser.getName();
		
		System.out.println(commentText);
		
		ItemQuestion itemQuestion = new ItemQuestion();
		itemQuestion.setNo(boardno);
		
		ItemQuestionComment comment = new ItemQuestionComment();
		comment.setItemQuestion(itemQuestion);
		comment.setContents(commentText);
		comment.setName(name);
	
		ItemQuestionDao itemQuestionDao = ItemQuestionDao.getInstance();
		
		//댓글 추가
		itemQuestionDao.addItemQuestionComment(comment);
		
		mav.setViewName("redirect:detail.do?boardno="+boardno);
		
		return mav;
	}
	

}