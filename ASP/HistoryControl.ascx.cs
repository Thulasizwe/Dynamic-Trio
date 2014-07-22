using System;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DevExpress.Web.ASPxEditors;

public partial class HistoryControl : System.Web.UI.UserControl
{
    private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        string name = Request.QueryString["un"];
        string tmpTableName = (string)(Session[name + "HistoryLoaded"]);

        if (tmpTableName != null && DAL.Key.DbData.DataTable.Exists(tmpTableName))
        {
            DataTable table = DAL.Key.DbData.DataTable.Get(tmpTableName);
            ASPxGV_History.DataSource = table;
        }
        if (DAL.Key.DbData == null)
            DAL.Setup(null, new OleDbConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString), loadTableSchemas: true);

        if (!IsPostBack)
        {

            ListBoxColumn clm1 = new ListBoxColumn("ScreenName", "Screen Name");
            ListBoxColumn clm2 = new ListBoxColumn("PersonName", "Name");
            ListBoxColumn clm3 = new ListBoxColumn("PersonSurname", "Surame");
            cbxUser.Columns.Add(clm1);
            cbxUser.Columns.Add(clm2);
            cbxUser.Columns.Add(clm3);
        }
        cbxUser.DataSource = DAL.Key.DbData.DataTable.Get("contactPerson");
        cbxUser.TextField = DAL.Key.DbData.DataTable.Get("contactPerson").Columns["ScreenName"].ToString();
        cbxUser.ValueField = DAL.Key.DbData.DataTable.Get("contactPerson").Columns[0].ToString();
        cbxUser.DataBind();
    }

    protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (ddlFilter.SelectedIndex)
        {
            case 0:
            {
                divSpecUser.Visible = false;
                ASPxGV_History.Visible = false;
            }
                break;
            case 1:
            {
                divSpecUser.Visible = true;
                cbxUser.SelectedItem = null;
                ASPxGV_History.Visible = false;
                //DAL.Key.DbData.DataTable.Get_FromSP("FilterPersonAliasesSp", "FilterPersonAliasesSp");
                //cbxUser.DataSource = DAL.Key.DbData.DataTable.Get("FilterPersonAliasesSp");
                //cbxUser.TextField = DAL.Key.DbData.DataTable.Get("FilterPersonAliasesSp").Columns["Names"].ToString();
                //cbxUser.ValueField = DAL.Key.DbData.DataTable.Get("FilterPersonAliasesSp").Columns["ScreenName"].ToString();
                //cbxUser.DataBind();

                cbxUser.DataSource = DAL.Key.DbData.DataTable.Get("contactPerson");
                cbxUser.TextField = DAL.Key.DbData.DataTable.Get("contactPerson").Columns["ScreenName"].ToString();
                cbxUser.ValueField = DAL.Key.DbData.DataTable.Get("contactPerson").Columns[0].ToString();
                
            }
            break;
            case 2:
            {
                string name = Request.QueryString["un"];
                ASPxGV_History.Visible = true;
                divSpecUser.Visible = false;
                string tmpTableName = "FilterAllHistorySP";
                DataTable dtAllHist = DAL.Key.DbData.DataTable.Get_FromSP("FilterAllHistorySp", tmpTableName);
                ASPxGV_History.DataSource = dtAllHist;
                Session[name + "HistoryLoaded"] = tmpTableName;
                ASPxGV_History.DataBind();
                ASPxGV_History.Visible = true;
            }

            break;
        }
    }

    protected void cbxUser_Select(object sender, EventArgs e)
    {
        var selUser = cbxUser.Text;
        string tmpTableName = "FilterPHistorySp" + selUser;
        DataTable dtUser = DAL.Key.DbData.DataTable.Get_FromSP("FilterPHistorySp", "FilterPHistorySp", cmdParameters: new object[] {selUser});
        ASPxGV_History.DataSource = dtUser;
        string name = Request.QueryString["un"];
        Session[name + "HistoryLoaded"] = tmpTableName;
        ASPxGV_History.DataBind();
        ASPxGV_History.Visible = true;
    }
}