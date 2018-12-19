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
    padding: 15px;
    font: 13px/14px verdana;
	
}
#question-title{
	height: 50px;
	text-align: center;
	
	vertical-align: middle;
    padding: 15px;
    font: 13px/14px verdana;
}

#question-title-content{
	height: 50px;
	
	
	vertical-align: middle;
    padding: 15px;
    font: 13px/14px verdana;
}
#vertical-middle{
	vertical-align: middle;
}
ul{
 	list-style: none; 
}

.u_cbox_comment_box{
	position: relative;
    border-bottom: 1px solid #e2e2e2;
}
.u_cbox_area{
	padding: 4px 0;
	font-size: 13px;
    color: #2a2a2a;
    line-height: 25px;
    font-weight: 700;
}

.u_cbox_info{
	padding-bottom: 1px;
}
.u_cbox_text_wrap{
	overflow: hidden;
    font-size: 13px;
    line-height: 18px;
    word-break: break-all;
    word-wrap: break-word;
}
.u_cbox_contents{
	font-size: 13px;
    line-height: 18px;
    word-break: break-all;
}

.u_cbox_info_base{
	position: relative;
    padding: 2px 0 0 0;
}
.u_cbox_date{
	display: inline-block;
   /*  float: left; */
    font-size: 12px;
    font-family: tahoma,helvetica,sans-serif;
    color: #999;
}
.u_cbox_head{
	padding: 0 0 2px;
    height: 38px;
}
.u_cbox_title{
	float: left;
    margin-top: 14px;
    font-size: 16px;
    font-weight: 700;
}
.u_cbox_count{
	overflow: hidden;
    float: left;
    margin-top: 11px;
    padding-left: 6px;
    font-size: 17px;
    font-family: tahoma,helvetica,sans-serif;
    color: #000;
}
.u_cbox_write_count{
	/* margin: -3px 16px 10px; */
	
    font-size: 13px;
    font-family: tahoma,helvetica,sans-serif;
   /*  color: #999; *//*  입력 컬러 */
    line-height: 22px;
    text-align: right;
}
.u_vc{
	overflow: hidden;
    position: absolute;
    left: -9999px;
    width: 1px;
    height: 1px;
    /* font-size: 1px; */
    color: transparent;
    line-height: 1px;
}
.u_cbox_count_num{
	font-weight: 400;
}
.u_cbox_write_total{
	/* margin: -3px 16px 10px; */
	margin: 4px 11px 0px -2px;
    font-size: 13px;
    font-family: tahoma,helvetica,sans-serif;
    color: #999;
    line-height: 22px;
    text-align: right;
}
.u_cbox_upload{
	height: 43px;
   /*  padding-right: 68px; */
    border-top: 1px solid #ededed;
}
.u_cbox_addition{
	    float: left;
    padding-left: 14px;
}
.u_cbox_btn_upload{
	
    bottom: -1px;
    right: -1px;
    z-index: 10;
    width: 68px;
    height: 45px;
    border: 1px solid #d50f6c;
    background: #ed1178;
    font-size: 13px;
    font-weight: 700;
    line-height: 45px;
    color: #fff;
}
.u_cbox_ico_upload{
	font-size: 13px;
    font-weight: 700;
    line-height: 45px;
    color: #fff;
}
.u_cbox_txt_upload{
	font-size: 13px;
    font-weight: 700;
    line-height: 45px;
    color: #fff;
}
a:link { 
	color: black;
	text-decoration: none;
	
}
a:visited { 
	color: black; 
	text-decoration: none;
}
a:hover { 
	color: black; 
	text-decoration: none;
}
.panel-footer1{
	padding: 10px 15px;
    background-color: #f5f5f5;
    /* border-top: 1px solid #ddd; */
    border-bottom-right-radius: 3px;
    border-bottom-left-radius: 3px;
}
</style>
</head>
<body>
<%@ include file="../include/header.jsp"%>
<div class="container" style="padding-top: 193px">
	<div class="row"  style="width:100%" >
		
		<div class="col-xs-12"> 
			<div class="panel panel">
				<div class="panel-heading" style="height: 60px">
					<div class="col-xs-2" id="question-title">SUBJECT</div>
					<div class="col-xs-10" id="question-title-content"><span style="font-size: 15px;"><b>${board.user.name}</b></span>고객님의 ${board.itemQuestionType.contents }입니다.</div>
					<div class="col-xs-2" id="top-menu1">ITEM-NAME</div>
					<div class="col-xs-10" id="content-menu1"><span style="font-size: 15px;"><b>${board.item.name}</b></span></div>
				</div>
				<div class="panel-body" style="padding: 0px">
					<div class="col-xs-2" id="top-menu1"><span id="vertical-middle">DATE</span></div>
					<div class="col-xs-10" id="content-menu1"><span id="vertical-middle"><fmt:formatDate value="${board.createDate }"/></span></div>
					<div class="col-xs-12" id="content-menu1" style="height: auto;"><span id="vertical-middle">${board.contents }</span></div>
					
				</div>
				
				
				
				<!-- 버튼 위치 -->
				<!-- style="height: 250px" -->
				<div >
					<div class="col-xs-12" style="height: auto;">
						<img src="../images/itemQuestions/${board.filename }" alt="등록이미지" style="width: 124px; height: 124px; margin-top: 100px;">
					</div>
				</div>
				<div>
					<div class="text-right" id="content-menu1" style="margin-bottom: 10px;">
						<a href="list.do" class="btn btn-info">목록</a>
						<a href="modifyform.do?boardno=${param.boardno }" class="btn btn-primary">수정</a>
						<a href="delete.do?boardno=${param.boardno }" class="btn btn-danger">삭제</a>
					</div>
				</div>
				<!--댓글  -->
				<div class="panel-footer1">
					
					<div class="u_cbox_head">
						<h5 class="u_cbox_title">댓글</h5>
							<span class="u_cbox_count">${commentCount }</span>
					</div>
					<form method="get" action="comment.do" id="submit-btn">	
						<div>	
							<input type="hidden" value="${board.no }" name="boardno">
							<textarea rows="5" cols="30" style="margin:0px; width: 1076px;height: 190px;" name="commentText" id="commentTextId"></textarea>
							<div class="u_cbox_write_count">
								<span class="u_vc">현재 입력한 글자수</span>
								<strong class="u_cbox_count_num" id="minCount">0</strong>/<span class="u_vc">전체 입력 가능한 글자수</span>
								<span class="u_cbox_write_total">300</span>
							</div>
							<div class="u_cbox_upload text-right">
								<div class="u_cbox_addition"></div>
									<button class="u_cbox_btn_upload" id="commentBtn" data-action="write#request" data-log="RPC.write#RPC.reply">
										<span class="u_cbox_ico_upload"></span>
										<span class="u_cbox_txt_upload">등록</span>
									</button>
								</div>
							</div>
					</form>
					<form method="get" action="detail.do?boardno=${board.no }" id="cp-btn">
						<input type="hidden" name="cp" value="1" id="cp-box" >
						<input type="hidden" name="boardno" value="${board.no }">
					<!-- 댓글  -->
						<ul class="list-group" style="padding-top: 20px">
						<c:forEach var="comment" items="${comments }">
							<li class="list-group-item">
								<div class="u_cbox_comment_box">
									<!--작성이  -->
									<div class="u_cbox_area">
										<div class="u_cbox_info">
											${comment.name }
										</div>
									</div>
									<!--댓글내용  -->
									<div class="u_cbox_text_wrap">
										<span class="u_cbox_contents" data-lang="ko">${comment.contents }</span>
									</div>
									<!--등록시간 -->
									<div class="u_cbox_info_base">
										<span class="u_cbox_date" data-value="2018-10-28T23:39:57+0900"><fmt:formatDate value="${comment.createDate }"/> </span>
									</div>
									<div>
										<button class="btn btn-xs">답글</button>
									</div>
								</div>
							</li>
						</c:forEach>			
						</ul>
						<div class="text-center">
							<ul class="pagination">
							
							<c:if test="${pagination.currentBlock gt 1 }">
								<li><a href="javascript:paginationSearch(${pagination.prevBlock })">&laquo;</a></li>
							</c:if>
							
							<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
								<li class="${num eq pagination.cp ? 'active' : ''}"><a href="javascript:paginationSearch(${num })">${num }</a></li>
							</c:forEach>
							
							<c:if test="${pagination.currentBlock lt pagination.totalBlocks }">
								<li><a href="javascript:paginationSearch(${pagination.nextBlock })">&raquo;</a></li>
							</c:if>
							
							</ul>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="col-xs-12">
			<h2>
				<img src="../images/itemQuestions/boardcenter.png" alt="상품문의" style="width: 1140px;" >
			</h2>
		</div>				
	</div>
</div>
<script type="text/javascript">
	var text = 1;
	var commentTextId = document.getElementById("commentTextId");
	var commentBtn = document.getElementById("commentBtn");
	
	//댓글 빈 공간일경우
	(function() {
		
		if(commentTextId.value.length == 0){
			commentBtn.setAttribute('disabled',true);
		}else{
			commentBtn.removeAttribute('disabled');
			
		}
	})();
	commentTextId.onkeyup = function(event){
		text = event.target.value;
		var minCount = text.length;
		commentBtn.removeAttribute('disabled');
		if(minCount == 0){
			commentBtn.setAttribute('disabled',true);
		}
		if(minCount >= 300) {
			var newText=text.substr(0,299);
			commentBtn.setAttribute('disabled',true);
			commentTextId.value = newText;
		}
			document.getElementById("minCount").innerHTML = minCount;
	}
	
	function paginationSearch(cp) {
		cp = cp || 1;
		document.getElementById("cp-box").value = cp;
		
		document.getElementById("cp-btn").submit();
	}
	commentBtn.onclick = function(event){
		
		document.getElementById("submit-btn").submit();
	}
</script>
</body>
</html>