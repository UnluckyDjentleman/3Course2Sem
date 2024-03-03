using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using WebApplication2a5.Models;

namespace WebApplication2a5.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index(string Id)
        {
            ViewBag.Id = Id;
            return View();
        }
        public IActionResult Uri01(int Id)
        {
            ViewBag.Id = Id;
            return View();
        }
        public IActionResult Uri02(int? Id)
        {
            ViewBag.Id = Id;
            return View();
        }
        public IActionResult Uri03(float Id)
        {
            ViewBag.Id = Id;
            return View();
        }
        public IActionResult Uri04(DateTime Id)
        {
            ViewBag.Id = Id;
            return View();
        }
    }
}
