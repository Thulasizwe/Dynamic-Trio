<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewLog.aspx.cs" Inherits="ViewLog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" 
            EmptyDataText="There are no data records to display.">
            <Columns>
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
            ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString1 %>" 
            DeleteCommand="DELETE FROM [LeagueLog] WHERE [LogID] = @LogID" 
            InsertCommand="INSERT INTO [LeagueLog] ([FKLeagueID], [FKTeamID], [Wins], [Draws], [Loses], [Points]) VALUES (@FKLeagueID, @FKTeamID, @Wins, @Draws, @Loses, @Points)" 
            SelectCommand="SELECT TAlias2.LeagueName, TAlias3.TeamName, TAlias1.Wins, TAlias1.Draws, TAlias1.Loses, TAlias1.Points FROM LeagueLog AS TAlias1 INNER JOIN SetupLeague AS TAlias2 ON TAlias1.FKLeagueID = TAlias2.LeagueID INNER JOIN SetupTeams AS TAlias3 ON TAlias1.FKTeamID = TAlias3.TeamID" 
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
        </asp:SqlDataSource>
        <br />
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Default.aspx">Go back to home page</asp:HyperLink>
    
    </div>
    </form>
</body>
</html>
