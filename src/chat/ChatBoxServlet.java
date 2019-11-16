package chat;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/ChatBoxServlet")
public class ChatBoxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID");
		userID = URLDecoder.decode(userID, "UTF-8");
		if(userID == null || userID.equals("") ) {
			response.getWriter().write("");
		}else {
			HttpSession session = request.getSession();
			if(!userID.equals((String) session.getAttribute("userID"))) {
				response.getWriter().write("");
				return;
				
			}
			try {
				response.getWriter().write(getBox(userID));
			} catch (Exception e) {
				response.getWriter().write("");
			}
			
		}
		
		
	}

	
	public String getBox(String userID) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDAO chatDAO = new ChatDAO();
		
		ArrayList<ChatDTO> chatList = chatDAO.getBox(userID); 
		if(chatList.size() == 0) return "";
		for (int i = chatList.size() - 1; i >= 0; i--) {
			String unread = "";
			int getUnread = chatDAO.getUnreadChat(chatList.get(i).getFromID(), userID); // 안읽씹 메세지 갯수
			if(userID.equals(chatList.get(i).getToID())) {
			    unread = Integer.toString(getUnread);
				if(unread.equals("0")) unread = "";
				else if(unread.equals("-1")) unread = "";
			}
			result.append("[{\"value\": \"" + chatList.get(i).getFromID() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getToID() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"},");
			result.append("{\"value\": \"" + unread + "\"}]");
			if(i != 0) result.append(",");
		}
		result.append("], \"last\": \"" + chatList.get(chatList.size() - 1).getChatID() + "\"}");
		return result.toString();
	}

}
