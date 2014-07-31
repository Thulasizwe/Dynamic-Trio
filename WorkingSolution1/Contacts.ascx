<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Contacts.ascx.cs" Inherits="WebUserControl2" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<%@ Register assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>

<head>
    <link rel="stylesheet" type="text/css" href="~/Content/NewStyles.css"/>
    <title></title>
</head>
<body>
Display contacts by:   <asp:DropDownList ID="ddlFilter" runat="server" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged" AutoPostBack="true">
    <asp:ListItem Value="0">Select Filter Type</asp:ListItem>
    <asp:ListItem Value="Site">Site</asp:ListItem>
    <asp:ListItem Value="Industry">Industry</asp:ListItem>
    <asp:ListItem Value="Department">Department</asp:ListItem>
    <asp:ListItem Value="Company">Company</asp:ListItem>
</asp:DropDownList>

<br />
<br />
<asp:Label ID="SearchFilter" runat="server" Text="Select a "></asp:Label>

<asp:DropDownList ID="ddlSelection" runat="server" >
</asp:DropDownList>
    
<br />
<br />
<asp:Button ID="btnFilter" runat="server" Text="Filter" OnClick="btnFilter_Click" />

<div runat="server" align="right">
    <div id="divBasicSearch" runat="server">
    <label id="lblBSearch">Search Contact: </label>&nbsp;
    <asp:TextBox ID="TxtSearch" runat="server"></asp:TextBox>
    <br/>
        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
    </div>
    <div id="divAdvancedSearch" runat="server" Visible="false">
    <label id="lblUserSearch">Search Username: </label>&nbsp;
    <asp:TextBox ID="txtUserSearch" runat="server"></asp:TextBox><br/>
     <label id="lblNameSearch">Search Name: </label>&nbsp;
    <asp:TextBox ID="txtNameSearch" runat="server"></asp:TextBox><br/>
     <label id="lblSurnameSearch">Search Surname: </label>&nbsp;
    <asp:TextBox ID="txtSurnameSearch" runat="server"></asp:TextBox><br/>
    <label id="lblKeywordSearch">Search Keyword: </label>&nbsp;
    <asp:TextBox ID="txtKeywordSearch" runat="server"></asp:TextBox><br/>
    <asp:Button ID="btnAdSearch" runat="server" Text="Search" OnClick="btnAddSearch_Click" />
    </div>
     <asp:LinkButton ID="lbnAdvanced" runat="server" OnClick="DisplayAdvanced_Click" Text="Advanced Search"></asp:LinkButton>
    <br />
    <br />
   
</div>

    <dx:ASPxGridView ID="ASPxGridView1" runat="server" EnableTheming="True" 
        Theme="Office2010Black" EnableRowsCache="True" EnableViewState="True" OnDataBound="checkUserSecurity" >
        <Settings ShowGroupPanel="True" />
        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" 
            AllowInsert="False" />
   
    </dx:ASPxGridView>

<br/>


<%--
<asp:GridView ID="GridView1" runat="server" Width="100%" AllowPaging="True" EnableSortingAndPagingCallbacks="True"
                            PageSize="15" ViewStateMode="Enabled"  BorderStyle="None" GridLines="None" 
                            AutoGenerateColumns="False" ShowHeaderWhenEmpty = "true">
                            <RowStyle CssClass="GridRow" />
                            <AlternatingRowStyle CssClass="GridAltRow" />
                            <HeaderStyle CssClass="GridHeader" />
                            <Columns>
                                <asp:BoundField HeaderText="Username" DataField="ScreenName" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Name" DataField="PersonName" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Surname" DataField="PersonSurname" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Title" DataField="PersonTitle" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Role" DataField="PersonRole" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Cell" DataField="Cell" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Phone" DataField="Phone" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="E-mail" DataField="eMail" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Indusrty" DataField="Industry" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Company" DataField="Company" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Department" DataField="Department" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Site" DataField="Site" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Date added" DataField="DateTimeStamp" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                            </Columns>
</asp:GridView>
--%>
 <%--OnRowCommand="GridView1_RowCommand" OnRowCreated= "GridView1_RowCreated"--%> 


<p>
    &nbsp;</p>

</body>



