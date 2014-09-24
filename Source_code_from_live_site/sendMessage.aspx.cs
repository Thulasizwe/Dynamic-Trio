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

using DevExpress.Web.ASPxEditors;

public partial class sendMessage : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            depDiv.Visible = false;
            userDiv.Visible = false;
            ErrorMessage.Visible = false;
            DataTable FilterIndustrySp = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("FilterIndustrySp", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(FilterIndustrySp);
                    }
                }
            }
            
            ddlIndustry.DataSource = FilterIndustrySp;
            ddlIndustry.DataTextField = FilterIndustrySp.Columns[1].ToString();
            ddlIndustry.DataValueField = FilterIndustrySp.Columns[0].ToString();
            ddlIndustry.DataBind();

            DataTable sp_LoadEventCompany = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_LoadEventCompany", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IndID", SqlDbType.VarChar).Value = ddlIndustry.SelectedValue;
                  
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(sp_LoadEventCompany);
                    }
                }
            }
           
            ddlCompany.DataSource = sp_LoadEventCompany;
            ddlCompany.DataTextField = sp_LoadEventCompany.Columns[1].ToString();
            ddlCompany.DataValueField = sp_LoadEventCompany.Columns[0].ToString();
            ddlCompany.DataBind();

            if (ddlCompany.Items.Count != 0)
            {
                DataTable FilterSiteSp = new DataTable();
                using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("FilterSiteSp", sqlcon))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@CompanyID", SqlDbType.VarChar).Value = ddlCompany.SelectedValue;

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(FilterSiteSp);
                        }
                    }
                }
               
                ddlSite.DataSource = FilterSiteSp;
                ddlSite.DataTextField = FilterSiteSp.Columns[1].ToString();
                ddlSite.DataValueField = FilterSiteSp.Columns[0].ToString();
                ddlSite.DataBind();
            }
            else
            {
                ddlCompany.Items.Add("No Company Available");
                ddlSite.Items.Clear();
                ddlSite.Items.Add("No Sites Available");
            }

            if (ddlSite.Text != "No Sites Available")
            {
                DataTable FilterDepartmentSp = new DataTable();
                using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("FilterDepartmentSp", sqlcon))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@SiteID", SqlDbType.VarChar).Value = ddlSite.SelectedValue;

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(FilterDepartmentSp);
                        }
                    }
                }
               
                ddlDepartment.DataSource = FilterDepartmentSp;
                ddlDepartment.DataTextField = FilterDepartmentSp.Columns[1].ToString();
                ddlDepartment.DataValueField = FilterDepartmentSp.Columns[0].ToString();
                ddlDepartment.DataBind();
            }
            else
            {
                ddlDepartment.Items.Clear();
                ddlDepartment.Items.Add("No Departments Available");
            }

            ListBoxColumn clm1 = new ListBoxColumn("ScreenName", "Screen Name");
            ListBoxColumn clm2 = new ListBoxColumn("PersonName", "Name");
            ListBoxColumn clm3 = new ListBoxColumn("PersonSurname", "Surame");
            ScreenName.Columns.Add(clm1);
            ScreenName.Columns.Add(clm2);
            ScreenName.Columns.Add(clm3);
        }
        DataTable contactPerson = new DataTable();
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("Select * from contactPerson", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(contactPerson);
                }
            }
        }
        ScreenName.DataSource = contactPerson;
        ScreenName.TextField = contactPerson.Columns["ScreenName"].ToString();
        ScreenName.ValueField = contactPerson.Columns[0].ToString();
        ScreenName.DataBind();
    }

    protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
    {

        DataTable FilterSiteSp = new DataTable();
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("FilterSiteSp", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@CompanyID", SqlDbType.VarChar).Value = ddlCompany.SelectedValue;

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(FilterSiteSp);
                }
            }
        }
        ddlSite.DataSource = FilterSiteSp;
        ddlSite.DataTextField = FilterSiteSp.Columns[1].ToString();
        ddlSite.DataValueField = FilterSiteSp.Columns[0].ToString();
        ddlSite.DataBind();

        if (ddlSite.Items.Count != 0)
        {
            DataTable FilterDepartmentSp = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("FilterDepartmentSp", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@SiteID", SqlDbType.VarChar).Value = ddlSite.SelectedValue;

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(FilterDepartmentSp);
                    }
                }
            }
            ddlDepartment.DataSource = FilterDepartmentSp;
            ddlDepartment.DataTextField = FilterDepartmentSp.Columns[1].ToString();
            ddlDepartment.DataValueField = FilterDepartmentSp.Columns[0].ToString();
            ddlDepartment.DataBind();
        }
        else
        {
            ddlDepartment.Items.Clear();
            ddlDepartment.Items.Add("No Departments Available");
            ddlSite.Items.Add("No Sites Available");
        }
    }

    protected void ddlIndustry_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable sp_LoadEventCompany = new DataTable();
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("sp_LoadEventCompany", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IndID", SqlDbType.VarChar).Value = ddlIndustry.SelectedValue;

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(sp_LoadEventCompany);
                }
            }
        }
        ddlCompany.DataSource = sp_LoadEventCompany;
        ddlCompany.DataTextField = sp_LoadEventCompany.Columns[1].ToString();
        ddlCompany.DataValueField = sp_LoadEventCompany.Columns[0].ToString();
        ddlCompany.DataBind();

        if (ddlCompany.Items.Count != 0)
        {
            DataTable FilterSiteSp = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("FilterSiteSp", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@CompanyID", SqlDbType.VarChar).Value = ddlCompany.SelectedValue;

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(FilterSiteSp);
                    }
                }
            }
            ddlSite.DataSource = FilterSiteSp;
            ddlSite.DataTextField = FilterSiteSp.Columns[1].ToString();
            ddlSite.DataValueField = FilterSiteSp.Columns[0].ToString();
            ddlSite.DataBind();
        }
        else
        {
            ddlCompany.Items.Add("No Company Available");
            ddlSite.Items.Clear();
            ddlSite.Items.Add("No Sites Available");
        }


        if (ddlSite.Text != "No Sites Available")
        {
            DataTable FilterDepartmentSp = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("FilterDepartmentSp", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@SiteID", SqlDbType.VarChar).Value = ddlSite.SelectedValue;

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(FilterDepartmentSp);
                    }
                }
            }
            ddlDepartment.DataSource = FilterDepartmentSp;
            ddlDepartment.DataTextField = FilterDepartmentSp.Columns[1].ToString();
            ddlDepartment.DataValueField = FilterDepartmentSp.Columns[0].ToString();
            ddlDepartment.DataBind();
        }
        else
        {
            ddlDepartment.Items.Clear();
            ddlDepartment.Items.Add("No Departments Available");
        }
    }

    protected void ddlSite_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable FilterDepartmentSp = new DataTable();
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("FilterDepartmentSp", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@SiteID", SqlDbType.VarChar).Value = ddlSite.SelectedValue;

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(FilterDepartmentSp);
                }
            }
        }
        ddlDepartment.DataSource = FilterDepartmentSp;
        ddlDepartment.DataTextField = FilterDepartmentSp.Columns[1].ToString();
        ddlDepartment.DataValueField = FilterDepartmentSp.Columns[0].ToString();
        ddlDepartment.DataBind();

        if (ddlDepartment.Items.Count == 0)
        {
            ddlDepartment.Items.Add("No Departments Available");
        }

    }

    protected void rdbDepatment_CheckedChanged(object sender, EventArgs e)
    {
        rdbDepatment.Checked = true;
        rdbPerson.Checked = false;
        depDiv.Visible = true;
        userDiv.Visible = false;
    }

    protected void rdbPerson_CheckedChanged(object sender, EventArgs e)
    {
        rdbDepatment.Checked = false;
        rdbPerson.Checked = true;
        depDiv.Visible = false;
        userDiv.Visible = true;
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        if (txtMessage.Text != "" && txtTitle.Text != "" && (rdbDepatment.Checked || rdbPerson.Checked))
        {
            int? dep = null;
            string user = null;
            string imgURL = null;

            if (rdbPerson.Checked)
            {
                if (ScreenName.Text == "")
                {
                    ErrorMessage.Visible = true;
                    ErrorMessage.Text = "Please select a user.";
                    ErrorMessage.ForeColor = Color.Red;
                    return; 
                }
                user = ScreenName.Text;
            }
            if (rdbDepatment.Checked)
            {
                if (ddlDepartment.Text == "No Departments Available")
                {
                    ErrorMessage.Visible = true;
                    ErrorMessage.Text = "Please select a department.";
                    ErrorMessage.ForeColor = Color.Red;
                    return; 
                }
                dep = Convert.ToInt32(ddlDepartment.SelectedValue);
            }

            //DataRow[] newRow;
            //DAL.Key.DbData.DataTable.Get_DataRows("contactPerson", "[ScreenName] = '" + Request.QueryString["un"].ToLower() + "'", out newRow);
            DataTable contactPerson = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("Select * from contactPerson WHERE [ScreenName] = '" + Request.QueryString["un"].ToLower() + "'", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(contactPerson);
                    }
                }
            }

            string uid = contactPerson.Rows[0]["IDPerson"].ToString();

            
            DataTable contactPerson_History = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("Select * from contactPerson_History WHERE [FKPerson] = '" + uid + "'", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(contactPerson_History);
                    }
                }
            }
            foreach (DataRow row in contactPerson_History.Rows)
            {
                if (row["Note_Heading"].ToString() == "Profile_Image")
                {
                    imgURL = row["Attachment"].ToString();
                    break;
                }
            }
            DataTable MessageTable = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_SendMessage", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Title", SqlDbType.VarChar).Value = txtTitle.Text;
                    cmd.Parameters.Add("@MessText", SqlDbType.VarChar).Value = txtMessage.Text;
                    cmd.Parameters.Add("@Username", SqlDbType.VarChar).Value = user;
                    cmd.Parameters.Add("@DEP", SqlDbType.VarChar).Value = dep;
                    cmd.Parameters.Add("@ImgURL", SqlDbType.VarChar).Value = imgURL;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(MessageTable);
                    }
                }
            }
           

            ErrorMessage.Visible = true;
            ErrorMessage.Text = "Message sent!";
            ErrorMessage.ForeColor = Color.ForestGreen;

        }
        else
        {
            ErrorMessage.Visible = true;
            ErrorMessage.Text = "Please make sure you entered all fields.";
            ErrorMessage.ForeColor = Color.Red;
        }
    }
}