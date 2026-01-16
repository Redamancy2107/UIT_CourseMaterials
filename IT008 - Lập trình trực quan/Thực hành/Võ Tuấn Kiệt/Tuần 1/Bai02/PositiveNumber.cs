using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bai02
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
        public bool IsPerfectNumber()
        {
            long sumOfDivisors = 0;
            for (long i = 1; i <= this.Value / 2; i++)
            {
                if (this.Value % i == 0)
                {
                    sumOfDivisors += i;
                }
            }
            return sumOfDivisors == this.Value;
        }
        public bool IsPrimeNumber()
        {
            if (this.Value < 2) 
                return false;
            for (long i = 2; i <= Math.Sqrt(this.Value); i++)
            {
                if (this.Value % i == 0)
                {
                    return false;
                }
            }
            return true;
        }
        public bool IsGreaterThan(PositiveNumber other)
        {
            if (other == null)
            {
                throw new ArgumentNullException(nameof(other), "Đối tượng so sánh không được null.");
            }
            return this.Value > other.Value;
        }
    }
}
