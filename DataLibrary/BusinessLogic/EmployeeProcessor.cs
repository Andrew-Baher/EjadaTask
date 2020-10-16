using DataLibrary.DataAcess;
using DataLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLibrary.BusinessLogic
{
    public static class EmployeeProcessor
    {
        public static int CreateEmployee(string name,
            int id,string contacts, int age, int dept)
        {
            EmployeeModel data = new EmployeeModel
            {
                EmpName = name,
                EmpID = id,
                EmpContacts = contacts,
                EmpAge = age,
                EmpDept = dept
            };

            //Creates a new Employee to a created department

            string sql = @"insert into dbo.[Employee] ([EmpName], [EmpID], [EmpContacts], [EmpAge], [EmpDept])
                           values (@EmpName, @EmpID, @EmpContacts, @EmpAge, @EmpDept);";

            return SqlDataAccess.SaveData(sql, data);
        }

        public static List<EmployeeModel> LoadEmployees()
        {

            //Load all employees with department name
            string sql = @"select E.Id, E.EmpName, E.EmpID, E.EmpContacts, E.EmpAge, D.DepName
                           from dbo.[Employee] as E, dbo.[Department] as D
                           where E.EmpDept = D.Id;";

            return SqlDataAccess.LoadData<EmployeeModel>(sql);
        }

        public static int SetManagerToDepartment(int EmployeeID, string DepartmentName) {

            //Executes a stored procedure to make an employeee manager to department
            string sql = $"Exec SetManager {EmployeeID},'{DepartmentName}';";
            return SqlDataAccess.ExecuteQuey(sql);
        }
    }
}
