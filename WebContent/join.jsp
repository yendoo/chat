<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	if (userID != null) {
		session.setAttribute("messageType","오류메시지");
		session.setAttribute("messageContent", "현재 로그인이 되어 있는 상태입니다.");
		response.sendRedirect("index.jsp");
		return;
	}
%>
	<div class="container">
		<form method="post" action="./userRegister">
			<table class="table table-bordered table-hover" style="text-align: ceonter; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="3"><h4>회원 등록 양식</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
						<td><input class="form-control" type="email" id="userID" name="userID" maxlength="20" placeholder="이메일를 입력하세요."></td>
						<td style="width: 110px;"><button class="btn btn-primary" onclick="registerCheckFunction();" type="button" data-target="#messageModal">중복체크</button></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호</h5></td>
						<td colspan="2"><input class="form-control" onkeyup="passwordCheckFunction();" type="password" id="userPassword1" name="userPassword1"  maxlength="20" placeholder="비밀번호를 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호</h5></td>
						<td colspan="2"><input class="form-control" onkeyup="passwordCheckFunction();" type="password" id="userPassword2"  name="userPassword2"  maxlength="20" placeholder="비밀번호를 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이름</h5></td>
						<td colspan="2"><input class="form-control"  type="text" id="userName" name="userName"  maxlength="20" placeholder="이름을 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>성별</h5></td>
						<td colspan="2">
						<div class="form-group" style="text-align:center; margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary active">
									<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
								</label>
								<label class="btn btn-primary">
									<input type="radio" name="userGender"  autocomplete="off" value="여자" >여자
								</label>
								</div>
							</div>
						</td> 
					</tr>
					<tr>
						<td style="width: 110px;"><h5>나이</h5></td>
						<td colspan="2"><input class="form-control"  type="number" id="userAge" name="userAge"  maxlength="20" placeholder="나이를 입력하세요."></td>
					</tr>
					<tr>
						<td style="text-align:left;"  colspan="3"><h5 style="color: red;" id="passwordCheckMessage"></h5><input class="btn btn primary pull-right" type="submit" value="등록"></td>
					</tr>
				</tbody>
			</table>
		</form>
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
function registerCheckFunction() {
	var userID = $('#userID').val();
	
	$.ajax({
		type:'POST',
		url:'./UserRegisterCheckServlet',
		data: {userID: userID},
		success:function(result){
			if(result == 1){
				$('#checkMessage').html('사용할수 있는 아이디 입니다.');
				$('#checkType').attr('class', 'modal-content panel-success');
			}else {
				$('#checkMessage').html('사용할수 없는 아이디 입니다.');
				$('#checkType').attr('class', 'modal-content panel-success');
			}
			$('#checkModal').modal("show");
		}
	});
	
}

function passwordCheckFunction() {
	var userPassword1 = $('#userPassword1').val();
	var userPassword2 = $('#userPassword2').val();
	if(userPassword1 != userPassword2){
		$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
	}else {
		$('#passwordCheckMessage').html("");
	}
}
</script>
</body>
</html>