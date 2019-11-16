<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<div class="container">
<%
if(userID == null) {
	session.setAttribute("messageType","오류 메시지");
	session.setAttribute("messageContent","현재 로그인이 되어있지 않습니다.");
	response.sendRedirect("login.jsp");
	return;
}
%>
	<table class="table table-bordered table-hover" style="text-align:center; border:1px solid #dddddd;">
		<thead>
			<tr>
				<th colspan="2"><h4>검색으로 친구찾기</h4></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td style="width:110px;"><h5>친구 이메일</h5></td>
				<td><input class="form-control" type="text" id="findID" name="findID" maxlength="20" placeholder="찾으실 이메일을 적어주세요."></td>
			</tr>
			<tr>
				<td style="width:110px;"><h5>친구 이름</h5></td>
				<td><input class="form-control" type="text" id="findName" maxlength="20" placeholder="찾으실 이름을 적어주세요."></td>
			</tr>
			<tr>
				<td colspan="2"><button class="btn btn-primary pull-right" onclick="findfunction();">검색</button></td>
			</tr>
		</tbody>
	</table>
</div>
<div class="container">
	<table id="friendResult" class="table table-bordered table-hover" style="text-align:center; border 1px solid: #dddddd;">
	</table>
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
	<div id="checkModal" class="modal fade">
	<div class="vertical-alignment-helper">
  <div class="modal-dialog">
    <div id="checkType" class="modal-content panel-info">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"> 확인 메시지</h4>
      </div>
      <div id="checkMessage" class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
  </div>
</div><!-- /.modal -->
	<script>
		function findfunction() {
			var userID = $('#findID').val();
			console.log(userID);
			$.ajax({
				type:"POST",
				url:'./UserRegisterCheckServlet',
				data:{userID:userID},
				success:function(result){
					if(result == 0){
						$('#checkMessage').html('친구찾기에 성공했습니다.');
						$('#checkType').attr('class','modal-content panel-success');
						getFriend(userID);
					}else{
						$('#checkMessage').html('친구를 찾을 수 없습니다.');
						$('#checkType').attr('class','modal-content panel-warning');
						failFriend();
					}
					$('#checkModal').modal("show");
				}
			});
		}
		
		function getFriend(findID){
			$('#friendResult').html('<thead>' +
					'<tr>' +
					'<th><h4>검색 결과</h4></th>' +
					'</tr>' + 
					'</thead>' + 
					'<tbody>' +
					'<tr>' +
					'<td style="text-align:center;"><h3>' + findID + '</h3><a href="chat.jsp?toID=' + encodeURIComponent(findID) + '" class="btn btn-primary pull-right">'+'메시지 보내기</a></td>' +
					'</tr>' +
					'</tbody>');
		}
		function failFriend(){
			$('#friendResult').html('');
		}
	</script>
</body>
</html>