package com.bridgelabz;

import java.io.Reader;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class EmployeePayrollDBService {
    private Connection getConnection() throws SQLException {
        String jdbcURL = "jdbc:mysql://localhost:3306/payroll_service?useSSL=false";
        String userName = "root";
        String password = "admin";
        Connection con;
        System.out.println("Connecting to database: "+jdbcURL);
        con = DriverManager.getConnection(jdbcURL, userName, password);
        System.out.println("Connection is successful!!"+ con);
        return con;
    }
    public List<EmployeePayrollData> readData() {
        String sql = "SELECT * FROM employee;";
        List<EmployeePayrollData> employeePayrollList = new ArrayList<>();
        try (Connection connection = this.getConnection()){
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            while (resultSet.next()){
                int empId = resultSet.getInt("emp_id");
                String name = resultSet.getString("name");
                String phoneNo = resultSet.getString("phone_no");
                String address = resultSet.getString("address");
                String gender = resultSet.getString("gender");
                int companyId = resultSet.getInt("company_id");
                LocalDate startDate = resultSet.getDate("start_date").toLocalDate();
                employeePayrollList.add(new EmployeePayrollData(empId, name, phoneNo,
                        address, gender, companyId,startDate));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employeePayrollList;
    }
}
