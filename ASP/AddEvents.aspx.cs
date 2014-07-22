using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxEditors;

public partial class AddEvents : System.Web.UI.Page
{
    private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        errorhandling.Visible = false;
        Success.Visible = false;
        if (!IsPostBack)
        {
           
            ddlIndustry.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterIndustrySp", "FilterIndustrySp", true), "IDIndustry", "Industry");
            ddlCompany.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("sp_LoadEventCompany", "sp_LoadEventCompany", true, "", new object[] { ddlIndustry.SelectedValue }), "IDCompany", "Company");

            if (ddlCompany.Items.Count != 0)
            {
               
                ddlSite.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", true, "", new object[] { ddlCompany.SelectedValue }), "IDSite", "Site");
            }
            else
            {
                ddlCompany.Items.Add("No Company Available");
                ddlSite.Items.Clear();
                ddlSite.Items.Add("No Sites Available");
            }

            if (ddlCompany.Text != "No Company Available")
            {
                ddlProduct.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterProductsSp", "FilterProductsSp", true, "", new object[] { ddlCompany.SelectedValue }), "ProductID", "Product");
            }
            else
            {
                ddlProduct.Items.Clear();
                ddlProduct.Items.Add("No Products Available");
            }


            if (ddlSite.Text != "No Sites Available")
            {
                ddlDepartment.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp", true, "", new object[] { ddlSite.SelectedValue }), "IDDepartment", "Department");
            }
            else
            {
                ddlDepartment.Items.Clear();
                ddlDepartment.Items.Add("No Departments Available");
            }

            if (ddlProduct.Items.Count == 0)
            {
                ddlProduct.Items.Add("No Products Available");
            }

            if (ddlProduct.Text != "No Products Available")
            {
                txtValue.Text = DAL.Key.DbData.DataTable.Get("FilterProductsSp").Rows[0][3].ToString();
                txtValue.ReadOnly = true;
            }
            else
            {
                txtValue.Text = "";
            }

            if (DAL.Key.DbData.DataTable.Exists("FilterProductSp")) if (DAL.Key.DbData.DataTable.Get("FilterProductsSp").Rows.Count > 0) 
            {
                txtValue.Text = DAL.Key.DbData.DataTable.Get("FilterProductsSp").Rows[0][3].ToString();
                txtValue.ReadOnly = true;
            }
            ListBoxColumn clm1 = new ListBoxColumn("ScreenName", "Screen Name");
            ListBoxColumn clm2 = new ListBoxColumn("PersonName", "Name");
            ListBoxColumn clm3 = new ListBoxColumn("PersonSurname", "Surame");
            ScreenName.Columns.Add(clm1);
            ScreenName.Columns.Add(clm2);
            ScreenName.Columns.Add(clm3);
            

