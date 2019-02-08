using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;

public partial class Triggers
{
    // Введите существующую таблицу или представление для целевого объекта и раскомментируйте строку атрибута.
    [Microsoft.SqlServer.Server.SqlTrigger (Name="SqlTrigger1", Target="CourierTable", Event="FOR UPDATE")]
    public static void SqlTrigger1()
    {
        SqlTriggerContext triggerContext = SqlContext.TriggerContext;

        if (triggerContext.TriggerAction == TriggerAction.Delete)
            SqlContext.Pipe.Send("Failed! Deletion is aborted.");
    }
}

