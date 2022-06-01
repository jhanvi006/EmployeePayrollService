package com.bridgelabz;

import java.time.LocalDate;

public class EmployeePayrollData {
    int id;
    String name;
    double salary;
    String gender;
    String address;
    String phoneNo;
    int companyId;
    LocalDate startDate;
    public EmployeePayrollData(int id, String name, double salary) {
        this.id = id;
        this.name = name;
        this.salary = salary;
    }

    public EmployeePayrollData(int empId, String name, String phoneNo, String address,
                               String gender, int companyId, LocalDate startDate) {
        this.id = empId;
        this.name = name;
        this.phoneNo = phoneNo;
        this.address = address;
        this.gender = gender;
        this.companyId = companyId;
        this.startDate = startDate;
    }

    public String toString() {
//        return "[Employee Id= "+id+", Name= "+name+", Salary= "+salary+"]";
        return "[Employee Id: "+id+", Name: "+name+", Phone No: "+phoneNo+", Address:"+address+
                ", Gender: "+gender+", Company Id: "+companyId+", Start Date: "+startDate+"]";
    }
    public boolean equals(Object o){
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;
        EmployeePayrollData that = (EmployeePayrollData) o;
        return id == that.id &&
                name.equals(that.name) &&
                phoneNo.equals(that.phoneNo) &&
                address.equals(that.address) &&
                gender.equals(that.gender) &&
                companyId == that.companyId;
    }
}
