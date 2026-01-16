using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT11
{
    public partial class mainForm : Form
    {
        private int ballLeft, ballTop; // vi tri goc trai tren ban dau cua qua banh
        private int deltaX = 40; // do dai buoc dich chuyen ngang
        private int deltaY = 20; // do dai buoc dich chuyen doc
        private int maxX; // vi tri phai nhat ma qua banh co the di toi
        private int maxY; // vi tri thap nhat ma qua banh co the di toi
        private int direction = 0; // huong chuyen dong
        // 0: left->right
        // 1: top -> down
        // 2: right -> left
        // 3: down -> top

        public mainForm()
        {
            InitializeComponent();
        }

        private void startButton_Click(object sender, EventArgs e)
        {
            startButton.Enabled = false;
            stopButton.Enabled = true;
            speedNumericUpDown.Enabled = true;
            movingTimer.Enabled = true;

        }

        private void mainForm_Load(object sender, EventArgs e)
        {
            startButton.Enabled = true;
            stopButton.Enabled = false;
            movingTimer.Enabled=false;
            movingTimer.Interval = 400; // ung voi toc do 1
            speedNumericUpDown.Enabled=false;
            ballLeft = ballPictureBox.Left;
            ballTop = ballPictureBox.Top;
            maxX = this.Size.Width - ballLeft - ballPictureBox.Width;
            maxY = this.Size.Height - ballTop - ballPictureBox.Height;
        }

        private void movingTimer_Tick(object sender, EventArgs e)
        {
            if (direction == 0)
            {
                if (ballPictureBox.Left + deltaX > maxX)
                {
                    ballPictureBox.Left = maxX;
                    direction = 1;
                }
                else
                {
                    ballPictureBox.Left += deltaX;
                }
            }
            else if (direction == 1)
            {
                if (ballPictureBox.Top + deltaY > maxY)
                {
                    ballPictureBox.Top = maxY;
                    direction = 2;
                }
                else
                {
                    ballPictureBox.Top += deltaY;
                }
            }
            else if (direction == 2)
            {
                if (ballPictureBox.Left - deltaX < ballLeft)
                {
                    ballPictureBox.Left = ballLeft;
                    direction = 3;
                }
                else
                {
                    ballPictureBox.Left -= deltaX;
                }
            }
            else if (direction == 3)
            {
                if (ballPictureBox.Top - deltaY < ballTop)
                {
                    ballPictureBox.Top = ballTop;
                    direction = 0;
                }
                else
                {
                    ballPictureBox.Top -= deltaY;
                }
            }

        }

        private void speedNumericUpDown_ValueChanged(object sender, EventArgs e)
        {
            if (speedNumericUpDown.Value == 1)
                movingTimer.Interval = 400;
            else if (speedNumericUpDown.Value == 2)
                movingTimer.Interval = 300;
            else if (speedNumericUpDown.Value == 3)
                movingTimer.Interval = 200;
            //movingTimer.Interval = 400 - (int)(speedNumericUpDown.Value - 1) * 100;
           
        }

        private void stopButton_Click(object sender, EventArgs e)
        {
            stopButton.Enabled = false;
            startButton.Enabled = true;
            speedNumericUpDown.Enabled = false;
            movingTimer.Enabled = false;
        }
    }
}
