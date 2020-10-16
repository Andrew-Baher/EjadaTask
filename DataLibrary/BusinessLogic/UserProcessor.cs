using DataLibrary.DataAcess;
using DataLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace DataLibrary.BusinessLogic
{
    public static class UserProcessor
    {
        public static int CreateUser(string name,
            string email, string password)
        {
            //Create the salt value with a cryptographic PRNG
            byte[] salt;
            new RNGCryptoServiceProvider().GetBytes(salt = new byte[16]);
            //Create the Rfc2898DeriveBytes and get the hash value
            var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 100000);
            byte[] hash = pbkdf2.GetBytes(20);
            //Combine the salt and password bytes for later use
            byte[] hashBytes = new byte[36];
            Array.Copy(salt, 0, hashBytes, 0, 16);
            Array.Copy(hash, 0, hashBytes, 16, 20);
            //Turn the combined salt+hash into a string for storage
            string savedPasswordHash = Convert.ToBase64String(hashBytes);

            //Create new user with hashed password
            UserModel data = new UserModel
            {
                UserName = name,
                UserEmail = email,
                UserPassword = savedPasswordHash
            };

            string sql = @"insert into dbo.[User] ([Name], [Email], [Password])
                           values (@UserName, @UserEmail, @UserPassword);";

            return SqlDataAccess.SaveData(sql, data);
        }

        public static bool CheckUserPassword(string email,string password)
        {
            // checks if user password is right
            string sql = $"select [Password] from dbo.[User] where Email = '{email}';";
            string savedPasswordHash = SqlDataAccess.LoadData<String>(sql)[0];
            // Extract the bytes 
            byte[] hashBytes = Convert.FromBase64String(savedPasswordHash);
            // Get the salt 
            byte[] salt = new byte[16];
            Array.Copy(hashBytes, 0, salt, 0, 16);
            // Compute the hash on the password the user entered 
            var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 100000);
            byte[] hash = pbkdf2.GetBytes(20);
            // Compare the results 
            for (int i = 0; i < 20; i++)
                if (hashBytes[i + 16] != hash[i])
                    return false;
            return true;
        }
    }
}
