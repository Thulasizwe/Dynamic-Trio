﻿using System;
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
//using Carab.BusinessObjects.Layers;
//using CarabiXbase._Object;
using DevExpress.Web;
using DevExpress.Web.ASPxGridView;



public partial class WebUserControl2 : System.Web.UI.UserControl
{
    //private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (DAL.Key.DbData == null)
        //    DAL.Setup(null, new OleDbConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString), loadTableSchemas: true);

        string name = Request.QueryString["un"];
        string table = (string)(Session[name + "TableName"]);


        //if (DAL.Key.DbData.DataSet.Get.Tables.Contains(table))
        //{
        //    ASPxGridView1.DataSource = DAL.Key.DbData.DataTable.Get(table);
        //}


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
            DataTable FilterSiteSp = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("FilterSiteSp", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(FilterSiteSp);
                    }
                }
            }
            SearchFilter.Visible = true;
            ddlSelection.Visible = true;
            ddlSelection.cxBindCombo(FilterSiteSp, "IDSite", "Site");

        }
        else if (ddlFilter.SelectedValue == "Industry")
        {

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
            SearchFilter.Visible = true;
            ddlSelection.Visible = true;
            ddlSelection.cxBindCombo(FilterIndustrySp, "IDIndustry", "Industry");
        }
        else if (ddlFilter.SelectedValue == "Department")
        {
            DataTable FilterDepartmentSp = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("FilterDepartmentSp", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(FilterDepartmentSp);
                    }
                }
            }
            SearchFilter.Visible = true;
            ddlSelection.Visible = true;
            ddlSelection.cxBindCombo(FilterDepartmentSp, "IDDepartment", "Department");
        }
        else if (ddlFilter.SelectedValue == "Company")
        {
            DataTable FilterCompanySp = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("FilterCompanySp", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(FilterCompanySp);
                    }
                }
            }

            SearchFilter.Visible = true;
            ddlSelection.Visible = true;
            ddlSelection.cxBindCombo(FilterCompanySp, "IDCompany", "Company");

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

        if (Convert.ToInt32(ddlSelection.SelectedValue) == 0)
        {
            selectedValue = null;
        }
        else
        {
            selectedValue = Convert.ToInt32(ddlSelection.SelectedValue);
        }
        string tmpTableName = "FilterSearchSp" + ddlFilter.SelectedItem.Text + selectedValue;
        DataTable FilterSearchSp = new DataTable();
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("FilterSearchSp", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Filter", SqlDbType.VarChar).Value = ddlFilter.SelectedItem.Text;
                cmd.Parameters.Add("@ID", SqlDbType.VarChar).Value = selectedValue;

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(FilterSearchSp);
                }
            }
        }
        ASPxGridView1.cxGridSetup(FilterSearchSp);
        ASPxGridView1.Visible = true;
        string user = Request.QueryString["un"];
        Session[user + "TableName"] = tmpTableName;
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {

        int? selectedValue;

        if (Convert.ToInt32(ddlSelection.SelectedValue) == 0)
        {
            selectedValue = null;
        }
        else
        {
            selectedValue = Convert.ToInt32(ddlSelection.SelectedValue);
        }

        string tmpTableName = "SearchPersonSp" + TxtSearch.Text + ddlFilter.SelectedItem.Text + selectedValue;
        DataTable SearchPersonSp = new DataTable();
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("SearchPersonSp", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Search", SqlDbType.VarChar).Value = TxtSearch.Text;
                cmd.Parameters.Add("@Filter", SqlDbType.VarChar).Value = ddlFilter.SelectedItem.Text;
                cmd.Parameters.Add("@ID", SqlDbType.VarChar).Value = selectedValue;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(SearchPersonSp);
                }
            }
        }
        ASPxGridView1.cxGridSetup(SearchPersonSp);
        ASPxGridView1.Visible = true;
        TxtSearch.Text = "";
        string user = Request.QueryString["un"];
        Session[user + "TableName"] = tmpTableName;

    }

    protected void btnAddSearch_Click(object sender, EventArgs e)
    {
        int? selectedValue;

        if (Convert.ToInt32(ddlSelection.SelectedValue) == 0)
        {
            selectedValue = null;
        }
        else
        {
            selectedValue = Convert.ToInt32(ddlSelection.SelectedValue);
        }
        string tmpTableName = "sp_SearchAdvPerson" + txtUserSearch.Text + txtNameSearch.Text + txtSurnameSearch.Text +
                                 txtKeywordSearch.Text + ddlFilter.SelectedItem.Text + selectedValue;
        DataTable sp_SearchAdvPerson = new DataTable();
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("sp_SearchAdvPerson", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Username", SqlDbType.VarChar).Value = txtUserSearch.Text;
                cmd.Parameters.Add("@Name", SqlDbType.VarChar).Value = txtNameSearch.Text;
                cmd.Parameters.Add("@Surname", SqlDbType.VarChar).Value = txtSurnameSearch.Text;
                cmd.Parameters.Add("@Keyword", SqlDbType.VarChar).Value = txtKeywordSearch.Text;
                cmd.Parameters.Add("@Filter", SqlDbType.VarChar).Value = ddlFilter.SelectedItem.Text;
                cmd.Parameters.Add("@@ID", SqlDbType.VarChar).Value = selectedValue;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(sp_SearchAdvPerson);
                }
            }
        }

        ASPxGridView1.cxGridSetup(sp_SearchAdvPerson);
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