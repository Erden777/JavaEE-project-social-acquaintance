package db;

public class Friend {
    private int id;
    private User user;
    private User friend;
    private String added_time;

    public Friend(int id, User user, User friend, String added_time) {
        this.id = id;
        this.user = user;
        this.friend = friend;
        this.added_time = added_time;
    }

    public Friend() {
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

    public User getFriend() {
        return friend;
    }

    public void setFriend(User friend) {
        this.friend = friend;
    }

    public String getAdded_time() {
        return added_time;
    }

    public void setAdded_time(String added_time) {
        this.added_time = added_time;
    }
}
