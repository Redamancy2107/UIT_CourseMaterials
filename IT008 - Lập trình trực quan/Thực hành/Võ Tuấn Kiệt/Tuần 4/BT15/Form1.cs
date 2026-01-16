using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT15
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
            string text = "Hello GDI+";
            Font f = new Font("Arial", 26, FontStyle.Bold);
            SizeF size = g.MeasureString(text, f);
            float x = (this.ClientSize.Width - size.Width) / 2;
            float y = (this.ClientSize.Height - size.Height) / 2;
            g.DrawString(text, f, Brushes.DarkRed, x, y);
        }

    }
}
