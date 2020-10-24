package servlets;

import db.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/Myfriend")
public class MyfriendServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("CURRENT_USER")!=null) {
            ArrayList<Friend> users = new ArrayList<>();
            users = db.getCurrUserfriends((User)request.getSession().getAttribute("CURRENT_USER"));
            ArrayList<Request> req_user = db.getrequestsUseridCurr((User)request.getSession().getAttribute("CURRENT_USER"));
            request.setAttribute("requests" , req_user);
            request.setAttribute("friends" , users);
            request.getRequestDispatcher("friendsPage.jsp").forward(request,response);
        }else{
            response.sendRedirect("/");
        }
    }
}
