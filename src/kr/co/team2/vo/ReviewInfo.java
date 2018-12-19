package kr.co.team2.vo;

public class ReviewInfo {
	
	private int reviewNo;
	private int no;
	private String sex;
	private int age;
	private int height;
	private int weight;
	private int sizes;
	
	private String textSize;
	
	public ReviewInfo() {}
	
	public String getCalSize() {
		if (getSizes() == 90) {
			return "XS";
		} else if (getSizes() == 95) {
			return "S";
		} else if (getSizes() == 100) {
			return "M";
		} else if (getSizes() == 105) {
			return "L";
		}
		return "XL";
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getWeight() {
		return weight;
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

	public int getSizes() {
		return sizes;
	}

	public void setSizes(int sizes) {
		this.sizes = sizes;
		this.textSize =  getCalSize();
	}

	public String getTextSize() {
		return textSize;
	}

	public void setTextSize(String textSize) {
		this.textSize = textSize;
	}
	
	
	
	
}
