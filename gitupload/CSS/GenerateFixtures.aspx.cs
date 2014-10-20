using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class GenerateFixtures : System.Web.UI.Page
{
    public int gameweeks = 0;
    public int gamesPerWeek = 0;
    public int numberOfFixtures = 0;
    public String TypeOfFixtures = "";
    public List<GenerateFixtures> fixtures;
    public int LeagueID = 0;
    public String err = "";
    private SqlConnection sqlCon = new SqlConnection(@"Password=6sckfes4zr;Persist Security Info=False;User ID=mamadi_k_SQLLogin_1;Initial Catalog=contactASPDB;Data Source=contactASPDB.mssql.somee.com;");
    protected void Page_Load(object sender, EventArgs e)
    {
        numberOfFixtures = 1;
        
     }
    public int Home { get; set; }
    public int Away { get; set; }

    public string FixtureTime { get; set; }
    void CallCode(int LeagueID)
    {
        string[] teamss = new string[Int32.Parse(GridView1.Rows[0].Cells[2].Text)];
        gameweeks = GridView1.Rows.Count;
        gamesPerWeek = GridView1.Rows.Count;
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
           teamss[i] = GridView1.Rows[i].Cells[1].Text;
        }
        
        gamesPerWeek = teamss.Length;
        gameweeks = teamss.Length;
        fixtures = CalculateFixtures(teamss);
        if (string.IsNullOrEmpty(err) == true)
        {
            int a = 0;
            int o = 0;
            for (int i = 0; i < fixtures.Count; i++)
            {
                if (a < gamesPerWeek)
                {
                    a = a + 1;
                }
                else
                {
                    a = 0;
                    o = o + 1;
                }
                fixtures[i].FixtureTime = "Week " + (o + 1);
                SqlCommand sqlCommand = new SqlCommand("INSERT INTO Fixtures VALUES ('" + fixtures[i].Home + "','" + fixtures[i].Away + "','" + fixtures[i].FixtureTime + "','" + DropDownList1.SelectedValue + "')", sqlCon);
                sqlCommand.ExecuteNonQuery();

            }
            Label1.Text = "Fixtures have been generated for league " + DropDownList1.SelectedValue;
            DateTime dateValue = DateTime.Now;
            string MySQLFormatDate = dateValue.ToString("yyyy-MM-dd HH:mm:ss");
            SqlCommand sqlCommand1 = new SqlCommand("INSERT INTO AuditLog VALUES ('" + 11 + "','" + Label1.Text + "','" + MySQLFormatDate + "')", sqlCon);
            sqlCommand1.ExecuteNonQuery();


            Label1.Visible = true;
        }

        
    }
   
    

    List<GenerateFixtures> CalculateFixtures(string[] teams)
    {
        fixtures = new List<GenerateFixtures>();
        int c = 0;
        String hom = "";
        String awa = "";
        Random ri = new Random();
        int num = 0;
        int ii = 0;
        bool found1 = false;
        for (int i = 0; i < teams.Length;i++ )
        {
            if (string.IsNullOrEmpty(teams[i]) == true)
                found1 = true;
        }
        if (found1 == true)
        {
            Label6.Visible = true;
            Label6.Text = "Not Enough teams in that league";
            err = "Something went wrong";
        }
        else
        {
            if (TypeOfFixtures == "League")
            {
                for (int i = 0; i < teams.Length; i++)
                {
                    num = num + i;
                }
                while (c < numberOfFixtures)
                {

                    if ((numberOfFixtures - c) == 1)
                    {
                        while (ii < num)
                        {
                            int randomIndex = ri.Next(0, teams.Length);
                            int rrandomIndex = ri.Next(0, teams.Length);
                            while ((fixtures.Contains(new GenerateFixtures() { Home = (rrandomIndex + 1), Away = (randomIndex + 1), FixtureTime = " " }).Equals(true)) || (fixtures.Contains(new GenerateFixtures() { Home = (randomIndex + 1), Away = (rrandomIndex + 1), FixtureTime = " " }).Equals(true)) || (teams[randomIndex] == teams[rrandomIndex]))
                            {
                                randomIndex = ri.Next(0, teams.Length);
                                rrandomIndex = ri.Next(0, teams.Length);
                            }
                            fixtures.Add(new GenerateFixtures() { Home = (rrandomIndex + 1), Away = (randomIndex + 1), FixtureTime = " " });
                            ii = ii + 1;
                            //c = c + 1;
                        }
                        c = c + 1;
                    }
                    else
                    {
                        for (int i = 0; i < teams.Length; i++)
                        {
                            for (int j = 0; j < teams.Length; j++)
                            {
                                if (teams[i] != teams[j])
                                {
                                    fixtures.Add(new GenerateFixtures() { Home = (i + 1), Away = (j + 1), FixtureTime = " " });
                                }
                            }
                        }
                        c = c + 2;
                    }

                }

            }
            else
            {
                List<String> chosen = new List<String>();
                for (int i = 0; i < teams.Length / 2; i++)
                {
                    int randomIndex = ri.Next(0, teams.Length);
                    int rrandomIndex = ri.Next(0, teams.Length);
                    hom = teams[randomIndex];
                    awa = teams[rrandomIndex];
                    bool found = false;
                    while (found.Equals(false))
                    {
                        bool b = chosen.Contains(hom);
                        bool bb = chosen.Contains(awa);
                        if (b.Equals(true) || bb.Equals(true) || (hom == awa))
                        {
                            randomIndex = ri.Next(0, teams.Length);
                            rrandomIndex = ri.Next(0, teams.Length);
                            hom = teams[randomIndex];
                            awa = teams[rrandomIndex];
                        }
                        else
                        {
                            break;
                        }
                    }
                    fixtures.Add(new GenerateFixtures() { Home = (randomIndex + 1), Away = (rrandomIndex + 1), FixtureTime = " " });
                    chosen.Add(hom);
                    chosen.Add(awa);
                }

            }
            for (int i = 0; i < fixtures.Count; i++)
            {
                GenerateFixtures temp = fixtures[i];
                Random r = new Random();
                int randomIndex = r.Next(i, fixtures.Count);
                fixtures[i] = fixtures[randomIndex];
                fixtures[randomIndex] = temp;
            }
        }
            
        
        return fixtures;
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        Label5.Visible = false;
        Label4.Visible = false;
        Boolean error = false;
        if (DropDownList1.SelectedValue.Equals("0"))
        {
            error = true;
            Label5.Visible = true;
            Label5.Text = "Please select a league";
        }
        else if (DropDownList2.SelectedIndex == 0)
        {
            error = true;
            Label4.Visible = true;
            Label4.Text = "Please select either league or tournament";
        }
        else if (error == false)
        {
            if (DropDownList2.SelectedValue == "League")
                TypeOfFixtures = "League";
            else if (DropDownList2.SelectedValue == "Tournament")
                TypeOfFixtures = "Tournament";
            sqlCon.Open();
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectParameters.Add("Param1", DropDownList1.SelectedValue);
            GridView1.DataBind();
            if (GridView1.Rows.Count > 1)
            {
                numberOfFixtures = 2;
                //numberOfFixtures = Int32.Parse(GridView1.Rows[0].Cells[3].Text);
                CallCode(LeagueID);
            }
            else
            {
                Label6.Visible = true;
                Label6.Text = "There are not enough teams added to the league or tournament to generate fixtures";
            }
            
        }
    }
   
}