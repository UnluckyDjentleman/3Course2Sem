using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using WebApplication2a3.Models;

namespace WebApplication2a3.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        public IActionResult One()
        {
            return View();
        }
        public IActionResult Two()
        {
            return View();
        }
        public IActionResult Three() { 
            return View();
        }
    }
}
