package servlets;

import db.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UserEdit")
public class UserEditServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("CURRENT_USER")!=null){
            User user = (User) request.getSession().getAttribute("CURRENT_USER");
            String redirect = "/";
            if(request.getParameter("reject")!=null){
                db.deletefriendsRequests(Integer.parseInt(request.getParameter("reject")));
                redirect="User?uid="+request.getParameter("uid");
            }
            else if(request.getParameter("confirm")!=null){
                String user_id = request.getParameter("confirm");
                db.addFriend(user.getId(),Integer.parseInt(user_id));
                db.addFriend(Integer.parseInt(user_id) , user.getId());
                db.deletefriendsRequests(user.getId() , Integer.parseInt(user_id));
                redirect="User?uid="+user_id;
            }
            else if (request.getParameter("remove") != null) {
                db.deletefriends(user.getId(), Integer.parseInt(request.getParameter("remove")));
                db.deletefriends( Integer.parseInt(request.getParameter("remove")) ,user.getId());
                redirect="User?uid="+request.getParameter("remove");
            } else if (request.getParameter("addfriend") != null) {
                db.addfriendsRequests(Integer.parseInt(request.getParameter("addfriend")), user.getId());
                redirect="User?uid="+request.getParameter("addfriend");
            } else if (request.getParameter("request_id") != null) {
                String request_id = request.getParameter("request_id");
                db.deletefriendsRequests(Integer.parseInt(request_id));
                redirect="User?uid="+request.getParameter("uid");
            }
            response.sendRedirect(redirect);
        }

    }
}
