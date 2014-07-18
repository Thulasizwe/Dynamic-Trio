<%@ Page Language="C#" CodeFile="~/League.aspx.cs" Inherits="_League"%>
<%@ Register TagPrefix="My" TagName="WebUserControl" Src="~/WebUserControl.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<body>
   <form id="form1" runat="server">
<div>
    <My:WebUserControl runat="server" ID="WebUserControl" UserName="John Doe" UserAge="45" UserCountry="Australia" />
    <asp:Label runat="server" id="HelloWorldLabel"></asp:Label>
    <br /><br />
    <asp:TextBox runat="server" id="TextInput" /> 
    <asp:Button runat="server" id="GreetButton" text="Say Hello!" />
    <asp:DropDownList runat="server" id="GreetList" autopostback="true"  onselectedindexchanged="GreetList_SelectedIndexChanged">
    <asp:ListItem value="no one">No one</asp:ListItem>
    <asp:ListItem value="world">World</asp:ListItem>
    <asp:ListItem value="universe">Universe</asp:ListItem>
</asp:DropDownList>
</div>
</form>
</body>
</html>