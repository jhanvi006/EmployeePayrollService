package com.bridgelabz;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

public class EmployeePayrollFileIOService {
    public static String PAYROLL_FILE_NAME = "payroll.txt";

    public static void readData() {
        try {
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream(PAYROLL_FILE_NAME)));
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                System.out.println(line);
            }
            bufferedReader.close();
        } catch (IOException e) {
            System.out.println("ERROR: unable to read file " + PAYROLL_FILE_NAME);
            e.printStackTrace();
        }
        return;
    }

    public static void writeData(List<EmployeePayrollData> employeePayrollDataList){
        StringBuffer buffer = new StringBuffer();
        employeePayrollDataList.forEach(employee -> {
            String employeeDataString = employee.toString().concat("\n");
            buffer.append(employeeDataString);
        });
        try {
            Files.write(Paths.get(PAYROLL_FILE_NAME), buffer.toString().getBytes());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
