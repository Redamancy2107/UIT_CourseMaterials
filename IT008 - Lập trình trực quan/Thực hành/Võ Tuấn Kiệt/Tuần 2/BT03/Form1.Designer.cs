namespace WindowsFormsApp6
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.retryCancelRadioButton = new System.Windows.Forms.RadioButton();
            this.yesNoRadioButton = new System.Windows.Forms.RadioButton();
            this.yesNoCancelRadioButton = new System.Windows.Forms.RadioButton();
            this.abortRetryIgnoreRadioButton = new System.Windows.Forms.RadioButton();
            this.okCancelRadioButton = new System.Windows.Forms.RadioButton();
            this.okRadioButton = new System.Windows.Forms.RadioButton();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.warningRadioButton = new System.Windows.Forms.RadioButton();
            this.stopRadioButton = new System.Windows.Forms.RadioButton();
            this.questionRadioButton = new System.Windows.Forms.RadioButton();
            this.infoRadioButton = new System.Windows.Forms.RadioButton();
            this.exclamationRadioButton = new System.Windows.Forms.RadioButton();
            this.handRadioButton = new System.Windows.Forms.RadioButton();
            this.errorRadioButton = new System.Windows.Forms.RadioButton();
            this.asterickRadioButton = new System.Windows.Forms.RadioButton();
            this.showDialogButton = new System.Windows.Forms.Button();
            this.exitButton = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.retryCancelRadioButton);
            this.groupBox1.Controls.Add(this.yesNoRadioButton);
            this.groupBox1.Controls.Add(this.yesNoCancelRadioButton);
            this.groupBox1.Controls.Add(this.abortRetryIgnoreRadioButton);
            this.groupBox1.Controls.Add(this.okCancelRadioButton);
            this.groupBox1.Controls.Add(this.okRadioButton);
            this.groupBox1.Location = new System.Drawing.Point(32, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(161, 177);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Button Type";
            // 
            // retryCancelRadioButton
            // 
            this.retryCancelRadioButton.AutoSize = true;
            this.retryCancelRadioButton.Location = new System.Drawing.Point(6, 139);
            this.retryCancelRadioButton.Name = "retryCancelRadioButton";
            this.retryCancelRadioButton.Size = new System.Drawing.Size(83, 17);
            this.retryCancelRadioButton.TabIndex = 5;
            this.retryCancelRadioButton.TabStop = true;
            this.retryCancelRadioButton.Text = "RetryCancel";
            this.retryCancelRadioButton.UseVisualStyleBackColor = true;
            this.retryCancelRadioButton.CheckedChanged += new System.EventHandler(this.typeRadioButton_CheckedChanged);
            // 
            // yesNoRadioButton
            // 
            this.yesNoRadioButton.AutoSize = true;
            this.yesNoRadioButton.Location = new System.Drawing.Point(6, 116);
            this.yesNoRadioButton.Name = "yesNoRadioButton";
            this.yesNoRadioButton.Size = new System.Drawing.Size(57, 17);
            this.yesNoRadioButton.TabIndex = 4;
            this.yesNoRadioButton.TabStop = true;
            this.yesNoRadioButton.Text = "YesNo";
            this.yesNoRadioButton.UseVisualStyleBackColor = true;
            this.yesNoRadioButton.CheckedChanged += new System.EventHandler(this.typeRadioButton_CheckedChanged);
            // 
            // yesNoCancelRadioButton
            // 
            this.yesNoCancelRadioButton.AutoSize = true;
            this.yesNoCancelRadioButton.Location = new System.Drawing.Point(6, 93);
            this.yesNoCancelRadioButton.Name = "yesNoCancelRadioButton";
            this.yesNoCancelRadioButton.Size = new System.Drawing.Size(90, 17);
            this.yesNoCancelRadioButton.TabIndex = 3;
            this.yesNoCancelRadioButton.TabStop = true;
            this.yesNoCancelRadioButton.Text = "YesNoCancel";
            this.yesNoCancelRadioButton.UseVisualStyleBackColor = true;
            this.yesNoCancelRadioButton.CheckedChanged += new System.EventHandler(this.typeRadioButton_CheckedChanged);
            // 
            // abortRetryIgnoreRadioButton
            // 
            this.abortRetryIgnoreRadioButton.AutoSize = true;
            this.abortRetryIgnoreRadioButton.Location = new System.Drawing.Point(6, 70);
            this.abortRetryIgnoreRadioButton.Name = "abortRetryIgnoreRadioButton";
            this.abortRetryIgnoreRadioButton.Size = new System.Drawing.Size(105, 17);
            this.abortRetryIgnoreRadioButton.TabIndex = 2;
            this.abortRetryIgnoreRadioButton.TabStop = true;
            this.abortRetryIgnoreRadioButton.Text = "AbortRetryIgnore";
            this.abortRetryIgnoreRadioButton.UseVisualStyleBackColor = true;
            this.abortRetryIgnoreRadioButton.CheckedChanged += new System.EventHandler(this.typeRadioButton_CheckedChanged);
            // 
            // okCancelRadioButton
            // 
            this.okCancelRadioButton.AutoSize = true;
            this.okCancelRadioButton.Location = new System.Drawing.Point(6, 47);
            this.okCancelRadioButton.Name = "okCancelRadioButton";
            this.okCancelRadioButton.Size = new System.Drawing.Size(73, 17);
            this.okCancelRadioButton.TabIndex = 1;
            this.okCancelRadioButton.TabStop = true;
            this.okCancelRadioButton.Text = "OKCancel";
            this.okCancelRadioButton.UseVisualStyleBackColor = true;
            this.okCancelRadioButton.CheckedChanged += new System.EventHandler(this.typeRadioButton_CheckedChanged);
            // 
            // okRadioButton
            // 
            this.okRadioButton.AutoSize = true;
            this.okRadioButton.Checked = true;
            this.okRadioButton.Location = new System.Drawing.Point(6, 24);
            this.okRadioButton.Name = "okRadioButton";
            this.okRadioButton.Size = new System.Drawing.Size(40, 17);
            this.okRadioButton.TabIndex = 0;
            this.okRadioButton.TabStop = true;
            this.okRadioButton.Text = "OK";
            this.okRadioButton.UseVisualStyleBackColor = true;
            this.okRadioButton.CheckedChanged += new System.EventHandler(this.typeRadioButton_CheckedChanged);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.warningRadioButton);
            this.groupBox2.Controls.Add(this.stopRadioButton);
            this.groupBox2.Controls.Add(this.questionRadioButton);
            this.groupBox2.Controls.Add(this.infoRadioButton);
            this.groupBox2.Controls.Add(this.exclamationRadioButton);
            this.groupBox2.Controls.Add(this.handRadioButton);
            this.groupBox2.Controls.Add(this.errorRadioButton);
            this.groupBox2.Controls.Add(this.asterickRadioButton);
            this.groupBox2.Location = new System.Drawing.Point(212, 12);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(135, 268);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Icon";
            // 
            // warningRadioButton
            // 
            this.warningRadioButton.AutoSize = true;
            this.warningRadioButton.Location = new System.Drawing.Point(6, 183);
            this.warningRadioButton.Name = "warningRadioButton";
            this.warningRadioButton.Size = new System.Drawing.Size(65, 17);
            this.warningRadioButton.TabIndex = 7;
            this.warningRadioButton.TabStop = true;
            this.warningRadioButton.Text = "Warning";
            this.warningRadioButton.UseVisualStyleBackColor = true;
            this.warningRadioButton.CheckedChanged += new System.EventHandler(this.iconRadioButton_CheckedChanged);
            // 
            // stopRadioButton
            // 
            this.stopRadioButton.AutoSize = true;
            this.stopRadioButton.Location = new System.Drawing.Point(6, 160);
            this.stopRadioButton.Name = "stopRadioButton";
            this.stopRadioButton.Size = new System.Drawing.Size(47, 17);
            this.stopRadioButton.TabIndex = 6;
            this.stopRadioButton.TabStop = true;
            this.stopRadioButton.Text = "Stop";
            this.stopRadioButton.UseVisualStyleBackColor = true;
            this.stopRadioButton.CheckedChanged += new System.EventHandler(this.iconRadioButton_CheckedChanged);
            // 
            // questionRadioButton
            // 
            this.questionRadioButton.AutoSize = true;
            this.questionRadioButton.Location = new System.Drawing.Point(6, 137);
            this.questionRadioButton.Name = "questionRadioButton";
            this.questionRadioButton.Size = new System.Drawing.Size(67, 17);
            this.questionRadioButton.TabIndex = 5;
            this.questionRadioButton.TabStop = true;
            this.questionRadioButton.Text = "Question";
            this.questionRadioButton.UseVisualStyleBackColor = true;
            this.questionRadioButton.CheckedChanged += new System.EventHandler(this.iconRadioButton_CheckedChanged);
            // 
            // infoRadioButton
            // 
            this.infoRadioButton.AutoSize = true;
            this.infoRadioButton.Location = new System.Drawing.Point(6, 114);
            this.infoRadioButton.Name = "infoRadioButton";
            this.infoRadioButton.Size = new System.Drawing.Size(77, 17);
            this.infoRadioButton.TabIndex = 4;
            this.infoRadioButton.TabStop = true;
            this.infoRadioButton.Text = "Information";
            this.infoRadioButton.UseVisualStyleBackColor = true;
            this.infoRadioButton.CheckedChanged += new System.EventHandler(this.iconRadioButton_CheckedChanged);
            // 
            // exclamationRadioButton
            // 
            this.exclamationRadioButton.AutoSize = true;
            this.exclamationRadioButton.Location = new System.Drawing.Point(6, 68);
            this.exclamationRadioButton.Name = "exclamationRadioButton";
            this.exclamationRadioButton.Size = new System.Drawing.Size(82, 17);
            this.exclamationRadioButton.TabIndex = 3;
            this.exclamationRadioButton.TabStop = true;
            this.exclamationRadioButton.Text = "Exclamation";
            this.exclamationRadioButton.UseVisualStyleBackColor = true;
            this.exclamationRadioButton.CheckedChanged += new System.EventHandler(this.iconRadioButton_CheckedChanged);
            // 
            // handRadioButton
            // 
            this.handRadioButton.AutoSize = true;
            this.handRadioButton.Location = new System.Drawing.Point(6, 91);
            this.handRadioButton.Name = "handRadioButton";
            this.handRadioButton.Size = new System.Drawing.Size(51, 17);
            this.handRadioButton.TabIndex = 2;
            this.handRadioButton.TabStop = true;
            this.handRadioButton.Text = "Hand";
            this.handRadioButton.UseVisualStyleBackColor = true;
            this.handRadioButton.CheckedChanged += new System.EventHandler(this.iconRadioButton_CheckedChanged);
            // 
            // errorRadioButton
            // 
            this.errorRadioButton.AutoSize = true;
            this.errorRadioButton.Location = new System.Drawing.Point(6, 45);
            this.errorRadioButton.Name = "errorRadioButton";
            this.errorRadioButton.Size = new System.Drawing.Size(47, 17);
            this.errorRadioButton.TabIndex = 1;
            this.errorRadioButton.TabStop = true;
            this.errorRadioButton.Text = "Error";
            this.errorRadioButton.UseVisualStyleBackColor = true;
            this.errorRadioButton.CheckedChanged += new System.EventHandler(this.iconRadioButton_CheckedChanged);
            // 
            // asterickRadioButton
            // 
            this.asterickRadioButton.AutoSize = true;
            this.asterickRadioButton.Checked = true;
            this.asterickRadioButton.Location = new System.Drawing.Point(6, 22);
            this.asterickRadioButton.Name = "asterickRadioButton";
            this.asterickRadioButton.Size = new System.Drawing.Size(62, 17);
            this.asterickRadioButton.TabIndex = 0;
            this.asterickRadioButton.TabStop = true;
            this.asterickRadioButton.Text = "Asterisk";
            this.asterickRadioButton.UseVisualStyleBackColor = true;
            this.asterickRadioButton.CheckedChanged += new System.EventHandler(this.iconRadioButton_CheckedChanged);
            // 
            // showDialogButton
            // 
            this.showDialogButton.Location = new System.Drawing.Point(32, 196);
            this.showDialogButton.Name = "showDialogButton";
            this.showDialogButton.Size = new System.Drawing.Size(161, 39);
            this.showDialogButton.TabIndex = 2;
            this.showDialogButton.Text = "Show Dialog";
            this.showDialogButton.UseVisualStyleBackColor = true;
            this.showDialogButton.Click += new System.EventHandler(this.showDialogButton_Click);
            // 
            // exitButton
            // 
            this.exitButton.Location = new System.Drawing.Point(32, 241);
            this.exitButton.Name = "exitButton";
            this.exitButton.Size = new System.Drawing.Size(161, 39);
            this.exitButton.TabIndex = 3;
            this.exitButton.Text = "Exit";
            this.exitButton.UseVisualStyleBackColor = true;
            this.exitButton.Click += new System.EventHandler(this.exitButton_Click);
            // 
            // mainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(387, 303);
            this.Controls.Add(this.exitButton);
            this.Controls.Add(this.showDialogButton);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Name = "mainForm";
            this.Text = "Radio Button";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.RadioButton retryCancelRadioButton;
        private System.Windows.Forms.RadioButton yesNoRadioButton;
        private System.Windows.Forms.RadioButton yesNoCancelRadioButton;
        private System.Windows.Forms.RadioButton abortRetryIgnoreRadioButton;
        private System.Windows.Forms.RadioButton okCancelRadioButton;
        private System.Windows.Forms.RadioButton okRadioButton;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.RadioButton warningRadioButton;
        private System.Windows.Forms.RadioButton stopRadioButton;
        private System.Windows.Forms.RadioButton questionRadioButton;
        private System.Windows.Forms.RadioButton infoRadioButton;
        private System.Windows.Forms.RadioButton exclamationRadioButton;
        private System.Windows.Forms.RadioButton handRadioButton;
        private System.Windows.Forms.RadioButton errorRadioButton;
        private System.Windows.Forms.RadioButton asterickRadioButton;
        private System.Windows.Forms.Button showDialogButton;
        private System.Windows.Forms.Button exitButton;
    }
}

