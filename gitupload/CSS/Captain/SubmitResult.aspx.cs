using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;

public partial class Captain_SubmitResult : System.Web.UI.Page
{
    private SqlConnection sqlCon = new SqlConnection(@"workstation id=contactASPDB.mssql.somee.com;packet size=4096;user id=mamadi_k_SQLLogin_1;pwd=6sckfes4zr;data source=contactASPDB.mssql.somee.com;persist security info=False;initial catalog=contactASPDB;");

    protected void Page_Load(object sender, EventArgs e)
    {
        sqlCon.Open();
    }

    private bool validate(int value)
    {
        if(value == null)
            return false;
        else
            return true;
    }

    private string uploadProof(FileUpload upload)
    {
        string result = "";
        if ((upload.PostedFile != null) && (upload.PostedFile.ContentLength > 0))
        {
            string fn = "GamesResult";
            string ext = System.IO.Path.GetExtension(upload.PostedFile.FileName);
            string fileName = "Games" + "\\" + fn + "_" + DateTime.Now.Day + "_" + DateTime.Now.Month + "_" +
                              DateTime.Now.Year + ext;
            string SaveLocation = Server.MapPath("Attachments") + "\\" + fileName;
            try
            {
                double size = ((double)FileUpload1.PostedFile.ContentLength) / (1024 * 1024);


                if (!Directory.Exists(Server.MapPath("Attachments") + "\\Games"))
                    Directory.CreateDirectory(Server.MapPath("Attachments") + "\\Games");
                FileUpload1.PostedFile.SaveAs(SaveLocation);

                result = SaveLocation;


            }
            catch (Exception)
            {
                //message
            }
        }
        else result = "Empty";

        return result;
    }

    public void submit(object sender, EventArgs e)
    {
        bool check;
       int league;
       int yourTeam;
       int opponent;
       int yourScore;
       int oppScore;
       string path;

       league = Convert.ToInt32(dropLeague.SelectedValue);
       yourTeam = Convert.ToInt32(team.SelectedValue);
       opponent = Convert.ToInt32(dropOpponent.SelectedValue);
       yourScore = Convert.ToInt32(teamScore.Text);
       oppScore = Convert.ToInt32(txtOpp.Text);
       string confirmed = "false"; 

       check = validate(league);
       check = validate(yourTeam);
       check = validate(opponent);
       check = validate(yourScore);
       check = validate(oppScore);

       if (check == false && uploadProof(FileUpload1) == "Empty")
       {
           //Fill in all fields
       }
       else
       {
           path = uploadProof(FileUpload1);
           SqlCommand cmd = new SqlCommand("Insert into Results values('" + yourTeam + "','" + opponent + "','" + league + "','" + yourScore + "','" + oppScore + "','" + 3 + "','" + confirmed + "','" + path +"')", sqlCon);
           cmd.ExecuteNonQuery();

           sqlCon.Close();
       }
       
    }
   
}