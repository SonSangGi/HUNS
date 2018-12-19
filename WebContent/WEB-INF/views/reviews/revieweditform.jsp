<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
<head>
  <title></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
    .review-content-hd {font-weight: bold;} 
    #review-age-warning {color:red;}
    #review-height-warning {color:red;}
    #review-weight-warning {color:red;}
    #review-content-warning {color:red;}
</style>

</head>

<body>
<c:choose>
	<c:when test="${empty LOGIN_USER_INFO }">
		<c:redirect url="/users/loginform.do">
			<c:param name="fail" value="deny"/>
		</c:redirect>
	</c:when>
</c:choose>
<%@ include file="../include/header.jsp"%>
<div class="container"  style="padding-top: 198px;">
<div class="row">
    <div>
        <div class="col-xs-offset-2 col-xs-8">
		<h2>리뷰 수정 페이지</h2>
	    </div>
    </div>
	
</div>

<div class="row">
    <form id="review-add-form" method="post" action="/reviews/edit.do" enctype="multipart/form-data">
    <input class="hidden" name="review-no" value="${review.no }"/>
	<input class="hidden" name="option-no" value="${review.option.no }"/>
	
	
	<div class="col-xs-offset-2 col-xs-8" style="text-align:center">
		<div class="row" style="margin-top:30px;">
		    <div class="col-xs-1" style="width:100px;">
		        <span class="review-content-hd">리뷰 상품</span>    
		    </div>
			<div class="col-xs-4">
           <span id="review-target-name">${review.item.name }</span>   
			</div>
		</div>
		<div class="row" style="margin-top:15px;">
            <div class="col-xs-1" style="width:100px;">
		      <span class="review-content-hd">성별</span>
		    </div>
           <div class="col-xs-3"  style="margin-left:5px;">   
               <input type="radio" name="option-sex" value="male"  checked="checked"/>
               남자
                <input type="radio" name="option-sex" value="female" style="margin-left:10px;" />
                여자            
           </div>
		</div>
        <div class="row" style="margin-top:15px;">
            <div class="col-xs-1" style="width:100px;">
		      <span class="review-content-hd">나이</span>
		    </div>
           <div class="col-xs-3" style="margin-left:-20px;">   
               <input type="number" name="option-age" style="width:50px;" id="review-age">            
           </div>
            <div class="col-xs-5">
               <span id="review-age-warning"></span>
           </div>
            
        </div>	
        <div class="row" style="margin-top:15px;">
            <div class="col-xs-1" style="width:100px;">
		      <span class="review-content-hd">키</span>
		    </div>
           <div class="col-xs-3" style="margin-left:-20px;">   
               <input type="number" name="option-height" style="width:50px;" id="review-height">            
           </div>
            <div class="col-xs-5">
               <span id="review-height-warning"></span>
           </div>
            
        </div>
        <div class="row" style="margin-top:15px;">
            <div class="col-xs-1" style="width:100px;">
		      <span class="review-content-hd">무게</span>
		    </div>
           <div class="col-xs-3" style="margin-left:-20px;">   
               <input type="number" name="option-weight" style="width:50px;" id="review-weight">            
           </div>
            <div class="col-xs-5">
               <span id="review-weight-warning"></span>
           </div>
            
        </div>
        <div class="row" style="margin-top:15px;">
            <div class="col-xs-1" style="width:100px;">
		      <span class="review-content-hd">사이즈</span>
		    </div>
           <div class="col-xs-3" style="margin-left:-20px;">   
               <select name="option-size" style="width:50px;">
                   <option value="90">XS</option>
                   <option value="95">S</option>
                   <option value="100">M</option>
                   <option value="105">L</option>
                   <option value="110">XL</option>
               </select>            
           </div>
        </div>
        <div class="row" style="margin-top:15px;">
            <div class="col-xs-1" style="width:100px;">
		      <span class="review-content-hd">점수</span>
		    </div>
            <div class="col-xs-7" style="margin-left:0px; color:crimson;">
                <input type="radio" name="option-star" value="1"  checked="checked"/>
                    ★
                <input type="radio" name="option-star" value="3" style="margin-left:10px;" />
                    ★★
                <input type="radio" name="option-star" value="5" style="margin-left:10px;" />
                    ★★★
                <input type="radio" name="option-star" value="7" style="margin-left:10px;" />
                    ★★★★
                <input type="radio" name="option-star" value="9" style="margin-left:10px;" />
                    ★★★★★         
                
            </div>
        </div>
        <div class="row" style="margin-top:15px;">
            <div class="col-xs-1" style="width:100px; margin-top:35px;">
		      <span class="review-content-hd">리뷰내용</span>
		    </div>
            <div class="col-xs-7" style="margin-left:35px;">
                <textarea rows="5" name="review-contents" style="width:500px;" id="review-contents"></textarea>
            </div>
            
        </div>
        <div class="row">
            <span id="review-content-warning"></span>
            
        </div>
        <div class="row" style="margin-top:15px;">
            <div class="col-xs-1" style="width:100px;">
		      <span class="review-content-hd">이미지</span>
		    </div>
           <!-- 이미지 업로드 후 파일 이름이 .jpg, .gif, .png가 아니면 거부하기-->
            <div class="col-xs-7" style="margin-left: 35px;">
                <input type="file" name="photo" id="review-photo"/>
            </div>
  
        </div>
        <div class="row" style="text-align: left; margin-left: 135px;">
            <p style="color: gray">파일은 .jpg, .gif, .png파일 형식만 업로드 해주세요</p>
        </div>
        <div class="row">
            <span id="review-photo-warning"></span>
            
        </div>
        
        
        
        <div class="row" style="margin-top:15px;">
            <div class="col-xs-offset-7 col-xs-5" style="padding-right:50px;">
                <button class="btn-primary" type="submit">수정</button>
                <button class="btn-danger" type="reset">취소</button>
            </div>
            
        </div>
	
	</div>
	</form>
</div>

</div>
</body>
<script>

	var ageField = document.getElementById("review-age");
	var heightField = document.getElementById("review-height");
	var weightField = document.getElementById("review-weight");
	var contentField = document.getElementById("review-contents");
	var photoField = document.getElementById("review-photo");
	
	var ageWarning = document.getElementById("review-age-warning");
	var heightWarning = document.getElementById("review-height-warning");
	var weightWarning = document.getElementById("review-weight-warning");
	var contentWarning = document.getElementById("review-content-warning");
	var photoWarning = document.getElementById("review-photo-warning");
	
	
	
	
	document.getElementById("review-add-form").onsubmit = function() {
		
		ageWarning.textContent ="";
		heightWarning.textContent="";
		weightWarning.textContent="";
		photoWarning.textContent="";		
		contentWarning.textContent="";
	
		if (ageField.value == "") {
			ageWarning.textContent="나이를 입력해주세요";
			ageField.focus();
			return false;
		}
		if (heightField.value == ""){
			heightWarning.textContent="키를 입력해주세요";
			heightField.focus();
			return false;
		}
		if (weightField.value == ""){
			heightWarning.textContent="키를 입력해주세요";
			weightField.focus();
			return false;
		}
		
		if (contentField.value == ""){
			contentWarning.textContent="리뷰 내용을 작성해주세요";
			contentField.focus();
			return false;
		}
	
		if (photoField.value == "") {
			photoWarning.textContent="이미지를 올려주세요";
			return false;
		}

		
		return true;
		
	}	
	
	
</script>
</html>