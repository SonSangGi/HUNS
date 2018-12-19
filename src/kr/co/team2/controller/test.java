package kr.co.team2.controller;

import java.sql.SQLException;

public class test {

	public static void main(String[] args) throws SQLException {
		System.out.println(Direct("안녕"));
	}

	public static String Direct(String name) {
		char b = name.charAt(0);
		String chosung = null;
		int first = (b - 44032) / (21 * 28);
		switch (first) {
		case 0:
		case 1:
			chosung = "ㄱ";
			break;
		case 2:
			chosung = "ㄴ";
			break;
		case 3:
		case 4:
			chosung = "ㄷ";
			break;
		case 5:
			chosung = "ㄹ";
			break;
		case 6:
			chosung = "ㅁ";
			break;
		case 7:
		case 8:
			chosung = "ㅂ";
			break;
		case 9:
		case 10:
			chosung = "ㅅ";
			break;
		case 11:
			chosung = "ㅇ";
			break;
		case 12:
		case 13:
			chosung = "ㅈ";
			break;
		case 14:
			chosung = "ㅊ";
			break;
		case 15:
			chosung = "ㅋ";
			break;
		case 16:
			chosung = "ㅌ";
			break;
		case 17:
			chosung = "ㅍ";
			break;
		case 18:
			chosung = "ㅎ";
			break;
		}
		return chosung;
	}

}
