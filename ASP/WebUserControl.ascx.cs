using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DevExpress.Web.ASPxMenu;

public partial class WebUserControl : System.Web.UI.UserControl
{
    private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        string user = Request.QueryString["un"];
        int index = Request.QueryString["ind"].AsInt();

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

        if (DAL.Key.DbData == null)
            DAL.Setup(null, new OleDbConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString), loadTableSchemas: true);

        int userSecurity;
        
        if (user != "guest")
        {

            DataRow userRow;
            DAL.Key.DbData.DataTable.Get("contactPerson").cxFindRow("[ScreenName] = '" + user + "'", out userRow);

            userSecurity = userRow.cxValue_Get("FKSecurity").AsInt();
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