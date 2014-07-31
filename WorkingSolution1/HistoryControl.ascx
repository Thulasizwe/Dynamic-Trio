﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HistoryControl.ascx.cs" Inherits="HistoryControl" %>
<%@ Register assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<head>
    <link rel="stylesheet" type="text/css" href="~/Content/NewStyles.css"/>
    <title></title>
</head>
<body>
    <br/>
    <div>
    Display contacts by:   <asp:DropDownList ID="ddlFilter" runat="server" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged" AutoPostBack="true">
        <asp:ListItem Value="0">Select Filter Type</asp:ListItem>
        <asp:ListItem Value="Single_User">Single User</asp:ListItem>
        <asp:ListItem Value="All_User">All User</asp:ListItem>
    </asp:DropDownList>
    </div>
    <br/>
    <div runat="server" id="divSpecUser" Visible="False">
        <asp:Label ID="ScreenNameLabel" runat="server" AssociatedControlID="cbxUser" Text="User name:   " ></asp:Label>
                <dx:ASPxComboBox EnableViewState="True" TextFormatString="{0}" IncrementalFilteringMode="Contains" OnTextChanged="cbxUser_Select" FilterMinLength="1" AutoPostBack="True" NullText="Start typing..." runat="server" ID="cbxUser"><DropDownButton Visible="False"/>
                    <Columns>
                        
                    </Columns>
                </dx:ASPxComboBox>
    </div>
    <p></p>
     <dx:ASPxGridView ID="ASPxGV_History" runat="server" EnableTheming="True" 
        Theme="Office2010Black" EnableRowsCache="True" EnableViewState="True" Visible="False" >
        <Settings ShowGroupPanel="True" />
        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" 
            AllowInsert="False" />
   
    </dx:ASPxGridView>
</body>