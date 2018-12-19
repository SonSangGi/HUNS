package kr.co.team2.vo;

import java.text.DecimalFormat;
import java.util.List;

public class AllReviews {

	private int no;
	private String name;
	private int price;
	private String image;
	private List<Review> reviews;
	private ReviewInfo reviewInfo;
	private Item item;
	
	public AllReviews() {}

	public double getScoreMean() {
		if (reviews == null) {
			return 0;
		}
		
		double scoreMean = 0;
		
		for (Review review : reviews) {
			scoreMean += review.getScore();
		}
		
		scoreMean = scoreMean / reviews.size();
		
		scoreMean = Math.round(scoreMean*100)/100;
		
		DecimalFormat dfm = new DecimalFormat("0.#");
		scoreMean = Double.parseDouble(dfm.format(scoreMean));
		
		return scoreMean;
	}
	
	public int getReviewsSize() {
		if (reviews == null) {
			return 0;
		}
		return reviews.size();
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

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	public ReviewInfo getReviewInfo() {
		return reviewInfo;
	}

	public void setReviewInfo(ReviewInfo reviewInfo) {
		this.reviewInfo = reviewInfo;
	}

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}
	
}
