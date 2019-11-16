<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet"  href="css/custom.css">
<title>태영 채팅</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="js/bootstrap.js"></script>
<link href="https://fonts.googleapis.com/css?family=Gamja+Flower&display=swap" rel="stylesheet">
<style>
#back{
	font-family: 'Gamja Flower', cursive;
   
}
#timeBox{
		display:flex;
	position:absolute;
	top:50%;
  	left:40%;
  	background:fff;
  	margin:-50px 0 0 -50px;
}

#timeBox #timeMain{
	font-size: 168px;
    font-weight: 500;
    color:white;
    letter-spacing: 2px;
}

#timeBox #timeSub{
	margin-top:40px;
    align-items: center;
    justify-content: center;
    margin-inline-start: 2px;
}

#ampm{
   text-transform: uppercase;
    font-size: 38px;
    font-weight: 300;
    opacity: 0.46;
    letter-spacing: 1px;
    border-bottom: 1px solid rgba(255,255,255,0.3);
    padding-block-end: 20px;
    color:white;
}

#seconds{
  	padding-block-end: 17px;
    font-size: 48px;
    color:white;
}
#year{

	position:absolute;
	top:73%;
  	left:46%;
  	background:fff;
  	margin:-50px 0 0 -50px;
 font-size: 28px;
color:white;
    line-height: 1.2;
}
</style>
</head>
<body>
	<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	String toID = null;
	if(request.getParameter("toID") != null) {
		toID = (String) request.getParameter("toID");
	}
	%>
	<nav class="navbar navbar-default" style="margin:0px;">
		<div class="navbar-header">
			 <button type="button" class="navbar-toggle collapsed"
			  data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
      </button>
      		<a class="navbar-brand" href="index.jsp">실시간 회원제 채팅 서비스</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul id="drop_change" class="nav navbar-nav">
				<li class="active"><a href="index.jsp">메인</a></li>
				<li><a href="find.jsp">친구찾기</a></li>
				<li><a href="box.jsp">메시지함<span id="unread" class="label label-info"></span></a></li>
			</ul>
			<script>
			$('#drop_change li').on('click', function(){
			    $('#drop_change li.active').removeClass('active');
			    $(this).addClass('active');
			});
			</script>
			<%
				if(userID == null) {
			%>
			<!-- 드롭다운 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span>
					</a>
					<ul  class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<% } else {%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
						<li><a href="update.jsp">회원정보수정</a></li>
					</ul>
				</li>
			</ul>
			<% }%>
		</div>
	</nav>
	<script>
		function getInfiniteUnread(){
			setInterval(function(){
				getUnread();
			},4000);
		}
		function showUnread(result){
			$('#unread').html(result);
		}
	</script>

		<script>
		function getUnread(){
			$.ajax({
			type:"POST",
			url:"./chatUnread",
			data:{
				userID:encodeURIComponent('<%= userID %>')
			},
			success:function(result){
				if(result >= 1){
					showUnread(result);
				}else{
					showUnread('');
				}
			}
		});
	}
	</script>
<%
if(userID != null){
%>
		<script>
		$(document).ready(function(){
			getInfiniteUnread();
		});
	</script>
<%
}
%>
	