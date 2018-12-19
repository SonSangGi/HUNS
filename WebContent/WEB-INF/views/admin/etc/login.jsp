<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>관리자 로그인</title>
<link href="../../../../resources/admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../../../../resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="../../../../resources/admin/css/sb-admin.css" rel="stylesheet">

  </head>
  <body class="bg-dark">
	<h1 class="text-center" style="margin-top:50px; font-size: 200px;"><i class="fas fa-cog" style="color: white;"></i></h1>
    <div class="container" >
      <div class="card card-login mx-auto mt-5">
        <div class="card-header">관리자 로그인</div>
        <div class="card-body">
          <form>
            <div class="form-group">
              <div class="form-label-group">
                <input type="text" id="input-id" class="form-control" required="required" placeholder="아이디를 입력해주세요." autofocus="autofocus" name="id">
                <label for="input-id">아이디를 입력해주세요.</label>
              </div>
            </div>
            <div class="form-group">
              <div class="form-label-group">
                <input type="password" id="input-password" class="form-control" required="required" placeholder="비밀번호를 입력해주세요." name="password">
                <label for="input-password">비밀번호를 입력해주세요.</label>
              </div>
            </div>
            <div class="form-group">
             <!--  <div class="checkbox">
                <label>
                  <input type="checkbox" value="remember-me">
                  ㅇㅇ
                </label>
              </div> -->
            </div>
            <a type="submit" class="btn btn-primary btn-block" onclick="loginCheck();" style="color:white;">로그인</a>
            <a type="submit" class="btn btn-warning btn-block" href="../../home.do" style="color:white;">취소</a>
          </form>
          <div class="text-center">
          </div>
        </div>
      </div>
    </div>
	<script>
		document.addEventListener('keydown', function(event) {
	        if (event.keyCode === 13) {
	            loginCheck();
	        }
	    }, true);
	
		function loginCheck(){
			var id = $("#input-id").val();
			var pw = $("#input-password").val();
			if(id.length < 5){
				alert("아이디를 5글자 이상 입력하세요.");
				return false;
			}
			$.ajax({
				url: "/admin/main/check.do",
		        type:"post", 
		        data: {"id":id,"password":pw},
		        success: function(result){
		        	if(result.result == "idNo"){
		        		alert("아이디가 일치하지 않습니다.")
		        	} else if(result.result == "pwNo"){
		        		alert("비밀번호가 일치하지 않습니다.")
		        	} else if(result.result == "OK"){
		        		alert("로그인 되었습니다.")
		        		location.href = "/admin/main/home.do";
		        	} else {
		        		alert("알 수 없는 오류가 발생되었습니다.")
		        	}
		        }
			})
		}
	</script>
    <!-- Bootstrap core JavaScript-->
   <script src="../../../resources/admin/vendor/jquery/jquery.min.js"></script>
    <script src="../../../resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
   <script src="../../../resources/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

  </body>

</html>
