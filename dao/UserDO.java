package dao;

public class UserDO {
    private String id, name, phone, upw;  // upw 추가

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getUpw() {  // upw getter 추가
        return upw;
    }
    public void setUpw(String upw) {  // upw setter 추가
        this.upw = upw;
    }

    // 기존 생성자
    public UserDO(String id, String name, String phone) {
        this.id = id;
        this.name = name;
        this.phone = phone;
    }

    // 새로운 생성자
    public UserDO(String id, String name, String phone, String upw) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.upw = upw;
    }
}