using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// The captain class must inherit the user class. 
/// It will have extra functionality that a normal team member cannot perform.
/// </summary>
public class League
{
    private string team_name;
    private string team_captain;
    private string team_zone;
    private int team_ID;

    public League()
    {
        team_name = "";
        team_captain = "";
        team_ID = 0;
        team_zone = "";
    }
    public League(string teamZone, int teamID, string teamName, string teamCaptain)
	{
        team_name = teamName;
        team_ID = teamID;
        team_captain = teamCaptain;
        team_zone = teamZone;
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

}
