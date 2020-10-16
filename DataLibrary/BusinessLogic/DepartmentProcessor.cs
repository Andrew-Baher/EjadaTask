using DataLibrary.DataAcess;
using DataLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLibrary.BusinessLogic
{
    public static class DepartmentProcessor
    {
        public static int CreateDepartment(string name,
            string description)
        {
            DepartmentModel data = new DepartmentModel
            {
                DepName = name,
                DepDescription = description
            };

            //Create a new department

            string sql = @"insert into dbo.[Department] ([DepName], [DepDescription])
                           values (@DepName, @DepDescription);";

            return SqlDataAccess.SaveData(sql, data);
        }

        public static List<DepartmentModel> LoadDepartments()
        {

            //List all departments with thire manager if assigned or diplay 'Not Assigned yet' if there is no manager
            string sql = @"select D.Id, D.DepName, D.DepDescription, E.EmpName
                            from dbo.[Department] as D,dbo.Employee as E,dbo.DepartmentManager as DM
                            where D.Id=DM.DepId and E.Id = DM.EmpId
                            UNION
                            select D.Id, D.DepName, D.DepDescription,'Not Assigned yet'
                            from dbo.[Department] as D
                            where D.Id Not In (select DepId from dbo.DepartmentManager);";

            return SqlDataAccess.LoadData<DepartmentModel>(sql);
        }
    }
}
