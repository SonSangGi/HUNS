package kr.co.team2.vo;

public class OrderDetail {

	private int no;
	private Orders order;
	private int qty;
	private Option option;
	private Item item;
	private String reviewPassed;
	
	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public Orders getOrder() {
		return order;
	}

	public void setOrder(Orders order) {
		this.order = order;
	}

	public Option getOption() {
		return option;
	}

	public void setOption(Option option) {
		this.option = option;
	}

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	public String getReviewPassed() {
		return reviewPassed;
	}

	public void setReviewPassed(String reviewPassed) {
		this.reviewPassed = reviewPassed;
	}
	
	
	

}
