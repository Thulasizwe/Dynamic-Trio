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
    private SqlConnection sqlCon = new SqlConnection(@"Data Source=localhost;Initial Catalog=Esports;Integrated Security=True");
    protected void Page_Load(object sender, EventArgs e)
    {
        //Text
        sqlCon.Open();
        numberOfFixtures = 2;
        Label1.Visible = true;

    }
    public string Home { get; set; }
    public string Away { get; set; }

    void CallCode(int LeagueID)
    {
        string[] teamss = new string[GridView1.Rows.Count];
        gameweeks = GridView1.Rows.Count;
        gamesPerWeek = GridView1.Rows.Count;
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
           teamss[i] = GridView1.Rows[i].Cells[0].Text;
        }
        List<GenerateFixtures> fixtures = CalculateFixtures(teamss);
        int a = 0;
        for (int i = 0; i < fixtures.Count; i++)
        {
            a = a + 1;
            if (a <= gamesPerWeek)
            {
                SqlCommand sqlCommand = new SqlCommand("INSERT INTO Fixtures VALUES ('" + fixtures[i].Home + "','" + fixtures[i].Away + "','" + "Week 1" + "')", sqlCon);
                sqlCommand.ExecuteNonQuery();
            }
            else if (a <= (gamesPerWeek * 2))
            {
                SqlCommand sqlCommand = new SqlCommand("INSERT INTO Fixtures VALUES ('" + fixtures[i].Home + "','" + fixtures[i].Away + "','" + "Week 2" + "')", sqlCon);
                sqlCommand.ExecuteNonQuery();
            }
            else if (a <= (gamesPerWeek * 3))
            {
                SqlCommand sqlCommand = new SqlCommand("INSERT INTO Fixtures VALUES ('" + fixtures[i].Home + "','" + fixtures[i].Away + "','" + "Week 3" + "')", sqlCon);
                sqlCommand.ExecuteNonQuery();
            }
            else if (a <= (gamesPerWeek * 4))
            {
                SqlCommand sqlCommand = new SqlCommand("INSERT INTO Fixtures VALUES ('" + fixtures[i].Home + "','" + fixtures[i].Away + "','" + "Week 4" + "')", sqlCon);
                sqlCommand.ExecuteNonQuery();
            }
            else if (a <= (gamesPerWeek * 5))
            {
                SqlCommand sqlCommand = new SqlCommand("INSERT INTO Fixtures VALUES ('" + fixtures[i].Home + "','" + fixtures[i].Away + "','" + "Week 5" + "')", sqlCon);
                sqlCommand.ExecuteNonQuery();
            }
            else if (a <= (gamesPerWeek * 6))
            {
                SqlCommand sqlCommand = new SqlCommand("INSERT INTO Fixtures VALUES ('" + fixtures[i].Home + "','" + fixtures[i].Away + "','" + "Week 6" + "')", sqlCon);
                sqlCommand.ExecuteNonQuery();
            }

        }
    }

    List<GenerateFixtures> CalculateFixtures(string[] teams)
    {
        List<GenerateFixtures> fixtures = new List<GenerateFixtures>();
        int c = 0;
        for (int i = 0; i < teams.Length; i++)
            {
                for (int j = 0; j < teams.Length; j++)
                {
                    if (teams[i] != teams[j])
                    {
                        fixtures.Add(new GenerateFixtures() { Home = teams[i], Away = teams[j] });
                        c = c + 1;
                    }
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

        return fixtures;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        int LeagueID = DropDownList1.SelectedIndex;
        GridView1.Enabled = true;
        GridView1.Visible = true;
        CallCode(LeagueID);
        Label1.Text = "Fixtures have been generated";
    }
}