package db;
import db.User;

public class Request {
    private int id ;
    private User user;
    private User req_sender_user;
    private String sent_date;

    public Request() {
    }

    public Request(int id, User user, User req_sender_user, String sent_date) {
        this.id = id;
        this.user = user;
        this.req_sender_user = req_sender_user;
        this.sent_date = sent_date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getReq_sender_user() {
        return req_sender_user;
    }

    public void setReq_sender_user(User req_sender_user) {
        this.req_sender_user = req_sender_user;
    }

    public String getSent_date() {
        return sent_date;
    }

    public void setSent_date(String sent_date) {
        this.sent_date = sent_date;
    }
}
