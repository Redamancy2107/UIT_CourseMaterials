using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bai02
{
    internal class PositiveNumberArray
    {
        public PositiveNumber[] Numbers { get; }
        private static Random random = new Random();
        public PositiveNumberArray(int size)
        {
            if (size <= 0)
            {
                throw new ArgumentException("Kích thước mảng phải là một số nguyên dương.", nameof(size));
            }
            Numbers = new PositiveNumber[size];
            for (int i = 0; i < size; i++)
            {
                long value = random.Next(1, 1001); 
                Numbers[i] = new PositiveNumber(value);
            }
        }
        public PositiveNumberArray(PositiveNumber[] numbers)
        {
            if (numbers == null || numbers.Length == 0)
            {
                throw new ArgumentException("Mảng không được rỗng.", nameof(numbers));
            }
            Numbers = numbers.ToArray();
        }
        public void PrintArray()
        {
            Console.Write("Mảng các số nguyên dương:");
            foreach (var number in Numbers)
            {
                Console.Write(number.Value + " ");
            }
            Console.WriteLine();
        }
        public void PrintPerfectNumbers()
        {
            Console.WriteLine("Các số hoàn hảo trong mảng:");
            bool found = false;
            foreach (var number in Numbers)
            {
                if (number.IsPerfectNumber())
                {
                    Console.Write(number.Value + " ");
                    found = true;
                }
            }
            if (!found)
            {
                Console.WriteLine("Không có số hoàn hảo nào trong mảng.");
            }
            else
            {
                Console.WriteLine();
            }
        }
        public void PrintPrimeNumbers()
        {
            Console.WriteLine("Các số nguyên tố trong mảng:");
            bool found = false;
            foreach (var number in Numbers)
            {
                if (number.IsPrimeNumber())
                {
                    Console.Write(number.Value + " ");
                    found = true;
                }
            }
            if (!found)
            {
                Console.WriteLine("Không có số nguyên tố nào trong mảng.");
            }
            else
            {
                Console.WriteLine();
            }
        }
        public void SortArray()
        {
            Array.Sort(Numbers, (a, b) => a.Value.CompareTo(b.Value));

        }
        public void SortAndPrintArray()
        {
            this.SortArray();
            Console.WriteLine("Mảng sau khi sắp xếp tăng dần:");
            PrintArray();
        }
    }
}
