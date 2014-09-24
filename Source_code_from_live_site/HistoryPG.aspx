<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HistoryPG.aspx.cs" Inherits="HistoryPG" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>
<%@ Register TagPrefix="hf" TagName="HistoryFilter" Src="~/HistoryControl.ascx" %>

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
        <div>
            <hf:HistoryFilter ID="filter" runat="server"></hf:HistoryFilter>
        </div>
    </form>
</body>
</html>
