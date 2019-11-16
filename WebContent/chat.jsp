<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.net.URLDecoder" %>
<%@ include file="header.jsp" %>
<%
if (userID == null) {
	session.setAttribute("messageType","오류메시지");
	session.setAttribute("messageContent", "현재 로그인이 되어 있지 않은 상태입니다.");
	response.sendRedirect("index.jsp");
	return;
}
if (toID == null) {
	session.setAttribute("messageType","오류메시지");
	session.setAttribute("messageContent", "대회상대가 지정 되어 있는 않은 상태입니다.");
	response.sendRedirect("index.jsp");
	return;
}
if(userID.equals(URLDecoder.decode(toID,"UTF-8"))){
	session.setAttribute("messageType","오류메시지");
	session.setAttribute("messageContent", "자기 자신에게는 쪽지를 보낼 수 없습니다.");
	response.sendRedirect("index.jsp");
	return;
}
%>
	<script>
	function autoClosingAlert(selector, delay){
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function () {
			alert.hide()
		},delay);
	}
	
	function submitFunction(){
		var fromID = '<%= userID %>';
		var toID = '<%= toID %>';
		var chatContent = $('#chatContent').val();
		$.ajax({
			type:'POST',
			url: './ChatSubmitServlet',
			data: {
				fromID : encodeURIComponent(fromID),
				toID : encodeURIComponent(toID),
				chatContent : encodeURIComponent(chatContent)
				
			},
			success:function(result){
				if(result == 1){
					autoClosingAlert('#successMessage',2000);
				}else if(result == 0){
					autoClosingAlert('#dangerMessage',2000);
				}else {
					autoClosingAlert('#warningMessage',2000);
				}
			}
		});
		$('#chatContent').val('');
		}
	
	var lastID = 0;
	
	function chatListFunction(type) {
		var fromID = '<%= userID %>';
		var toID = '<%= toID %>';
		$.ajax({
			type:'POST',
			url: './ChatListServlet',
			data: {
				fromID : encodeURIComponent(fromID),
				toID : encodeURIComponent(toID),
				listType : type
			},
			success:function(data){
				if(data == "")return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				
				for (var i = 0; i < result.length; i++) {
					if(result[i][0].value == fromID){
						result[i][0].value = '나';
					}
					addChat(result[i][0].value, result[i][2].value, result[i][3].value);
				}
				lastID = Number(parsed.last);
			}
		});
	}
	/*
	function addChat(chatName, chatContent, chatTime) {
		$('#chatList').append('<div class="row">' + 
		'<div class="col-lg-12">' + 
		'<div class="media">' + 
		'<a class="pull-left" href="#">' + 
		'<img class="media-object img-circle" style="width:30px; height:30px;" src="images/user.png" alt="">' + 
		'</a>' + 
		'<div class="media-body">' + 
		'<h4 class="media-heading">' +
		chatName + 
		'<span class="small pull-right">' + 
		chatTime +
		'</span>' +
		'</h4>' + 
		'<p>' +
		chatContent +
		'</p>' +
		'</div>' + 
		'</div>' + 
		'</div>' + 
		'</div>' + 
		'<hr>');
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
	}
	*/
	function addChat(chatName, chatContent, chatTime) {
		$('#chatList').append(' <li class="left clearfix">' + 
		'<span class="chat-img pull-left">' + 
		'<img src="https://bootdey.com/img/Content/user_3.jpg" alt="User Avatar">' + 
		'</span>' + 
		'<div  class="chat-body clearfix">' + 
		'<div class="header">' +
		'<strong class="primary-font">' + chatName + '</strong>' + 
		'<small class="pull-right text-muted"><i class="fa fa-clock-o"></i>'+ chatTime + '</small>' + 
		'</div>' +
		'<p>' +
		chatContent +
		'</p>' +
		'</div>' + 
		'</li>' + 
		'</ul>' + 
		'<hr>');
		$('#chat').scrollTop($('#chat')[0].scrollHeight);
	}
	
	
	function getInfiniteChat() {
		setInterval(function(){
			chatListFunction(lastID);
		},3000);
	}
</script>

<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<div class="container bootstrap snippet">
    <div class="row">
		<div class="col-md-4 bg-white ">
            <div class=" row border-bottom padding-sm" style="height: 40px;">
            	Member
            </div>
            
            <!-- =============================================================== -->
            <!-- member list -->
            <ul id="chatMember" class="friend-list">
                <li class="active bounceInDown">
                	<a href="#" class="clearfix">
                		<img src="https://bootdey.com/img/Content/user_1.jpg" alt="" class="img-circle">
                		<div class="friend-name">	
                			<strong>John Doe</strong>
                		</div>
                		<div class="last-message text-muted">Hello, Are you there?</div>
                		<small class="time text-muted">Just now</small>
                		<small class="chat-alert label label-danger">1</small>
                	</a>
                </li>
               
            </ul>
		</div>
        
        <!--=========================================================-->
        <!-- selected chat -->
    	<div class="col-md-8 bg-white ">
            <div id="chat" class="chat-message" style="overflow:auto; ">
                <ul id="chatList" class="chat">
                   
            </div>
            <div class="chat-box bg-white">
            	<div class="input-group">
            		<input class="form-control border no-shadow no-rounded" id="chatContent" name="chatContent" placeholder="Type your message here">
            		<span class="input-group-btn">
            			<button class="btn btn-success no-rounded" type="button" onclick="submitFunction()">전송</button>
            		</span>
            	</div><!-- /input-group -->	
            </div>            
		</div>        
	</div>
</div>
<div class="alert alert-success" id="successMessage" style="display:none;">
	<strong>메시지 전송에 성공했습니다.</strong>
</div>
<div class="alert alert-success" id="dangerMessage" style="display:none;">
	<strong>이름과 내용을 모두 입력해주세요.</strong>
</div>
<div class="alert alert-success" id="warningMessage" style="display:none;">
	<strong>데이터베이스 오류가 발생했습니다.</strong>
</div>
	<%
			String messageContent = null;
			if(session.getAttribute("messageContent") != null) {
				messageContent = (String) session.getAttribute("messageContent");
			}
			String messageType = null;
			if(session.getAttribute("messageType") != null) {
				messageType = (String) session.getAttribute("messageType");
			}
			if(messageContent != null) {
	%>
	
	<div id="messageModal" class="modal fade">
	<div class="vertical-alignment-helper">
  <div class="modal-dialog vertical-align-center">
    <div class="modal-content ">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"> <%= messageType %></h4>
      </div>
      <div class="modal-body">
 		<%= messageContent %>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
      </div>
    </div><!-- /.modal-content -->
    </div>
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
	<script>
		$('#messageModal').modal("show");
	</script>
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
			}
	%>
	<% if(userID!=null){ %>
	<script>
	$(document).ready(function(){
		chatListFunction('0');
		getInfiniteChat();
	})
	</script>
	<%} %>
</body>
</html>