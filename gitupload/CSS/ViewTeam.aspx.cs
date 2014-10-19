using System; 
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewTeam : System.Web.UI.Page
{
    static public String curID = ""; 
    protected void Page_Load(object sender, EventArgs e)
    {
        curID = (Request.QueryString["id"]) ;
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
        for (int i = 0; i < GridView1.Rows.Count;i++ )
        {
            GridView1.Rows[i].Cells[0].Text = (i +1).ToString();
            //if (GridView1.Rows[i].Cells[1].Text == GridView4.Rows[0].Cells[0].Text)
            //    GridView1.Rows[i].Cells[1].Attributes.style.backgroundColor = "#FFFFFF";
        }
            Label2.Text = GridView4.Rows[0].Cells[0].Text;
        Label3.Text = GridView4.Rows[0].Cells[1].Text + " " + GridView4.Rows[0].Cells[2].Text; 
    }
}