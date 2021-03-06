﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Products.ascx.cs" Inherits="Products" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<%@ Register assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxPopupControl" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxRoundPanel" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxPanel" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxRatingControl" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>


<%@ Register assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxLoadingPanel" tagprefix="dx" %>


<head>
    <link rel="stylesheet" type="text/css" href="~/Content/NewStyles.css"/>
    <title></title>
</head>
<body>
    <br/>
<asp:Label ID="SearchFilter" runat="server" Text="Select a Company"></asp:Label>

<asp:DropDownList ID="ddlSelection" runat="server" >
</asp:DropDownList>
    
<br />
<br />
<asp:Button ID="btnFilter" runat="server" Text="Filter" OnClick="btnFilter_Click" />

<div id="Div1" runat="server" align="right">
    <div id="divBasicSearch" runat="server">
    <label id="lblBSearch">Search Product: </label>&nbsp;
    <asp:TextBox ID="TxtSearch" runat="server"></asp:TextBox>
    <br/>
        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
    </div>
</div>

<div runat="server" ID="GridDiv" Visible="False">
    <dx:ASPxLabel runat="server" ID="rateLabel" Text="Click a row to rate that product."/><br/><br/>
    
    <dx:ASPxButton runat="server" Text="Rate" OnClick="InitialiseRatePopup" ID="OpenRateButton"></dx:ASPxButton>
    &nbsp;
    <dx:ASPxButton runat="server" Text="View Other Ratings" OnClick="InitialiseHistoryPopup" ID="OtherButton"></dx:ASPxButton>
    <br/><br/>
    <dx:ASPxGridView ID="ProductGrid" runat="server" EnableTheming="True" Theme="Office2010Black" EnableRowsCache="True" EnableViewState="True" >
        <Settings ShowGroupPanel="True" />
        <SettingsBehavior></SettingsBehavior>
        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
    </dx:ASPxGridView>
</div>

   <dx:ASPxPopupControl ID="historyPopup"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderText="Rating History" AllowDragging="true"
                        PopupElementID="OtherButton" PopupAction="LeftMouseClick"  Modal="True" CloseAction="OuterMouseClick" ShowCloseButton="True" runat="server">
      <ContentCollection>    
        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" >
            <asp:panel ID="Panel1" runat="server">
                <dx:ASPxRoundPanel ID="HistPanel" runat="server" ShowHeader="False" HorizontalAlign="Center">
                        <PanelCollection>
                            <dx:PanelContent ID="PanelContent2" runat="server">
                                <div runat="server" ID="HistGridDiv" Visible="False">
                                <dx:ASPxGridView ID="HistoryGrid" runat="server" EnableTheming="True" Theme="Office2010Black" EnableRowsCache="True" >
                                    <Settings ShowGroupPanel="True" />
                                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                </dx:ASPxGridView>
                                </div>
                                <dx:ASPxLabel runat="server" ID="ErrorLabel" Text ="This product has no ratings yet." Visible="False"/>
                             </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>
            </asp:panel>
        </dx:PopupControlContentControl>
      </ContentCollection>  
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="popup" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderText="Rate Product" AllowDragging="true"
                       PopupElementID="OpenRateButton" PopupAction="LeftMouseClick" Modal="True" CloseAction="OuterMouseClick" ShowCloseButton="True" runat="server">
      <ContentCollection>    
        <dx:PopupControlContentControl runat="server" >
            <asp:panel ID="popupPanel" runat="server">
                        <dx:ASPxRoundPanel ID="ratingPanel" runat="server" ShowHeader="False" HorizontalAlign="Center">
                        <PanelCollection>
                            <dx:PanelContent ID="PanelContent1" runat="server">
                                <div>
                                    <asp:Label runat="server" Text="Rating"></asp:Label>
                                    <dx:ASPxRatingControl ID="ProductRating" FillPrecision="Full" ItemCount="10" Titles="1,2,3,4,5,6,7,8,9,10" runat="server" Theme="iOS">
                                    </dx:ASPxRatingControl>
                                </div>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>
                    <br/>
                       Department: <asp:DropDownList ID="ddlDepartment" runat="server"></asp:DropDownList>
                    <br/><br/>
                   <asp:Label ID="CommentLabel" runat="server" AssociatedControlID="Comments" >Comments:  <br/></asp:Label>
                   <asp:TextBox runat="server" ID="Comments" AutoCompleteType="Disabled" TextMode="MultiLine" Rows="5" Height="100px" Width="100%"></asp:TextBox>
                <dx:ASPxButton runat="server" Text="Rate" ID="RateButton" OnClick="RateProduct"></dx:ASPxButton>
            </asp:panel>
        </dx:PopupControlContentControl>
      </ContentCollection>  
    </dx:ASPxPopupControl>
</body>



