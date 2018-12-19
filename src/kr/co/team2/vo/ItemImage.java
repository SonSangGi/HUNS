package kr.co.team2.vo;

public class ItemImage {
	private Item item;			//이미지 번호와 외래키
	private String images;			//이미지 파일

	public ItemImage() {}

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	public String getImages() {
		return images;
	}

	public void setImages(String images) {
		this.images = images;
	}
	
	
}
