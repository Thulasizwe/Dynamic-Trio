<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GenerateFixtures.aspx.cs" Inherits="GenerateFixtures" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>
<html>
	<head id="Head1" runat="server">
		<link rel="stylesheet" type="text/css" href="style/style.css">
        <title></title>
        <script type="text/javascript" src="sliderengine/jquery.js"></script><script type="text/javascript" src="sliderengine/jquery.hislider.js"></script>
	    <script type="text/javascript" src="style/scrpt.js"></script>
    </head>
	<body id="body">
    <form id="form1" runat="server">
        <fc:menu ID="menu1" runat="server" /> 
    <div id="wrapper">
       <h1 style="text-align:center;">
            Generate Fixtures</h1>

        <div id ="content">
            <div id="serch">
    
        <p>
            &nbsp;Select League:</p>
                <p>
            &nbsp;<asp:DropDownList ID="DropDownList1" runat="server" 
                DataSourceID="SqlDataSource2" DataTextField="LeagueName" 
                DataValueField="LeagueID" Height="25px" Width="185px" 
                >
            </asp:DropDownList>
&nbsp;<asp:Label ID="Label5" runat="server" BackColor="Red" Text="Label" Visible="False"></asp:Label>
        </p>
        <p>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>" 
                SelectCommand="SELECT * FROM [SetupLeague]"></asp:SqlDataSource>
&nbsp;</p>
        <p>
            Select either League or Tournament:</p>
                <p>
                    &nbsp;&nbsp;<asp:DropDownList 
                ID="DropDownList2" runat="server" Height="25px" Width="181px">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem>League</asp:ListItem>
                <asp:ListItem>Tournament</asp:ListItem>
            </asp:DropDownList>
&nbsp;<asp:Label ID="Label4" runat="server" BackColor="Red" Text="Label" Visible="False"></asp:Label>
        &nbsp;</p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click1" Text="Generate" CssClass="btn" />
&nbsp;&nbsp;&nbsp;</p>
        <p>
            <asp:Label ID="Label1" runat="server" Text="Label" Visible="False" 
                BackColor="#009933"></asp:Label>
        &nbsp;<asp:Label ID="Label6" runat="server" Text="Label" Visible="False" 
                BackColor="Red"></asp:Label>
        </p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" Visible="False">
            <Columns>
                <asp:BoundField DataField="TeamID" HeaderText="TeamID" 
                    SortExpression="TeamID" />
                <asp:BoundField DataField="TeamName" HeaderText="TeamName" 
                    SortExpression="TeamName" />
                <asp:BoundField DataField="NumberOfTeams" HeaderText="Number Of Teams" 
                    SortExpression="NumberOfTeams" />
                <asp:BoundField DataField="GamesAgainst" HeaderText="Games Against" 
                    SortExpression="GamesAgainst" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>" 
            SelectCommand="SELECT T.TeamID, T.TeamName , T2.NumberOfTeams , T2.GamesAgainst	
FROM SetupTeams AS T 
INNER JOIN LeagueTeams AS T1 ON T1.TeamID = T.TeamID 
INNER JOIN SetupLeague AS T2 ON T2.LeagueID = T1.LeagueID
WHERE T1.LeagueID = @Param1 ">
                    <SelectParameters >
                <asp:Parameter Name="Param1" />
            </SelectParameters>
        </asp:SqlDataSource>
        <p>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Default.aspx">Go back to home page</asp:HyperLink>
        </p>
    </form>
                </div>
            </div>
        </div>
</body>
</html>
