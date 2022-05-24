package com.bridgelabz;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class EmployeePayrollService {
    Scanner consoleInputReader = new Scanner(System.in);
    private List<EmployeePayrollData> employeePayrollList;
    public EmployeePayrollService(ArrayList<EmployeePayrollData> employeePayrollList) {
        this.employeePayrollList = employeePayrollList;
    }
    public void readEmployeePayrollData(){
        System.out.println("Enter Employee ID.: ");
        int id = consoleInputReader.nextInt();
        System.out.println("Enter Employee name: ");
        String name = consoleInputReader.next();
        System.out.println("Enter Employee salary: ");
        double salary = consoleInputReader.nextDouble();
        employeePayrollList.add(new EmployeePayrollData(id, name, salary));
    }
    public void writeEmployeePayrollData(){
        System.out.println("\nWriting Employee Payroll Data to console: \n"+employeePayrollList);
    }
    public static void main(String[] args) {
        System.out.println("Welcome to Employee Payroll Service System.");
        ArrayList<EmployeePayrollData> employeePayrollList = new ArrayList<>();
        EmployeePayrollService employeePayrollService = new EmployeePayrollService(employeePayrollList);
        employeePayrollService.readEmployeePayrollData();
        employeePayrollService.writeEmployeePayrollData();
    }
}
