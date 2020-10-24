package servlets;
import db.db;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;

import db.* ;

@WebServlet(value = "/signin")
public class SigninServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String check = request.getParameter("remember");
        HttpSession session = request.getSession();
        ArrayList<Message> messages = new ArrayList<Message>();

        if (check != null) {
            Cookie emailCookie = new Cookie("email", email);
            Cookie passwordCookie = new Cookie("password", password);
            emailCookie.setMaxAge(30 * 24 * 60 * 60);
            passwordCookie.setMaxAge(30 * 24 * 60 * 60);
            response.addCookie(emailCookie);
            response.addCookie(passwordCookie);
        }
        if (db.getUser(email, password) != null) {
            User user = db.getUser(email, password);
            session.setAttribute("CURRENT_USER", user);
            response.sendRedirect("/home");
        }

        else{
            response.sendRedirect("/?&error");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie cookies[] = request.getCookies();
        String email = "";
        String password = "";
        HttpSession session = request.getSession();
        session.removeAttribute("CURRENT_USER");
        session.removeAttribute("messages");
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("email")) {
                    email = c.getValue();
                }
                if (c.getName().equals("password")) {
                    password = c.getValue();
                }
            }
        }

        request.setAttribute("password", password);
        request.setAttribute("email", email);
        request.getRequestDispatcher("/signin.jsp").forward(request, response);
    }
}
