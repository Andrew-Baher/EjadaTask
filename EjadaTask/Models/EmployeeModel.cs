using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EjadaTask.Models
{
    public class EmployeeModel
    {
        [Display(Name = "ID")]
        [Required(ErrorMessage = "Please enter employee Id")]
        [Range(1000, 9999, ErrorMessage = "You need to enter a valid EmployeeId between 1000 and 9999")]
        public int EmployyeId { get; set; }

        [Display(Name = "Name")]
        [Required(ErrorMessage = "Please enter employee name")]
        public string EmployeeName { get; set; }
        
        [Display(Name = "Contacts")]
        [Required(ErrorMessage = "Please enter employee contacts")]
        public string EmployeeContacts { get; set; }

        [Display(Name = "Age")]
        [Required(ErrorMessage = "Please enter employee Age")]
        [Range(18, 60, ErrorMessage = "You need to enter a valid Employee Age")]
        public int EmployeeAge { get; set; }

        [Display(Name = "Department")]
        [Required(ErrorMessage = "Please choose employee department")]
        public string EmployeeDeaprtment { get; set; }
        public IEnumerable<DepartmentItemsModel> Departments { get; set; }
    }
}