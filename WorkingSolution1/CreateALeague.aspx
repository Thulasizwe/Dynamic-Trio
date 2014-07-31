<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreateALeague.aspx.cs" Inherits="CreateALeague" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h2>
            Create a League page
        </h2>

        <asp:Label runat ="server">
            Enter league name
        </asp:Label>
        <asp:textbox runat="server" ID="leagueName" />
        <asp:Label runat="server" ID="LeagueNameError" Text="Please enter a league name" ForeColor="red" Visible="False"></asp:Label>
        <br />
        <asp:Label runat ="server">
            Pick a game
        </asp:Label>
        
        <asp:DropDownList ID="gameType" runat="server" DataSourceID="SqlDataSource1" 
            DataTextField="GameName" DataValueField="GameID" 
            onselectedindexchanged="gameType_SelectedIndexChanged" AutoPostBack="true">
          
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:EsportsConnectionString %>" 
            SelectCommand="SELECT [GameName], [GameID] FROM [SetupGame]">
        </asp:SqlDataSource>
        <asp:Label runat="server" ID="GameNameError" Text="Please select a game" ForeColor="red" Visible="False"></asp:Label>
        <br />
        <br />
        <br />
        <asp:Label runat ="server" ID ="amount" Text="Enter amount of teams"> 
        
        </asp:Label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
         <asp:Label runat="server" ID="amountError" Text="Please enter the number of teams allowed in the league" ForeColor="red" Visible="False"></asp:Label>
        <br />
        <asp:Label runat ="server" ID="against" Text="Games against each team">
        
        </asp:Label>
        
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
         <asp:Label runat="server" ID="againstError" Text="Please enter the amount of games against each team" ForeColor="red" Visible="False"></asp:Label>
        <br />
        <br />
        
        <asp:Button runat="server" OnClick="submit" text="Add a league"/>
        <asp:Label runat="server" ID="LeagueSuccess" Text="League created successfully" ForeColor="green" Visible="False"></asp:Label>
        <br />
        <a href="Default.aspx">
            Go back to home page
        </a>
    </div>
    </form>
</body>
</html>
