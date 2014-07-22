using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DevExpress.Web.ASPxGridView;


public partial class Default2 : System.Web.UI.Page
{
    private DAL_ DAL = DAL_.Instance;
    protected void Page_Load(object sender, EventArgs e)
    {
        ASPxGridView1.cxGridSetup(DAL.Key.DbData.DataTable.Get_FromSP("sp_LoadIndustry", "sp_LoadIndustry", true));
        ASPxGridView1.cxGridColDesign("ID","PrimaryKey",200,0);
    }

   protected void SaveIndusrty(object sender, EventArgs e)
    {
        DAL.Key.DbData.SP_Execute("AddIndusrty", new object[] { txtIndustry.Text});

        ASPxGridView1.cxGridSetup(DAL.Key.DbData.DataTable.Get_FromSP("sp_LoadIndustry", "sp_LoadIndustry", true));
        ASPxGridView1.cxGridColDesign("ID", "PrimaryKey", 200, 0);
        popup.ShowOnPageLoad = false;
    }
    protected void SaveCompany(object sender, EventArgs e)
    {
        if (ddlIndustry.SelectedValue != "")
        {
            DAL.Key.DbData.SP_Execute("AddCompany", new object[] {ddlIndustry.SelectedValue, txtCompany.Text});
            ASPxGridView1.cxGridSetup(DAL.Key.DbData.DataTable.Get_FromSP("sp_LoadIndustry", "sp_LoadIndustry", true));
            ASPxGridView1.cxGridColDesign("ID", "PrimaryKey", 200, 0);
            popcomp.ShowOnPageLoad = false;
        }
    }

    protected void AddNewSite(object sender, EventArgs e)
    {
        
        if (ddlComany.SelectedValue != "")
        {
            DAL.Key.DbData.SP_Execute("AddSite", new object[] {ddlComany.SelectedValue, txtSite.Text});
            ASPxGridView1.cxGridSetup(DAL.Key.DbData.DataTable.Get_FromSP("sp_LoadIndustry", "sp_LoadIndustry", true));
            ASPxGridView1.cxGridColDesign("ID", "PrimaryKey", 200, 0);
            popsite.ShowOnPageLoad = false;
        }
    }
    protected void AddNewDep(object sender, EventArgs e)
    {
        DAL.Key.DbData.SP_Execute("AddDepartment", new object[] {ddldepsite.SelectedValue, txtDepartment.Text });
        ASPxGridView1.cxGridSetup(DAL.Key.DbData.DataTable.Get_FromSP("sp_LoadIndustry", "sp_LoadIndustry", true));
        ASPxGridView1.cxGridColDesign("ID", "PrimaryKey", 200, 0);
        popdepa.ShowOnPageLoad = false;
    }
   
