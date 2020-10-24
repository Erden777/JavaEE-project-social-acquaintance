package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

import db.*;

@WebServlet("/User")
public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("CURRENT_USER")!=null){
            if (request.getParameter("uid") != null) {
                User user = db.getUserId(Integer.parseInt(request.getParameter("uid")));
                ArrayList<Post> posts = db.getPostForid(user);
                ArrayList<Friend> friends = db.getFriedforId((User)request.getSession().getAttribute("CURRENT_USER"));
                ArrayList<Request> requests = db.getrequestsUserid((User)request.getSession().getAttribute("CURRENT_USER"));
                requests.addAll(db.getrequestsUseridCurr((User)request.getSession().getAttribute("CURRENT_USER")));
                request.setAttribute("requests" , requests);
                request.setAttribute("user" , user);
                request.setAttribute("friends" , friends);
                request.setAttribute("posts"  , posts);
                request.getRequestDispatcher("userpage.jsp").forward(request,response);
            }
        }else{
            response.sendRedirect("/");
        }
    }
}
