using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json.Linq;


public partial class _Default : System.Web.UI.Page
{
    string SQL_S = Environment.GetEnvironmentVariable("SQL_S");
    string SQL_U = Environment.GetEnvironmentVariable("SQL_U");
    string SQL_P = Environment.GetEnvironmentVariable("SQL_P");
    string SQL_DB = Environment.GetEnvironmentVariable("SQL_P");


    protected void Page_Load(object sender, EventArgs e)
    {
        gv_swapi_vehicles.Visible = false;
    }

    protected void getVehicles(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(@"Data Source="+ SQL_S + ";Initial Catalog="+ SQL_DB + ";Persist Security Info=True;User ID="+ SQL_U + ";Password="+ SQL_P);
        SqlCommand cmd = new SqlCommand("SELECT NAME, MODEL, cost_in_credits, length, max_atmosphering_speed, crew, passengers, cargo_capacity, consumables, vehicle_class, url FROM SWAPI_VEHICLES", con);
        string query = "";

        JObject jObject = null;
        JToken jentities = null;

        try
        {
            jObject = JObject.Parse(call_swapi());
            jentities = jObject["results"];

            int count = 0;
            foreach (JToken element in jentities)
            {
                query = @"IF NOT EXISTS (SELECT * FROM SWAPI_VEHICLES WHERE URL = '" + jentities[count]["url"].ToString() + @"')
                        BEGIN
                        ";
                query += "INSERT INTO SWAPI_VEHICLES (NAME, MODEL, cost_in_credits, length, max_atmosphering_speed, crew, passengers, cargo_capacity, consumables, vehicle_class, url)";
                query += " VALUES (@NAME, @MODEL, @cost_in_credits, @length, @max_atmosphering_speed, @crew, @passengers, @cargo_capacity, @consumables, @vehicle_class, @url)";

                query = query.Replace("@NAME", "'" + jentities[count]["name"].ToString() + "'");
                query = query.Replace("@MODEL", "'" + jentities[count]["model"].ToString() + "'");
                query = query.Replace("@cost_in_credits", "'" + jentities[count]["cost_in_credits"].ToString() + "'");
                query = query.Replace("@length", "'" + jentities[count]["length"].ToString() + "'");
                query = query.Replace("@max_atmosphering_speed", "'" + jentities[count]["max_atmosphering_speed"].ToString() + "'");
                query = query.Replace("@crew", "'" + jentities[count]["crew"].ToString() + "'");
                query = query.Replace("@passengers", "'" + jentities[count]["passengers"].ToString() + "'");
                query = query.Replace("@cargo_capacity", "'" + jentities[count]["cargo_capacity"].ToString() + "'");
                query = query.Replace("@consumables", "'" + jentities[count]["consumables"].ToString() + "'");
                query = query.Replace("@vehicle_class", "'" + jentities[count]["vehicle_class"].ToString() + "'");
                query = query.Replace("@url", "'" + jentities[count]["url"].ToString() + "'");

                query += " END;";
                SqlCommand insert_CMD = new SqlCommand(query, con);
                con.Open();
                insert_CMD.ExecuteNonQuery();
                con.Close();
                count++;
            }

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            gv_swapi_vehicles.DataSource = ds;
            gv_swapi_vehicles.DataBind();
            gv_swapi_vehicles.Visible = true;

        }
        catch (Exception)
        {
            lb_error.Text = "Error fetching data from source: <a href=\"https://swapi.co/api/vehicles/\"";
        }  
    }
    
    public string call_swapi()
    {
        string url = "https://swapi.co/api/vehicles/";
        var client = new WebClient();
        //client.Headers.Add(RequestConstants.UserAgent, RequestConstants.UserAgentValue);
        var response = "";
        try
        {
            response = client.DownloadString(url);
        }
        catch (Exception)
        {
            response = "Error in: " + url;
        }
        return response;
    }
}