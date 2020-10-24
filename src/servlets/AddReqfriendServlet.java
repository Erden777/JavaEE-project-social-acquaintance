package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

import db.db;
import db.User;

@WebServlet("/addrequest")
public class AddReqfriendServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("CURRENT_USER") != null) {
            User user =(User)request.getSession().getAttribute("CURRENT_USER");
            ArrayList<User> users = new ArrayList<>();
            if(request.getParameter("search")!=null) {
                users = db.getSearchUsers(request.getParameter("search"));
            }
            if(request.getParameter("userid")!=null){
                if(db.addfriendsRequests(user.getId() , Integer.parseInt(request.getParameter("userid")))){
                    request.setAttribute("users" , users);
                    request.getRequestDispatcher("friendsPage.jsp").forward(request,response);
                }
            }
        }
        else{
            response.sendRedirect("/");
        }
    }
}
