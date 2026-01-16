using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT08
{
    
    public partial class mainForm : Form
    {
        private int imgIdx = 0;
        public mainForm()
        {
            InitializeComponent();
        }

        private void nextButton_Click(object sender, EventArgs e)

        {
            imgIdx = (imgIdx + 1) % 4;
            imgPictureBox.Image = (Image)Properties.Resources.ResourceManager.GetObject($"img{imgIdx}");
            
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            imgPictureBox.Image = (Image)Properties.Resources.ResourceManager.GetObject("img0");
            imgIdx = 0;
        }
    }
}
