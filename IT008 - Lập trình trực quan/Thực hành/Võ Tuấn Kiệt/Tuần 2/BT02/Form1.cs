using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BT02
{
    public partial class mainForm : Form
    {
        public mainForm()
        {
            InitializeComponent();
        }

        private void radioBacNhat_CheckedChanged(object sender, EventArgs e)
        {
            cTextBox.Enabled = !bacNhatRadioButton.Checked;
        }

        private void btnSolve_Click(object sender, EventArgs e)
        {
            if (cTextBox.Enabled) // Giai pt bac 2
            {
                float a = float.Parse(aTextBox.Text);
                float b = float.Parse(bTextBox.Text);
                float c = float.Parse(cTextBox.Text);
                String res = "";
                if (a == 0)
                {
                    res = "Hệ số a không được bằng 0!";
                }
                else
                {
                    float delta = b * b - 4 * a * c;
                    if (delta < 0)
                        res = "Phương trình vô nghiệm";
                    else if (delta == 0)
                        res = $"Phương trình có nghiệm kép x={-b/(2*a)}"; 
                    else
                        res = $"Phương trình có 2 nghiệm x1={(-b + Math.Sqrt(delta))/ (2 * a)} và x2={(-b - Math.Sqrt(delta)) / (2 * a)}";
                }
                resultTextBox.Text = res;
            }
            else // Giai pt bac 1
            {
                float a = float.Parse(aTextBox.Text);
                float b = float.Parse(bTextBox.Text);
                String res = "";
                if (a != 0)
                {
                    res = $"Phương trình có nghiệm {-b / a}";
                }
                else
                {
                    if (b == 0)
                        res = "Phương trình có vô số nghiệm";
                    else
                        res = "Phương trình vô nghiệm";
                }
                resultTextBox.Text = res;
            }
        }

        private void clearButton_Click(object sender, EventArgs e)
        {
            aTextBox.Clear();
            bTextBox.Clear();
            cTextBox.Clear();
            resultTextBox.Clear();
        }

        private void exitButton_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

    }
}
