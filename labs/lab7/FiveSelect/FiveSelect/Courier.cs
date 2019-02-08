using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FiveSelect
{
    class Courier
    {
        public int id;
        public String name;
        public int age;
        public int exp;
        public int currentdeliveryId;

        public Courier(int i, string n, int a, int e, int c)
        {
            id = i;
            name = n;
            age = a;
            exp = e;
            currentdeliveryId = c;
        }
    }
}
