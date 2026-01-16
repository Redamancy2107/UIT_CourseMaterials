using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bai01
{
    internal class Helper
    {
        public static long InputPositiveNumber()
        {
            long value;
            while (true)
            {
                Console.Write("Nhập vào một số nguyên dương: ");
                string input = Console.ReadLine();
                try
                {
                    value = long.Parse(input);
                    PositiveNumber number = new PositiveNumber(value);
                    return number.Value;
                }
                catch (FormatException)
                {
                    Console.WriteLine("Giá trị nhập vào không đúng định dạng số nguyên. Vui lòng thử lại.");
                }
                catch (OverflowException)
                {
                    Console.WriteLine("Giá trị nhập vào quá lớn hoặc quá nhỏ. Vui lòng thử lại.");
                }
                catch (ArgumentException ex)
                {
                    Console.WriteLine(ex.Message);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Đã xảy ra lỗi không xác định: " + ex.Message);
                }
            }
        }
    public static void ShowMenu()
        {
            Console.WriteLine("\n\n==================== MENU ====================");
            Console.WriteLine("1. Tính tổng các chữ số của một số nguyên dương");
            Console.WriteLine("0. Thoát chương trình");
            Console.WriteLine("==============================================");
            Console.Write("Chọn chức năng: ");
            string choice = Console.ReadLine();
            switch (choice)
            {
                case "1":
                    long value = InputPositiveNumber();
                    PositiveNumber number = new PositiveNumber(value);
                    long sumOfDigits = number.CalculateSumOfDigits();
                    Console.WriteLine($"Tổng các chữ số của {value} là: {sumOfDigits}");
                    break;
                case "0":
                    Console.Write("\n\n\nKết thúc chương trình\n\n\n");
                    Environment.Exit(0);
                    break;
                default:
                    Console.WriteLine("Lựa chọn không hợp lệ. Vui lòng thử lại.");
                    break;
            }
        }
    }
}
