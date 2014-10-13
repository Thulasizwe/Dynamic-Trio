<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<html>
	<head id="Head1" runat="server">
		<link rel="stylesheet" type="text/css" href="style/style.css">
        <title>Administrator</title>
        <script type="text/javascript" src="sliderengine/jquery.js"></script><script type="text/javascript" src="sliderengine/jquery.hislider.js"></script>
	    <script type="text/javascript" src="style/scrpt.js"></script>
        <script language="javascript" type="text/javascript">
            // Semicolon (;) to ensure closing of earlier scripting
            // Encapsulation
            // $ is assigned to jQuery
            ; (function ($) {

                // DOM Ready
                $(function () {

                    //Manage Users
                    $('#my-button').bind('click', function (e) {

                        // Prevents the default action to be triggered. 
                        e.preventDefault();

                        // Triggering bPopup when click event is fired
                        $('#element_to_pop_up').bPopup({
                            modalColor: 'LightSkyBlue '
                        });

                    });

                    //Create Team
                    $('#cCreate').bind('click', function (e) {

                        // Prevents the default action to be triggered. 
                        e.preventDefault();

                        // Triggering bPopup when click event is fired
                        $('#create').bPopup({
                            modalColor: 'LightSkyBlue '
                        });

                    });

                    //Send message
                    $('#cSend').bind('click', function (e) {

                        // Prevents the default action to be triggered. 
                        e.preventDefault();

                        // Triggering bPopup when click event is fired
                        $('#send').bPopup({
                            modalColor: 'LightSkyBlue '
                        });

                    });

                    //Create league
                    $('#cLeague').bind('click', function (e) {

                        // Prevents the default action to be triggered. 
                        e.preventDefault();

                        // Triggering bPopup when click event is fired
                        $('#league').bPopup({
                            modalColor: 'LightSkyBlue '
                        });

                    });

                    //Publish results
                    $('#cResults').bind('click', function (e) {

                        // Prevents the default action to be triggered. 
                        e.preventDefault();

                        // Triggering bPopup when click event is fired
                        $('#results').bPopup({
                            modalColor: 'LightSkyBlue '
                        });

                    });

                    //Add new Users
                    $('#cNew').bind('click', function (e) {

                        // Prevents the default action to be triggered. 
                        e.preventDefault();

                        // Triggering bPopup when click event is fired
                        $('#new').bPopup({
                            modalColor: 'LightSkyBlue '
                        });

                    });

                    //Admin structure
                    $('#cStruct').bind('click', function (e) {

                        // Prevents the default action to be triggered. 
                        e.preventDefault();

                        // Triggering bPopup when click event is fired
                        $('#struct').bPopup({
                            modalColor: 'LightSkyBlue '
                        });

                    });

                    


                });

            })(jQuery);
        </script>
         <script src="http://ajax.googleapis.com/ajax/libs/jquery/0.10.0/jquery.min.js"></script>
         <script src="style/jquery.bpopup-0.10.0.min.js"></script>
    </head>
	<body id="body">
		<div id="header">
			<div id = "logo">
				<img src = "images/logo.png" width = "150" height = "150" alt="img"/>
			</div>
		</div>
		<header class="blue">
				<ul>
					<li><a href="Default.aspx">Home</a></li>
					<li><a href="javascript:void(0);">Captain</a></li>
					<li><a href="javascript:void(0);">Teams</a></li>
					<li><a href="javascript:void(0);">Messages</a></li>
					<li><a href="javascript:void(0);" class="active">Admin</a></li>
					<li><a href="javascript:void(0);">Logouts</a></li>
				</ul>
			</header>
		<div id = "wrapper">
			
			<div id="content">
               <table cellspacing="25">
                <tr>
                    <td><button id="my-button"><img src="images/edit.png" id="my-buttton" length="70" width="70" alt="Manage Users" onclick="div_show()"/><p>Manage Users</p></button><td>
                    <td><button id="cCreate"><img src="images/add.png" id="Img1" length="70" width="70" alt="Manage Users" onclick="div_show()"/><p>Create Team</p></button><td>
                    <td><button id="cSend"><img src="images/message.png" id="Img2" length="70" width="70" alt="Manage Users" onclick="div_show()"/><p>Send message</p></button><td>
                    <td><button id="cLeague"><img src="images/lig.png" id="Img3" length="70" width="70" alt="Manage Users" onclick="div_show()"/><p>Create League</p></button><td>
                </tr>
                <tr>
                    <td><button id="cResults"><img src="images/result.png" id="Img4" length="70" width="70" alt="Manage Users" onclick="div_show()"/><p>Publish Results</p></button><td>
                   <td><button id="cNew"><img src="images/new.png" id="Img5" length="70" width="70" alt="Manage Users" onclick="div_show()"/><p>Add New User</p></button><td>
                    <td><button id="cStruct"><img src="images/admin.png" id="Img6" length="70" width="70" alt="Manage Users" onclick="div_show()"/><p>Structure Admin</p></button><td>
                </tr>
               </table>
               
                <!-- Element to pop up -->
                <div id="element_to_pop_up">
                    <form>
			            <input name="name" placeholder="What is your name?" class="name" required />
			            <input name="emailaddress" placeholder="What is your email?" class="email" type="email" required />
			            <textarea rows="4" cols="50" name="subject" placeholder="Please enter your message" class="message" required></textarea>
			            <input name="submit" class="btn" type="submit" value="Send" />
			        </form>
                </div>
                <div id = "create">
                    //Plug in code here
                </div>
                <div id = "send">
                   //Plug in code here
                </div>
                <div id = "league">
                    //Plug in code here
                </div>
                <div id = "results">
                    //Plug in code here
                </div>
                <div id = "new">
                    //Plug in code here
                </div>
                <div id = "struct">
                    //Plug in code here
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

