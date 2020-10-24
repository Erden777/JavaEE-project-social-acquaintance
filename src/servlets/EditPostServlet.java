package servlets;

import db.User;
import db.db;
import db.Post;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/editpost")
public class EditPostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String redirect="";
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("CURRENT_USER");

        if (user != null) {
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String short_content = request.getParameter("short_content");
            int id = Integer.parseInt(request.getParameter("id"));
            Post p = new Post();
            p.setId(id);
            p.setUser(user);
            p.setTitle(title);
            p.setShort_content(short_content);
            p.setContent(content);

            if (db.updatePost(p)) {
                redirect = "&successEdit";
            } else {
                redirect = "&error";
            }
        }
        response.sendRedirect("/mypost?"+redirect);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
