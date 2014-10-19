<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreateALeague.aspx.cs" Inherits="CreateALeague" %>
<!DOCTYPE html>

<<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>

<html><head id="Head1" runat="server"><link rel="stylesheet" type="text/css" href="style/style.css"><title></title><script type="text/javascript" src="sliderengine/jquery.js"></script><script type="text/javascript" src="sliderengine/jquery.hislider.js"></script><script type="text/javascript" src="style/scrpt.js"></script></head><body id="body"><form id="form1" runat="server">
        <fc:menu ID="menu1" runat="server" /> 
    <div id="wrapper">
        <h1 style="text-align:center;">
    Create a League
        </h1>
      
    <div id ="content">
            <div id="serch">
   

        <Label runat ="server">
            Enter league name
        </Label>
        <asp:textbox runat="server" ID="leagueName" />
        <Label runat="server" ID="LeagueNameError" Text="Please enter a league name" ForeColor="red" Visible="False"></Label>
        <br />
        <Label runat ="server">
            Pick a game
        </Label>
        
        <asp:DropDownList ID="gameType" runat="server" DataSourceID="SqlDataSource1" 
            DataTextField="GameName" DataValueField="GameID" 
            onselectedindexchanged="gameType_SelectedIndexChanged" AutoPostBack="True" Height="27px">
          
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>" 
            SelectCommand="SELECT * FROM [SetupGame]">
        </asp:SqlDataSource>
        <asp:Label runat="server" ID="GameNameError" Text="Please select a game" ForeColor="red" Visible="False"></asp:Label>
        <br />
        <br />
        <br />
        <Label runat ="server" ID ="amount" Text="Enter amount of teams"> 
        
        </Label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
         <Label runat="server" ID="amountError" Text="Please enter the number of teams allowed in the league" ForeColor="red" Visible="False"></Label>
        <br />
        <Label runat ="server" ID="against" Text="Games against each team">
        
        </Label>
        
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
         <Label runat="server" ID="againstError" Text="Please enter the amount of games against each team" ForeColor="red" Visible="False"></Label>
        <br />
        <br />
        
        <asp:Button runat="server" OnClick="submit" text="Add a league" CssClass="btn" Width="152px"/>
        <asp:Label runat="server" ID="LeagueSuccess" Text="League created successfully" ForeColor="green" Visible="False"></asp:Label>
        <br />
        <a href="Default.aspx">
            Go back to home page
        k to home page
        </a>
    </div>
        </div>
        </div>
    </form>
        
</body>
</html>
