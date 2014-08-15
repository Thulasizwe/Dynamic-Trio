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
    
    </div>
    </form>
</body>
</html>
