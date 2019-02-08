using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace Lab8
{
    class Tasks
    {
        private readonly string connectionString = @"server = DESKTOP-9C01EOF\SQLEXPRESS; Database = myDb; Integrated Security = true";

        static void Main(string[] args)
        {
            Tasks solution = new Tasks();
            
            solution.connectedObjects_task_1_ConnectionString();
            solution.connectedObjects_task_2_SimpleScalarSelection();
            solution.connectedObjects_task_3_SqlCommand_SqlDataReader();
            solution.connectedObjects_task_4_SqlCommandWithParameters();
            solution.connectedObjects_task_5_SqlCommand_StoredProcedure();
            solution.disconnectedObjects_task_6_DataSetFromTable();
            solution.disconnectedObjects_task_7_FilterSort();
            solution.disconnectedObjects_8_Insert();
            solution.disconnectedObjects_9_Delete();
            solution.disconnectedObjects_10_Xml();
        }

        public void connectedObjects_task_1_ConnectionString()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 1, "[Connected] Shows connection info.");

            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.");
                Console.WriteLine("Connection properties:");
                Console.WriteLine("\tConnection string: {0}", connection.ConnectionString);
                Console.WriteLine("\tDatabase:          {0}", connection.Database);
                Console.WriteLine("\tData Source:       {0}", connection.DataSource);
                Console.WriteLine("\tServer version:    {0}", connection.ServerVersion);
                Console.WriteLine("\tConnection state:  {0}", connection.State);
                Console.WriteLine("\tWorkstation id:    {0}", connection.WorkstationId);
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the connection creating. Message: " + e.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        public void connectedObjects_task_2_SimpleScalarSelection()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 2, "[Connected] Simple scalar query.");

            string queryString = @"select Count(*) from CourierTable where CurrentDelivery is NULL";
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand scalarQueryCommand = new SqlCommand(queryString, connection);
            Console.WriteLine("Sql command \"{0}\" has been created.", queryString);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.");
                Console.WriteLine("-------->>> Number of free couriers is {0}", scalarQueryCommand.ExecuteScalar());
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql command execution. Message: " + e.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        public void connectedObjects_task_3_SqlCommand_SqlDataReader()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 3, "[Connected] DataReader for query.");

            string queryString = @"select Name, Age from CourierTable where Experience > 0";
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand dataQueryCommand = new SqlCommand(queryString, connection);
            Console.WriteLine("Sql command \"{0}\" has been created.", queryString);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.");
                SqlDataReader dataReader = dataQueryCommand.ExecuteReader();

                Console.WriteLine("-------->>> Couriers with not null experience: ");
                while (dataReader.Read())
                {
                    Console.WriteLine("\t{0} {1}", dataReader.GetValue(0), dataReader.GetValue(1));
                }
                Console.WriteLine("-------->>> <<<-------");
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql command execution. Message: " + e.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        public void connectedObjects_task_4_SqlCommandWithParameters()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 4, "[Connected] SqlCommand (Insert, Delete).");

            string countQueryString = @"select count(*) from CourierTable go";
            string insertQueryString = @"insert into CourierTable(ID, Name, Age, Experience) values (@id, @name, @age, @experience)";
            string deleteQueryString = @"delete from CourierTable where Name = @name";

            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand countQueryCommand = new SqlCommand(countQueryString, connection);
            SqlCommand insertQueryCommand = new SqlCommand(insertQueryString, connection);
            SqlCommand deleteQueryCommand = new SqlCommand(deleteQueryString, connection);

            //parameters
            insertQueryCommand.Parameters.Add("@id", SqlDbType.Int);
            insertQueryCommand.Parameters.Add("@name", SqlDbType.NVarChar,50);
            insertQueryCommand.Parameters.Add("@age", SqlDbType.Int);
            insertQueryCommand.Parameters.Add("@experience", SqlDbType.NVarChar, 6);
            deleteQueryCommand.Parameters.Add("@name", SqlDbType.NVarChar, 50);

            Console.WriteLine("Sql commands: \n1) \"{0}\"\n\n2) \"{1}\"\n\n3) \"{2}\"\n\nhas been created.\n", countQueryString, insertQueryString, deleteQueryString);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.\n");
                Console.WriteLine("Current count of couriers: {0}\n", countQueryCommand.ExecuteScalar());
                Console.WriteLine("Inserting a new courier. Input: ");
                Console.Write("- id = ");
                int id = Convert.ToInt32(Console.ReadLine());
                Console.Write("- name = ");
                string name = Console.ReadLine();
                Console.Write("- age = ");
                int age = Convert.ToInt32(Console.ReadLine());
                Console.Write("- experience = ");
                string experience = Console.ReadLine();


                insertQueryCommand.Parameters["@id"].Value = id;
                insertQueryCommand.Parameters["@name"].Value = name;
                insertQueryCommand.Parameters["@age"].Value = age;
                insertQueryCommand.Parameters["@experience"].Value = experience;
                deleteQueryCommand.Parameters["@name"].Value = name;

                Console.WriteLine("\nInsert command: {0}", insertQueryCommand.CommandText);
                insertQueryCommand.ExecuteNonQuery();
                Console.WriteLine("------>>> New count of Couriers: {0}", countQueryCommand.ExecuteScalar());

                Console.WriteLine("Delete command: {0}", deleteQueryCommand.CommandText);
                deleteQueryCommand.ExecuteNonQuery();
                Console.WriteLine("------>>> New count of Couriers: {0}", countQueryCommand.ExecuteScalar());
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql command execution. Message: " + e.Message);
            }
            catch (FormatException ex)
            {
                Console.WriteLine("Bad input! " + ex.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        public void connectedObjects_task_5_SqlCommand_StoredProcedure()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 5, "[Connected] Stored procedure.");

            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand storedProcedureCommand = connection.CreateCommand();
            storedProcedureCommand.CommandType = CommandType.StoredProcedure;
            storedProcedureCommand.CommandText = "dbo.AverageAge";

            Console.WriteLine("Sql command \"{0}\" has been created.", storedProcedureCommand.CommandText);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.\n");
                
                var result = storedProcedureCommand.ExecuteScalar();
                Console.WriteLine("Average couriers age equals {0}", result);
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql command execution. Message: " + e.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        public void disconnectedObjects_task_6_DataSetFromTable()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 6, "[Disconnected] DataSet from the table.");

            string query = @"select Name, Experience, CurrentDelivery from CourierTable where Age > 30";

            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.");

                SqlDataAdapter dataAdapter = new SqlDataAdapter(query, connection);
                DataSet dataSet = new DataSet();
                dataAdapter.Fill(dataSet, "CourierTable");
                DataTable table = dataSet.Tables["CourierTable"];

                Console.WriteLine("Couriers with age more than 30:");
                foreach (DataRow row in table.Rows)
                {
                    Console.WriteLine("{0} {1} {2}", row["Name"], row["Experience"], row["CurrentDelivery"]);
                    Console.Write("");
                }
                Console.WriteLine();
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql query execution. Message: " + e.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        public void disconnectedObjects_task_7_FilterSort()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 7, "[Disconnected] Filter and sort.");

            string query = @"select * from CourierTable";
            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.");

                SqlDataAdapter dataAdapter = new SqlDataAdapter(query, connection);
                DataSet dataSet = new DataSet();
                dataAdapter.Fill(dataSet, "CourierTable");
                DataTableCollection tables = dataSet.Tables;

                Console.Write("Input part of couier Name: ");
                string partOfName = Console.ReadLine();
                Console.WriteLine();

                string filter = "Name like '%" + partOfName + "%'";
                string sort = "Name asc";
                Console.WriteLine("Couriers who have name like \"" + partOfName + "\":");
                foreach (DataRow row in tables["CourierTable"].Select(filter, sort))
                {
                    Console.Write("{0} ", row["Id"]);
                    Console.Write("{0} ", row["Name"]);
                    Console.WriteLine("{0} ", row["Age"]);
                }
                Console.WriteLine();
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql query execution. Message: " + e.Message);
            }
            catch (FormatException ex)
            {
                Console.WriteLine("Bad input! Message: " + ex.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        public void disconnectedObjects_8_Insert()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 8, "[Disconnected] Insert.");

            string dataCommand = @"select * from CourierTable";
            string insertQueryString = @"insert into CourierTable(ID, Name, Age, Experience) values (@id, @name, @age, @experience)";

            SqlConnection connection = new SqlConnection(connectionString);

            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.");

                Console.WriteLine("Inserting a new Courier. Input: ");
                Console.Write("- id = ");
                int id = Convert.ToInt32(Console.ReadLine());
                Console.Write("- name = ");
                string name = Console.ReadLine();
                Console.Write("- age = ");
                int age = Convert.ToInt32(Console.ReadLine());
                Console.Write("- experience = ");
                string experience = Console.ReadLine();

                SqlDataAdapter dataAdapter = new SqlDataAdapter(new SqlCommand(dataCommand, connection));
                DataSet dataSet = new DataSet();
                dataAdapter.Fill(dataSet, "CourierTable");
                DataTable table = dataSet.Tables["CourierTable"];

                DataRow insertingRow = table.NewRow();
                insertingRow["Id"] = id;
                insertingRow["Name"] = name;
                insertingRow["Age"] = age;
                insertingRow["Experience"] = experience;

                table.Rows.Add(insertingRow);

                Console.WriteLine("Couriers");
                foreach (DataRow row in table.Rows)
                {
                    Console.Write("{0} ", row["Id"]);
                    Console.Write("{0} ", row["Name"]);
                    Console.Write("{0} ", row["Age"]);
                    Console.Write("---- {0}\n", row["Experience"]);
                }

                SqlCommand insertQueryCommand = new SqlCommand(insertQueryString, connection);
                insertQueryCommand.Parameters.Add("@id", SqlDbType.Int);
                insertQueryCommand.Parameters.Add("@name", SqlDbType.NVarChar, 35);
                insertQueryCommand.Parameters.Add("@age", SqlDbType.Int);
                insertQueryCommand.Parameters.Add("@experience", SqlDbType.Int);

                insertQueryCommand.Parameters["@id"].Value = id;
                insertQueryCommand.Parameters["@name"].Value = name;
                insertQueryCommand.Parameters["@age"].Value = age;
                insertQueryCommand.Parameters["@experience"].Value = experience;

                dataAdapter.InsertCommand = insertQueryCommand;
                dataAdapter.Update(dataSet, "CourierTable");
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql command execution. Message: " + e.Message);
            }
            catch (FormatException ex)
            {
                Console.WriteLine("Bad input! " + ex.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        public void disconnectedObjects_9_Delete()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 9, "[Disconnected] Delete.");

            string dataCommand = @"select * from CourierTable";
            string deleteQueryString = @"delete from CourierTable where Name = @name";

            SqlConnection connection = new SqlConnection(connectionString);

            try
            {
                connection.Open();
                Console.WriteLine("Deleting the courier. Input: ");
                Console.Write("- name = ");
                string name = Console.ReadLine();

                SqlDataAdapter dataAdapter = new SqlDataAdapter(new SqlCommand(dataCommand, connection));
                DataSet dataSet = new DataSet();
                dataAdapter.Fill(dataSet, "CourierTable");
                DataTable table = dataSet.Tables["CourierTable"];

                string filter = "Name = '" + name + "'";
                foreach (DataRow row in table.Select(filter))
                {
                    row.Delete();
                }

                SqlCommand deleteQueryCommand = new SqlCommand(deleteQueryString, connection);
                deleteQueryCommand.Parameters.Add("@name", SqlDbType.NVarChar, 35, "Name");

                dataAdapter.DeleteCommand = deleteQueryCommand;
                dataAdapter.Update(dataSet, "CourierTable");

                Console.WriteLine("CourierTable");
                foreach (DataRow row in table.Rows)
                {
                    Console.Write("{0} ", row["Id"]);
                    Console.Write("{0} ", row["Name"]);
                    Console.Write("{0} ", row["Age"]);
                    Console.Write("{0}\n", row["Experience"]);
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql command execution. Message: " + e.Message);
            }
            catch (FormatException ex)
            {
                Console.WriteLine("Bad input! " + ex.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        public void disconnectedObjects_10_Xml()
        {
            Console.WriteLine("".PadLeft(80, '-'));
            Console.WriteLine("Task #{0}: {1}", 10, "WriteXml.");

            string query = @"select TOP(10) Name, CurrentDelivery from CourierTable";

            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.");

                SqlDataAdapter dataAdapter = new SqlDataAdapter(query, connection);
                DataSet dataSet = new DataSet();
                dataAdapter.Fill(dataSet, "CourierTable");
                DataTable table = dataSet.Tables["CourierTable"];

                dataSet.WriteXml("couriers.xml");
                Console.WriteLine("Check the couriers.xml file.");
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql query execution. Message: " + e.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }
    }
}
