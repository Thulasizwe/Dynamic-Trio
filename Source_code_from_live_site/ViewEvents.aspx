<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewEvents.aspx.cs" Inherits="ViewEvents" %>
<%@ Register TagPrefix="cf" TagName="EventFilter" Src="~/Events.ascx" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
         <fc:menu ID="menu" runat="server" />  
    </div>
    <div align="center" style="height: 150px">
         <br />
         <br />
         <br />
    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="View Events" 
         Theme="iOS"  
         Font-Bold="True" Font-Size="XX-Large" align="center">
    </dx:ASPxLabel>

     </div>
    <div>
       <cf:EventFilter ID="filter" runat="server"></cf:EventFilter>

    </div>
    </form>
</body>
</html>
