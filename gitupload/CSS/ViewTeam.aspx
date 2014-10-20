<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewTeam.aspx.cs" Inherits="ViewTeam" %>

<%@ Register assembly="DevExpress.Web.v14.1, Version=14.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxNewsControl" tagprefix="dx" %>

<html>
	<head runat="server">
		<link rel="stylesheet" type="text/css" href="style/style.css">
        <title></title>
        <script type="text/javascript" src="sliderengine/jquery.js"></script><script type="text/javascript" src="sliderengine/jquery.hislider.js"></script>
       
	</head>
	<body>
		<div id="header">
			<div id = "logo">
				<img src = "images/logo.png" width = "150" height = "150" alt="img"/>
			</div>
		</div>
		<header class="blue">
				<ul>
					<li><a href="Default.aspx" >Home</a></li>
					<li><a href="viewLog.aspx">Log</a></li>
					<li><a href="Teams.aspx" class="active">Teams</a></li>
					<li><a href="Leagues.aspx">Leagues</a></li>
					<li><a href="Message.aspx">Message</a></li>
					<li><a href="javascript:void(0);">Logouts</a></li>
				</ul>
			</header>
             <div id='hislider1' style=" max-width:960px;  max-height:360px;height:100%; margin: 0 auto;">
        	
        	    <noscript>The slider is powered by <strong>Hi Slider</strong>, a easy jQuery image slider from <a target="_blank" href="hislider.com">hislider.com</a>. Please enable JavaScript to view.</noscript><div class="hi-about-text" style="display:none">This jQuery slider was created with the free <a style="color:#FFF;" href="http://hislider.com" target="_blank">Hi Slider</a> for WordPress plugin,Joomla & Drupal Module from hislider.com.<br /><br /><a style="color:#FFF;" href="#" class="hi-about-ok">OK</a></div><div class="hi-slider-watermark"  style="display:none"><a href="http://hislider.com" target="_blank">hislider.com</a></div>
            </div>
		<div id = "wrapper">
            
			<div id="content">
                <form id="form1" runat="server">
                    <br />
                    <asp:Image ID="Image1" runat="server" />
&nbsp;
                    <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                    <br />
                    <br />
                    Captain:
                    <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
                    <br />
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Join Team" />
                    <br />
                    <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" 
                    EmptyDataText="There are no data records to display." >
                    <Columns>
                        <asp:BoundField HeaderText="Position" 
                        />
                    <asp:BoundField DataField="TeamName" HeaderText="Team Name" 
                        SortExpression="TeamName" />
                    <asp:BoundField DataField="Wins" HeaderText="W" 
                        SortExpression="Wins" />
                    <asp:BoundField DataField="Draws" HeaderText="D" 
                        SortExpression="Draws" />
                        <asp:BoundField DataField="Loses" HeaderText="L" 
                        SortExpression="Loses" />
                        <asp:BoundField DataField="Points" HeaderText="Points" 
                        SortExpression="Points" />
                    </Columns>
                    </asp:GridView>
                    
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>"  
            SelectCommand="SELECT T1.TeamName, T.Wins, T.Draws, T.Loses, T.Points
FROM LeagueLog AS T
INNER JOIN SetupTeams AS T1 ON T1.TeamID = T.FKTeamID
ORDER BY T.Points
DESC
" >
        <SelectParameters >
                <asp:Parameter Name="Param1" />
            </SelectParameters>    
        </asp:SqlDataSource>
                    Most Recent Results<br />
                    <br />
                    <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSource2" 
                    EmptyDataText="There are no data records to display." >
                    <Columns>
                    <asp:BoundField DataField="LeagueName" HeaderText="LeagueName" 
                        SortExpression="LeagueName" />
                    <asp:BoundField DataField="TeamName" HeaderText="Home Team" 
                        SortExpression="TeamName" />
                    <asp:BoundField DataField="Expr1" HeaderText="Away Team" 
                        SortExpression="Expr1" />
                        <asp:BoundField DataField="FirstScore" HeaderText="Home Score" 
                        SortExpression="FirstScore" />
                        <asp:BoundField DataField="SecondScore" HeaderText="Away Score" 
                        SortExpression="SecondScore" />
                    </Columns>
                    </asp:GridView>
                    
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>"  
            SelectCommand="SELECT TAlias4.LeagueName, TAlias2.TeamName , TAlias3.TeamName AS Expr1, TAlias1.FirstScore , TAlias1.SecondScore 
