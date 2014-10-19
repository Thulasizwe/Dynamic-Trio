<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreateATeam.aspx.cs" Inherits="CreateATeam" %>
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
            Create a Team</h1>

        <div id ="content">
            <div id="serch">
        <Label runat="server">
           
            Enter a team name
        </Label>
         
        <asp:textbox runat="server" ID="teamName" BackColor="White" /> 
        <asp:Label runat="server" ID="TeamNameError" Text="Please enter a team name" ForeColor="red" Visible="False"></asp:Label>
        <br />
                <br/>
        <Label runat="server">
            Select team captain<br />
&nbsp;</Label><asp:DropDownList ID="teamCaptain" runat="server" DataSourceID="SqlDataSource2" 
            DataTextField="UserName" DataValueField="UserName" Height="25px" Width="170px">
        </asp:DropDownList>
                 <br />
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>" 
            
            SelectCommand="SELECT UserName FROM SetupUser WHERE (FKUserType = @Param1)">
            <SelectParameters>
                <asp:Parameter DefaultValue="2" Name="Param1" />
            </SelectParameters>
        </asp:SqlDataSource>
                 <br />
        <asp:Label runat="server" ID="TeamCaptainError" Text="Please select a captain" ForeColor="red" Visible="False"></asp:Label>
        <br />
        <Label runat="server">
            Select team zone
        </Label>
                 <br />
        <asp:DropDownList ID="TeamZone" runat="server" DataSourceID="SqlDataSource3" 
            DataTextField="TeamZone" DataValueField="TeamZoneID" Height="26px" Width="170px">
        </asp:DropDownList>
                 <br />
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>" 
            SelectCommand="SELECT * FROM [TeamZone]">
        </asp:SqlDataSource>
                 <br />
        <asp:Label runat="server" ID="TeamZoneError" Text="Please select a team zone" ForeColor="red" Visible="False"></asp:Label>
        <br />
        <asp:Button runat="server" OnClick="submit" text="Add a team" class="btn"/>
                 <br />
        <asp:Label runat="server" ID="TeamSuccess" Text="Team created successfully" ForeColor="#66FF66" Visible="False" Font-Bold="True" Font-Names="Comic Sans MS" Font-Size="Large"></asp:Label>
        <br />
        <a href="Default.aspx">
            Go back to home page
        </a>
        </div>
    </div>
        </div>
    </form>
</body>
</html>
