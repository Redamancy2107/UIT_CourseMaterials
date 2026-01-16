using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT21
{
  public partial class mainForm : Form
  {
    class Raindrop
    {
      public float X;
      public float Y;
      public float Length;
      public float Speed;
      public Color Color;
    }

    List<Raindrop> raindrops = new List<Raindrop>();
    Random rnd = new Random();
    int dropCount = 200;


    public mainForm()
    {
      InitializeComponent();

      // Tạo hạt mưa
      for (int i = 0; i < dropCount; i++)
      {
        raindrops.Add(CreateRaindrop());
      }

    }
    private Raindrop CreateRaindrop()
    {
      return new Raindrop
      {
        X = rnd.Next(this.ClientSize.Width),
        Y = rnd.Next(this.ClientSize.Height),
        Length = 10 + (float)rnd.NextDouble() * 10,  // chiều dài hạt mưa
        Speed = 4 + (float)rnd.NextDouble() * 6,     // tốc độ khác nhau
        Color = Color.FromArgb(150 + rnd.Next(105), 173, 216, 230) // đậm nhạt khác nhau
      };
    }
    private void mainForm_Paint(object sender, PaintEventArgs e)
    {
      e.Graphics.Clear(Color.Black); // nền tối

      foreach (var drop in raindrops)
      {
        using (Pen p = new Pen(drop.Color, 2))
        {
          // vẽ line từ Y đến Y + Length
          e.Graphics.DrawLine(p, drop.X, drop.Y, drop.X, drop.Y + drop.Length);
        }
      }

    }

    private void timer1_Tick(object sender, EventArgs e)
    {
      foreach (var drop in raindrops)
      {
        drop.Y += drop.Speed;
        // nếu rơi khỏi màn hình thì quay lại từ trên
        if (drop.Y > this.ClientSize.Height)
        {
          drop.Y = -drop.Length;
          drop.X = rnd.Next(this.ClientSize.Width);
        }
      }

      Invalidate();

    }
  }
}
