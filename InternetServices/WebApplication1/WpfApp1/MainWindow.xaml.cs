using System.Net.Http;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private async void Button_Click(object sender, RoutedEventArgs e)
        {
            List<KeyValuePair<string,string>>param = new List<KeyValuePair<string, string>>();
            param.Add(new KeyValuePair<string, string>("x",textboxX.Text));
            param.Add(new KeyValuePair<string, string>("y", textboxY.Text));
            var parameters = new FormUrlEncodedContent(param);
            HttpClient client = new HttpClient();
            var res = await client.PostAsync("http://localhost:43714/task4", parameters);
            try
            {
                if (res.IsSuccessStatusCode)
                {
                    textboxRes.Text = await res.Content.ReadAsStringAsync();
                }
            }
            catch(Exception ex)
            {
                textboxRes.Text = ex.Message;
            }
        }
    }
}