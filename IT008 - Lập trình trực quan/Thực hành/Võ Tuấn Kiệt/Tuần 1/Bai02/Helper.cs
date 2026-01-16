using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bai02
{
    internal class Helper
    {
        public static void ShowMenu()
        {
            PositiveNumberArray numberArray = null;
            while (true)
            {
                Console.WriteLine("\n\n==================== MENU ====================");
                Console.WriteLine("1. Tạo mảng các số nguyên dương");
                Console.WriteLine("2. Xuất ra mảng");
                Console.WriteLine("3. Xuất ra các số hoàn hảo trong mảng");
                Console.WriteLine("4. Xuất ra các số nguyên tố trong mảng");
                Console.WriteLine("5. Sắp xếp mảng tăng dần và xuất ra");
                Console.WriteLine("0. Thoát chương trình");
                Console.WriteLine("==============================================");
                Console.Write("Chọn chức năng: ");
                string choice = Console.ReadLine();
                switch (choice)
                {
                    case "1":
                        Console.Write("Nhập vào kích thước mảng (số nguyên dương): ");
                        if (int.TryParse(Console.ReadLine(), out int size) && size > 0)
                        {
                            numberArray = new PositiveNumberArray(size);
                            Console.WriteLine($"Đã tạo mảng gồm {size} số nguyên dương ngẫu nhiên.");
                        }
                        else
                        {
                            Console.WriteLine("Kích thước mảng không hợp lệ. Vui lòng nhập một số nguyên dương.");
                        }
                        break;
                    case "2":
                        if (numberArray != null)
                        {
                            numberArray.PrintArray();
                        }
                        else
                        {
                            Console.WriteLine("Vui lòng tạo mảng trước khi xuất.");
                        }
                        break;
                    case "3":
                        if (numberArray != null)
                        {
                            numberArray.PrintPerfectNumbers();
                        }
                        else
                        {
                            Console.WriteLine("Vui lòng tạo mảng trước khi xuất.");
                        }
                        break;
                    case "4":
                        if (numberArray != null)
                        {
                            numberArray.PrintPrimeNumbers();
                        }
                        else
                        {
                            Console.WriteLine("Vui lòng tạo mảng trước khi xuất.");
                        }
                        break;
                    case "5":
                        if (numberArray != null)
                        {
                            numberArray.SortAndPrintArray();
                        }
                        else
                        {
                            Console.WriteLine("Vui lòng tạo mảng trước khi sắp xếp và xuất.");
                        }
                        break;
                    case "0":
                        Console.Write("\n\n\nKết thúc chương trình\n\n\n");
                        Console.ReadKey();
                        Environment.Exit(0);
                        break;
                }
            }
        }
    }
}
