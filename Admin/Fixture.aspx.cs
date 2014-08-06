using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Fixture : System.Web.UI.Page
{
    public SqlConnection con = new SqlConnection(@"Data Source=localhost;Initial Catalog=Esports;Integrated Security=True");
    protected void Page_Load(object sender, EventArgs e)
    {
        con.Open();
        CallCode();
    }
    public string Home { get; set; }
    public string Away { get; set; }

    void CallCode()
    {
        string[] teams = new string[GridView2.Rows.Count];
            for (int i = 0; i < GridView2.Rows.Count ;i++)
            {
                teams[i] = GridView2.Rows[i].Cells[1].Text;
            }
        TextBox1.Text = "" + teams.Length;
        List<Fixture> fixtures = CalculateFixtures(teams);
        for(int i = 0; i < fixtures.Count;i++)
        {
            
            SqlCommand cmd = new SqlCommand("Insert into Fixtures values('" + fixtures[i].Home + "','" + fixtures[i].Away + "','" + i + "')", con);
            cmd.ExecuteNonQuery();
        }
        con.Close();
    }

    List<Fixture> CalculateFixtures(string[] teams)
    {
        //create a list of all possible fixtures (order not important)
        List<Fixture> fixtures = new List<Fixture>();
        for (int i = 0; i < teams.Length; i++)
        {
            for (int j = 0; j < teams.Length; j++)
            {
                if (teams[i] != teams[j])
                {
                    fixtures.Add(new Fixture() { Home = teams[i], Away = teams[j] });
                }
            }
        }

        fixtures.Reverse();//reverse the fixture list as we are going to remove element from this and will therefore have to start at the end

        //calculate the number of game weeks and the number of games per week
        int gameweeks = (teams.Length - 1) * 2;
        int gamesPerWeek = gameweeks / 2;

        List<Fixture> sortedFixtures = new List<Fixture>();

        //foreach game week get all available fixture for that week and add to sorted list
        for (int i = 0; i < gameweeks; i++)
        {
            sortedFixtures.AddRange(TakeUnique(fixtures, gamesPerWeek));
        }

        return sortedFixtures;
    }

    List<Fixture> TakeUnique(List<Fixture> fixtures, int gamesPerWeek)
    {
        List<Fixture> result = new List<Fixture>();

        //pull enough fixture to cater for the number of game to play
        for (int i = 0; i < gamesPerWeek; i++)
        {
            //loop all fixture to find an unused set of teams
            for (int j = fixtures.Count - 1; j >= 0; j--)
            {
                //check to see if any teams in current fixtue have already been used this game week and ignore if they have
                if (!result.Any(r => r.Home == fixtures[j].Home || r.Away == fixtures[j].Home || r.Home == fixtures[j].Away || r.Away == fixtures[j].Away))
                {
                    //teams not yet used
                    result.Add(fixtures[j]);
                    fixtures.RemoveAt(j);
                }
            }
        }

        return result;
    }
}