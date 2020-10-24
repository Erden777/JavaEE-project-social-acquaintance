package servlets;

import db.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/dialog")
public class DialogServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User currentUser =(User) request.getSession().getAttribute("CURRENT_USER");
        if (currentUser != null) {
            int chatId = Integer.parseInt(request.getParameter("chatId"));
            ArrayList<Message> messages = db.getMessageForChatId(chatId);
            for (Message m : messages) {
                if(m.getSender_user().getId()!=currentUser.getId()) {
                    db.readed(m);
                }
            }
            request.setAttribute("messages" , messages);
            request.getRequestDispatcher("message.jsp").forward(request , response);
        } else {
            response.sendRedirect("/");
        }
    }
}
