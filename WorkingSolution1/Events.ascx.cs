using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Carab.BusinessObjects.Layers;
using CarabCore;
using CarabiXbase;
using CarabiXbase._Object;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxEditors;

public partial class Events : System.Web.UI.UserControl
{
    private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (DAL.Key.DbData == null)
            DAL.Setup(null, new OleDbConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString), loadTableSchemas: true);

        GridDiv.Visible = false;

        if (Request.QueryString["un"].ToLower() == "guest")
        {
            OpenEditButton.Visible = false;
            editLabel.Visible = false;
        }

        string name = Request.QueryString["un"];
        string table = (string)(Session[name + "TableName"]);
        if (DAL.Key.DbData.DataSet.Get.Tables.Contains(table))
        {
            EventGrid.DataSource = DAL.Key.DbData.DataTable.Get(table);
            EventGrid.DataBind();
            EventGrid.KeyFieldName = "IDEvent";
            GridDiv.Visible = true;
            EventGrid.Columns[0].Visible = false;
        }

        if (ddlFilter.SelectedValue == "0")
        {
            SearchFilter.Visible = false;
            ddlSelection.Visible = false;
            GridDiv.Visible = false;
        }
        if (!IsPostBack)
        {
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

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        FilterEvents();
    }

    private void FilterEvents()
    {
        int? selectedValue;
        int? showAll;

        if (xStatic_Object.AsInt(ddlSelection.SelectedValue) == 0)
        {
            selectedValue = null;
        }
        else
        {
            selectedValue = xStatic_Object.AsInt(ddlSelection.SelectedValue);
        }

        if (ddlCompleted.SelectedValue == "all")
        {
            showAll = null;
        }
        else
        {
            showAll = xStatic_Object.AsInt(ddlCompleted.SelectedValue);
        }
        string tmpTableName = "FilterEventsSp" + ddlFilter.SelectedItem.Text + selectedValue + showAll;
        DAL.Key.DbData.DataTable.Get_FromSP("FilterEventsSp", tmpTableName,
            cmdParameters: new object[] {ddlFilter.SelectedItem.Text, selectedValue, showAll});
        EventGrid.DataSource = DAL.Key.DbData.DataTable.Get(tmpTableName);
        EventGrid.DataBind();
        EventGrid.KeyFieldName = "IDEvent";
        EventGrid.Columns[0].Visible = false;
        GridDiv.Visible = true;

        if (EventGrid.VisibleRowCount > 0 && Request.QueryString["un"].ToLower() != "guest")
        {
            OpenEditButton.Visible = true;
            editLabel.Visible = true;
        }
        else
        {
            OpenEditButton.Visible = false;
            editLabel.Visible = false;
        }
        string name = Request.QueryString["un"];
        Session[name + "TableName"] = tmpTableName;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        int? selectedValue;
        int? showAll;

        if (xStatic_Object.AsInt(ddlSelection.SelectedValue) == 0)
        {
            selectedValue = null;
        }
        else
        {
            selectedValue = xStatic_Object.AsInt(ddlSelection.SelectedValue);
        }

        if (ddlCompleted.SelectedValue == "all")
        {
            showAll = null;
        }
        else
        {
            showAll = xStatic_Object.AsInt(ddlCompleted.SelectedValue);
        }

        string tmpTableName = "SearchEventTable" + TxtSearch.Text + ddlFilter.SelectedItem.Text + selectedValue + showAll;
        DAL.Key.DbData.DataTable.Get_FromSP("SearchEventSp", tmpTableName, cmdParameters: new object[] { TxtSearch.Text, ddlFilter.SelectedItem.Text, selectedValue, showAll });
        EventGrid.DataSource = DAL.Key.DbData.DataTable.Get(tmpTableName);
        EventGrid.DataBind();
        EventGrid.KeyFieldName = "IDEvent";
        EventGrid.Columns[0].Visible = false;
        GridDiv.Visible = true;

        if (EventGrid.VisibleRowCount > 0 && Request.QueryString["un"].ToLower() != "guest")
        {
            OpenEditButton.Visible = true;
            editLabel.Visible = true;
        }
        else
        {
            OpenEditButton.Visible = false;
            editLabel.Visible = false;
        }

        TxtSearch.Text = "";

        string name = Request.QueryString["un"];
        Session[name + "TableName"] = tmpTableName;
    }

    protected void InitialiseEditPopup(object sender, EventArgs e)
    {
        DataRow currentRow = EventGrid.GetDataRow(EventGrid.FocusedRowIndex);

            completedCB.Checked = currentRow[3].AsBool();

        eventPopup.ScrollBars = ScrollBars.None;
        eventPopup.Width = 1;
        eventPopup.Height = 1;

        eventPopup.PopupVerticalAlign = PopupVerticalAlign.WindowCenter;

        EditButton.Text = "Cancel Editing";

        GridDiv.Visible = true;
        EditButton.Text = "Edit Event";
        EditFieldDiv.Visible = false;
    }

    protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlFilter.SelectedValue == "Site")
        {
            var tmp = DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp");
            SearchFilter.Visible = true;
            ddlSelection.Visible = true;
            SetComboBox("FilterSiteSp");

        }
        else if (ddlFilter.SelectedValue == "Industry")
        {

            var tmp = DAL.Key.DbData.DataTable.Get_FromSP("FilterIndustrySp", "FilterIndustrySp");
            SearchFilter.Visible = true;
            ddlSelection.Visible = true;
            SetComboBox("FilterIndustrySp");
        }
        else if (ddlFilter.SelectedValue == "Department")
        {

            var tmp = DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp");
            SearchFilter.Visible = true;
            ddlSelection.Visible = true;
            SetComboBox("FilterDepartmentSp");
        }
        else if (ddlFilter.SelectedValue == "Company")
        {

            var tmp = DAL.Key.DbData.DataTable.Get_FromSP("FilterCompanySp", "FilterCompanySp");
            SearchFilter.Visible = true;
            ddlSelection.Visible = true;
            SetComboBox("FilterCompanySp");

        }
        else
        {
            ddlFilter.SelectedValue = "0";
            SearchFilter.Visible = false;
            ddlSelection.Visible = false;
        }

        SearchFilter.Text = "Select a " + ddlFilter.Text + ": ";
    }
    
    private void SetComboBox(string tableName)
    {
        ddlSelection.DataSource = DAL.Key.DbData.DataTable.Get(tableName);
        ddlSelection.DataTextField = DAL.Key.DbData.DataTable.Get(tableName).Columns[1].ToString();
        ddlSelection.DataValueField = DAL.Key.DbData.DataTable.Get(tableName).Columns[0].ToString();
        ddlSelection.DataBind();
    }

    protected void editEvent_Click(object sender, EventArgs e)
    {
        DataRow currentRow = EventGrid.GetDataRow(EventGrid.FocusedRowIndex);

        GridDiv.Visible = true;

        string eventID = currentRow[0].ToString();

        if (EditFieldDiv.Visible)
        {
            EditFieldDiv.Visible = false;
            EditButton.Text = "Edit Event";

            eventPopup.ScrollBars = ScrollBars.None;
            eventPopup.Width = 1;
            eventPopup.Height = 1;

            eventPopup.PopupVerticalAlign = PopupVerticalAlign.WindowCenter;
        }
        else
        {
            EditFieldDiv.Visible = true;
            EditButton.Text = "Cancel Editing";

            eventPopup.ScrollBars = ScrollBars.Vertical;
            eventPopup.Width = 463;
            eventPopup.Height = 600;

            eventPopup.PopupVerticalAlign = PopupVerticalAlign.WindowCenter;
        }

        if (EditFieldDiv.Visible)
        {
            //Default Values
            txtEvent.Text = currentRow["Heading"].ToString();
            txtValue.Text = currentRow["Offer Value"].ToString();
            txtClient.Text = currentRow["Client"].ToString();
            txtComment.Text = currentRow["Comment"].ToString();

            DataTable tempDT = DAL.Key.DbData.DataTable.Get_FromSP("FilterIDsSp", "TempIDs", cmdParameters: new object[] {eventID});
            
            DAL.Key.DbData.DataTable.Get_FromSP("FilterIndustrySp", "FilterIndustrySp");
            ddlIndustry.DataSource = DAL.Key.DbData.DataTable.Get("FilterIndustrySp");
            ddlIndustry.DataTextField = DAL.Key.DbData.DataTable.Get("FilterIndustrySp").Columns[1].ToString();
            ddlIndustry.DataValueField = DAL.Key.DbData.DataTable.Get("FilterIndustrySp").Columns[0].ToString();
            ddlIndustry.DataBind();

            ddlIndustry.SelectedValue = tempDT.Rows[0][0].ToString();

            DAL.Key.DbData.DataTable.Get_FromSP("sp_LoadEventCompany", "sp_LoadEventCompany", false, "", new object[] { ddlIndustry.SelectedValue });
            ddlCompany.DataSource = DAL.Key.DbData.DataTable.Get("sp_LoadEventCompany");
            ddlCompany.DataTextField = DAL.Key.DbData.DataTable.Get("sp_LoadEventCompany").Columns[1].ToString();
            ddlCompany.DataValueField = DAL.Key.DbData.DataTable.Get("sp_LoadEventCompany").Columns[0].ToString();
            ddlCompany.DataBind();

            ddlCompany.SelectedValue = tempDT.Rows[0][1].ToString();

            DAL.Key.DbData.DataTable.Get_FromSP("FilterProductsSp", "FilterProductsSp", cmdParameters: new object[] { ddlCompany.SelectedValue });
            ddlProduct.DataSource = DAL.Key.DbData.DataTable.Get("FilterProductsSp");
            ddlProduct.DataTextField = DAL.Key.DbData.DataTable.Get("FilterProductsSp").Columns[1].ToString();
            ddlProduct.DataValueField = DAL.Key.DbData.DataTable.Get("FilterProductsSp").Columns[0].ToString();
            ddlProduct.DataBind();

            txtValue.Text = DAL.Key.DbData.DataTable.Get("FilterProductsSp").Rows[0][3].ToString();
            txtValue.ReadOnly = true;

            DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", cmdParameters: new object[] { ddlCompany.SelectedValue });
            ddlSite.DataSource = DAL.Key.DbData.DataTable.Get("FilterSiteSp");
            ddlSite.DataTextField = DAL.Key.DbData.DataTable.Get("FilterSiteSp").Columns[1].ToString();
            ddlSite.DataValueField = DAL.Key.DbData.DataTable.Get("FilterSiteSp").Columns[0].ToString();
            ddlSite.DataBind();

            ddlSite.SelectedValue = tempDT.Rows[0][2].ToString();
                
            DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp", cmdParameters: new object[] { ddlSite.SelectedValue });
            ddlDepartment.DataSource = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp");
            ddlDepartment.DataTextField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[1].ToString();
            ddlDepartment.DataValueField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[0].ToString();
            ddlDepartment.DataBind();

            ddlDepartment.SelectedValue = tempDT.Rows[0][3].ToString();

        }

    }

    protected void Done_Click(object sender, EventArgs e)
    {
        DataRow currentRow = EventGrid.GetDataRow(EventGrid.FocusedRowIndex);
        
        string eventID = currentRow[0].ToString();

        int done = 0;
        if (completedCB.Checked)
        {
            done = 1;
        }

        if (EditFieldDiv.Visible)
        {
            DAL.Key.DbData.DataTable.Get_FromSP("sp_UpdateEvent", "Temp", cmdParameters: new object[] {eventID, ddlIndustry.SelectedValue, ddlCompany.SelectedValue, 
                ddlSite.SelectedValue, ddlDepartment.SelectedValue, txtEvent.Text, ddlProduct.SelectedValue, txtValue.Text, txtClient.Text, txtComment.Text, done });

            if(rdbPerson.Checked)
            {
                DAL.Key.DbData.DataTable.Get_FromSP("sp_UpdateEventPerson", "Temp",
                                                    cmdParameters: new object[] {eventID, ScreenName.Text});
            }
        }
        else
        {
            DataRow drTemp;
            DAL.Key.DbData.DataTable.Get("Events").cxFindRow("IDEvent = " + eventID, out drTemp);
            drTemp.cxValue_Set("Complete", done);
            drTemp.cxValue_Set("Status", "Complete");
            DAL.Key.DbData.DataTable.Update("Events",true);
        }

        FilterEvents();
        GridDiv.Visible = true;

        eventPopup.ShowOnPageLoad = false;
    }

    protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
    {
        int? param;

        if (ddlCompany.SelectedValue == "") param = null;
        else param = ddlCompany.SelectedValue.AsInt();

        DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", false, "", new object[] { param });
        ddlSite.DataSource = DAL.Key.DbData.DataTable.Get("FilterSiteSp");
        ddlSite.DataTextField = DAL.Key.DbData.DataTable.Get("FilterSiteSp").Columns[1].ToString();
        ddlSite.DataValueField = DAL.Key.DbData.DataTable.Get("FilterSiteSp").Columns[0].ToString();
        ddlSite.DataBind();

        DataTable temp = DAL.Key.DbData.DataTable.Get_FromSP("FilterProductsSp", "FilterProductsSp", cmdParameters: new object[] { param });
        ddlProduct.DataSource = DAL.Key.DbData.DataTable.Get("FilterProductsSp");
        ddlProduct.DataTextField = DAL.Key.DbData.DataTable.Get("FilterProductsSp").Columns[1].ToString();
        ddlProduct.DataValueField = DAL.Key.DbData.DataTable.Get("FilterProductsSp").Columns[0].ToString();
        ddlProduct.DataBind();

        if (temp.Rows.Count > 0)
        {
            txtValue.Text = DAL.Key.DbData.DataTable.Get("FilterProductsSp").Rows[0][3].ToString();
        }
        else
        {
            txtValue.Text = "0.00";
        }
        txtValue.ReadOnly = true;
        
        if (ddlSite.SelectedValue == "") param = null;
        else param = ddlSite.SelectedValue.AsInt();

        DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp", false, "", new object[] { param });
        ddlDepartment.DataSource = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp");
        ddlDepartment.DataTextField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[1].ToString();
        ddlDepartment.DataValueField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[0].ToString();
        ddlDepartment.DataBind();

    }

    protected void ddlIndustry_SelectedIndexChanged(object sender, EventArgs e)
    {
        int? param;
        
		DAL.Key.DbData.DataTable.Get_FromSP("sp_LoadEventCompany", "sp_LoadEventCompany", false, "", new object[] { ddlIndustry.SelectedValue });
        ddlCompany.DataSource = DAL.Key.DbData.DataTable.Get("sp_LoadEventCompany");
        ddlCompany.DataTextField = DAL.Key.DbData.DataTable.Get("sp_LoadEventCompany").Columns[1].ToString();
        ddlCompany.DataValueField = DAL.Key.DbData.DataTable.Get("sp_LoadEventCompany").Columns[0].ToString();
        ddlCompany.DataBind();

        if (ddlCompany.SelectedValue == "") param = null;
        else param = ddlCompany.SelectedValue.AsInt();

        DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", cmdParameters: new object[] { param });
        ddlSite.DataSource = DAL.Key.DbData.DataTable.Get("FilterSiteSp");
        ddlSite.DataTextField = DAL.Key.DbData.DataTable.Get("FilterSiteSp").Columns[1].ToString();
        ddlSite.DataValueField = DAL.Key.DbData.DataTable.Get("FilterSiteSp").Columns[0].ToString();
        ddlSite.DataBind();

        DataTable temp = DAL.Key.DbData.DataTable.Get_FromSP("FilterProductsSp", "FilterProductsSp", cmdParameters: new object[] { param });
        ddlProduct.DataSource = DAL.Key.DbData.DataTable.Get("FilterProductsSp");
        ddlProduct.DataTextField = DAL.Key.DbData.DataTable.Get("FilterProductsSp").Columns[1].ToString();
        ddlProduct.DataValueField = DAL.Key.DbData.DataTable.Get("FilterProductsSp").Columns[0].ToString();
        ddlProduct.DataBind();

	    if (temp.Rows.Count > 0)
	    {
	        txtValue.Text = DAL.Key.DbData.DataTable.Get("FilterProductsSp").Rows[0][3].ToString();
	    }
	    else
	    {
	        txtValue.Text = "0.00";
	    }
        txtValue.ReadOnly = true;

        if (ddlSite.SelectedValue == "") param = null;
        else param = ddlSite.SelectedValue.AsInt();

        DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp", cmdParameters: new object[] { param });
        ddlDepartment.DataSource = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp");
        ddlDepartment.DataTextField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[1].ToString();
        ddlDepartment.DataValueField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[0].ToString();
        ddlDepartment.DataBind();
    }

    protected void ddlSite_SelectedIndexChanged(object sender, EventArgs e)
    {
        DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp", cmdParameters: new object[] { ddlSite.SelectedValue });
        ddlDepartment.DataSource = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp");
        ddlDepartment.DataTextField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[1].ToString();
        ddlDepartment.DataValueField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[0].ToString();
        ddlDepartment.DataBind();

    }

   

    protected void rdbPerson_CheckedChanged(object sender, EventArgs e)
    {
        lblPerson.Visible = true;
        ScreenName.Visible = true;
        rdbNone.Checked = false;
    }

    protected void tdbNone_CheckedChanged(object sender, EventArgs e)
    {
        lblPerson.Visible = false;
        ScreenName.Visible = false;
        rdbPerson.Checked = false;
    }

    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        DAL.Key.DbData.DataTable.Get_FromSP("sp_Price", "sp_Price", cmdParameters: new object[] { ddlProduct.SelectedValue });
        txtValue.Text = DAL.Key.DbData.DataTable.Get("sp_Price").Rows[0][0].ToString();
        txtValue.ReadOnly = true;

    }

    protected void ScreenName_Select(object sender, EventArgs e)
    {
        
    }
}