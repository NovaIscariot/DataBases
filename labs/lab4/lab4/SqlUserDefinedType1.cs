using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Text;
using Microsoft.SqlServer.Server;

[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedType(Format.Native)]
public struct SqlUserDefinedType1 : INullable
{
    private bool isNull;
    private Int32 _Did;
    private Int32 _Cid;

    public bool IsNull
    {
        get
        {
            return isNull;
        }
    }

    public static SqlUserDefinedType1 Null
    {
        get
        {
            SqlUserDefinedType1 Delivery = new SqlUserDefinedType1();
            Delivery.isNull = true;
            return Delivery;
        }
    }

    public override string ToString()
    {
        if (this.isNull)
            return "NULL";
        else
        {
            StringBuilder builder = new StringBuilder();
            builder.Append(Did);
            builder.Append(", ");
            builder.Append(Cid);
            return builder.ToString();
        }
    }

    [SqlMethod(OnNullCall = false)]
    public static SqlUserDefinedType1 Parse(SqlString s)
    {
        if (s.IsNull)
            return Null;

        SqlUserDefinedType1 Delivery = new SqlUserDefinedType1();
        string[] tmp = s.Value.Split(",".ToCharArray());
        Delivery._Did = Int32.Parse(tmp[0]);
        Delivery._Cid = Int32.Parse(tmp[1]);

        return Delivery;
    }
    public Int32 Did
    {
        get
        {
            return this._Did;
        }

        set
        {
            _Did = value;
        }
    }

    public Int32 Cid
    {
        get
        {
            return this._Cid;
        }

        set
        {
            _Cid = value;
        }
    }
}