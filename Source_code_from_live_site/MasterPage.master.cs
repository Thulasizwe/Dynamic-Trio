using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using Carab.BusinessObjects.Layers;

public partial class MasterPage : System.Web.UI.MasterPage
{
    //private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
       // DAL.Setup(null, new OleDbConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString),loadTableSchemas:true);
        Response.Redirect("Login.aspx");
    }
}
