using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bai02
{
    internal class Program
    {
        static void Main(string[] args)
        {
            #region Support Vietnamese
            Console.InputEncoding = Encoding.UTF8;
            Console.OutputEncoding = Encoding.UTF8;
            #endregion

            Console.WriteLine("Bài 02: Viết chương trình nhập vào một số nguyên dương n, tạo ra một mảng gồm n số nguyên dương ngẫu nhiên không quá 1000." + 
                              "\nThực hiện các chức năng sau: " +
                              "\r\n1. Xuất ra mảng" + 
                              "\r\n2. Xuất ra các số hoàn hảo trong mảng" +
                              "\r\n3. Xuất ra các số nguyên tố trong mảng" +
                              "\r\n4. Sắp xếp mảng tăng dần và xuất ra");

            Helper.ShowMenu();

            Console.Write("\n\n\nKết thúc chương trình\n\n\n");
            Console.ReadKey();
        }
    }
}
