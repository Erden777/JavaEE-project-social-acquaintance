package servlets;

import db.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet( "/AddMessage")
public class AddMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User currentUser = (User)request.getSession().getAttribute("CURRENT_USER");
        String redirect = "/";
        if (currentUser != null) {
            int id = Integer.parseInt(request.getParameter("userId"));
            Chat chat = db.getChatbyOppId(  id ,currentUser.getId());
            String messages = request.getParameter("message");
            Message message = new Message(db.getUserId(id), currentUser, messages, false);
            if (chat != null) {
                message.setChat(chat);
                chat.setLatest_message_text(messages);
                db.updateChat(chat);
                if (db.addMessage(message)) {
                    if (request.getParameter("chatId")!=null) {
                        redirect ="dialog?chatId="+request.getParameter("chatId");
                    }
                    else {
                        redirect = "Myfriend?success";
                    }
                }
            } else if (chat == null) {
                chat = new Chat();
                User user = db.getUserId(id);
                chat.setUser(currentUser);
                chat.setOpponent(user);
                chat.setLatest_message_text(messages);
                if(db.addChats(chat)){
                    message.setChat(db.getChatbyOppId(id , currentUser.getId() ));
                    System.out.println(message.getChat().getId());
                    db.addMessage(message);
                    redirect= "Myfriend?success";
                }
            }
            response.sendRedirect(redirect);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
