package kr.co.team2.vo;

import java.util.Date;

public class ItemQuestionComment {
	/*
	 * ITEM_QUESTION_COMMENTs_seq 시컨
	*/
	
	private int no;
	private String available;
	private ItemQuestion itemQuestion;
	private String contents;
	private Date createDate;
	private String name;
	
	public ItemQuestionComment() {}

	public ItemQuestion getItemQuestion() {
		return itemQuestion;
	}

	public void setItemQuestion(ItemQuestion itemQuestion) {
		this.itemQuestion = itemQuestion;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getAvailable() {
		return available;
	}

	public void setAvailable(String available) {
		this.available = available;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}
