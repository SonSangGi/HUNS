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
#nameTop-menu{
	height: 50px;
	text-align: center;
	border-bottom: 1px solid #dbdad8;
	vertical-align: middle;
    padding: 15px;
    font: 13px/14px verdana;
}

#nameConent-menu{
	height: 50px;
	border-bottom: 1px solid #dbdad8;
	vertical-align: middle;
    padding: 13px;
    font: 13px/14px verdana;
    margin-bottom: 10px;
	
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
	vertical-align: middle;
	border-bottom: 1px solid #dbdad8;
    padding-top: 9px;
    font: 13px/14px verdana;
}
</style>

</head>
<body>
<%@ include file="../include/header.jsp"%>
<div class="container" style="padding-top: 180px">
	<div class="row">
		<div class="col-xs-12"> 
			<form method="post" action="modify.do" enctype="multipart/form-data" >
			<div class="panel panel">
				<input type="hidden" value="${param.boardno }" name="boardno"/>	
					<div class="panel-heading" style="height: 52px">
						<div class="col-xs-2" id="question-title">SUBJECT</div>
						<div class="col-xs-10" id="question-title-content">
							<select style="height: 25px; width: 300px;" name="title">
							<!-- 세션 이름 받아서또는 유저이름 받아서 -->
							
							<c:forEach var="type" items="${types }">
								<option value="${type.no }" ${type.no == board.itemQuestionType.no ? 'selected' : '' }>고객님의 ${type.contents }입니다.</option>
							</c:forEach>
							</select>
							
						</div>
					</div>
				
					<div class="panel-body">
						<div class="col-xs-2" id="nameTop-menu"><span id="vertical-middle">NAME</span></div>
						<div class="col-xs-10" id="nameConent-menu"><span id="vertical-middle">${board.user.name }</span></div>
						<div class="col-xs-2" id="nameTop-menu"><span id="vertical-middle">ITEM-NAME</span></div>
						<div class="col-xs-10" id="nameConent-menu" style="PADDING-TOP: 1PX;"><span id="vertical-middle">
								<select name="item-title" style="height: 34px; width: auto; ">
									<c:forEach var="boardItem" items="${boardItems }"> 
										<option value="${boardItem.no }" ${boardItem.no eq board.item.no ? 'selected':''}>${boardItem.name }</option>
									</c:forEach>
								</select>
						
						
						</span></div>
					
						<div class="col-xs-12" style="display: flex; padding-bottom: 13px;">
							<textarea rows="20" cols="152" name="contents">${board.contents }</textarea>
						</div>
						
						<div class="col-xs-2"  id="top-menu1">
							첨부파일
						</div>
						<div class="col-xs-10" id="content-menu1">
							<input type="file" value="" name="upfile" style="display: inline;">
							<span class="glyphicon glyphicon-plus" aria-hidden="true" id="add-btn"></span>
							파일명
						</div>
						
						<div class="col-xs-2" id="top-menu1" style="border-bottom: 1px solid #dbdad8;">
							secret
						</div>
						<div class="col-xs-10" id="content-menu1" style="border-bottom: 1px solid #dbdad8;">
							<input type="radio" name="secret" value="P" ${'P' eq board.secret ? 'checked' : '' }>공개글
							<input type="radio" name="secret" value="S" ${'S' eq board.secret ? 'checked' : '' }>비밀글 
						</div>
					
						<div class="col-xs-12" style="padding-top: 12px">
							<div class="text-right">
							<!-- btn-xs  -->
								<a href="detail.do?boardno=${param.boardno }" class="btn btn-default">목록</a>
								<input type="reset" value="취소" class="btn btn-default">
								<input type="submit" value="수정" class="btn btn">
							</div>
						</div>
					</div>
				
			</div>	
			</form>		
			<!--댓글  -->
			<div class="panel-footer">
				
			</div>
			
		</div>
	</div>
</div>

</body>
</html>