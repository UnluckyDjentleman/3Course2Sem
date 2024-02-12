using System.Diagnostics;
using System.Net.WebSockets;
using System.Text;
internal class Program
{
    public static ParameterizedThreadStart SendCycle = async (Object? lol) =>
    {
        int k = 0;
        WebSocket? ws = (WebSocket?)lol;
        byte[] buffer = new byte[4096];
        while (ws != null && ws.State == WebSocketState.Open)
        {
            buffer = Encoding.ASCII.GetBytes(string.Format("Send Cycle: {0}\n", k++));
            await ws.SendAsync(new ArraySegment<byte>(buffer), WebSocketMessageType.Text, true, CancellationToken.None);
            Thread.Sleep(1000);
        }
    };
    public static ParameterizedThreadStart ReceiveCycle = async (Object? lol) =>
    {
        int k = 0;
        WebSocket? ws = (WebSocket?)lol;
        byte[] buffer = new byte[4096];
        string message = string.Empty;
        Trace.Listeners.Add(new TextWriterTraceListener(Console.Out));
        Trace.AutoFlush = true;
        Trace.WriteLine("Trace was Started");
        while (ws != null && ws.State == WebSocketState.Open)
        {
            WebSocketReceiveResult res = await ws.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);
            message = System.Text.Encoding.UTF8.GetString(buffer, 0, res.Count);
            Trace.WriteLine(message);
        }
        Trace.WriteLine("Trace was finished");
    };
    private static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        // Add services to the container.

        var app = builder.Build();

        app.UseWebSockets();
        app.UseStaticFiles();
        app.MapGet("/tws", async (HttpContext httpContext) =>
        {
            Thread hSend = new Thread(new System.Threading.ParameterizedThreadStart(SendCycle));
            Thread hReceive = new Thread(new System.Threading.ParameterizedThreadStart(ReceiveCycle));
            byte[] buf = new byte[4096];
            if (httpContext.WebSockets.IsWebSocketRequest)
            {
                WebSocket ws = await httpContext.WebSockets.AcceptWebSocketAsync();
                WebSocketReceiveResult result = await ws.ReceiveAsync(new ArraySegment<byte>(buf), CancellationToken.None);
                string message = System.Text.Encoding.UTF8.GetString(buf, 0, result.Count);
                hSend.Start(ws);
                hReceive.Start(ws);
                hSend.Join();
                hReceive.Join(); 
            }
        });

        app.Run();
    }
}
