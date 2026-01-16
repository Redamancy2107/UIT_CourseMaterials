using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp6
{
    public partial class mainForm : Form
    {
        MessageBoxButtons buttonType = MessageBoxButtons.OK;
        MessageBoxIcon icon = MessageBoxIcon.Asterisk;    
        public mainForm()
        {
            InitializeComponent();
        }

        private void typeRadioButton_CheckedChanged(object sender, EventArgs e)
        {
            RadioButton rb = (RadioButton)sender;
            if (rb.Checked)
            {
                if (rb == okRadioButton)
                    buttonType = MessageBoxButtons.OK;
                else if (rb == okCancelRadioButton)
                    buttonType = MessageBoxButtons.OKCancel;
                else if (rb == abortRetryIgnoreRadioButton)
                    buttonType = MessageBoxButtons.AbortRetryIgnore;
                else if (rb == yesNoCancelRadioButton)
                    buttonType = MessageBoxButtons.YesNoCancel;
                else if (rb == yesNoRadioButton)
                    buttonType = MessageBoxButtons.YesNo;
                else if (rb == retryCancelRadioButton)
                    buttonType = MessageBoxButtons.RetryCancel;
            }
        }

        private void iconRadioButton_CheckedChanged(object sender, EventArgs e)
        {
            RadioButton rb = (RadioButton)sender;
            if (rb.Checked)
            {
                if (rb == asterickRadioButton)
                    icon = MessageBoxIcon.Asterisk;
                else if (rb == errorRadioButton)
                    icon = MessageBoxIcon.Error;
                else if (rb == exclamationRadioButton)
                    icon = MessageBoxIcon.Exclamation;
                else if (rb == handRadioButton)
                    icon = MessageBoxIcon.Hand;
                else if (rb == infoRadioButton)
                    icon = MessageBoxIcon.Information;
                else if (rb == questionRadioButton)
                    icon = MessageBoxIcon.Question;
                else if (rb == stopRadioButton)
                    icon = MessageBoxIcon.Stop;
                else if (rb == warningRadioButton)
                    icon = MessageBoxIcon.Warning;
            }
        }

        private void showDialogButton_Click(object sender, EventArgs e)
        {
            MessageBox.Show("This is a custom dialog", "", buttonType, icon);
        }


        private void exitButton_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
