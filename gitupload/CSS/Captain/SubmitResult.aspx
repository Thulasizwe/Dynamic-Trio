<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SubmitResult.aspx.cs" Inherits="Captain_SubmitResult" %>

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
                           <td><label> League </label></td>
                           <td><asp:DropDownList ID="dropLeague" runat="server" DataSourceID="SqlDataSource1" DataTextField="LeagueName" DataValueField="LeagueID"> </asp:DropDownList>
                               <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=.;Initial Catalog=contactASPDB;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [SetupLeague]"></asp:SqlDataSource>
                           </td>
                        </tr>
                         <tr>
                           <td><label> Your Team </label></td>
                           <td><asp:DropDownList ID="team" runat="server" DataSourceID="SqlDataSource2" DataTextField="TeamName" DataValueField="TeamID"> </asp:DropDownList>
                               <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Data Source=.;Initial Catalog=contactASPDB;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [SetupTeams]"></asp:SqlDataSource>
                             </td>
                        </tr>
                        <tr>
                           <td><label> Opponent </label></td>
                           <td><asp:DropDownList ID="dropOpponent" runat="server" DataSourceID="SqlDataSource3" DataTextField="TeamName" DataValueField="TeamID"> </asp:DropDownList>
                               <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="Data Source=.;Initial Catalog=contactASPDB;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [SetupTeams]"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td><label> Your score </label></td>
                            <td> <asp:TextBox ID="teamScore" runat="server" ></asp:TextBox> </td>
                        </tr>  
                       <tr>
                            <td><label> Opponent </label></td>
                            <td> <asp:TextBox ID="txtOpp" runat="server" ></asp:TextBox> </td>
                        </tr>     
                        <tr>
                             <td><label> Snapshot Proof </label></td>
                            <td> <asp:FileUpload ID="FileUpload1" runat="server" /> </td>
                        </tr>
                        <tr><td><asp:Button ID="submitResult" runat="server" Text="Submit" OnClick="submit" /></td></tr>
                        
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
