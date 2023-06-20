package starter.data;

import java.util.Random;

public class Jabatan {
    public String forPosision(){
        Random random = new Random();

        String [] posision = {"PIC", "CS", "MANAGER", "DIREKTUR", "AKUNTAN"};
        return(posision[random.nextInt(posision.length)]);
    }

    public String forGender(){
        Random random = new Random();

        String [] gender = {"PRIA", "WANITA"};
        return(gender[random.nextInt(gender.length)]);
    }

}
