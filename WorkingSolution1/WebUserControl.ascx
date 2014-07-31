<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WebUserControl.ascx.cs" Inherits="WebUserControl" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxMenu" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<%@ Register assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPopupControl" tagprefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<asp:PlaceHolder ID="PlaceHolder1" runat="server" >
        <a target="blank" href="http://direvco.co.za/"><asp:Image ID="Image1" runat="server" ImageUrl="~/Images/logo.jpg" /></a>
</asp:PlaceHolder>
<p/>
<style >
    .styleOne { text-align: right; vertical-align: bottom}
</style>

<table runat="server" ID="menuTable" width="100%">
 <tr>
  <td>
    &nbsp;<dx:ASPxMenu ID="MainMenu" runat="server" ShowPopOutImages="True" 
    AutoSeparators="RootOnly"  Orientation="Horizontal" style="text-align: left;" 
    Theme="Glass" >
    <Items>
        <dx:MenuItem Text="File">
            <Items>
            <dx:MenuItem Text="Home" NavigateUrl="~/Default.aspx"></dx:MenuItem>
            <dx:MenuItem Text="Log out" NavigateUrl="~/Login.aspx"></dx:MenuItem>
            </Items>
        </dx:MenuItem>
        <dx:MenuItem Text="Admin" >
            <Items>
            <dx:MenuItem Text="Add User" NavigateUrl="~/Register.aspx"></dx:MenuItem>
            <dx:MenuItem Text="Edit Users" NavigateUrl="~/manageUsers.aspx"></dx:MenuItem>
            <dx:MenuItem Text="Send Message" NavigateUrl="~/sendMessage.aspx"></dx:MenuItem>
            <dx:MenuItem Text="Structure Admin" NavigateUrl="~/admindustry.aspx"></dx:MenuItem>
            <dx:MenuItem Text="Create a league" NavigateUrl="~/CreateALeague.aspx"></dx:MenuItem>
            <dx:MenuItem Text="Create a team" NavigateUrl="~/CreateATeam.aspx"></dx:MenuItem>
            <dx:MenuItem Text="Dispute/Publish results" NavigateUrl="~/Results.aspx"></dx:MenuItem>
            <dx:MenuItem Text="News" NavigateUrl="~/News.aspx"></dx:MenuItem>
            <dx:MenuItem Text="Captain" NavigateUrl="~/Captain.aspx"></dx:MenuItem>
            </Items>
        </dx:MenuItem>
        <dx:MenuItem Text="Contact">
            <Items>
 
            <dx:MenuItem Text="View Contacts" NavigateUrl="~/ViewContacts.aspx"></dx:MenuItem>
            <dx:MenuItem Text="View Contact History" NavigateUrl="~/HistoryPG.aspx"></dx:MenuItem>
            </Items>
        </dx:MenuItem>
        <dx:MenuItem Text="Events">
            <Items>
            <dx:MenuItem Text="Add Event"  NavigateUrl="~/AddEvents.aspx"></dx:MenuItem>
            <dx:MenuItem Text="View Event" NavigateUrl="~/ViewEvents.aspx"></dx:MenuItem>
            <dx:MenuItem Text="View Event History" NavigateUrl="~/EventHistory.aspx"></dx:MenuItem>
            </Items>
        </dx:MenuItem>
        <dx:MenuItem Text="Manage Account" NavigateUrl="~/userAccount.aspx"></dx:MenuItem>
        <%--<dx:MenuItem Text="About"></dx:MenuItem>--%>
    </Items>
</dx:ASPxMenu>
  </td><td runat="server" class="styleOne">
    <dx:ASPxButton runat="server" ID="PopupButton" Text="About" Theme="Glass"></dx:ASPxButton>
  </td>  
 </tr>
</table>
<dx:ASPxPopupControl ID="popup" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderText="About E-Sports Manager"
                        AllowDragging="True" PopupElementID="PopupButton" CloseAction="OuterMouseClick" PopupAction="LeftMouseClick" ShowCloseButton="True" runat="server">
  <ContentCollection>    
    <dx:PopupControlContentControl runat="server" >
        <asp:panel ID="popupPanel" runat="server">
            <table>
                <tr>
                   <td>
            <a href="http://derivco.co.za" target="_blank"><dx:ASPxImage runat="server" ImageUrl="~/Images/logo.jpg" ></dx:ASPxImage></a></td> <td><dx:ASPxImage ID="ASPxImage1" runat="server" ImageUrl="~/Images/about.jpg" ></dx:ASPxImage> </td>
            </tr>
            <tr>
                <td>
                E-sports League <br/>
                Copyright © 2013 E-Sports
                </td>
            </tr>
            </table>
        </asp:panel>
    </dx:PopupControlContentControl>
  </ContentCollection>  
</dx:ASPxPopupControl>


