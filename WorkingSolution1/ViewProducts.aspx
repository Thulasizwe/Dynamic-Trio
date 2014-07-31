<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewProducts.aspx.cs" Inherits="ViewProducts" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>
<%@ Register TagPrefix="cf" TagName="ProductFilter" Src="~/Products.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="~/Content/NewStyles.css"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
         <fc:menu ID="menu" runat="server" />  
    </div>
    <div>
       <cf:ProductFilter ID="filter" runat="server"></cf:ProductFilter>

    </div>
    </form>
</body>
</html>