FROM Results AS TAlias1 
INNER JOIN SetupTeams AS TAlias2 ON TAlias1.HomeTeamID = TAlias2.TeamID 
INNER JOIN SetupTeams AS TAlias3 ON TAlias1.AwayTeamID = TAlias3.TeamID 
INNER JOIN SetupLeague AS TAlias4 ON TAlias1.FKLeagueID = TAlias4.LeagueID 
WHERE (TAlias1.HomeTeamID = @Param1 OR TAlias1.AwayTeamID = @Param1)" >
        <SelectParameters >
                <asp:Parameter Name="Param1" />
            </SelectParameters>    
        </asp:SqlDataSource>
        &nbsp;Upcoming Fixtures
            <br />
                    <asp:GridView ID="GridView3" runat="server" DataSourceID="SqlDataSource3" 
                    EmptyDataText="There are no data records to display." >
                    <Columns>
                    <asp:BoundField DataField="TeamName" HeaderText="Home Team" 
                        SortExpression="TeamName" />
                    <asp:BoundField DataField="Expr1" HeaderText="Away Team" 
                        SortExpression="Expr1" />
                    <asp:BoundField DataField="DateTime" HeaderText="DateTime" 
                        SortExpression="DateTime" />
                    </Columns>
                    </asp:GridView>
                    
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>"  
            SelectCommand="SELECT TAlias2.TeamName, TAlias3.TeamName AS Expr1 , TAlias1.DateTime
FROM Fixtures AS TAlias1 
INNER JOIN SetupTeams AS TAlias2 ON TAlias1.HomeTeamID = TAlias2.TeamID 
INNER JOIN SetupTeams AS TAlias3 ON TAlias1.AwayTeamID = TAlias3.TeamID 
WHERE (TAlias1.HomeTeamID = @Param1 OR TAlias1.AwayTeamID = @Param1)" >
        <SelectParameters >
                <asp:Parameter Name="Param1" />
            </SelectParameters>    
        </asp:SqlDataSource>
                    <asp:GridView ID="GridView4" Visible ="false" runat="server" DataSourceID="SqlDataSource4" 
                    EmptyDataText="There are no data records to display." >
                    <Columns>
                    <asp:BoundField DataField="TeamName" HeaderText="Home Team" 
                        SortExpression="TeamName" />
                    <asp:BoundField DataField="FirstName" HeaderText="First Name" 
                        SortExpression="FirstName" />
                    <asp:BoundField DataField="Surname" HeaderText="Surname" 
                        SortExpression="Surname" />
                        <asp:BoundField DataField="TeamZone" HeaderText="TeamZone" 
                        SortExpression="TeamZone" />
                    </Columns>
                    </asp:GridView>
                    
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>"  
            SelectCommand="SELECT TAlias1.TeamName, TAlias2.FirstName, TAlias2.Surname, TAlias1.TeamZone
FROM SetupTeams AS TAlias1
INNER JOIN SetupUser AS TAlias2 ON TAlias1.TeamCaptain = TAlias2.IDUser 
WHERE TAlias1.TeamID = @Param1" >
        <SelectParameters >
                <asp:Parameter Name="Param1" />
            </SelectParameters>    
        </asp:SqlDataSource>
        <br />
        <a href="Default.aspx">
            Go back to home page
        </a>
            </form>
            </div>
    
               
               
			</div>
			
		
		<div id = "news">
				<h1> News </h1>
		</div>
		<div id = "upcoming">
				<h1> Upcoming </h1>
			<div id="in">
				<img src="images/chelsea.jpg" width="80" height="80"/><br><br>
				<img src="images/v.png" width="40" height="40"/><br><br>
				<img src="images/liverpool.png" width="80" height="80"/>
			</div>
		</div>

		<br/>
		
	</body>
</html>

