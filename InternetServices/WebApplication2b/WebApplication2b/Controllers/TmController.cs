using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using WebApplication2b.Models;

namespace WebApplication2b.Controllers
{
    public class TmController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }
        [Route("/MResearch/M01/{id:int:range(1,1)}")]
        [Route("/MResearch/M01")]
        [Route("/MResearch")]
        [Route("/")]
        [Route("/V2/MResearch/M01")]
        [Route("/V3/MResearch/{id}/M01")]
        public IActionResult M01(string id)
        {
            return Content("GET:M01=" + id);
        }
        [Route("/V2")]
        [Route("/V2/MResearch")]
        [Route("/V2/MResearch/M02")]
        [Route("/MResearch/M02")]
        [Route("/V3/MResearch/{id}/M02")]
        public IActionResult M02(string id)
        {
            return Content("GET:M02=" + id);
        }
        [Route("/V3")]
        [Route("/V3/MResearch/{id}")]
        [Route("/V2/MResearch/M02/{id}")]
        public IActionResult M03(string id)
        {
            return Content("GET:M03=" + id);
        }
        [Route("{* path}")]
        public IActionResult MXX(string id)
        {
            return Content("GET:MXX=" + id);
        }
    }
}
