using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;


namespace Test
{
    class Program
    {
        private readonly string connectionString = @"Data Source = DESKTOP-9C01EOF\SQLEXPRESS; Database = rk3; Integrated Security = true";
        static void Main(string[] args)
        {
            Program solution = new Program();
            testDataContext db = new testDataContext(connectionString);
            solution.Task21LINQ(db);
            solution.Task21ADO();
            solution.Task22LINQ(db);
            solution.Task22ADO();
            /*solution.Task23LINQ(db);
            solution.Task23ADO();*/
        }

        public void Task21LINQ(testDataContext db)
        {
            Console.WriteLine("LINQ");
            var query = from t in db.GetTable<Job>()
                        where t.calary > 10000
                        where t.calary < 50000
                        select t;
            foreach (var item in query)
            {
                Console.WriteLine("{0} {1} {2}", item.company, item.spec, item.calary);
            }
        }

        public void Task21ADO()
        {
            string queryString = @"SELECT Company, Spec, Calary FROM RK3.Job WHERE (Calary BETWEEN 10000 and 50000)";
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand query = new SqlCommand(queryString, connection);
            try
            {
                connection.Open();
                SqlDataReader dataReader = query.ExecuteReader();
                while (dataReader.Read())
                {
                    Console.WriteLine("{0} {1} {2}", dataReader.GetValue(0), dataReader.GetValue(1), dataReader.GetValue(2));
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine(e.Message);
            }
            finally
            {
                connection.Close();
            }
        }
        public void Task22LINQ(testDataContext db)
        {
            Console.WriteLine("LINQ");
            var huntPerVac = from s in db.GetTable<Worker>()
                             group s by s.spec into specGroup
                             select new
                             {
                                 spec = specGroup.Key,
                                 count = specGroup.Count(),
                             };
            var interlude = from q in huntPerVac
                            where q.count > 5
                            join v in db.GetTable<Job>()
                            on q.spec equals v.spec into result
                            from r in result
                            select r;
            foreach (var group in interlude)
            {
                Console.WriteLine("{0} | {1}", group.company, group.spec);
            }
        }
        public void Task22ADO()
        {
            string queryString = @"Select t1.Company, t1.Spec
from RK3.Job as t1 join
(
	SELECT COUNT(id) as 'count', spec
	from TRK3.Job
	group by spec) as t2 on t1.Spec = t2.spec
where t2.count > 5";
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand query = new SqlCommand(queryString, connection);
            try
            {
                connection.Open();
                SqlDataReader dataReader = query.ExecuteReader();
                while (dataReader.Read())
                {
                    Console.WriteLine("{0} {1}", dataReader.GetValue(0), dataReader.GetValue(1));
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine(e.Message);
            }
            finally
            {
                connection.Close();
            }
        }

        public void Task23LINQ(testDataContext db)
		{
			Console.WriteLine("LINQ");
			var queryA = from t in db.GetTable<Worker>()
						 select t.name;
			var queryB = from t in db.GetTable<Worker>()
						 join p in db.GetTable<Job>() 
						 on t.Spec equals p.Spec into result
						 select t.name;
			IEnumerable<string> res = queryA.AsEnumerable().Except(queryB.AsEnumerable());
			foreach(var i in res)
			{
				Console.WriteLine("{0}", i.ToString());
			}
		}

		public void Task23ADO()
		{  
			Console.WriteLine("Ado");
			string queryString = @"Select Fullname from RK3.Worker 
EXCEPT
Select RK3.Worker.Name from RK3.Job join RK3.Worker on RK3.Worker.Spec = RK3.Job.Spec";
			SqlConnection connection = new SqlConnection(connectionString);
			SqlCommand query = new SqlCommand(queryString, connection);
			try
			{
				connection.Open();
				SqlDataReader dataReader = query.ExecuteReader();
				while (dataReader.Read())
				{
					Console.WriteLine("{0}", dataReader.GetValue(0));
				}
			}
			catch (SqlException e)
			{
				Console.WriteLine(e.Message);
			}
			finally
			{
				connection.Close();
			}
		}
    }
}
