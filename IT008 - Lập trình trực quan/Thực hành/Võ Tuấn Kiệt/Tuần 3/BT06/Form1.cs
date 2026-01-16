using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT06
{
    public partial class mainForm : Form
    {
        public mainForm()
        {
            InitializeComponent();
        }

        private void mainForm_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar=='p' || e.KeyChar == 'P')
            {
                payingCarLabel.Text = $"{int.Parse(payingCarLabel.Text) + 1}";
                totalCashLabel.Text = $"{double.Parse(totalCashLabel.Text) + 0.5}";
            }
            else if (e.KeyChar == 'n' || e.KeyChar == 'N')
            {
                nopayCarLabel.Text = $"{int.Parse(nopayCarLabel.Text) + 1}";

            }
        }

        private void exitButton_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
