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
using Carab.BusinessObjects.Layers;
using CarabiXbase._Object;
using DevExpress.Web;
using DevExpress.Web.ASPxGridView;



public partial class WebUserControl2 : System.Web.UI.UserControl
{
    private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (DAL.Key.DbData == null)
            DAL.Setup(null, new OleDbConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString), loadTableSchemas: true);

        string name = Request.QueryString["un"];
        string table = (string)(Session[name + "TableName"]);
        if (DAL.Key.DbData.DataSet.Get.Tables.Contains(table))
        {
            ASPxGridView1.DataSource = DAL.Key.DbData.DataTable.Get(table);
        }


        if (ddlFilter.SelectedValue == "0")
        {
            SearchFilter.Visible = false;
            ddlSelection.Visible = false;
            ASPxGridView1.Visible = false;
        }

    }

    protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();

        if (ddlFilter.SelectedValue == "Site")
        {
           
            SearchFilter.Visible = true;
            ddlSelection.Visible = true;
            ddlSelection.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp"), "IDSite", "Site");

        }
        else if (ddlFilter.SelectedValue == "Industry")
        {


            SearchFilter.Visible = true;
            ddlSelection.Visible = true;
            ddlSelection.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterIndustrySp", "FilterIndustrySp"), "IDIndustry", "Industry");
        }
        else if (ddlFilter.SelectedValue == "Department")
        {

            SearchFilter.Visible = true;
            ddlSelection.Visible = true;
            ddlSelection.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp"), "IDDepartment", "Department");
        }
        else if (ddlFilter.SelectedValue == "Company")
        {


            SearchFilter.Visible = true;
            ddlSelection.Visible = true;
           ddlSelection.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterCompanySp", "FilterCompanySp", true), "IDCompany", "Company");

        }
        else
        {
            ddlFilter.SelectedValue = "0";
            SearchFilter.Visible = false;
            ddlSelection.Visible = false;
        }

        SearchFilter.Text = "Select a " + ddlFilter.Text + ": ";



    }


    protected void btnFilter_Click(object sender, EventArgs e)
    {

        int? selectedValue;

        if (ddlSelection.SelectedValue.AsInt() == 0)
        {
            selectedValue = null;
        }
        else
        {
            selectedValue = ddlSelection.SelectedValue.AsInt();
        }
        string tmpTableName = "FilterSearchSp" + ddlFilter.SelectedItem.Text + selectedValue;
        ASPxGridView1.cxGridSetup(DAL.Key.DbData.DataTable.Get_FromSP("FilterSearchSp", tmpTableName, cmdParameters: new object[] { ddlFilter.SelectedItem.Text, selectedValue }));
        ASPxGridView1.Visible = true;
        string user = Request.QueryString["un"];
        Session[user + "TableName"] = tmpTableName;
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {

        int? selectedValue;

        if (ddlSelection.SelectedValue.AsInt() == 0)
        {
            selectedValue = null;
        }
        else
        {
            selectedValue = ddlSelection.SelectedValue.AsInt();
        }

        string tmpTableName = "SearchPersonSp" + TxtSearch.Text + ddlFilter.SelectedItem.Text + selectedValue;
        ASPxGridView1.cxGridSetup(DAL.Key.DbData.DataTable.Get_FromSP("SearchPersonSp", tmpTableName, cmdParameters: new object[] { TxtSearch.Text, ddlFilter.SelectedItem.Text, selectedValue }));
        ASPxGridView1.Visible = true;
        TxtSearch.Text = "";
        string user = Request.QueryString["un"];
        Session[user + "TableName"] = tmpTableName;

    }

    protected void btnAddSearch_Click(object sender, EventArgs e)
    {
        int? selectedValue;

        if (ddlSelection.SelectedValue.AsInt() == 0)
        {
            selectedValue = null;
        }
        else
        {
            selectedValue = ddlSelection.SelectedValue.AsInt();
        }
        string tmpTableName = "sp_SearchAdvPerson" + txtUserSearch.Text + txtNameSearch.Text + txtSurnameSearch.Text +
                                 txtKeywordSearch.Text + ddlFilter.SelectedItem.Text + selectedValue;
        ASPxGridView1.cxGridSetup(DAL.Key.DbData.DataTable.Get_FromSP("sp_SearchAdvPerson", tmpTableName, cmdParameters: new object[] { txtUserSearch.Text, txtNameSearch.Text, txtSurnameSearch.Text, txtKeywordSearch.Text, ddlFilter.SelectedItem.Text, selectedValue }));
        ASPxGridView1.Visible = true;
        txtNameSearch.Text = "";
        txtSurnameSearch.Text = "";
        txtUserSearch.Text = "";
        txtKeywordSearch.Text = "";
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