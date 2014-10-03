<%@ Page Language="C#" AutoEventWireup="true" CodeFile="manageUsers.aspx.cs" Inherits="Register" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>
<%@ Register assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="RegisterPage" runat="server">
    <div>
        <fc:menu ID="menu" runat="server" />    
    </div>
         <div>
             <p>
        
        <asp:Label ID="SavedLabel" runat="server" Visible="false" Text="Changes saved!"></asp:Label>
             </p>
             <p>Click Save to save changes to a user's account.</p>
             <p>
            <asp:Label runat="server" ID="FailureText" Visible="False" ForeColor="red" Text="Username or password is incorrect" ></asp:Label>
             </p>
             <asp:Button ID="btnOverride" runat="server" Text="Enable Override" OnClick="btnOverride_Click" Visible="False" Theme="Default"></asp:Button>
             <br />
             <br />
            <section id="loginSection">
                
                <asp:Label ID="ScreenNameLabel" runat="server" AssociatedControlID="ScreenName" >User name:   </asp:Label>
                <dx:ASPxComboBox TextFormatString="{0}" IncrementalFilteringMode="Contains" OnTextChanged="ScreenName_Select" FilterMinLength="1" AutoPostBack="True"
                    NullText="Start typing..." runat="server" ID="ScreenName"><DropDownButton Visible="False" />
                    <Columns>
                        <%--<dx:ListBoxColumn Caption="Screen Name"/>
                        <dx:ListBoxColumn Caption="Name"/>
                        <dx:ListBoxColumn Caption="Surname"/>--%>
                    </Columns>
                </dx:ASPxComboBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" ErrorMessage="No username was entered." ></asp:RequiredFieldValidator>--%>
             
                <br />
                <asp:Label runat="server" ID="InvalidScreenName" AssociatedControlID="ScreenName" Text="Invalid username" Visible="false" ForeColor="red" ></asp:Label>
             
                <div ID="userDataDiv" runat="server" Visible="False">
                <ul>
                     <asp:Button ID="btnPassword" runat="server" 
                            Text="Reset Password" onclick="btnPassword_Click" />
                    <br/>
                     <br/>
                        <asp:Label ID="passwordLabel" runat="server" AssociatedControlID="UserPassword" >New Password:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="UserPassword" TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UserPassword" ErrorMessage="No password was entered."></asp:RequiredFieldValidator>--%>
                    
                    <p></p>
                     
                    
                        <asp:Label ID="confirmLabel" runat="server" AssociatedControlID="UserConfirmP" >Confirm Password:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="UserConfirmP" TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:Label runat="server" ID="PasswordIncorrect" AssociatedControlID="UserConfirmP" Text="The passwords do not match" Visible="false" ForeColor="red" ></asp:Label>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UserPassword" ErrorMessage="No password was entered."></asp:RequiredFieldValidator>--%>
                    
                    <p></p>

                        <asp:Label ID="TitleLabel" runat="server" AssociatedControlID="ddlTitle" >Title:  <br/></asp:Label>
                        <asp:DropDownList runat="server" ID="ddlTitle" Enabled="True" AutoPostBack="False"/>
                         <asp:Label runat="server" ID="TitleEmpty" AssociatedControlID="ddlTitle" Text=" Please select a Title" Visible="false" ForeColor="red" ></asp:Label>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" ErrorMessage="No username was entered." ></asp:RequiredFieldValidator>--%>
                    
                    <p></p>
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" >First Name:<br/></asp:Label>
                        <asp:TextBox runat="server" ID="UserName" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:Label runat="server" ID="NameEmpty" AssociatedControlID="UserName" Text="The Name field is not allowed to be empty" Visible="false" ForeColor="red" ></asp:Label>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" ErrorMessage="No username was entered." ></asp:RequiredFieldValidator>--%>
                    
                    <p></p>

                        <asp:Label ID="SurnameLabel" runat="server" AssociatedControlID="Surname" >Surname:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="Surname" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:Label runat="server" ID="SurnameEmpty" AssociatedControlID="Surname" Text="The Surname field is not allowed to be zero" Visible="false" ForeColor="red" ></asp:Label>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" ErrorMessage="No username was entered." ></asp:RequiredFieldValidator>--%>
                    
                    <p></p>
                    
                        <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="UserEmailAdd" >Email Address:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="UserEmailAdd" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:Label runat="server" ID="EmailInvalid" AssociatedControlID="UserEmailAdd" Text="The email address had illegal characters or was in the incorrect format" Visible="false" ForeColor="red" ></asp:Label>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UserPassword" ErrorMessage="No password was entered."></asp:RequiredFieldValidator>--%>
                    
                    <p></p>
                    
                        <asp:Label ID="CellLabel" runat="server" AssociatedControlID="Cell" >Cell:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="Cell" AutoCompleteType="Disabled"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UserPassword" ErrorMessage="No password was entered."></asp:RequiredFieldValidator>--%>
                    
                    <p></p>
                    
                        <asp:Label ID="PhoneLabel" runat="server" AssociatedControlID="Phone" >Phone:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="Phone_Ext" Width="40px" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:TextBox runat="server" ID="Phone" Width="77px"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UserPassword" ErrorMessage="No password was entered."></asp:RequiredFieldValidator>--%>
                   
                    <p></p>
                    
                        <asp:Label ID="CompanyLabel" runat="server" AssociatedControlID="ddlCompany" >Company:   <br/></asp:Label>
                        <asp:DropDownList runat="server" ID="ddlCompany" AutoPostBack="True" OnSelectedIndexChanged="CompanyRefresh_Index"/>
                        <asp:Label runat="server" ID="CompanyEmpty" AssociatedControlID="ddlCompany" Text="The company can not be empty" Visible="false" ForeColor="red" ></asp:Label>
                    
                    <p></p>
                    
                        <asp:Label ID="CompanySite" runat="server" AssociatedControlID="ddlSite" >Site:   <br/></asp:Label>
                        <asp:DropDownList runat="server" ID="ddlSite" Enabled="False" AutoPostBack="True" OnSelectedIndexChanged="SiteRefresh_Index"/>
                        <asp:Label runat="server" ID="SiteEmpty" AssociatedControlID="ddlSite" Text="The site can not be empty" Visible="false" ForeColor="red" ></asp:Label>
                    
                     <p></p>

                        <asp:Label ID="DepartmentLabel" runat="server" AssociatedControlID="ddlDepartment" >Department:   <br/></asp:Label>
                        <asp:DropDownList runat="server" ID="ddlDepartment" />
                        <asp:Label runat="server" ID="DepartmentEmpty" AssociatedControlID="ddlDepartment" Text="The department can not be empty" Visible="false" ForeColor="red" ></asp:Label>
                        
                

                       
                         <p>
                        </p>
<%--                    
                        <asp:Label ID="AddressLabel" runat="server" AssociatedControlID="txtAddress" >Living Address:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="txtAddress" TextMode="MultiLine" Width="20%" Height="75px"/>
                        <asp:Label runat="server" ID="AddressEmpty" AssociatedControlID="txtAddress" Text="Please enter an address before continueing" Visible="false" ForeColor="red" ></asp:Label>
                    
                    <p></p>--%>
                </ul>
              </div>  
            </section>
        </div>
        
        <asp:PlaceHolder ID="PlaceHolder1" runat="server">
            <asp:Button runat="server" ID="SaveButton" Text="Save" OnClick="SaveButton_Click" Enabled="false"/>
        </asp:PlaceHolder>
    </form>
</body>
</html>
