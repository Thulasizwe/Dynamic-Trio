using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Teams : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int a = 0;
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            Label lbl = new Label();
            lbl.Text = GridView1.Rows[i].Cells[1].Text + " ";
            ImageButton img = new ImageButton();
            img.ImageUrl = GridView1.Rows[i].Cells[2].Text + "";
            img.ID = GridView1.Rows[i].Cells[0].Text;

            img.PostBackUrl = string.Concat("~/ViewTeam.aspx?id=", GridView1.Rows[i].Cells[0].Text);

            form1.Controls.Add(lbl);
            form1.Controls.Add(img);
        }
                    
    }
}