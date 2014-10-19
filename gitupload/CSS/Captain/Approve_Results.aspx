<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approve_Results.aspx.cs" Inherits="Captain_Approve_Results" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="stylesheet" type="text/css" href="../style/style.css">
        <title>Captain</title>
        <script type="text/javascript" src="sliderengine/jquery.js"></script><script type="text/javascript" src="sliderengine/jquery.hislider.js"></script>
	    <script type="text/javascript" src="style/scrpt.js"></script>
        
    </head>
	<body id="body">
		<div id="header">
			<div id = "logo">
				<img src = "../images/logo.png" width = "150" height = "150" alt="img"/>
			</div>
		</div>
		<header class="blue">
				<ul>
					<li><a href="Default.aspx">Home</a></li>
					<li><a href="javascript:void(0);">Log</a></li>
					<li><a href="javascript:void(0);">Teams</a></li>
					<li><a href="javascript:void(0);">Results</a></li>
					<li><a href="manageTeam.aspx">Manage Teams</a></li>
					<li><a href="javascript:void(0);">Logouts</a></li>
				</ul>
			</header>
		<div id = "wrapper">
			
			<div id="content">
               <form id="form1" runat="server">
                   <table>
                     <tr>
                         <td><asp:Label ID="lblteam" runat="server" ></asp:Label></td>
                         <td><asp:Label ID="lblscore1" runat="server" Text="1"></asp:Label></td>
                         <td><asp:Label ID="lblopponent" runat="server" ></asp:Label></td>
                         <td><asp:Label ID="lblScore2" runat="server" Text="2"></asp:Label></td>
                         <td><asp:Image ID="Image1" runat="server" Width="250" Height="250" /></td>
                     </tr>
                     <tr>
                         <td> 
                             <asp:RadioButtonList ID="decision" runat="server">
                                <asp:ListItem Text="Accept" Value="Accept"></asp:ListItem>
                                <asp:ListItem Text="Dispute" Value="Dispute"></asp:ListItem>               
                             </asp:RadioButtonList>
                         </td>
                     </tr>
                      <tr>
                          <td>
                              <asp:TextBox id="disputText" Rows ="100" runat="server" ></asp:TextBox>
                          </td>
                      </tr>
                       <tr>
                          <td> <asp:Button Text="Submit" runat="server" /></td>
                       </tr>
                        
                   </table>
                </form>
			</div>
            
		</div>
		<div id = "news">
				<h1> News </h1>
		</div>
		<div id = "upcoming">
				<h1> Upcoming </h1>
			<div id="in">
				<img src="images/chelsea.jpg" width="80" height="80"/><br><br>
				<img src="images/v.png" width="40" height="40"/><br><br>
				<img src="images/liverpool.png" width="80" height="80"/>
			</div>
		</div>

		<br/>
		
	</body>
</html>
