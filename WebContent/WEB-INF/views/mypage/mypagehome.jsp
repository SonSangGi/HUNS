<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!DOCTYPE html>

<html lang="ko">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">

.romi_detail_page{
	 width: 100%;
	 margin: 0px auto;
    background: #fff;
    padding: 0 0 20px;
}

.romi_titleArea{
	clear: both;
    margin: 0px auto;
    width: 1200px;
    padding: 10px 0 20px 0;
    text-align: center;
    text-transform: uppercase;
}
.path{
	overflow: hidden;
    height: 30px;
    line-height: 30px;
    display: none;
}
path li.first{
	background: none;
}
.path h3 {
    overflow: hidden;
    position: absolute;
    width: 0;
    height: 0;
    white-space: nowrap;
    text-indent: 100%;
    font-size: 0;
    line-height: 0;
}


.path li {
    float: left;
    padding: 0 0 0 10px;
    margin: 0 0 0 5px;
    font-size: 11px;
}
.mypage_block01_wrap{
	background: #f0f0f0;
    padding: 42px 0px;
    height: 113px;
    margin-bottom: 100px;
}
.mypage_block01{
	width: 1035px;
    margin: 0 auto;
}
.xans-myshop-benefit {
	overflow: hidden;
    margin: 0 0 10px;
    padding: 0px;
    color: #878787;
    float: left;
    width: 400px;
}
.xans-myshop-benefit .myInfo p {
    line-height: 20px;
    text-align: left;
    position: absolute;
    margin-top: -13px;
}

.myThumb{
	margin: 0px auto;
    width: 90px;
    float: left;
}
.myInfo{
	float: left;
    margin: 0px auto;
    padding: 10px 0 0 0px;
}
.myInfo p{
	float: left;
    margin: 0px auto;
    padding: 10px 0 0 0px;
}

.name{
	    font-size: 12px;
}
.xans-myshop-bankbook{
	float: right;
    width: 370px;
}
.xans-myshop-bankbook ul{
	padding: 20px 0px;
}

.xans-myshop-bankbook li a{
	display: block;
    float: left;
    margin: 0px 0 0 8px;
    font-weight: bold;
    font-size: 13px;
    line-height: 20px;
}
.xans-myshop-bankbook li:last-child{
	    width: 70px;
}
.mypage_block02{
	width: 1035px;
    margin: 0 auto;
}
.mypage_lmenu{
	float: left;
    width: 135px;
    outline: 1px solid #d2d2d2;
    padding: 60px 0px 60px 20px;
    align: left;
}
.lmenu1{
	list-style: none;
	margin-left: -42px;
}
.lmenu2{
	margin-left: -42px;
	list-style: none;
}
ul, ol {
    list-style: none;
}

.mypage_lmenu .lmenu1 li:first-child {
    margin-bottom: 20px;
    
}
a {
    text-decoration: none;
}    
#myshopMain{
	float: right;
    width: 810px;
}
#myshopMain li {
    float: left;
    margin-left: 20px;
    margin-bottom: 20px;
}
.layout{
	    display: none;
}
#container {
    margin-top: 117px;
    width: 100%;
    margin:auto 0; 
    background: #fff;
}
#container #contents {
	width: 100%;
	margin: 0 auto;
    position: relative;
    min-height: 1000px;
    padding: 0px 0 0px 0;
    background: #fff;
}
</style>

</head>
<body>

<%@ include file="../include/header.jsp"%>
	<div class="container" id="container" >
		<c:choose>
			<c:when test="${empty LOGIN_USER_INFO }">
				<c:redirect url="/users/loginform.do">
					<c:param name="fail" value="deny"/>
				</c:redirect>
			</c:when>
		</c:choose>
		<div id="contents">
			<div class="romi_detail_page">
				<!-- 
				<div class="romi_titleArea">
					<h2>my shopping</h2>
				</div>
				 -->
				<!-- 
				<div class="path">
					<h3>현재 위치</h3>
					<ol>
						<li class="first"><a href="/">&nbsp;</a></li>
						<li title="현재 위치">마이 쇼핑</li>
					</ol>
				</div> 
				-->
				<div class="mypage_block01_wrap" style="margin-top: 201px;">
					<div class="mypage_block01">
						<div class="xans-element- xans-myshop xans-myshop-benefit ">
							<p class="myThumb">
								<img alt="" src="/images/mypage/mypage_m_icon.gif">
							</p>
							<div class="myInfo">
								<p>
									<strong class=><span>${LOGIN_USER_INFO.name }</span></strong><img alt=""
										src="/images/mypage/mypage_m_txt_01.gif">
								</p>
								<!-- 회원정보 수정  -->
								<p style="margin-top: 13px;">
								</p>
							</div>
						</div>
						<!-- 
						<div class="xans-element- xans-myshop xans-myshop-bankbook ">
							<ul>
								<li class="etc "><a href="/myshop/coupon/coupon.html">쿠폰<br>0
										개
								</a></li>
								<li><a href="/myshop/mileage/historyList.html">적립금<br>2,000원
								</a></li>
								<li><a href="/myshop/deposits/historyList.html">예치금<br>0원
								</a></li>
							</ul>
						</div>
						 -->
					</div>
				</div>
				<div class="mypage_block02">
					<div class="mypage_lmenu">
					<!--왼쪽 메뉴바  -->
						<ul class="lmenu1">
							<li><img alt="" src="/images/mypage/mypage_smenu_t01.gif"></li>
							<li><a href="/myshop/order/list.html"><img alt=""
									src="/images/mypage/mypage_smenu_01.gif"></a></li>
				
							<li><a href="/order/basket.html"><img alt=""
									src="/images/mypage/mypage_smenu_04.gif"></a></li>
									
							<li><a href="/myshop/wish_list.html"><img alt=""
									src="/images/mypage/mypage_smenu_05.gif" style="padding-bottom: 110px;"></a></li>
						</ul>
						<ul class="lmenu2">
							<li ><img alt="" src="/images/mypage/mypage_smenu_t02.gif" style="padding-bottom: 14px;"></li>
							<li><a href="recentItem.do"><img
									alt="" src="/images/mypage/mypage_smenu_06.gif"></a></li>
							<li><a href="mypageview.do"><img alt=""
									src="/images/mypage/mypage_smenu_07.gif"></a></li>
							<li><a href="/users/modifyform.do"><img src="/images/mypage/mypage_smenu_08.gif">
									</a></li>
							<li><a href="/users/modifyform.do"><img alt=""
									src="/images/mypage/mypage_smenu_09.gif"></a></li>
						</ul>
					</div>
					
					
					<ul id="myshopMain">
						<li><a href="mypageview.do"><img alt="board"
								src="/images/mypage/mypage_menu_01.gif"></a></li>
								
						<li><a href="/orders/saveList.do"><img alt="order"
								src="/images/mypage/mypage_menu_02.gif"></a></li>
								
						<li><a href="/users/modifyform.do"><img alt="member"
								src="/images/mypage/mypage_menu_03.gif"></a></li>
								
						<li><a href="/carts/cart-list.do"><img alt="basket"
								src="/images/mypage/mypage_menu_04.gif"></a></li>
						
					</ul>
				</div>

				<!--romi_detail END-->
			</div>
		</div>
	</div>
</body>
</html>