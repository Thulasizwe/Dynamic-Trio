<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sendMessage.aspx.cs" Inherits="sendMessage" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html>

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
    <dx:ASPxLabel ID="HeadingLabel" runat="server" Text="Send Message" 
         Theme="iOS"  
         Font-Bold="True" Font-Size="XX-Large" align="center">
    </dx:ASPxLabel>
     </div>
        <dx:ASPxLabel runat="server" ID="ErrorMessage"/>
        <br/>
    <div>
    <dx:ASPxLabel ID="msgLabel" runat="server" Text="Send a message to a specific person or department"></dx:ASPxLabel>
        <br />
        <br/>
              
        Title: <br/> 
    <dx:ASPxTextBox ID="txtTitle" runat="server" Width="170px">
    </dx:ASPxTextBox> <br/>

        Send to: <dx:ASPxRadioButton ID="rdbDepatment" 
        runat="server" Text="Department"  
        oncheckedchanged="rdbDepatment_CheckedChanged" AutoPostBack="True">
        </dx:ASPxRadioButton>
        <dx:ASPxRadioButton ID="rdbPerson" runat="server" Text="Person" 
        AutoPostBack="True" oncheckedchanged="rdbPerson_CheckedChanged">
        </dx:ASPxRadioButton>
       
        <br/>
        <div runat="server" ID="depDiv">
     
    Select An Idustry:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
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
        </asp:DropDownList>  
            <br />
       </div><div runat="server" ID="userDiv">
       <dx:ASPxLabel ID="lblPerson" runat="server" Text="Select a Person: " 
        Font-Bold="False" Font-Names="Verdana" Font-Size="10pt" ForeColor="Black">
    </dx:ASPxLabel>                
        <dx:ASPxComboBox TextFormatString="{0}" IncrementalFilteringMode="Contains"  FilterMinLength="1"  NullText="Start typing..." runat="server" ID="ScreenName" AutoPostBack="True"><DropDownButton Visible="False" />
                   
                </dx:ASPxComboBox>
    </div>
        <br/>
        Message:
    <dx:ASPxMemo ID="txtMessage" runat="server" Width="657px" Height="135px">
    </dx:ASPxMemo> <br/>
        <dx:ASPxButton runat="server" ID="btnSend" Text="Send" OnClick="btnSend_Click"></dx:ASPxButton> 
    </div>
    </form>
</body>
</html>
