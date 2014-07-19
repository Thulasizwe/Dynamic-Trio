<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Captain.aspx.cs" Inherits="Captain" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 49%;
            margin-bottom: 0px;
        }
        .style2
        {
            width: 158px;
        }
        .style3
        {
            color: #0066FF;
            font-size: x-large;
            font-family: "Times New Roman";
        }
        .style4
        {
            width: 100%;
        }
        .style5
        {
            width: 150px;
        }
        .style6
        {
            font-size: xx-large;
            color: #3399FF;
        }
        .style7
        {
            width: 150px;
            height: 23px;
        }
        .style8
        {
            height: 23px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    <table align="center" class="style1">
        <caption class="style3">
            <h1>
                <strong>Join League</strong></h1>
        </caption>
        <tr>
            <td class="style2">
                League
            </td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" 
                    DataSourceID="SqlDataSource1" DataTextField="LeagueName" 
                    DataValueField="IDLeague" Height="21px" Width="126px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:EsportsConnectionString %>" 
                    SelectCommand="SELECT * FROM [League]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style2">
                Team
            </td>
            <td>
                <asp:DropDownList ID="DropDownList2" runat="server" 
                    DataSourceID="SqlDataSource2" DataTextField="TeamName" DataValueField="TeamID" 
                    Height="16px" Width="132px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:EsportsConnectionString %>" 
                    SelectCommand="SELECT * FROM [SetupTeams]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style2">
                Score</td>
            <td>
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style2">
                Game</td>
            <td>
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style2">
                <asp:Label ID="Label1" runat="server"></asp:Label>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                &nbsp;</td>
            <td>
                <asp:Button ID="Button1" runat="server" onclick="Button1_Click1" Text="Join" 
                    Width="50px" />
            </td>
        </tr>
    </table>
    <div style="border-style: outset; border-width: thin; height: 219px">
        <table class="style4">
            <caption class="style6">
                <strong>Upload Results</strong></caption>
            <tr>
                <td class="style7">
                    Your Team</td>
                <td class="style8">
                    <asp:DropDownList ID="YourTeamDrop" runat="server" 
                        DataSourceID="SqlDataSource2" DataTextField="TeamName" DataValueField="TeamID">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style5">
                    Opponent</td>
                <td>
                    <asp:DropDownList ID="OpponentDrop" runat="server" 
                        DataSourceID="SqlDataSource2" DataTextField="TeamName" DataValueField="TeamID">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style5">
                    Your score</td>
                <td>
                    <asp:TextBox ID="YourText" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style5">
                    Opponent Score</td>
                <td>
                    <asp:TextBox ID="OpponentText" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style5">
                    Proof Image</td>
                <td>
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="style5">
                    <asp:Label ID="UploadLabel" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:Button ID="Button2" runat="server" onclick="Button2_Click" 
                        Text="Upload Result" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
