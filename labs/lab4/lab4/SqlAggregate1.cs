using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedAggregate(Format.Native)]
public struct SqlAggregate1
{
    private int sum;

    public void Init()
    {
        sum = 0;
    }

    public void Accumulate(SqlInt32 Value)
    {
        sum += (int)Value;
    }

    public void Merge (SqlAggregate1 Group)
    {
        sum += Group.sum;
    }

    public SqlInt32 Terminate ()
    {
        return new SqlInt32(sum);
    }

    #region IBinarySerialize Members

    public void Read(System.IO.BinaryReader r)
    {
        sum = r.ReadInt32();
    }

    public void Write(System.IO.BinaryWriter w)
    {
        w.Write(sum);
    }

    #endregion
}
