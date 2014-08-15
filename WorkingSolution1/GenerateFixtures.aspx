<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GenerateFixtures.aspx.cs" Inherits="GenerateFixtures" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
        <br />
        <br />
        <asp:DropDownList ID="DropDownList1" runat="server" 
            DataSourceID="SqlDataSource1" DataTextField="LeagueName" 
            DataValueField="LeagueName">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:EsportsConnectionString2 %>" 
            SelectCommand="SELECT [LeagueName] FROM [SetupLeague]"></asp:SqlDataSource>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
            Text="Generate Fixtures" />
        <br />
        <br />
      <a href="Default.aspx">
            Go back to home page
        </a>
    
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource2" Enabled="False" Visible="False">
            <Columns>
                <asp:BoundField DataField="TeamName" HeaderText="TeamName" 
                    SortExpression="TeamName" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:EsportsConnectionString %>" 
            SelectCommand="SELECT [TeamName] FROM [SetupTeams]"></asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
