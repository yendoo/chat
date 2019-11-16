<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<script>

setInterval("dpTime()",1000);

function dpTime(){
   var now = new Date();
    var hours = now.getHours();
    var minutes = now.getMinutes();
    var seconds = now.getSeconds();
	var year = now.getFullYear();
	var month = now.getMonth()+1;
	var day = now.getDay();
	var aday = new Array('일요일','월요일','화요일','수요일','목요일','금요일','토요일');

    if (hours > 12){
        hours -= 12;
    ampm = "PM ";
    }else{
        ampm = "AM ";
    }
    if (hours < 10){
        hours = "0" + hours;
    }
    if (minutes < 10){
        minutes = "0" + minutes;
    }
    if (seconds < 10){
        seconds = "0" + seconds;
    }
    
	document.getElementById("hour").innerHTML = hours +":";
	document.getElementById("min").innerHTML = minutes;
	document.getElementById("ampm").innerHTML = ampm;
	document.getElementById("seconds").innerHTML = seconds;
	document.getElementById("year").innerHTML = year +'년 ' +  month +'월 '+ now.getDate() + '일 ' +  aday[now.getDay()];

	}

</script>
<div style="
		height:925px;
        background-image: url( './images/back.jpg' );
        background-repeat: no-repeat;
        background-position: center center;
        background-size: cover;">
<div  id="timeBox">
 <div id="timeMain">
<span id="hour"></span>
<span id="min"></span>
</div>
<div id="timeSub">
<div id="ampm"></div>
<div id="seconds"></div>
</div>
</div>
<div id="year"></div>
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
 		<%= messageContent %><br>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
      </div>
    </div><!-- /.modal-content -->
    </div>
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</div><!-- /.back -->
	<script>
		$('#messageModal').modal("show");
	</script>
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
			}
	%>
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