<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreateATeam.aspx.cs" Inherits="CreateATeam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <h2>
            Create a Team page
        </h2>
        <asp:Label runat="server">
            Enter a team name
        </asp:Label>
        <asp:textbox runat="server" ID="teamName" />
        <asp:Label runat="server" ID="TeamNameError" Text="Please enter a team name" ForeColor="red" Visible="False"></asp:Label>
        <br />
        <asp:Label runat="server">
            Select team captain
        </asp:Label>
        <asp:DropDownList ID="teamCaptain" runat="server" DataSourceID="SqlDataSource2" 
            DataTextField="UserName" DataValueField="UserName">

        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:EsportsConnectionString %>" 
            SelectCommand="SELECT UserName FROM SetupUser WHERE (FKUserType = @Param1)">
            <SelectParameters>
                <asp:Parameter DefaultValue="2" Name="Param1" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label runat="server" ID="TeamCaptainError" Text="Please select a captain" ForeColor="red" Visible="False"></asp:Label>
        <br />
        <asp:Label runat="server">
            Select team zone
        </asp:Label>
        <asp:DropDownList ID="TeamZone" runat="server" DataSourceID="SqlDataSource3" 
            DataTextField="TeamZone" DataValueField="TeamZoneID">

        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:EsportsConnectionString %>" 
            SelectCommand="SELECT [TeamZone], [TeamZoneID] FROM [TeamZone]">
        </asp:SqlDataSource>
        <asp:Label runat="server" ID="TeamZoneError" Text="Please select a team zone" ForeColor="red" Visible="False"></asp:Label>
        <br />
        <asp:Button runat="server" OnClick="submit" text="Add a team"/>
        <asp:Label runat="server" ID="TeamSuccess" Text="Team created successfully" ForeColor="green" Visible="False"></asp:Label>
        <br />
        <a href="Default.aspx">
            Go back to home page
        </a>
    </div>
    </form>
</body>
</html>
