package starter.data;

public class User {
    String email = "2006147@itg.ac.id";
    String password = "test123";
    String registPassword = "testqe123";
//    String fullname;
//    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJGdWxsbmFtZSI6IkFydWwgQnVkaSBLYWxpbWF0IiwiRW1haWwiOiJhcnVsYmVrYTI1QGdtYWlsLmNvbSJ9.NtJJUFo0ssUYUjmWU188jec4qco6BB39qatQyDTmrE8";
    String otp = "946189";

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    public String getRegistPassword() {
        return registPassword;
    }

    public void setRegistPassword(String registPassword) {
        this.registPassword = registPassword;
    }
//    public String getToken() {
//        return token;
//    }

//    public void setToken(String token) {
//        this.token = token;
//    }


    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

//    public String getFullname() {
//        return fullname;
//    }
//
//    public void setFullname(String fullname) {
//        this.fullname = fullname;
//    }

}


