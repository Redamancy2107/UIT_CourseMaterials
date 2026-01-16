using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT14
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

            Pen pen = new Pen(Color.Blue, 2);
            g.DrawRectangle(pen, 20, 60, 120, 80);

            g.DrawEllipse(pen, 160, 60, 120, 80);

            Point[] tamGiac = new Point[] {
                new Point(320, 140),
                new Point(280, 60),
                new Point(360, 60)
            };
            g.DrawPolygon(pen, tamGiac);

            Brush br = new SolidBrush(Color.LightGreen);
            g.FillRectangle(br, 20, 170, 120, 50);
        }
    }
}
