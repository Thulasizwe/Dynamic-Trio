using System;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.Web.ASPxGridView;



public partial class WebUserControl2 : System.Web.UI.UserControl
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string name = Request.QueryString["un"];
        string table = (string)(Session[name + "TableName"]);
    }

 
    protected void btnSearch_Click(object sender, EventArgs e)
    {

        string tmpTableName = "SearchPersonSp" + TxtSearch.Text;
        DataTable SearchPersonSp = new DataTable();
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("SearchPersonSp", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Search", SqlDbType.VarChar).Value = TxtSearch.Text;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(SearchPersonSp);
                }
            }
        }
        ASPxGridView1.DataSource = SearchPersonSp;
        ASPxGridView1.Visible = true;
        TxtSearch.Text = "";
        string user = Request.QueryString["un"];
        Session[user + "TableName"] = tmpTableName;

    }

    protected void btnAddSearch_Click(object sender, EventArgs e)
    {
        
        string tmpTableName = "sp_SearchAdvPerson" + txtUserSearch.Text + txtNameSearch.Text;
        DataTable sp_SearchAdvPerson = new DataTable();
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("sp_SearchAdvPerson", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Username", SqlDbType.VarChar).Value = txtUserSearch.Text;
                cmd.Parameters.Add("@Name", SqlDbType.VarChar).Value = txtNameSearch.Text;
                cmd.Parameters.Add("@Surname", SqlDbType.VarChar).Value = txtSurnameSearch.Text;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(sp_SearchAdvPerson);
                }
            }
        }

        ASPxGridView1.DataSource = sp_SearchAdvPerson;
        ASPxGridView1.Visible = true;
        txtNameSearch.Text = "";
        txtSurnameSearch.Text = "";
        txtUserSearch.Text = "";
        string name = Request.QueryString["un"];
        Session[name + "TableName"] = tmpTableName;
    }

    protected void DisplayAdvanced_Click(object sender, EventArgs e)
    {
        if (divAdvancedSearch.Visible == false)
        {
            divAdvancedSearch.Visible = true;
            divBasicSearch.Visible = false;
            lbnAdvanced.Text = "Simple Search";
        }
        else
        {
            divAdvancedSearch.Visible = false;
            divBasicSearch.Visible = true;
            lbnAdvanced.Text = "Advanced Search";
        }
    }

    protected void checkUserSecurity(object sender, EventArgs e)
    {
        if (Request.QueryString["un"].ToLower() == "guest")
        {
            ASPxGridView1.Columns[5].Visible = false;
            ASPxGridView1.Columns[6].Visible = false;
            ASPxGridView1.Columns[7].Visible = false;
        }
    }
}