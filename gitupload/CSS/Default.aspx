<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxNewsControl" tagprefix="dx" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>


<html>
	<head runat="server">
		<link rel="stylesheet" type="text/css" href="style/style.css">
        <title></title>
        <script type="text/javascript" src="sliderengine/jquery.js"></script><script type="text/javascript" src="sliderengine/jquery.hislider.js"></script>
       <script type="text/javascript" src="style/scrpt.js"></script>
	</head>
<body id="body1">
    <form id="form3" runat="server">
        <fc:menu ID="menu2" runat="server" /> 
 
             <div id='hislider1' style=" max-width:960px;  max-height:360px;height:100%; margin: 0 auto;">
        	
        	    <noscript>The slider is powered by <strong>Hi Slider</strong>, a easy jQuery image slider from <a target="_blank" href="hislider.com">hislider.com</a>. Please enable JavaScript to view.</noscript><div class="hi-about-text" style="display:none">This jQuery slider was created with the free <a style="color:#FFF;" href="http://hislider.com" target="_blank">Hi Slider</a> for WordPress plugin,Joomla & Drupal Module from hislider.com.<br /><br /><a style="color:#FFF;" href="#" class="hi-about-ok">OK</a></div><div class="hi-slider-watermark"  style="display:none"><a href="http://hislider.com" target="_blank">hislider.com</a></div>
            </div>
		<div id = "wrapper">
            <asp:Label ID="WelcomeLabel" runat="server" Font-Size="X-Large"></asp:Label>
			
			<div id="content">
                
                    <table border="1">
                        <tr>
                            <td>
                        <h2>
                            Latest Results
                        </h2>
                                <p>
                                    &nbsp;</p>
                                <asp:TextBox ID="TextBox1" runat="server" ReadOnly="True" TextMode="MultiLine"></asp:TextBox>
                        <br />
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="SqlDataSource1" DataKeyNames="ResultID" Visible="False">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
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
            SelectCommand="SELECT TAlias1.ResultID, TAlias2.TeamName, TAlias3.TeamName AS Expr1, TAlias1.FirstScore, TAlias1.SecondScore, TAlias4.LeagueName FROM Results AS TAlias1 INNER JOIN SetupTeams AS TAlias2 ON TAlias1.HomeTeamID = TAlias2.TeamID INNER JOIN SetupTeams AS TAlias3 ON TAlias1.AwayTeamID = TAlias3.TeamID INNER JOIN SetupLeague AS TAlias4 ON TAlias1.FKLeagueID = TAlias4.LeagueID " 
            
            
            
            
            
            
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
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="false" Name="Param1" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="HomeTeam" Type="String" />
                <asp:Parameter Name="AwayTeam" Type="String" />
                <asp:Parameter Name="FKLeagueID" Type="String" />
                <asp:Parameter Name="FirstScore" />
                <asp:Parameter Name="SecondScore" />
                <asp:Parameter Name="FKGameID" Type="String" />
                <asp:Parameter Name="ResultID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <a href="Default.aspx">
            Go back to home page
        </a>
                        
                            </td>
                            <td>
                        <h2>
                            Matchday</h2>
                                <p>
                                    <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Height="64px" ReadOnly="True"></asp:TextBox>
                        </p>
                        <br />
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource2" Visible="False">
            <Columns>
                <asp:BoundField DataField="TeamName" HeaderText="Home Team" 
                    SortExpression="TeamName" />
                <asp:BoundField DataField="Expr1" HeaderText="Away Team" 
                    SortExpression="Expr1" />
                <asp:BoundField DataField="DateTime" HeaderText="DateTime" 
                    SortExpression="DateTime" />
                <asp:BoundField DataField="LeagueName" HeaderText="League Name" 
                    SortExpression="LeagueName" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>"  
            SelectCommand="SELECT TAlias2.TeamName, TAlias3.TeamName AS Expr1, TAlias1.DateTime, TAlias4.LeagueName FROM Fixtures AS TAlias1 INNER JOIN SetupTeams AS TAlias2 ON TAlias1.HomeTeamID = TAlias2.TeamID INNER JOIN SetupTeams AS TAlias3 ON TAlias1.AwayTeamID = TAlias3.TeamID INNER JOIN SetupLeague AS TAlias4 ON TAlias1.LeagueID = TAlias4.LeagueID">
        </asp:SqlDataSource>
        <br />
        
        
        <br />
        <a href="Default.aspx">
            Go back to home page
        </a>

                            </td>
                        </tr>
                     </table> 
                    <dx:ASPxNewsControl ID="ASPxNewsControl1" runat="server" Width="400px">
                    </dx:ASPxNewsControl>
                
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

