package db;

public class Message {
    private int id;
    private Chat chat;
    private User user;
    private User sender_user;
    private String message_text;
    private Boolean read_by_receiver;
    private String sent_date;

    public Message() { }

    public Message(int id, Chat chat, User user, User sender_user, String message_text, Boolean read_by_receiver, String sent_date) {
        this.id = id;
        this.chat = chat;
        this.user = user;
        this.sender_user = sender_user;
        this.message_text = message_text;
        this.read_by_receiver = read_by_receiver;
        this.sent_date = sent_date;
    }
    public Message( Chat chat, User user, User sender_user, String message_text, Boolean read_by_receiver) {
        this.chat = chat;
        this.user = user;
        this.sender_user = sender_user;
        this.message_text = message_text;
        this.read_by_receiver = read_by_receiver;

    }
    public Message( User user, User sender_user, String message_text, Boolean read_by_receiver) {

        this.user = user;
        this.sender_user = sender_user;
        this.message_text = message_text;
        this.read_by_receiver = read_by_receiver;

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Chat getChat() {
        return chat;
    }

    public void setChat(Chat chat) {
        this.chat = chat;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getSender_user() {
        return sender_user;
    }

    public void setSender_user(User sender_user) {
        this.sender_user = sender_user;
    }

    public String getMessage_text() {
        return message_text;
    }

    public void setMessage_text(String message_text) {
        this.message_text = message_text;
    }

    public Boolean getRead_by_receiver() {
        return read_by_receiver;
    }

    public void setRead_by_receiver(Boolean read_by_receiver) {
        this.read_by_receiver = read_by_receiver;
    }

    public String getSent_date() {
        return sent_date;
    }

    public void setSent_date(String sent_date) {
        this.sent_date = sent_date;
    }
}
