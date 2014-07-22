using System;
using System.Collections.Generic;
using System.Data;
using System.EnterpriseServices.CompensatingResourceManager;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DevExpress.Web.ASPxEditors;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.ASPxRatingControl;
using DevExpress.XtraRichEdit.Model.History;

public partial class Products : System.Web.UI.UserControl
{
    private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["un"].ToLower() == "guest")
        {
            OpenRateButton.Visible = false;
            OtherButton.Visible = false;
            rateLabel.Visible = false;
        }

        GridDiv.Visible = false;
        string name = Request.QueryString["un"];
        string table = (string)(Session[name + "TableName"]);
        if (DAL.Key.DbData.DataSet.Get.Tables.Contains(table))
        {
            ProductGrid.DataSource = DAL.Key.DbData.DataTable.Get(table);
            ProductGrid.DataBind();
            ProductGrid.KeyFieldName = "ProductID";
            GridDiv.Visible = true;
            ProductGrid.Columns[0].Visible = false;
        }

        if(!IsPostBack)
        {
            DAL.Key.DbData.DataTable.Get_FromSP("FilterCompanySp", "FilterCompanySp");
            ddlSelection.DataSource = DAL.Key.DbData.DataTable.Get("FilterCompanySp");
            ddlSelection.DataTextField = DAL.Key.DbData.DataTable.Get("FilterCompanySp").Columns[1].ToString();
            ddlSelection.DataValueField = DAL.Key.DbData.DataTable.Get("FilterCompanySp").Columns[0].ToString();
            ddlSelection.DataBind();

            ListItem lst = new ListItem("All", "0");
            ddlSelection.Items.Insert(0,lst);
        }
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
        string tmpTableName = "FilterProductsSp" + selectedValue;
        DAL.Key.DbData.DataTable.Get_FromSP("FilterProductsSp", tmpTableName, cmdParameters: new object[] { selectedValue });
        ProductGrid.DataSource = DAL.Key.DbData.DataTable.Get(tmpTableName);
        ProductGrid.DataBind();
        ProductGrid.KeyFieldName = "ProductID";
        GridDiv.Visible = true;

        ProductGrid.SettingsBehavior.AllowSelectByRowClick = true;
        ProductGrid.SettingsBehavior.AllowSelectSingleRowOnly = true;
        ProductGrid.SettingsBehavior.AllowFocusedRow = true;

        ProductGrid.Selection.UnselectAll();
        ProductGrid.Columns[0].Visible = false;
        string name = Request.QueryString["un"];
        Session[name + "TableName"] = tmpTableName;

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
        string tmpTableName = "SearchProductsSp" + TxtSearch.Text + selectedValue;
        DAL.Key.DbData.DataTable.Get_FromSP("SearchProductsSp", tmpTableName, cmdParameters: new object[] { TxtSearch.Text, selectedValue });
        ProductGrid.DataSource = DAL.Key.DbData.DataTable.Get(tmpTableName);
        ProductGrid.DataBind();
        ProductGrid.KeyFieldName = "ProductID";
        GridDiv.Visible = true;
        ProductGrid.Columns[0].Visible = false;
        TxtSearch.Text = "";
        string name = Request.QueryString["un"];
        Session[name + "TableName"] = tmpTableName;

        ProductGrid.Selection.UnselectAll();
    }

    protected void RateProduct(object sender, EventArgs e)
    {
        DataRow currentRow = ProductGrid.GetDataRow(ProductGrid.FocusedRowIndex);

        int productID = currentRow[0].AsInt();
        string comments = Comments.Text;
        int rating = ProductRating.Value.AsInt();
        int? department;

        if (ddlDepartment.SelectedValue.AsInt() == 0)
        {
            department = null;
        }
        else
        {
            department = ddlDepartment.SelectedValue.AsInt();
        }

        DAL.Key.DbData.SP_Execute("RateProductSp", new object[] {productID, rating, comments, department});

        int? selectedValue;

        if (ddlSelection.SelectedValue.AsInt() == 0)
        {
            selectedValue = null;
        }
        else
        {
            selectedValue = ddlSelection.SelectedValue.AsInt();
        }
        string tmpTableName = "FilterProductsSp" + selectedValue;
        DAL.Key.DbData.DataTable.Get_FromSP("FilterProductsSp", tmpTableName, cmdParameters: new object[] { selectedValue });
        ProductGrid.DataSource = DAL.Key.DbData.DataTable.Get(tmpTableName);
        ProductGrid.DataBind();
        ProductGrid.KeyFieldName = "ProductID";
        GridDiv.Visible = true;

        ProductGrid.Selection.UnselectAll();
        ProductGrid.Columns[0].Visible = false;
        string name = Request.QueryString["un"];
        Session[name + "TableName"] = tmpTableName;

        popup.ShowOnPageLoad = false;

    }

    protected void InitialiseHistoryPopup(object sender, EventArgs e)
    {
        DataRow currentRow = ProductGrid.GetDataRow(ProductGrid.FocusedRowIndex);

        string productID = currentRow[0].ToString();

        DataRow[] newRows;
        DAL.Key.DbData.DataTable.Get_DataRows("ProductRatings", "FKProduct = " + productID, out newRows);

        if (newRows.Length > 0)
        {
            DataTable dr = newRows.CopyToDataTable<DataRow>();
            HistoryGrid.DataSource = dr;
            HistoryGrid.DataBind();
            HistGridDiv.Visible = true;
            ErrorLabel.Visible = false;
            ProductGrid.Columns[0].Visible = false;
        }
        else
        {
            HistGridDiv.Visible = false;
            ErrorLabel.Visible = true;
        }

    }

    protected void InitialiseRatePopup(object sender, EventArgs e)
    {
        DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp");
        ddlDepartment.DataSource = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp");
        ddlDepartment.DataTextField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[1].ToString();
        ddlDepartment.DataValueField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[0].ToString();
        ddlDepartment.DataBind();
    }
}