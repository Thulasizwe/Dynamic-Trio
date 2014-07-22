using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.Services;

using AjaxControlToolkit;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Summary description for CCDDLWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Ajaxdropdowns : System.Web.Services.WebService
{
    
    private SqlConnection conn = null;
   

    [WebMethod]
    public CascadingDropDownNameValue[] BindIndustry(string knownCategoryValues, string category)
    {
        
        conn = new SqlConnection(@"Password=ckmcpta7;Persist Security Info=True;User ID=sa;Initial Catalog=contactASPDB;Data Source=192.168.0.148\testing,1433;");
       
        DataSet ds = new DataSet();
        conn.Open();
        SqlCommand cmd = new SqlCommand("exec FilterIndustrySp", conn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        cmd.ExecuteNonQuery();        
        adp.Fill(ds);
        conn.Close();
        var industry = new List<CascadingDropDownNameValue>();
        foreach (DataRow DR in ds.Tables[0].Rows)
        {
            string IndustryID = DR.cxValue_Get("IDIndustry").ToString();
            string IndustryName = DR.cxValue_Get("Industry").ToString();
            industry.Add(new CascadingDropDownNameValue(IndustryName, IndustryID));

        }
        return industry.ToArray();
    }

    [WebMethod]


    public CascadingDropDownNameValue[] BindCompany(string knownCategoryValues, string category)
    {
        conn = new SqlConnection(@"Password=ckmcpta7;Persist Security Info=True;User ID=sa;Initial Catalog=contactASPDB;Data Source=192.168.0.148\testing,1433;");
       
        DataSet ds = new DataSet();
        conn.Open();
        SqlCommand cmd = new SqlCommand("exec FilterCompanySp", conn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        cmd.ExecuteNonQuery();
        adp.Fill(ds);
        conn.Close();

        List<CascadingDropDownNameValue> Company = new List<CascadingDropDownNameValue>();
        foreach (DataRow DR in ds.Tables[0].Rows)
        {
            string CompanyID = DR.cxValue_Get("IDCompany").ToString();
            string CompanyName = DR.cxValue_Get("Company").ToString();
            Company.Add(new CascadingDropDownNameValue(CompanyName, CompanyID));

        }
        return Company.ToArray();
    }

    [WebMethod]


    public CascadingDropDownNameValue[] BindSite(string knownCategoryValues, string category)
    {
        conn = new SqlConnection(@"Password=ckmcpta7;Persist Security Info=True;User ID=sa;Initial Catalog=contactASPDB;Data Source=192.168.0.148\testing,1433;");
        DataSet ds = new DataSet();
        int CompanyID;
        StringDictionary Company = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
        CompanyID = Company["Company"].AsInt();
        conn.Open();
        SqlCommand cmd = new SqlCommand("exec FilterSiteSp " + CompanyID, conn);
        //cmd.Parameters.AddWithValue("@CompanyID", CompanyID);
        cmd.ExecuteNonQuery();
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        adp.Fill(ds);
        conn.Close();
        var Site = new List<CascadingDropDownNameValue>();
        foreach (DataRow DR in ds.Tables[0].Rows)
        {
            string SiteID = DR["IDSite"].ToString();
            string SiteName = DR["Site"].ToString();
            Site.Add(new CascadingDropDownNameValue(SiteName, SiteID));

        }
        return Site.ToArray();
    }
    
}
