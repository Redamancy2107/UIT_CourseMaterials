using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT13
{
    public partial class mainForm : Form
    {
        public mainForm()
        {
            InitializeComponent();
        }

        private void mainForm_Paint(object sender, PaintEventArgs e)
        {
            Graphics g = e.Graphics;
            g.TranslateTransform(100, 50);
            g.RotateTransform(35);
            g.DrawString("Cool Text", new Font("Arial", 26, FontStyle.Bold), Brushes.Blue, 0, 0);
            g.ResetTransform();
        }
    }
}