    protected void edtindssave_Click(object sender, EventArgs e)
    {
        DAL.Key.DbData.SP_Execute("EditIndustry", new object[] { ddlEditind.SelectedValue, txteditind.Text });

        Response.Redirect("admindustry.aspx");
    }
    protected void EditIndustry_Click(object sender, EventArgs e)
    {
        ddlEditind.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterIndustrySp", "FilterIndustrySp", true), "IDIndustry", "Industry");
       
        txteditind.Text = ddlEditind.SelectedItem.Text;
    }
    protected void ddlEditind_SelectedIndexChanged(object sender, EventArgs e)
    {
        txteditind.Text = ddlEditind.SelectedItem.Text;
    }
    protected void EditCompany_Click(object sender, EventArgs e)
    {
        ddledtCom.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterCompanySp", "FilterCompanySp", true), "IDCompany", "Company");
        ddlcind.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterIndustrySp", "FilterIndustrySp", true), "IDIndustry", "Industry");
        txtedtCom.Text = ddledtCom.SelectedItem.Text;
    }
    protected void ddledtCom_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtedtCom.Text = ddledtCom.SelectedItem.Text;
    }
    protected void svedtcom_Click(object sender, EventArgs e)
    {
        bool flag;
        if (cIndus.Checked)
        {
            flag = true;
        }
        else
        {
            flag = false;
        }
        DAL.Key.DbData.SP_Execute("EditComapny", new object[] { ddledtCom.SelectedValue, txtedtCom.Text, flag, ddlcind.SelectedValue});

        Response.Redirect("admindustry.aspx");
    }
    protected void btnsaveSite_Click(object sender, EventArgs e)
    {
        
        bool flag;
         if (cbSite.Checked)
        {
            flag = true;
        }
        else
        {
            flag = false;
        }
         DAL.Key.DbData.SP_Execute("EditSite", new object[] { ddleditSite.SelectedValue, txtedSite.Text, flag, ddlCComp.SelectedValue });

        Response.Redirect("admindustry.aspx");
    }
    protected void ddleditSite_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtedSite.Text = ddleditSite.SelectedItem.Text;
    }
    protected void EditSite_Click(object sender, EventArgs e)
    {

        ddleditcomp.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterCompanySp", "FilterCompanySp", true), "IDCompany", "Company");
        ddleditSite.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", true, "", new object[] { ddleditcomp.SelectedValue }), "IDSite", "Site");
        ddlCComp.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterCompanySp", "FilterCompanySp", true), "IDCompany", "Company");
        txtedSite.Text = ddleditSite.SelectedItem.Text;
    }
    protected void ddleditcomp_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddleditSite.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", true, "", new object[] { ddleditcomp.SelectedValue }), "IDSite", "Site");
        txtedSite.Text = ddleditSite.SelectedItem.Text;
    }
    protected void EditDepartment_Click(object sender, EventArgs e)
    {


        DataRow currentRow = ASPxGridView1.GetDataRow(ASPxGridView1.FocusedRowIndex);
        string Company = currentRow[2].ToString();
        string site = currentRow[3].ToString();
        string Dep = currentRow[4].ToString();

        ddldepcompedit.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("sp_GetDepartments", "GetDepartments", true, "", new object[] { Company, site, Dep }), "IDCompany", "Company");
        ddlsiteEdit.cxBindCombo(DAL.Key.DbData.DataTable.Get("GetDepartments"), "IDSite", "Site");
        ddlEditDep.cxBindCombo(DAL.Key.DbData.DataTable.Get("GetDepartments"), "IDDepartment", "Department");
        txtDep.Text = ddlEditDep.SelectedItem.Text;
        ddlCsite.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", true, "", new object[] { ddldepcompedit.SelectedValue }), "IDSite", "Site");
  
      }
   
   
    
    protected void depSAve_Click(object sender, EventArgs e)
    {
        bool flag;
        if (cbDep.Checked)
        {
            flag = true;
        }
        else
        {
            flag = false;
        }
        DAL.Key.DbData.SP_Execute("EditDep", new object[] { ddlEditDep.SelectedValue, txtDep.Text, flag, ddlCsite.SelectedValue });

        Response.Redirect("admindustry.aspx");
    }
    protected void DeleteIndustry_Click(object sender, EventArgs e)
    {
        ddldeleteind.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterIndustrySp", "FilterIndustrySp", true), "IDIndustry", "Industry");
   }
    protected void btndelteind_Click(object sender, EventArgs e)
    {
        DAL.Key.DbData.SP_Execute("sp_DeleteIndustry", new object[] { ddldeleteind.SelectedValue });

        Response.Redirect("admindustry.aspx");
    }
    protected void DeleteCompany_Click(object sender, EventArgs e)
    {

        ddldelcomp.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterCompanySp", "FilterCompanySp", true), "IDCompany", "Company");
       
    }
   
    protected void deletecomp_Click(object sender, EventArgs e)
    {
        DAL.Key.DbData.SP_Execute("sp_DeleteCompany", new object[] { ddldelcomp.SelectedValue });

        Response.Redirect("admindustry.aspx");
    }

    protected void DeleteSitesse_Click(object sender, EventArgs e)
    {
        DAL.Key.DbData.SP_Execute("sp_DeleteSite", new object[] { ddldelsite.SelectedValue });

        Response.Redirect("admindustry.aspx");
    }

    

    protected void ddldelcoms_SelectedIndexChanged(object sender, EventArgs e)
    {

        ddldelsite.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", true, "", new object[] { ddldelcoms.SelectedValue }), "IDSite", "Site");
       
    }
    protected void DeleteSite_Click(object sender, EventArgs e)
    {
        ddldelcoms.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterCompanySp", "FilterCompanySp", true), "IDCompany", "Company");
        ddldelsite.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("FilterSiteSp", "FilterSiteSp", true, "", new object[] { ddldelcoms.SelectedValue }), "IDSite", "Site");
    }
    protected void DeleteDepartment_Click(object sender, EventArgs e)
    {
        DataRow currentRow = ASPxGridView1.GetDataRow(ASPxGridView1.FocusedRowIndex);
        string Company = currentRow[2].ToString();
        string site = currentRow[3].ToString();
        string Dep = currentRow[4].ToString();
        ddlselcomp.cxBindCombo(DAL.Key.DbData.DataTable.Get_FromSP("sp_GetDepartments", "GetDepartments", true, "", new object[] { Company, site, Dep }), "IDCompany", "Company");
        ddlselsite.cxBindCombo(DAL.Key.DbData.DataTable.Get("GetDepartments"), "IDSite", "Site");
        ddlseldep.cxBindCombo(DAL.Key.DbData.DataTable.Get("GetDepartments"), "IDDepartment", "Department");


 
    

        
       
    }
    protected void btndeldep_Click(object sender, EventArgs e)
    {
        DAL.Key.DbData.SP_Execute("sp_DeleteDept", new object[] { ddlseldep.SelectedValue });

        Response.Redirect("admindustry.aspx");

    }
    protected void AddIndustry_Click(object sender, EventArgs e)
    {

    }
}

