package kr.co.team2.vo;

public class Category {
	
	private int no; 
	private String contents;			//상위 카테고리의 내용
	private int subNo;					//하위 카테고리 번호
	
	public Category() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getSubNo() {
		return subNo;
	}

	public void setSubNo(int subNo) {
		this.subNo = subNo;
	}
}
