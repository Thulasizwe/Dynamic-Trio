using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Carab.BusinessObjects.Layers;
using CarabiXbase;

public partial class Register : System.Web.UI.Page
{
    
    private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (DAL.Key.DbData == null)
                DAL.Setup(null, new OleDbConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString), loadTableSchemas: true);

            DAL.Key.DbData.DataTable.Get_FromSP("FilterTitleSp", "FilterTitleSp");


            ddlTitle.DataSource = DAL.Key.DbData.DataTable.Get("FilterTitleSp");
            ddlTitle.DataTextField = DAL.Key.DbData.DataTable.Get("FilterTitleSp").Columns[1].ToString();
            ddlTitle.DataValueField = DAL.Key.DbData.DataTable.Get("FilterTitleSp").Columns[0].ToString();
            ddlTitle.DataBind();


            string loginUser = Request.QueryString["un"];
            if (loginUser != null && loginUser != "") loginUser = loginUser.ToLower();
            else Response.Redirect("~/Login.aspx");
            string tmpTableName = "SearchScreenNameSp" + loginUser;
            DAL.Key.DbData.DataTable.Get_FromSP("SearchScreenNameSp", tmpTableName, cmdParameters: new object[] { loginUser });
                
            ScreenName.Text = loginUser;
            ScreenName.ReadOnly = true;

            if (DAL.Key.DbData.DataTable.Get(tmpTableName) != null)
            {
                ddlTitle.SelectedValue = DAL.Key.DbData.DataTable.Get(tmpTableName).Rows[0][1].ToString();
                UserName.Text = DAL.Key.DbData.DataTable.Get(tmpTableName).Rows[0][2].ToString();
                Surname.Text = DAL.Key.DbData.DataTable.Get(tmpTableName).Rows[0][3].ToString();
                UserEmailAdd.Text = DAL.Key.DbData.DataTable.Get(tmpTableName).Rows[0][4].ToString();
                Cell.Text = DAL.Key.DbData.DataTable.Get(tmpTableName).Rows[0][5].ToString();
                Phone_Ext.Text = DAL.Key.DbData.DataTable.Get(tmpTableName).Rows[0][6].ToString();
                Phone.Text = DAL.Key.DbData.DataTable.Get(tmpTableName).Rows[0][7].ToString();
                AddrNo.Text = DAL.Key.DbData.DataTable.Get(tmpTableName).Rows[0][12].ToString();
                AddrStr.Text = DAL.Key.DbData.DataTable.Get(tmpTableName).Rows[0][13].ToString();
                AddrCity.Text = DAL.Key.DbData.DataTable.Get(tmpTableName).Rows[0][14].ToString();
                AddrZip.Text = DAL.Key.DbData.DataTable.Get(tmpTableName).Rows[0][15].ToString();
                AddrCountry.Text = DAL.Key.DbData.DataTable.Get(tmpTableName).Rows[0][16].ToString();
            }
            string name = Request.QueryString["un"];   
            Session[name + "Tool"] = false;
        }
    
        confirmLabel.Visible = false;
        UserConfirmP.Visible = false;
        passwordLabel.Visible = false;
        UserPassword.Visible = false;
        lblCurPass.Visible = false;
        OldPassword.Visible = false;
     
    }
 
    public void SaveButton_Click(object sender, EventArgs e)
    {
        NameEmpty.Visible = (UserName.Text == "");

        SurnameEmpty.Visible = (Surname.Text == "");

        AddrNoEmpty.Visible = (AddrNo.Text == "");
        AddrStrEmpty.Visible = (AddrStr.Text == "");
        AddrCityEmpty.Visible = (AddrCity.Text == "");
        AddrZipEmpty.Visible = (AddrZip.Text == "");
        AddrCountryEmpty.Visible = (AddrCountry.Text == "");
        string name = Request.QueryString["un"];
        string AddrID;
        if (DAL.Key.DbData.DataTable.Exists("SearchScreenNameSp")) AddrID = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][18].ToString();
        else AddrID = DAL.Key.DbData.DataTable.Get_FromSP("SearchScreenNameSp", "SearchScreenNameSp",cmdParameters: new object[] {name}).Rows[0][18].ToString();
        string screenname = name;
        string username = UserName.Text;
        string surname = Surname.Text;
        string emailaddress = UserEmailAdd.Text;
        string addrNo = AddrNo.Text;
        string addrStr = AddrStr.Text;
        string addrCity = AddrCity.Text;
        string addrZip = AddrZip.Text;
        string addrCountry = AddrCountry.Text;
        string phone;
        string phoneExt;
        string cell;
        int title = Convert.ToInt32(ddlTitle.SelectedValue);
        string password = FormsAuthentication.HashPasswordForStoringInConfigFile(UserPassword.Text, "md5");
        string oldpassword = FormsAuthentication.HashPasswordForStoringInConfigFile(OldPassword.Text, "md5");
        bool flag = (bool) Session[name + "Tool"];
        if (Cell.Text == "")  cell = "NULL";
        else  cell = Cell.Text;

        if (Phone_Ext.Text == "")  phoneExt = "NULL";
        else  phoneExt = Phone_Ext.Text;

        if (Phone.Text == "")  phone = "NULL";
        else  phone = Phone.Text;
        if (flag)
        {
            string spName = "PersonLogin" + screenname + OldPassword.Text;
            DAL.Key.DbData.DataTable.Get_FromSP("PersonLoginSP", spName, cmdParameters: new object[] { screenname, oldpassword });
            DataTable tmp = DAL.Key.DbData.DataTable.Get(spName);
            if (DAL.Key.DbData.DataTable.Get(spName).Rows.Count <= 0)
            {
                OldPasswordIncorrect.Visible = true;
                OldPassword.Text = "";
            }
            else OldPasswordIncorrect.Visible = false;
           

            if (UserConfirmP.Text != UserPassword.Text || UserConfirmP.Text == "" ||
           UserPassword.Text == "")
            {
                PasswordIncorrect.Visible = true;
                UserConfirmP.Text = "";
                UserPassword.Text = "";
            }
            else {PasswordIncorrect.Visible = false;
            
                 }

            if (NameEmpty.Visible || SurnameEmpty.Visible || AddrNoEmpty.Visible || AddrStrEmpty.Visible ||
                AddrCityEmpty.Visible || AddrZipEmpty.Visible || AddrCountryEmpty.Visible || PasswordIncorrect.Visible || OldPasswordIncorrect.Visible)
            {
                OldPassword.Focus();
                confirmLabel.Visible = true;
                UserConfirmP.Visible = true;
                passwordLabel.Visible = true;
                UserPassword.Visible = true;
                lblCurPass.Visible = true;
                OldPassword.Visible = true;
                return;
            }
            else
            {
                DAL.Key.DbData.SP_Execute("UpdateContactPersonSp", title, screenname, username, surname, emailaddress, cell, phoneExt, phone, password, 1);
            }
        }
        else
        {

            if (NameEmpty.Visible || SurnameEmpty.Visible || AddrNoEmpty.Visible || AddrStrEmpty.Visible ||
                AddrCityEmpty.Visible || AddrZipEmpty.Visible || AddrCountryEmpty.Visible)
            {
                OldPassword.Focus();
                confirmLabel.Visible = true;
                UserConfirmP.Visible = true;
                passwordLabel.Visible = true;
                UserPassword.Visible = true;
                lblCurPass.Visible = true;
                OldPassword.Visible = true;
                return;
            }
            else
            {
                DAL.Key.DbData.SP_Execute("UpdateContactPersonSp", title, screenname, username, surname, emailaddress, cell, phoneExt, phone, password, 0);
            }
        }
        DAL.Key.DbData.SP_Execute("sp_UpdateAddr",AddrID, addrNo, addrStr, addrCity, addrZip, addrCountry);
           
        

        UserName.Text = "";
        UserEmailAdd.Text = "";
        AddrNo.Text = "";
        AddrStr.Text = "";
        AddrCity.Text = "";
        AddrZip.Text = "";
        AddrCountry.Text = "";
        ScreenName.Text = "";
        Surname.Text = "";
        SavedLabel.Visible = true;
        Session[name + "Tool"] = false;
        string loginUser = name;

        var tmps = DAL.Key.DbData.DataTable.Get_FromSP("SearchScreenNameSp", "SearchScreenNameSp", cmdParameters: new object[] { loginUser });

        ScreenName.Text = loginUser;
        ScreenName.ReadOnly = true;


        ddlTitle.SelectedValue = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][1].ToString();
        UserName.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][2].ToString();
        Surname.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][3].ToString();
        UserEmailAdd.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][4].ToString();
        Cell.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][5].ToString();
        Phone_Ext.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][6].ToString();
        Phone.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][7].ToString();
        AddrNo.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][12].ToString();
        AddrStr.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][13].ToString();
        AddrCity.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][14].ToString();
        AddrZip.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][15].ToString();
        AddrCountry.Text = DAL.Key.DbData.DataTable.Get("SearchScreenNameSp").Rows[0][16].ToString();
    }
    /// <summary>
    /// Handles the Click event of the Button1 control.
    /// </summary>
    /// <param name="sender">The source of the event Testing 1  2  3.</param>
    /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
    protected void Button1_Click(object sender, EventArgs e)
    {
        confirmLabel.Visible = true;
        UserConfirmP.Visible = true;
        btnPassword.Visible = false;
        string name = Request.QueryString["un"];
        Session[name + "Tool"] = true;
        passwordLabel.Visible = true;
        UserPassword.Visible = true;
        lblCurPass.Visible = true;
        OldPassword.Visible = true;
    }
    protected void SubmitID_Click(object sender, EventArgs e)
    {
        if ((FileUploadControl.PostedFile != null) && (FileUploadControl.PostedFile.ContentLength > 0))
        {
            string fn = "FacialImage";
            string ext = System.IO.Path.GetExtension(FileUploadControl.PostedFile.FileName);
            string fileName = ScreenName.Text + "\\" + fn + "_" + DateTime.Now.Day + "_" + DateTime.Now.Month + "_" +
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
                //
                UploadLabel.Text = "Upload Successful";
                DataTable Tmp = DAL.Key.DbData.DataTable.Get_FromSP("SearchScreenNameSp", "SearchScreenNameSp",
                                                                    cmdParameters: new object[] {ScreenName.Text});

                int personId = (int)DAL.Key.DbData.DataTable.Get_FromSP("SearchScreenNameSp", "SearchScreenNameSp",
                                                    cmdParameters: new object[] { ScreenName.Text }).Rows[0].cxValue_Get("IDPerson");
                if (personId <= 0) return; // <----------------------------------

                DataTable dtAttach = DAL.Key.DbData.DataTable.Get("contactPerson_History");
                DataRow dtRow = dtAttach.NewRow();
                dtRow.cxValue_Set("FKPerson", personId);
                dtRow.cxValue_Set("Note_Heading", "Profile_Image");
                dtRow.cxValue_Set("Note_Detail", fn);
                dtRow.cxValue_Set("Note_Date", DateTime.Now);
                dtRow.cxValue_Set("Attachment", "~\\Attachments\\" + fileName);
                dtAttach.Rows.Add(dtRow);
                DAL.Key.DbData.DataTable.Update(dtAttach, true);
            }
            catch (Exception)
            {
                UploadLabel.Text = "Upload unsuccessful, please try again";
            }
        }
        else
        {
            UploadLabel.Text = "Upload unsuccessful, please try again";
        }
    }
}