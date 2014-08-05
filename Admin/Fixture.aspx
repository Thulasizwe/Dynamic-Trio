<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Fixture.aspx.cs" Inherits="Fixture" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:TextBox ID="some" runat="server">

    </asp:TextBox>
        <br />
    </div>
        <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
        <br />
        <br />
        <asp:Table ID="Table1" runat="server">
        </asp:Table>
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
    </form>
</body>
</html>
