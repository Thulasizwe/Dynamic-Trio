<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateATeam.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        input[type=text], input[type=password]
        {
            width: 200px;
        }
        table
        {
            border: 1px solid #ccc;
        }
        table th
        {
            background-color: #F7F7F7;
            color: #333;
            font-weight: bold;
        }
        table th, table td
        {
            padding: 5px;
            border-color: #ccc;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <h1>
        Register a team
    </h1>
    <br />
    <label>
        team Name:
    </label>
    <input type="text" id="name" />
    <br />
    <label>
        Select a team captain
    </label>
    <asp:DropDownList runat="server" id="TeamCaptains" OnSelectedIndexChanged="OnSelectedIndexChangedMethod" DataSource="">
        
    </asp:DropDownList>
    <br />
    <label>
        Select a team zone
    </label>
    <br />
    <asp:DropDownList runat="server" id="TeamZone" OnSelectedIndexChanged="OnSelectedIndexChangedMethod" DataSource="">
        
    </asp:DropDownList>
    <br />
    <input type="submit" value="Register team" />
    </form>
</body>
</html>
