using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public class gridData
{
    public gridData()
    {
        
    }
    private string[] cHideNames;
    private int[] cHideNum;
    private string _Heading;
    private bool _hideNames = true;

    public event EventHandler fireChangeEvent;
    public event EventHandler OnNoDataBasedChangeEvent;
    private DataTable dt;

    public string[] ColumnNames
    {
        get
        {
            return cHideNames;
        }
        set
        {
            cHideNames = value;
            if (this.fireChangeEvent != null)
            {
                this.fireChangeEvent(new object(), new EventArgs());
            }
        }
    }
    public int[] ColumnNumbers
    {
        get
        {
            return cHideNum;
        }
        set
        {
            cHideNum = value;
            if (this.fireChangeEvent != null)
            {
                this.fireChangeEvent(new object(), new EventArgs());
            }
        }
    }
    public DataTable theDataTable
    {
        get
        {
            return dt;
        }
        set
        {
            dt = value;
            if (this.fireChangeEvent != null)
            {
                this.fireChangeEvent(new object(), new EventArgs());
            }
        }
    }

    public string Heading
    {
        get
        {
            return _Heading;
        }
        set
        {
            _Heading = value;
            if (this.OnNoDataBasedChangeEvent != null)
            {
                this.OnNoDataBasedChangeEvent(new object(), new EventArgs());
            }
        }
    }

    public bool HideGivenValues
    {
        get
        {
            return _hideNames;
        }
        set
        {
            _hideNames = value;
            if (this.fireChangeEvent != null)
            {
                this.fireChangeEvent(new object(), new EventArgs());
            }
        }
    }


    //private void fireChangeEvent(object sender, EventArgs e)
    //{
    //    //GetDataFromSession(this, null);
    //}
}
public partial class gridDisplay : System.Web.UI.UserControl
{
    //private string gData; // The Name of the session (datagridName)
    public gridData thisGridsData = new gridData();
    //public struct sessionDataT
    //{
    //    // Any One of the folowing or both (hides given columns)
       
    //    public string[] ColumnNames;
    //    public int[] ColumnNumbers;

    //    public DataTable theDataTable;

        
    //}

    //public sessionDataT GridDisplayData;
    //public string sessionName
    //{
    //    get
    //    {
    //        return ("GridControl" + gData);
    //    }
    //    set
    //    {
    //        gData = value;
    //    }
    //}
    
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void HeadingChanged_Event(object sender, EventArgs e)
    {
        GVData.Caption = thisGridsData.Heading;
    }

    protected void GetDataFromSession(object sender, EventArgs e)
    {
        if (thisGridsData.theDataTable != null)
        {
            GVData.DataSource = thisGridsData.theDataTable;
            GVData.DataBind();
            foreach (var column in GVData.DataColumns)
            {
                column.Visible = (thisGridsData.HideGivenValues);
                bool found = false;
                if (thisGridsData.ColumnNumbers != null) foreach (var VisibleNumbers in thisGridsData.ColumnNumbers)
                {
                    if (column.Index == VisibleNumbers)
                    {
                        column.Visible = (!thisGridsData.HideGivenValues);
                        found = true;
                        break;
                    }
                }
                if (found) continue;
                if (thisGridsData.ColumnNames != null) foreach (var VisibleNames in thisGridsData.ColumnNames)
                {
                    if (String.Equals((column.FieldName), VisibleNames, StringComparison.CurrentCultureIgnoreCase))
                    {
                        column.Visible = (!thisGridsData.HideGivenValues);
                        break;
                    }
                }
            }
        }
    }

    protected void InitEvents(object sender, EventArgs e)
    {
        thisGridsData.fireChangeEvent -= GetDataFromSession;
        thisGridsData.fireChangeEvent += GetDataFromSession;

        thisGridsData.OnNoDataBasedChangeEvent -= HeadingChanged_Event;
        thisGridsData.OnNoDataBasedChangeEvent += HeadingChanged_Event;

        GetDataFromSession(this, e);
    }
}