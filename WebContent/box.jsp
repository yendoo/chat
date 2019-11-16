<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
if(userID == null) {
	session.setAttribute("messageType","오류 메시지");
	session.setAttribute("messageContent","현재 로그인이 되어있지 않습니다.");
	response.sendRedirect("login.jsp");
	return;
}
%>
<script>
		function chatBoxFunction(){
			var userID = '<%= userID %>';
			$.ajax({
			type:"POST",
			url:"./chatBox",
			data:{
				userID:encodeURIComponent(userID),
			},
			success:function(data){
				
				if(data == "")return;
				$('#boxTable').html('');
				var parsed = JSON.parse(data);
				var result = parsed.result;
				for (var i = 0; i < result.length; i++) {
					if(result[i][0].value == userID){
					result[i][0].value = result[i][1].value;	
				}else{
					result[i][1].value = result[i][0].value;
				}
				addBox(result[i][0].value, result[i][1].value, result[i][2].value, result[i][3].value, result[i][4].value );
			}
		}
			});
	}
		
		function addBox(lastID,toID,chatContent,chatTime,unread){
		
			$('#boxTable').append('<tr onclick="location.href=\'chat.jsp?toID=' + encodeURIComponent(toID) + '\'">' + 
					'<td style="width;150px;"><h5>' + lastID + '</h5></td>' +
					'<td>' +
					'<h5>' + chatContent + 
					' <span class="label label-info">' + unread + '</span></h5>' +
					'<div class="pull-right">' + chatTime + '</div>' + 
					'</td>' +
					'</tr>')
		}
		
		function getInfiniteBox(){
			setInterval(function(){
				chatBoxFunction();
			},3000)
		}
	</script>
	<div class="container">
		<table  class="table" style="margin:0 auto;">
			<thead>
				<tr>
					<th><h4>주고받은 메시지 목록</h4></th>
				</tr>
			</thead>
			<div style="overflow-y:auto; width:100%; max-height:450px;">
				<table class="table table-bordered table-hover" style="text-align:center; border:1px solid #dddddd; margin:0 auto;">
					<tbody id="boxTable">
					
					</tbody>
				</table>
			</div>
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
	<% if(userID!=null){ %>
	<script>
	$(document).ready(function(){
		
		chatBoxFunction();
		getInfiniteBox();
	});
	</script>
	<%} %>
	
</body>
</html>