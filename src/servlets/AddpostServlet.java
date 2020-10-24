package servlets;

import db.Post;
import db.User;
import db.db;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/addpost")
public class AddpostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        request.setCharacterEncoding("UTF-8");
        Post p = new Post();
        if (session.getAttribute("CURRENT_USER") != null) {
            String title = request.getParameter("title");
            String short_content = request.getParameter("short_content");
            String content = request.getParameter("content");
            p.setContent(content);
            p.setShort_content(short_content);
            p.setTitle(title);
            p.setUser((User) session.getAttribute("CURRENT_USER"));
            if (db.addpost(p)) {
                response.sendRedirect("/home?"+"success");
            }

        }else{
            response.sendRedirect("/");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
