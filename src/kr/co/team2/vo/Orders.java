package kr.co.team2.vo;

import java.util.Date;

public class Orders {
	
	private int no;
	private String state;			//주문 상태
	private Date createDate;
	private User user;
	private Option option;
	private int count;
	
	public Orders() {}
	
	
	
	public Option getOption() {
		return option;
	}



	public void setOption(Option option) {
		this.option = option;
	}



	public int getCount() {
		return count;
	}



	public void setCount(int count) {
		this.count = count;
	}



	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	
}
