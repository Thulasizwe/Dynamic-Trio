using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.Odbc;

public partial class _League : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["MySQLConnStr"].ConnectionString))
            {
                connection.Open();
                using (OdbcCommand command = new OdbcCommand("SELECT * FROM SetupTeams", connection))
                using (OdbcDataReader dr = command.ExecuteReader())
                {
                    while (dr.Read())
                        Response.Write(dr["TeamName"].ToString() + "<br />");
                    dr.Close();
                }
                connection.Close();
            }
        }
        catch (Exception ex)
        {
            Response.Write("An error occured: " + ex.Message);
        }
        WebUserControl.UserName = "Jane Doe";
        WebUserControl.UserAge = 33;
        WebUserControl.UserCountry = "Germany";
        // HelloWorldLabel.Text = "Hello, " + TextInput.Text;
        
    }
    protected void GreetList_SelectedIndexChanged(object sender, EventArgs e)
    {
        HelloWorldLabel.Text = "Hello, " + GreetList.SelectedValue;
    }
}