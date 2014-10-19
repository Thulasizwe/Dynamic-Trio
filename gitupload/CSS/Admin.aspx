﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>
<%@ Register TagPrefix="fc" TagName="menu" Src="~/WebUserControl.ascx" %>

<html>
	<head id="Head1" runat="server">
		<link rel="stylesheet" type="text/css" href="style/style.css">
        <title></title>
        <script type="text/javascript" src="sliderengine/jquery.js"></script><script type="text/javascript" src="sliderengine/jquery.hislider.js"></script>
	    <script type="text/javascript" src="style/scrpt.js"></script>
    </head>
	<body id="body" onload="check(event)" style="overflow:hidden;">
		<%--<div id="header">--%>
            <form id="header" runat="server">
            <fc:menu ID="menu1" runat="server" /> 
                </form>
        <br/ >
        <br/ >
        <br/ >
        <br/ >
			<%--<div id = "logo">
				<img src = "images/logo.png" width = "150" height = "150" alt="img"/>
			</div>--%>
		<%--</div>--%>
        
		<%--<header class="blue">

				<ul>
					<li><a href="Default.aspx">Home</a></li>
					<li><a href="javascript:void(0);">Captain</a></li>
					<li><a href="javascript:void(0);">Teams</a></li>
					<li><a href="javascript:void(0);">Messages</a></li>
					<li><a href="javascript:void(0);" class="active">Admin</a></li>
					<li><a href="javascript:void(0);">Logouts</a></li>
				</ul>
			</header>--%>

		<div id = "wrapper">
			
			<div id="content">
               <table cellspacing="25">
                <tr>
                    <td><a href="ViewContacts.aspx"><img src="images/edit.png" id="popup" length="70" width="70" alt="Manage Users"/><p>Manage Users</p></a><td>
                    <td><a href="CreateATeam.aspx"><img src="images/add.png" length="70" width="70" alt="Manage Users"/><p>Create Team</p></a><td>
                    <td><a href="CreateALeague.aspx"><img src="images/lig.png" length="70" width="70" alt="Manage Users"/><p>Create League</p></a><td>
                    <td><a href="GenerateFixtures.aspx"><img src="images/generate.png" length="70" width="70" alt="Manage Users"/><p>Generate Fixtures</p></a><td>
                </tr>
                <tr>
                    <td><a href="sendMessage.aspx"><img src="images/message.png" length="70" width="70" alt="Manage Users"/><p>Send Message</p></a><td>
                    <td><a href="manageUsers.aspx"><img src="images/result.png" length="70" width="70" alt="Manage Users"/><p>Publish Results</p></a><td>
                    <td><a href="News.aspx"><img src="images/new.png" length="70" width="70" alt="Manage Users"/><p>Publish News</p></a><td>
                    <td><a href="manageUsers.aspx"><img src="images/admin.png" length="70" width="70" alt="Manage Users"/><p>Structure Admin</p></a><td>
                </tr>
               </table>
               <div id="abc">
				<div id="popupContact">
                    &nbsp;</div>
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

