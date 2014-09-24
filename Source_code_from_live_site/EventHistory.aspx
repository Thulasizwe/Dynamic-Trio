<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EventHistory.aspx.cs" Inherits="EventHistory" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>

<%@ Register assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>
<%@ Register TagPrefix="gDF" TagName="gridDataFilter" Src="~/gridDisplayData.ascx" %>
<%@ Register TagPrefix="asp" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style2
        {
            height: 34px;
        }
        .auto-style3
        {
            height: 71px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <menu>
        <fc:menu ID="menu" runat="server" />
    </menu>
    </div>
    <table width="70%">
        <tr>
            <td class="auto-style2">
            <dx:ASPxComboBox ID="lbxCompany" runat="server" AutoPostBack="True" ValueType="System.String" OnSelectedIndexChanged="lbxCompany_Change">
            </dx:ASPxComboBox>
                </td>
            <td class="auto-style2">
            <dx:ASPxComboBox ID="lbxSite" runat="server" AutoPostBack="True" ValueType="System.String" OnSelectedIndexChanged="lbxSite_Change">
            </dx:ASPxComboBox>
                </td>
            <td class="auto-style2">
            <dx:ASPxComboBox ID="lbxDepartment" runat="server" AutoPostBack="True" ValueType="System.String" OnSelectedIndexChanged="lbxDepartment_Change">
            </dx:ASPxComboBox>
                </td>
             <td class="auto-style2">
            <dx:ASPxComboBox ID="lbxPerson" runat="server" AutoPostBack="True" ValueType="System.String" OnSelectedIndexChanged="lbxPerson_Change" >
            </dx:ASPxComboBox>
                </td>
            <td class="auto-style2">
                <dx:aspxButton runat="server" ID="btnClear" Enabled="False" AutoPostBack="True" OnClick="RefreshComboBoxes" Text="Clear">
                    
                </dx:aspxButton>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxButton ID="btnActiveSearches" runat="server" Height="20px" Text="Enable Filters" Visible="False" AutoPostBack="True" OnClick="btnActiveSearches_Click"></dx:ASPxButton>
                </td>
        </tr>
            <gDF:gridDataFilter ID="grdDataFilter" runat="server" Visible="False"> </gDF:gridDataFilter>
        </table>
           <%-- <asp:ASPxButton ID="btnActiveSearches" runat="server" Height="40px" Text="Hello World"></asp:ASPxButton>--%>

    </form>
</body>
</html>
