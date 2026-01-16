using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT22
{
  public partial class mainForm : Form
  {
    private bool moving = false;
    private bool upDirection = false;
    public mainForm()
    {
      InitializeComponent();
    }

    private void mainForm_Load(object sender, EventArgs e)
    {
    }

    private void startButton_Click(object sender, EventArgs e)
    {
      moving = true;
      Action action = new Action(MoveBall);
      Task.Run(action);
    }
    private void MoveBall()
    {
      while (moving)
      {
        if (upDirection)
        {
          ballPictureBox.Invoke(new Action(() =>
          {
            ballPictureBox.Top -= 5;
          }));
          if (ballPictureBox.Top <= 0)
          {
            upDirection = false;
          }
        }
        else
        {
          ballPictureBox.Invoke(new Action(() =>
          {
            ballPictureBox.Top += 5;
          }));
          if (ballPictureBox.Top + ballPictureBox.Height >= this.ClientSize.Height)
          {
            upDirection = true;
          }
        }
        Task.Delay(20).Wait();
      }
    }

    private void stopButton_Click(object sender, EventArgs e)
    {
      moving = false;
    }
  }
}
