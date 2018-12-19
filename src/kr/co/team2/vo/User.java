package kr.co.team2.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class User {

	// 고유키 no 시퀀스 만듦.
	private int no;
	private String id;
	private String password;
	private String name;
	private String gender;
	private String birthDay;
	private UserQuestion userQuestion;		//질문
	private String answer;					//질문답
	private String postcode;
	private String address1;
	private String address2;
	private String tel;
	private String phoneTel;				//핸드폰
	private String email;
	private String available;				//회원일 경우 Y , 회원탈퇴시 N 기본값 : 'Y'
	private Date createDate;
	private String tel1;		// 전화번호 두번째, 세번째란을 vo에서 추가해줘서 써먹기. DB랑은 전혀 상관이 없다.
	private String tel2;
	private String tel3;
	private String phoneTel1;
	private String phoneTel2;
	private String phoneTel3;
	private String email1;
	private String email2;
	private String questionText;
	
	
	public User() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String getBirthDay() {
		return birthDay;
	}

	public void setBirthDay(String birthDay) {
		this.birthDay = birthDay;
	}

	public UserQuestion getUserQuestion() {
		return userQuestion;
	}

	public void setUserQuestion(UserQuestion userQuestion) {
		this.userQuestion = userQuestion;
	}

	public String getAvailable() {
		return available;
	}

	public void setAvailable(String available) {
		this.available = available;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}
	
	public String getTel3() {
		return tel3;
	}

	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}

	public String getPhoneTel3() {
		return phoneTel3;
	}

	public void setPhoneTel3(String phoneTel3) {
		this.phoneTel3 = phoneTel3;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getPhoneTel() {
		return phoneTel;
	}

	public void setPhoneTel(String phoneTel) {
		this.phoneTel = phoneTel;
	}


	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	public int getAge() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		int now = Integer.parseInt(sdf.format(new Date()));
		int birth = Integer.parseInt(this.birthDay.substring(0, 4));
		return now-birth+1;
	}


	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public String getPhoneTel1() {
		return phoneTel1;
	}

	public void setPhoneTel1(String phoneTel1) {
		this.phoneTel1 = phoneTel1;
	}

	public String getPhoneTel2() {
		return phoneTel2;
	}

	public void setPhoneTel2(String phoneTel2) {
		this.phoneTel2 = phoneTel2;
	}

	public String getEmail1() {
		return email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}

	public String getQuestionText() {
		return questionText;
	}

	public void setQuestionText(String questionText) {
		this.questionText = questionText;
	}
	
	
}
