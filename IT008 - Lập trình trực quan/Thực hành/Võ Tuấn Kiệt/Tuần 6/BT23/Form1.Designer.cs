namespace BT23
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
      this.groupBox1 = new System.Windows.Forms.GroupBox();
      this.greenLabel = new System.Windows.Forms.Label();
      this.redLabel = new System.Windows.Forms.Label();
      this.carPictureBox = new System.Windows.Forms.PictureBox();
      this.groupBox1.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this.carPictureBox)).BeginInit();
      this.SuspendLayout();
      // 
      // startButton
      // 
      this.startButton.Location = new System.Drawing.Point(35, 28);
      this.startButton.Name = "startButton";
      this.startButton.Size = new System.Drawing.Size(77, 33);
      this.startButton.TabIndex = 0;
      this.startButton.Text = "Start";
      this.startButton.UseVisualStyleBackColor = true;
      this.startButton.Click += new System.EventHandler(this.startButton_Click);
      // 
      // stopButton
      // 
      this.stopButton.Location = new System.Drawing.Point(35, 73);
      this.stopButton.Name = "stopButton";
      this.stopButton.Size = new System.Drawing.Size(77, 33);
      this.stopButton.TabIndex = 1;
      this.stopButton.Text = "Stop";
      this.stopButton.UseVisualStyleBackColor = true;
      this.stopButton.Click += new System.EventHandler(this.stopButton_Click);
      // 
      // groupBox1
      // 
      this.groupBox1.Controls.Add(this.redLabel);
      this.groupBox1.Controls.Add(this.greenLabel);
      this.groupBox1.Location = new System.Drawing.Point(133, 23);
      this.groupBox1.Name = "groupBox1";
      this.groupBox1.Size = new System.Drawing.Size(147, 79);
      this.groupBox1.TabIndex = 2;
      this.groupBox1.TabStop = false;
      // 
      // greenLabel
      // 
      this.greenLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.greenLabel.ForeColor = System.Drawing.Color.White;
      this.greenLabel.Location = new System.Drawing.Point(12, 25);
      this.greenLabel.Name = "greenLabel";
      this.greenLabel.Size = new System.Drawing.Size(49, 40);
      this.greenLabel.TabIndex = 0;
      this.greenLabel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      // 
      // redLabel
      // 
      this.redLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.redLabel.ForeColor = System.Drawing.Color.White;
      this.redLabel.Location = new System.Drawing.Point(82, 25);
      this.redLabel.Name = "redLabel";
      this.redLabel.Size = new System.Drawing.Size(49, 40);
      this.redLabel.TabIndex = 1;
      this.redLabel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      // 
      // carPictureBox
      // 
      this.carPictureBox.BackColor = System.Drawing.Color.White;
      this.carPictureBox.Image = global::BT23.Properties.Resources.car;
      this.carPictureBox.Location = new System.Drawing.Point(21, 338);
      this.carPictureBox.Name = "carPictureBox";
      this.carPictureBox.Size = new System.Drawing.Size(55, 41);
      this.carPictureBox.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
      this.carPictureBox.TabIndex = 3;
      this.carPictureBox.TabStop = false;
      // 
      // mainForm
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.BackColor = System.Drawing.Color.White;
      this.ClientSize = new System.Drawing.Size(800, 450);
      this.Controls.Add(this.carPictureBox);
      this.Controls.Add(this.groupBox1);
      this.Controls.Add(this.stopButton);
      this.Controls.Add(this.startButton);
      this.Name = "mainForm";
      this.Text = "Traffic Lights";
      this.groupBox1.ResumeLayout(false);
      ((System.ComponentModel.ISupportInitialize)(this.carPictureBox)).EndInit();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.Button startButton;
    private System.Windows.Forms.Button stopButton;
    private System.Windows.Forms.GroupBox groupBox1;
    private System.Windows.Forms.Label redLabel;
    private System.Windows.Forms.Label greenLabel;
    private System.Windows.Forms.PictureBox carPictureBox;
  }
}

