<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GenerateLeagues.aspx.cs" Inherits="GenerateLeagues" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label Text="Please select a league" runat="server">
        </asp:Label>
         <asp:DropDownList runat="server" ID="gameType" runat="server" DataSourceID="SqlDataSource1" 
            DataTextField="LeagueName" DataValueField="LeagueID" >
          
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:EsportsConnectionString %>" 
            SelectCommand="SELECT * FROM [SetupLeague]"></asp:SqlDataSource>
        <asp:Button onClick="generate"Text="Generate league" runat="server"/>

    </div>
    </form>
</body>
</html>
