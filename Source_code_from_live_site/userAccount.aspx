<%@ Page Language="C#" AutoEventWireup="true" CodeFile="userAccount.aspx.cs" Inherits="Register" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
        <link rel="stylesheet" type="text/css" href="~/Content/NewStyles.css"/>
    <title></title>
</head>
<body>
    <form id="RegisterPage" runat="server">
    <div>
        <fc:menu ID="menu" runat="server" />    
    </div>
         <div>
             <p>Click Save to save changes to your account.</p>
            <asp:Label runat="server" ID="FailureText" Visible="False" ForeColor="red" Text="Changes were not saved please revise fields" ></asp:Label>
            <section id="loginSection">
                <ul>
                    
                        <asp:Label ID="ScreenNameLabel" runat="server" AssociatedControlID="ScreenName" >User name:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="ScreenName" ReadOnly="false" AutoCompleteType="Disabled"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" ErrorMessage="No username was entered." ></asp:RequiredFieldValidator>--%>
                    
                    <p></p>
                     <asp:Button ID="btnPassword" runat="server" 
                            Text="Change Pasword" onclick="Button1_Click" />
                             <br/>
                     <br/>
                        <asp:Label ID="lblCurPass" runat="server" AssociatedControlID="OldPassword" >Current Password:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="OldPassword" TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:Label runat="server" ID="OldPasswordIncorrect" AssociatedControlID="OldPassword" Text="The password is incorrect" Visible="false" ForeColor="red" ></asp:Label>
                    <br/>
                     <br/>
                        <asp:Label ID="passwordLabel" runat="server" AssociatedControlID="UserPassword" >New Password:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="UserPassword" TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                    
                    
                    <p></p>
                     
                    
                        <asp:Label ID="confirmLabel" runat="server" AssociatedControlID="UserConfirmP" >Confirm New Password:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="UserConfirmP" TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:Label runat="server" ID="PasswordIncorrect" AssociatedControlID="UserConfirmP" Text="The passwords do not match" Visible="false" ForeColor="red" ></asp:Label>

                       
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
                        <asp:TextBox runat="server" ID="Phone_Ext" Width="40px" AutoCompleteType="Disabled"></asp:TextBox><asp:TextBox runat="server" ID="Phone" Width="77px"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UserPassword" ErrorMessage="No password was entered."></asp:RequiredFieldValidator>--%>
                   
                    
                    <br/>
                    <div runat="server" ID="UploadDiv">
                    <asp:Label runat="server" ID="UploadLabel" Text="Upload facial Image please"></asp:Label><br/>
                            <asp:FileUpload id="FileUploadControl" runat="server" /><%-- type="file" id="File1" name="File1" runat="server"/>--%>
                       <br/>
                            <asp:Button id="btnUpload" Text="Upload image" runat="server" OnClick="SubmitID_Click"/>
                        </div>
                        
                    <p></p>
<%--                    
                        <asp:Label ID="AddressLabel" runat="server" AssociatedControlID="txtAddress" >Living Address:   <br/></asp:Label>
                        <asp:TextBox runat="server" ID="txtAddress" TextMode="MultiLine" Width="20%" Height="75px"/>
                        <asp:Label runat="server" ID="AddressEmpty" AssociatedControlID="txtAddress" Text="Please enter an address before continueing" Visible="false" ForeColor="red" ></asp:Label>
                    
                    <p></p>--%>
                </ul>
            </section>
        </div>
        
        <asp:Label ID="SavedLabel" runat="server" Visible="false" Text="Changes saved!"></asp:Label>
        <asp:PlaceHolder ID="PlaceHolder1" runat="server">
            <asp:Button runat="server" ID="SaveButton" Text="Save" OnClick="SaveButton_Click" />
        </asp:PlaceHolder>
    </form>
</body>
</html>
