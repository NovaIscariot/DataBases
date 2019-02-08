using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace LINQtoXML
{
    class Program
    {
        static void Main(string[] args)
        {
            int status = -1;            
            while (status == -1)
            {
                Console.WriteLine("1.Извлечь данные\n2. Вывести первый элемент\n3. Обновить XML\n4. Записать новые строки в XML\n0. Выход");
                Console.WriteLine("Выбор: ");
                status = Convert.ToInt32(Console.ReadLine());
                switch (status)
                {
                    case 1:
                        ReadXML();
                        status = -1;
                        break;
                    case 2:
                        ReadOneElement();
                        status = -1;
                        break;
                    case 3:
                        UpdateXML();
                        status = -1;
                        break;
                    case 4:
                        WriteXML();
                        status = -1;
                        break;
                    case 0:
                        Console.WriteLine("Завершение");
                        break;
                    default:
                        Console.WriteLine("Неизвестный пункт меню");
                        break;
                }
            }          
        }

        // Извлечение данных
        static void ReadXML()
        {
            XDocument xdoc = XDocument.Load(@"couriers.xml");
            var result = from courier in xdoc.Descendants("Courier")
                         select courier.Element("Name").Value;
            Console.WriteLine("Найдено {0} курьеров", result.Count());
            for (int i = 0; i < result.Count(); i++)
            {
                Console.WriteLine("имя: " + result.ElementAt(i) + "\n");
            }
            Console.WriteLine();
    
        }
        // Чтение
        static void ReadOneElement()
        {
            XDocument xdoc = XDocument.Load(@"couriers.xml");
            XElement courier = xdoc.Element("Couriers").Element("Courier");
            XAttribute idAttribute = courier.Attribute("Id");
            XElement nameElement = courier.Element("Name");
            XElement currentDeliveryElement = courier.Element("CurrentDelivery");

            Console.WriteLine("\n\nID: {0}", idAttribute.Value);
            Console.WriteLine("Имя: {0}", nameElement.Value);
            Console.WriteLine("Текущая доставка: {0}\n", currentDeliveryElement.Value);
        }
        // Обновление
        static void UpdateXML()
        {
            XDocument xdoc = XDocument.Load(@"couriers.xml");
            IEnumerable<XElement> answerElements = xdoc.Descendants("Courier");
            XElement toChange = answerElements.ElementAtOrDefault(1);

            Console.WriteLine("\n\nИзмененный элемент\n");

            Console.WriteLine("До:");
            Console.WriteLine(toChange.Element("Name").Value + "\n" + toChange.Element("CurrentDelivery").Value);

            toChange.SetElementValue("Name", "ENIN TUPOI");
            xdoc.Save("updated.xml");
            Console.WriteLine("После:");
            Console.WriteLine(toChange.Element("Name").Value + "\n" + toChange.Element("CurrentDelivery").Value);
        }

        // Запись
        static void WriteXML()
        {
            XDocument xdoc = XDocument.Load(@"couriers.xml");
            XElement root = new XElement("Couriers");
            XElement newcourier = new XElement("Courier");
            XAttribute id = new XAttribute("Id", "101");
            XElement name = new XElement("Name", "PRIMITE LABY");
            XElement currentDelivery = new XElement("CurrentDelivery", "123");
            

            Console.WriteLine("\nСоздан XML-файл\n");

            newcourier.Add(id, name, currentDelivery);
            xdoc.Element("Couriers").Add(newcourier);
            xdoc.Save("written.xml");

            /*Console.WriteLine("Добавленные элементы:\n");*/
            
        }
    }
}
