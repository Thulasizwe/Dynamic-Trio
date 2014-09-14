<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<html>
	<head runat="server">
		<link rel="stylesheet" type="text/css" href="style.css">
        <title></title>
        <script type="text/javascript" src="sliderengine/jquery.js"></script><script type="text/javascript" src="sliderengine/jquery.hislider.js"></script>
	</head>
	<body>
		<div id="header">
			<div id = "logo">
				<img src = "logo.png" width = "150" height = "150" alt="img"/>
			</div>
		</div>
		<header class="blue">
				<ul>
					<li><a href="javascript:void(0);" class="active">Home</a></li>
					<li><a href="javascript:void(0);">Captain</a></li>
					<li><a href="javascript:void(0);">Teams</a></li>
					<li><a href="javascript:void(0);">Messages</a></li>
					<li><a href="javascript:void(0);">Admin</a></li>
					<li><a href="javascript:void(0);">Logouts</a></li>
				</ul>
			</header>
             <div id='hislider1' style=" max-width:960px;  max-height:360px;height:100%; margin: 0 auto;">
        	
        	    <noscript>The slider is powered by <strong>Hi Slider</strong>, a easy jQuery image slider from <a target="_blank" href="hislider.com">hislider.com</a>. Please enable JavaScript to view.</noscript><div class="hi-about-text" style="display:none">This jQuery slider was created with the free <a style="color:#FFF;" href="http://hislider.com" target="_blank">Hi Slider</a> for WordPress plugin,Joomla & Drupal Module from hislider.com.<br /><br /><a style="color:#FFF;" href="#" class="hi-about-ok">OK</a></div><div class="hi-slider-watermark"  style="display:none"><a href="http://hislider.com" target="_blank">hislider.com</a></div>
            </div>
		<div id = "wrapper">
			
			<div id="content">
				
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
				<img src="chelsea.jpg" width="80" height="80"/><br><br>
				<img src="v.png" width="40" height="40"/><br><br>
				<img src="liverpool.png" width="80" height="80"/>
			</div>
		</div>

		<br/>
		
	</body>
</html>

