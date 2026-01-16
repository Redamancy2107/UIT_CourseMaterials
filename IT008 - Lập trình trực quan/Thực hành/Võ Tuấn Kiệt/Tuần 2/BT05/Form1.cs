using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT05
{
    public partial class mainForm : Form
    {
        private bool down = true; // bắt đầu từ vị trí trên rơi xuống, rồi từ dưới lên trên và lặp lại
        public mainForm()
        {
            InitializeComponent();
        }

        private void mainForm_Load(object sender, EventArgs e)
        {
            timer1.Enabled = true;
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if (down)
                ballPictureBox.Top += 50;
            else
                ballPictureBox.Top -= 50;
            down = !down; // chuyển hướng
        }
    }
}
