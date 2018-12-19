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
		<div class="col-md-offset-4 col-md-4">
			<c:choose>
				<c:when test="${param.fail eq 'login'}">
					<div class="alert alert-danger">
						<strong>로그인 실패</strong> 아이디 또는 비밀번호가 올바르지 않습니다.
					</div>
				</c:when>
				<c:when test="${param.fail eq 'deny'}">
					<div class="alert alert-danger">
						<strong>로그인 실패</strong><br>회원가입을 하고 마이페이지를 이용해주세요.
					</div>
				</c:when>
				<c:when test="${param.fail eq 'withdrawal'}">
					<div class="alert alert-danger">
						<strong>로그인 실패</strong><br>탈퇴 처리 된 회원입니다.
					</div>
				</c:when>
			</c:choose>
			<div class="panel panel-info">
					<div class="panel-heading">로그인</div>
					<div class="panel-body">
						<form method="post" action="login.do" >
							<div class="form-group">
								<label>아이디</label>
								<input type="text" class="form-control" name="id" id=id placeholder="아이디를 입력하세요." value="${not empty userId? userId.id : not empty autoUser? autoUser.id :'' }" />
							</div>
							<div class="form-group">
								<label>비밀번호</label>
								<input type="password" class="form-control" name="password" id="password" placeholder="비밀번호를 입력하세요." value="${not empty autoUser ? autoUser.password :'' }"/>
							</div>
							<div class="text-left">
								<label for="autologin"><input id="auto" name="auto" class="ec-base-chk" value="Y" type="checkbox" ${not empty autoUser ? 'checked' :'' }>자동 로그인</label>
								<input id="save-id" name="saveid" class="" type="checkbox" ${not empty userId ? 'checked' :'' }>아이디 기억하기</label>
							</div>
							<div class="text-right">
								<input type="submit" class="btn btn-romi" value="로그인" id="submit-btn" onclick="savaId();">				
								<input type="button" class="btn btn-default" value="취소" onClick="location.href='/home.do'">
							</div>
							<br>
							<div class="text-left">
								<input type="button" class="btn btn-romi" value="아이디 찾기" onClick="location.href='/users/findidform.do'">
								<input type="button" class="btn btn-romi" value="비밀번호 찾기" onClick="location.href='/users/findpwdform.do'">
							</div>
						</form>					
					</div>
					
				</div>
				
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

	function savaId(){
		var inputId = $('#id').val();
		var inputPw = $('#password').val();
		var checkBox = false;
		var autoLogin = false;  //자동로그인 체크박스
		if($('#save-id').is(':checked') == true){
			checkBox = true;
		}
		if($('#auto').is(':checked') == true){
			autoLogin = true;
		}
		$.ajax({
			data : {'id':inputId, 'password':inputPw, 'checkBox':checkBox, 'autoLogin': autoLogin},
			type:'post',
			url:'login.do',
			success :function(result){
				
			},
			error: function(xhr, status, error) {
	           
	        }
		});
	
	
		
	}
	
	

</script>
</html>
