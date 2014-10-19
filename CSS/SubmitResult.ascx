<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SubmitResult.ascx.cs" Inherits="SubmitResult" %>
<form id="form1" runat="server">
    <label> League </label>
    <asp:DropDownList ID="dropLeague" runat="server"> </asp:DropDownList>
    <label> Your team </label>
    <asp:DropDownList ID="dropTeam" runat="server"> </asp:DropDownList>
    <label> Opponent </label>
    <asp:DropDownList ID="dropOpponent" runat="server"> </asp:DropDownList>
    <asp:TextBox ID="Team" runat="server" value="Your score"></asp:TextBox> 
    <asp:TextBox ID="Opponent" runat="server" value="Opponent score"></asp:TextBox>
    <label> Snapshot Proof </label>
    <asp:FileUpload ID="FileUpload1" runat="server" />
    <asp:Button ID="submitResult" runat="server" 
    Text="Submit" />
</form>