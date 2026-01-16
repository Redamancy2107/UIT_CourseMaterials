namespace BT24
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
      this.hitNumberLabel = new System.Windows.Forms.Label();
      this.label1 = new System.Windows.Forms.Label();
      this.car1PictureBox = new System.Windows.Forms.PictureBox();
      this.car2PictureBox = new System.Windows.Forms.PictureBox();
      this.groupBox1.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this.car1PictureBox)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.car2PictureBox)).BeginInit();
      this.SuspendLayout();
      // 
      // startButton
      // 
      this.startButton.Location = new System.Drawing.Point(33, 28);
      this.startButton.Name = "startButton";
      this.startButton.Size = new System.Drawing.Size(78, 34);
      this.startButton.TabIndex = 0;
      this.startButton.Text = "Start";
      this.startButton.UseVisualStyleBackColor = true;
      this.startButton.Click += new System.EventHandler(this.startButton_Click);
      // 
      // stopButton
      // 
      this.stopButton.Location = new System.Drawing.Point(33, 73);
      this.stopButton.Name = "stopButton";
      this.stopButton.Size = new System.Drawing.Size(78, 34);
      this.stopButton.TabIndex = 1;
      this.stopButton.Text = "Stop";
      this.stopButton.UseVisualStyleBackColor = true;
      this.stopButton.Click += new System.EventHandler(this.stopButton_Click);
      // 
      // groupBox1
      // 
      this.groupBox1.Controls.Add(this.hitNumberLabel);
      this.groupBox1.Controls.Add(this.label1);
      this.groupBox1.Location = new System.Drawing.Point(126, 25);
      this.groupBox1.Name = "groupBox1";
      this.groupBox1.Size = new System.Drawing.Size(106, 83);
      this.groupBox1.TabIndex = 2;
      this.groupBox1.TabStop = false;
      // 
      // hitNumberLabel
      // 
      this.hitNumberLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.hitNumberLabel.Location = new System.Drawing.Point(12, 46);
      this.hitNumberLabel.Name = "hitNumberLabel";
      this.hitNumberLabel.Size = new System.Drawing.Size(84, 27);
      this.hitNumberLabel.TabIndex = 1;
      this.hitNumberLabel.Text = "0";
      this.hitNumberLabel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      // 
      // label1
      // 
      this.label1.Location = new System.Drawing.Point(32, 15);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(46, 21);
      this.label1.TabIndex = 0;
      this.label1.Text = "Hits";
      this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      // 
      // car1PictureBox
      // 
      this.car1PictureBox.BackColor = System.Drawing.Color.White;
      this.car1PictureBox.Image = global::BT24.Properties.Resources.car;
      this.car1PictureBox.Location = new System.Drawing.Point(33, 259);
      this.car1PictureBox.Name = "car1PictureBox";
      this.car1PictureBox.Size = new System.Drawing.Size(50, 47);
      this.car1PictureBox.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
      this.car1PictureBox.TabIndex = 4;
      this.car1PictureBox.TabStop = false;
      // 
      // car2PictureBox
      // 
      this.car2PictureBox.BackColor = System.Drawing.Color.White;
      this.car2PictureBox.Image = global::BT24.Properties.Resources.car2;
      this.car2PictureBox.Location = new System.Drawing.Point(404, 13);
      this.car2PictureBox.Name = "car2PictureBox";
      this.car2PictureBox.Size = new System.Drawing.Size(45, 47);
      this.car2PictureBox.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
      this.car2PictureBox.TabIndex = 3;
      this.car2PictureBox.TabStop = false;
      // 
      // mainForm
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.BackColor = System.Drawing.Color.White;
      this.ClientSize = new System.Drawing.Size(800, 450);
      this.Controls.Add(this.car1PictureBox);
      this.Controls.Add(this.car2PictureBox);
      this.Controls.Add(this.groupBox1);
      this.Controls.Add(this.stopButton);
      this.Controls.Add(this.startButton);
      this.Name = "mainForm";
      this.Text = "Count Hits";
      this.groupBox1.ResumeLayout(false);
      ((System.ComponentModel.ISupportInitialize)(this.car1PictureBox)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.car2PictureBox)).EndInit();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.Button startButton;
    private System.Windows.Forms.Button stopButton;
    private System.Windows.Forms.GroupBox groupBox1;
    private System.Windows.Forms.Label hitNumberLabel;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.PictureBox car2PictureBox;
    private System.Windows.Forms.PictureBox car1PictureBox;
  }
}

