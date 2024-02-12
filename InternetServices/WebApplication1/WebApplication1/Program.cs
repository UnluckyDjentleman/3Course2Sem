using Microsoft.AspNetCore.Http;
using System.Net.Http;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

var app = builder.Build();

// Configure the HTTP request pipeline.

//1
app.MapGet("/gvs", (string x, string y) =>$"GET-Http-GVS: ParmA={x}, ParmB={y}");

//2
app.MapPost("/gvs", (string x, string y) => $"POST-Http-GVS: ParmA={x}, ParmB={y}");

//3
app.MapPut("/gvs", (string x, string y) => $"PUT-Http-GVS: ParmA={x}, ParmB={y}");

//4
app.MapPost("/task4", async(HttpContext httpContext) =>
{
    var form=httpContext.Request.Form;
    string? x = form["x"];
    string? y = form["y"];
    await httpContext.Response.WriteAsync((double.Parse(x)+ double.Parse(y)).ToString());
});

//5
app.MapGet("/task5", async (HttpContext httpContext) => { 
    httpContext.Response.ContentType = "text/html";
    await httpContext.Response.WriteAsync(File.ReadAllText("htmlpage.html"));
});
app.MapPost("/task5", async (HttpContext httpContext) => { 
    string x = httpContext.Request.Form["x"];
    string y= httpContext.Request.Form["y"];
    try
    {
        int xPar = int.Parse(x);
        int yPar = int.Parse(y);
        await httpContext.Response.WriteAsync(x + "*" + y + "=" + xPar * yPar);
    }
    catch(Exception ex)
    {
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

//6
app.MapGet("/task6", async(HttpContext httpContext) => {
    httpContext.Response.ContentType = "text/html";
    await httpContext.Response.WriteAsync(File.ReadAllText("task6.html"));
});
app.MapPost("/task6", async(HttpContext httpContext) => {
    var x = int.Parse(httpContext.Request.Form["x"]);
    var y = int.Parse(httpContext.Request.Form["y"]);
    var mul = x * y;
    await httpContext.Response.WriteAsync("<html>" +
        "<head>" +
        "<title>Answer</title>" +
        "</head>" +
        "<body>" +
        $"<p>{x}*{y}={mul}</p>" +
        "</body>" +
        "</html>");
});

app.Run();
