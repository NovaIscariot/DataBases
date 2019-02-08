using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace FiveSelect
{
    class Program
    {
        static void Main(string[] args)
        {

            Courier[] couriers = new Courier[6];
            couriers[0] = new Courier(1, "Evgeny Enin", 20, 0 , 0);
            couriers[1] = new Courier(2, "Anastasia Jukova", 19, 1, 0);
            couriers[2] = new Courier(3, "Danil Enin", 18, 2, 0);
            couriers[3] = new Courier(4, "Alex Ivanov", 22, 1, 0);
            couriers[4] = new Courier(5, "Roman Petrov", 19, 3, 0);
            couriers[5] = new Courier(6, "Evgeny Birukov", 20, 1, 0);

            Delivery[] deliveries = new Delivery[8];
            deliveries[0] = new Delivery(1, "Novaya 2", 1);
            deliveries[1] = new Delivery(2, "Staraya 2", 2);
            deliveries[2] = new Delivery(3, "Ochen Staraya 2", 3);
            deliveries[3] = new Delivery(4, "Novaya 4", 4);
            deliveries[4] = new Delivery(5, "Baumanskaya 2", 5);
            deliveries[5] = new Delivery(6, "Baumanskaya 3", 6);
            deliveries[6] = new Delivery(7, "Staraya 12", 4);
            deliveries[7] = new Delivery(8, "Baumanskaya 4", 2);




            // select where
            Console.WriteLine("\nЗапрос select where");
            var result = from d in deliveries
                     where d.coureierId == 3
                     select d.address;
            Console.WriteLine("Доставки курьера с индексом 3:");
            for (int i = 0; i < result.Count(); i++)
            {
                Console.WriteLine("Адрес: " + result.ElementAt(i));
            }

            // select orderby
            Console.WriteLine("\nЗапрос select orderby");
            result = from c in couriers
                     orderby c.exp
                     select c.name;
            Console.WriteLine("Все курьеры, отсортированные по возрасту:");
            for (int i = 0; i < result.Count(); i++)
            {
                Console.WriteLine("имя: " + result.ElementAt(i));
            }

            //select join
            Console.WriteLine("\nЗапрос select join");
            var result3 = from c in couriers
                     join d in deliveries on c.id equals d.coureierId
                     select new { Name = c.name, Address = d.address };
            Console.WriteLine("Курьеры и их адреса:");
            foreach (var address in result3)
            {
                Console.WriteLine($"\"{address.Name}\t\"{address.Address}");
            }

            //select group 
            Console.WriteLine("Количество доставок каждого курьера");
            var result4 = from t in deliveries
                          group t by t.coureierId into g
                          select new { CourierId = g.Key, Count = g.Sum(a => a.id) };
            foreach (var grp in result4)
            {
                Console.WriteLine("CourierId = {0}, Count of deliveries = {1}",
                    grp.CourierId, grp.Count);
            }


            //select let
            Console.WriteLine("\nЗапрос select let");
            Console.Write("Введите id: ");
            int id = Int32.Parse(Console.ReadLine());
            result = from c in deliveries
                     let tmp = id
                     where c.coureierId == tmp
                     orderby c.id
                     select c.address;
            Console.WriteLine("Доставки курьера {0}, сортировка по id:", id);
            for (int i = 0; i < result.Count(); i++)
            {
                Console.WriteLine("Адрес: " + result.ElementAt(i));
            }


            Console.ReadLine();
        }
    }
}
