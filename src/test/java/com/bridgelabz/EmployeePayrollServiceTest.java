package com.bridgelabz;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.util.List;

public class EmployeePayrollServiceTest {
    private EmployeePayrollService employeePayrollService;
    @Test
    public void givenEmployeeWhenWrittenToFileShouldMatchEmployeeEntries(){
        EmployeePayrollData[] employeePayrollData = {
                new EmployeePayrollData(121, "Jhanvi Kanakhara", 25000),
                new EmployeePayrollData(122, "Karan Shah", 32000),
                new EmployeePayrollData(123, "Pooja Mehta", 28490)};
        EmployeePayrollFileIOService.writeData(List.of(employeePayrollData));
        EmployeePayrollFileIOService.readData();
        System.out.println("No. of entries: "+employeePayrollData.length);
    }
}
