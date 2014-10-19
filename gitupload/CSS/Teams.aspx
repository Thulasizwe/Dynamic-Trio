<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Teams.aspx.cs" Inherits="Teams" %>

<html>
	<head runat="server">
		<link rel="stylesheet" type="text/css" href="style/style.css">
        <title></title>
        <script type="text/javascript" src="sliderengine/jquery.js"></script><script type="text/javascript" src="sliderengine/jquery.hislider.js"></script>
       
	</head>
	<body>
		<div id="header">
			<div id = "logo">
				<img src = "images/logo.png" width = "150" height = "150" alt="img"/>
			</div>
		</div>
		<header class="blue">
				<ul>
					<li><a href="Default.aspx" >Home</a></li>
					<li><a href="viewLog.aspx">Log</a></li>
					<li><a href="Teams.aspx" class="active">Teams</a></li>
					<li><a href="Leagues.aspx">Leagues</a></li>
					<li><a href="Results.aspx">Results</a></li>
                    <li><a href="Message.aspx">Message</a></li>
					<li><a href="javascript:void(0);">Logouts</a></li>
				</ul>
			</header>
             <div id='hislider1' style=" max-width:960px;  max-height:360px;height:100%; margin: 0 auto;">
        	
        	    <noscript>The slider is powered by <strong>Hi Slider</strong>, a easy jQuery image slider from <a target="_blank" href="hislider.com">hislider.com</a>. Please enable JavaScript to view.</noscript><div class="hi-about-text" style="display:none">This jQuery slider was created with the free <a style="color:#FFF;" href="http://hislider.com" target="_blank">Hi Slider</a> for WordPress plugin,Joomla & Drupal Module from hislider.com.<br /><br /><a style="color:#FFF;" href="#" class="hi-about-ok">OK</a></div><div class="hi-slider-watermark"  style="display:none"><a href="http://hislider.com" target="_blank">hislider.com</a></div>
            </div>
		<div id = "wrapper">
			
			<div id="content">
				<form id="form1" runat="server">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" 
            EmptyDataText="There are no data records to display." Visible="False">
            <Columns>
                <asp:BoundField DataField="TeamID" HeaderText="TeamID" 
                    SortExpression="TeamID" />
                <asp:BoundField DataField="TeamName" HeaderText="TeamName" 
                    SortExpression="TeamName" />
              <asp:BoundField DataField="ImagePath" HeaderText="ImagePath" 
                    SortExpression="ImagePath" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>"  
            SelectCommand="SELECT TeamName, TeamID, ImagePath FROM SetupTeams" >
            </asp:SqlDataSource>
        <br />

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

