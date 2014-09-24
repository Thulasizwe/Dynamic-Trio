using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxMenu;

public partial class WebUserControl : System.Web.UI.UserControl
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string user = Request.QueryString["un"];
        int index = 0;
        try
        {
             index = Convert.ToInt32(Request.QueryString["ind"]);
        }
        catch (Exception)
        {
        }
        

       // string[] temp = (string[]) Session["login"];

        //if (temp == null || temp[index] != user)
        //{
        //    Response.Redirect("Login.aspx");
        //}

        foreach (DevExpress.Web.ASPxMenu.MenuItem menuItem in MainMenu.Items)
        {
            if (menuItem.NavigateUrl != "") menuItem.NavigateUrl += "?un=" + user + "&ind=" + index;
            foreach (DevExpress.Web.ASPxMenu.MenuItem subItem in menuItem.Items)
            {
                if (subItem.NavigateUrl != "") subItem.NavigateUrl += "?un=" + user + "&ind=" + index;
            }
            
        }
        string query = "select * from contactPerson where ScreenName = " + user;
        int userSecurity = 0;

       
        
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
                            userSecurity = Convert.ToInt32(userRow["FKSecurity"]); 
                        }
                    }
                    finally
                    {
                        userRow.Close();
                    }
                }
            }

            

           
        }
        else
        {
            userSecurity = 2;
        }

        switch (userSecurity)
        {
            case 3:
                MainMenu.Items[2].Items[0].Visible = false;
                MainMenu.Items[1].Visible = false;
                break;

            case 2:
                MainMenu.Items[4].Items[0].Visible = false;
                MainMenu.Items[3].Items[1].Visible = false;
                MainMenu.Items[2].Items[0].Visible = false;
                MainMenu.Items[5].Visible = false;
                MainMenu.Items[1].Visible = false;

                break;
        }
    }
}