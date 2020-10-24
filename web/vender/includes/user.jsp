<%@ page import="db.User" %>
<%@ page import="db.Message" %>
<%@ page import="db.db" %>
<% User userOnline = (User) session.getAttribute("CURRENT_USER");

    int newMessage =4;
    Boolean ONLINE = false;

    if(userOnline!=null) {
        int messages =db.getOnlyNewMessage(userOnline).size();
        System.out.println(messages);
        ONLINE = true;
        newMessage = messages;
    }
    %>