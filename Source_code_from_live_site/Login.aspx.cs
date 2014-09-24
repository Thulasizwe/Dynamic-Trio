using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.OleDb;
using System.Data.SqlClient;
using  System.Data.SqlTypes;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
//using Carab.BusinessObjects.Layers;

public partial class Login : System.Web.UI.Page
{
    //private DAL_ DAL = DAL_.Instance;
    DataTable dt = new DataTable();
    protected int index;
    protected void Page_Load(object sender, EventArgs e)
    {
     //   DAL.Setup(null, new OleDbConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString), loadTableSchemas: true);
    }

    public void LoginButton_Click(object sender, EventArgs e)
    {
        UserNameError.Visible = (UserName.Text == "");
        
        PasswordError.Visible = (UserPassword.Text == "");

        if(!UserNameError.Visible && !PasswordError.Visible)
        {
            string username = UserName.Text; // For @username we will compare to database username
            string password = FormsAuthentication.HashPasswordForStoringInConfigFile(UserPassword.Text, "md5");
                // For the password after its encrypted as will be saved in the database.
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("PersonLoginSP", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = username;
                    cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = password;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        

                        da.Fill(dt);
                    }
                }
            }
           // DAL.Key.DbData.DataTable.Get_FromSP("PersonLoginSP", "PersonLoginSP", cmdParameters: new object[] { username, password });
            if(dt.Rows.Count>0)
            {
                //Session["login"] = UserName.Text;

                if (Session["login"] == null)
                {
                    Session["login"] = new string[10];
                }

                string[] temp = (string[])Session["login"];

                if (!CheckUser(ref temp))
                {
                    AssignUser(ref temp, ref index);
                }

                Response.Redirect("Default.aspx?un=" + UserName.Text + "&ind=" + index.ToString());
            }
            else
            {
                FailureText.Text = "Username or password is incorrect";
                FailureText.Visible = true;
                UserPassword.Text = "";
            }
        }
    }

    private bool CheckUser(ref string[] temp)
    {
        for (int i = 0; i < temp.Length; i++)
        {
            if (temp[i] == UserName.Text)
            {
                index = i;
                return true;
            }
        }
        return false;
    }

    private void AssignUser(ref string[] temp, ref int userIndex)
    {
        bool growArray = true;
        for (int i = 0; i < temp.Length; i++)
        {
            if (temp[i] == null)
            {
                temp[i] = UserName.Text;
                userIndex = i;
                growArray = false;
                break;
            }
        }

        if (growArray)
        {
            Array.Resize(ref temp, temp.Length*2);
            AssignUser(ref temp, ref userIndex);
        }
        Session["login"] = temp;
    }

    protected void guestLogin(object sender, EventArgs e)
    {
        Response.Redirect("~/Register.aspx");
    }
}