using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }

    [WebMethod]
    [ScriptMethod]
    public static string Registration(int PhoneNumber, string FirstName, string LastName, string month, string date, string year, string gender, string email)
    {
        string result = "";
        string connstring = ConfigurationManager.ConnectionStrings["ConnString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connstring))
        {
            using (SqlCommand cmd = new SqlCommand("SP_SaveRegistration", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@PhoneNumber", SqlDbType.Int).Value = PhoneNumber;
                cmd.Parameters.Add("@FirstName", SqlDbType.Int).Value = FirstName;
                cmd.Parameters.Add("@LastName", SqlDbType.Int).Value = LastName;
                cmd.Parameters.Add("@DateofBirth", SqlDbType.Date).Value = Convert.ToDateTime(year + '-' + month + '-' + date);
                cmd.Parameters.Add("@Gender ", SqlDbType.VarChar).Value = gender;
                cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = PhoneNumber;
                cmd.Parameters.Add("@CreatedDate", SqlDbType.DateTime).Value = Convert.ToDateTime(DateTime.Now);

                var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;

                cmd.CommandTimeout = 500;
                con.Open();
                cmd.ExecuteNonQuery();
                int i = (int)returnParameter.Value;
                con.Close();
                if (i == 1)
                {
                    result = "success";
                }
                return result;
            }
        }
    }
}