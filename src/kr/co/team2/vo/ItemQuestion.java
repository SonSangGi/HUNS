package kr.co.team2.vo;

import java.util.Date;

public class ItemQuestion {
	
	//item_questions_seq 시퀀스	
	private int no;
	private String title;
	private String contents;
	private String filename;		//첨부파일 null값 가능
	private String secret;			//공개글('P')비밀글('S')여부,, 기본값 : 비밀글 'S' 
	private User user;
	private String available;		//판매여부		기본값: 'Y'
	private Date createDate;		
	private ItemQuestionType itemQuestionType;
	private int commentCount;
	private Item item;
	
	public ItemQuestion() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getAvailable() {
		return available;
	}

	public void setAvailable(String available) {
		this.available = available;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public ItemQuestionType getItemQuestionType() {
		return itemQuestionType;
	}

	public void setItemQuestionType(ItemQuestionType itemQuestionType) {
		this.itemQuestionType = itemQuestionType;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}
	
	
	
	
}
