﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxTabControl" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register tagPrefix="gd" tagName="CustomGrid" src="~/gridDisplayData.ascx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxClasses" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxNewsControl" tagprefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxRoundPanel" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxPanel" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
     <link rel="stylesheet" type="text/css" href="~/Content/NewStyles.css"/>
    <title>Home Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
             <fc:menu ID="menu" runat="server" />  
    </div>
    <div>
        <br/><br/>
        <dx:ASPxLabel ID="WelcomeLabel" runat="server" Text="" Theme="iOS"  
             Font-Bold="True" Font-Size="Large">
        </dx:ASPxLabel><br/><br/>
        
        <dx:ASPxPageControl ActiveTabIndex="0" runat="server" Width="100%">
            <TabPages>
                <dx:TabPage Text="Events">
                    <ContentCollection>
                        <dx:ContentControl>
                            <gd:CustomGrid runat="server" ID="EventGrid" />
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Ratings">
                    <ContentCollection>
                        <dx:ContentControl>
                            <dx:ASPxRoundPanel runat="server" ID="DepartmentRating" HeaderText="My Department's Rating: " Theme="BlackGlass" HorizontalAlign="Center" Width="200px">
                                <PanelCollection>
                                   <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                       <dx:ASPxLabel runat="server" ID="DepRatingLabel" Text="." Font-Size="XXLarge"/>
                                   </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxRoundPanel>
                            <br/><br/>
                            <dx:ASPxRoundPanel runat="server" ID="CompanyRating" HeaderText="My Company's Rating: " Theme="BlackGlass" HorizontalAlign="Center" Width="200px">
                                <PanelCollection>
                                   <dx:PanelContent ID="PanelContent1" runat="server" SupportsDisabledAttribute="True">
                                       <dx:ASPxLabel runat="server" ID="CompRatingLabel" Text="." Font-Size="XXLarge"/>
                                   </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxRoundPanel>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Messages">
                    <ContentCollection>
                        <dx:ContentControl>
                            <dx:ASPxRoundPanel runat="server" HeaderText="News Feed">
                                <PanelCollection>
                                    <dx:PanelContent>
                                        <dx:ASPxNewsControl ID="NewsControl" runat="server" Theme="iOS" Width="400px" RowPerPage="4">
                                        </dx:ASPxNewsControl>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxRoundPanel>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
            </TabPages>
        </dx:ASPxPageControl>
    </div>
    </form>
</body>
</html>
