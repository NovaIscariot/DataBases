using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FiveSelect
{
    class Delivery
    {
        public int id;
        public string address;
        public int coureierId;

        public Delivery(int i, string a, int ci)
        {
            id = i;
            address = a;
            coureierId = ci;
        }
    }
}
