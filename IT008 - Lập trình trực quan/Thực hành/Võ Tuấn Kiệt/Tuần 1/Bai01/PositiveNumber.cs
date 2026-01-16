using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bai01
{
    internal class PositiveNumber
    {
        public long Value { get; }
        public PositiveNumber(long value)
        {
            if (value <= 0)
            {
                throw new ArgumentException("Giá trị phải là một số nguyên dương.", nameof(value));
            }
            this.Value = value;
        }
        public long CalculateSumOfDigits()
        {
            long sum = 0;
            long number = this.Value;
            long digit;

            while (number > 0)
            {
                digit = number % 10; 
                sum = sum + digit;             
                number = number / 10;             
            }

            return sum;
        }
    }
}
