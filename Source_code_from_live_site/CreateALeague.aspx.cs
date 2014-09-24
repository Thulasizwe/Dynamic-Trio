using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class CreateALeague : System.Web.UI.Page
    {
        private int game_ID;
        private string score;
        private int team_ID;
        private string league_name;
        private int league_ID;
        
        private SqlConnection sqlCon = new SqlConnection(@"Data Source=contactASPDB.mssql.somee.com;Initial Catalog=contactASPDB;Integrated Security=True");
        public CreateALeague()
        {
            score = "";
            league_name = "";
            team_ID = 0;
            game_ID = 0;
            league_ID = 0;
        }
        public CreateALeague(int GameID, string Score, int TeamID, string LeagueName, int LeagueID)
        {
            score = Score;
            league_name = LeagueName;
            team_ID = TeamID;
            game_ID = GameID;
            league_ID = LeagueID;
        }
    protected void submit(object sender, EventArgs e)    
     {
         LeagueNameError.Visible = false;
         GameNameError.Visible = false;
         bool valid = true;
        if (leagueName.Text.Length < 1)
        {
            LeagueNameError.Visible = true;
            valid = false;
        }
        if (gameType.SelectedIndex == 0)
        {
            GameNameError.Visible = true;
            valid = false;
        }
        if (gameType.SelectedItem.Text == "FIFA")
            {
                string Str = TextBox1.Text.Trim();
                double Num;
                bool isNum = double.TryParse(Str, out Num);
                if (!isNum)
                {
                    amountError.Visible = true;
                    valid = false;
                }
                else
                    amountError.Visible = false;
                Str = TextBox2.Text.Trim();
                isNum = double.TryParse(Str, out Num);
                if (!isNum)
                {
                    againstError.Visible = true;
                    valid = false;
                }
                else
                    againstError.Visible = false;
                
            
            TextBox1.Visible = true;
            TextBox2.Visible = true;
            against.Visible = true;
            amount.Visible = true;
        }
        if (valid == true )
        {
            SqlCommand sqlCommand = new SqlCommand("INSERT INTO SetupLeague VALUES ('" + leagueName.Text + "','" + TextBox1.Text + "','" + TextBox2.Text + "','" + gameType.SelectedIndex + "')", sqlCon);
            sqlCommand.ExecuteNonQuery();
            LeagueNameError.Visible = false;
            GameNameError.Visible = false ;
            LeagueSuccess.Text = "The league " + leagueName.Text + " has been created and " + gameType.SelectedIndex; 
            LeagueSuccess.Visible = true;
        }
  

     }
        public string Score
        {
            get
            {
                return score;
            }
            set
            {
                score = value;
            }
        }

        public string League_Name
        {
            get
            {
                return league_name;
            }
            set
            {
                league_name = value;
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
        public int Game_ID
        {
            get
            {
                return game_ID;
            }
            set
            {
                game_ID = value;
            }
        }

        public int League_ID
        {
            get
            {
                return league_ID;
            }
            set
            {
                league_ID = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            sqlCon.Open();
            if (gameType.SelectedIndex > 0)
            {
                if (gameType.SelectedItem.Text == "FIFA")
                {
                    TextBox1.Visible = true;
                    TextBox2.Visible = true;
                    against.Visible = true;
                    amount.Visible = true;
                }
             
            }
            else
            {
                TextBox1.Visible = false;
                TextBox2.Visible = false;
                against.Visible = false;
                amount.Visible = false;
            }

        }
      
        protected void gameType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (gameType.SelectedItem.Text == "FIFA")
            {
                TextBox1.Visible = true;
                TextBox2.Visible = true;
                against.Visible = true;
                amount.Visible = true;
            }
            else
            {
                TextBox1.Visible = false;
                TextBox2.Visible = false;
                against.Visible = false;
                amount.Visible = false;
            }
            //this.
            //this.Refresh();
        }
}