using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLibrary.Models
{
    public class EmployeeModel
    {
        public int Id { get; set; }
        public string EmpName { get; set; }
        public int EmpID { get; set; }
        public string EmpContacts { get; set; }
        public int EmpAge { get; set; }
        public int EmpDept { get; set; }
        public string DepName { get; set; }
    }
}
