package kr.co.team2.vo;

import java.util.Date;

public class PhotoReviews {
	
	private int no;
	private String photo;
	private String contents;
	private Date createDate;
	private double score;
	private int likes;
	private int counts;
	private User user;
	private Item item;
	private Option option;
	private ReviewInfo reviewInfo;
	
	public PhotoReviews() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}
	
	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getCounts() {
		return counts;
	}

	public void setCounts(int counts) {
		this.counts = counts;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	public int getCount() {
		return counts;
	}

	public void setCount(int count) {
		this.counts = count;
	}

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public Option getOption() {
		return option;
	}

	public void setOption(Option option) {
		this.option = option;
	}

	public ReviewInfo getReviewInfo() {
		return reviewInfo;
	}

	public void setReviewInfo(ReviewInfo reviewInfo) {
		this.reviewInfo = reviewInfo;
	}
	
	
	
}
