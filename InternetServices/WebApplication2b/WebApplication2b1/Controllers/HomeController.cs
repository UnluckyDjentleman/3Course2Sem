using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using WebApplication2и1.Models;

namespace WebApplication2и1.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [HttpGet("/it/{n: int}/{str}")]
        public IActionResult M04(int n, string str)
        {
            return Content("GET:M04:/" + n + "/" + str);
        }
        [HttpGet("/it/{b: bool}/{letters: alpha}")]
        [HttpPost("/it/{b: bool}/{letters: alpha}")]
        public IActionResult M05(bool b, string letters)
        {
            return Content(HttpContext.Request.Method+"M05:/" + b + "/" + letters);
        }
        [HttpGet("/it/{f: float}/{str: length(2,5)}")]
        [HttpDelete("/it/{f: float}/{str: length(2,5)}")]
        public IActionResult M06(float f, string str)
        {
            return Content(HttpContext.Request.Method + "M06:/" + f + "/" + str);
        }
        [HttpPut("/it/{letters: length(3,4)}/{n: range(100,200)}")]
        public IActionResult M07(string letters, int n)
        {
            return Content("PUT:M07:/" + letters + "/" + n);
        }
        [HttpPost("/it/{mail: regex('[[\\w\\d]]+@[\\w]+\\.[\\w]')}")]
        public IActionResult M08(string mail)
        {
            return Content("POST: M08:/" + mail);
        }
    }
}
