<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewContacts.aspx.cs" Inherits="ViewContacts" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>
<%@ Register TagPrefix="cf" TagName="ContactFilter" Src="~/Contacts.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="~/Content/NewStyles.css"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
         <fc:menu ID="menu" runat="server" />  
    </div>
    <div>
       <cf:ContactFilter ID="filter" runat="server"></cf:ContactFilter>

    </div>
    </form>
</body>
</html>
