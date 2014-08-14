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
    public SqlConnection con = new SqlConnection(@"Data Source=THULASIZWE-PC\JT;Initial Catalog=Esports;Integrated Security=True");

    protected void Page_Load(object sender, EventArgs e)
    {
        con.Open();
       
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if ((FileUpload1.PostedFile != null) && (FileUpload1.PostedFile.ContentLength > 0))
        {
            string fn = "News";
            string ext = System.IO.Path.GetExtension(FileUpload1.PostedFile.FileName);
            string fileName = "News" + "\\" + fn + "_" + DateTime.Now.Day + "_" + DateTime.Now.Month + "_" +
                              DateTime.Now.Year + ext;
            string SaveLocation = Server.MapPath("Attachments") + "\\" + fileName;
            try
            {
                double size = ((double)FileUpload1.PostedFile.ContentLength) / (1024 * 1024);
                // Maximum 5 Mb file size
                if (size > 5.25)
                {
                    return;
                }
                if (!Directory.Exists(Server.MapPath("Attachments") + "\\News"))
                    Directory.CreateDirectory(Server.MapPath("Attachments") + "\\News");
                FileUpload1.PostedFile.SaveAs(SaveLocation);

                string admin = "Temp admin";
                SqlCommand cmd = new SqlCommand("Insert into News values('" + admin + "','" + TextBox1.Text + "','" + TextArea1.InnerText + "','" + DropDownList1.SelectedValue + "','" + SaveLocation + "')", con);
               
                int result = cmd.ExecuteNonQuery();

                if (result == 1)
                {
                    Label1.Text = "News published to " + DropDownList1.SelectedItem;
                }
                con.Close();
            }
            catch (Exception)
            {
                
            }
        }
    }
}
