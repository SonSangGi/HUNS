package kr.co.team2.vo;

public class Option {
	private int no;					//시퀀스 option_no_seq
	private String color;			//색
	private String size;			//사이즈
	private int stock;				//수량
	private int currentPrice;		//현재 가격
	private String sellAvailable;	//판매여부		기본값 : 'Y'
	private Item item;
	private String reviewPass;
	
	public Option () {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getCurrentPrice() {
		return currentPrice;
	}

	public void setCurrentPrice(int currentPrice) {
		this.currentPrice = currentPrice;
	}

	public String getSellAvailable() {
		return sellAvailable;
	}

	public void setSellAvailable(String sellAvailable) {
		this.sellAvailable = sellAvailable;
	}

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	public String getReviewPass() {
		return reviewPass;
	}

	public void setReviewPass(String reviewPass) {
		this.reviewPass = reviewPass;
	}

	
	
}
