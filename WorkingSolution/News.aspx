<%@ Page Language="C#" AutoEventWireup="true" CodeFile="News.aspx.cs" Inherits="News" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 73%;
            margin-bottom: 0px;
        }
        .style3
        {
            color: #0066FF;
            font-size: x-large;
            font-family: "Times New Roman";
        }
        .style2
        {
            width: 158px;
        }
        .style4
        {
            width: 158px;
            height: 45px;
        }
        .style5
        {
            height: 45px;
        }
        #TextArea1
        {
            height: 125px;
            width: 421px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <table align="center" class="style1">
        <caption class="style3">
            <h1>
                Publish News</h1>
        </caption>
        <tr>
            <td class="style4">
                Header</td>
            <td class="style5">
                <asp:TextBox ID="TextBox1" runat="server" Height="28px" Width="232px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style2">
                League</td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" 
                    DataSourceID="SqlDataSource1" DataTextField="LeagueName" 
                    DataValueField="LeagueID" Height="16px" Width="231px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:EsportsConnectionString %>" 
                    SelectCommand="SELECT * FROM [SetupLeague]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style2">
                Content</td>
            <td>
                <textarea rows="100" cols="100" id="TextArea1" name="S1" runat="server"></textarea></td>
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
                <asp:Button ID="Button1" runat="server" onclick="Button1_Click1" Text="Publish" 
                    Width="74px" />
            </td>
        </tr>
    </table>
    <br />
      <a href="Default.aspx">
            Go back to home page
        </a>
    </div>
    </form>
</body>
</html>
