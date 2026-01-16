using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT07
{
    public partial class mainForm : Form
    {
        bool flagPaint = false;
        public mainForm()
        {
            InitializeComponent();
        }

        private void Form1_MouseMove(object sender, MouseEventArgs e)
        {
            if (flagPaint)
            {
                System.Drawing.Graphics graphic = CreateGraphics();
                graphic.FillEllipse(new SolidBrush(Color.Green), new Rectangle(e.X, e.Y, 4, 4));
            }
            
        }

        private void Form1_MouseDown(object sender, MouseEventArgs e)
        {
            flagPaint = true;
        }

        private void Form1_MouseUp(object sender, MouseEventArgs e)
        {
            flagPaint = false;
        }
    }
}
