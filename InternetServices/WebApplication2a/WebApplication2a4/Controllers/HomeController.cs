using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using WebApplication2a4.Models;

namespace WebApplication2a4.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        public IActionResult S200()
        {
            return Content("Hello World");
        }

        public IActionResult S300() 
        {
            return RedirectPermanent("/Home/S200");
        }

        public IActionResult S500()
        {
            int num= 2;
            int zero = 0;
            int div = num / zero;
            return StatusCode(200);
        }

        //fetch("http://localhost:5013/Home/S500").then(r=>Console.log(r.status);

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
