package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class UserSignUpModel {
    public int signup(String email, String userName, String password) {
        try (
                Connection connection = 
//                        DriverManager.getConnection("jdbc:sqlserver://localhost\\SQLEXPRESS;database=InternetForum;"
//                        + "encrypt=true;trustServerCertificate=true;"
//                        + "integratedSecurity=false;user=sa;password=1234;");
                        DriverManager.getConnection("jdbc:sqlserver://localhost;database=InternetForum;"
                                + "encrypt=true;trustServerCertificate=true;"
                                + "integratedSecurity=false;user=sa;password=Password.1;");
                
                ){
            
            String signUpSql = 
                    "INSERT INTO [user] (user_name, mail_address, hashed_password, registration_date) VALUES(?, ?, ?, GETDATE())";
            PreparedStatement statement = connection.prepareStatement(signUpSql);
            HashPasswordUtil util = new HashPasswordUtil();
            statement.setString(1, userName);
            statement.setString(2, email);
            statement.setString(3, util.create(password));
            return statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
