using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bai01
{
    internal class Program
    {
        static void Main(string[] args)
        {
            #region Support Vietnamese
            Console.InputEncoding = Encoding.UTF8;
            Console.OutputEncoding = Encoding.UTF8;
            #endregion

            Console.WriteLine("Bài 1: Viết chương trình nhập vào một số nguyên dương," + 
                              "xuất ra tổng các chữ số của số đó.");

            Helper.ShowMenu();

            Console.Write("\n\n\nKết thúc chương trình\n\n\n");
        }
    }
}
