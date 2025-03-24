package kr.co.soldesk.beans;


public class UserLikesBean {
    private int likes_index;
    private String id;
    private int item_index;
    private int openRecipe_index;
    private String likes_status;

   //생성자
    public UserLikesBean() {}

    public UserLikesBean(String id, int openRecipe_index) {
        this.id = id;
        this.openRecipe_index = openRecipe_index;
    }

    // Getters and Setters
    public int getLikes_index() {
        return likes_index;
    }

    public void setLikes_index(int likes_index) {
        this.likes_index = likes_index;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getItem_index() {
        return item_index;
    }

    public void setItem_index(int item_index) {
        this.item_index = item_index;
    }

    public int getOpenRecipe_index() {
        return openRecipe_index;
    }

    public void setOpenRecipe_index(int openRecipe_index) {
        this.openRecipe_index = openRecipe_index;
    }

    public String getLikes_status() {
        return likes_status;
    }

    public void setLikes_status(String likes_status) {
        this.likes_status = likes_status;
    }
}