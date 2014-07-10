using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// The captain class must inherit the user class. 
/// It will have extra functionality that a normal team member cannot perform.
/// </summary>


public class Captain
{
    private string name;
    private int team_ID;
    
    
    public Captain(string name, int teamID)
	{
        Name = name;
        TeamID = team_ID;
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
}