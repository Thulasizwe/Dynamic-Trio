using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
public partial class ViewLog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    
    protected void Button1_Click(object sender, EventArgs e)
    {
        //SqlDataSource1.SelectParameters.Clear();
        SqlDataSource1.SelectParameters.Clear();
        SqlDataSource1.SelectParameters.Add("Param1", LeagueName.SelectedValue);
        GridView1.DataBind();
        for (int i  = 0; i < GridView1.Rows.Count;i++)
        {
            GridView1.Rows[i].Cells[0].Text = (i+1).ToString();
        }
        
    }
}