using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT10
{
    public partial class mainForm : Form
    {
        public mainForm()
        {
            InitializeComponent();
        }

        private void ClearColor()
        {
            blackToolStripMenuItem.Checked = false;
            blueToolStripMenuItem.Checked = false;
            redToolStripMenuItem.Checked = false;
            greenToolStripMenuItem.Checked = false;
        }

        private void ClearFont()
        {
            timesNewRomanToolStripMenuItem.Checked = false;
            courierToolStripMenuItem.Checked = false;
            arialToolStripMenuItem.Checked = false;
        }

        private void menuStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            if (e.Equals(openStripMenuItem))
            {
                MessageBox.Show("Ban da click Open");
            }
        }

        private void openStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Ban da click Open");
        }

        private void pasteToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void blackToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ClearColor();
            blackToolStripMenuItem.Checked = true;
            textLabel.ForeColor = Color.Black;
        }

        private void blueToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ClearColor();
            blueToolStripMenuItem.Checked = true;
            textLabel.ForeColor = Color.Blue;
        }

        private void redToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ClearColor();
            redToolStripMenuItem.Checked = true;
            textLabel.ForeColor = Color.Red;
        }

        private void greenToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ClearColor();
            greenToolStripMenuItem.Checked = true;
            textLabel.ForeColor = Color.Green;
        }

        private void timesNewRomanToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ClearFont();
            timesNewRomanToolStripMenuItem.Checked = true;
            textLabel.Font = new Font("Times New Roman", textLabel.Font.Size, textLabel.Font.Style);
        }

        private void courierToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ClearFont();
            courierToolStripMenuItem.Checked = true;
            textLabel.Font = new Font("Courier", textLabel.Font.Size, textLabel.Font.Style);
        }

        private void arialToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ClearFont();
            arialToolStripMenuItem.Checked = true;
            textLabel.Font = new Font("Arial", textLabel.Font.Size, textLabel.Font.Style);

        }

        private void boldToolStripMenuItem_Click(object sender, EventArgs e)
        {
            boldToolStripMenuItem.Checked = !boldToolStripMenuItem.Checked;
            textLabel.Font = new Font(textLabel.Font, textLabel.Font.Style ^ FontStyle.Bold);
        }

        private void italicToolStripMenuItem_Click(object sender, EventArgs e)
        {
            italicToolStripMenuItem.Checked = !italicToolStripMenuItem.Checked;
            textLabel.Font = new Font(textLabel.Font, textLabel.Font.Style ^ FontStyle.Italic);

        }
    }
}
