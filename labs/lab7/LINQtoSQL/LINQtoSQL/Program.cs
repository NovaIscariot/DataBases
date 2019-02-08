using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LINQtoSQL
{
    class Program
    {
        public static DataContext db;

        public static void SelectFreeCouriers()
        {
            Table<CourierTable> couriers = db.GetTable<CourierTable>();
            var freecouriers = from courier in couriers
                                    where courier.CurrentDelivery == null
                                    select courier.Name;
            foreach (var courier in freecouriers)
            {
                Console.WriteLine(courier);
            }

        }

        public static void СurrentAddresses()
        {
            Table<CourierTable> couriers = db.GetTable<CourierTable>();
            Table<DeliveryTable> deliveries = db.GetTable<DeliveryTable>();
            
            var addresses = from courier in couriers
                            join del in deliveries on courier.CurrentDelivery equals del.Id
                            select new { Name = courier.Name, Address = del.Address };
            foreach (var address in addresses)
            {
                Console.WriteLine($"\"{address.Name}\"{address.Address}");
            }
        }

        public static void InsertPerson()
        {

            CourierTable courier = new CourierTable();
            courier.Id = 500;
            courier.Name = "Evgeny Enin";
            courier.Age = 20;
            courier.Experience = 0;
            courier.CurrentDelivery = null;
            Table<CourierTable> couriers = db.GetTable<CourierTable>();
            var newcour = from c in couriers
                        where c.Name == "Evgeny Enin"
                        select c.Name;
            if (newcour.Count() > 0)
            {
                Console.WriteLine("Информация уже была добавлена\n");
            }
            else
            {
                couriers.InsertOnSubmit(courier);
                db.SubmitChanges();
                var me = from c in couriers
                         where c.Name == "Evgeny Enin"
                         select c;
                foreach (var atr in me)
                {
                    Console.WriteLine($"\"{atr.Id}\" {atr.Name}\" {atr.Age}\" {atr.Experience}\n");
                }
            }            
        }

        public static void UpdatePerson()
        {
            Table<CourierTable> couriers = db.GetTable<CourierTable>();

            var me = from c in couriers
                     where c.Name == "Evgeny Enin"
                     select c;
            if (me.Count() > 0)
            {
                foreach (var atr in me)
                {
                    atr.Experience = 1;
                    Console.WriteLine($"\"{atr.Id}\" {atr.Name}\" {atr.Age}\" {atr.Experience}\n"); ;
                }
                db.SubmitChanges();
            }
            else
            {
                Console.WriteLine("Нет информации обо мне для обновления\n");
            }            
        }

        public static void DeletePerson()
        {
            Table<CourierTable> couriers = db.GetTable<CourierTable>();

            var me = from c in couriers
                     where c.Name == "Evgeny Enin"
                     select c;

            Console.WriteLine("Было удалено " + me.Count() + " строк");
            foreach (var atr in me)
            {
                couriers.DeleteOnSubmit(atr);
                db.SubmitChanges();
            };
        }

        public static void Deliveries(int id)
        {
            Table<DoneDeliveryTable> deliveries = db.GetTable<DoneDeliveryTable>();

            var result = from delivery in deliveries
                         where delivery.CourierId == id
                         select delivery;
            foreach (var r in result)
            {
                Console.WriteLine($"\"{r.Address}\n");
            }
        }

        static void Main(string[] args)
        {
            db = new DataContext(@"Data Source = DESKTOP-9C01EOF\SQLEXPRESS; Database = myDb; Integrated Security = true");

            int status = -1;
            while (status == -1)
            {
                Console.WriteLine("1. Однотабличный запрос\n2. Многотабличный запрос\n3. Добавить данные\n4. Изменить данные\n5. Удалить данные\n6. Хранимая процедура\n0. Выход");
                Console.WriteLine("Выбор: ");
                status = Convert.ToInt32(Console.ReadLine());
                switch (status)
                {
                    case 1:
                        Console.WriteLine("\nСвободные курьеры:\n");
                        SelectFreeCouriers();
                        Console.WriteLine(" ");
                        status = -1;
                        break;
                    case 2:
                        Console.WriteLine("\nКурьеры и их текущий адрес доставки: \n");
                        СurrentAddresses();
                        status = -1;
                        break;
                    case 3:
                        Console.WriteLine("\nДобавление информации обо мне \n");
                        InsertPerson();
                        status = -1;
                        break;
                    case 4:
                        Console.WriteLine("\nИзменение информации обо мне \n");
                        UpdatePerson();
                        status = -1;
                        break;
                    case 5:
                        Console.WriteLine("\nУдаление информации обо мне \n");
                        DeletePerson();
                        status = -1;
                        break;
                    case 6:
                        Console.WriteLine("\nДоставки курьера с индексом 11\n");
                        Deliveries(11);
                        status = -1;
                        break;
                    case 0:
                        Console.WriteLine("\nЗавершение\n");
                        break;
                    default:
                        Console.WriteLine("\nНеизвестный пункт меню\n");
                        status = -1;
                        break;
                }
            }
        }
    }
}
