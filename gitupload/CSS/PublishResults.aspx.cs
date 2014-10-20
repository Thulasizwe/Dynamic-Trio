using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PublishResults : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView1.Rows.Count;i++)
        {
            Label lbl = new Label();
            Label lbl1 = new Label();
            Label lbl2 = new Label();
            Label lbl3 = new Label();
            Label lbl4 = new Label();
            Label lbl5 = new Label();
            lbl.Text = "Home Team: ";
            lbl1.Text = GridView1.Rows[i].Cells[1].Text;
            lbl2.Text = GridView1.Rows[i].Cells[4].Text;
            lbl3.Text = " : " + GridView1.Rows[i].Cells[5].Text;
            lbl4.Text = GridView1.Rows[i].Cells[2].Text;
            lbl5.Text = "Away Team ";
            form1.Controls.Add(lbl);
            form1.Controls.Add(new Literal() {Text = "&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;" });
            form1.Controls.Add(lbl1);
            form1.Controls.Add(new Literal() {Text = "&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" });
            form1.Controls.Add(lbl2);
            form1.Controls.Add(lbl3);
            form1.Controls.Add(new Literal() {Text = "&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;" });
            form1.Controls.Add(lbl4);
            form1.Controls.Add(new Literal() {Text = "&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;" });
            form1.Controls.Add(lbl5);
            form1.Controls.Add(new Literal() {Text = "<br />" });
            form1.Controls.Add(new Literal() {Text = "<br />" });
            Button btn = new Button();
            btn.ID = GridView1.Rows[i].Cells[6].Text;
            btn.Text = "Publish Result";
            //btn.OnClick(Publish(GridView1.Rows[i].Cells[5].Text));
            form1.Controls.Add(new Literal() {Text = "<br />" });
            
        }
    }
    protected void Publish( String s)
    {

    }
}