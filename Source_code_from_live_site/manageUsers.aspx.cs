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
//using Carab.BusinessObjects.Layers;
//using CarabCore;
//using CarabiXbase;
//using CarabiXbase._Object;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxEditors;

public partial class Register : System.Web.UI.Page
{
    public bool ChangePass;
    //private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (DAL.Key.DbData == null)
        //    DAL.Setup(null, new OleDbConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString), loadTableSchemas: true);
       
        if (!IsPostBack)
        {

            //Databind Title ddl
            DataTable FilterTitleSp = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("FilterTitleSp", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(FilterTitleSp);
                    }
                }
            }
           
            ddlTitle.DataSource = FilterTitleSp;
            ddlTitle.DataTextField = FilterTitleSp.Columns[1].ToString();
            ddlTitle.DataValueField = FilterTitleSp.Columns[0].ToString();
            ddlTitle.DataBind();

            


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
                //cmd.CommandType = CommandType.StoredProcedure;
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

        ChangePass = true;
        confirmLabel.Visible = false;
        UserConfirmP.Visible = false;
        passwordLabel.Visible = false;
        UserPassword.Visible = false;
      
    }

    private void FilterCompanyddl()
    {
        //Databind Company ddl
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


        ddlCompany.DataSource = FilterCompanySp;
        ddlCompany.DataTextField = FilterCompanySp.Columns[1].ToString();
        ddlCompany.DataValueField = FilterCompanySp.Columns[0].ToString();
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

       

        string screenname = ScreenName.Text;
        string username = UserName.Text;
        string surname = Surname.Text;
        string emailaddress = UserEmailAdd.Text;
        
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

            if (NameEmpty.Visible || SurnameEmpty.Visible || CompanyEmpty.Visible || SiteEmpty.Visible || DepartmentEmpty.Visible)
            {
                return;
            }
        }
        else
        {

            if (NameEmpty.Visible || SurnameEmpty.Visible || CompanyEmpty.Visible || SiteEmpty.Visible || DepartmentEmpty.Visible )
            {
                return;
            }
        }
        
        
        if (ChangePass)
        {
           // DAL.Key.DbData.SP_Execute("UpdateContactPersonAdminSp", new object[] { title, screenname, username, surname, emailaddress, cell, phoneExt, phone, department, password, 1 });
        }
        else
        {
            //DAL.Key.DbData.SP_Execute("UpdateContactPersonAdminSp", new object[] { title, screenname, username, surname, emailaddress, cell, phoneExt, phone, department, password, 0 });
        }

       

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
            btnOverride.Text = "Enable Override";
        }
    }

    protected void ScreenName_Select(object sender, EventArgs e)
    {
        if(ScreenName.Text != "")
        {
            DataTable SearchScreenNameSp = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SearchScreenNameSp", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ScreenNameSp", SqlDbType.VarChar).Value = ScreenName.Text;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(SearchScreenNameSp);
                    }
                }
            }
           // DataTable dt = DAL.Key.DbData.DataTable.Get_FromSP("SearchScreenNameSp", "SearchScreenNameSp", cmdParameters: new object[] { ScreenName.Text });

            ddlTitle.SelectedValue =SearchScreenNameSp.Rows[0][1].ToString();
            ddlTitle.Enabled = false;

            UserName.Text =SearchScreenNameSp.Rows[0][2].ToString();
            UserName.ReadOnly = true;

            Surname.Text = SearchScreenNameSp.Rows[0][3].ToString();
            Surname.ReadOnly = true;

            UserEmailAdd.Text = SearchScreenNameSp.Rows[0][4].ToString();

            Cell.Text = SearchScreenNameSp.Rows[0][5].ToString();
            Cell.ReadOnly = true;

            Phone_Ext.Text = SearchScreenNameSp.Rows[0][6].ToString();
            Phone_Ext.ReadOnly = true;

            Phone.Text = SearchScreenNameSp.Rows[0][7].ToString();
            Phone.ReadOnly = true;

            FilterCompanyddl();
            ddlCompany.SelectedValue = SearchScreenNameSp.Rows[0][8].ToString();
            //AddrCity.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][14].ToString();
            //AddrCity.ReadOnly = true;
            //AddrCountry.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][16].ToString();
            //AddrCountry.ReadOnly = true;
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