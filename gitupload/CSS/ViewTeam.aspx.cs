using System; 
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxMenu;


public partial class ViewTeam : System.Web.UI.Page
{
    private SqlConnection sqlCon = new SqlConnection(@"Password=6sckfes4zr;Persist Security Info=False;User ID=mamadi_k_SQLLogin_1;Initial Catalog=contactASPDB;Data Source=contactASPDB.mssql.somee.com;");
    static public String curID = "";
    static string user = " " ;
    static int curUserID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        sqlCon.Open();
        user = Request.QueryString["un"];
        curID = (Request.QueryString["id"]);
        SqlDataSource1.SelectParameters.Clear();
        SqlDataSource1.SelectParameters.Add("Param1", curID);
        SqlDataSource2.SelectParameters.Clear();
        SqlDataSource2.SelectParameters.Add("Param1", curID);
        SqlDataSource3.SelectParameters.Clear();
        SqlDataSource3.SelectParameters.Add("Param1", curID);
        SqlDataSource4.SelectParameters.Clear();
        SqlDataSource4.SelectParameters.Add("Param1", curID);
        GridView1.DataBind();
        GridView2.DataBind();
        GridView3.DataBind();
        GridView4.DataBind();
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            GridView1.Rows[i].Cells[0].Text = (i + 1).ToString();
            //if (GridView1.Rows[i].Cells[1].Text == GridView4.Rows[0].Cells[0].Text)
            //    GridView1.Rows[i].Cells[1].Attributes.style.backgroundColor = "#FFFFFF";
        }
        Label2.Text = GridView4.Rows[0].Cells[0].Text;
        Label3.Text = GridView4.Rows[0].Cells[1].Text + " " + GridView4.Rows[0].Cells[2].Text;
        string query = "SELECT * FROM [SetupUser] WHERE username = '" + user + "'";
        if (user != "guest")
        {

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
                            curUserID = Convert.ToInt32(userRow["IDUser"]);
                        }
                    }
                    finally
                    {
                        userRow.Close();
                    }
                }
            }
            bool found = false;
        query = "SELECT * FROM [TeamMembers] WHERE Member = '" + curUserID + "'";
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
                            found = true;
                        }
                    }
                    finally
                    {
                        userRow.Close();
                    }
                }
            }
            if (found == true)
                Button1.Visible = false;
    }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        
            //
            SqlCommand sqlCommand = new SqlCommand("INSERT INTO TeamMembers VALUES ('" + curUserID + "','" + curID + "','" + "false" + "')", sqlCon);
            sqlCommand.ExecuteNonQuery();
            DateTime dateValue = DateTime.Now;
            string MySQLFormatDate = dateValue.ToString("yyyy-MM-dd HH:mm:ss");
            SqlCommand sqlCommand1 = new SqlCommand("INSERT INTO AuditLog VALUES ('" + 11 + "','" + curID +" added a new member awaiting confirmation " + "','"+ MySQLFormatDate + "')", sqlCon);
            sqlCommand1.ExecuteNonQuery();

        }
    }
}