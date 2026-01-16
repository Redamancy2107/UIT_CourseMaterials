using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT24
{
  public partial class mainForm : Form
  {
    private bool running = false;
    private bool leftDir = false;
    private bool upDir = false;
    private bool pausingCountHits = false;
    public mainForm()
    {
      InitializeComponent();
    }

    private void startButton_Click(object sender, EventArgs e)
    {
      running = true;
      Action car1 = new Action(moveCar1);
      Task.Run(car1);
      Action car2 = new Action(moveCar2);
      Task.Run(car2);
    }
    private void moveCar1()
    {
      while (running)
      {
        if (leftDir)
        {
          car1PictureBox.Invoke(new Action(()=>{
            car1PictureBox.Left -= 5; }));

          if (car1PictureBox.Left <= 0)
            leftDir = false;
        }
        else
        {
          car1PictureBox.Left += 5;
          if (car1PictureBox.Right >= this.ClientSize.Width)
            leftDir = true;
        }
        System.Threading.Thread.Sleep(50);
      }
    }
    private void moveCar2()
    {
      while (running)
      {

        if (upDir)
        {
          car2PictureBox.Invoke(new Action(() =>
          {
            car2PictureBox.Top -= 5;
          }));
          if (car2PictureBox.Top <= 0)
            upDir = false;
        }
        else
        {
          car2PictureBox.Top += 5;
          if (car2PictureBox.Bottom >= this.ClientSize.Height)
            upDir = true;
        }
        checkHit();
        System.Threading.Thread.Sleep(70);
      }
    }
    private void checkHit()
    {
      if (car1PictureBox.Bounds.IntersectsWith(car2PictureBox.Bounds))
      {
        if (pausingCountHits) return;
        hitNumberLabel.Invoke(new Action(() =>
        {
          hitNumberLabel.Text = (int.Parse(hitNumberLabel.Text) + 1).ToString();
        }));
        pausingCountHits = true;
      }
      else
      {
        pausingCountHits = false;
      }
    }

    private void stopButton_Click(object sender, EventArgs e)
    {
      running = false;
    }
  }
}
