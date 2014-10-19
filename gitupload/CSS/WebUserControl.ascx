<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WebUserControl.ascx.cs" Inherits="WebUserControl" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxMenu" Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPopupControl" tagprefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<div id="header">
    <div id="logo">
        <img alt="img" height="150" src="images/logo.png" width="150" />
    </div>
</div>
<p/>
<style >
    .styleOne {text-align: right; vertical-align: bottom}
</style>

<table runat="server" ID="menuTable" width="100%" class="set">
 <tr>
  <td>
    &nbsp;<dx:ASPxMenu ID="MainMenu" runat="server" ShowPopOutImages="True" 
    AutoSeparators="RootOnly" style="text-align: left;" 
    Theme="iOS" EnableTheming="True" BackColor="#3399FF" ForeColor="White" >
    
        <Items>
        <dx:MenuItem Text="Home">
        </dx:MenuItem>
        <dx:MenuItem Text="Captain" >
        </dx:MenuItem>
        <dx:MenuItem Text="Teams">
        </dx:MenuItem>
        <dx:MenuItem Text="Message">
        </dx:MenuItem>
        <dx:MenuItem Text="Manage Account"></dx:MenuItem>
        <dx:MenuItem Text="Admin" NavigateUrl="~/Admin.aspx">
        </dx:MenuItem>
        <dx:MenuItem Text="Logout">
        </dx:MenuItem>
    </Items>
</dx:ASPxMenu>
  </td><td runat="server">
    <dx:ASPxButton runat="server" ID="PopupButton" Text="About" Theme="iOS" BackColor ="#3399FF" ForeColor ="White"></dx:ASPxButton>
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


