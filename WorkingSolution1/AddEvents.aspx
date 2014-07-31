﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddEvents.aspx.cs" Inherits="AddEvents" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    
    <form id="form1" runat="server">
        <div>
         <fc:menu ID="menu" runat="server" />  
    </div>
    <div align="center" style="height: 150px">
         <br />
         <br />
         <br />
    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Add Events" 
         Theme="iOS"  
         Font-Bold="True" Font-Size="XX-Large" align="center">
    </dx:ASPxLabel>

     </div>
         <dx:ASPxLabel ID="errorhandling" runat="server" Text="" Font-Bold="True" 
            Font-Size="12pt" ForeColor="#FF3300">
        </dx:ASPxLabel>
        <br/>
         <dx:ASPxLabel ID="Success" runat="server" Text="" Font-Bold="True" 
            Font-Size="12pt" ForeColor="Green">
        </dx:ASPxLabel>
        <br/>
        <br/>
        Select an Industry:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <asp:DropDownList ID="ddlIndustry" runat="server" 
        onselectedindexchanged="ddlIndustry_SelectedIndexChanged" AutoPostBack="True">
        <asp:ListItem>Please Select</asp:ListItem>
        </asp:DropDownList> 
    
        <br/> <br/>
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
        Assign event to: <dx:ASPxRadioButton ID="rdbDepatment" 
        runat="server" Text="Department"  
        oncheckedchanged="rdbDepatment_CheckedChanged" AutoPostBack="True">
        </dx:ASPxRadioButton>
        <dx:ASPxRadioButton ID="rdbPerson" runat="server" Text="Person" 
        AutoPostBack="True" oncheckedchanged="rdbPerson_CheckedChanged">
        </dx:ASPxRadioButton>
       
       <dx:ASPxLabel ID="lblPerson" runat="server" Text="Select a Person: " 
        Font-Bold="False" Font-Names="Verdana" Font-Size="10pt" ForeColor="Black">
    </dx:ASPxLabel>                
        <dx:ASPxComboBox TextFormatString="{0}" IncrementalFilteringMode="Contains"  FilterMinLength="1"  NullText="Start typing..." runat="server" ID="ScreenName" AutoPostBack="True"><DropDownButton Visible="False" />
                   
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
    <dx:ASPxTextBox ID="txtComment" runat="server" Width="657px" Height="135px">
    </dx:ASPxTextBox> <br/> <br/>
    
    <div align="center">
        <dx:ASPxButton ID="btnAdd" runat="server" Text="Create Event" Theme="Glass" 
            onclick="btnAdd_Click">
    </dx:ASPxButton>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <dx:ASPxButton ID="btnCancel" runat="server" Text="Cancel" Theme="Glass" 
            onclick="btnCancel_Click">
    </dx:ASPxButton>
    </div>
    
    </form>
</body>
</html>

