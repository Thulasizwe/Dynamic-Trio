using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GenerateLeagues : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void generate()
    {
        /* Code to generate fixtures but still work in progress
         
        string[] inputSet = { "ManU", "Arse", "Chels", "Lvpool" };
        Variations<string> variations = new Variations<string>(inputSet, 2);
        string vformat = "Variations of {{A B C D}} choose 2: size = {0}";
        Console.WriteLine(String.Format(vformat, variations.Count));
        foreach (IList<char> v in variations)
        {
            Console.WriteLine(String.Format("{{{0} {1}}}", v[0], v[1]));
        }
        */
    }
}