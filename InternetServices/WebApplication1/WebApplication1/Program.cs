using Microsoft.AspNetCore.Http;

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
    await 
});
app.MapPost("/task5", (string x, string y) => { 

});

//6
app.MapGet("/task6", () => {

});
app.MapPost("/task6", () => {

});

app.Run();
