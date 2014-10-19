<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Contacts.ascx.cs" Inherits="WebUserControl2" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>




    <div id="serch">
<div runat="server">
    <div id="divBasicSearch" runat="server">
    <label id="lblBSearch">Search Contact: </label>&nbsp;
    <asp:TextBox ID="TxtSearch" runat="server"></asp:TextBox>
    <br/>
        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn" />
    </div>
    <div id="divAdvancedSearch" runat="server" Visible="false">
    <label id="lblUserSearch">Search Username: </label>&nbsp;
    <asp:TextBox ID="txtUserSearch" runat="server"></asp:TextBox><br/>
     <label id="lblNameSearch">Search Name: </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="txtNameSearch" runat="server"></asp:TextBox><br/>
     <label id="lblSurnameSearch">Search Surname: </label>&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="txtSurnameSearch" runat="server"></asp:TextBox><br/>
        <br/>
    <asp:Button ID="btnAdSearch" runat="server" Text="Search" OnClick="btnAddSearch_Click" CssClass="btn"/>
    </div>
     <asp:LinkButton ID="lbnAdvanced" runat="server" OnClick="DisplayAdvanced_Click" Text="Advanced Search"></asp:LinkButton>
    <br />
    <br />
   
</div>

    <dx:ASPxGridView ID="ASPxGridView1" runat="server" EnableTheming="True" 
        Theme="Aqua" EnableRowsCache="True" EnableViewState="True" OnDataBound="checkUserSecurity" >
        <Settings ShowGroupPanel="True" />
        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" 
            AllowInsert="False" />
   
    </dx:ASPxGridView>




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

        
    </div>