            lblPerson.Visible = false;
            ScreenName.Visible = false;

        }
        ScreenName.DataSource = DAL.Key.DbData.DataTable.Get("contactPerson");
        ScreenName.TextField = DAL.Key.DbData.DataTable.Get("contactPerson").Columns["ScreenName"].ToString();
        ScreenName.ValueField = DAL.Key.DbData.DataTable.Get("contactPerson").Columns[0].ToString();
        ScreenName.DataBind();


    }


    protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
    {
            ddlSite.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", true, "", new object[] { ddlCompany.SelectedValue }), "IDSite", "Site");
            ddlProduct.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterProductsSp", "FilterProductsSp", true, "", new object[] { ddlCompany.SelectedValue }), "ProductID", "Product");
           
        
        if (ddlSite.Items.Count != 0)
        {
           ddlDepartment.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp", true, "", new object[] { ddlSite.SelectedValue }), "IDDepartment", "Department");
            
        }
        else
        {
            ddlDepartment.Items.Clear();
            ddlDepartment.Items.Add("No Departments Available");
            ddlSite.Items.Add("No Sites Available");
        }

        if (ddlProduct.Items.Count == 0)
        {
            ddlProduct.Items.Add("No Products Available");
        }

        if (ddlProduct.Text != "No Products Available")
        {
            txtValue.Text = DAL.Key.DbData.DataTable.Get("FilterProductsSp").Rows[0][3].ToString();
            txtValue.ReadOnly = true;
        }
        else
        {
            txtValue.Text = "";
        }
    }
    protected void ddlIndustry_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        ddlCompany.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("sp_LoadEventCompany", "sp_LoadEventCompany", true, "", new object[] { ddlIndustry.SelectedValue }), "IDCompany", "Company");
       
        if (ddlCompany.Items.Count != 0)
        {
           ddlSite.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", true, "", new object[] { ddlCompany.SelectedValue }), "IDSite", "Site");
        }
        else
        {   ddlCompany.Items.Add("No Company Available");
            ddlSite.Items.Clear();
            ddlSite.Items.Add("No Sites Available");
        }

        if (ddlCompany.Text != "No Company Available")
        {
       
             ddlProduct.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterProductsSp", "FilterProductsSp", true, "", new object[] { ddlCompany.SelectedValue }), "ProductID", "Product");
         }
        else
        {
            ddlProduct.Items.Clear();
            ddlProduct.Items.Add("No Products Available");
        }


        if (ddlSite.Text != "No Sites Available")
        {
          if (ddlSite.SelectedValue != "")
          {
              ddlDepartment.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp", true, "", new object[] {ddlSite.SelectedValue}), "IDDepartment", "Department");
          }
          else
          {
              ddlSite.Items.Clear();
              ddlSite.Items.Add("No Sites Available");
              ddlDepartment.Items.Clear();
              ddlDepartment.Items.Add("No Departments Available");
          }
        }
        else
        {
            ddlDepartment.Items.Clear();
            ddlDepartment.Items.Add("No Departments Available");
        }

        if( ddlProduct.Items.Count == 0)
        {
            ddlProduct.Items.Add("No Products Available");
        }

        if (ddlProduct.Text != "No Products Available")
        {
            txtValue.Text = DAL.Key.DbData.DataTable.Get("FilterProductsSp").Rows[0][3].ToString();
            txtValue.ReadOnly = true;
        }
        else
        {
            txtValue.Text = "";
        }
    }
    protected void ddlSite_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        ddlDepartment.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp", true, "", new object[] { ddlSite.SelectedValue }), "IDDepartment", "Department");

        if (ddlDepartment.Items.Count == 0)
        {
            ddlDepartment.Items.Add("No Departments Available");
        }

    }
    protected void rdbDepatment_CheckedChanged(object sender, EventArgs e)
    {
      
            lblPerson.Visible = false;
            ScreenName.Visible = false;
            rdbPerson.Checked = false;

    }
    protected void rdbPerson_CheckedChanged(object sender, EventArgs e)
    {
      
            lblPerson.Visible = true;
            ScreenName.Visible = true;
            rdbDepatment.Checked = false;
      
    }
    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        DAL.Key.DbData.DataTable.Get_FromSP("sp_Price", "sp_Price", cmdParameters: new object[] { ddlProduct.SelectedValue });
        txtValue.Text = DAL.Key.DbData.DataTable.Get("sp_Price").Rows[0][0].ToString();
        txtValue.ReadOnly = true;
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (ddlDepartment.Text != "No Departments Available" && ddlProduct.Text != "No Products Available" && txtEvent.Text != "" && (rdbPerson.Checked != false || rdbDepatment.Checked != false))
        {
            if (rdbPerson.Checked)
            {
                if(ScreenName.Text== "")
                {
                    errorhandling.Visible = true;
                    errorhandling.Text =
                        "Please ensure that you have selected a user to assign the event!!";
                    return;
                }
            }
            DAL.Key.DbData.DataTable.Get_FromSP("sp_AddEvent", "sp_AddEvent", false, "",
                                                new object[]
                                                    {
                                                        ddlIndustry.SelectedValue, ddlCompany.SelectedValue,
                                                        ddlSite.SelectedValue, ddlDepartment.SelectedValue, txtEvent.Text,
                                                        ddlProduct.SelectedValue, txtValue.Text, txtClient.Text,
                                                        txtComment.Text
                                                    });

            if (rdbPerson.Checked == true)
            {
                DAL.Key.DbData.SP_Execute("sp_AddEventPerson",
                                          new object[]
                                              {
                                                  DAL.Key.DbData.DataTable.Get_FromSP("sp_TrackNO","sp_TrackNO").Rows[0][0].ToString(),
                                                  ScreenName.Text
                                              });

            }

            Success.Visible = true;
            Success.Text = "Your Event was created successfully! The Tracking No. is :" +
                           DAL.Key.DbData.DataTable.Get("sp_TrackNO").Rows[0][1].ToString();

            rdbDepatment.Checked = false;
            rdbPerson.Checked = false;
            txtEvent.Text = "";
            txtClient.Text = "";
            ScreenName.Visible = false;
            lblPerson.Visible = false;
            txtComment.Text = "";
        }
        else
        {
            errorhandling.Visible = true;
            errorhandling.Text =
                "Please ensure you have selected a department, assignment option, a Product and have given the event a name.";
        }

    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        rdbDepatment.Checked = false;
        rdbPerson.Checked = false;
        txtEvent.Text = "";
        txtClient.Text = "";
        ScreenName.Visible = false;
        errorhandling.Visible = false;
        Success.Visible = false;
        lblPerson.Visible = false;
        txtComment.Text = "";
    }
}