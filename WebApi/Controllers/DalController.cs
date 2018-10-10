using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using WebApi.Models;

namespace WebApi.Controllers
{
    public class DalController : ApiController
    {
        //ado.net
        public string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        public DataTable GetDataTable(string spName, List<SqlParameter> sqlParams = null)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {

                    SqlCommand cmd = new SqlCommand(spName, conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (sqlParams != null)
                    {
                        foreach (SqlParameter param in sqlParams)
                        {
                            cmd.Parameters.Add(param);
                        }
                    }

                    SqlDataAdapter dad = new SqlDataAdapter(cmd);
                    DataSet dst = new DataSet();
                    dad.Fill(dst);
                    return dst.Tables[0];
                }
            }
            catch (Exception ex)
            {
                return null;
            }

        }
        public HttpResponseMessage GetCategories()
        {
            DataTable dtbl = GetDataTable("spGetCategories");
            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, dtbl);

            return response;

        }

        public HttpResponseMessage GetProductsByCategoryID(int id)
        {
            List<SqlParameter> sqlParams = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();
            param.ParameterName = "@CategoryID";
            param.SqlDbType = SqlDbType.Int;
            param.Value = id;

            sqlParams.Add(param);

            DataTable dtbl = GetDataTable("spGetProductsByCategoryID", sqlParams);
            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, dtbl);

            return response;

        }

        //entity framework
        public HttpResponseMessage GetProducts()
        {
            using (NorthwindEntities context = new NorthwindEntities())
            {
                List<Product> products = context.Products.ToList();

                HttpResponseMessage reponse = Request.CreateResponse(HttpStatusCode.OK, products);

                return reponse;
            }
        }
        public HttpResponseMessage GetProductByProductID(int id)
        {
            using (NorthwindEntities contex = new NorthwindEntities())
            {
                Product product = contex.Products.Where(p => p.ProductID == id).FirstOrDefault();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, product);
                return response;
            }
        }

        [HttpPost]
        [HttpOptions]
        public int AddToCart([FromBody] Cart cart)
        {
            if (cart != null)
            {
                using (NorthwindEntities context = new NorthwindEntities())
                {
                    Cart cartDB = context.Carts
                        .Where(c => c.Username == cart.Username && c.ProductID == cart.ProductID)
                        .FirstOrDefault();

                    if (cartDB == null)
                    {
                        context.Carts.Add(cart);
                    }
                    else
                    {
                        cartDB.Quantity += cart.Quantity;
                    }

                    context.SaveChanges();

                    int count = context.Carts
                        .Where(c => c.Username == cart.Username)
                        .Sum(c => c.Quantity);

                    return count;
                }           

            }
            else
            {
                return -1;
            }
        }
    }
}
