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
				<c:when test="${param.fail eq 'check' }">
					<div class="alert alert-danger">
						<strong>확인 실패</strong> 가입 된 아이디가 없습니다.
					</div>
				</c:when>
			</c:choose>
					<div class="panel panel-info">
					<div class="panel-heading">비밀번호 찾기</div>
					<div class="panel-body">
						<form method="post" action="checkAnswer.do">
							<input type="hidden" name="userno" value="${userInfo.no }">
							<div class="form-group">
								<label>질문</label>
								<select id="" class="form-control" name="question">
									<option value="1" ${userQuestion.no eq '1' ? 'selected':''}>자신의 인생 좌우명은?</option>
									<option value="2" ${userQuestion.no eq '2' ? 'selected':''}>자신의 보물 제 1호는?</option>
									<option value="3" ${userQuestion.no eq '3' ? 'selected':''}>추억하고 싶은 날짜가 있다면?</option>
									<option value="4" ${userQuestion.no eq '4' ? 'selected':''}>인상 깊게 읽은 책 이름은?</option>
									<option value="5" ${userQuestion.no eq '5' ? 'selected':''}>내가 좋아하는 캐릭터는?</option>
								</select>
							</div>
							<div class="form-group">
								<label>답변</label>
								<input type="text" class="form-control" name="answer" id="answer" placeholder="초기설정하신 답변을 입력하세요." value="" />
							</div>
							<div class="text-right">
								<input type="submit" class="btn btn-romi" value="확인" id="submit-btn">				
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>