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
	<div class="jumbotron">
		<h2>고객님의 비밀번호 찾기가 완료되었습니다.</h2>
		<p>고객님의 비밀번호 찾기가 성공적으로 이루어졌습니다.<br>
		항상 고객님의 즐겁고 편리한 쇼핑을 위해 최선의 노력을 
		다하는 쇼핑몰이 되도록 하겠습니다.</p>
	</div>
	<div class="row">
		<div class="col-md-12">
			<form method="post" action="modify.do" id="modify-form">
				<div class="panel panel-info">
					<div class="pannel-body">
						<table class="table">
							<colgroup>
								<col width="20%">
								<col width="*">
							</colgroup>
								<tbody>
									<tr>
										<th>찾은 비밀번호 : ${userInfo.password }</th>
										<td></td>
									</tr>
								</tbody>
						</table>
					</div>				
				</div>			
			</form>
		</div>
	</div>



	<div class="col-md-12">
		<div class=text-right>
			<input type="button" class="btn btn-inverse" value="로그인 화면으로" onClick="location.href='/users/loginform.do'">
		</div>
	</div>
</div>
</body>
</html>
