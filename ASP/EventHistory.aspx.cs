using System;
using System.Activities.Expressions;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DevExpress.Utils.Win;

public partial class EventHistory : System.Web.UI.Page
{
    private DAL_ DAL = DAL_.Instance;

    struct ehInformation // Information of the session (used to determine certain information)
    {
        public int[] ColumnVal;  //CompayID, SiteID, DepartmentID, PersonID
        public string[] ColumnName; // Optional;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (DAL.Key.DbData == null)
            DAL.Setup(null, new OleDbConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString), loadTableSchemas: true);

        if (!IsPostBack)
        {
            // Assign temporary values for testing purposes
            //var TempAssign = new ehInformation();
            //TempAssign.ColumnName = new[] {"FKCompany", "FKSite", "FKDepartment"};
            //TempAssign.ColumnVal = new[] {1,1,1};
            string name = Request.QueryString["un"];
            if (Session[name + "EventHistory"] == null) lbxCompany_Change(this, null);
            populateGrid();
        }
    }

    private void populateGrid()
    {
        string name = Request.QueryString["un"];
        if (Session[name + "EventHistory"] != null)
        {
            lbxCompany.Enabled = false;
            lbxSite.Enabled = false;
            lbxDepartment.Enabled = false;
            lbxPerson.Enabled = false;
            btnActiveSearches.Visible = true;
            if (((ehInformation)Session[name + "EventHistory"]).ColumnVal[0] != 0)
            {
                DataRow drTemp;
                DAL.Key.DbData.DataTable.Get("contactCompany")
                    .cxFindRow("IDCompany = " + ((ehInformation)Session[name + "EventHistory"]).ColumnVal[0].ToString(),
                        out drTemp);
                if (lbxCompany.SelectedIndex == -1)
                {
                    lbxCompany.NullText = drTemp.cxValue_Get("Company").ToString();
                }
            }
            if (((ehInformation)Session[name + "EventHistory"]).ColumnVal[1] != 0)
            {
                DataRow drTemp;
                DAL.Key.DbData.DataTable.Get("contactSite")
                    .cxFindRow("IDSite = " + ((ehInformation)Session[name + "EventHistory"]).ColumnVal[1].ToString(),
                        out drTemp);
                if (lbxSite.SelectedIndex == -1)
                {
                    lbxSite.NullText = drTemp.cxValue_Get("Site").ToString();
                    
                }
                //lbxCompany.SelectedItem.Text = drTemp.cxValue_Get("Site").ToString();
            }

            if (((ehInformation)Session[name + "EventHistory"]).ColumnVal[2] != 0)
            {
                DataRow drTemp;
                DAL.Key.DbData.DataTable.Get("contactDepartment")
                    .cxFindRow(
                        "IDDepartment = " + ((ehInformation)Session[name + "EventHistory"]).ColumnVal[2].ToString(),
                        out drTemp);

                if (lbxDepartment.SelectedIndex == -1)
                {
                    lbxDepartment.NullText = drTemp.cxValue_Get("Department").ToString();
                    lbxDepartment.SelectedIndex = -1;
                }
                //lbxCompany.SelectedItem.Text = drTemp.cxValue_Get("Department").ToString();
            }
        }
        else // No Session (session is null);
        {
            //
            // Person
            lbxPerson.DataSource = DAL.Key.DbData.DataTable.Get("contactPerson");
            lbxPerson.TextField = DAL.Key.DbData.DataTable.Get("contactPerson").Columns["ScreenName"].ToString();
            lbxPerson.ValueField = DAL.Key.DbData.DataTable.Get("contactPerson").Columns[0].ToString();
            lbxPerson.DataBind();

            var lbxParamVal = new ehInformation();
            lbxParamVal.ColumnName = new[] {"FKCompany", "FKSite", "FKDepartment", "IDPerson"};
            lbxParamVal.ColumnVal = new int[4];
            if (lbxCompany.SelectedIndex != -1) lbxParamVal.ColumnVal[0] = lbxCompany.SelectedItem.Value.AsInt();
            if (lbxSite.SelectedIndex != -1) lbxParamVal.ColumnVal[1] = lbxSite.SelectedItem.Value.AsInt();
            if (lbxDepartment.SelectedIndex != -1) lbxParamVal.ColumnVal[2] = lbxDepartment.SelectedItem.Value.AsInt();
            if (lbxPerson.SelectedIndex != -1) lbxParamVal.ColumnVal[3] = lbxPerson.SelectedItem.Value.AsInt();

            DataTable dtEventHistory = null;
            var counter = 0;
            dtEventHistory = dtEventHistory = DAL.Key.DbData.DataTable.Get_FromSP("FilterEHistory",
                    cmdParameters:
                        new object[] { DBNull.Value, DBNull.Value });
            foreach (var numberID in lbxParamVal.ColumnVal)
            {
                if (numberID <= 0)
                {
                    counter++;
                    continue;
                }
                dtEventHistory = DAL.Key.DbData.DataTable.Get_FromSP("FilterEHistory",
                    cmdParameters:
                        new object[] {numberID, lbxParamVal.ColumnName[counter]});
                counter++;
            }
            if (dtEventHistory != null)
            {
                grdDataFilter.thisGridsData.theDataTable = dtEventHistory;
                grdDataFilter.thisGridsData.ColumnNames = new[]
                {
                    "IDEvent", "FKIndustry", "FKCompany", "FKSite", "FKDepartment", "FKProduct", "Followup_Date",
                    "FKPerson_Review", "Review", "ReviewComment"
                };
                grdDataFilter.thisGridsData.ColumnNumbers = new[] {0, 1};
                grdDataFilter.Visible = true;
            }
        }
    }

    protected void lbxCompany_Change(object sender, EventArgs e)
    {
        // Company
        lbxCompany.DataSource = DAL.Key.DbData.DataTable.Get("contactCompany");
        lbxCompany.TextField = DAL.Key.DbData.DataTable.Get("contactCompany").Columns["Company"].ToString();
        lbxCompany.ValueField = DAL.Key.DbData.DataTable.Get("contactCompany").Columns[0].ToString();
        lbxCompany.DataBind();
        if (lbxCompany.SelectedIndex != -1)
        {
            lbxSite.SelectedIndex = -1;
            lbxDepartment.SelectedIndex = -1;
        }

        if (lbxCompany.SelectedIndex >= 0) btnClear.Enabled = true;
        lbxSite_Change(this, e);
    }

    protected void lbxSite_Change(object sender, EventArgs e)
    {
        // Site
        //lbxSite.DataSource = DAL.Key.DbData.DataTable.Get("contactSite");
        //lbxSite.TextField = DAL.Key.DbData.DataTable.Get("contactSite").Columns["Site"].ToString();
        //lbxSite.ValueField = DAL.Key.DbData.DataTable.Get("contactSite").Columns[0].ToString();
        if (lbxCompany.SelectedIndex != -1) DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", cmdParameters: new object[] { lbxCompany.SelectedItem.Value });
        else DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", cmdParameters: new object[] { DBNull.Value });
        {
            lbxSite.DataSource = DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp");
            lbxSite.TextField = DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp").Columns[1].ToString();
            lbxSite.ValueField = DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp").Columns[0].ToString();
            lbxSite.DataBind();
        }
        if (lbxSite.SelectedIndex != -1)
        {
            lbxDepartment.SelectedIndex = -1;
        }
        //lbxCompany.DataBind();
        if (lbxSite.SelectedIndex >= 0) btnClear.Enabled = true;
        lbxDepartment_Change(this, e);
    }

    protected void lbxDepartment_Change(object sender, EventArgs e)
    {
        // Department
        //lbxDepartment.DataSource = DAL.Key.DbData.DataTable.Get("contactDepartment");
        //lbxDepartment.TextField = DAL.Key.DbData.DataTable.Get("contactDepartment").Columns["Department"].ToString();
        //lbxDepartment.ValueField = DAL.Key.DbData.DataTable.Get("contactDepartment").Columns[0].ToString();
        //lbxDepartment.DataBind();

        if (lbxSite.SelectedIndex != -1)DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", cmdParameters: new object[] { lbxSite.SelectedItem.Value });
        else DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", cmdParameters: new object[] { DBNull.Value });
        {
            lbxDepartment.DataSource = DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp");
            lbxDepartment.TextField = DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp").Columns[1].ToString();
            lbxDepartment.ValueField = DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp").Columns[0].ToString();
            lbxDepartment.DataBind();
        }
        if (lbxDepartment.SelectedIndex >= 0) btnClear.Enabled = true;
        populateGrid();
    }
    protected void btnActiveSearches_Click(object sender, EventArgs e)
    {
        btnActiveSearches.Visible = false;
        lbxCompany.Enabled = true;
        lbxSite.Enabled = true;
        lbxDepartment.Enabled = true;
        lbxPerson.Enabled = true;
        string name = Request.QueryString["un"];
        Session[name + "EventHistory"] = null;
        lbxCompany_Change(this,e);

    }

    protected void RefreshComboBoxes(object sender, EventArgs e)
    {
        lbxCompany.SelectedIndex = -1;
        lbxSite.SelectedIndex = -1;
        lbxDepartment.SelectedIndex = -1;
        lbxPerson.SelectedIndex = -1;
        lbxCompany_Change(sender, e);
        lbxSite_Change(sender, e);
        lbxDepartment_Change(sender, e);
        lbxPerson_Change(sender, e);
        btnClear.Enabled = false;
    }

    protected void lbxPerson_Change(object sender, EventArgs e)
    {
        if (lbxPerson.SelectedIndex >= 0) btnClear.Enabled = true;
        populateGrid();
    }
}