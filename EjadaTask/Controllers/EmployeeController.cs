using DataLibrary.BusinessLogic;
using EjadaTask.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EjadaTask.Controllers
{
    public class EmployeeController : Controller
    {
        public ActionResult SetManager(int EmployeeID,string Department)
        {
            //Sets Manager with employee id to department he assigned to
            EmployeeProcessor.SetManagerToDepartment(EmployeeID, Department);
            return RedirectToAction("ViewDepartments","Department");
        }

        public ActionResult CreateEmployee()
        {
            //Check if user is logged in then redirect him to gome page
            if (Session["Email"] == null)
            {
                return RedirectToAction("SignIn", "User");
            }
            else
            {
                //Load all departments to display in drop down menu
                var data = DepartmentProcessor.LoadDepartments();
                List<DepartmentItemsModel> departments = new List<DepartmentItemsModel>();

                foreach (var row in data)
                {
                    departments.Add(new DepartmentItemsModel
                    {
                        Id = row.Id,
                        Name = row.DepName,
                    });
                }

                var model = new EmployeeModel();
                model.Departments = departments;

                return View(model);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateEmployee(EmployeeModel model)
        {
            //Checks for all user inputs are valid then create new employee with this information
            if (ModelState.IsValid)
            {
                int recordsCreated = EmployeeProcessor.CreateEmployee(
                    model.EmployeeName,model.EmployyeId,model.EmployeeContacts,model.EmployeeAge, Int16.Parse(model.EmployeeDeaprtment)
                    );
                if (recordsCreated > 1)
                {
                    return RedirectToAction("ViewEmployees");
                }
                return RedirectToAction("ViewEmployees");
            }
            return View();
        }

        public ActionResult ViewEmployees(string searchString)
        {
            //Check if user is logged in then redirect him to gome page
            if (Session["Email"] == null)
            {
                return RedirectToAction("SignIn", "User");
            }
            else
            {
                //Load all employees fro data base then add filter to filter them
                var data = EmployeeProcessor.LoadEmployees();
                List<EmployeeModel> employees = new List<EmployeeModel>();

                foreach (var row in data)
                {
                    employees.Add(new EmployeeModel
                    {
                        EmployyeId = row.EmpID,
                        EmployeeName = row.EmpName,
                        EmployeeContacts = row.EmpContacts,
                        EmployeeAge = row.EmpAge,
                        EmployeeDeaprtment = row.DepName,
                    });
                }

                if (!String.IsNullOrEmpty(searchString))
                {
                    employees = employees.Where(e => e.EmployeeName.Contains(searchString)).ToList();
                }

                return View(employees);
            }

        }
    }
}