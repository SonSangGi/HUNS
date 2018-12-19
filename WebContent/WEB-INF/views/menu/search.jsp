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
#searchinit{
	padding-top: 300px;
}
#search-content{
	margin-top:50px;
	font-size: 14px;
	font: 12px verdana, "굴림", Dotum, sans-serif;
	color: #f5f6f7;
	margin-bottom: 20px;
	
}

#max-small {
    width: 350; 
    height: 350px;
    max-width: 500px;
    max-height: 660px;
}

#button {
	border: none;
  outline: 0;
  display: inline-block;
  padding: 8px;
  color: white;
  background-color: #000;
  text-align: center;
  cursor: pointer;
  width: 100%;
}
p{	
    margin: 0 0 0px;

}
.thumbnails {
    display: block;
    padding: 4px;
    margin-bottom: 20px;
    line-height: 1.42857143;
    background-color: #fff;
    /* border: 1px solid #ddd; */
    /* border-radius: 4px; */
    -webkit-transition: border .2s ease-in-out;
    -o-transition: border .2s ease-in-out;
    transition: border .2s ease-in-out;
}
label{
	font: 11px verdana,"돋움",Dotum,sans-serif;
}
select {
	font: 11px verdana,"돋움",Dotum,sans-serif;
	color: #555;
	height: 24px;
    border: 1px solid #ddd;
    vertical-align: middle;
    border: 1px solid #ddd;
    padding: 0px;
}
input {
	font: 12px verdana,"굴림",Dotum,sans-serif;
    color: #555;
	vertical-align: middle;
    border: 1px solid #ddd;
    padding: 0px;
}
.form-control{
    display: block;
    width: 100%;
    height: 34px;
    padding: 6px 12px;
    /* font-size: 14px; */
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #dad4d4;
    border-radius: 0px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
button {
	color: black;
	    
    border: 1px solid white;
    background: white;
}

#search-name{
	padding: 10px 0px 0px;
    margin: 0px 0 0px;
    text-align: left;
}
#summary{
	font-size: 12px;
    line-height: 15px;
    color: #c6c6c6;
    margin-top: 7px;
    font-weight: normal;
}
#viewimage {
	font: 17px/20px verdana,dotum!important;
    letter-spacing: -1px!important;
    font-weight: normal!important;
    color: #606060!important;
}
#prd-custom {
	font-size: 12px;
    line-height: 15px;
    text-decoration: line-through;
    color: #c6c6c6;
    font-weight: normal;
    margin: 5px auto;
}
#salerate-red{
	font-size: 13px;
    line-height: 5px;
    color: #ec1313;
    font-weight: bold;
    float: left;
    margin-right: 5px;
    margin: 5px auto;
    padding-right: 8px;
}
#prd-price{
	font-size: 18px;
    line-height: 7px;
    color: #313131;
    font-weight: 900;
    margin: 9px auto;
}
</style>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container" id="searchinit" >
	<form method="get" id="form-btn" action="search.do" class="form-horizontal">
		
		<div class="row">
			<div class="col-xs-offset-2 col-xs-7">
				<div class="form-group" >
					<label class="control-label col-xs-2" >상품분류</label>
					<div class="col-xs-10">
						<select class="form-control" onchange="keywordSearch();" id="sort-box" name="category" >
							<option selected="selected" value="" >상품분류 선택</option>
							<option value="1" ${param.category eq '1' ? 'selected':'' }>아우터</option>
							<option value="2" ${param.category eq '2' ? 'selected':'' }>티셔츠</option>
							<option value="3" ${param.category eq '3' ? 'selected':'' }>셔츠</option>
							<option value="4" ${param.category eq '4' ? 'selected':'' }>바지</option>
							<option value="5" ${param.category eq '5' ? 'selected':'' }>니트/가디건</option>
							<option value="6" ${param.category eq '6' ? 'selected':'' }>트레이닝복</option>
							<option value="7" ${param.category eq '7' ? 'selected':'' }>신발</option>
						</select>
					</div>	
				</div>
				<!-- 검색조건 -->
				<div class="form-group">
					<label class="control-label col-xs-2" >검색 조건</label>
					<div class="col-xs-3">
						<select class="form-control" id="" name="opt">
							<option selected="selected" value="itemName" >상품명</option>
							<option value="itemSize" ${param.opt eq 'itemSize' ? 'selected' : ''}>사이즈</option>
							<option value="itemColor" ${param.opt eq 'itemColor' ? 'selected' : ''}>색상</option>
							<option></option>
						</select>
					</div>
					<div class="col-xs-7">	
							<input type="text" class="form-control" id="keyword" value="${param.keyword }" name="keyword"  />	
					</div>	
				</div>
			
				<div class="form-group">
					<span class="control-label col-xs-2 text-left">인기검색어</span>
				
				</div>
					
					
				<div class="form-group">
					<label class="control-label col-xs-2">판매가격대 </label>
					<div class="col-xs-4">
						<input type="text" class="form-control"  id="minprice" name="minprice" value="${param.minprice }"/>
					</div>	
					<div class="col-xs-1 text-center"> 
						<span> ~</span>
					</div>
					<div class="col-xs-4">
						<input type="text" class="form-control" id="maxprice" name="maxprice" value="${param.maxprice }"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-xs-2"> </label>
					<div class="col-xs-7">
						<span id="dangerText" style="color: #fb0707 "></span>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-xs-2" >검색정렬기준</label>
					<div class="col-xs-8">
						<select class="form-control" id="order-combobox" name="orders">
							<option selected="selected" value="">::: 기준선택 :::</option>
							<option value="new" ${param.orders eq 'new' ? 'selected' : '' }>신상품</option>
							<option value="min" ${param.orders eq 'min' ? 'selected' : '' }>낮은 가격대</option>
							<option value="max" ${param.orders eq 'max' ? 'selected' : '' }>높은 가격대</option>
							
						</select>
					</div>
						
					<div class="col-xs-2">	
						<input type="submit" class="btn btn-primary-xs" id="button" value="검색" onclick="keywordSearch();"/>
					</div>	
				</div>
				
			</div>
		</div>
		<div class="text-right" id="search-content">
			<button type="button" name="orderbtn"  onclick="changeOrder('new');"><span id="orderby1" >신상품</span></button>
			<button type="button" name="orderbtn"  onclick="changeOrder('min');"><span id="orderby2">낮은가격</span></button>
			<button type="button" name="orderbtn" onclick="changeOrder('max');"><span id="orderby3">높은가격</span></button>
			
		</div>
	
		<div class="row" id="item-scroll" id="search-image">
			<div class="col-xs-12">	
				<c:forEach var="item" items="${items }" varStatus="status" >
					<div class="col-xs-4">
					    <div class="thumbnails">
					      <a href="/stores/detail.do?no=${item.no }">
					        <img src="/images/items/${item.image }" alt="Lights" style="width:100%" id="max-small" >
					        <div class="caption">
						         <p id="search-name">
									<span id="viewimage">${item.name }</span>
								</p>
									<!-- 컬러갯수, 사이즈갯수 -->
								<p id="summary">${item.colorCount }color / ${item.sizeCount }size</p>
								
								<p id="prd-custom">${item.price }</p>
								
								<div id="salerate-red">
									할인가
								</div>
								<div id="prd-price"><fmt:formatNumber value="${item.detailOption.currentPrice }" />원</div>
				        	</div>
					      </a>
						</div>
					</div>
				</c:forEach>
				
				
				
			</div>
		</div>
		<!-- 페이징 처리  -->
		<%-- <div class="text-center">
			<input type="hidden" name="cp" value="1" id="cp-box">
			<ul class="pagination">
			
			<c:if test="${pagination.currentBlock gt 1 }">
				<li><a href="javascript:keywordSearch(${pagination.prevBlock })">&laquo;</a></li>
			</c:if>
			
			<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
				<li class="${num eq pagination.cp ? 'active' : ''}"><a href="javascript:keywordSearch(${num })">${num }</a></li>
			</c:forEach>
			
			<c:if test="${pagination.currentBlock lt pagination.totalBlocks }">
				<li><a href="javascript:keywordSearch(${pagination.nextBlock })">&raquo;</a></li>
			</c:if>
			
			</ul>
		</div> --%>
	</form>
