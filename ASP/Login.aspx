﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxPopupControl" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxRoundPanel" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxPanel" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
        <link rel="stylesheet" type="text/css" href="~/Content/NewStyles.css"/>
    <title></title>
        <style type="text/css">
            .style1
            {
                height: 22px;
            }
        </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:PlaceHolder id="ContentPlaceHolderLogo" runat="server">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/logo.jpg" />
        </asp:PlaceHolder>    
    </div>
        <div>
        <%--    ***OLD WAY WITH NORMAL ASP.NET CONTROLS***
            <asp:Label runat="server" ID="FailureText" Visible="False" ForeColor="red" Text="Username or password is incorrect" ></asp:Label>
            <section id="loginSection">
                <ul>
                    <asp:Label ID="usernameLabel" runat="server" AssociatedControlID="UserName" >Username:   </asp:Label>
                    <asp:TextBox runat="server" ID="UserName"></asp:TextBox>
                    <asp:Label runat="server" ID="UserNameError" Text="Please enter your username." ForeColor="red" Visible="False"></asp:Label>
                    
                    <br/>
                    <br/>
                    <asp:Label ID="passwordLabel" runat="server" AssociatedControlID="UserPassword" >Password:   </asp:Label>
                    <asp:TextBox runat="server" ID="UserPassword" TextMode="Password"></asp:TextBox>
                    <asp:Label runat="server" ID="PasswordError" Text="Please enter your password." ForeColor="red" Visible="False"></asp:Label>
                    
                    
                </ul>
                <asp:PlaceHolder ID="PlaceHolder1" runat="server">
                    <asp:Button runat="server" ID="LoginButton" Text="Log in" OnClick="LoginButton_Click"/>
                </asp:PlaceHolder>
            </section>--%>
            
            <dx:ASPxPopupControl runat="server" ShowCloseButton="False" 
                PopupVerticalAlign="WindowCenter" PopupHorizontalAlign="WindowCenter" 
                Modal="True" ShowOnPageLoad="True" CloseAction="None" AllowDragging="False" 
                HeaderText="Login" Height="165px" Width="262px" Theme="BlackGlass">
               <ContentCollection>
                  <dx:PopupControlContentControl runat="server">
                      <dx:ASPxRoundPanel runat="server" ShowHeader="False" Theme="Office2010Black">
                          <PanelCollection>
                            <dx:PanelContent ID="PanelContent2" runat="server">
                                  <table runat="server" align="center">
                                      <tr runat="server" align="center">
                                          <td>
                                            <asp:Label ID="FailureText" runat="server" AssociatedControlID="UserName" Text="Username: "></asp:Label>
                                            <asp:TextBox runat="server" ID="UserName"></asp:TextBox>
                                              <br />
                                            <asp:Label runat="server" ID="UserNameError" Text="Please enter your username." ForeColor="red" Visible="False"></asp:Label>
                                          </td>
                                       </tr><tr><td></td></tr><tr runat="server" align="center">
                                          <td>
                                            <asp:Label ID="passwordLabel" runat="server" AssociatedControlID="UserPassword" Text="Password: "></asp:Label>
                                            <asp:TextBox runat="server" ID="UserPassword" TextMode="Password"></asp:TextBox>
                                              <br />
                                            <asp:Label runat="server" ID="PasswordError" Text="Please enter your password." ForeColor="red" Visible="False"></asp:Label>
                                          </td>
                                       </tr><tr><td class="style1"></td></tr><tr runat="server" align="center">
                                          <td>
                                            <dx:ASPxButton runat="server" ID="LoginButton" Text="Log in" 
                                                  OnClick="LoginButton_Click" Theme="Moderno"/>
                                              &nbsp;&nbsp;
                                            <asp:LinkButton runat="server" OnClick="guestLogin" Text="Register" ></asp:LinkButton>
                                          </td>
                                       </tr>
                                  </table>
                           </dx:PanelContent>
                        </PanelCollection>
                       </dx:ASPxRoundPanel>
                  </dx:PopupControlContentControl>
               </ContentCollection>  
            </dx:ASPxPopupControl>
        </div>
    </form>
</body>
</html>
