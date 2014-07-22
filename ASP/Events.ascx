﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Events.ascx.cs" Inherits="Events" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<%@ Register assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxPopupControl" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxRoundPanel" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxPanel" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<style >
    .styleOne { text-align: right; vertical-align: bottom}
</style>

<head>
    <link rel="stylesheet" type="text/css" href="~/Content/NewStyles.css"/>
    <title></title>
</head>
<body>
<table runat="server" ID="topTable" width="100%">
 <tr>
  <td>
Display Events by:   <asp:DropDownList ID="ddlFilter" runat="server" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged" AutoPostBack="true">
    <asp:ListItem Value="0">Select Filter Type</asp:ListItem>
    <asp:ListItem Value="Site">Site</asp:ListItem>
    <asp:ListItem Value="Department">Department</asp:ListItem>
    <asp:ListItem Value="Company">Company</asp:ListItem>
</asp:DropDownList>

<br />
<br />
<asp:Label ID="SearchFilter" runat="server" Text="Select a "></asp:Label>

<asp:DropDownList ID="ddlSelection" runat="server" >
</asp:DropDownList>
    
<br /><br/>
<asp:DropDownList runat="server" ID="ddlCompleted">
    <asp:ListItem Value="all">Show all events</asp:ListItem>
    <asp:ListItem Value="1">Show only Completed</asp:ListItem>
    <asp:ListItem Value="0">Show only uncompleted</asp:ListItem>
</asp:DropDownList>
<br /><br/>
<asp:Button ID="btnFilter" runat="server" Text="Filter" OnClick="btnFilter_Click" />
 </td><td runat="server" ID="tableColumn" class="styleOne">
<div id="Div1" runat="server" align="right">
    <div id="divBasicSearch" runat="server">
    <dx:ASPxLabel runat="server" id="lblBSearch" Text="Search Event: "></dx:ASPxLabel>&nbsp;
    <asp:TextBox ID="TxtSearch" runat="server"></asp:TextBox>
    <br/>
        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
    </div>
</div>
    </td>
   </tr>
</table>
<div runat="server" ID="GridDiv" Visible="False">
    <br/>
    <dx:ASPxLabel runat="server" ID="editLabel" Text="Click a row to edit that event."/><br/>
    <dx:ASPxButton runat="server" OnClick="InitialiseEditPopup" Text="Edit" ID="OpenEditButton"></dx:ASPxButton>
    <br/><br/>
    <dx:ASPxGridView ID="EventGrid" runat="server" EnableTheming="True" Theme="Office2010Black" EnableRowsCache="True" EnableViewState="True" >
        <Settings ShowGroupPanel="True" />
        <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" AllowFocusedRow="True"></SettingsBehavior>
        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
    </dx:ASPxGridView>