</div> 



<script type="text/javascript">

	
	var orderByBtns = document.querySelectorAll("#search-content a");
	orderByBtns.forEach(function(orderByBtn,index){
		
		orderByBtn.onclick = function(){
			orderByBtn.style.color='#999';
		}
	})
	
	
	function changeOrder(sort) {
		document.getElementById("order-combobox").value = sort;
		
		var cpage = $("#cp-box").val();
		$("#cp-box").val(cpage);
		$("#form-btn").submit();
	}
	
	function keywordSearch(cp) {
		cp = cp || 1;
		$("#cp-box").val(cp);
		$("#form-btn").submit();
	}
	
	
	var searchbtn = document.getElementById("button");
	var dangerText = document.getElementById("dangerText");
	var maxprice = document.getElementById("maxprice");
	var minprice = document.getElementById("minprice");
	minprice.onkeyup = function(event){
	  var minbtn = event.target.value;
	 
	 
	  if(Math.ceil(minprice.value) <= 0 || minbtn.startsWith('-') || minbtn.startsWith() ){
		  searchbtn.setAttribute('disabled',true);
		  maxprice.setAttribute('disabled',true);
		  dangerText.textContent = "0이하의 가격은 넣을 수 없습니다.";
	  }
	  if(minbtn >= 0 || minbtn=="") {
		  searchbtn.removeAttribute('disabled');
		  maxprice.removeAttribute('disabled');
		  dangerText.textContent = "";
	  }
	}
	
	maxprice.onkeyup = function(event) {
		var maxvalue = event.target.value;
		
		if(minprice.value == "" && maxvalue > 0) {
			minprice.setAttribute("value","0");
		}
		if(maxvalue==""){
			minprice.setAttribute("value","");
		}
	}
	var cp = 2;
	var text;
	
	$(window).scroll(function(){
		if( $(document).height()-$(window).scrollTop()-$(window).height() <= 0.1) {
			cp++;
			var keyword = $("#keyword").val();
			var opt = $("select[name=opt]").val();
			var minprice = $("#minprice").val();
			var maxprice = $("#maxprice").val();
			var orders = $("select[name=orders]").val();
			var category = $("#sort-box").val();
			$.ajax({
				url:"items.do",
				type:"get",
				data:{cp:cp, keyword:keyword , opt:opt, minprice:minprice, maxprice:maxprice,orders:orders,category:category},
				dataType:'json',
				success:function(result){
				
				result.items.forEach(function(item,index){
					console.log(item.name)
					var text = '';
					text += '<div class="col-xs-4">';
					text += '<div class="thumbnails">';
					text += '<a href="">';
					text += '<img src="/images/items/'+item.image+'" alt="Lights" style="width:100%" id="max-small" >';
					text += '<div class="caption">';
					text += '<p id="search-name">';
					text += '<span id="viewimage">'+item.name+'</span></p>';
					text += '<p id="summary">'+item.color+'color / '+item.size+'size</p>';
					text += '<p id="prd-custom">'+item.price+'</p>';
					text += '<div id="salerate-red">할인가</div>';
					text += '<div id="prd-price">'+item.price+'원</div>';
					text += '</div></a></div></div>';
					$("#item-scroll").append(text);
				})
					
				},
				error: function(xhr, status, error) {
		            alert(error);
		        }
				
				
			});
		}
	});
	
	
	
	
	
	/* var startHeightMin=788; //트리거 시작 스크롤 위치
	var itemHeight=100; // 아이템별 높이
	var itemMax=; //현재 표시 아이템수
	var itemLimit=${totalRows}; // 모든 아이템 수
	jQuery(window).scroll(function() {
	itemLimit=jQuery('.btm2_item').length; // 모든 아이템수 btm2_item css class 가 표시될 객채 li
	if(itemMax > itemLimit){ //표시 아이템 수가 모든 아이템수보다 높으면 작동 하지 말아야..
	    return;
	}
	cehcksc();
	});
	
	
	function cehcksc(){
	//#startdiv 는 해당 객채를 지나가면 작동을 한다 알맞게 변경 (트리거)
	    if (jQuery(window).scrollTop() >= ((jQuery(document).height() - jQuery(window).height()) - jQuery('#startdiv').innerHeight())-100) {
	          //console.log(jQuery(window).scrollTop()); // startHeightMin 찾기
	        var docHeight = jQuery(window).scrollTop() - startHeightMin;
	        var itemLength=Math.floor(docHeight / itemHeight);  / 스크롤 위치에서 시작 스크롤 위치를 -,출력할 아이템수를 설정 
	        if(itemMax<itemLength){ // 수가 낮아 졌을때는 표시 안함
	            itemMax=itemLength; // itemMax 갱신
	            jQuery('.btm2_item').each(function(index,item){ //btm2_item
	                if((itemMax-1) >= index){
	                    if(jQuery(this).css("display") == "none"){
	                        jQuery(this).fadeIn(2000);
	                    }
	                }
	            });
	        }
	         
	      }
	}
	
	
	 */
	
</script>

</body>
</html>