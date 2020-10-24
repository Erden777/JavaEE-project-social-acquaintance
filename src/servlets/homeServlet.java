package servlets;

import db.db;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;

import db.*;


@WebServlet(value = "/home")
public class homeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("CURRENT_USER")!=null) {
            User user =(User) session.getAttribute("CURRENT_USER");

            ArrayList<Post> posts = db.getAllpost();
            request.setAttribute("posts" , posts);

            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
        else{
            response.sendRedirect("/");
        }
    }
}
