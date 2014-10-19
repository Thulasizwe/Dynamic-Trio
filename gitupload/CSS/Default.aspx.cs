using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.ASPxTabControl;

public partial class _Default : System.Web.UI.Page
{
    private int userID;
    protected void Page_Load(object sender, EventArgs e)
    {
        string name = Request.QueryString["un"];
        int index = Convert.ToInt32(Request.QueryString["ind"]);

        string[] temp = (string[])Session["login"];

        if (temp == null || temp[index] != name)
        {
            Response.Redirect("Login.aspx");
        }

        string query = "select * from SetupUser where UserName = '" + name + "'";
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, sqlcon))
            {
                sqlcon.Open();
                SqlDataReader userRow = cmd.ExecuteReader();
                try
                {
                    while (userRow.Read())
                    {
                        WelcomeLabel.Text = "Welcome " + userRow["FirstName"].ToString() + @" " + userRow["Surname"].ToString();
                        userID = Convert.ToInt32(userRow["IDUser"]);
                    }
                }
                finally
                {
                    userRow.Close();
                }
            }
        }
    }
}
           
            