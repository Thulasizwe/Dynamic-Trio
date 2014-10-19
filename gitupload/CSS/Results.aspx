<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Results.aspx.cs" Inherits="Results" %>

<!DOCTYPE html>


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
					<li><a href="Teams.aspx">Teams</a></li>
					<li><a href="Leagues.aspx">Leagues</a></li>
					<li><a href="Results.aspx" class="active">Results</a></li>
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
    <div>
       <h2>
            Results
        </h2>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" DataKeyNames="ResultID" Width="503px">
            <Columns>
                <asp:BoundField DataField="ResultID" HeaderText="ResultID" 
                    SortExpression="ResultID" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="TeamName" HeaderText="Home Team" 
                    SortExpression="TeamName" />
                <asp:BoundField DataField="Expr1" HeaderText="Away Team" 
                    SortExpression="Expr1" />
                <asp:BoundField DataField="FirstScore" HeaderText="FirstScore" 
                    SortExpression="FirstScore" />
                <asp:BoundField DataField="SecondScore" HeaderText="SecondScore" 
                    SortExpression="SecondScore" />
                <asp:BoundField DataField="LeagueName" HeaderText="LeagueName" 
                    SortExpression="LeagueName" />
                
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>" 
            DeleteCommand="DELETE FROM [Results] WHERE [ResultID] = @ResultID" 
            InsertCommand="INSERT INTO [Results] ([HomeTeam], [AwayTeam], [FKLeagueID], [Score], [FKGameID], [Confirmed]) VALUES (@HomeTeam, @AwayTeam, @FKLeagueID, @Score, @FKGameID, @Confirmed)" 
            SelectCommand="SELECT TAlias1.ResultID, TAlias2.TeamName, TAlias3.TeamName AS Expr1, TAlias1.FirstScore, TAlias1.SecondScore, TAlias4.LeagueName, TAlias1.Confirmed FROM Results AS TAlias1 INNER JOIN SetupTeams AS TAlias2 ON TAlias1.HomeTeamID = TAlias2.TeamID INNER JOIN SetupTeams AS TAlias3 ON TAlias1.AwayTeamID = TAlias3.TeamID INNER JOIN SetupLeague AS TAlias4 ON TAlias1.FKLeagueID = TAlias4.LeagueID" 
            
            
            
            
            
            
            UpdateCommand="UPDATE Results SET HomeTeamID = @HomeTeam, AwayTeamID = @AwayTeam, FKLeagueID = @FKLeagueID, FirstScore = @FirstScore, SecondScore = @SecondScore, FKGameID = @FKGameID, Confirmed = @Confirmed WHERE (ResultID = @ResultID)">
            <DeleteParameters>
                <asp:Parameter Name="ResultID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="HomeTeam" Type="String" />
                <asp:Parameter Name="AwayTeam" Type="String" />
                <asp:Parameter Name="FKLeagueID" Type="String" />
                <asp:Parameter Name="Score" Type="String" />
                <asp:Parameter Name="FKGameID" Type="String" />
                <asp:Parameter Name="Confirmed" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="HomeTeam" Type="String" />
                <asp:Parameter Name="AwayTeam" Type="String" />
                <asp:Parameter Name="FKLeagueID" Type="String" />
                <asp:Parameter Name="FirstScore" />
                <asp:Parameter Name="SecondScore" />
                <asp:Parameter Name="FKGameID" Type="String" />
                <asp:Parameter Name="Confirmed" Type="String" />
                <asp:Parameter Name="ResultID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <a href="Default.aspx">
            Go back to home page
        
              
			</div>
		</form>	
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
