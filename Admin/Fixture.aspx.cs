using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Fixture : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        CallCode();
    }
    public string Home { get; set; }
    public string Away { get; set; }

    void CallCode()
    {
        string[] teams = new string[] { "A", "B", "C", "D" };
        List<Fixture> fixtures = CalculateFixtures(teams);
        /*DataTable table = new DataTable();
        TableRow row1 = new TableRow();
        TableCell tCell = new TableCell();
        for(int i = 0; i < fixtures.Count;i++)
        {
            some.Text += fixtures[i].Home;
            Label2.Text += fixtures[i].Away;
            tCell.Text = "Row " + i + ", Cell " + (i+1);
            row1.Cells.Add(tCell);
            Table1.Rows.Add(row1);  
            //GridView1.
            //GridView1.
        }
         */

        GridView1.DataSource = fixtures;
        GridView1.DataBind();
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