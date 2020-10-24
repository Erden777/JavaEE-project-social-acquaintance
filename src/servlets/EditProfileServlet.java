package servlets;

import db.User;
import db.db;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/edit")
public class EditProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String redirect="";
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("CURRENT_USER");
        if(request.getParameter("editProfile")!=null){

            String full_name = request.getParameter("full_name");
            String birth_date = request.getParameter("birth_date");
            User u = new User();
            u.setId(user.getId());
            u.setFull_name(full_name);
            u.setBirth_date(birth_date);
            if(db.updateprofile(u)){
                user.setFull_name(full_name);
                user.setBirth_date(birth_date);

                session.setAttribute("CURRENT_USER" , user);
                redirect="success";
            } else{
                redirect = "error";
            }
        }
        if(request.getParameter("editPicture")!=null){
            String picture_url = request.getParameter("picture_url");
            if (db.updatePicture(user.getId(), picture_url)) {
                user.setPicture_url(picture_url);
                session.setAttribute("CURRENT_USER" , user);
                redirect = "success";
            } else {
                redirect = "error";
            }
        }
        if(request.getParameter("editPassword")!=null){
            if(request.getParameter("OldPassword").equals(user.getPassword())){
                   if(request.getParameter("NewPassword").equals(request.getParameter("ReNewPassword"))){
                        String newPassword = request.getParameter("NewPassword");
                        if(db.updatePassword(newPassword ,user.getId())){
                            user.setPassword(newPassword);
                            session.setAttribute("CURRENT_USER" , user);
                        }
                        else{
                            redirect = "error";
                        }
                   } else {
                       redirect ="IncorrectnewPassword";
                   }
            } else{
                redirect = "Incorrectoldpassword";
            }
        }
        response.sendRedirect("/edit?"+redirect);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("CURRENT_USER")!=null) {
            request.getRequestDispatcher("editprofile.jsp").forward(request, response);
        }
        else{
            response.sendRedirect("/");
        }
    }
}
