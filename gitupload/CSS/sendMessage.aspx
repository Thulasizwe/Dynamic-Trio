<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sendMessage.aspx.cs" Inherits="sendMessage" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>


<html>
	<head id="Head1" runat="server">
		<link rel="stylesheet" type="text/css" href="style/style.css">
        <title></title>
        <script type="text/javascript" src="sliderengine/jquery.js"></script><script type="text/javascript" src="sliderengine/jquery.hislider.js"></script>
	    <script type="text/javascript" src="style/scrpt.js"></script>
    </head>
	<body id="body">
    <form id="form1" runat="server">
        <fc:menu ID="menu1" runat="server" /> 
    <div id="wrapper">
       <h1 style="text-align:center;">
            Send Messages</h1>

        <div id ="content">
            <div id="serch">
    
    
        <dx:ASPxLabel runat="server" ID="ErrorMessage"/>
        <br/>
    <div>
    <dx:ASPxLabel ID="msgLabel" runat="server" Text="Send a message to a specific person or department"></dx:ASPxLabel>
        <br />
        <br/>
              
        Title: <br/> 
    <dx:ASPxTextBox ID="txtTitle" runat="server" Width="170px">
    </dx:ASPxTextBox> <br/>

        Send to: 
        <dx:ASPxRadioButton ID="rdbPerson" runat="server" Text="Person" 
        AutoPostBack="True" oncheckedchanged="rdbPerson_CheckedChanged">
        </dx:ASPxRadioButton>
       
        <br/>
        <div runat="server" ID="depDiv">
     
    Select An Idustry:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <asp:DropDownList ID="ddlIndustry" runat="server" 
        onselectedindexchanged="ddlIndustry_SelectedIndexChanged" AutoPostBack="True" Height="27px">
        <asp:ListItem>Please Select</asp:ListItem>
        </asp:DropDownList> 
    
        <br/> <br/>
        Select a Company:&nbsp;&nbsp;&nbsp;&nbsp; 
    <asp:DropDownList ID="ddlCompany" runat="server" 
        onselectedindexchanged="ddlCompany_SelectedIndexChanged" AutoPostBack="True" Height="27px">
        <asp:ListItem>Please Select</asp:ListItem>
        </asp:DropDownList> <br/> <br/>
        Select a Site:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <asp:DropDownList ID="ddlSite" runat="server" 
        onselectedindexchanged="ddlSite_SelectedIndexChanged" AutoPostBack="True" Height="27px">
        <asp:ListItem>Please Select</asp:ListItem>
        </asp:DropDownList> <br/> <br/>
        Select a Department:&nbsp; <asp:DropDownList ID="ddlDepartment" 
            runat="server" Height="27px">
            <asp:ListItem>Please Select</asp:ListItem>
        </asp:DropDownList>  
            <br />
       </div><div runat="server" ID="userDiv">
       <dx:ASPxLabel ID="lblPerson" runat="server" Text="Select a Person: " 
        Font-Bold="False" Font-Names="Verdana" Font-Size="10pt" ForeColor="white">
    </dx:ASPxLabel>                
        <dx:ASPxComboBox TextFormatString="{0}" IncrementalFilteringMode="Contains"  FilterMinLength="1"  NullText="Start typing..." runat="server" ID="ScreenName" AutoPostBack="True" Height="27px"><DropDownButton Visible="False" />
                   
                </dx:ASPxComboBox>
    </div>
        <br/>
        Message:
    <dx:ASPxMemo ID="txtMessage" runat="server" Width="657px" Height="135px">
    </dx:ASPxMemo> <br/>
        <dx:ASPxButton runat="server" ID="btnSend" Text="Send" OnClick="btnSend_Click" CssClass="btn"></dx:ASPxButton> 
    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
