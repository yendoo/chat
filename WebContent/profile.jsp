<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDTO" %>
    <%@ page import="user.UserDAO" %>
<%@ include file="header.jsp" %>
<%
	UserDTO user = new UserDAO().getUser(userID);
%>
<div class="container">
		<form method="post" action="./userUpdate">
			<table class="table table-bordered table-hover" style="text-align: ceonter; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="2"><h4>회원 정보 수정</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
						<td><h5><%=user.getUserID() %></h5>
						<input type="hidden" name="userID" value="<%= user.getUserID() %>">
						</td>
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
						<td colspan="2"><input class="form-control"  type="text" id="userName" name="userName"  maxlength="20" placeholder="이름을 입력하세요." value="<%= user.getName()%>"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>성별</h5></td>
						<td colspan="2">
						<div class="form-group" style="text-align:center; margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary <% if(user.getGender().equals("남자")) out.print("active"); %>">
									<input type="radio" name="userGender" autocomplete="off" value="남자"  <% if(user.getGender().equals("남자")) out.print("checked"); %> >남자
								</label>
								<label class="btn btn-primary <% if(user.getGender().equals("여자")) out.print("active"); %>">
									<input type="radio" name="userGender"  autocomplete="off" value="여자"  <% if(user.getGender().equals("여자")) out.print("checked"); %> >여자
								</label>
								</div>
							</div>
						</td> 
					</tr>
					<tr>
						<td style="width: 110px;"><h5>나이</h5></td>
						<td colspan="2"><input class="form-control"  type="number" id="userAge" name="userAge"  maxlength="20" placeholder="나이를 입력하세요." value="<%= user.getAge()%>"></td>
					</tr>
					<tr>
						<td style="text-align:left;"  colspan="3"><h5 style="color: red;" id="passwordCheckMessage"></h5><input class="btn btn primary pull-right" type="submit" value="수정"></td>
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
<script>

function passwordCheckFunction() {
	var userPassword1 = $('#userPassword1').val();
	var userPassword2 = $('#userPassword2').val();
	if(userPassword1 != userPassword2){
		$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
	}else {
		$('#passwordCheckMessage').html("");
	}
}</script>
	<script>
	$(function(){
	    $(".heading-compose").click(function() {
	      $(".side-two").css({
	        "left": "0"
	      });
	    });

	    $(".newMessage-back").click(function() {
	      $(".side-two").css({
	        "left": "-100%"
	      });
	    });
	})
	</script>
</body>
</html>