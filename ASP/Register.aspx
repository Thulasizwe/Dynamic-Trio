<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>
<%@ Register assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <link rel="stylesheet" type="text/css" href="~/Content/NewStyles.css"/>
    <title></title>
</head>
<body>
    <form id="RegisterPage" runat="server">
    <div>
         <fc:menu ID="menu" runat="server" />  
    </div>
        <asp:Label runat="server" ID="SuccessLabel" Visible="False"></asp:Label>
         <div>
             <p>Please create your account,</p>
             <p><i>Note that you will have no access untill you have been given rights by an administrator.</i></p>
            <asp:Label runat="server" ID="FailureText" Visible="False" ForeColor="red" Text="Username or password is incorrect" ></asp:Label>
            <section id="loginSection">
                <ul>
                    
                        <asp:Label ID="ScreenNameLabel" runat="server" AssociatedControlID="ScreenName" >Screen name:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="ScreenName" AutoPostBack="True" OnTextChanged="CheckScreenName_Event" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:Label runat="server" ID="ScreenNameInvalid" AssociatedControlID="ScreenName" Text="The screen name has already been taken" Visible="false" ForeColor="red" ></asp:Label>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" ErrorMessage="No username was entered." ></asp:RequiredFieldValidator>--%>
                    
                    <p></p>
                    
                        <asp:Label ID="TitleLabel" runat="server" AssociatedControlID="ddlTitle" >Title:   <br/></asp:Label>
                        <asp:DropDownList runat="server" ID="ddlTitle" >
                        </asp:DropDownList>
                    
                    <p></p>
                   
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" >First name:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="UserName" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:Label runat="server" ID="NameEmpty" AssociatedControlID="UserName" Text="Name field is not allowed to be empty" Visible="false" ForeColor="red" ></asp:Label>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" ErrorMessage="No username was entered." ></asp:RequiredFieldValidator>--%>
                    
                    <p></p>
                    
                        <asp:Label ID="SurnameLabel" runat="server" AssociatedControlID="Surname" >Surname:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="Surname" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:Label runat="server" ID="SurnameEmpty" AssociatedControlID="Surname" Text="Surname field is not allowed to be zero" Visible="false" ForeColor="red" ></asp:Label>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" ErrorMessage="No username was entered." ></asp:RequiredFieldValidator>--%>
                    
                    <p></p>
                    
                        <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="UserEmailAdd" >Email Address:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="UserEmailAdd" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:Label runat="server" ID="EmailInvalid" AssociatedControlID="UserEmailAdd" Text="The email address had illegal characters or was in the incorrect format" Visible="false" ForeColor="red" ></asp:Label>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UserPassword" ErrorMessage="No password was entered."></asp:RequiredFieldValidator>--%>
                    
                    <p></p>
                    
                        <asp:Label ID="CellLabel" runat="server" AssociatedControlID="Cell" >Cell:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="Cell" MaxLength="15" AutoCompleteType="Disabled"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UserPassword" ErrorMessage="No password was entered."></asp:RequiredFieldValidator>--%>
                    
                    <p></p>
                    
                        <asp:Label ID="PhoneLabel" runat="server" AssociatedControlID="Phone" >Phone:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="Phone_Ext" Width="40px" MaxLength="5" AutoCompleteType="Disabled"></asp:TextBox>
                        &nbsp;
                        <asp:TextBox runat="server" ID="Phone" Width="90px" MaxLength="10" AutoCompleteType="Disabled"></asp:TextBox>
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
                        <asp:DropDownList runat="server" ID="ddlDepartment" Enabled="False" AutoPostBack="True" OnSelectedIndexChanged="DepartmentRefresh_Index"/>
                        <asp:Label runat="server" ID="DepartmentEmpty" AssociatedControlID="ddlDepartment" Text="The department can not be empty" Visible="false" ForeColor="red" ></asp:Label>
                    
                    <p></p>
                    
                        <asp:Label ID="AddrCountryLabel" runat="server" AssociatedControlID="AddrCountry" >Country:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="AddrCountry" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:Label runat="server" ID="AddrCountryEmpty" AssociatedControlID="AddrCountry" Text="The country can not be empty." Visible="false" ForeColor="red" ></asp:Label>
                        <%--<asp:RequiredFieldValidator ID="AddrCountryEmpty" runat="server" ControlToValidate="AddrCountry" ErrorMessage="The country can not be empty." ForeColor="red"></asp:RequiredFieldValidator>--%>
                    
                    <p></p>
                    
                        <%--<asp:Label ID="AddressLabel" runat="server" AssociatedControlID="txtAddress" >Living Address:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="txtAddress" TextMode="MultiLine" Width="20%" Height="75px" AutoCompleteType="Disabled"/>
                        <asp:Label runat="server" ID="AddressEmpty" AssociatedControlID="txtAddress" Text="Please enter an address before continueing" Visible="false" ForeColor="red" ></asp:Label>
                    
                    <p></p>--%>
                    
                        <asp:Label ID="passwordLabel" runat="server" AssociatedControlID="UserPassword" >Password:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="UserPassword" TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UserPassword" ErrorMessage="No password was entered."></asp:RequiredFieldValidator>--%>
                    
                    <p></p>
                    
                        <asp:Label ID="confirmLabel" runat="server" AssociatedControlID="UserConfirmP" >Confirm Password:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="UserConfirmP" TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:Label runat="server" ID="PasswordIncorrect" AssociatedControlID="UserConfirmP" Text="The passwords do not match" Visible="false" ForeColor="red" ></asp:Label>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UserPassword" ErrorMessage="No password was entered."></asp:RequiredFieldValidator>--%>
                    
                    <p></p>

                        <div runat="server" id="divUploadbtns" Visible="False">
                             <asp:Label ID="Label1" runat="server" AssociatedControlID="FileUploadControl" >Upload a Photo:   <br/></asp:Label>
                            <asp:FileUpload id="FileUploadControl" runat="server" /><%-- type="file" id="File1" name="File1" runat="server"/>--%>
                             <br>
                            <asp:Button id="btnUpload" Text="Upload" runat="server" OnClick="SubmitID_Click" Enabled="False"/>
                        </div>
                    </p>
                </ul>
            </section>
        </div>
        <asp:PlaceHolder ID="PlaceHolder1" runat="server">
            <asp:Button runat="server" ID="RegisterButton" Text="Register" OnClick="RegisterButton_Click" Enabled="false"/>
        </asp:PlaceHolder>
        
        <p>
            
        </p>
    </form>
</body>
</html>