</div>

   <dx:ASPxPopupControl ID="eventPopup"  PopupHorizontalAlign="WindowCenter" 
        PopupVerticalAlign="WindowCenter" HeaderText="Edit Event" AllowDragging="true"
                        PopupElementID="OpenEditButton" 
        PopupAction="LeftMouseClick"  Modal="True"
                        CloseAction="OuterMouseClick" ShowCloseButton="True" 
        runat="server" ShowPageScrollbarWhenModal="True" Width="391px">
      <ContentCollection>    
        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" >
            <asp:panel ID="Panel1" runat="server">
                <dx:ASPxRoundPanel ID="EditPanel" runat="server" ShowHeader="False" HorizontalAlign="Center">
                        <PanelCollection>
                            <dx:PanelContent ID="PanelContent2" runat="server">
                                <table>
                                  <tr>
                                   <td>
                                    <dx:ASPxCheckBox runat="server" Text="Mark as completed" ID="completedCB"></dx:ASPxCheckBox>
                                   </td><td></td><td>
                                    <dx:ASPxButton ID="EditButton" runat="server" OnClick="editEvent_Click" Text="Edit Event"></dx:ASPxButton>
                                   </td>
                                  </tr>
                                </table>
                                   <div runat="server" ID="EditFieldDiv" Visible="False">
                                      Select An Industry:&nbsp;&nbsp;&nbsp;&nbsp; <asp:DropDownList ID="ddlIndustry" runat="server" 
                                        onselectedindexchanged="ddlIndustry_SelectedIndexChanged" AutoPostBack="True">
                                        <asp:ListItem>Please Select</asp:ListItem>
                                        </asp:DropDownList> <br/> <br/>
                                        Select a Company:&nbsp;&nbsp;&nbsp;&nbsp; 
                                    <asp:DropDownList ID="ddlCompany" runat="server" 
                                        onselectedindexchanged="ddlCompany_SelectedIndexChanged" AutoPostBack="True">
                                        <asp:ListItem>Please Select</asp:ListItem>
                                        </asp:DropDownList> <br/> <br/>
                                        Select a Site:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                    <asp:DropDownList ID="ddlSite" runat="server" 
                                        onselectedindexchanged="ddlSite_SelectedIndexChanged" AutoPostBack="True">
                                        <asp:ListItem>Please Select</asp:ListItem>
                                        </asp:DropDownList> <br/> <br/>
                                        Select a Department:&nbsp; <asp:DropDownList ID="ddlDepartment" 
                                            runat="server">
                                            <asp:ListItem>Please Select</asp:ListItem>
                                        </asp:DropDownList> <br/> <br/>
                                        Assign event to: 
                                        <dx:ASPxRadioButton ID="rdbPerson" runat="server" Text="Person" 
                                        AutoPostBack="True" oncheckedchanged="rdbPerson_CheckedChanged">
                                        </dx:ASPxRadioButton>
                                       <dx:ASPxRadioButton runat="server" ID="rdbNone" Text="Keep as is"
                                           AutoPostBack="True" OnCheckedChanged="tdbNone_CheckedChanged">
                                       </dx:ASPxRadioButton>
       
                                       <dx:ASPxLabel ID="lblPerson" runat="server" Text="Select a Person: " 
                                        Font-Bold="False" Font-Names="Verdana" Font-Size="10pt" ForeColor="Black">
                                    </dx:ASPxLabel>                
                                        <dx:ASPxComboBox TextFormatString="{0}" IncrementalFilteringMode="Contains" OnTextChanged="ScreenName_Select" FilterMinLength="1"
                                            NullText="Start typing..." runat="server" ID="ScreenName" AutoPostBack="True"><DropDownButton />
                                                </dx:ASPxComboBox>
                                        <br/>  <br/>
              
                                    Event Name: 
                                    <dx:ASPxTextBox ID="txtEvent" runat="server" Width="170px">
                                    </dx:ASPxTextBox> <br/> <br/>
                                        Select a Product: <br/>
                                     <asp:DropDownList ID="ddlProduct" runat="server" 
                                        onselectedindexchanged="ddlProduct_SelectedIndexChanged" AutoPostBack="True">
                                         <asp:ListItem>Please Select</asp:ListItem>
                                        </asp:DropDownList> <br/> <br/>

                                 Offer Value: 
                                    <dx:ASPxTextBox ID="txtValue" runat="server" Width="170px">
                                    </dx:ASPxTextBox> <br/> <br/>
                                     Client Name: 
                                    <dx:ASPxTextBox ID="txtClient" runat="server" Width="170px">
                                    </dx:ASPxTextBox> <br/> <br/>
    
                                    Comments:
                                    <dx:ASPxTextBox ID="txtComment" runat="server" Width="400px" Height="135px">
                                    </dx:ASPxTextBox>
                                                                </div><br/>
                                 <dx:ASPxButton ID="DoneButton" OnClick="Done_Click" runat="server" Text="Done"></dx:ASPxButton>
                             </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>
            </asp:panel>
        </dx:PopupControlContentControl>
      </ContentCollection>  
    </dx:ASPxPopupControl>

</body>
