using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace DataLibrary.DataAcess
{
    public static class SqlDataAccess
    {
        public static string GetConnectionString(string connectionName = "EjadaDB")
        {
            //Get current connection string to connect with database
            return ConfigurationManager.ConnectionStrings[connectionName].ConnectionString;
        }

        public static List<T> LoadData<T>(string sql)
        {
            using (IDbConnection cnn = new SqlConnection(GetConnectionString()))
            {
                //Load data from query
                return cnn.Query<T>(sql).ToList();
            }
        }

        public static int SaveData<T>(string sql, T data)
        {
            using (IDbConnection cnn = new SqlConnection(GetConnectionString()))
            {
                //save data to query
                return cnn.Execute(sql, data);
            }
        }

        public static int ExecuteQuey(string sql)
        {
            using (IDbConnection cnn = new SqlConnection(GetConnectionString()))
            {
                //Executes current query
                return cnn.Execute(sql);
            }
        }
    }
}
