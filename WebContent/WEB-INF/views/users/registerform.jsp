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
			<c:choose>
				<c:when test="${param.fail eq 'login'}">
					<div class="alert alert-danger">
						<strong>로그인 실패</strong> 아이디가 없습니다. 회원가입을 해주세요.
					</div>
				</c:when>
			</c:choose>
			<form method="post" id="register-form" action="register.do">
				<div class="panel panel-info">
					<div class="panel-heading">회원가입</div>
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
									<td><input id="id" name="id" type="text">
										<input type="button" value="중복 체크" onclick="chkMbId();">
										<em >(영문소문자/숫자, 4~16자)</em>
										<span  style="display:block" id="messge"></span>
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
										<select id="question" name="question">
											<c:forEach var="userQuestion" items="${userQuestions }">
												<option value="${userQuestion.no}">${userQuestion.textQustion }</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th>비밀번호 확인 답변</th>
									<td>
										<input id="answer" name="answer" value="" style="width:350px;" />
									</td>
								</tr>
								<tr>
									<th>이름</th>
									<td>
										<input type="text" name="name" id="name"/>
									</td>
								</tr>
								<tr>
									<th>성별</th>
									<td>
										<input type="radio" name="gender" value="M" checked="checked">
                                         <label for="male">남자</label>
										<input type="radio" name="gender" value="F" >
										<label for="femail">여자</label>
									</td>
								</tr>
								<tr>
									<th>생년월일 입력</th>
									<td>
										<input type="text" id="birthDay" name="birthDay" value="">
										<em>예) -을 제외하고 "19881205"의 형식으로 입력해주세요.</em>
									</td>
								</tr>
								<!-- <tr>
									<th>주소</th>
									<td>
										<input id="addr1" name="addr1" value="" type="text" style="width:350px">
										<em>기본주소</em>
										<br>
										<input id="addr2" name="addr2"  value="" type="text" style="width:350px">
										<em>나머지 주소</em>
									</td>
								</tr> -->
								<tr>
									<th>주소</th>
									<td>
										<input type="text" id="postcode" name="postcode" value="" placeholder="우편번호">
										<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
										<input type="text" id="addr1" name="addr1" value="" placeholder="주소" style="width:350px">
										<br>
										<input type="text" id="addr2" name="addr2" value="" placeholder="상세주소" style="width:350px">
									</td>
								</tr>
								<tr>
									<th>일반전화</th>
									<td>
										<select id="phone1" name="phone1">
											<option value="" selected="selected">선택</option>
											<option value="02">02</option>
											<option value="031">031</option>
											<option value="032">032</option>
											<option value="033">033</option>
											<option value="041">041</option>
											<option value="042">042</option>
											<option value="043">043</option>
											<option value="044">044</option>
											<option value="051">051</option>
											<option value="052">052</option>
											<option value="053">053</option>
											<option value="054">054</option>
											<option value="055">055</option>
											<option value="061">061</option>
											<option value="062">062</option>
											<option value="063">063</option>
											<option value="064">064</option>
											<option value="070">070</option>
										</select>
										-
										<input id="phone2" name="phone2" maxlength="4" value="" type="text" style="width:80px;">
										-
										<input id="phone3" name="phone3" maxlength="4" value="" type="text" style="width:80px;">
									</td>
								</tr>
								<tr>
									<th>휴대전화</th>
									<td>
										<select id="mobile1" name="mobile1">
											<option value="" selected="selected">선택</option>
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
										</select>
										-
										<input id="mobile2" name="mobile2" maxlength="4" value="" type="text" style="width:75px;">
										-
										<input id="mobile3" name="mobile3" maxlength="4" value="" type="text" style="width:80px;">
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>
										<input id="email1" name="email1" class="mailId" value="" type="text">
										@
										<input id="email2" name="email2" class="mailAddress" value="" type="text">
										<select id="email3" class="mailAddress">
											<option value="" selected="selected">- 이메일 선택 -</option>
											<option value="naver.com">naver.com</option>
											<option value="daum.net">daum.net</option>
											<option value="nate.com">nate.com</option>
											<option value="hotmail.com">hotmail.com</option>
											<option value="yahoo.com">yahoo.com</option>
											<option value="empas.com">empas.com</option>
											<option value="korea.com">korea.com</option>
											<option value="dreamwiz.com">dreamwiz.com</option>
											<option value="gmail.com">gmail.com</option>
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
					<input type="submit" id="btnSend" class="btn btn-romi" value="회원가입">
					<input type="button" id="btnReset" class="btn btn-default" value="취소" onClick="location.href='/home.do'">
				</div>
			</form>
		</div>
	</div>
</div>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">


