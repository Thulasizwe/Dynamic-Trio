using System;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxEditors;

public partial class Register : System.Web.UI.Page
{
    public bool ChangePass;
    private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (DAL.Key.DbData == null)
            DAL.Setup(null, new OleDbConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString), loadTableSchemas: true);
       
        if (!IsPostBack)
        {

            //Databind Title ddl
            DAL.Key.DbData.DataTable.Get_FromSP("FilterTitleSp", "FilterTitleSp");
            ddlTitle.DataSource = DAL.Key.DbData.DataTable.Get("FilterTitleSp");
            ddlTitle.DataTextField = DAL.Key.DbData.DataTable.Get("FilterTitleSp").Columns[1].ToString();
            ddlTitle.DataValueField = DAL.Key.DbData.DataTable.Get("FilterTitleSp").Columns[0].ToString();
            ddlTitle.DataBind();

            //string loginUser = (string) Session["login"];


            ListBoxColumn clm1 = new ListBoxColumn("ScreenName", "Screen Name");
            ListBoxColumn clm2 = new ListBoxColumn("PersonName", "Name");
            ListBoxColumn clm3 = new ListBoxColumn("PersonSurname", "Surame");
            ScreenName.Columns.Add(clm1);
            ScreenName.Columns.Add(clm2);
            ScreenName.Columns.Add(clm3);
        }
        ScreenName.DataSource = DAL.Key.DbData.DataTable.Get("contactPerson",true,true);
        ScreenName.TextField = DAL.Key.DbData.DataTable.Get("contactPerson").Columns["ScreenName"].ToString();
        ScreenName.ValueField = DAL.Key.DbData.DataTable.Get("contactPerson").Columns[0].ToString();
        ScreenName.DataBind();

        ChangePass = false;
        confirmLabel.Visible = false;
        UserConfirmP.Visible = false;
        passwordLabel.Visible = false;
        UserPassword.Visible = false;
        //    ddlDepartment.DataBind();
    }

    private void FilterCompanyddl()
    {
        //Databind Company ddl
        DAL.Key.DbData.DataTable.Get_FromSP("FilterCompanySp", "FilterCompanySp");
        ddlCompany.DataSource = DAL.Key.DbData.DataTable.Get("FilterCompanySp");
        ddlCompany.DataTextField = DAL.Key.DbData.DataTable.Get("FilterCompanySp").Columns[1].ToString();
        ddlCompany.DataValueField = DAL.Key.DbData.DataTable.Get("FilterCompanySp").Columns[0].ToString();
        ddlCompany.DataBind();

        FilterSiteddl();
    }


    public void SaveButton_Click(object sender, EventArgs e)
    {
        NameEmpty.Visible = (UserName.Text == "");

        SurnameEmpty.Visible = (Surname.Text == "");

        TitleEmpty.Visible = (ddlTitle.DataValueField == null);

        CompanyEmpty.Visible = (ddlCompany.DataValueField == null);
        SiteEmpty.Visible = (ddlSite.DataValueField == null);
        DepartmentEmpty.Visible = (ddlDepartment.DataValueField == null);

        AddrNoEmpty.Visible = (AddrNo.Text == "");
        AddrStrEmpty.Visible = (AddrStr.Text == "");
        AddrCityEmpty.Visible = (AddrCity.Text == "");
        AddrZipEmpty.Visible = (AddrZip.Text == "");
        AddrCountryEmpty.Visible = (AddrCountry.Text == "");


        string screenname = ScreenName.Text;
        string username = UserName.Text;
        string surname = Surname.Text;
        string emailaddress = UserEmailAdd.Text;
        string role = Role.Text;
        int addrNo = AddrNo.Text.AsInt();
        string addrStr = AddrStr.Text;
        string addrCity = AddrCity.Text;
        string addrZip = AddrZip.Text;
        string addrCountry = AddrCountry.Text;
        string keywords = KeywordTokBox.Text;
        string phone;
        string phoneExt;
        string cell;
        int title = Convert.ToInt32(ddlTitle.SelectedValue);
        int department = Convert.ToInt32(ddlDepartment.SelectedValue);
        string password = FormsAuthentication.HashPasswordForStoringInConfigFile(UserPassword.Text, "md5");

        if (Cell.Text == "") cell = "NULL";
        else cell = Cell.Text;

        if (Phone_Ext.Text == "") phoneExt = "NULL";
        else phoneExt = Phone_Ext.Text;

        if (Phone.Text == "") phone = "NULL";
        else phone = Phone.Text;

        if (ChangePass)
        {
            if (UserConfirmP.Text != UserPassword.Text || UserConfirmP.Text == "" || UserPassword.Text == "")
            {
                PasswordIncorrect.Visible = true;
                UserConfirmP.Text = "";
                UserPassword.Text = "";
            }
            else PasswordIncorrect.Visible = false;

            if (NameEmpty.Visible || SurnameEmpty.Visible || CompanyEmpty.Visible || SiteEmpty.Visible || DepartmentEmpty.Visible || AddrNoEmpty.Visible
                || AddrStrEmpty.Visible || AddrCityEmpty.Visible || AddrZipEmpty.Visible || AddrCountryEmpty.Visible)
            {
                return;
            }
        }
        else
        {

            if (NameEmpty.Visible || SurnameEmpty.Visible || CompanyEmpty.Visible || SiteEmpty.Visible || DepartmentEmpty.Visible || AddrNoEmpty.Visible
                || AddrStrEmpty.Visible || AddrCityEmpty.Visible || AddrZipEmpty.Visible || AddrCountryEmpty.Visible)
            {
                return;
            }
        }
        
        DAL.Key.DbData.SP_Execute("UpdateAddrRerID_SP", new object[] { screenname, addrNo.AsInt(), addrStr, addrCity, addrZip, addrCountry });

        if (ChangePass)
        {
            DAL.Key.DbData.SP_Execute("UpdateContactPersonAdminSp", new object[] { title, screenname, username, surname, emailaddress, cell, phoneExt, phone, role, department, password, 1 });
        }
        else
        {
            DAL.Key.DbData.SP_Execute("UpdateContactPersonAdminSp", new object[] { title, screenname, username, surname, emailaddress, cell, phoneExt, phone, role, department, password, 0 });
        }

        DAL.Key.DbData.SP_Execute("PopulateKeywordSp", new object[] { screenname, keywords });

        SavedLabel.Visible = true;
    }

    public void CompanyRefresh_Index(object sender, EventArgs e)
    {
        FilterSiteddl();
    }

    private void FilterSiteddl()
    {
        ddlSite.Enabled = true;
        ddlDepartment.Enabled = true;
        
        //Databind Site ddl
        DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", cmdParameters: new object[] { ddlCompany.SelectedValue });
        ddlSite.DataSource = DAL.Key.DbData.DataTable.Get("FilterSiteSp");
        ddlSite.DataTextField = DAL.Key.DbData.DataTable.Get("FilterSiteSp").Columns[1].ToString();
        ddlSite.DataValueField = DAL.Key.DbData.DataTable.Get("FilterSiteSp").Columns[0].ToString();
        ddlSite.DataBind();

        ddlSite.SelectedIndex = 0;

        FilterDepartmentddl();
    }

    public void SiteRefresh_Index(object sender, EventArgs e)
    {
        FilterDepartmentddl();
    }

    private void FilterDepartmentddl()
    {
        ddlDepartment.Enabled = true;

        //Databind Department ddl
        DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", "FilterDepartmentSp", cmdParameters: new object[] { ddlSite.SelectedValue });
        ddlDepartment.DataSource = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp");
        ddlDepartment.DataTextField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[1].ToString();
        ddlDepartment.DataValueField = DAL.Key.DbData.DataTable.Get("FilterDepartmentSp").Columns[0].ToString();
        ddlDepartment.DataBind();

        ddlDepartment.SelectedIndex = 0;
    }

    protected void btnPassword_Click(object sender, EventArgs e)
    {
        confirmLabel.Visible = true;
        UserConfirmP.Visible = true;
        btnPassword.Visible = false;
        ChangePass = true;
        passwordLabel.Visible = true;
        UserPassword.Visible = true;
    }

    protected void btnOverride_Click(object sender, EventArgs e)
    {
        if (ddlTitle.Enabled == false)
        {
            ddlTitle.Enabled = true;
            UserName.ReadOnly = false;
            Surname.ReadOnly = false;
            Cell.ReadOnly = false;
            Phone_Ext.ReadOnly = false;
            Phone.ReadOnly = false;
            AddrNo.ReadOnly = false;
            AddrStr.ReadOnly = false;
            AddrCity.ReadOnly = false;
            AddrZip.ReadOnly = false;
            AddrCountry.ReadOnly = false;
            btnOverride.Text = "Disable Override";
        }
        else
        {
            ddlTitle.Enabled = false;
            UserName.ReadOnly = true;
            Surname.ReadOnly = true;
            Cell.ReadOnly = true;
            Phone_Ext.ReadOnly = true;
            Phone.ReadOnly = true;
            AddrNo.ReadOnly = true;
            AddrStr.ReadOnly = true;
            AddrCity.ReadOnly = true;
            AddrZip.ReadOnly = true;
            AddrCountry.ReadOnly = true;
            btnOverride.Text = "Enable Override";
        }
    }

    protected void ScreenName_Select(object sender, EventArgs e)
    {
        if(ScreenName.Text != "")
        {
            DataTable dt = DAL.Key.DbData.DataTable.Get_FromSP("SearchScreenNameSp", "SearchScreenNameSp", cmdParameters: new object[] { ScreenName.Text });

            ddlTitle.SelectedValue = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][1].ToString();
            ddlTitle.Enabled = false;

            UserName.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][2].ToString();
            UserName.ReadOnly = true;

            Surname.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][3].ToString();
            Surname.ReadOnly = true;

            UserEmailAdd.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][4].ToString();

            Cell.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][5].ToString();
            Cell.ReadOnly = true;

            Phone_Ext.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][6].ToString();
            Phone_Ext.ReadOnly = true;

            Phone.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][7].ToString();
            Phone.ReadOnly = true;

            FilterCompanyddl();
            ddlCompany.SelectedValue = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][8].ToString();

            FilterSiteddl();
            ddlSite.SelectedValue = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][9].ToString();

            FilterDepartmentddl();
            ddlDepartment.SelectedValue = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][10].ToString();

            Role.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][11].ToString();

            AddrNo.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][12].ToString();
            AddrNo.ReadOnly = true;
            AddrStr.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][13].ToString();
            AddrStr.ReadOnly = true;
            AddrCity.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][14].ToString();
            AddrCity.ReadOnly = true;
            AddrZip.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][15].ToString();
            AddrZip.ReadOnly = true;
            AddrCountry.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][16].ToString();
            AddrCountry.ReadOnly = true;

            KeywordTokBox.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][17].ToString();

            userDataDiv.Visible = true;
            InvalidScreenName.Visible = false;
            btnOverride.Visible = true;
            SaveButton.Enabled = true;
        }
        else
        {
            userDataDiv.Visible = false;
            InvalidScreenName.Visible = true;
            btnOverride.Visible = false;
            SaveButton.Enabled = false;
        }
    }
}