using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Captain : System.Web.UI.Page
{

    public SqlConnection con = new SqlConnection(@"Data Source=localhost;Initial Catalog=Esports;Integrated Security=True");

    protected void Page_Load(object sender, EventArgs e)
    {
        con.Open();
    }

        private string name;
        private int team_ID;


        public Captain()
        {
            
        }

        public string Name
        {
            get
            {
                return name;
            }
            set
            {
                name = value;
            }
        }

        public int TeamID
        {
            get
            {
                return team_ID;
            }
            set
            {
                team_ID = value;
            }
        }

        private bool ConfirmMember(int memberID)
        {
            //Make entry in [SetupMapUserTeams] using the current team and the memberID parameter
            return false;
        }

        private bool SubmitResult()
        {

            return false;
        }

        private string SendDispute()
        {

            return "";
        }

        private void UploadEmblem()
        {

        }

        private void JoinLeague(int leagueID)
        {

        }

      
        protected void Button1_Click1(object sender, EventArgs e)
        {


            SqlCommand cmd = new SqlCommand("Insert into LeagueTeams values('" + DropTeam.SelectedValue + "','" + dropLeague.SelectedValue + "','" + dropGame.SelectedValue + "')", con);
            cmd.ExecuteNonQuery();
            con.Close();

            Label1.Text = "Leaugue Joined";
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
            

            if ((FileUpload1.PostedFile != null) && (FileUpload1.PostedFile.ContentLength > 0))
            {
                string fn = "GamesResult";
                string ext = System.IO.Path.GetExtension(FileUpload1.PostedFile.FileName);
                string fileName = "Games" + "\\" + fn + "_" + DateTime.Now.Day + "_" + DateTime.Now.Month + "_" +
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
                    if (!Directory.Exists(Server.MapPath("Attachments") + "\\Games"))
                        Directory.CreateDirectory(Server.MapPath("Attachments") + "\\Games");
                    FileUpload1.PostedFile.SaveAs(SaveLocation);

                    SqlCommand cmd = new SqlCommand("Insert into Results values('" + YourTeamDrop.SelectedValue + "','" + OpponentDrop.SelectedValue + "','" + LeagueDrop.SelectedItem + "','" + YourText.Text + "','" + OpponentText.Text + "','" + GameDrop.SelectedItem + "','" + "false" + "','" + SaveLocation + "')", con);
                    cmd.ExecuteNonQuery();
                    //
                    UploadLabel.Text = "Upload Successful";
                }
                catch (Exception)
                {
                    UploadLabel.Text = "Upload unsuccessful, please try again";
                }
            }
            con.Close();
        }
}