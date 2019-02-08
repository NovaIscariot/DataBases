using System;
using System.Xml;
using System.IO;

namespace Lab6
{
    class Program
    {

        static public int DisplayMenu()
        {
            Console.WriteLine("Работа с Xml-файлом");
            Console.WriteLine();
            Console.WriteLine("1. Поиск информации, содержащейся в документе");
            Console.WriteLine("2. Доступ к содержимому узлов");
            Console.WriteLine("3. Изменение документа");
            Console.WriteLine("4. Выход из программы");
            Console.WriteLine("Выберите опцию: ");
            var result = Console.ReadLine();
            return Convert.ToInt32(result);
        }
        static void Main(string[] args)
        {
            //int choice = DisplayMenu();
            // 1. Reading document
            XmlDocument inputXML = new XmlDocument();
            inputXML.Load("couriers.xml");
            while(true)
            {
                int choice = DisplayMenu();
                switch (choice)
                {
                    case 1:
                        //2. Finding information 
                        Console.Write("This names were found in the document:\r\n");
                        XmlNodeList contents = inputXML.GetElementsByTagName("Name");
                        for (int i = 0; i < contents.Count; i++)
                            Console.Write(contents[i].ChildNodes[0].Value + "\r\n");

                        Console.Write("\n\nThis courier has id = 11:\r\n");
                        XmlElement courierID = inputXML.GetElementById("11");
                        //Console.WriteLine(courierID.OuterXml);
                        Console.Write(courierID.ChildNodes[0].ChildNodes[0].Value + "\t");
                        Console.Write(courierID.ChildNodes[1].ChildNodes[0].Value + "\r\n");

                        Console.Write("\n\nCouriers with name 'Artem Petrov' are:\r\n");
                        XmlNodeList name = inputXML.SelectNodes("//Courier/CurrentDelivery/text()[../../Name/text()='Artem Petrov']");
                        for (int i = 0; i < name.Count; i++)
                            Console.Write(name[i].Value + "\r\n");

                        Console.Write("\n\n First courier with name 'Artem Petrov' is:\r\n");
                        XmlNode firstName = inputXML.SelectSingleNode("//Courier/CurrentDelivery/text()[../../Name/text()='Artem Petrov']");
                        Console.Write(firstName.Value + "\r\n");

                        break;
                    case 2:
                        // 3. Access to nodes
                        Console.Write("\n" + inputXML.DocumentElement.InnerXml + "\r\n");

                        Console.Write("\n\nNames of couriers: \n");
                        XmlNodeList courier = inputXML.GetElementsByTagName("Courier");
                        for (int i = 0; i < courier.Count; i++)
                        {
                            Console.Write(courier[i].ChildNodes[0].InnerText + "\n");
                        }

                        Console.Write("\nComment:\n");
                        Console.Write(courier[0].ChildNodes[2].InnerText + "\n");


                        if (inputXML.FirstChild is XmlProcessingInstruction)
                        {
                            XmlProcessingInstruction processInfo = (XmlProcessingInstruction)inputXML.FirstChild;
                            Console.WriteLine(processInfo.Data);
                            Console.WriteLine(processInfo.Name);
                        }

                        Console.Write("\n\nIDs of couriers: \n");
                        for (int i = 0; i < courier.Count; i++)
                            Console.Write(courier[i].ChildNodes[0].InnerText + " : " + courier[i].Attributes[0].Value + "\r\n");

                        break;
                    case 3:
                        //3. Changes file
                        XmlNodeList change = inputXML.GetElementsByTagName("Courier");

                        XmlElement pcElement = (XmlElement)inputXML.GetElementsByTagName("Name")[1];
                        change[1].RemoveChild(pcElement);
                        Console.Write("\n Delete the second couriers's name..." + "\r\n");
                        inputXML.Save("couriers-deleted.xml");

                        XmlNodeList nameValues = inputXML.SelectNodes("//Courier/Name/text()");
                        for (int i = 0; i < nameValues.Count; i++)
                            nameValues[i].Value = nameValues[i].Value + "::?:?:";
                        Console.Write("\n Change format of name..." + "\r\n");
                        inputXML.Save("couriers-chg.xml");

                        /* XmlElement CourierElement = inputXML.CreateElement("Courier");
                         XmlElement nameElement = inputXML.CreateElement("Name");
                         XmlElement currentdeliveryElement = inputXML.CreateElement("CurrentDelivery");


                         XmlText nameText = inputXML.CreateTextNode("Evgeny Enin");
                         XmlText curr = inputXML.CreateTextNode("11");

                         nameElement.AppendChild(nameText);
                         currentdeliveryElement.AppendChild(curr);

                         CourierElement.AppendChild(nameElement);
                         CourierElement.AppendChild(currentdeliveryElement);

                         inputXML.DocumentElement.AppendChild(CourierElement);
                         inputXML.Save("couriers-new.xml");

                         XmlElement newElement = (XmlElement)inputXML.GetElementsByTagName("Courier")[3];
                         newElement.SetAttribute("Id", "142");*/
                        /*for (int i = 0; i<change.Count; i++)
                        {
                            XmlElement tmp = (XmlElement)inputXML.GetElementsByTagName("Courier")[i];
                            String tmpstr = "";
                            if (tmp.ChildNodes.Count > 1)
                                tmpstr = inputXML.GetElementsByTagName("CurrentDelivery")[i].InnerText;
                            tmp.SetAttribute("Extra", "POSTAVTE LABU PLEZ " + tmpstr);
                        }
                        inputXML.Save("couriers-new.xml");
                        break;*/
                        for (int i = 0; i < change.Count; i++)
                        {
                            XmlElement tmp = (XmlElement)inputXML.GetElementsByTagName("Courier")[i];
                            String tmpstr = "";
                            for (int j = 0; j < tmp.ChildNodes.Count; j++)
                                if (tmp.ChildNodes[j].Name == "CurrentDelivery")
                                    tmpstr = inputXML.GetElementsByTagName("CurrentDelivery")[i].InnerText;
                            tmp.SetAttribute("Extra", "POSTAVTE LABU PLEZ " + tmpstr);
                        }
                        inputXML.Save("couriers-new.xml");
                        break;

                    case 4:
                        System.Environment.Exit(0);
                        break;
                }
            }
        }
    }
}
