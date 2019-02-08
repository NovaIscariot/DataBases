using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;


public partial class StoredProcedures
{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void SqlStoredProcedure1 ()
    {
        using (SqlConnection contextConnection = new SqlConnection("context connection = true"))
        {
            SqlCommand contextCommand =
               new SqlCommand(
               "Select AVG(age) from CourierTable ", contextConnection);

            contextConnection.Open();

            SqlContext.Pipe.ExecuteAndSend(contextCommand);
        }
    }
}