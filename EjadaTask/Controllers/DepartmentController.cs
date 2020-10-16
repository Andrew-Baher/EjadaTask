using DataLibrary.BusinessLogic;
using EjadaTask.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EjadaTask.Controllers
{
    public class DepartmentController : Controller
    {

        public ActionResult CreateDepartment()
        {
            //Check if user is logged in then redirect him to gome page
            if (Session["Email"] == null)
            {
                return RedirectToAction("SignIn", "User");
            }
            else
            {
                return View();
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateDepartment(DepartmentModel model)
        {
            //Checks if user inputs are valid then create new department
            if (ModelState.IsValid)
            {
                int recordsCreated = DepartmentProcessor.CreateDepartment(model.DepartmentName,
                    model.DepartmentDescription);
                if (recordsCreated > 1)
                {
                    return RedirectToAction("ViewDepartments");
                }
                return RedirectToAction("ViewDepartments");
            }
            return View();
        }

        public ActionResult ViewDepartments()
        {
            //Check if user is logged in then redirect him to gome page
            if (Session["Email"] == null)
            {
                return RedirectToAction("SignIn", "User");
            }
            else
            {
                //View all departments with their manager if it is assigned
                var data = DepartmentProcessor.LoadDepartments();
                List<DepartmentModel> departments = new List<DepartmentModel>();

                foreach (var row in data)
                {
                    departments.Add(new DepartmentModel
                    {
                        DepartmentName = row.DepName,
                        DepartmentDescription = row.DepDescription,
                        ManagerName = row.EmpName

                    });
                }

                return View(departments);
            }

        }
    }
}