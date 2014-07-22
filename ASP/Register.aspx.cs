using System;
using System.Activities.Expressions;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Register : System.Web.UI.Page
{
    private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (DAL.Key.DbData == null)
            DAL.Setup(null, new OleDbConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString), loadTableSchemas: true);
        if (!IsPostBack)
        {
            DAL.Key.DbData.DataTable.Get_FromSP("FilterCompanySp");
            ddlCompany.DataSource = DAL.Key.DbData.DataTable.Get("FilterCompanySP");
            ddlCompany.DataTextField = DAL.Key.DbData.DataTable.Get("FilterCompanySP").Columns[1].ToString();
            ddlCompany.DataValueField = DAL.Key.DbData.DataTable.Get("FilterCompanySP").Columns[0].ToString();
            ddlCompany.DataBind();
            FilterSiteddl();

            DAL.Key.DbData.DataTable.Get_FromSP("FilterTitleSP");
            ddlTitle.DataSource = DAL.Key.DbData.DataTable.Get("FilterTitleSP");
            ddlTitle.DataTextField = DAL.Key.DbData.DataTable.Get("FilterTitleSP").Columns[1].ToString();
            ddlTitle.DataValueField = DAL.Key.DbData.DataTable.Get("FilterTitleSP").Columns[0].ToString();
            ddlTitle.DataBind();
        }

            
        ////    ddlDepartment.DataBind();
    }

    public void RegisterButton_Click(object sender, EventArgs e)
    {
        if (UserConfirmP.Text != UserPassword.Text || UserConfirmP.Text == "" ||
            UserPassword.Text == "")
        {
            PasswordIncorrect.Visible = true;
            UserConfirmP.Text = "";
            UserPassword.Text = "";
        }
        else PasswordIncorrect.Visible = false;
        
        if (ScreenName.Text == "")
        {
            ScreenNameInvalid.Text = "The screen name is not allowed to be empty";
            ScreenNameInvalid.Visible = true;
        }
        else ScreenNameInvalid.Visible = false;

        //if (UserEmailAdd.Text ==) Email address format validation check

        NameEmpty.Visible = (UserName.Text == "");

        SurnameEmpty.Visible = (Surname.Text == "");

        CompanyEmpty.Visible = (ddlCompany.DataValueField == null);

        SiteEmpty.Visible = (ddlSite.DataValueField == null);

        DepartmentEmpty.Visible = (ddlDepartment.DataValueField == null);

       
        AddrCountryEmpty.Visible = (AddrCountry.Text == "");


        string screenname = ScreenName.Text; // For @username we will compare to database username
        string password = FormsAuthentication.HashPasswordForStoringInConfigFile(UserPassword.Text, "md5");
        string username = UserName.Text;
        string surname = Surname.Text;
        string emailaddress = UserEmailAdd.Text;
        string addrCountry = AddrCountry.Text;
        string phone;
        string phoneExt;
        string cell;

        if (Cell.Text == "") cell = "NULL";
        else cell = Cell.Text;

        if (Phone_Ext.Text == "") phoneExt = "NULL";
        else phoneExt = Phone_Ext.Text;

        if (Phone.Text == "") phone = "NULL";
        else phone = Phone.Text;

        bool valid = CheckScreenName(screenname);

        if (NameEmpty.Visible || SurnameEmpty.Visible || CompanyEmpty.Visible || SiteEmpty.Visible || PasswordIncorrect.Visible || DepartmentEmpty.Visible|| AddrCountryEmpty.Visible || !valid)
        {
            SuccessLabel.Text = "Some required fields are not added.";
            SuccessLabel.Visible = true;
            return;
        }
        //DataSet ds = new DataSet();
        DAL.Key.DbData.SP_AsDataTable("AddAddrRerID_SP", "AddAddresID_SP", cmdParameters:
            new object[] {addrCountry});
        DataRow drTemp;
        DAL.Key.DbData.DataTable.Get("ContactCompany").cxFindRow("IDCompany = " + ddlCompany.SelectedValue, out drTemp);
        int industry = drTemp.cxValue_Get("FkIndustry").AsInt(1); //drTemp.cxValue_Get(0).AsInt(1);

        DAL.Key.DbData.SP_Execute("AddContactPersonSp",new object[]
                {
                    screenname, username, surname, emailaddress, ddlDepartment.SelectedValue, industry,
                    DAL.Key.DbData.DataTable.Get("AddAddresID_SP").Rows[0][0],
                    password, ddlTitle.SelectedValue, cell, phone, phoneExt
                });

           
        
        
        string name = Request.QueryString["un"];
        if (Session[name + "AttachmentID"] != null)
        {
            if (DAL.Key.DbData.DataTable.Get("contactPerson").cxFindRow("ScreenName = '" + screenname +"'", out drTemp))
            {

                int PersonID = (int) drTemp.cxValue_Get(0);
                DataRow drAddPerson;
                DataTable dtPHistory = DAL.Key.DbData.DataTable.Get("contactPerson_History");
                int?[] temp = ((int?[])Session[name + "AttachmentID"]);
                foreach (int? IdPerson in temp)
                {
                    if (IdPerson == null) continue;
                    dtPHistory.cxFindRow("IDPersonHistory = '" + IdPerson + "'", out drAddPerson);
                    drAddPerson.cxValue_Set("FKPerson", PersonID);
                }
                DAL.Key.DbData.DataTable.Update(dtPHistory);
            }
        }
        // Reset to start Values
        ClearValues();

        SuccessLabel.Text = "User seccessfully added.";
        SuccessLabel.Visible = true;
    }

    private void ClearValues()
    {
        UserName.Text = "";
        UserPassword.Text = "";
        UserConfirmP.Text = "";
        UserEmailAdd.Text = "";
       
        AddrCountry.Text = "";
        ddlTitle.SelectedIndex = 0;
        ddlCompany.SelectedIndex = 0;
        ddlSite.SelectedIndex = 0;
        ddlDepartment.SelectedIndex = 0;
        ScreenName.Text = "";
        Surname.Text = "";
       
        Cell.Text = "";
        Phone.Text = "";
        Phone_Ext.Text = "";
       
        ScreenNameInvalid.Visible = false;
        string name = Request.QueryString["un"];
        Session[name + "AttachmentID"] = null;
        Session[name + "ScreenName"] = null;
      
    }

    public void CheckScreenName_Event(object sender, EventArgs e)
    {
        string name = Request.QueryString["un"];
        string temp = (string)Session[name + "ScreenName"];
        if (Session[name + "ScreenName"] != null && (string)Session[name + "ScreenName"] != "" && (string)Session[name + "ScreenName"] != ScreenName.Text)
        {
            if (Directory.Exists(Server.MapPath("Attachments") + "\\" + (string)Session[name + "ScreenName"]))
            {
                DAL.Key.DbData.DataTable.Get_FromSP("SearchScreenNameSp", cmdParameters: new object[] { (string)Session[name + "ScreenName"] });
                if (DAL.Key.DbData.DataTable.Get("SearchScreenNameSP").Rows.Count <= 0)
                {
                    Directory.Delete(Server.MapPath("Attachments") + "\\" + (string)Session[name + "ScreenName"], true);
                }
            }
        }
        CheckScreenName(ScreenName.Text);
        Session[name + "ScreenName"] = ScreenName.Text;
        divUploadbtns.Visible = true;
       
        Session[name + "AttachmentID"] = null;
        
    }

    public bool CheckScreenName(string screenname)
    {
        DAL.Key.DbData.DataTable.Get_FromSP("SearchScreenNameSp", cmdParameters: new object[] {screenname});
        if (DAL.Key.DbData.DataTable.Get("SearchScreenNameSP").Rows.Count > 0) // Is the user already inside the database
        {
            ScreenNameInvalid.Text =
                "The user is already inside the database (Suggested: append your Initials to the screen name)";
            ScreenNameInvalid.ForeColor = Color.Red;
            ScreenNameInvalid.Visible = true;
            btnUpload.Enabled = false;
            return false;
            //return;
        }
        else if (ScreenName.Text == "")
        {
            ScreenNameInvalid.Visible = false;
            btnUpload.Enabled = false;
            return false;
        }
        else
        {
            ScreenNameInvalid.Text = "This screen name is available!";
            ScreenNameInvalid.ForeColor = Color.ForestGreen;
            ScreenNameInvalid.Visible = true;
            btnUpload.Enabled = true;
            return true;
        }
    }

    public void CompanyRefresh_Index(object sender, EventArgs e)
    {
        FilterSiteddl();
    }

    private void FilterSiteddl()
    {
        ddlSite.Enabled = true;
        ddlDepartment.Enabled = true;
        RegisterButton.Enabled = true;

        DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", cmdParameters: new object[] { ddlCompany.SelectedValue});
        {

            ddlSite.DataSource = DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp");
            ddlSite.DataTextField = DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp").Columns[1].ToString();
            ddlSite.DataValueField = DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp").Columns[0].ToString();
            ddlSite.DataBind();
        }

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
        RegisterButton.Enabled = true;

        DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp", cmdParameters: new object[] { ddlSite.SelectedValue });
        {
            ddlDepartment.DataSource = DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartMentSp");
            ddlDepartment.DataTextField = DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp").Columns[1].ToString();
            ddlDepartment.DataValueField = DAL.Key.DbData.DataTable.Get_FromSP("FilterDepartmentSp").Columns[0].ToString();
            ddlDepartment.DataBind();
        }

        ddlDepartment.SelectedIndex = 0;
    }

    public void DepartmentRefresh_Index(object sender, EventArgs e)
    {
        RegisterButton.Enabled = true;
    }


    protected void SubmitID_Click(object sender, EventArgs e)
    {
        if (ScreenNameInvalid.Text != "This screen name is available!")
        {
            return;
        }
        if ((FileUploadControl.PostedFile != null) && (FileUploadControl.PostedFile.ContentLength > 0))
        {
            string fn;
           
            string ext = System.IO.Path.GetExtension(FileUploadControl.PostedFile.FileName);
            string fileName = ScreenName.Text  + "_" + DateTime.Now.Day + "_" + DateTime.Now.Month + "_" +
                              DateTime.Now.Year + ext;
            string SaveLocation = Server.MapPath("Attachments") + "\\" + fileName;
            try
            {
                double size = ((double)FileUploadControl.PostedFile.ContentLength) / (1024 * 1024);
                // Maximum 5 Mb file size
                if (size > 5.25)
                {
                    return;
                }
                if (!Directory.Exists(Server.MapPath("Attachments") + "\\" + ScreenName.Text))
                    Directory.CreateDirectory(Server.MapPath("Attachments") + "\\" + ScreenName.Text);
                FileUploadControl.PostedFile.SaveAs(SaveLocation);
                divUploadbtns.Visible = false;
                Label1.Text = "Upload Successful";
                DataTable dtAttach = DAL.Key.DbData.DataTable.Get("contactPerson_History");
                DataRow dtRow = dtAttach.NewRow();
                dtRow.cxValue_Set("FKPerson", -1);
                dtRow.cxValue_Set("Note_Date",  DateTime.Now);
                dtRow.cxValue_Set("Attachment", "~\\Attachments\\" + fileName);
                dtAttach.Rows.Add(dtRow);
                DAL.Key.DbData.DataTable.Update(dtAttach, true);

                DAL.Key.DbData.DataTable.Get_FromSP("sp_TOP1PersonHistory", "sp_TOP1PersonHistory",true).cxFindRow("FKPerson = -1", out dtRow);
                string name = Request.QueryString["un"];
                if (Session[name + "AttachmentID"] != null)
                {
                    ((int?[])Session[name + "AttachmentID"])[1] = (int)dtRow.cxValue_Get("IDPersonHistory");
                }
                else
                {
                    Session[name + "AttachmentID"] = new int?[] { (int)dtRow.cxValue_Get("IDPersonHistory"), null };
                }
               
            }
            catch (Exception)
            {
                Label1.Text = "Upload unsuccessful, please try again";
            }
        }
        else
        {
            Label1.Text = "Upload unsuccessful, please try again";
        }
    }

    protected void DisplayUploader(object sender, EventArgs e)
    {
        
    }
}