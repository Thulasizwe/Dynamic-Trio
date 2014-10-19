<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewLog.aspx.cs" Inherits="ViewLog" %>

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
					<li><a href="viewLog.aspx" class="active">Log</a></li>
					<li><a href="Teams.aspx">Teams</a></li>
					<li><a href="Leagues.aspx">Leagues</a></li>
					<li><a href="Results.aspx">Results</a></li>
                    <li><a href="Message.aspx">Message</a></li>
					<li><a href="javascript:void(0);">Logouts</a></li>
				</ul>
			</header>
             <div id='hislider1' style=" max-width:960px;  max-height:360px;height:100%; margin: 0 auto;">
        	
        	    <noscript>The slider is powered by <strong>Hi Slider</strong>, a easy jQuery image slider from <a target="_blank" href="hislider.com">hislider.com</a>. Please enable JavaScript to view.</noscript><div class="hi-about-text" style="display:none">This jQuery slider was created with the free <a style="color:#FFF;" href="http://hislider.com" target="_blank">Hi Slider</a> for WordPress plugin,Joomla & Drupal Module from hislider.com.<br /><br /><a style="color:#FFF;" href="#" class="hi-about-ok">OK</a></div><div class="hi-slider-watermark"  style="display:none"><a href="http://hislider.com" target="_blank">hislider.com</a></div>
            </div>
		<div id = "wrapper">
			
			<div id="content">
				<form runat="server">
                     <asp:DropDownList ID="LeagueName" runat="server" DataSourceID="SqlDataSource2" 
            DataTextField="LeagueName" DataValueField="LeagueID" >

        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>" 
            
            SelectCommand="SELECT LeagueID , LeagueName FROM SetupLeague ">

        </asp:SqlDataSource>
	                 <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Show Log" />
	<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" 
            EmptyDataText="There are no data records to display.">
            <Columns>
                <asp:BoundField HeaderText="Position" />
                <asp:BoundField DataField="LeagueName" HeaderText="LeagueName" 
                    SortExpression="LeagueName" />
                <asp:BoundField DataField="TeamName" HeaderText="TeamName" 
                    SortExpression="TeamName" />
                <asp:BoundField DataField="Wins" HeaderText="Wins" SortExpression="Wins" />
                <asp:BoundField DataField="Draws" HeaderText="Draws" SortExpression="Draws" />
                <asp:BoundField DataField="Loses" HeaderText="Loses" SortExpression="Loses" />
                <asp:BoundField DataField="Points" HeaderText="Points" 
                    SortExpression="Points" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>"  
            DeleteCommand="DELETE FROM [LeagueLog] WHERE [LogID] = @LogID" 
            InsertCommand="INSERT INTO [LeagueLog] ([FKLeagueID], [FKTeamID], [Wins], [Draws], [Loses], [Points]) VALUES (@FKLeagueID, @FKTeamID, @Wins, @Draws, @Loses, @Points)" 
            SelectCommand="SELECT TAlias2.LeagueName, TAlias3.TeamName, TAlias1.Wins, TAlias1.Draws, TAlias1.Loses, TAlias1.Points FROM LeagueLog AS TAlias1 INNER JOIN SetupLeague AS TAlias2 ON TAlias1.FKLeagueID = TAlias2.LeagueID INNER JOIN SetupTeams AS TAlias3 ON TAlias1.FKTeamID = TAlias3.TeamID WHERE (TAlias1.FKLeagueID = @Param1) ORDER BY TAlias1.Points DESC " 
            UpdateCommand="UPDATE [LeagueLog] SET [FKLeagueID] = @FKLeagueID, [FKTeamID] = @FKTeamID, [Wins] = @Wins, [Draws] = @Draws, [Loses] = @Loses, [Points] = @Points WHERE [LogID] = @LogID">
            <DeleteParameters>
                <asp:Parameter Name="LogID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="FKLeagueID" Type="Int32" />
                <asp:Parameter Name="FKTeamID" Type="Int32" />
                <asp:Parameter Name="Wins" Type="Int32" />
                <asp:Parameter Name="Draws" Type="Int32" />
                <asp:Parameter Name="Loses" Type="Int32" />
                <asp:Parameter Name="Points" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="FKLeagueID" Type="Int32" />
                <asp:Parameter Name="FKTeamID" Type="Int32" />
                <asp:Parameter Name="Wins" Type="Int32" />
                <asp:Parameter Name="Draws" Type="Int32" />
                <asp:Parameter Name="Loses" Type="Int32" />
                <asp:Parameter Name="Points" Type="Int32" />
                <asp:Parameter Name="LogID" Type="Int32" />
            </UpdateParameters>
            <SelectParameters >
                <asp:Parameter Name="Param1" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Default.aspx">Go back to home page</asp:HyperLink>
    
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
