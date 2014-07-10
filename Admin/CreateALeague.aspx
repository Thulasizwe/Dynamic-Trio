<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateALeague.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
   <h1>
        Register a League
    </h1>
    <br />
    <label>
        League Name:
    </label>
    <input type="text" id="name" />
    <br />
    <label>
        Select the type of game
    </label>
    <asp:DropDownList runat="server" id="GameTypes" OnSelectedIndexChanged="OnSelectedIndexChangedMethod" DataSource="">
        
    </asp:DropDownList>
    <br />
    <input type="submit" value="Register league" />
 </form>
</body>
</html>
