package servlets;

import db.User;
import db.db;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String fname = request.getParameter("fullname");
        String date = request.getParameter("date");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");
        String picture_url = "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT8tKhcp9CBPQyd55zxA0kX9xhACw7PXGUViQ&usqp=CAU";
        if(!password.equals(repassword)){
            response.sendRedirect("/?"+"&error");
        }
        else{
            User user = new User( email, password , fname , date , picture_url);
            if(db.adduser(user)){
                request.getSession().setAttribute("CURRENT_USER" , db.getUser(email , password));
                response.sendRedirect("/home?success");
            }
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}
