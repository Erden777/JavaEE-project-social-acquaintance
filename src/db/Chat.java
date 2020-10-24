package db;

public class Chat {
    private int id;
    private User user;
    private User opponent;
    private String created_time;
    private String latest_message_text;
    private String lates_message_time;

    public Chat(int id, User user, User opponent, String created_time, String latest_message_text, String lates_message_time) {
        this.id = id;
        this.user = user;
        this.opponent = opponent;
        this.created_time = created_time;
        this.latest_message_text = latest_message_text;
        this.lates_message_time = lates_message_time;
    }

    public Chat() {
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

    public User getOpponent() {
        return opponent;
    }

    public void setOpponent(User opponent) {
        this.opponent = opponent;
    }

    public String getCreated_time() {
        return created_time;
    }

    public void setCreated_time(String created_time) {
        this.created_time = created_time;
    }

    public String getLatest_message_text() {
        return latest_message_text;
    }

    public void setLatest_message_text(String latest_message_text) {
        this.latest_message_text = latest_message_text;
    }

    public String getLates_message_time() {
        return lates_message_time;
    }

    public void setLates_message_time(String lates_message_time) {
        this.lates_message_time = lates_message_time;
    }
}
