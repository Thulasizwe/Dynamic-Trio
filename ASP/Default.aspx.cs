using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DevExpress.Web.ASPxGridView;
using DevExpress.Web.ASPxTabControl;

public partial class _Default : System.Web.UI.Page
{
    private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        string name = Request.QueryString["un"];
        int index = Request.QueryString["ind"].AsInt();

        string[] temp = (string[]) Session["login"];

        if (temp == null || temp[index] != name)
        {
            Response.Redirect("Login.aspx");
        }

        //string name = Session["login"].ToString();//((string[])Session["login"]);
        if (name != "guest")
        {
            DataRow[] userRow;
            DAL.Key.DbData.DataTable.Get_DataRows("contactPerson", "[ScreenName] = '" + name + "'", out userRow);

            WelcomeLabel.Text ="Welcome " + userRow[0]["PersonName"].ToString() + @" " + userRow[0]["PersonSurname"].ToString() + "!";

            EventGrid.Visible = true;

            DataTable dt = DAL.Key.DbData.DataTable.Get_FromSP("sp_GetUserEvents", "UserEvents", cmdParameters: new object[] { name, 1 });

            EventGrid.thisGridsData.theDataTable = dt;
            EventGrid.thisGridsData.ColumnNumbers = new []{0};
            EventGrid.thisGridsData.Heading = "My Recent Events";

            int userID = userRow[0]["IDPerson"].AsInt();

            NewsControl.DataSource = DAL.Key.DbData.DataTable.Get_FromSP("sp_GetUserNews", "UserNews", cmdParameters: new object[] {userID});
            NewsControl.HeaderTextField = "Heading";
            NewsControl.DateField = "DateCreated";
            NewsControl.ItemSettings.DateFormatString = "{0:dd/MM/yyyy H:mm}";
            NewsControl.TextField = "Message";
            NewsControl.ImageUrlField = "Image";
            NewsControl.ItemImage.Width = 50;
            NewsControl.DataBind();

            DataTable userDT = DAL.Key.DbData.DataTable.Get_FromSP("sp_GetUserRatings", "UserRatings", cmdParameters: new object[] {userID});

            int depRating = userDT.Rows[0]["Department Average"].AsInt();
            if (depRating < 35) DepRatingLabel.ForeColor = Color.Red;
            else if (depRating > 70) DepRatingLabel.ForeColor = Color.ForestGreen;
            else DepRatingLabel.ForeColor = Color.DarkOrange;

            DepRatingLabel.Text = depRating.ToString() + "%";

            int compRating = userDT.Rows[0]["Company Average"].AsInt();
            if (compRating < 35) CompRatingLabel.ForeColor = Color.Red;
            else if (compRating > 70) CompRatingLabel.ForeColor = Color.ForestGreen;
            else CompRatingLabel.ForeColor = Color.DarkOrange;

            CompRatingLabel.Text = compRating.ToString() + "%";
        }
        else
        {
            WelcomeLabel.Text = "Welcome guest!";
            EventGrid.Visible = false;
        }
    }
}