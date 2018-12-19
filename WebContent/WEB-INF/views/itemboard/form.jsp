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
<style type="text/css">
#subject {
	height: 45px;
}
#top-menu1{
	height: 50px;
	text-align: center;
	border-top: 1px solid #dbdad8;
	vertical-align: middle;
    padding: 15px;
    font: 13px/14px verdana;
}

#content-menu1{
	height: 50px;
	border-top: 1px solid #dbdad8;
	vertical-align: middle;
    padding: 13px;
    font: 13px/14px verdana;
	
}
#top-menupassword{
	height: 50px;
	text-align: center;
	border-top: 1px solid #dbdad8;
	vertical-align: middle;
    padding: 15px;
    font: 13px/14px verdana;
}
#question-title{
	height: 50px;
	text-align: center;
	border-bottom: 1px solid #dbdad8;
	vertical-align: middle;
    padding-top: 15px;
    font: 13px/14px verdana;
}

#question-title-content{
	height: 50px;
	border-bottom: 1px solid #dbdad8;
	vertical-align: middle;
    padding-top: 9px;
    font: 13px/14px verdana;
}
#listBtn{
	display: inline-block;
    font: normal 11px 돋움;
    letter-spacing: -1px;
    cursor: pointer;
    padding: 8px 18px 6px;
    border: #555 1px solid;
    background: #3c3c3c;
    color: #fff;
}
#resetBtn{
	display: inline-block;
    font: normal 11px 돋움;
    letter-spacing: -1px;
    cursor: pointer;
    padding: 8px 18px 6px;
    border: #555 1px solid;
    background: #3c3c3c;
    color: #fff;
}
#submitBtn{
	display: inline-block;
    font: normal 11px 돋움;
    letter-spacing: -1px;
    cursor: pointer;
    padding: 8px 18px 6px;
    border: #555 1px solid;
    background: #3c3c3c;
    color: #fff;
}
</style>

</head>
<body>
<%@ include file="../include/header.jsp"%>
<div class="container" style="padding-top: 180px">
	<div class="row"  style="width:100%" >
		
		<div class="col-xs-12">
		<form method="post" action="add.do" enctype="multipart/form-data" >
			<input type="hidden" name="name" value="${loginedUser.name }">
			<div class="panel-panel">
				<div class="panel-heading" style="height: 43px">
					<div class="col-xs-2" id="question-title" >
						subject
					</div>
					<div class="col-xs-10" id="question-title-content">
						
						
						<select style="height: 34px; width: auto;" name="title">
						<c:set var="typeSelect" value="1"></c:set>
						<c:forEach var="type" items="${types }">
							<!-- 세션 이름 받아서또는 유저이름 받아서 -->
							<option value="${type.no }" ${typeSelect eq 1 ? 'selecte': '' } >${type.contents }입니다.</option>
						</c:forEach>
						</select>
					</div>
					
					<div class="col-xs-2" id="question-title" >
						상품명
					</div>
					<div class="col-xs-10" id="question-title-content">
					<c:choose>
							<c:when test="${param.load eq 'item'}">
								<input type="hidden" value="${item.no}" name="item-title">
								<span  style="vertical-align: -webkit-baseline-middle;"><label>${item.name }</label></span>
							</c:when>
						
							<c:when test="${param.load  eq 'board'}">
								<span style="vertical-align: -webkit-baseline-middle;"><label>
									<select name="item-title" style="height: 34px; width: auto;">
										<c:forEach var="boardItem" items="${boardItems }"> 
											<option value="${boardItem.no }">${boardItem.name }</option>
										</c:forEach>
									</select>
								</label></span>
							</c:when>
					</c:choose>
					</div>
					
					<div class="col-xs-2" id="question-title" >
						작성자
					</div>
					<div class="col-xs-10" id="question-title-content">
						<span style="vertical-align: -webkit-baseline-middle;"><label>${loginedUser.name }</label></span>
					</div>
					
				
				</div>
				<div class="panel-body">
					<div class="col-xs-12" style="margin-top: 10px; display: flex; padding-bottom: 13px;" > 
						<textarea rows="20" cols="152" name="contents">문의 사항 : </textarea>
					</div>
					
					<div class="col-xs-2"  id="top-menu1">
						<label>첨부파일</label>
					</div>
					<div class="col-xs-10" id="content-menu1">
						<input type="file" value="" name="upfile" style="display: inline;">
						<span class="glyphicon glyphicon-plus" aria-hidden="true" id="add-btn"></span>
						<label>파일명</label>
					</div>
					
					
					<div class="col-xs-2" id="top-menu1" style="border-bottom: 1px solid #dbdad8;">
						<label>secret</label>
					</div>
					<div class="col-xs-10" id="content-menu1" style="border-bottom: 1px solid #dbdad8;">
						<input type="radio" name="secret" value="p">공개글
						<input type="radio" name="secret" value="s" checked="checked">비밀글 
					</div>
					
					
					
					<div class="col-xs-12" style="padding-top: 12px">
						<div class="text-right">
						<!--  btn-xs 버튼사이즈 -->
							<a href="list.do"  id="listBtn">목록</a>
							<input type="reset" value="취소"  id="resetBtn">
							<input type="submit" value="등록" id="submitBtn">
						</div>
					</div>			
				</div>	
			</div>
		</form>
		</div>
		<div class="col-xs-12">
			<h2>
				<img src="../images/itemQuestions/boardcenter.png" alt="상품문의" style="width: 1140px;" >
			</h2>
		</div>
	</div>
</div>
<script type="text/javascript">
var index = 1;
	document.getElementById("add-btn").onclick = function() {	
		
		var content = '<div class="col-xs-2" id="top-menu1">';
		content += '<label>첨부파일</label>';
		content += '</div>';
		content += '<div class="col-xs-10" id="content-menu1">';
		content += '<input type="file" value="" name="upfile'+ index++ +'" style="display: inline;">';
		content += '<span class="glyphicon glyphicon-plus" aria-hidden="true" id="add-btn"></span>';
		content += '<label>파일명</label>';
		content += '</div>';
		
		$("#top-menupassword").before(content);
		
		
		
		
		
	}

</script>
</body>
</html>