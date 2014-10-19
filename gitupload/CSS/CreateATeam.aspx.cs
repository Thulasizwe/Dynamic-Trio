using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


public partial class CreateATeam : System.Web.UI.Page
{
    private string team_name;
    private string team_captain;
    private string team_zone;
    private int team_ID;
    private SqlConnection sqlCon = new SqlConnection(@"Password=6sckfes4zr;Persist Security Info=False;User ID=mamadi_k_SQLLogin_1;Initial Catalog=contactASPDB;Data Source=contactASPDB.mssql.somee.com;");
    public CreateATeam()
    {
        team_name = "";
        team_captain = "";
        team_ID = 0;
        team_zone = "";
    }
    public CreateATeam(string teamZone, int teamID, string teamName, string teamCaptain)
	{
        team_name = teamName;
        team_ID = teamID;
        team_captain = teamCaptain;
        team_zone = teamZone;
	}

    protected void submit(object sender, EventArgs e)
    {
       
        TeamNameError.Visible = false;
        TeamCaptainError.Visible = false;
        TeamZoneError.Visible = false;
       
        if (teamName.Text.Length < 1)
        {
            TeamNameError.Visible = true;
        }
        if (teamCaptain.SelectedIndex == 0)
        {
            TeamCaptainError.Visible = true;
        }
        if (TeamZone.SelectedIndex == 0)
        {
            TeamZoneError.Visible = true;
       }
        if ((teamName.Text.Length > 1) && (teamCaptain.SelectedIndex != 0) && (TeamZone.SelectedIndex != 0))
        {
            SqlCommand sqlCommand = new SqlCommand("INSERT INTO SetupTeams VALUES ('" + teamName.Text + "','" + teamCaptain.SelectedIndex + "','" + TeamZone.SelectedItem + "')",sqlCon);
            sqlCommand.ExecuteNonQuery();
            TeamSuccess.Text = "The team " + teamName.Text + " has been created, captain : " + teamCaptain.SelectedItem + " and the team zone selected is " + TeamZone.SelectedItem;
            DateTime dateValue = DateTime.Now;
            string MySQLFormatDate = dateValue.ToString("yyyy-MM-dd HH:mm:ss");
            SqlCommand sqlCommand1 = new SqlCommand("INSERT INTO AuditLog VALUES ('" + 11 + "','" + TeamSuccess.Text + "','" + MySQLFormatDate + "')", sqlCon);
            sqlCommand1.ExecuteNonQuery();
            TeamNameError.Visible = false;
            TeamCaptainError.Visible = false;
            TeamZoneError.Visible = false;
            
            TeamSuccess.Visible = true;
        }
        
        
        
    }
    public string Team_Name
    {
        get
        {
            return team_name;
        }
        set
        {
            team_name = value;
        }
    }

    public string Team_Zone
    {
        get
        {
            return team_zone;
        }
        set
        {
            team_zone = value;
        }
    }

    public string Team_Captain
    {
        get
        {
            return team_captain;
        }
        set
        {
            team_captain = value;
        }
    }
    public int Team_ID
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

    protected void Page_Load(object sender, EventArgs e)
    {
        sqlCon.Open();
        

    }
}