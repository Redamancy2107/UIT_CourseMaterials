using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT19
{
  public partial class mainForm : Form
  {
    private const string st = "Chúc mừng năm mới an khang thịnh vượng";
    private float stLen = 0;
    private float x = 0;
    public mainForm()
    {
      InitializeComponent();
    }

    private void mainForm_Load(object sender, EventArgs e)
    {
      x = ClientSize.Width;
      timer1.Enabled = true;
    }

    private void mainForm_Paint(object sender, PaintEventArgs e)
    {
      Graphics g = e.Graphics;
      Font f = new Font("Arial", 60, FontStyle.Bold);
      SizeF size = g.MeasureString(st, f);
      g.DrawString(st, f, Brushes.Red, x, (ClientSize.Height-size.Height) / 2);
      stLen = size.Width;
    }

    private void timer1_Tick(object sender, EventArgs e)
    {
      x -= 10;
      if (x <= -stLen) x = ClientSize.Width;
      Invalidate();
    }
  }
}
