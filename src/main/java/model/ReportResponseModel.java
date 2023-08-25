package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class ReportResponseModel {
    public int report(int responseId) {
        try (
                Connection connection =
                        DriverManager.getConnection("jdbc:sqlserver://localhost;database=InternetForum;"
                                + "encrypt=true;trustServerCertificate=true;"
                                + "integratedSecurity=false;user=sa;password=Password.1;");
        ){
            // 返信の通報フラグを変更する
            String reportSql = 
                    "UPDATE [response] SET report = 1 WHERE response_id = ? ";
            PreparedStatement statement = connection.prepareStatement(reportSql);
            statement.setInt(1, responseId);
            int row = statement.executeUpdate();
            if (row == 0) {
                return 0;
            }
            connection.close();
            return row;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
