package db;

import java.sql.*;
import java.util.ArrayList;
import java.util.concurrent.ExecutionException;

public class db {
    public static Connection connection;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aralasukz?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static Boolean adduser(User u){
        int rows = 0;
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "INSERT INTO users(id , email, password, full_name, birth_date,picture_url)"+
                    " VALUES (null  ,? ,?, ? ,?,?)");
            statement.setString(1 ,u.getEmail());
            statement.setString(2, u.getPassword());
            statement.setString(3 , u.getFull_name());
            statement.setString(4 , u.getBirth_date());
            statement.setString(5 , u.getPicture_url());
            rows = statement.executeUpdate();
            statement.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static User getUser(String email, String password) {
        User u = null;
        try {
            PreparedStatement statement = connection.prepareStatement(" "+
                    "SELECT id , full_name , birth_date , picture_url FROM users " +
                    "WHERE email=? and password=? LIMIT 1");
            statement.setString(1 , email);
            statement.setString(2 , password);
            ResultSet rs = statement.executeQuery();
            if(rs.next()){
                u = new User(rs.getInt("id") , email , password , rs.getString("full_name") ,
                        rs.getString("birth_date") , rs.getString("picture_url"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    public static User getUserId(int id) {
        User u = null;
        try {
            PreparedStatement statement = connection.prepareStatement(" "+
                    "SELECT id , full_name , email, password, birth_date , picture_url FROM users " +
                    "WHERE id= ? LIMIT 1");
            statement.setInt(1 , id);

            ResultSet rs = statement.executeQuery();
            if(rs.next()){
                u = new User(id , rs.getString("email") , rs.getString("password") , rs.getString("full_name") ,
                        rs.getString("birth_date") , rs.getString("picture_url"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }


    public static ArrayList<User> getAlluser() {
        ArrayList<User> users = new ArrayList<>();
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "SELECT * FROM users"
            );
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                users.add(new User(rs.getInt("id"), rs.getString("email"),
                        rs.getString("password"), rs.getString("full_name"),
                        rs.getString("birth_date"), rs.getString("picture_url")));

            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    public static ArrayList<Friend> getCurrUserfriends(User user){
        ArrayList<Friend> friends = new ArrayList<>();
        try {
            PreparedStatement statement = connection.prepareStatement(" "+
                    "SELECT * FROM friends WHERE user_id=?");
            statement.setInt(1 , user.getId());
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                friends.add(new Friend(rs.getInt("id") , user , getUserId(rs.getInt("friend_id")) , rs.getString("added_time")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return friends;
    }



    public static ArrayList<User> getSearchUsers(String name) {
        ArrayList<User> users = new ArrayList<>();
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "SELECT * FROM users WHERE full_name LIKE ?");
            statement.setString(1, "%" + name + "%");
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                users.add(new User(rs.getInt("id"), rs.getString("email"),
                        rs.getString("password"), rs.getString("full_name"),
                        rs.getString("birth_date"), rs.getString("picture_url")));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }
    public static boolean updateprofile(User u){
        int rows = 0;
        try {
            PreparedStatement statement = connection.prepareStatement(" "+
                    "UPDATE users SET full_name=? , birth_date= ? WHERE id=?");

        statement.setString(1  ,u.getFull_name());
        statement.setString(2  , u.getBirth_date());
        statement.setInt(3 , u.getId());
        rows = statement.executeUpdate();
        statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rows>0;
    }

    public static boolean updatePicture( int id , String picture_url){
       int rows = 0;
        try {
            PreparedStatement statement = connection.prepareStatement(" " +
                    "UPDATE users SET picture_url=? WHERE id=?");
            statement.setString(1, picture_url);
            statement.setInt(2, id);
            rows = statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rows>0;
    }
    public static boolean updatePassword(String password , int id){
        int rows = 0;
        try{
            PreparedStatement statement = connection.prepareStatement("" +
                    "UPDATE  users SET password=? WHERE id=?");
            statement.setString(1, password);
            statement.setInt(2, id);
            rows = statement.executeUpdate();
            statement.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();

        }
        return rows>0;
    }

    public static boolean addpost(Post post) {
        int rows= 0;
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "INSERT INTO posts (id , author_id, short_content, content, title) " +
                    "VALUES (null , ? , ?,?,?)");
            statement.setInt(1, post.getUser().getId());

            statement.setString(2, post.getShort_content());
            statement.setString(3, post.getContent());
            statement.setString(4, post.getTitle());
            rows = statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rows>0;
    }

    public static ArrayList<Post> getAllpost() {
        ArrayList<Post> posts = new ArrayList<>();
        try{
            PreparedStatement statement = connection.prepareStatement(""+
                    "SELECT p.id , p.title , p.short_content , p.content, p.post_date , p.author_id AS author_id , u.email , u.birth_date , u.full_name , u.password, u.picture_url " +
                    "FROM posts p " +
                    "INNER JOIN users u ON p.author_id = u.id "+
                    "ORDER BY post_date desc");
            ResultSet rs= statement.executeQuery();
            while (rs.next()) {
                posts.add(new Post(rs.getInt("id") , rs.getString("title") , rs.getString("short_content") , rs.getString("content") , rs.getString("post_date") ,
                        new User(rs.getInt("author_id") , rs.getString("email") , rs.getString("password") , rs.getString("full_name") , rs.getString("birth_date") , rs.getString("picture_url"))));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return posts;
    }

    public static ArrayList<Post> getPostForid(User user) {
        ArrayList<Post> posts = new ArrayList<>();
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "SELECT id , title , short_content , content , post_date FROM posts WHERE author_id=?"+
                    " ORDER BY post_date desc");
            statement.setInt(1, user.getId());
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                posts.add(
                  new Post(rs.getInt("id") , rs.getString("title"),rs.getString("short_content") , rs.getString("content"),
                  rs.getString("post_date") ,user)
                );
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return posts;
    }

    public static boolean updatePost(Post post) {
        int rows = 0;
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "UPDATE posts SET title =?, short_content=? , content=?, post_date=null WHERE id=? ");
            statement.setString(1, post.getTitle());
            statement.setString(2, post.getShort_content());
            statement.setString(3, post.getContent());
            statement.setInt(4, post.getId());
            rows = statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rows>0;
    }


    public static boolean deletePost(int id) {
        int rows =0;
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "DELETE FROM posts WHERE id=?");
            statement.setInt(1, id);
            rows = statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rows>0;
    }

    public static boolean addFriend(int user_id, int friend_id) {
        int rows = 0;
        try {
            PreparedStatement statement= connection.prepareStatement(""+
                    "INSERT INTO friends(id , user_id , friend_id , added_time) "+
                    "VALUES (null , ? , ? , NOW())");
            statement.setInt(1, user_id);
            statement.setInt(2, friend_id);
            rows = statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rows>0;
    }

    public static boolean addfriendsRequests(int user_id, int sender_id) {
        int rows= 0;
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "INSERT INTO friends_requests(id ,user_id , request_sender_id , sent_time ) "+
                    "VALUES (null  , ? , ? ,NOW())"
            );
            statement.setInt(1 , user_id);
            statement.setInt(2 , sender_id);
            rows = statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rows >0;
    }
    public static boolean deletefriends(int user_id , int friend_id){
        int rows = 0;
        try{
            PreparedStatement statement = connection.prepareStatement("" +
                    "DELETE FROM friends WHERE user_id = ? and friend_id = ?"
            );
            statement.setInt(1, user_id);
            statement.setInt(2, friend_id);
            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }


    public static boolean deletefriendsRequests(int id){
        int rows = 0;
        try{
            PreparedStatement statement = connection.prepareStatement("" +
                    "DELETE FROM friends_requests WHERE id = ?"
            );
            statement.setInt(1, id);
            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static boolean deletefriendsRequests(int user_id , int sender_id){
        int rows = 0;
        try{
            PreparedStatement statement = connection.prepareStatement("" +
                    "DELETE FROM friends_requests WHERE user_id = ? and request_sender_id=?"
            );
            statement.setInt(1, user_id);
            statement.setInt(2 , sender_id);
            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static ArrayList<Request> getAllrequests() {
        ArrayList<Request> requests = new ArrayList<>();
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "SELECT * FROM friends_requests"
            );
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                requests.add(new Request(rs.getInt("id"), db.getUserId(Integer.parseInt(rs.getString("user_id"))), db.getUserId(Integer.parseInt(rs.getString("request_sender_id"))) , rs.getString("sent_time")));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  requests;
    }

    public static ArrayList<Request> getrequestsUserid(User user) {
        ArrayList<Request> requests = new ArrayList<>();
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "SELECT * FROM friends_requests WHERE request_sender_id=?"
            );
            statement.setInt(1 , user.getId());
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                requests.add(new Request(rs.getInt("id"), db.getUserId(Integer.parseInt(rs.getString("user_id"))), db.getUserId(Integer.parseInt(rs.getString("request_sender_id"))) , rs.getString("sent_time")));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  requests;
    }

    public static ArrayList<Request> getrequestsUseridCurr(User user) {
        ArrayList<Request> requests = new ArrayList<>();
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "SELECT * FROM friends_requests WHERE user_id=?"
            );
            statement.setInt(1 , user.getId());
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                requests.add(new Request(rs.getInt("id"), db.getUserId(Integer.parseInt(rs.getString("user_id"))), db.getUserId(Integer.parseInt(rs.getString("request_sender_id"))) , rs.getString("sent_time")));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  requests;
    }


    public static ArrayList<Friend> getFriedforId(User user) {
        ArrayList<Friend> friends = new ArrayList<>();
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "SELECT * FROM friends WHERE user_id=?"
            );
            statement.setInt(1 , user.getId());
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                friends.add(new Friend(rs.getInt("id"), db.getUserId(Integer.parseInt(rs.getString("user_id"))), db.getUserId(Integer.parseInt(rs.getString("friend_id"))) , rs.getString("added_time")));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  friends;
    }

    public static boolean addChats(Chat chats) {
        int rows = 0;

        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "INSERT INTO chats (id, user_id, opponenet_user_id, created_time, latest_messege_text, latest_message_time) " +
                    "VALUES (NULL,?,?, NOW(),?,NOW())");

            statement.setLong(1,chats.getUser().getId());
            statement.setLong(2,chats.getOpponent().getId());
            statement.setString(3,chats.getLatest_message_text());
            rows = statement.executeUpdate();

            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static Chat getChatbyOppId(int opp_id, int currentuser_id) {
        Chat chat = null;
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "SELECT id , user_id , opponenet_user_id , created_time , latest_message_time , latest_messege_text FROM chats WHERE " +
                    " (opponenet_user_id=? and user_id=?) OR (user_id=? and opponenet_user_id=?)");
            statement.setInt(1, opp_id);
            statement.setInt(2, currentuser_id);
            statement.setInt(3, opp_id);
            statement.setInt(4, currentuser_id);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                chat = new Chat(rs.getInt("id") ,
                        db.getUserId(rs.getInt("user_id")) ,
                        db.getUserId(rs.getInt("opponenet_user_id")),
                        rs.getString("created_time"),
                        rs.getString("latest_messege_text")  ,
                        rs.getString("latest_message_time"));
            }
            statement.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return chat;
    }


    public static ArrayList<Chat> getmyChats(User user) {
        ArrayList<Chat> chats = new ArrayList<Chat>();
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "SELECT id , user_id , opponenet_user_id , created_time , latest_message_time , latest_messege_text FROM chats WHERE " +
                    "user_id=? OR  opponenet_user_id=? ORDER BY latest_message_time desc");

            statement.setInt(1, user.getId());
            statement.setInt(2, user.getId());

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                if(user.getId()!=rs.getInt("opponenet_user_id")) {
                    chats.add(new Chat(rs.getInt("id"),
                            db.getUserId(rs.getInt("user_id")),
                            db.getUserId(rs.getInt("opponenet_user_id")),
                            rs.getString("created_time"),
                            rs.getString("latest_messege_text"),
                            rs.getString("latest_message_time")));
                }
                else {
                    chats.add(new Chat(rs.getInt("id"),
                            db.getUserId(rs.getInt("opponenet_user_id")),
                            db.getUserId(rs.getInt("user_id")),
                            rs.getString("created_time"),
                            rs.getString("latest_messege_text"),
                            rs.getString("latest_message_time")));
                }
            }
            statement.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return chats;
    }

    public static Chat getChat(int id) {
        Chat chat = null;
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "SELECT id , user_id , opponenet_user_id , created_time , latest_message_time , latest_messege_text " +
                    "FROM chats " +
                    "WHERE id=? ");

            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                    chat = new Chat(rs.getInt("id"),
                            db.getUserId(rs.getInt("user_id")),
                            db.getUserId(rs.getInt("opponenet_user_id")),
                            rs.getString("created_time"),
                            rs.getString("latest_messege_text"),
                            rs.getString("latest_message_time"));
            }
            statement.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    return chat;
    }

    public static ArrayList<Message> getMessageForChatId(int id) {
        ArrayList<Message> messages = new ArrayList<Message>();
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    " SELECT * FROM messages WHERE chat_id=? ");
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                messages.add(new Message(rs.getInt("id"),
                        getChat(id),
                        getUserId(rs.getInt("user_id")),
                        getUserId(rs.getInt("sender_id")),
                        rs.getString("message_text"),
                        rs.getBoolean("read_by_receiver"),
                        rs.getString("sent_date")));
            }
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return messages;
    }


    public static ArrayList<Message> getOnlyNewMessage(User user) {
        ArrayList<Message> messages = new ArrayList<Message>();
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    " SELECT * FROM messages WHERE user_id=? and read_by_receiver=? ");
            statement.setInt(1, user.getId());
            statement.setBoolean(2 , false);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                messages.add(new Message(rs.getInt("id"),
                        getChat(rs.getInt("chat_id")),
                        getUserId(rs.getInt("user_id")),
                        getUserId(rs.getInt("sender_id")),
                        rs.getString("message_text"),
                        rs.getBoolean("read_by_receiver"),
                        rs.getString("sent_date")));
            }
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return messages;
    }


    public static boolean addMessage(Message messages){
        int rows = 0;

        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "INSERT INTO messages (id, chat_id, user_id, sender_id, message_text, read_by_receiver, sent_date) " +
                    "VALUES (NULL,?,?,?,?,?, NOW())");

            statement.setLong(1,messages.getChat().getId());
            statement.setLong(2,messages.getUser().getId());
            statement.setLong(3,messages.getSender_user().getId());
            statement.setString(4,messages.getMessage_text());
            statement.setBoolean(5,messages.getRead_by_receiver());
            rows = statement.executeUpdate();

            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static void readed(Message message) {
        try {
            PreparedStatement statement = connection.prepareStatement(" " +
                    "UPDATE messages SET read_by_receiver=? WHERE id=?");
            statement.setBoolean(1 , true);
            statement.setInt(2 , message.getId());
            statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    public static boolean updateChat(Chat chat){
        int rows = 0;
        try {
            PreparedStatement statement = connection.prepareStatement(" "+
                    "UPDATE chats SET latest_messege_text=? , latest_message_time=NOW() WHERE id=?");

            statement.setString(1  ,chat.getLatest_message_text());
            statement.setInt(2  , chat.getId());

            rows = statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rows>0;
    }
}
