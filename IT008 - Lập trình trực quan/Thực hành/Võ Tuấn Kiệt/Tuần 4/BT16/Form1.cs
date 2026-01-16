using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT16
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
            int midX = this.ClientSize.Width / 2;
            int midY = this.ClientSize.Height / 2;

            Pen axisPen = new Pen(Color.Black, 2);
            g.DrawLine(axisPen, 0, midY, this.ClientSize.Width, midY);
            g.DrawLine(axisPen, midX, 0, midX, this.ClientSize.Height);

            // arrow x
            g.DrawLine(axisPen, this.ClientSize.Width - 15, midY - 5, this.ClientSize.Width, midY);
            g.DrawLine(axisPen, this.ClientSize.Width - 15, midY + 5, this.ClientSize.Width, midY);
            // arrow y
            //g.DrawLine(axisPen, midX - 5, 15, midX, 0);
            //g.DrawLine(axisPen, midX + 5, 15, midX, 0);
            g.DrawLine(axisPen, midX - 5, this.ClientSize.Height - 15, midX, this.ClientSize.Height);
            g.DrawLine(axisPen, midX + 5, this.ClientSize.Height - 15, midX, this.ClientSize.Height);

            // tick and label
            for (int i = -5; i <= 5; i++)
            {
                int x = midX + i * 40;
                g.DrawLine(Pens.Gray, x, midY - 4, x, midY + 4);
                if (i != 0)
                    g.DrawString(i.ToString(), this.Font, Brushes.Black, x - 5, midY + 5);

                int y = midY - i * 40;
                g.DrawLine(Pens.Gray, midX - 4, y, midX + 4, y);
                if (i != 0)
                    g.DrawString((-i).ToString(), this.Font, Brushes.Black, midX + 5, y - 7);
            }

            g.DrawString("O", this.Font, Brushes.Red, midX + 3, midY + 3);
        }

        private void mainForm_Resize(object sender, EventArgs e)
        {
            Invalidate();
        }
    }
}
