namespace BT22
{
  partial class mainForm
  {
    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    protected override void Dispose(bool disposing)
    {
      if (disposing && (components != null))
      {
        components.Dispose();
      }
      base.Dispose(disposing);
    }

    #region Windows Form Designer generated code

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
      this.startButton = new System.Windows.Forms.Button();
      this.stopButton = new System.Windows.Forms.Button();
      this.ballPictureBox = new System.Windows.Forms.PictureBox();
      ((System.ComponentModel.ISupportInitialize)(this.ballPictureBox)).BeginInit();
      this.SuspendLayout();
      // 
      // startButton
      // 
      this.startButton.Location = new System.Drawing.Point(23, 26);
      this.startButton.Name = "startButton";
      this.startButton.Size = new System.Drawing.Size(83, 38);
      this.startButton.TabIndex = 0;
      this.startButton.Text = "Start";
      this.startButton.UseVisualStyleBackColor = true;
      this.startButton.Click += new System.EventHandler(this.startButton_Click);
      // 
      // stopButton
      // 
      this.stopButton.Location = new System.Drawing.Point(23, 86);
      this.stopButton.Name = "stopButton";
      this.stopButton.Size = new System.Drawing.Size(82, 39);
      this.stopButton.TabIndex = 1;
      this.stopButton.Text = "Stop";
      this.stopButton.UseVisualStyleBackColor = true;
      this.stopButton.Click += new System.EventHandler(this.stopButton_Click);
      // 
      // ballPictureBox
      // 
      this.ballPictureBox.BackColor = System.Drawing.Color.White;
      this.ballPictureBox.Image = global::BT22.Properties.Resources.ball;
      this.ballPictureBox.Location = new System.Drawing.Point(335, 15);
      this.ballPictureBox.Name = "ballPictureBox";
      this.ballPictureBox.Size = new System.Drawing.Size(49, 48);
      this.ballPictureBox.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
      this.ballPictureBox.TabIndex = 2;
      this.ballPictureBox.TabStop = false;
      // 
      // mainForm
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.BackColor = System.Drawing.Color.White;
      this.ClientSize = new System.Drawing.Size(800, 450);
      this.Controls.Add(this.ballPictureBox);
      this.Controls.Add(this.stopButton);
      this.Controls.Add(this.startButton);
      this.Name = "mainForm";
      this.Text = "Moving Ball - Multithread";
      this.Load += new System.EventHandler(this.mainForm_Load);
      ((System.ComponentModel.ISupportInitialize)(this.ballPictureBox)).EndInit();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.Button startButton;
    private System.Windows.Forms.Button stopButton;
    private System.Windows.Forms.PictureBox ballPictureBox;
  }
}

