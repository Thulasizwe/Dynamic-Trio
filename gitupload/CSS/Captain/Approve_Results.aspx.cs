using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;

public partial class Captain_Approve_Results : System.Web.UI.Page
{
    private SqlConnection sqlCon = new SqlConnection(@"workstation id=contactASPDB.mssql.somee.com;packet size=4096;user id=mamadi_k_SQLLogin_1;pwd=6sckfes4zr;data source=contactASPDB.mssql.somee.com;persist security info=False;initial catalog=contactASPDB;");

    protected void Page_Load(object sender, EventArgs e)
    {
        sqlCon.Open();

        int session = 11; // from session
        int capId = session;// userid frm db
        int team;
        int results;
        string home;
        string away;
        int opponentID;
        string theirName;
        string yourName;
        string status="false";

        //Get the current team
        SqlDataReader reader = null;
        SqlCommand comm = new SqlCommand("select * from TeamMembers where Member = '" + capId + "'", sqlCon);
        reader = comm.ExecuteReader();
        reader.Read();
        team = Convert.ToInt32(reader["Team"].ToString());
        reader.Close();

        //Get the current team's results
        comm = new SqlCommand("select Min(ResultID) AS ID from Results where AwayTeamID='" + team + "' AND Confirmed= '" + status + "'", sqlCon);
        reader = comm.ExecuteReader();
        reader.Read();
        results = Convert.ToInt32(reader["ID"].ToString());
        reader.Close();

        //Get the uploaded yet not confirmed results
        comm = new SqlCommand("select * from Results where ResultID='" + results + "'", sqlCon);
        reader = comm.ExecuteReader();
        reader.Read();
        away = reader["SecondScore"].ToString();
        home = reader["FirstScore"].ToString();
        reader.Close();

        //Get team names
        comm = new SqlCommand("select * from Results where ResultID='" + results + "'", sqlCon);
        reader = comm.ExecuteReader();
        reader.Read();
        opponentID = Convert.ToInt32(reader["HomeTeamID"].ToString());
        reader.Close();

        comm = new SqlCommand("select * from SetupTeams where TeamID='" + opponentID + "'", sqlCon);
        reader = comm.ExecuteReader();
        reader.Read();
        theirName = reader["TeamName"].ToString();
        reader.Close();

        comm = new SqlCommand("select * from SetupTeams where TeamID='" + team + "'", sqlCon);
        reader = comm.ExecuteReader();
        reader.Read();
        yourName = reader["TeamName"].ToString();
        reader.Close();

        lblteam.Text = yourName;
        lblopponent.Text = theirName;
        lblscore1.Text = away;
        lblScore2.Text = home;
 

    }



}