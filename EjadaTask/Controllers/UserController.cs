using EjadaTask.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DataLibrary.BusinessLogic;


namespace EjadaTask.Controllers
{
    public class UserController : Controller
    {
        
        public ActionResult SignIn()
        {
            //Check if user is logged in then redirect him to gome page
            if (Session["Email"] != null){
                return RedirectToAction("Index", "Home");
            }
            else {
                return View();
            }
            
        }

        public ActionResult SignUp()
        {
           return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SignUp(UserModel model)
        {
            //Checks if all user inputs are valid
            if (ModelState.IsValid)
            {
                int recordsCreated = UserProcessor.CreateUser(model.UserName,
                    model.UserEmail,
                    model.UserPassword);
                if (recordsCreated > 1) {
                    return RedirectToAction("SignIn");
                }
                return RedirectToAction("SignIn");
            }

            return View();
        }

        [HttpPost]
        public ActionResult SignIn(string Email, string Password)
        {
            //Check user credetials

            if (UserProcessor.CheckUserPassword(Email, Password))
            {
                Session["Email"] = Email;
                return RedirectToAction("Index", "Home");
            }
            else {
                ModelState.AddModelError("LogOnError", "The user name or password provided is incorrect.");
                return View();
            }
            
        }



    }
}