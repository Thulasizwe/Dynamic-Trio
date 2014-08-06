<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Fixture.aspx.cs" Inherits="Fixture" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="FixtureID" HeaderText="FixtureID" 
                    InsertVisible="False" ReadOnly="True" SortExpression="FixtureID" />
                <asp:BoundField DataField="HomeTeam" HeaderText="HomeTeam" 
                    SortExpression="HomeTeam" />
                <asp:BoundField DataField="AwayTeam" HeaderText="AwayTeam" 
                    SortExpression="AwayTeam" />
                <asp:BoundField DataField="DateTime" HeaderText="DateTime" 
                    SortExpression="DateTime" />
            </Columns>
        </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:EsportsConnectionString %>" 
        SelectCommand="SELECT * FROM [Fixtures]"></asp:SqlDataSource>
    <br />
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="TeamID" DataSourceID="SqlDataSource2" Visible="False">
        <Columns>
            <asp:BoundField DataField="TeamID" HeaderText="TeamID" InsertVisible="False" 
                ReadOnly="True" SortExpression="TeamID" />
            <asp:BoundField DataField="TeamName" HeaderText="TeamName" 
                SortExpression="TeamName" />
            <asp:BoundField DataField="TeamCaptain" HeaderText="TeamCaptain" 
                SortExpression="TeamCaptain" />
            <asp:BoundField DataField="TeamZone" HeaderText="TeamZone" 
                SortExpression="TeamZone" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:EsportsConnectionString %>" 
        SelectCommand="SELECT * FROM [SetupTeams]"></asp:SqlDataSource>
    </form>
</body>
</html>
