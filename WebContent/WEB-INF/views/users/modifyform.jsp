<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
  <title></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style type="text/css">
  .container {
	padding-top: 198px;
	box-sizing: border-box;
	
	}
  </style>
</head>
<body>
<%@ include file="../include/header.jsp"%>
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<form method="post" action="modify.do" id="modify-form">
				<div class="panel panel-info">
					<div class="panel-heading">회원정보수정</div>
					<div class="pannel-body">
						<h3>필수정보</h3>
						<table class="table">
							<colgroup>
								<col width="20%">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th>아이디</th>
									<td><input id="id" name="id" type="text" readonly="readonly" value="${user.id}">
										<em>(영문소문자/숫자, 4~16자)</em>
									</td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td>
										<input id="password" autocomplete="off" name="password" maxlength="16" value="" type="password" />
										<em>(영문 대소문자/숫자, 10자~16자)</em> 
									</td>
								</tr>
								<tr>
									<th>비밀번호 확인</th>
									<td>
										<input id="password2" name="password2" maxlength="16" value="" type="password" />
										<em>(비밀번호를 동일하게 정확히 입력해주십시오.)</em>
									</td>
								</tr>
								 	<tr>
									<th>비밀번호 확인 질문</th>
									<td>
								
										<select id="question" name="que">
											<c:forEach var="Question" items="${Questions }">
												<option value="${Question.no}" ${Question.no eq userQuestion.no ? 'selected': '' }>${Question.textQustion }</option>
											</c:forEach>
										</select>
										 
									</td>
								</tr>
								<tr>
									<th>비밀번호 확인 답변</th>
									<td>
										<input id="answer" name="answer" value="${user.answer }" style="width:350px;" /> <!--컨트롤러에서 추가 안 해서 안 나왔었음.-->
									</td>
								</tr>
								<tr>
									<th>이름</th>
									<td>
										<input type="text" name="name" id="name" value="${user.name }" readonly="readonly"/>
									</td>
								</tr>
							<!-- 	<tr>
									<th>성별</th>
									<td>
										<input type="radio" name="gender" value="M" checked="checked">
                                         <label for="male">남자</label>
										<input type="radio" name="gender" value="F" >
										<label for="femail">여자</label>
									</td>
								</tr> -->
								<tr>
									<th>생년월일 입력</th>
									<td>
										<input type="text" id="birthDay" name="birthDay" value="${user.birthDay }" readonly="readonly">
										<em>예) -을 제외하고 "19881205"의 형식으로 입력해주세요.</em>
									</td>
								</tr>
								<tr>
									<th>주소</th>
									<td>
										<input type="text" id="postcode" name="postcode" value="${user.postcode }" placeholder="우편번호">
										<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
										<input type="text" id="addr1" name="addr1" value="${user.address1 }" placeholder="주소" style="width:350px">
										<br>
										<input type="text" id="addr2" name="addr2" value="${user.address2 }" placeholder="상세주소" style="width:350px">
									</td>
								</tr>
								<tr>
									<th>일반전화</th>
									<td>
										<select id="phone1" name="phone1">
																		<!--조건이 참이라면-->
											<option value="02" ${user.tel1 eq '02' ? 'selected':'' }>02</option>
											<option value="031" ${user.tel1 eq '031' ? 'selected' :'' }>031</option>
											<option value="032" ${user.tel1 eq '032' ? 'selected' :'' }>032</option>
											<option value="033" ${user.tel1 eq '033' ? 'selected':'' }>033</option>
											<option value="041" ${user.tel1 eq '041' ? 'selected' :'' }>041</option>
											<option value="042" ${user.tel1 eq '042' ? 'selected' :'' }>042</option>
											<option value="043" ${user.tel1 eq '043' ? 'selected' :'' }>043</option>
											<option value="044" ${user.tel1 eq '044' ? 'selected' :'' }>044</option>
											<option value="051" ${user.tel1 eq '051' ? 'selected' :'' }>051</option>
											<option value="052" ${user.tel1 eq '052' ? 'selected' :'' }>052</option>
											<option value="053" ${user.tel1 eq '053' ? 'selected' :'' }>053</option>
											<option value="054" ${user.tel1 eq '054' ? 'selected' :'' }>054</option>
											<option value="055" ${user.tel1 eq '055' ? 'selected' :'' }>055</option>
											<option value="061" ${user.tel1 eq '061' ? 'selected' :'' }>061</option>
											<option value="062" ${user.tel1 eq '062' ? 'selected' :'' }>062</option>
											<option value="063" ${user.tel1 eq '063' ? 'selected' :'' }>063</option>
											<option value="064" ${user.tel1 eq '064' ? 'selected' :'' }>064</option>
											<option value="070" ${user.tel1 eq '070' ? 'selected' :'' }>070</option>
										</select>
										-
										<input id="phone2" name="phone2" maxlength="4" value="${user.tel2 }" type="text" style="width:80px;"> <!--전화번호 뽑아먹는 식 추가해주기-->
										-
										<input id="phone3" name="phone3" maxlength="4" value="${user.tel3 }" type="text" style="width:80px;">
									</td>
								</tr>
								<tr>
									<th>휴대전화</th>
									<td>
										<select id="mobile1" name="mobile1">
											<option value="010" ${user.phoneTel1 eq '010' ? 'selected' :'' }>010</option>
											<option value="011" ${user.phoneTel1 eq '011' ? 'selected' :'' }>011</option>
											<option value="016" ${user.phoneTel1 eq '016' ? 'selected' :'' }>016</option>
											<option value="017" ${user.phoneTel1 eq '017' ? 'selected' :'' }>017</option>
											<option value="018" ${user.phoneTel1 eq '018' ? 'selected' :'' }>018</option>
											<option value="019" ${user.phoneTel1 eq '019' ? 'selected' : ''}>019</option>
										</select>
										-
										<input id="mobile2" name="mobile2" maxlength="4" value="${user.phoneTel2 }" type="text" style="width:75px;">
										-
										<input id="mobile3" name="mobile3" maxlength="4" value="${user.phoneTel3 }" type="text" style="width:80px;">
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>
										<input id="email1" name="email1" class="mailId" value="${user.email1 }" type="text">
										@
										<input id="email2" name="email2" class="mailAddress" value="${user.email2 }" type="text">
										<select id="email3" class="mailAddress">
											<option value="" selected="">- 이메일 선택 -</option>
											<option value="naver.com" ${user.email2 eq 'naver.com' ? 'selected' : '' }>naver.com</option>
											<option value="daum.net" ${user.email2 eq 'daum.net' ? 'selected' : '' }>daum.net</option>
											<option value="nate.com" ${user.email2 eq 'nate.com' ? 'selected' : '' }>nate.com</option>
											<option value="hotmail.com" ${user.email2 eq 'hotmail.com' ? 'selected' : '' }>hotmail.com</option>
											<option value="yahoo.com" ${user.email2 eq 'yahoo.com' ? 'selected' : '' }>yahoo.com</option>
											<option value="empas.com" ${user.email2 eq 'empas.com' ? 'selected' : '' }>empas.com</option>
											<option value="korea.com" ${user.email2 eq 'korea.com' ? 'selected' : '' }>korea.com</option>
											<option value="dreamwiz.com" ${user.email2 eq 'dreamwiz.com' ? 'selected' : '' }>dreamwiz.com</option>
											<option value="gmail.com" ${user.email2 eq 'gmail.com' ? 'selected' : '' }>gmail.com</option>
											<option value="etc">직접입력</option>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
						<br>
					</div>
				</div>
				<br>
				<br>
					<div class="text-center">
					<div class="col-md-12">
						<div class=text-right>
							<button type="button" class="btn btn-danger" onclick="leaveConfirm();">회원 탈퇴</button>
							<input type="submit" class="btn btn-romi" value="정보수정완료">
							<input type="button" class="btn btn-default" value="취소" onClick="location.href='/home.do'">
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	/*회원 탈퇴 자바스크립트 */
	function leaveConfirm() {
		var result = confirm("정말로 탈퇴하시겠습니까?");
		if (result) {
			location.href = "/users/deletecmp.do";
		}
	}
	
	var userform = document.getElementById("modify-form");
	userform.onsubmit = function(event) {
		console.log('${LOGIN_USER_INFO}');
		console.log('${user}');
		console.log('${LOGIN_USER_INFO.no}');
		console.log('${user.no}');
		console.log('${user.tel}');
	}
	
	document.getElementById("modify-form").onsubmit = function() {
	if (document.getElementById("password").value == "") {
		alert("비밀번호를 입력하지 않았습니다.");
		document.getElementById("password").focus();
		return false;
	}
	
	 // 비밀번호 조합 
    for (i = 0; i < document.getElementById("password").value.length; i++) {
        ch = document.getElementById("password").value.charAt(i)
        if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
            alert("비밀번호는 영어, 숫자로만 입력가능합니다..")
            document.getElementById("password").focus()
            document.getElementById("password").select()
            return false;
        }
    }
	 
  //비밀번호 길이 체크
	if (document.getElementById("password").value.length<10) {
		alert("비밀번호를 10자 이상으로 입력해주십시오.");
		document.getElementById("password").focus();
		return false;
	}
	if (document.getElementById("password").value.length>16) {
		alert("비밀번호를 16자 이하로 입력해주십시오.");
		document.getElementById("password").focus();
		return false;
	}
	
		//비밀번호와 비밀번호 확인 일치여부 체크
		if(document.getElementById("password").value != document.getElementById("password2").value) {
			alert("비밀번호가 일치하지 않습니다.");
 			document.getElementById("password2").value = "";
			document.getElementById("password2").focus();
			return false;
		}
		return true;
	}
	
	function sample6_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var fullAddr = ''; // 최종 주소 변수
	            var extraAddr = ''; // 조합형 주소 변수

	            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                fullAddr = data.roadAddress;

	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                fullAddr = data.jibunAddress;
	            }

	            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	            if(data.userSelectedType === 'R'){
	                //법정동명이 있을 경우 추가한다.
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있을 경우 추가한다.
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	            }

	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
	            document.getElementById('addr1').value = fullAddr;

	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById('addr2').focus();
	        }
	    }).open();
	}
</script>
</body>
</html>
