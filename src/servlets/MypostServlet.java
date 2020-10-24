package servlets;

import db.Post;
import db.db;
import db.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/mypost")
public class MypostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("CURRENT_USER")!=null) {
            User user =(User) session.getAttribute("CURRENT_USER");
            ArrayList<Post> posts = db.getPostForid(user);
            request.setAttribute("posts" , posts);
            request.getRequestDispatcher("mypost.jsp").forward(request , response);
        }
        else{
            response.sendRedirect("/");
        }

    }
}
