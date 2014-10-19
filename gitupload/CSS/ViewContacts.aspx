<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewContacts.aspx.cs" Inherits="ViewContacts" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>
<%@ Register TagPrefix="cf" TagName="ContactFilter" Src="~/Contacts.ascx" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
		<link rel="stylesheet" type="text/css" href="style/style.css">
        <title></title>
        <script type="text/javascript" src="sliderengine/jquery.js"></script><script type="text/javascript" src="sliderengine/jquery.hislider.js"></script>
    <script type="text/javascript" src="style/scrpt.js"></script>
    </head>
<body id="body" >
    <form runat="server">
    
         <fc:menu ID="menu" runat="server" />  
 
 <div id="wrapper">
    <div id="content">
       <cf:ContactFilter ID="filter" runat="server"></cf:ContactFilter>
     </div>
      </div>
    </form>
</body>
</html>
