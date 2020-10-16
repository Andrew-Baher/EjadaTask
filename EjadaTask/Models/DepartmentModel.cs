using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace EjadaTask.Models
{
    public class DepartmentModel
    {
        [Display(Name = "Name")]
        [Required(ErrorMessage = "Please enter department name")]
        public string DepartmentName { get; set; }

        [Display(Name = "Description")]
        [Required(ErrorMessage = "Please enter department description")]
        public string DepartmentDescription { get; set; }

        [Display(Name = "Manager Name")]
        public string ManagerName { get; set; }
    }
}