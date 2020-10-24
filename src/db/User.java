package db;

public class User {
    private int  id;
    private String email;
    private String password;
    private String full_name;
    private String birth_date;
    private String picture_url;

    public User() {
    }

    public User(String email, String password, String full_name, String birth_date, String picture_url) {
        this.email = email;
        this.password = password;
        this.full_name = full_name;
        this.birth_date = birth_date;
        this.picture_url = picture_url;
    }

    public User(int id, String email, String password, String full_name, String birth_date, String picture_url) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.full_name = full_name;
        this.birth_date = birth_date;
        this.picture_url = picture_url;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", full_name='" + full_name + '\'' +
                '}';
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public String getBirth_date() {
        return birth_date;
    }

    public void setBirth_date(String birth_date) {
        this.birth_date = birth_date;
    }

    public String getPicture_url() {
        return picture_url;
    }

    public void setPicture_url(String picture_url) {
        this.picture_url = picture_url;
    }
}
