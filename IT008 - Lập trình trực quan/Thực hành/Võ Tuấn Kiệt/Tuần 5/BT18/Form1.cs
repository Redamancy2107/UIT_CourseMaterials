using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT18
{
  public partial class mainForm : Form
  {
    int recX = 10;
    int recY = 10;
    int recWidth = 60;
    int recHeight = 40;
    bool moving = false;
    int deltaX  = 0;
    int deltaY = 0;
    public mainForm()
    {
      InitializeComponent();
    }

    private void mainForm_Paint(object sender, PaintEventArgs e)
    {
      Graphics g = e.Graphics;
      g.FillRectangle(Brushes.Red, recX, recY, recWidth, recHeight);
    }

    private void mainForm_MouseDown(object sender, MouseEventArgs e)
    {
      if (e.X>=recX && e.X<=recX + recWidth && e.Y>=recY & e.Y<recY + recHeight)
      {
        moving = true;
        deltaX = e.X - recX;
        deltaY = e.Y - recY;
      }
    }

    private void mainForm_MouseMove(object sender, MouseEventArgs e)
    {
      if (moving) {
        recX = e.X - deltaX;
        recY = e.Y - deltaY;
        Invalidate();
      }
      
    }

    private void mainForm_MouseUp(object sender, MouseEventArgs e)
    {
      moving = false;
    }
  }
}
