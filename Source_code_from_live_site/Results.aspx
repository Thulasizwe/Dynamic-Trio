<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Results.aspx.cs" Inherits="Results" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <h2>
            Dispute/Publish Results
        </h2>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="ResultID" HeaderText="ResultID" 
                    SortExpression="ResultID" />
                <asp:BoundField DataField="HomeTeam" HeaderText="HomeTeam" 
                    SortExpression="HomeTeam" />
                <asp:BoundField DataField="AwayTeam" HeaderText="AwayTeam" 
                    SortExpression="AwayTeam" />
                <asp:BoundField DataField="FKLeagueID" HeaderText="FKLeagueID" 
                    SortExpression="FKLeagueID" />
                <asp:BoundField DataField="FirstScore" HeaderText="FirstScore" 
                    SortExpression="FirstScore" />
                <asp:BoundField DataField="SecondScore" HeaderText="SecondScore" 
                    SortExpression="SecondScore" />
                <asp:BoundField DataField="FKGameID" HeaderText="FKGameID" 
                    SortExpression="FKGameID" />
                <asp:BoundField DataField="Confirmed" HeaderText="Confirmed" 
                    SortExpression="Confirmed" />
                <asp:BoundField DataField="ResultPath" HeaderText="ResultPath" 
                    SortExpression="ResultPath" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:contactASPDBConnectionString %>" 
            DeleteCommand="DELETE FROM [Results] WHERE [ResultID] = @ResultID" 
            InsertCommand="INSERT INTO [Results] ([HomeTeam], [AwayTeam], [FKLeagueID], [Score], [FKGameID], [Confirmed]) VALUES (@HomeTeam, @AwayTeam, @FKLeagueID, @Score, @FKGameID, @Confirmed)" 
            SelectCommand="SELECT * FROM [Results] WHERE ([Confirmed] = @Confirmed)" 
            
            
            UpdateCommand="UPDATE [Results] SET [HomeTeam] = @HomeTeam, [AwayTeam] = @AwayTeam, [FKLeagueID] = @FKLeagueID, [Score] = @Score, [FKGameID] = @FKGameID, [Confirmed] = @Confirmed WHERE [ResultID] = @ResultID">
            <DeleteParameters>
                <asp:Parameter Name="ResultID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="HomeTeam" Type="String" />
                <asp:Parameter Name="AwayTeam" Type="String" />
                <asp:Parameter Name="FKLeagueID" Type="String" />
                <asp:Parameter Name="Score" Type="String" />
                <asp:Parameter Name="FKGameID" Type="String" />
                <asp:Parameter Name="Confirmed" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="false" Name="Confirmed" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="HomeTeam" Type="String" />
                <asp:Parameter Name="AwayTeam" Type="String" />
                <asp:Parameter Name="FKLeagueID" Type="String" />
                <asp:Parameter Name="Score" Type="String" />
                <asp:Parameter Name="FKGameID" Type="String" />
                <asp:Parameter Name="Confirmed" Type="String" />
                <asp:Parameter Name="ResultID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <a href="Default.aspx">
            Go back to home page
        </a>
    </div>
    </form>
</body>
</html>
