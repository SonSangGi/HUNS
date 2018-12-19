package kr.co.team2.vo;

import java.util.Date;
import java.util.List;

import kr.co.team2.service.admin.adminItemService;


public class Item {
	
	private int no;							//시퀀스 item_no_seq
	private String name;
	private String contents;
	private int price;
	private String displayAvailable;		//진열 여부 	기본값 : 'Y'
	private String sellAvailable; 			//판매 여부	기본값 : 'Y'
	private int currentDiscount;			//판매 할인가
	private Date createDate;		
	private Category category;
	private List<Option> option;			// 한 제품이 현재 존재하는 
	private String image;
	private int colorCount; 
	private int sizeCount;
	private Option detailOption;			//opt에 있는 가격을 담는 변수
	private Review review;
	private int optCurrentPrice;
	private int bestCount;
	private int recentReview;
	
	public Item() {}

	

	public Item(int no, String name, String contents, int price, String displayAvailable, String sellAvailable,
			int currentDiscount, Category category, String image) {
		super();
		this.no = no;
		this.name = name;
		this.contents = contents;
		this.price = price;
		this.displayAvailable = displayAvailable;
		this.sellAvailable = sellAvailable;
		this.currentDiscount = currentDiscount;
		this.category = category;
		this.image = image;
	}



	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getContents() {
		return contents;
	}


	public void setContents(String contents) {
		this.contents = contents;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public String getDisplayAvailable() {
		return displayAvailable;
	}


	public void setDisplayAvailable(String displayAvailable) {
		this.displayAvailable = displayAvailable;
	}


	public String getSellAvailable() {
		return sellAvailable;
	}


	public void setSellAvailable(String sellAvailable) {
		this.sellAvailable = sellAvailable;
	}


	public int getCurrentDiscount() {
		return currentDiscount;
	}


	public void setCurrentDiscount(int currentDiscount) {
		this.currentDiscount = currentDiscount;
	}


	public Date getCreateDate() {
		return createDate;
	}


	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}


	public Category getCategory() {
		return category;
	}


	public void setCategory(Category category) {
		this.category = category;
	}


	public List<Option> getOption() {
		return option;
	}


	public void setOption(List<Option> option) {
		this.option = option;
	}


	public String getImage() {
		return image;
	}


	public void setImage(String image) {
		this.image = image;
	}


	public int getColorCount() {
		return colorCount;
	}


	public void setColorCount(int colorCount) {
		this.colorCount = colorCount;
	}


	public int getSizeCount() {
		return sizeCount;
	}


	public void setSizeCount(int sizeCount) {
		this.sizeCount = sizeCount;
	}



	public Option getDetailOption() {
		return detailOption;
	}



	public void setDetailOption(Option detailOption) {
		this.detailOption = detailOption;
	}



	public Review getReview() {
		return review;
	}



	public void setReview(Review review) {
		this.review = review;
	}



	public int getOptCurrentPrice() {
		return optCurrentPrice;
	}



	public void setOptCurrentPrice(int optCurrentPrice) {
		this.optCurrentPrice = optCurrentPrice;
	}


	public int getBestCount() {
		return bestCount;
	}


	public void setBestCount(int bestCount) {
		this.bestCount = bestCount;
	}



	public int getRecentReview() {
		return recentReview;
	}



	public void setRecentReview(int recentReview) {
		this.recentReview = recentReview;
	}
	
	
	
}
