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
//using Carab.BusinessObjects.Layers;
//using CarabiXbase;

public partial class Register : System.Web.UI.Page
{
    
    //private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //if (DAL.Key.DbData == null)
            //    DAL.Setup(null, new OleDbConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString), loadTableSchemas: true);

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


            string loginUser = Request.QueryString["un"];
            if (loginUser != null && loginUser != "") loginUser = loginUser.ToLower();
            else Response.Redirect("~/Login.aspx");
            string tmpTableName = "SearchScreenNameSp" + loginUser;
            DataTable SearchScreenNameSp = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SearchScreenNameSp", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ScreenNameSp", SqlDbType.VarChar).Value = loginUser;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(SearchScreenNameSp);
                    }
                }
            }
           
                
            ScreenName.Text = loginUser;
            ScreenName.ReadOnly = true;

            
                ddlTitle.SelectedValue = SearchScreenNameSp.Rows[0][1].ToString();
                UserName.Text = SearchScreenNameSp.Rows[0][2].ToString();
                Surname.Text = SearchScreenNameSp.Rows[0][3].ToString();
                UserEmailAdd.Text = SearchScreenNameSp.Rows[0][4].ToString();
                Cell.Text = SearchScreenNameSp.Rows[0][5].ToString();
                Phone_Ext.Text = SearchScreenNameSp.Rows[0][6].ToString();
                Phone.Text = SearchScreenNameSp.Rows[0][7].ToString();
                
            
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

       
        string name = Request.QueryString["un"];
        string AddrID;
        string screenname = name;
        string username = UserName.Text;
        string surname = Surname.Text;
        string emailaddress = UserEmailAdd.Text;
       
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
            DataTable PersonLoginSP = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("PersonLoginSP", sqlcon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = screenname;
                    cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = oldpassword;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {


                        da.Fill(PersonLoginSP);
                    }
                }
            }

            if (PersonLoginSP.Rows.Count <= 0)
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

            if (NameEmpty.Visible || SurnameEmpty.Visible ||  PasswordIncorrect.Visible || OldPasswordIncorrect.Visible)
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
                DataTable UpdateContactPersonSp = new DataTable();
                using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("PersonLoginSP", sqlcon))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@spTile", SqlDbType.VarChar).Value = title;
                        cmd.Parameters.Add("@spScreenName", SqlDbType.VarChar).Value = screenname;
                        cmd.Parameters.Add("@spUsername", SqlDbType.VarChar).Value = username;
                        cmd.Parameters.Add("@spSurname", SqlDbType.VarChar).Value = surname;
                        cmd.Parameters.Add("@spEmail", SqlDbType.VarChar).Value = emailaddress;
                        cmd.Parameters.Add("@spCell", SqlDbType.VarChar).Value = cell;
                        cmd.Parameters.Add("@spPhoneExt", SqlDbType.VarChar).Value = phoneExt;
                        cmd.Parameters.Add("@spPhone", SqlDbType.VarChar).Value = phone;
                        cmd.Parameters.Add("@Password", SqlDbType.VarChar).Value = password;
                        cmd.Parameters.Add("@CPass", SqlDbType.VarChar).Value = 1;
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {


                            da.Fill(UpdateContactPersonSp);
                        }
                    }
                }
               
            }
        }
        else
        {

            if (NameEmpty.Visible || SurnameEmpty.Visible )
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
                DataTable UpdateContactPersonSp = new DataTable();
                using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("PersonLoginSP", sqlcon))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@spTile", SqlDbType.VarChar).Value = title;
                        cmd.Parameters.Add("@spScreenName", SqlDbType.VarChar).Value = screenname;
                        cmd.Parameters.Add("@spUsername", SqlDbType.VarChar).Value = username;
                        cmd.Parameters.Add("@spSurname", SqlDbType.VarChar).Value = surname;
                        cmd.Parameters.Add("@spEmail", SqlDbType.VarChar).Value = emailaddress;
                        cmd.Parameters.Add("@spCell", SqlDbType.VarChar).Value = cell;
                        cmd.Parameters.Add("@spPhoneExt", SqlDbType.VarChar).Value = phoneExt;
                        cmd.Parameters.Add("@spPhone", SqlDbType.VarChar).Value = phone;
                        cmd.Parameters.Add("@Password", SqlDbType.VarChar).Value = password;
                        cmd.Parameters.Add("@CPass", SqlDbType.VarChar).Value = 0;
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {


                            da.Fill(UpdateContactPersonSp);
                        }
                    }
                }
            }
        }
       
           
        

        UserName.Text = "";
        UserEmailAdd.Text = "";
        ScreenName.Text = "";
        Surname.Text = "";
        SavedLabel.Visible = true;
        Session[name + "Tool"] = false;
        string loginUser = name;
        DataTable SearchScreenNameSp = new DataTable();
        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("SearchScreenNameSp", sqlcon))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@ScreenNameSp", SqlDbType.VarChar).Value = loginUser;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(SearchScreenNameSp);
                }
            }
        }

        ScreenName.Text = loginUser;
        ScreenName.ReadOnly = true;


        ddlTitle.SelectedValue = SearchScreenNameSp.Rows[0][1].ToString();
        UserName.Text = SearchScreenNameSp.Rows[0][2].ToString();
        Surname.Text = SearchScreenNameSp.Rows[0][3].ToString();
        UserEmailAdd.Text = SearchScreenNameSp.Rows[0][4].ToString();
        Cell.Text = SearchScreenNameSp.Rows[0][5].ToString();
        Phone_Ext.Text = SearchScreenNameSp.Rows[0][6].ToString();
        Phone.Text = SearchScreenNameSp.Rows[0][7].ToString();
        
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
               
                int personId = (int)SearchScreenNameSp.Rows[0]["IDPerson"];
                if (personId <= 0) return; // <----------------------------------
                string insert = "INSERT INTO contactPerson_History(FKPerson,Note_Heading, Note_Detail, Note_Date, Attachment) VALUES (" +
            personId + "," + "Profile_Image" + "," + fn + "," + DateTime.Now + "," + "~\\Attachments\\" + fileName + ")";
                using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["ManDash"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(insert, sqlcon))
                    {
                        sqlcon.Open();
                        cmd.ExecuteReader();
                        sqlcon.Close();

                    }
                }
                
                //DAL.Key.DbData.DataTable.Update(dtAttach, true);
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