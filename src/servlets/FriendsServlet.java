package servlets;

import db.db;
import db.User;
import db.Request;
import db.Friend;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/friends")
public class FriendsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("CURRENT_USER") != null) {
            User user =(User)request.getSession().getAttribute("CURRENT_USER");
            String search="";
            String redirect="/";
            if(request.getParameter("search")!=null) {
                search = request.getParameter("search");
            }

            if(request.getParameter("reject")!=null){
                db.deletefriendsRequests(Integer.parseInt(request.getParameter("reject")));
              redirect="Myfriend";
            }
            else if(request.getParameter("confirm")!=null){
                db.addFriend(user.getId(),Integer.parseInt(request.getParameter("confirm")));
                db.addFriend(Integer.parseInt(request.getParameter("confirm")) , user.getId());
                db.deletefriendsRequests(Integer.parseInt(request.getParameter("request_id")));
                redirect="Myfriend";
            }



            if(request.getParameter("sended")!=null){
                    db.deletefriendsRequests(Integer.parseInt(request.getParameter("reqId")));
                    System.out.println("delete");
                    redirect ="friends?&search="+search;
            }
            else if(request.getParameter("addreq")!=null) {
                 db.addfriendsRequests( Integer.parseInt(request.getParameter("userid")) , user.getId());
                     System.out.println("added");
                     redirect="friends?&search="+search;
            }

            response.sendRedirect(redirect);
        }


        else{
            response.sendRedirect("/");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("CURRENT_USER")!=null) {
            ArrayList<User> users = new ArrayList<>();
            if(request.getParameter("search")!=null) {
                users = db.getSearchUsers(request.getParameter("search"));
            }
            ArrayList<Friend> friends = db.getFriedforId((User)request.getSession().getAttribute("CURRENT_USER"));
            ArrayList<Request> requests = db.getrequestsUserid((User)request.getSession().getAttribute("CURRENT_USER"));
            requests.addAll(db.getrequestsUseridCurr((User)request.getSession().getAttribute("CURRENT_USER")));
            request.setAttribute("requests" , requests);
            request.setAttribute("friends" , friends);
            request.setAttribute("users" , users);
            request.getRequestDispatcher("SearchPage.jsp").forward(request,response);
        }else{
            response.sendRedirect("/");
        }
    }
}
