<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Accept.aspx.cs" Inherits="Captain_Accept" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="stylesheet" type="text/css" href="../style/style.css">
        <title>Captain</title>
        <script type="text/javascript" src="sliderengine/jquery.js"></script><script type="text/javascript" src="sliderengine/jquery.hislider.js"></script>
	    <script type="text/javascript" src="style/scrpt.js"></script>
        
    </head>
	<body id="body">
		<form id="form1" runat="server">
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
                
			 
			    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                        <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" />
                        <asp:BoundField DataField="Member" HeaderText="Member" SortExpression="Member" />
                        <asp:BoundField DataField="Team" HeaderText="Team" SortExpression="Team" />
                        <asp:BoundField DataField="Approved" HeaderText="Approved" SortExpression="Approved" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=.;Initial Catalog=contactASPDB;Integrated Security=True" DeleteCommand="DELETE FROM [TeamMembers] WHERE [ID] = @ID" InsertCommand="INSERT INTO [TeamMembers] ([ID], [Member], [Team], [Approved]) VALUES (@ID, @Member, @Team, @Approved)" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [TeamMembers]" UpdateCommand="UPDATE [TeamMembers] SET [Member] = @Member, [Team] = @Team, [Approved] = @Approved WHERE [ID] = @ID">
                    <DeleteParameters>
                        <asp:Parameter Name="ID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ID" Type="Int32" />
                        <asp:Parameter Name="Member" Type="Int32" />
                        <asp:Parameter Name="Team" Type="Int32" />
                        <asp:Parameter Name="Approved" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Member" Type="Int32" />
                        <asp:Parameter Name="Team" Type="Int32" />
                        <asp:Parameter Name="Approved" Type="String" />
                        <asp:Parameter Name="ID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                
			 
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
		
	    </form>
		
	</body>
</html>
