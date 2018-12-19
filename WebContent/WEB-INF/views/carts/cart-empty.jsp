<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>장바구니 empty</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
  #footer {
        width: 1140px;
        margin: 0px auto;
        padding: 20px;
        border: 1px solid #bcbcbc;
        
  	}
  
  	.center {
    	text-align: center;
	}
	#empty {
        width: 1140px;
        margin: 0px auto;
        padding: 20px;
        border: 1px solid #bcbcbc;
        
  	}
  
  	.center {
   	 	text-align: center;
	}
       
	.button {
   		background-color: #4CAF50;
  	 	border: none;
   		color: white;
   	 	padding: 15px 32px;
  	  	text-align: center;
  		text-decoration: none;
    	display: inline-block;
   		font-size: 16px;
   		margin-left: auto;
   		margin-right: auto;
    	cursor: pointer;  	 
	}
	
	.button1 {background-color: #000;}
	.button2 {background-color: #ccc;}
	.button3 {background-color: #fff;
				color: black;
				border: 1px solid #e7e7e7;}

	.button:hover {
   		 box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
	}

	.center {
 		text-align: center;
	 }
 
 	.right {
		 text-align: right;
 	}
 	</style>
</head>
<body>

<%@ include file="../include/header.jsp"%>
<!-- 장바구니 상단 -->
<div class="container" style="padding-top: 210px">  
	<div class="panel panel-default">
   		<div class="panel-heading">
   			<span><a href="/carts/cart-empty.do">국내배송상품(0)</a></span>
   		 	<span><a href="/carts/cart-empty.do">해외배송상품(0)</a></span> 
   		 	<span>장바구니에 담긴 상품은 14일 동안 보관됩니다.</span>
   		</div> 
 	</div>
</div>

<!-- 장바구니 비어있을 때 -->
<div class="container">
	<div id="empty" style="position:relative; bottom:5px;">
		<div class="center">
			<p>no item in shopping cart</p>
			<span>장바구니가 비어있습니다.<br/> 선택하신 상품을 장바구니에 담아주세요.</span>
		</div>
	</div>
	
<!-- Trigger the modal with a button -->	
	<button type="button" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#myModal" style="font-size: 13px; padding: 10px; position:relative; left:500px;" >선택상품주문</button>
	<button type="button" class="btn btn-basic btn-xs" data-toggle="modal" data-target="#myModal" style="font-size: 13px; padding: 10px; position:relative; left:505px;">전체상품주문</button>
	<button class="button button3" style="font-size: 13px; padding: 10px; position:relative; left:833px;"><a href="/home.do">쇼핑계속하기</a></button>


<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
<!-- Modal content-->
      		<div class="modal-content">
        		<div class="modal-header">
          			<button type="button" class="close" data-dismiss="modal">&times;</button>
          		<h4 class="modal-title">hun-s.com 내용:</h4>
        		</div>
        		<div class="modal-body">
          			<p>선택된 상품이 없습니다.</p>
       			</div>
        		<div class="modal-footer">
       				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
        		</div>
      		</div>
		</div>
	</div>
	
	
	<!--
	<div class="buttons" style="text-align: center;">
		<button class="button button1" style="font-size: 13px; padding: 10px; position:relative; left:50px;" >선택상품주문</button>
		<button class="button button2" style="font-size: 13px; padding: 10px; position:relative; left:50px;">전체상품주문</button>
		<button class="button button3" style="font-size: 13px; padding: 10px; position:relative; left:418px;"><a href="/home.do">쇼핑계속하기</a></button>
	</div>
</div>
	
  -->	
	
	

<!-- 장바구니 하단 -->
	<div id="footer" style="position:relative; top:10px;">
    	<h4 class="center">장바구니 이용안내</h4>
    		<p class="center"> 해외배송 상품과 국내배송 상품은 함께 결제하실 수 없으니 장바구니 별로 따로 결제해 주시기 바랍니다. <br/>
      			해외배송 가능 상품의 경우 국내배송 장바구니에 담았다가 해외배송 장바구니로 이동하여 결제하실 수 있습니다. <br/>
      			선택하신 상품의 수량을 변경하시려면 수량변경 후 [변경] 버튼을 누르시면 됩니다. <br/>
    			[쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다. <br/>
       			 장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.
       		</p>
       			 
       		<h4 class="center">무이자할부 이용안내</h4>
       		
       		<p class="center">상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면 됩니다. <br/>
       		   [전체 상품 주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다. <br/>
       		      단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.
       		</p>   
     </div>
</div>
</body>
</html>