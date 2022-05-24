package com.bridgelabz;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class EmployeePayrollService {
    Scanner consoleInputReader = new Scanner(System.in);
    public enum IOService{
        CONSOLE_IO, FILE_IO
    }
    private List<EmployeePayrollData> employeePayrollList;
    public EmployeePayrollService(ArrayList<EmployeePayrollData> employeePayrollList) {
        this.employeePayrollList = employeePayrollList;
    }
    public long readEmployeePayrollData(IOService ioService){
        if (ioService.equals(IOService.FILE_IO)) {
            EmployeePayrollFileIOService.readData();
        }
        else if (ioService.equals(IOService.CONSOLE_IO)){
            System.out.println("Enter Employee ID.: ");
            int id = consoleInputReader.nextInt();
            System.out.println("Enter Employee name: ");
            String name = consoleInputReader.next();
            System.out.println("Enter Employee salary: ");
            double salary = consoleInputReader.nextDouble();
            employeePayrollList.add(new EmployeePayrollData(id, name, salary));
        }
        return employeePayrollList.size();
    }
    public void writeEmployeePayrollData(IOService ioService){
        if (ioService.equals(IOService.CONSOLE_IO))
            System.out.println("\nWriting Employee Payroll Data to console: \n"+employeePayrollList);
        else
            EmployeePayrollFileIOService.writeData(employeePayrollList);
    }
    public static void main(String[] args) {
        System.out.println("Welcome to Employee Payroll Service System.");
        ArrayList<EmployeePayrollData> employeePayrollList = new ArrayList<>();
        EmployeePayrollService employeePayrollService = new EmployeePayrollService(employeePayrollList);
        long size = employeePayrollService.readEmployeePayrollData(IOService.CONSOLE_IO);
        System.out.println("No. of entries: "+size);
        employeePayrollService.writeEmployeePayrollData(IOService.CONSOLE_IO);
    }
}
