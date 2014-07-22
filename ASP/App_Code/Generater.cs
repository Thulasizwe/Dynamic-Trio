using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

using DevExpress.Web.ASPxEditors;
using DevExpress.Web.ASPxGridView;

/// <summary>
/// Summary description for Generater
/// </summary>
public class Generater
{
    #region Singleton ----------------------------------------------        
        /// <summary>
        /// This is a private constructor, meaning no outsiders have access.
        /// </summary>
        private Generater()
        {
            // Initialize members, etc. here or use the lazy creation technique
        }

        /// <summary>
        /// Access SiteStructure.Instance to get the singleton object.
        /// Then call methods on that instance.
        /// </summary>
        public static Generater Instance
        {
            get { return _Generater; }
        }
        private static Generater _Generater = new Generater();

        #endregion Singleton ----------------------------------------------


    //public Generater()
    //{
    //    //
    //    // TODO: Add constructor logic here
    //    //
    //}

    public class GenerateGridParams
    {
        private string _caption;
        private string _fieldName;
        private bool _visible;
        private int _width;
        private int _index;

        public GenerateGridParams(string fieldName)
        {
           
            _fieldName = fieldName;
            _caption = fieldName;
            _visible = true;
            _width = 100;
            _index = 0;

        }

        public string Caption
        {
            get { return _caption; }

            set { _caption = value; }

        }

        public string FieldName
        {
            get { return _fieldName; }

        }

        public bool Visible
        {
            get { return _visible; }
            set { _visible = value; }
        }

        public int Width
        {
            get { return _width; }
            set { _width = value; }
        }
        public int Index
        {
            get { return _index; }
            set { _index = value; }
        }
    }

    public void GenerateGrid(ASPxGridView grid, GenerateGridParams generateGridParams)
    {
        //if (sender == null) return;

        //var grid = sender as ASPxGridView;
        //if (grid == null) return;

        //var grid = ((ASPxGridView)sender);
        var fieldname = grid.Columns[generateGridParams.FieldName];
        fieldname.Visible = generateGridParams.Visible;
        fieldname.Width = generateGridParams.Width;
        fieldname.Caption = generateGridParams.Caption;
        fieldname.Index = generateGridParams.Index;
    }
    

    public void BindCombo(DropDownList combo, DataTable Table, string keyValue, string displayValue)
    {
        if(Table == null) return;

        combo.DataSource = Table;
        combo.DataValueField = keyValue;
        combo.DataTextField = displayValue;
        combo.DataBind();
    }

    public void BindCombo(DropDownList combo, string Table, string keyValue, string displayValue)
    {
        DAL_ DAL = DAL_.Instance;
        BindCombo(combo,DAL.Key.DbData.DataTable.Get(Table),keyValue,displayValue);
    }

    public void Setup(ASPxGridView gridView, DataTable table)
    {
        if (table == null) return;

        gridView.DataSource = table;
        gridView.DataBind();
    }

    public void GridColDesign(ASPxGridView gridView, string fieldName, string Caption, int Width , int Index, bool isVisible)
    {
       GenerateGridParams GridSetup;
       GridSetup = new GenerateGridParams(fieldName);
       GridSetup.Caption = Caption;
       GridSetup.Width = Width;
       GridSetup.Visible = isVisible;
       GridSetup.Index = Index;
       gridView.cxGenerateGrid(GridSetup);
    }
}

public static class statMeth
{
    public static void cxBindCombo(this DropDownList combo, DataTable Table, string keyValue, string displayValue)
    {
        Generater.Instance.BindCombo( combo,  Table,  keyValue,  displayValue);
    }

    public static void cxGenerateGrid(this ASPxGridView grid, Generater.GenerateGridParams generateGridParams )
    {
        Generater.Instance.GenerateGrid(grid, generateGridParams);
    }

    public static void cxGridSetup(this ASPxGridView gridView, DataTable table)
    {
        Generater.Instance.Setup(gridView,table);
    }

    public static void cxGridColDesign(this ASPxGridView gridView, string fieldName, string Caption, int Width = 100, int Index=-1, bool Visible = true)
    {
        Generater.Instance.GridColDesign(gridView, fieldName, Caption, Width, Index, Visible);
    }
}