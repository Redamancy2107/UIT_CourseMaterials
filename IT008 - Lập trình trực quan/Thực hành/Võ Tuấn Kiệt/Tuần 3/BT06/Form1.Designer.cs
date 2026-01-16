namespace BT06
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
            this.label1 = new System.Windows.Forms.Label();
            this.payingCarLabel = new System.Windows.Forms.Label();
            this.nopayCarLabel = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.totalCashLabel = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.exitButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(101, 34);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(115, 24);
            this.label1.TabIndex = 0;
            this.label1.Text = "Số xe trả phí";
            // 
            // payingCarLabel
            // 
            this.payingCarLabel.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.payingCarLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.payingCarLabel.ForeColor = System.Drawing.Color.Red;
            this.payingCarLabel.Location = new System.Drawing.Point(222, 34);
            this.payingCarLabel.Name = "payingCarLabel";
            this.payingCarLabel.Size = new System.Drawing.Size(112, 23);
            this.payingCarLabel.TabIndex = 1;
            this.payingCarLabel.Text = "0";
            // 
            // nopayCarLabel
            // 
            this.nopayCarLabel.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.nopayCarLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.nopayCarLabel.ForeColor = System.Drawing.Color.Red;
            this.nopayCarLabel.Location = new System.Drawing.Point(222, 81);
            this.nopayCarLabel.Name = "nopayCarLabel";
            this.nopayCarLabel.Size = new System.Drawing.Size(112, 23);
            this.nopayCarLabel.TabIndex = 3;
            this.nopayCarLabel.Text = "0";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(43, 81);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(173, 24);
            this.label3.TabIndex = 2;
            this.label3.Text = "Số xe không trả phí";
            // 
            // totalCashLabel
            // 
            this.totalCashLabel.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.totalCashLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCashLabel.ForeColor = System.Drawing.Color.Red;
            this.totalCashLabel.Location = new System.Drawing.Point(222, 129);
            this.totalCashLabel.Name = "totalCashLabel";
            this.totalCashLabel.Size = new System.Drawing.Size(112, 23);
            this.totalCashLabel.TabIndex = 5;
            this.totalCashLabel.Text = "0";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(101, 129);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(115, 24);
            this.label5.TabIndex = 4;
            this.label5.Text = "Tổng số tiền";
            // 
            // exitButton
            // 
            this.exitButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.exitButton.Location = new System.Drawing.Point(133, 186);
            this.exitButton.Name = "exitButton";
            this.exitButton.Size = new System.Drawing.Size(106, 40);
            this.exitButton.TabIndex = 6;
            this.exitButton.Text = "Thoát";
            this.exitButton.UseVisualStyleBackColor = true;
            this.exitButton.Click += new System.EventHandler(this.exitButton_Click);
            // 
            // mainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(398, 271);
            this.Controls.Add(this.exitButton);
            this.Controls.Add(this.totalCashLabel);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.nopayCarLabel);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.payingCarLabel);
            this.Controls.Add(this.label1);
            this.KeyPreview = true;
            this.Name = "mainForm";
            this.Text = "Trạm Thu Phí";
            this.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.mainForm_KeyPress);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label payingCarLabel;
        private System.Windows.Forms.Label nopayCarLabel;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label totalCashLabel;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Button exitButton;
    }
}

