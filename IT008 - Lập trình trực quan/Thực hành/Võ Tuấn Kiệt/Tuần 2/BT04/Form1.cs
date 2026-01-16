using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT04
{
    public partial class mainForm : Form
    {
        public mainForm()
        {
            InitializeComponent();
        }


        private void boldCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            messageLabel.Font = new Font(messageLabel.Font, messageLabel.Font.Style ^ FontStyle.Bold);
        }

        private void italicCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            messageLabel.Font = new Font(messageLabel.Font, messageLabel.Font.Style ^ FontStyle.Italic);
        }
    }
}
