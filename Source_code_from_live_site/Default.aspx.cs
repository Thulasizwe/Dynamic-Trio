using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.ASPxTabControl;

public partial class _Default : System.Web.UI.Page
{
    private int userID;
    protected void Page_Load(object sender, EventArgs e)
    {
        string name = Request.QueryString["un"];
        int index = Convert.ToInt32(Request.QueryString["ind"]);

        string[] temp = (string[]) Session["login"];

        if (temp == null || temp[index] != name)
        {
            Response.Redirect("Login.aspx");
        }

        //string name = Session["login"].ToString();//((string[])Session["login"]);
        if (name != "guest")
        {
            string query = "select * from contactPerson where ScreenName = '" + name + "'";
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, sqlcon))
                {
                    sqlcon.Open();
                    SqlDataReader userRow = cmd.ExecuteReader();
                    try
                    {
                        while (userRow.Read())
                        {
                            WelcomeLabel.Text = "Welcome " + userRow["PersonName"].ToString() + @" " + userRow["PersonSurname"].ToString() + "!";
                            userID = Convert.ToInt32(userRow["IDPerson"]);
                        }
                    }
                    finally
                    {
                        userRow.Close();
                    }
                }
            }
           
            EventGrid.Visible = true;

            DataTable dt = new DataTable();
           
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetUserEvents", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@scrName", SqlDbType.VarChar).Value = name;
                    cmd.Parameters.Add("@TOP5", SqlDbType.VarChar).Value = 1;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            EventGrid.thisGridsData.theDataTable = dt;
            EventGrid.thisGridsData.ColumnNumbers = new []{0};
            EventGrid.thisGridsData.Heading = "My Recent Events";

            DataTable UserNews = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetUserNews", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ID", SqlDbType.VarChar).Value = userID;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(UserNews);
                    }
                }
            }


            NewsControl.DataSource = UserNews; 
            NewsControl.HeaderTextField = "Heading";
            NewsControl.DateField = "DateCreated";
            NewsControl.ItemSettings.DateFormatString = "{0:dd/MM/yyyy H:mm}";
            NewsControl.TextField = "Message";
            NewsControl.ImageUrlField = "Image";
            NewsControl.ItemImage.Width = 50;
            NewsControl.DataBind();

            DataTable userDT = new DataTable();   
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetUserRatings", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@UID", SqlDbType.VarChar).Value = userID;
                    
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(userDT);
                    }
                }
            }

            int depRating = Convert.ToInt32(userDT.Rows[0]["Department Average"]);
            if (depRating < 35) DepRatingLabel.ForeColor = Color.Red;
            else if (depRating > 70) DepRatingLabel.ForeColor = Color.ForestGreen;
            else DepRatingLabel.ForeColor = Color.DarkOrange;

            DepRatingLabel.Text = depRating.ToString() + "%";

            int compRating = Convert.ToInt32(userDT.Rows[0]["Company Average"]);
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