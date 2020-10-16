using EjadaTask.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DataLibrary.BusinessLogic;

namespace EjadaTask.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            //Check if user is loged in or not
            if (Session["Email"] == null)
            {
                return RedirectToAction("SignIn", "User");
            }
            else
            {
                return View();
            }
            
        }

        public ActionResult About()
        {

            //Check if user is loged in or not
            if (Session["Email"] == null)
            {
                return RedirectToAction("SignIn", "User");
            }
            else
            {
                return View();
            }
        }

        public ActionResult Contact()
        {
            //Check if user is loged in or not

            if (Session["Email"] == null)
            {
                return RedirectToAction("SignIn", "User");
            }
            else
            {
                return View();
            }
        }

       
    }
}