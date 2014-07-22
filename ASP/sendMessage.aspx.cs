using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DevExpress.Web.ASPxEditors;

public partial class sendMessage : System.Web.UI.Page
{
    private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            depDiv.Visible = false;
            userDiv.Visible = false;
            ErrorMessage.Visible = false;

            DAL.Key.DbData.DataTable.Get_FromSP("FilterIndustrySp", "FilterIndustrySp");
            ddlIndustry.DataSource = DAL.Key.DbData.DataTable.Get("FilterIndustrySp");
            ddlIndustry.DataTextField = DAL.Key.DbData.DataTable.Get("FilterIndustrySp").Columns[1].ToString();
            ddlIndustry.DataValueField = DAL.Key.DbData.DataTable.Get("FilterIndustrySp").Columns[0].ToString();
            ddlIndustry.DataBind();

            DAL.Key.DbData.DataTable.Get_FromSP("sp_LoadEventCompany", "sp_LoadEventCompany", false, "",
                new object[] {ddlIndustry.SelectedValue});
            ddlCompany.DataSource = DAL.Key.DbData.DataTable.Get("sp_LoadEventCompany");
            ddlCompany.DataTextField = DAL.Key.DbData.DataTable.Get("sp_LoadEventCompany").Columns[1].ToString();
            ddlCompany.DataValueField = DAL.Key.DbData.DataTable.Get("sp_LoadEventCompany").Columns[0].ToString();
            ddlCompany.DataBind();

            if (ddlCompany.Items.Count != 0)
            {
                DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", false, "",
                    new object[] {ddlCompany.SelectedValue});
                ddlSite.DataSource = DAL.Key.DbData.DataTable.Get("FilterSiteSp");
                ddlSite.DataTextField = DAL.Key.DbData.DataTable.Get("FilterSiteSp").Columns[1].ToString();
                ddlSite.DataValueField = DAL.Key.DbData.DataTable.Get("FilterSiteSp").Columns[0].ToString();
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
                DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp", false, "",
                    new object[] {ddlSite.SelectedValue});
                ddlDepartment.DataSource = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp");
                ddlDepartment.DataTextField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[1].ToString();
                ddlDepartment.DataValueField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[0].ToString();
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
        ScreenName.DataSource = DAL.Key.DbData.DataTable.Get("contactPerson");
        ScreenName.TextField = DAL.Key.DbData.DataTable.Get("contactPerson").Columns["ScreenName"].ToString();
        ScreenName.ValueField = DAL.Key.DbData.DataTable.Get("contactPerson").Columns[0].ToString();
        ScreenName.DataBind();
    }

    protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
    {

        DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", false, "",
                                            new object[] { ddlCompany.SelectedValue });
        ddlSite.DataSource = DAL.Key.DbData.DataTable.Get("FilterSiteSp");
        ddlSite.DataTextField = DAL.Key.DbData.DataTable.Get("FilterSiteSp").Columns[1].ToString();
        ddlSite.DataValueField = DAL.Key.DbData.DataTable.Get("FilterSiteSp").Columns[0].ToString();
        ddlSite.DataBind();

        if (ddlSite.Items.Count != 0)
        {
            DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp", false, "",
                                                new object[] { ddlSite.SelectedValue });
            ddlDepartment.DataSource = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp");
            ddlDepartment.DataTextField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[1].ToString();
            ddlDepartment.DataValueField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[0].ToString();
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
        DAL.Key.DbData.DataTable.Get_FromSP("sp_LoadEventCompany", "sp_LoadEventCompany", false, "", new object[] { ddlIndustry.SelectedValue });
        ddlCompany.DataSource = DAL.Key.DbData.DataTable.Get("sp_LoadEventCompany");
        ddlCompany.DataTextField = DAL.Key.DbData.DataTable.Get("sp_LoadEventCompany").Columns[1].ToString();
        ddlCompany.DataValueField = DAL.Key.DbData.DataTable.Get("sp_LoadEventCompany").Columns[0].ToString();
        ddlCompany.DataBind();

        if (ddlCompany.Items.Count != 0)
        {
            DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", false, "",
                                                new object[] { ddlCompany.SelectedValue });
            ddlSite.DataSource = DAL.Key.DbData.DataTable.Get("FilterSiteSp");
            ddlSite.DataTextField = DAL.Key.DbData.DataTable.Get("FilterSiteSp").Columns[1].ToString();
            ddlSite.DataValueField = DAL.Key.DbData.DataTable.Get("FilterSiteSp").Columns[0].ToString();
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
            DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp", false, "",
                                                new object[] { ddlSite.SelectedValue });
            ddlDepartment.DataSource = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp");
            ddlDepartment.DataTextField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[1].ToString();
            ddlDepartment.DataValueField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[0].ToString();
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
        DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp", false, "", new object[] { ddlSite.SelectedValue });
        ddlDepartment.DataSource = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp");
        ddlDepartment.DataTextField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[1].ToString();
        ddlDepartment.DataValueField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[0].ToString();
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
                dep = ddlDepartment.SelectedValue.AsInt();
            }

            DataRow[] newRow;
            DAL.Key.DbData.DataTable.Get_DataRows("contactPerson", "[ScreenName] = '" + Request.QueryString["un"].ToLower() + "'", out newRow);

            string uid = newRow[0]["IDPerson"].ToString();

            DAL.Key.DbData.DataTable.Get_DataRows("contactPerson_History", "[FKPerson] = " + uid, out newRow);

            foreach (DataRow row in newRow)
            {
                if (row["Note_Heading"].ToString() == "Profile_Image")
                {
                    imgURL = row["Attachment"].ToString();
                    break;
                }
            }

            DAL.Key.DbData.DataTable.Get_FromSP("sp_SendMessage", "MessageTable",
                cmdParameters: new object[] {txtTitle.Text, txtMessage.Text, user, dep, imgURL});

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