<%@ Control Language="C#" AutoEventWireup="true" CodeFile="gridDisplayData.ascx.cs" Inherits="gridDisplay" %>
<%@ Register assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxGridView" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<table>
    <tr>
        <td>
            <dx:ASPxGridView runat="server" EnableTheming="True" ID="GVData" 
                Theme="Office2010Black" EnableRowsCache="True" EnableViewState="True" OnInit="InitEvents" >
                <Settings ShowGroupPanel="True" />
                <SettingsDataSecurity AllowDelete="False" AllowEdit="False" 
                AllowInsert="False" />
            </dx:ASPxGridView>
        </td>
    </tr>

</table>