<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewFixtures.aspx.cs" Inherits="ViewFixtures" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1">
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="Data Source=localhost;Initial Catalog=contactASPDB;Integrated Security=True" 
            ProviderName="System.Data.SqlClient" 
            SelectCommand="SELECT TAlias2.TeamName, TAlias3.TeamName AS Expr1, TAlias1.DateTime, TAlias4.LeagueName FROM Fixtures AS TAlias1 INNER JOIN SetupTeams AS TAlias2 ON TAlias1.HomeTeamID = TAlias2.TeamID INNER JOIN SetupTeams AS TAlias3 ON TAlias1.AwayTeamID = TAlias3.TeamID INNER JOIN SetupLeague AS TAlias4 ON TAlias1.LeagueID = TAlias4.LeagueID">
        </asp:SqlDataSource>
        <br />
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Default.aspx">Go back to home page</asp:HyperLink>
    
    </div>
    </form>
</body>
</html>
