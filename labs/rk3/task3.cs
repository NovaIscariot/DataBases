using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    private class MinCalary
    {
        public SqlInt32 Calary;
        public SqlString Spec;

        public MinCalary(SqlString tSpec, SqlInt32 tCalary)
        {
            Spec = tSpec;
            Calary = tCalary;
        }
    }
    [SqlFunction(DataAccess = DataAccessKind.Read, FillRowMethodName = "FillRow",
        TableDefinition = "Spec nchar(40), Calary int")]
    public static IEnumerable SqlTableFunction1()
    {
        ArrayList result = new ArrayList();

        using (SqlConnection connection = new SqlConnection("context connection=true"))
        {
            connection.Open();
            using (SqlCommand selectRows = new SqlCommand(
            "SELECT [Spec], MIN([Calary]) AS MinCalary FROM [Job]" +
            "GROUP BY [Spec]",
            connection))
            {
                using (SqlDataReader countReader = selectRows.ExecuteReader())
                {
                    while (countReader.Read())
                    {
                        result.Add(new MinCalary(
                        countReader.GetSqlString(0),
                        countReader.GetSqlInt32(1)));
                    }
                }
            }
        }
        return result;
    }

    public static void FillRow(object countResultObj, out SqlString Spec, out SqlInt32 Calary)
    {
        MinCalary tmp = (MinCalary)countResultObj;

        Spec = tmp.Spec;
        Calary = tmp.Calary;
    }
}
