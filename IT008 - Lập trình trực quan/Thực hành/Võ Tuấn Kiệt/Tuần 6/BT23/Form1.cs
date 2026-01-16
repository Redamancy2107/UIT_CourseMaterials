using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT23
{
  public partial class mainForm : Form
  {
    private bool isRunning = false;
    private bool leftDir = true;
    public mainForm()
    {
      InitializeComponent();
    }

    private void startButton_Click(object sender, EventArgs e)
    {
      isRunning = true;
      Action car = new Action(runCar);
      Task.Run(car);
      Action lights = new Action(() => runLights(5, 3));
      Task.Run(lights);
    }
    private void runCar()
    {
      while (isRunning)
      {
        if (redLabel.BackColor == Color.Red)
          continue;
        if (leftDir)
        {
          carPictureBox.Invoke(new Action(()=>{
            carPictureBox.Left += 5;
          }));
          
          if (carPictureBox.Left >= this.ClientSize.Width - carPictureBox.Width)
          {
            leftDir = false;
          }
        }
        else
        {
          carPictureBox.Invoke(new Action(()=> {
            carPictureBox.Left -= 5;
          }));
          if (carPictureBox.Left <= 0)
          {
            leftDir = true;
          }
        }
        Task.Delay(50).Wait();
      }
    }
    private void runLights(int greenLightSeconds, int redLightSeconds)
    {
      while (isRunning)
      {
        // turn off red, turn on green
        redLabel.Invoke(new Action(() =>
        {
          redLabel.BackColor = Color.Gray;
        }));
        greenLabel.Invoke(new Action(() =>
        {
          greenLabel.BackColor = Color.Green;
        }));
        // wait for green light duration
        for (int i = greenLightSeconds; i > 0; --i)
        {
          greenLabel.Invoke(new Action(() =>
          {
            greenLabel.Text = i.ToString();
          }));
          Task.Delay(1000).Wait();
        }
        greenLabel.Invoke(new Action(() =>
        {
          greenLabel.Text = "";
        }));
        // turn off green, turn on red
        greenLabel.Invoke(new Action(() =>
        {
          greenLabel.BackColor = Color.Gray;
        }));
        redLabel.Invoke(new Action(() =>
        {
          redLabel.BackColor = Color.Red;
        }));
        for (int i = redLightSeconds; i > 0; --i)
        {
          redLabel.Invoke(new Action(() =>
          {
            redLabel.Text = i.ToString();
          }));
          Task.Delay(1000).Wait();
        }
        redLabel.Invoke(new Action(() =>
        {
          redLabel.Text = "";
        }));
      }
    }
    private void stopButton_Click(object sender, EventArgs e)
    {
      isRunning = false;
    }
  }
}
