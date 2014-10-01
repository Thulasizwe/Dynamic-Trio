using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class News : System.Web.UI.Page
{
    public SqlConnection con = new SqlConnection(@"Password=6sckfes4zr;Persist Security Info=False;User ID=mamadi_k_SQLLogin_1;Initial Catalog=contactASPDB;Data Source=contactASPDB.mssql.somee.com;");

    protected void Page_Load(object sender, EventArgs e)
    {
        con.Open();
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        string admin = "Temp admin";
        SqlCommand cmd = new SqlCommand("Insert into News values('" + admin + "','" + TextBox1.Text + "','" + TextArea1.InnerText + "','" + DropDownList1.SelectedIndex + "')", con);
        cmd.ExecuteNonQuery();
        con.Close();

        Label1.Text = "News published";
    }
}