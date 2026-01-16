using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT12
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
            g.DrawLine(Pens.Red, 10, 10, 200, 100);
            g.DrawLine(Pens.Green, 10, 30, 200, 130);
            g.DrawLine(Pens.Blue, 10, 50, 200, 150);
            g.DrawLine(new Pen(Color.Red, 5), 10, 100, 200, 190);

        }
    }
}
