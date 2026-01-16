using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT20
{
  public partial class mainForm : Form
  {
    int recX = 10;
    int recY = 10;
    int recWidth = 60;
    int recHeight = 40;
    public mainForm()
    {
      InitializeComponent();
    }

    private void mainForm_Paint(object sender, PaintEventArgs e)
    {
      Graphics g = e.Graphics;
      g.FillRectangle(Brushes.Red, recX, recY, recWidth, recHeight);

    }
    private void mainForm_KeyDown(object sender, KeyEventArgs e)
    {
      switch (e.KeyCode)
      {
        case Keys.Up:
          recY -= 5;
          break;
        case Keys.Down:
          recY += 5;
          break;
        case Keys.Left:
          recX -= 5;
          break;
        case Keys.Right:
          recX += 5; 
          break;
      }
      if (recY<=0) recY=0;
      if (recY>=ClientSize.Height-recHeight) recY=ClientSize.Height-recHeight;
      if (recX<=0) recX=0;
      if (recX>=ClientSize.Width-recWidth) recX=ClientSize.Width-recWidth;
      Invalidate();
    }
  }
}
