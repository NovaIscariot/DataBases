using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;


namespace HandWrittenUDF
{
    public class UserDefinedFunctions
    {
        [Microsoft.SqlServer.Server.SqlFunction]
        public static SqlInt32 GetDate(SqlDateTime tb, SqlDateTime te)
        {
            TimeSpan tmp = ((DateTime)te) - ((DateTime)tb);
            return (SqlInt32)(tmp.TotalMinutes);
        }
    }
}
