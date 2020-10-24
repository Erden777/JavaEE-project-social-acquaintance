package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

import db.*;

@WebServlet("/message")
public class MessagesServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User currentUser =(User) request.getSession().getAttribute("CURRENT_USER");
        if (currentUser != null) {
            ArrayList<Chat> chats = db.getmyChats(currentUser);
            ArrayList<Message> messages = db.getOnlyNewMessage(currentUser);
            request.setAttribute("newMessages", messages);
            request.setAttribute("chats" , chats);
            request.getRequestDispatcher("chat.jsp").forward(request , response);
        } else {
            response.sendRedirect("/");
        }
    }
}
