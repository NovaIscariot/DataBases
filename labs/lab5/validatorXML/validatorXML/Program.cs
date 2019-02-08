using System;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Schema;

namespace validatorXML
{
    class Program
    {
        static void Main(string[] args)
        {
            XmlSchemaSet schemas = new XmlSchemaSet();
            schemas.Add("", "XML.xsd");

            XDocument custOrdDoc = XDocument.Load("XML.xml");
            bool errors = false;
            custOrdDoc.Validate(schemas, (o, e) =>
            {
                    Console.WriteLine(e.Message);
                    errors = true;
            });
            Console.WriteLine("Couriers {0}", errors ? "did not pass validation" : "passed validation");

            Console.ReadLine();
        }
    }
}
