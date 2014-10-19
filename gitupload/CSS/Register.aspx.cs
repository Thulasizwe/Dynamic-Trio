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

    private int PersonID;
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!IsPostBack)
        {
            DataTable FilterCompany = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("FilterCompanySp", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                   using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(FilterCompany);
                    }
                }
            }
            
            ddlCompany.DataSource = FilterCompany;
            ddlCompany.DataTextField = FilterCompany.Columns[1].ToString();
            ddlCompany.DataValueField = FilterCompany.Columns[0].ToString();
            ddlCompany.DataBind();

            DataTable FilterTitle = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("FilterTitleSp", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(FilterTitle);
                    }
                }
            }

            
            ddlTitle.DataSource = FilterTitle;
            ddlTitle.DataTextField = FilterTitle.Columns[1].ToString();
            ddlTitle.DataValueField = FilterTitle.Columns[0].ToString();
            ddlTitle.DataBind();
        }

        


            
   
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

        if (NameEmpty.Visible || SurnameEmpty.Visible || CompanyEmpty.Visible || PasswordIncorrect.Visible || AddrCountryEmpty.Visible || !valid)
        {
            SuccessLabel.Text = "Some required fields are not added.";
            SuccessLabel.Visible = true;
            return;
        }
        
        string query = "select * from ContactCompany where IDCompany = '" + ddlCompany.SelectedValue + "'";
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, sqlcon))
            {
                sqlcon.Open();
                SqlDataReader userRow = cmd.ExecuteReader();
                try
                {
                    while (userRow.Read())
                    {
                        
                    }
                }
                finally
                {
                    userRow.Close();
                }
            }
        }
        //DAL.Key.DbData.DataTable.Get("ContactCompany").cxFindRow("IDCompany = " + , out drTemp);

        string insert = "INSERT INTO SetupUser(UserName,FirstName, Surname,Email, [UserPassword],FKTitle, Cell, Phone, Phone_Ext, FKCompany, FKUserType) VALUES ( '" +
            screenname + "','" + username + "','" + surname + "','" + emailaddress + "','" +
            password + "'," + ddlTitle.SelectedValue + ",'" + cell + "','" + phone + "','" + phoneExt + "', " + ddlCompany.SelectedValue + ", 1)";
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand(insert, sqlcon))
            {
                sqlcon.Open();
                cmd.ExecuteReader();
                sqlcon.Close();
                
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
                DataTable SearchScreenNameSp = new DataTable();
                using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SearchScreenNameSp", sqlcon))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@ScreenNameSp", SqlDbType.VarChar).Value = (string)Session[name + "ScreenName"];
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(SearchScreenNameSp);
                        }
                    }
                }
                //DAL.Key.DbData.DataTable.Get_FromSP("SearchScreenNameSp", cmdParameters: new object[] { (string)Session[name + "ScreenName"] });
                if (SearchScreenNameSp.Rows.Count <= 0)
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
        DataTable SearchScreenNameSp = new DataTable();
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("SearchScreenNameSp", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@ScreenNameSp", SqlDbType.VarChar).Value = screenname;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(SearchScreenNameSp);
                }
            }
        }

        if (SearchScreenNameSp.Rows.Count > 0) // Is the user already inside the database
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
               // DataTable dtAttach = DAL.Key.DbData.DataTable.Get("contactPerson_History");
               // DataRow dtRow = dtAttach.NewRow();
               // dtRow.cxValue_Set("FKPerson", -1);
               // dtRow.cxValue_Set("Note_Date",  DateTime.Now);
              //  dtRow.cxValue_Set("Attachment", "~\\Attachments\\" + fileName);
              //  dtAttach.Rows.Add(dtRow);
              //  DAL.Key.DbData.DataTable.Update(dtAttach, true);

              //  DAL.Key.DbData.DataTable.Get_FromSP("sp_TOP1PersonHistory", "sp_TOP1PersonHistory",true).cxFindRow("FKPerson = -1", out dtRow);
                string name = Request.QueryString["un"];
                if (Session[name + "AttachmentID"] != null)
                {
                    //((int?[])Session[name + "AttachmentID"])[1] = (int)dtRow.cxValue_Get("IDPersonHistory");
                }
                else
                {
                    //Session[name + "AttachmentID"] = new int?[] { (int)dtRow.cxValue_Get("IDPersonHistory"), null };
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