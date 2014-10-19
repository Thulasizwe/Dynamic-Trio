<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Captain.aspx.cs" Inherits="Captain" %>4


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
               <table cellspacing="25">
                <tr>
                    <td><a href="SubmitResult.aspx"><button id="my-button"><img src="../images/result.png" id="Img7" length="70" width="70" alt="Manage Users" onclick="div_show()"/><p>Submit Results</p></button></a></td>
                    <td><a href="Approve_Results.aspx"><button id="cApprove"><img src="../images/approve.png" id="Img1" length="70" width="70" alt="Manage Users" onclick="div_show()"/><p>Aprove Results</p></button></a></td>
                    <td><a href="Accept.aspx"><button id="Button2"><img src="../images/welcome.png" id="Img4" length="70" width="70" alt="Manage Users" onclick="div_show()"/><p>Accept Requests</p></button></a></td>
                    <td><a href="Message.aspx"><button id="cSend"><img src="../images/message.png" id="Img2" length="70" width="70" alt="Manage Users" onclick="div_show()"/><p>Mesage to Admin</p></button><td>
               
                </tr>
                <tr>
                   
                </tr>
               </table>
               
                <!-- Element to pop up -->
              
                <div id = "approve">
                    <form id="form2" runat="server">

                        <asp:Label ID="lblTeam" runat="server">Team Name</asp:Label>
                        <asp:Label ID="lblOpponent" runat="server">Team Name</asp:Label>
                        <label> Uploaded by: </label> <asp:Label ID="captainName" runat="server">Captain Name</asp:Label>
                        <asp:Button ID="acceptBtn" runat="server" onclick="AcceptResults" 
                        Text="Accept" />
                    </form>
                </div>
                
			</div>
            
			<!--<form>
			    <input name="name" placeholder="What is your name?" class="name" required />
			    <input name="emailaddress" placeholder="What is your email?" class="email" type="email" required />
			    <textarea rows="4" cols="50" name="subject" placeholder="Please enter your message" class="message" required></textarea>
			    <input name="submit" class="btn" type="submit" value="Send" />
			</form>-->
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