function chkMbId(){
var checknum = 0;
	var inputId = $('#id').val();
	$.ajax({
		data : {"id": inputId },
		type : 'post',
		url: "idCheck.do",
		success : function(result){
		
			if(result.result == true){
				$("#btnSend").prop("disabled",true);
				$("#messge").css("color","#de1010");
				$("#messge").text('아이디 중복');
				alert("아이디중복");
				
			} else if (result.result == false) {
				$("#btnSend").prop("disabled",false);
				$("#messge").css("color","#3316ca");
				$("#messge").text('아이디  사용가능');
				alert("사용가능");
			} else if(inputId == "" ){
				$("#messge").text('아이디를 입력하시오');
			}
		},
		
		error: function(xhr, status, error) {
            alert(error);
        } 


	});
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


	var emails = document.querySelectorAll("#email3");
	var emailValue;
	
	emails.forEach(function(email,index1){
		email.onchange = function(event){
			emailValue = email.value;
			document.getElementById("email2").value = emailValue;
			
		}
	})

	document.getElementById("register-form").onsubmit = function() {
		
		// 아이디 입력여부 검사
		if(document.getElementById("id").value == "") {
			alert("아이디를 입력하지 않았습니다.");
			document.getElementById("id").focus();
			return false;
		}
		
		//아이디 영어 대, 소문자, 숫자로 한정 짓기
		 for (i = 0; i < document.getElementById("id").value.length; i++) {
            ch = document.getElementById("id").value.charAt(i)
            if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
                alert("아이디는 대소문자, 숫자만 입력가능합니다.")
                document.getElementById("id").focus()
                document.getElementById("id").select()
                return false;
            }
        }
		
		// 아이디 길이 체크
		if(document.getElementById("id").value.length<4) {
			alert("아이디를 4자 이상으로 입력해주세요.");
			document.getElementById("id").focus();
			return false;
		}
		if(document.getElementById("id").value.length>16) {
			alert("아이디를 16자 이하로 입력해주세요.");
			document.getElementById("id").focus();
			return false;
		}
	
		//비밀번호 입력여부 체크
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
		
		
		//비밀번호 확인 공백체크
		if(document.getElementById("answer").value == "") {
			alert("비밀번호 확인 답변을 입력하지 않았습니다.")
			document.getElementById("answer").focus()
			return false;
		}
		
		//이름 공백 체크
		if(document.getElementById("name").value == "") {
			alert("이름을 입력하지 않았습니다.")
			document.getElementById("name").focus()
			return false;
		}
		if(document.getElementById("name").value.length<2) {
			alert("이름을 2글자 이상 입력해주세요.")
			document.getElementById("name").focus()
			return false;
		}
		
		//생년월일 체크 기능 미구현 / 공백체크 기능만 구현
		//숫자가 아닌것을 입력한 경우
		
		if(document.getElementById("birthDay").value == "") {
			alert("생년월일을 입력하지 않았습니다.")
			document.getElementById("birthDay").focus()
			return false;
		}
		
	  for (i = 0; i < document.getElementById("birthDay").value.length; i++) {
            ch = document.getElementById("birthDay").value.charAt(i)
            if (!(ch >= '0' && ch <= '9')) {
                alert("생년월일은 숫자로만 입력가능합니다..")
                document.getElementById("birthDay").focus()
                document.getElementById("birthDay").select()
                return false;
            }
	  }
	  
		
		//주소 공백 체크
		if(document.getElementById("postcode").value == "") {
			alert("우편번호를 입력하지 않았습니다.")
			document.getElementById("postcode").focus()
			return false;
		}
		//주소 공백 체크
		if(document.getElementById("addr1").value == "") {
			alert("주소를 입력하지 않았습니다.")
			document.getElementById("addr1").focus()
			return false;
		}

		//상세주소 공백 체크
		if(document.getElementById("addr2").value == "") {
			alert("나머지 주소를 입력하지 않았습니다.")
			document.getElementById("addr2").focus()
			return false;
		}
		
		// 전화번호 공백체크
		if(document.getElementById("phone1").value == "") {
			alert("지역번호는 필수입력값입니다!")
			document.getElementById("phone1").focus()
			return false;
		}
		if(document.getElementById("phone2").value == "") {
			alert("일반전화번호를 입력하지 않았습니다.")
			document.getElementById("phone2").focus()
			return false;
		}
		if(document.getElementById("phone3").value == "") {
			alert("일반전화번호를 입력하지 않았습니다.")
			document.getElementById("phone3").focus()
			return false;
		}
		
		//휴대전화 공백체크
		if(document.getElementById("mobile1").value == "") {
			alert("휴대전화번호 앞자리를 선택해주십시오.")
			document.getElementById("mobile1").focus()
			return false;
		}
		if(document.getElementById("mobile2").value == "") {
			alert("휴대전화번호를 입력하지 않았습니다.")
			document.getElementById("mobile2").focus()
			return false;
		}
		if(document.getElementById("mobile3").value =="") {
			alert("휴대전화번호를 입력하지 않았습니다.")
			document.getElementById("mobile3").focus()
			return false;
		}
		
		//이메일 공백체크
		if(document.getElementById("email1").value == "") {
			alert("이메일을 입력하지 않았습니다.")
			document.getElementById("email1").focus()
			return false;
		}
		if(document.getElementById("email2").value == "") {
			alert("이메일 형식을 선택하지 않았습니다.")
			document.getElementById("email2").focus()
			return false;
		}
		
		return true;
		
	}
</script>
</body>
</html>
